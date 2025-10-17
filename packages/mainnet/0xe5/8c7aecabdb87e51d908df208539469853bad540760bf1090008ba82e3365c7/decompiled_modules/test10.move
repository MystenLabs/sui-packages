module 0xe58c7aecabdb87e51d908df208539469853bad540760bf1090008ba82e3365c7::test10 {
    struct TEST10 has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<TEST10>, arg1: 0x2::coin::Coin<TEST10>) {
        0x2::coin::burn<TEST10>(arg0, arg1);
    }

    public(friend) fun mint(arg0: &mut 0x2::coin::TreasuryCap<TEST10>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<TEST10> {
        0x2::coin::mint<TEST10>(arg0, arg1, arg2)
    }

    fun init(arg0: TEST10, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEST10>(arg0, 6, b"TEST10", b"Test10", b"Template Coin Description", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://surgeai.s3.ap-southeast-1.amazonaws.com/1760681380844mCWY.jpeg"))), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST10>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TEST10>>(v1);
    }

    public fun mint_max_supply(arg0: &mut 0x2::coin::TreasuryCap<TEST10>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<TEST10> {
        assert!(0x2::coin::total_supply<TEST10>(arg0) + 10000000000 <= 10000000000, 0);
        0x2::coin::mint<TEST10>(arg0, 10000000000, arg1)
    }

    // decompiled from Move bytecode v6
}

