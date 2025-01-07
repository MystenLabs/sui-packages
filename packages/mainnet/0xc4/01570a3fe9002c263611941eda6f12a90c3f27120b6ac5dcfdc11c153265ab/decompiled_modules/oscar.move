module 0xc401570a3fe9002c263611941eda6f12a90c3f27120b6ac5dcfdc11c153265ab::oscar {
    struct OSCAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: OSCAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OSCAR>(arg0, 6, b"OSCAR", b"First Oscar On Sui", b"First Oscar On Sui ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_1_9_20a49e44c8.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OSCAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OSCAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

