module 0x639e0be521805da4d5142412312f24c2d1c68cc8bed299bffae7f5be5c139dbf::witness {
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

