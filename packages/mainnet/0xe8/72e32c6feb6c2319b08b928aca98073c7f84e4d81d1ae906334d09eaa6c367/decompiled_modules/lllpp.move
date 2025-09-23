module 0xe872e32c6feb6c2319b08b928aca98073c7f84e4d81d1ae906334d09eaa6c367::lllpp {
    struct LLLPP has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<LLLPP>, arg1: 0x2::coin::Coin<LLLPP>) {
        0x2::coin::burn<LLLPP>(arg0, arg1);
    }

    public(friend) fun mint(arg0: &mut 0x2::coin::TreasuryCap<LLLPP>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<LLLPP> {
        0x2::coin::mint<LLLPP>(arg0, arg1, arg2)
    }

    fun init(arg0: LLLPP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LLLPP>(arg0, 6, b"LLLPP", b"ppll", b"Template Coin Description", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://surgeai.s3.ap-southeast-1.amazonaws.com/1758609416531VbOG.png"))), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LLLPP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LLLPP>>(v1);
    }

    public fun mint_max_supply(arg0: &mut 0x2::coin::TreasuryCap<LLLPP>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<LLLPP> {
        assert!(0x2::coin::total_supply<LLLPP>(arg0) + 10000000000 <= 10000000000, 0);
        0x2::coin::mint<LLLPP>(arg0, 10000000000, arg1)
    }

    // decompiled from Move bytecode v6
}

