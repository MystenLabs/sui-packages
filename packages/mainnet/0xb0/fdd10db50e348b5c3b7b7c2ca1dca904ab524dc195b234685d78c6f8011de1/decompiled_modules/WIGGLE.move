module 0xb0fdd10db50e348b5c3b7b7c2ca1dca904ab524dc195b234685d78c6f8011de1::WIGGLE {
    struct WIGGLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WIGGLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WIGGLE>(arg0, 6, b"Wiggle Worm", b"WIGGLE", b"The ultimate meme coin for the animated worm community! $WIGGLE brings the fun and frenzy of wriggly worms to the crypto world. Whether you're into garden worms, gummy worms, or just love the wiggle life, this coin is for you. Join the movement and let your investments wiggle to the moon!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://w3s.link/ipfs/bafkreigx5gg27whnzplj4v5pzk5txh2oyrdfhm7g5ucsch4pmwlxmuqj44")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WIGGLE>>(v0, @0x2be6c850562754e11af55b7f049f4e304e488dff630b3832874d80c837c458a8);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WIGGLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

