module 0x8b8c16ebeb9a7c87153abc86eae72bf86cfad3dcd6492b6d9c6df4f8518f745c::c13 {
    struct C13 has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<C13>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<C13>>(0x2::coin::mint<C13>(arg0, arg1, arg3), arg2);
    }

    public fun add_addr_from_deny_list(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<C13>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<C13>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: C13, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<C13>(arg0, 6, b"c13", b"c13", b"1", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"1"))), false, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<C13>>(v2);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<C13>>(v1, 0x2::tx_context::sender(arg1));
        let v3 = v0;
        0x2::coin::mint_and_transfer<C13>(&mut v3, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<C13>>(v3, 0x2::tx_context::sender(arg1));
    }

    public fun remove_addr_from_deny_list(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<C13>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<C13>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

