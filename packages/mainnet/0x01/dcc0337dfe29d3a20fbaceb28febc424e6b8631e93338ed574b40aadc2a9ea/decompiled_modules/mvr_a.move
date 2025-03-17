module 0xc168b8766e69c07b1b5ed194e3dc2b4a2a0e328ae6a06a2cae40e2ec83a3f94f::mvr_a {
    struct MvrA<phantom T0> has drop {
        dummy_field: bool,
    }

    struct V1 has drop {
        dummy_field: bool,
    }

    public fun new(arg0: V1) : MvrA<V1> {
        MvrA<V1>{dummy_field: false}
    }

    public fun new_v1() : V1 {
        V1{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

