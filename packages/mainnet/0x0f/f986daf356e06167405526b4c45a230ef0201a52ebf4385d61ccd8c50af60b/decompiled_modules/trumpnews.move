module 0xff986daf356e06167405526b4c45a230ef0201a52ebf4385d61ccd8c50af60b::trumpnews {
    struct TRUMPNEWS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPNEWS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<TRUMPNEWS>(arg0, 6, b"TRUMPNEWS", b"Trump News by SuiAI", b"Follows all news related to President Donald Trump ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_5750_13e41d73e2.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TRUMPNEWS>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPNEWS>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

