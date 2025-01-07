module 0xed234e898a16f895354b7fe7b7d7b80be518fa0e17a791e314b289d9760cf4ea::wmsui {
    struct WMSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: WMSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WMSUI>(arg0, 6, b"WMSUI", b"Waterman", x"496d2061205355497065726865726f2c0a6e6f742061205355497065726465762e204265207761746572204d462e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000039719_6f6ec73d52.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WMSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WMSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

