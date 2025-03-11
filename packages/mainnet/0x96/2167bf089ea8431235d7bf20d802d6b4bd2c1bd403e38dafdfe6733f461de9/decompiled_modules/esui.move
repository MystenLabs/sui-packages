module 0x962167bf089ea8431235d7bf20d802d6b4bd2c1bd403e38dafdfe6733f461de9::esui {
    struct ESUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ESUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ESUI>(arg0, 9, b"ESUI", b"ESUI", b"ESUI Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://res.cloudinary.com/nfttokenasa/image/upload/v1741696033/xcbh6uc45zco9efdsgsp.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ESUI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ESUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ESUI>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

