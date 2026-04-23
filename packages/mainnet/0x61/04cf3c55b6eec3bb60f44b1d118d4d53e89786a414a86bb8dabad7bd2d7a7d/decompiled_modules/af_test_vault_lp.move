module 0x6104cf3c55b6eec3bb60f44b1d118d4d53e89786a414a86bb8dabad7bd2d7a7d::af_test_vault_lp {
    struct AF_TEST_VAULT_LP has drop {
        dummy_field: bool,
    }

    fun init(arg0: AF_TEST_VAULT_LP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AF_TEST_VAULT_LP>(arg0, 9, b"afTVLP", b"AF Test Vault LP", b"Aftermath test vault LP for assistant cap testing", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aftermath.finance")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AF_TEST_VAULT_LP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AF_TEST_VAULT_LP>>(v1);
    }

    // decompiled from Move bytecode v7
}

