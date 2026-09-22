module 0xfc482f77bf3b75f78d82028a63139fa71339ded8cea73a0f49e252cdc027083b::math3_mainnet {
    struct Math3Mainnet has drop {
        dummy_field: bool,
    }

    public fun init_for_test() : Math3Mainnet {
        Math3Mainnet{dummy_field: false}
    }

    // decompiled from Move bytecode v7
}

