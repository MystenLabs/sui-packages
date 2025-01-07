module 0x26cbb755b18fa49b5be4833c3066a662a6d2923cc05fbeb01676ea1e22b71a84::dojobrett {
    struct DOJOBRETT has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOJOBRETT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOJOBRETT>(arg0, 6, b"DOJOBRETT", b"DOJO BRETT", b"Brett is the biggest meme on Base, has arrived at Dojo!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_17_21_53_41_1abca037d3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOJOBRETT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOJOBRETT>>(v1);
    }

    // decompiled from Move bytecode v6
}

