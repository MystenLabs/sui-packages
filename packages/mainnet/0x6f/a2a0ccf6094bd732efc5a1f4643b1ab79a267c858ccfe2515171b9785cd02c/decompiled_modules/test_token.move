module 0x6fa2a0ccf6094bd732efc5a1f4643b1ab79a267c858ccfe2515171b9785cd02c::test_token {
    struct TEST_TOKEN has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<TEST_TOKEN>, arg1: 0x2::coin::Coin<TEST_TOKEN>) {
        0x2::coin::burn<TEST_TOKEN>(arg0, arg1);
    }

    fun init(arg0: TEST_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEST_TOKEN>(arg0, 9, b"TST", b"TEST", b"TEST token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://freepngimg.com/thumb/coin/66672-coin-transparent-gold-icon-free-photo-png.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TEST_TOKEN>>(v1);
        0x2::coin::mint_and_transfer<TEST_TOKEN>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST_TOKEN>>(v2, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<TEST_TOKEN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<TEST_TOKEN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

