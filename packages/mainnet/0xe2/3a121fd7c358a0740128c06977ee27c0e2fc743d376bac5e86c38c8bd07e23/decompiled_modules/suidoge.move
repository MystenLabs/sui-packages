module 0xe23a121fd7c358a0740128c06977ee27c0e2fc743d376bac5e86c38c8bd07e23::suidoge {
    struct SUIDOGE has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUIDOGE>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SUIDOGE>>(0x2::coin::mint<SUIDOGE>(arg0, arg2 * 1000000000, arg3), arg1);
    }

    public entry fun addToDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<SUIDOGE>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<SUIDOGE>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: SUIDOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<SUIDOGE>(arg0, 9, b"SuiDoge", b"SuiDoge", x"f09f9fa3205265616c204d656d65636f696e204f662054686520596561722120f09f9fa320436f6d706c6574656c7920636f6d6d756e6974792064726976656e20f09f9fa3", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<SUIDOGE>(&mut v3, 3000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIDOGE>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDOGE>>(v3, @0x0);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<SUIDOGE>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun removeFromDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<SUIDOGE>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<SUIDOGE>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

