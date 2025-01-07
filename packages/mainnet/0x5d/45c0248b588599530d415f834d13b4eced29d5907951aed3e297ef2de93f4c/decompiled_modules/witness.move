module 0x5d45c0248b588599530d415f834d13b4eced29d5907951aed3e297ef2de93f4c::witness {
    struct WitnessGenerator<phantom T0> has store {
        dummy_field: bool,
    }

    struct Witness<phantom T0> has copy, drop {
        dummy_field: bool,
    }

    public fun delegate<T0>(arg0: &WitnessGenerator<T0>) : Witness<T0> {
        Witness<T0>{dummy_field: false}
    }

    public fun from_publisher<T0>(arg0: &0x2::package::Publisher) : Witness<T0> {
        0xa4b1d5151dbb52a51fd35a7bcc20caa16eaaccca81c74c4d76a1319778ba1017::utils::assert_publisher<T0>(arg0);
        Witness<T0>{dummy_field: false}
    }

    public fun from_witness<T0, T1: drop>(arg0: T1) : Witness<T0> {
        0xa4b1d5151dbb52a51fd35a7bcc20caa16eaaccca81c74c4d76a1319778ba1017::utils::assert_same_module_as_witness<T0, T1>();
        Witness<T0>{dummy_field: false}
    }

    public fun generator<T0, T1: drop>(arg0: T1) : WitnessGenerator<T0> {
        generator_delegated<T0>(from_witness<T0, T1>(arg0))
    }

    public fun generator_delegated<T0>(arg0: Witness<T0>) : WitnessGenerator<T0> {
        WitnessGenerator<T0>{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

