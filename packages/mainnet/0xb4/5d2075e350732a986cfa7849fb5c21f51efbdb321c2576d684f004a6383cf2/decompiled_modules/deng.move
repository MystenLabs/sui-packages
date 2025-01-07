module 0xb45d2075e350732a986cfa7849fb5c21f51efbdb321c2576d684f004a6383cf2::deng {
    struct DENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DENG>(arg0, 6, b"DENG", b"PIXEL DENG DENG", b"With 1 SUI and a whole bunch of Pixel Deng Deng, you can ride a rocket straight to Mars ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GY_2_C_Tm_Bb_AAA_cd_F_c53614013c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

