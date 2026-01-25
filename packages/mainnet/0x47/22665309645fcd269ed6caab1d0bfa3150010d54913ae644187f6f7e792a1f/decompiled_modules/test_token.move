module 0x4722665309645fcd269ed6caab1d0bfa3150010d54913ae644187f6f7e792a1f::test_token {
    struct TEST_TOKEN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<TEST_TOKEN>, arg1: 0x2::coin::Coin<TEST_TOKEN>) {
        0x2::coin::burn<TEST_TOKEN>(arg0, arg1);
    }

    fun init(arg0: TEST_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEST_TOKEN>(arg0, 9, b"TFLOW", b"Test Inflow Token", b"Testing wallet inflow display patterns", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://example.com/token.png"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TEST_TOKEN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST_TOKEN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint_and_transfer(arg0: &mut 0x2::coin::TreasuryCap<TEST_TOKEN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<TEST_TOKEN>>(0x2::coin::mint<TEST_TOKEN>(arg0, arg1, arg3), arg2);
    }

    public fun mint_return(arg0: &mut 0x2::coin::TreasuryCap<TEST_TOKEN>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<TEST_TOKEN> {
        0x2::coin::mint<TEST_TOKEN>(arg0, arg1, arg2)
    }

    public fun mint_two_step(arg0: &mut 0x2::coin::TreasuryCap<TEST_TOKEN>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<TEST_TOKEN> {
        0x2::coin::mint<TEST_TOKEN>(arg0, arg1, arg2)
    }

    public fun mint_via_split(arg0: &mut 0x2::coin::TreasuryCap<TEST_TOKEN>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<TEST_TOKEN> {
        0x2::coin::mint<TEST_TOKEN>(arg0, arg1, arg2)
    }

    public fun mint_with_transfer(arg0: &mut 0x2::coin::TreasuryCap<TEST_TOKEN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<TEST_TOKEN>>(0x2::coin::mint<TEST_TOKEN>(arg0, arg1, arg3), arg2);
    }

    // decompiled from Move bytecode v6
}

