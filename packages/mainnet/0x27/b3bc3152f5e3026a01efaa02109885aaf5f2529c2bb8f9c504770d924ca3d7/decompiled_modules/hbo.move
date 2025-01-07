module 0x27b3bc3152f5e3026a01efaa02109885aaf5f2529c2bb8f9c504770d924ca3d7::hbo {
    struct HBO has drop {
        dummy_field: bool,
    }

    fun init(arg0: HBO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HBO>(arg0, 6, b"HBO", b"Hidden Bitcoin Origins", b"On October 8th, HBO will show the world who is Satoshi Nakamoto.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/hbo_black_d1f844f54c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HBO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HBO>>(v1);
    }

    // decompiled from Move bytecode v6
}

