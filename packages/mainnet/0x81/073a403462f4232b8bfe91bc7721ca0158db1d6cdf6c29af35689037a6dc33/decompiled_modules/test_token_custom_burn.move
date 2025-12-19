module 0x81073a403462f4232b8bfe91bc7721ca0158db1d6cdf6c29af35689037a6dc33::test_token_custom_burn {
    struct TEST_TOKEN_CUSTOM_BURN has drop {
        dummy_field: bool,
    }

    struct ProtectedTreasury has key {
        id: 0x2::object::UID,
    }

    struct TreasuryCapKey has copy, drop, store {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut ProtectedTreasury, arg1: 0x2::coin::Coin<TEST_TOKEN_CUSTOM_BURN>) {
        let v0 = TreasuryCapKey{dummy_field: false};
        0x2::coin::burn<TEST_TOKEN_CUSTOM_BURN>(0x2::dynamic_object_field::borrow_mut<TreasuryCapKey, 0x2::coin::TreasuryCap<TEST_TOKEN_CUSTOM_BURN>>(&mut arg0.id, v0), arg1);
    }

    fun init(arg0: TEST_TOKEN_CUSTOM_BURN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEST_TOKEN_CUSTOM_BURN>(arg0, 9, b"CUSTOM", b"Custom Burn Token", b"Token with custom burn logic like WAL/DEEP", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TEST_TOKEN_CUSTOM_BURN>>(v1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<TEST_TOKEN_CUSTOM_BURN>>(0x2::coin::mint<TEST_TOKEN_CUSTOM_BURN>(&mut v2, 1000000000, arg1), 0x2::tx_context::sender(arg1));
        let v3 = ProtectedTreasury{id: 0x2::object::new(arg1)};
        let v4 = TreasuryCapKey{dummy_field: false};
        0x2::dynamic_object_field::add<TreasuryCapKey, 0x2::coin::TreasuryCap<TEST_TOKEN_CUSTOM_BURN>>(&mut v3.id, v4, v2);
        0x2::transfer::share_object<ProtectedTreasury>(v3);
    }

    // decompiled from Move bytecode v6
}

