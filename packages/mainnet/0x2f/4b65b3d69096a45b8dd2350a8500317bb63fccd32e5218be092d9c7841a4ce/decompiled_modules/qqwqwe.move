module 0x2f4b65b3d69096a45b8dd2350a8500317bb63fccd32e5218be092d9c7841a4ce::qqwqwe {
    struct QQWQWE has drop {
        dummy_field: bool,
    }

    fun init(arg0: QQWQWE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QQWQWE>(arg0, 6, b"qqwqwe", b"sdsad", b"sacdsadssads", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pub-efea87dea3f94e8084e073588c980c50.r2.dev/logo/01JFMDJYV2541BE0EWS6EW03YY/01JFMDKA8ZTX7DW76HW8FTMJYY")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QQWQWE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<QQWQWE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

