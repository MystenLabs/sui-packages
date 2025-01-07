module 0xecc8ce683f3a2d7a093836b5b418fed620fc8acb6decfb2164e11f0db9e0523c::bgme {
    struct BGME has drop {
        dummy_field: bool,
    }

    fun init(arg0: BGME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BGME>(arg0, 6, b"BGME", b"Baby GameStop", b"Relaunched on Baby Gamestop", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1735010220_922264_AD_81_D761_9_B23_441_E_8_E5_F_F9_B4_B68326_E0_ba0d284b11.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BGME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BGME>>(v1);
    }

    // decompiled from Move bytecode v6
}

