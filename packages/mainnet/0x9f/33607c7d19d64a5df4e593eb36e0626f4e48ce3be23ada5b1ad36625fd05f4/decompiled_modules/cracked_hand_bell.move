module 0x9f33607c7d19d64a5df4e593eb36e0626f4e48ce3be23ada5b1ad36625fd05f4::cracked_hand_bell {
    struct CRACKED_HAND_BELL has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRACKED_HAND_BELL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<CRACKED_HAND_BELL>(arg0, 0, 0x1::string::utf8(b"CRACKEDHANDB"), 0x1::string::utf8(b"Cracked Hand Bell"), 0x1::string::utf8(x"437261636b65642048616e642042656c6c20e2809420616e2049646c65205469646573207265736f757263652e204465706f73697420696e2067616d6520746f207573652069742e"), 0x1::string::utf8(b"https://raw.githubusercontent.com/Neuradite-Games/assets/main/idle-tides/items/314.png"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRACKED_HAND_BELL>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<CRACKED_HAND_BELL>>(0x2::coin_registry::finalize<CRACKED_HAND_BELL>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

