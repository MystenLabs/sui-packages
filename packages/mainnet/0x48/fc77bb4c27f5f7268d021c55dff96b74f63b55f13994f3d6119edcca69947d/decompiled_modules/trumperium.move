module 0x48fc77bb4c27f5f7268d021c55dff96b74f63b55f13994f3d6119edcca69947d::trumperium {
    struct TRUMPERIUM has drop {
        dummy_field: bool,
    }

    public entry fun addToDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<TRUMPERIUM>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<TRUMPERIUM>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: TRUMPERIUM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<TRUMPERIUM>(arg0, 9, b"TRUMPERIUM", b"TRUMPERIUM", b"TRUMPERIUM", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<TRUMPERIUM>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRUMPERIUM>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPERIUM>>(v3, @0x0);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<TRUMPERIUM>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun removeFromDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<TRUMPERIUM>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<TRUMPERIUM>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

