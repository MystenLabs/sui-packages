module 0x7757618c0e00b360a83e3c75dc67665e1f7578c213788054e151889869dca6bc::bububububu {
    struct BUBUBUBUBU has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUBUBUBUBU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUBUBUBUBU>(arg0, 6, b"Bububububu", b"BUBUBUBU", b"https://www.bubububbububububububububububu.com/", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/AD_6_F18_E6_FE_2_D_4_AD_9_B3_D9_1_B8428_B46_F91_9ec5f7ea3d.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUBUBUBUBU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUBUBUBUBU>>(v1);
    }

    // decompiled from Move bytecode v6
}

