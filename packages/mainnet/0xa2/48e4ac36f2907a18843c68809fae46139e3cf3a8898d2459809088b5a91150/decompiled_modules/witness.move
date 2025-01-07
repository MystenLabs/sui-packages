module 0xa248e4ac36f2907a18843c68809fae46139e3cf3a8898d2459809088b5a91150::witness {
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
        0x8f147a66681627597d33d30125449704af9dba3351dd9a359fdc731ed931c912::utils::assert_publisher<T0>(arg0);
        Witness<T0>{dummy_field: false}
    }

    public fun from_witness<T0, T1: drop>(arg0: T1) : Witness<T0> {
        0x8f147a66681627597d33d30125449704af9dba3351dd9a359fdc731ed931c912::utils::assert_same_module_as_witness<T0, T1>();
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

