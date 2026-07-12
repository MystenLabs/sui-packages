module 0x9f33607c7d19d64a5df4e593eb36e0626f4e48ce3be23ada5b1ad36625fd05f4::fishing_bait {
    struct FISHING_BAIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: FISHING_BAIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<FISHING_BAIT>(arg0, 0, 0x1::string::utf8(b"FISHINGBAIT"), 0x1::string::utf8(b"Fishing Bait"), 0x1::string::utf8(x"46697368696e67204261697420e2809420616e2049646c65205469646573207265736f757263652e204465706f73697420696e2067616d6520746f207573652069742e"), 0x1::string::utf8(b"https://raw.githubusercontent.com/Neuradite-Games/assets/main/idle-tides/items/200.png"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FISHING_BAIT>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<FISHING_BAIT>>(0x2::coin_registry::finalize<FISHING_BAIT>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

