module 0xa716c9090f9209aea60924c09c94fe0269fe213515b076bf46d8fe1b7d6b765a::vault {
    struct TestVault has copy, drop, store {
        dummy_field: bool,
    }

    public fun new_test_vault_type() : TestVault {
        TestVault{dummy_field: false}
    }

    // decompiled from Move bytecode v7
}

