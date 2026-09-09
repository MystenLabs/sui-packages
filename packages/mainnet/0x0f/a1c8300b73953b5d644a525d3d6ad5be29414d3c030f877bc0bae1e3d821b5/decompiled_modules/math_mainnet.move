module 0xfa1c8300b73953b5d644a525d3d6ad5be29414d3c030f877bc0bae1e3d821b5::math_mainnet {
    struct MathMainnet has drop {
        dummy_field: bool,
    }

    public fun init_for_test() : MathMainnet {
        MathMainnet{dummy_field: false}
    }

    // decompiled from Move bytecode v7
}

