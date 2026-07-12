module 0x9f33607c7d19d64a5df4e593eb36e0626f4e48ce3be23ada5b1ad36625fd05f4::gull_feather {
    struct GULL_FEATHER has drop {
        dummy_field: bool,
    }

    fun init(arg0: GULL_FEATHER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<GULL_FEATHER>(arg0, 0, 0x1::string::utf8(b"GULLFEATHER"), 0x1::string::utf8(b"Gull Feather"), 0x1::string::utf8(x"47756c6c204665617468657220e2809420616e2049646c65205469646573207265736f757263652e204465706f73697420696e2067616d6520746f207573652069742e"), 0x1::string::utf8(b"https://raw.githubusercontent.com/Neuradite-Games/assets/main/idle-tides/items/303.png"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GULL_FEATHER>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<GULL_FEATHER>>(0x2::coin_registry::finalize<GULL_FEATHER>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

