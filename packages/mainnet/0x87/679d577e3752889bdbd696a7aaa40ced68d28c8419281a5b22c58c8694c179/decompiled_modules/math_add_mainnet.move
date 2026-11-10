module 0x87679d577e3752889bdbd696a7aaa40ced68d28c8419281a5b22c58c8694c179::math_add_mainnet {
    struct MathAddMainnet has drop {
        dummy_field: bool,
    }

    public fun init_for_test() : MathAddMainnet {
        MathAddMainnet{dummy_field: false}
    }

    // decompiled from Move bytecode v7
}

