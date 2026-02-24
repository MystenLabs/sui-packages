module 0xfb6b4840a14474660b0ec1bea5e8c9d29abff9681d5c173cc518a5ab6d2c3f48::test_vault_currency {
    struct TEST_VAULT_CURRENCY has drop {
        dummy_field: bool,
    }

    public fun finalize_registration(arg0: &mut 0x2::coin_registry::CoinRegistry, arg1: 0x2::transfer::Receiving<0x2::coin_registry::Currency<TEST_VAULT_CURRENCY>>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin_registry::finalize_registration<TEST_VAULT_CURRENCY>(arg0, arg1, arg2);
    }

    fun init(arg0: TEST_VAULT_CURRENCY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<TEST_VAULT_CURRENCY>(arg0, 9, 0x1::string::utf8(b"TVC"), 0x1::string::utf8(b"Test Vault Currency"), 0x1::string::utf8(b"Test currency for vault with all extensions"), 0x1::string::utf8(b"https://example.com/icon.png"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST_VAULT_CURRENCY>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<TEST_VAULT_CURRENCY>>(0x2::coin_registry::finalize<TEST_VAULT_CURRENCY>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

