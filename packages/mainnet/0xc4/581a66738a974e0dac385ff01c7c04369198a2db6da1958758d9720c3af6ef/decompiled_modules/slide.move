module 0xc4581a66738a974e0dac385ff01c7c04369198a2db6da1958758d9720c3af6ef::slide {
    struct SLIDE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLIDE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLIDE>(arg0, 6, b"Slide", b"Zenguins", b"Emperor of titan on multiverse 420000000001", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/9_C6_C86_B4_2_F11_40_B7_AADA_8_D974_FA_1_FC_4_F_d84cbc71b5.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLIDE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SLIDE>>(v1);
    }

    // decompiled from Move bytecode v6
}

