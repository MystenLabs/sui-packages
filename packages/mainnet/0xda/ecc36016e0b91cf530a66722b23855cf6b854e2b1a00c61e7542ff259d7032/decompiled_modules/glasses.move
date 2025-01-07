module 0xdaecc36016e0b91cf530a66722b23855cf6b854e2b1a00c61e7542ff259d7032::glasses {
    struct GLASSES has drop {
        dummy_field: bool,
    }

    fun init(arg0: GLASSES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GLASSES>(arg0, 6, b"Glasses", b"ElonWifGlasses", b"The Glasses Stay On", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/86_A8_AF_45_3_BBF_4_D22_A7_E2_9959395_A829_E_9c8db3637f.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GLASSES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GLASSES>>(v1);
    }

    // decompiled from Move bytecode v6
}

