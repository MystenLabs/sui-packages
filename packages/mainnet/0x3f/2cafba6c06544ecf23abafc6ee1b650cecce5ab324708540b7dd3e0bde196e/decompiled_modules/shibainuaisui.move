module 0x3f2cafba6c06544ecf23abafc6ee1b650cecce5ab324708540b7dd3e0bde196e::shibainuaisui {
    struct SHIBAINUAISUI has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<SHIBAINUAISUI>, arg1: vector<0x2::coin::Coin<SHIBAINUAISUI>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<SHIBAINUAISUI>>(&mut arg1);
        0x2::pay::join_vec<SHIBAINUAISUI>(&mut v0, arg1);
        0x2::coin::burn<SHIBAINUAISUI>(arg0, 0x2::coin::split<SHIBAINUAISUI>(&mut v0, arg2, arg3));
        if (0x2::coin::value<SHIBAINUAISUI>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<SHIBAINUAISUI>>(v0, 0x2::tx_context::sender(arg3));
        } else {
            0x2::coin::destroy_zero<SHIBAINUAISUI>(v0);
        };
    }

    fun init(arg0: SHIBAINUAISUI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SHIBAINUAISUI>(arg0, 9, b"SHIBSUI", b"SHIBAINUAISUI", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v3 = v1;
        0x2::coin::mint_and_transfer<SHIBAINUAISUI>(&mut v3, 100000000000000000, v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHIBAINUAISUI>>(v3, v0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHIBAINUAISUI>>(v2);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SHIBAINUAISUI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SHIBAINUAISUI>(arg0, arg1, arg2, arg3);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<SHIBAINUAISUI>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SHIBAINUAISUI>>(arg0);
    }

    // decompiled from Move bytecode v6
}

