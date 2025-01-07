module 0xbe4667db091d477ad62ba7079f2d2d7cc350b372b06e5e1b5824f64cd06afe66::babyneiro {
    struct BABYNEIRO has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<BABYNEIRO>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<BABYNEIRO>>(0x2::coin::mint<BABYNEIRO>(arg0, arg2 * 1000000000, arg3), arg1);
    }

    public entry fun addToDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<BABYNEIRO>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<BABYNEIRO>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: BABYNEIRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<BABYNEIRO>(arg0, 9, b"BabyNeiro", b"BabyNeiro", b"The best meme son of the famouse token Neiro", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<BABYNEIRO>(&mut v3, 3000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BABYNEIRO>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYNEIRO>>(v3, @0x0);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<BABYNEIRO>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun removeFromDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<BABYNEIRO>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<BABYNEIRO>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

