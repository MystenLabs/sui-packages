module 0x64ee9904d0646bacff0707a77b9eb96ae965edb27b8045c1c37c717704df7273::suimoon {
    struct SUIMOON has drop {
        dummy_field: bool,
    }

    public fun add_addr_from_deny_list(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<SUIMOON>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<SUIMOON>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: SUIMOON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<SUIMOON>(arg0, 6, b"SuiMoon", b"SuiMoon", b"To the moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://d391b93f5f62d9c15f67142e43841acc.ipfscdn.io/ipfs/QmfPZ2HnvFxBKq4AohuSu2Eqk1AptiyAfU2b959iSbrWDZ")), false, arg1);
        let v3 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIMOON>>(v2);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<SUIMOON>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<SUIMOON>>(0x2::coin::mint<SUIMOON>(&mut v3, 210000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SUIMOON>>(v3);
    }

    public fun remove_addr_from_deny_list(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<SUIMOON>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<SUIMOON>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

