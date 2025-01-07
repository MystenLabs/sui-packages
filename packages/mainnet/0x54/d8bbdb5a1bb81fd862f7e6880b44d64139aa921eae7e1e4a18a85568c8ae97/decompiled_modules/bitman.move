module 0x54d8bbdb5a1bb81fd862f7e6880b44d64139aa921eae7e1e4a18a85568c8ae97::bitman {
    struct BITMAN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<BITMAN>, arg1: vector<0x2::coin::Coin<BITMAN>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<BITMAN>>(&mut arg1);
        0x2::pay::join_vec<BITMAN>(&mut v0, arg1);
        0x2::coin::burn<BITMAN>(arg0, 0x2::coin::split<BITMAN>(&mut v0, arg2, arg3));
        if (0x2::coin::value<BITMAN>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<BITMAN>>(v0, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<BITMAN>(v0);
        };
    }

    fun init(arg0: BITMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v1, 0x2::url::new_unsafe_from_bytes(b""));
        let (v2, v3) = 0x2::coin::create_currency<BITMAN>(arg0, 7, b"BTN", b"BITMAN", b"", v1, arg1);
        let v4 = v2;
        0x2::coin::mint_and_transfer<BITMAN>(&mut v4, 8000000, v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BITMAN>>(v4, v0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BITMAN>>(v3);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<BITMAN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<BITMAN>(arg0, arg1, arg2, arg3);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<BITMAN>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<BITMAN>>(arg0);
    }

    // decompiled from Move bytecode v6
}

