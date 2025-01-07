module 0xbc7e2b9814565dee2485b582838abebe46e755e0863315a1535779ff02873feb::ccc1 {
    struct CCC1 has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<CCC1>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<CCC1>>(0x2::coin::mint<CCC1>(arg0, arg1, arg3), arg2);
    }

    public fun add_addr_from_deny_list(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<CCC1>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<CCC1>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: CCC1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<CCC1>(arg0, 6, b"ccc1", b"ccc1", b"323", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"3"))), false, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CCC1>>(v2);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<CCC1>>(v1, 0x2::tx_context::sender(arg1));
        let v3 = v0;
        0x2::coin::mint_and_transfer<CCC1>(&mut v3, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CCC1>>(v3, 0x2::tx_context::sender(arg1));
    }

    public fun remove_addr_from_deny_list(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<CCC1>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<CCC1>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

