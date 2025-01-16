module 0x1ed15c431b620bb0e8bb6cb45c6e7a23b71566ae5a545d1bd4321758d0685131::btsn {
    struct BTSN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BTSN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<BTSN>(arg0, 6, b"BTSN", b"BitSense by SuiAI", x"5265616c2d74696d652063727970746f63757272656e6379206e6577732026206d61726b657420696e74656c6c6967656e63652e20427265616b696e6720757064617465732c2065787065727420616e616c797369732c20616e6420626c6f636b636861696e20696e7369676874732e20547275737465642062792063727970746f2074726164657273202620696e766573746f727320776f726c64776964652e202ef09f8c902068747470733a2f2f62697473656e73652e6e657773", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/logo_e87839df26.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BTSN>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BTSN>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

