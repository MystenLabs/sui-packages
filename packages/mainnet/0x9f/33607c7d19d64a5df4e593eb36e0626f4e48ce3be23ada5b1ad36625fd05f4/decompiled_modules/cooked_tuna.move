module 0x9f33607c7d19d64a5df4e593eb36e0626f4e48ce3be23ada5b1ad36625fd05f4::cooked_tuna {
    struct COOKED_TUNA has drop {
        dummy_field: bool,
    }

    fun init(arg0: COOKED_TUNA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<COOKED_TUNA>(arg0, 0, 0x1::string::utf8(b"COOKEDTUNA"), 0x1::string::utf8(b"Cooked Tuna"), 0x1::string::utf8(x"436f6f6b65642054756e6120e2809420616e2049646c65205469646573207265736f757263652e204465706f73697420696e2067616d6520746f207573652069742e"), 0x1::string::utf8(b"https://raw.githubusercontent.com/Neuradite-Games/assets/main/idle-tides/items/127.png"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COOKED_TUNA>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<COOKED_TUNA>>(0x2::coin_registry::finalize<COOKED_TUNA>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

