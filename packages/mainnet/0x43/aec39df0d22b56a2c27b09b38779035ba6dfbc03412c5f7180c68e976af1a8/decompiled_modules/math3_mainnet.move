module 0x43aec39df0d22b56a2c27b09b38779035ba6dfbc03412c5f7180c68e976af1a8::math3_mainnet {
    struct Math3Mainnet has drop {
        dummy_field: bool,
    }

    public fun init_for_test() : Math3Mainnet {
        Math3Mainnet{dummy_field: false}
    }

    // decompiled from Move bytecode v7
}

