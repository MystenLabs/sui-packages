module 0x2fe56716f09abb7e0016b438ab1ef840bd4cad0ca83e3f833fc6a60a90f278c5::yy {
    struct YY has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<YY>, arg1: 0x2::coin::Coin<YY>) {
        0x2::coin::burn<YY>(arg0, arg1);
    }

    public(friend) fun mint(arg0: &mut 0x2::coin::TreasuryCap<YY>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<YY> {
        0x2::coin::mint<YY>(arg0, arg1, arg2)
    }

    fun init(arg0: YY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YY>(arg0, 6, b"YY", b"ii", b"Template Coin Description", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"hee"))), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YY>>(v1);
    }

    public fun mint_max_supply(arg0: &mut 0x2::coin::TreasuryCap<YY>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<YY> {
        assert!(0x2::coin::total_supply<YY>(arg0) + 10000000000 <= 10000000000, 0);
        0x2::coin::mint<YY>(arg0, 10000000000, arg1)
    }

    // decompiled from Move bytecode v6
}

