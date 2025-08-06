module 0x4e17c8fb5ccbaead8c30ca5f91735cb621484653e07c1007e231e82a197d9e8c::test_coin {
    struct TEST_COIN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<TEST_COIN>, arg1: 0x2::coin::Coin<TEST_COIN>) {
        0x2::coin::burn<TEST_COIN>(arg0, arg1);
    }

    public(friend) fun mint(arg0: &mut 0x2::coin::TreasuryCap<TEST_COIN>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<TEST_COIN> {
        0x2::coin::mint<TEST_COIN>(arg0, arg1, arg2)
    }

    fun init(arg0: TEST_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEST_COIN>(arg0, 6, b"OOOO", b"OVO", b"Template Coin Description", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"ddd"))), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST_COIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TEST_COIN>>(v1);
    }

    public fun mint_max_supply(arg0: &mut 0x2::coin::TreasuryCap<TEST_COIN>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<TEST_COIN> {
        assert!(0x2::coin::total_supply<TEST_COIN>(arg0) + 1000000000 <= 1000000000, 0);
        0x2::coin::mint<TEST_COIN>(arg0, 1000000000, arg1)
    }

    // decompiled from Move bytecode v6
}

