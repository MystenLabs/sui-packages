module 0x1a1fa63c67b5b6d54a3d16671c20f3ba45d5c3ddb74aa3111bf7985d131c1798::ptrump {
    struct PTRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: PTRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PTRUMP>(arg0, 6, b"PTRUMP", b"Saint Pope TRUMP", b"Trump as Pope memecoin.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1746302659876.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PTRUMP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PTRUMP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

