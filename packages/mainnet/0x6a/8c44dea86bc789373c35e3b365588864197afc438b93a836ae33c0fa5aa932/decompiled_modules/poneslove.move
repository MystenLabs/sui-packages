module 0x6a8c44dea86bc789373c35e3b365588864197afc438b93a836ae33c0fa5aa932::poneslove {
    struct PONESLOVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PONESLOVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PONESLOVE>(arg0, 6, b"PONESLOVE", b"SUI PONESLOVE", b"Welcome to true \"Poneslove\", a place for love between unicorns.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmeo_Yxn8_D1kfn_Wjyze_Sr_Nwe_Nn6_H2_Z8v9_VE_Sod_Mvzzq3_Hqv_222e990712.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PONESLOVE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PONESLOVE>>(v1);
    }

    // decompiled from Move bytecode v6
}

