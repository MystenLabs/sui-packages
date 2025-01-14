module 0xcb35503aa8bb0bd9c9cb4ef07db22275398302d6bb5540621d2a67428aecaef9::bba {
    struct BBA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<BBA>(arg0, 6, b"BBA", b"BlackBox - AI by SuiAI", x"456e68616e636520796f75722074726164696e67206465636973696f6e73207769746820616476616e6365642041492d64726976656e20616e616c7973697320616e64207265616c2d74696d652070726564696374696f6e732e20f09f9a80f09f9388", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/bb_logo_f72d2b9001.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BBA>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBA>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

