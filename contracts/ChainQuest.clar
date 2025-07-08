(define-trait sip009-nft-trait
  (
    ;; minimal SIP-009 NFT interface
    (get-token-uri (uint) (response (optional (string-utf8 256)) uint))
    (get-owner (uint) (response (optional principal) uint))
    (transfer (uint principal principal) (response bool uint))
  )
)

(define-non-fungible-token character-nft uint)

(define-data-var next-id uint u1)

(define-map character-stats
  {id: uint}
  {
    owner: principal,
    level: uint,
    xp: uint,
    strength: uint,
    agility: uint,
    intelligence: uint
  }
)

(define-public (mint-character)
  (let 
    ((id (var-get next-id)))
    (ok (begin
      (var-set next-id (+ id u1))
      (map-insert character-stats
        {id: id}
        {
          owner: tx-sender,
          level: u1,
          xp: u0,
          strength: u5,
          agility: u5,
          intelligence: u5
        }
      )
      (nft-mint? character-nft id tx-sender)
    ))
  )
)

(define-public (train-character (id uint))
  (let ((char (map-get? character-stats {id: id})))
    (match char
      entry (begin
          (asserts! (is-eq tx-sender (get owner entry)) (err u403))
          (map-set character-stats
            {id: id}
            (merge entry { strength: (+ (get strength entry) u1), xp: (+ (get xp entry) u10) })
          )
          (ok true)
        )
      (err u404)
    )
  )
)

(define-public (level-up (id uint))
  (let (
    (char (map-get? character-stats {id: id})))
    (match char 
      entry (begin
        (asserts! (is-owner id tx-sender) (err u403))
        (if (>= (get xp entry) u100)
          (begin
            (map-set character-stats
              {id: id}
              (merge entry { xp: (- (get xp entry) u100), level: (+ (get level entry) u1) })
            )
            (ok true)
          )
          (err u402)
        )
      )
      (err u404)
    )
  )
)

(define-private (is-owner (id uint) (address principal))
  (match (nft-get-owner? character-nft id)
    owner (is-eq address owner)
    false
  )
)
