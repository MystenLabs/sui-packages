module 0x2159e640e546f4214c5effa15d0c328c43bd52a25f84fad72fbd964f957cc923::candy {
    struct CANDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CANDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CANDY>(arg0, 6, b"CANDY", b"SuiCandy", b"The Sweet World of the SUI Blockchain is Coming!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_12_01_18_49_55_ad901aee8c.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CANDY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CANDY>>(v1);
    }

    // decompiled from Move bytecode v6
}

