module 0x9f33607c7d19d64a5df4e593eb36e0626f4e48ce3be23ada5b1ad36625fd05f4::fire {
    struct FIRE has drop {
        dummy_field: bool,
    }

    fun init(arg0: FIRE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<FIRE>(arg0, 0, 0x1::string::utf8(b"FIRE"), 0x1::string::utf8(b"Fire"), 0x1::string::utf8(x"4669726520e2809420616e2049646c65205469646573207265736f757263652e204465706f73697420696e2067616d6520746f207573652069742e"), 0x1::string::utf8(b"https://raw.githubusercontent.com/Neuradite-Games/assets/main/idle-tides/items/110.png"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FIRE>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<FIRE>>(0x2::coin_registry::finalize<FIRE>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

