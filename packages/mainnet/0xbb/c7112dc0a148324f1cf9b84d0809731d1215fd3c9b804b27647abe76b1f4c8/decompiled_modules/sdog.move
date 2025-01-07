module 0xbbc7112dc0a148324f1cf9b84d0809731d1215fd3c9b804b27647abe76b1f4c8::sdog {
    struct SDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDOG>(arg0, 6, b"SDOG", b"SuiDog", b"SuiDoge is the first Dog of Sui. Same like SunDog, BinanceDog this is SuiDog!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0_B78_E104_90_D5_42_EC_BB_8_D_CBCAF_6_CAF_8_B2_2673d9b7e3.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

