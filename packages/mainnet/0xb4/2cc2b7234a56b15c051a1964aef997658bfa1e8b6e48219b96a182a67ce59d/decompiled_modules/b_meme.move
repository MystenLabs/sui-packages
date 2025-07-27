module 0xb42cc2b7234a56b15c051a1964aef997658bfa1e8b6e48219b96a182a67ce59d::b_meme {
    struct B_MEME has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_MEME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_MEME>(arg0, 9, b"bMEME", b"bToken MEME", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_MEME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_MEME>>(v1);
    }

    // decompiled from Move bytecode v6
}

