module 0xf2bb923fd7ff2dde7e232ea4fb5510b2bcd7083294c30b916ed7e87bf02cfb8b::pump {
    struct PUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<PUMP>(arg0, 9, b"TEST", b"test", b"A Sui community token launched with one click.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://sui.io/favicon.ico")), true, arg1);
        let v3 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<PUMP>>(0x2::coin::mint<PUMP>(&mut v3, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PUMP>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<PUMP>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUMP>>(v3, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint_more(arg0: &mut 0x2::coin::TreasuryCap<PUMP>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PUMP>>(0x2::coin::mint<PUMP>(arg0, arg1, arg3), arg2);
    }

    public entry fun pause_address(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<PUMP>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<PUMP>(arg0, arg1, arg2, arg3);
    }

    public entry fun pause_all(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<PUMP>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_enable_global_pause<PUMP>(arg0, arg1, arg2);
    }

    public entry fun resume_address(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<PUMP>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<PUMP>(arg0, arg1, arg2, arg3);
    }

    public entry fun resume_all(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<PUMP>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_disable_global_pause<PUMP>(arg0, arg1, arg2);
    }

    public entry fun revoke_all(arg0: 0x2::coin::TreasuryCap<PUMP>, arg1: 0x2::coin::CoinMetadata<PUMP>, arg2: 0x2::coin::DenyCapV2<PUMP>) {
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUMP>>(arg0, @0x0);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PUMP>>(arg1, @0x0);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<PUMP>>(arg2, @0x0);
    }

    // decompiled from Move bytecode v7
}

