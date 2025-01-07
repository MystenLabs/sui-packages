module 0x59d41e24d4eba6fa35cbc12710cf2dce817cdeb2ed9c1798339e1add6e7d94d6::witness {
    struct WitnessGenerator<phantom T0> has store {
        dummy_field: bool,
    }

    struct Witness<phantom T0> has drop {
        dummy_field: bool,
    }

    public fun assert_publisher<T0>(arg0: &0x2::package::Publisher) {
        assert!(0x2::package::from_package<T0>(arg0), 135425);
    }

    public fun from_generator<T0>(arg0: WitnessGenerator<T0>) : Witness<T0> {
        let WitnessGenerator {  } = arg0;
        Witness<T0>{dummy_field: false}
    }

    public fun from_publisher<T0>(arg0: &0x2::package::Publisher) : Witness<T0> {
        assert_publisher<T0>(arg0);
        Witness<T0>{dummy_field: false}
    }

    public fun to_generator<T0>(arg0: Witness<T0>) : WitnessGenerator<T0> {
        WitnessGenerator<T0>{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

