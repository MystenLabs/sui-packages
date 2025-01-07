module 0x3330dd667876ef9947b3f80b92e0e16f80103f5d90ccc7a5351a9077ede4edc5::suimson {
    struct SUIMSON has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMSON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMSON>(arg0, 6, b"Suimson", b"Sui Simpson", b"Sui Simpson is helping you farm lp on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/S_Ti_D_APR_400x400_fd6dffdf11.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMSON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMSON>>(v1);
    }

    // decompiled from Move bytecode v6
}

