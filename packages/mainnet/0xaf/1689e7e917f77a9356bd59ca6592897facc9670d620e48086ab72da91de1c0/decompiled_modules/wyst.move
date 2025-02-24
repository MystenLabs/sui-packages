module 0xaf1689e7e917f77a9356bd59ca6592897facc9670d620e48086ab72da91de1c0::wyst {
    struct WYST has drop {
        dummy_field: bool,
    }

    fun init(arg0: WYST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<WYST>(arg0, 1, b"WYST", b"Demo Wyoming stable token", b"Demon of a token wit compliance features", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://en.wikipedia.org/wiki/Bucking_Horse_and_Rider#/media/File:Bucking_Horse_and_Rider_logo.png")), true, arg1);
        let v3 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<WYST>>(0x2::coin::mint<WYST>(&mut v3, 10000, arg1), @0xe498af88b9e1670f579734607264d2325ecc57768fab757106ebf5db82e1faea);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WYST>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<WYST>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WYST>>(v2);
    }

    // decompiled from Move bytecode v6
}

