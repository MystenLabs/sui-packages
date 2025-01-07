module 0x9d9d505e643ddb269de1cee21844ebb3112171eb1c7932960c6c7e3d9b94629::suitea {
    struct SUITEA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITEA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITEA>(arg0, 9, b"SUITEA", b"SuiTeaTims", b"Welcome to the SuiTea", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://x.com/BirdandBlendTea?t=klda_I2MIYcBZz0YJBuksw&s=09")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUITEA>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITEA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITEA>>(v1);
    }

    // decompiled from Move bytecode v6
}

