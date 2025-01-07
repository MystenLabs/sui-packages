module 0x5e3a17634fc436d69900dd49d07c445cb02816e6566d253cef385c1f046e94d0::suishiba {
    struct SUISHIBA has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SUISHIBA>, arg1: vector<0x2::coin::Coin<SUISHIBA>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<SUISHIBA>>(&mut arg1);
        0x2::pay::join_vec<SUISHIBA>(&mut v0, arg1);
        0x2::coin::burn<SUISHIBA>(arg0, 0x2::coin::split<SUISHIBA>(&mut v0, arg2, arg3));
        if (0x2::coin::value<SUISHIBA>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<SUISHIBA>>(v0, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<SUISHIBA>(v0);
        };
    }

    fun init(arg0: SUISHIBA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v1, 0x2::url::new_unsafe_from_bytes(b""));
        let (v2, v3) = 0x2::coin::create_currency<SUISHIBA>(arg0, 7, b"SUISHIB", b"SUISHIBA", b"", v1, arg1);
        let v4 = v2;
        0x2::coin::mint_and_transfer<SUISHIBA>(&mut v4, 1000000000000000000, v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISHIBA>>(v4, v0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISHIBA>>(v3);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUISHIBA>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUISHIBA>(arg0, arg1, arg2, arg3);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<SUISHIBA>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SUISHIBA>>(arg0);
    }

    // decompiled from Move bytecode v6
}

