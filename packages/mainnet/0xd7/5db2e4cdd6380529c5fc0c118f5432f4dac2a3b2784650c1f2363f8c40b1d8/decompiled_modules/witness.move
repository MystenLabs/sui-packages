module 0xd75db2e4cdd6380529c5fc0c118f5432f4dac2a3b2784650c1f2363f8c40b1d8::witness {
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

