module 0x4898f2b2d2d9a4b2f184e384e1a5c9a56c7b4a43ff46ce3d913e24ee6d4d0810::b_trench {
    struct B_TRENCH has drop {
        dummy_field: bool,
    }

    fun init(arg0: B_TRENCH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<B_TRENCH>(arg0, 9, b"bTRENCH", b"bToken TRENCH", b"STEAMM bToken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d29k09wtkr1a3e.cloudfront.net/steamm/STEAMM+bToken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<B_TRENCH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<B_TRENCH>>(v1);
    }

    // decompiled from Move bytecode v6
}

