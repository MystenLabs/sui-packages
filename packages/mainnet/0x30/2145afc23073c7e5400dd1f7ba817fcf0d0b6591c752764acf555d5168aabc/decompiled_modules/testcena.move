module 0x302145afc23073c7e5400dd1f7ba817fcf0d0b6591c752764acf555d5168aabc::testcena {
    struct TESTCENA has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESTCENA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESTCENA>(arg0, 6, b"TESTCENA", b"test", b"dont buy this shiii", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Gbze_V_OWIA_0_Dte1_73c4baa324.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTCENA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TESTCENA>>(v1);
    }

    // decompiled from Move bytecode v6
}

