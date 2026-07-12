module 0x9f33607c7d19d64a5df4e593eb36e0626f4e48ce3be23ada5b1ad36625fd05f4::harpy_talon {
    struct HARPY_TALON has drop {
        dummy_field: bool,
    }

    fun init(arg0: HARPY_TALON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<HARPY_TALON>(arg0, 0, 0x1::string::utf8(b"HARPYTALON"), 0x1::string::utf8(b"Harpy Talon"), 0x1::string::utf8(x"48617270792054616c6f6e20e2809420616e2049646c65205469646573207265736f757263652e204465706f73697420696e2067616d6520746f207573652069742e"), 0x1::string::utf8(b"https://raw.githubusercontent.com/Neuradite-Games/assets/main/idle-tides/items/306.png"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HARPY_TALON>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<HARPY_TALON>>(0x2::coin_registry::finalize<HARPY_TALON>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

