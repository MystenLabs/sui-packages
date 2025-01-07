module 0xa6a8ea5922d57dcc7800972079dc2058aa1aa113bca721c4535cb0418f35555::hccapital {
    struct HCCAPITAL has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<HCCAPITAL>, arg1: vector<0x2::coin::Coin<HCCAPITAL>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<HCCAPITAL>>(&mut arg1);
        0x2::pay::join_vec<HCCAPITAL>(&mut v0, arg1);
        0x2::coin::burn<HCCAPITAL>(arg0, 0x2::coin::split<HCCAPITAL>(&mut v0, arg2, arg3));
        if (0x2::coin::value<HCCAPITAL>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<HCCAPITAL>>(v0, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<HCCAPITAL>(v0);
        };
    }

    fun init(arg0: HCCAPITAL, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<HCCAPITAL>(arg0, 7, b"HC", b"HCCAPITAL", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v3 = v1;
        0x2::coin::mint_and_transfer<HCCAPITAL>(&mut v3, 10000000000000, v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HCCAPITAL>>(v3, v0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HCCAPITAL>>(v2);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<HCCAPITAL>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<HCCAPITAL>(arg0, arg1, arg2, arg3);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<HCCAPITAL>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<HCCAPITAL>>(arg0);
    }

    // decompiled from Move bytecode v6
}

