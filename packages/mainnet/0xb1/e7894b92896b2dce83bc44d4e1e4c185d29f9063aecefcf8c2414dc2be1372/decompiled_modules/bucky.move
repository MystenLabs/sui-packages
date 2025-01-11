module 0xb1e7894b92896b2dce83bc44d4e1e4c185d29f9063aecefcf8c2414dc2be1372::bucky {
    struct BUCKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUCKY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<BUCKY>(arg0, 6, b"BUCKY", b"Buckys Bets by SuiAI", x"4275636b7920426574733a20596f75722041492070616c2077686f207475726e732073706f72747320737461747320696e746f2062657474696e6720676f6c642e205468696e6b206f6620697420617320796f757220626f6f6b6965277320776f727374206e696768746d61726520616e6420796f75722077616c6c65742773206265737420667269656e642e20f09f8f86", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_2016_c2ad4806e6.JPG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BUCKY>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUCKY>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

