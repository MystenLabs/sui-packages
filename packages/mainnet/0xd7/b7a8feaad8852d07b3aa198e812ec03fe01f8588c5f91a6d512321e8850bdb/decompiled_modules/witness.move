module 0xd7b7a8feaad8852d07b3aa198e812ec03fe01f8588c5f91a6d512321e8850bdb::witness {
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

