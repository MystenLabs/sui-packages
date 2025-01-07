module 0x16c5f17f2d55584a6e6daa442ccf83b4530d10546a8e7dedda9ba324e012fc40::witness {
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
        0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::assert_publisher<T0>(arg0);
        Witness<T0>{dummy_field: false}
    }

    public fun from_witness<T0, T1: drop>(arg0: T1) : Witness<T0> {
        0x859eb18bd5b5e8cc32deb6dfb1c39941008ab3c6e27f0b8ce2364be7102bb7cb::utils::assert_same_module_as_witness<T0, T1>();
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

