module 0x52b266b31e8529aa0c23844028bc46bb802d8f50b2b1ee25435cd29836403911::yyy {
    struct YYY has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<YYY>, arg1: 0x2::coin::Coin<YYY>) {
        0x2::coin::burn<YYY>(arg0, arg1);
    }

    public(friend) fun mint(arg0: &mut 0x2::coin::TreasuryCap<YYY>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<YYY> {
        0x2::coin::mint<YYY>(arg0, arg1, arg2)
    }

    fun init(arg0: YYY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YYY>(arg0, 6, b"YYY", b"TT", b"Template Coin Description", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://surgeai.s3.ap-southeast-1.amazonaws.com/1762099809866CNHb.png"))), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YYY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YYY>>(v1);
    }

    public fun mint_max_supply(arg0: &mut 0x2::coin::TreasuryCap<YYY>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<YYY> {
        assert!(0x2::coin::total_supply<YYY>(arg0) + 10000000000 <= 10000000000, 0);
        0x2::coin::mint<YYY>(arg0, 10000000000, arg1)
    }

    // decompiled from Move bytecode v6
}

