module 0x9f33607c7d19d64a5df4e593eb36e0626f4e48ce3be23ada5b1ad36625fd05f4::iron_ingot {
    struct IRON_INGOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: IRON_INGOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<IRON_INGOT>(arg0, 0, 0x1::string::utf8(b"IRONINGOT"), 0x1::string::utf8(b"Iron Ingot"), 0x1::string::utf8(x"49726f6e20496e676f7420e2809420616e2049646c65205469646573207265736f757263652e204465706f73697420696e2067616d6520746f207573652069742e"), 0x1::string::utf8(b"https://raw.githubusercontent.com/Neuradite-Games/assets/main/idle-tides/items/101.png"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IRON_INGOT>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<IRON_INGOT>>(0x2::coin_registry::finalize<IRON_INGOT>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

