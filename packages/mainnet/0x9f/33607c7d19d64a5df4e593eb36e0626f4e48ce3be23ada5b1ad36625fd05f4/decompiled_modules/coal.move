module 0x9f33607c7d19d64a5df4e593eb36e0626f4e48ce3be23ada5b1ad36625fd05f4::coal {
    struct COAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: COAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<COAL>(arg0, 0, 0x1::string::utf8(b"COAL"), 0x1::string::utf8(b"Coal"), 0x1::string::utf8(x"436f616c20e2809420616e2049646c65205469646573207265736f757263652e204465706f73697420696e2067616d6520746f207573652069742e"), 0x1::string::utf8(b"https://raw.githubusercontent.com/Neuradite-Games/assets/main/idle-tides/items/4.png"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COAL>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<COAL>>(0x2::coin_registry::finalize<COAL>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

