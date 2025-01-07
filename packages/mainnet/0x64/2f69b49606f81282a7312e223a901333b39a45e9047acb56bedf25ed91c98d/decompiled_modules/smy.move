module 0x642f69b49606f81282a7312e223a901333b39a45e9047acb56bedf25ed91c98d::smy {
    struct SMY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMY>(arg0, 6, b"SMY", b"Smuiley", b"Smuiley is already an extremely popular emoji. Now it's also a popular memecoin. Universal", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/B1_F66995_590_A_4_FFC_B6_FA_3_CC_39_EAE_16_C9_c4bf9e8075.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMY>>(v1);
    }

    // decompiled from Move bytecode v6
}

