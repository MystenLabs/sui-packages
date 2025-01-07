module 0x9e94250eb6f968393066cdb7dabf51596a04912e1e33a14d92c7fc232cbff028::typhoon {
    struct TYPHOON has drop {
        dummy_field: bool,
    }

    fun init(arg0: TYPHOON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TYPHOON>(arg0, 6, b"TYPHOON", b"Typhoon Hippo", x"54686520626967676573742028616e64206375746573742920747970686f6f6e2069732061626f757420746f20686974205375692053706163652e20200a200a53746f726d207369676e616c2039393920547970686f6f6e20486970706f206973206e6f77206865726520746f2072656b74206861766f632077697468206974732061646f7261626c652077696e64732020", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_6064413601009090120_y_ed0ac28546.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TYPHOON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TYPHOON>>(v1);
    }

    // decompiled from Move bytecode v6
}

