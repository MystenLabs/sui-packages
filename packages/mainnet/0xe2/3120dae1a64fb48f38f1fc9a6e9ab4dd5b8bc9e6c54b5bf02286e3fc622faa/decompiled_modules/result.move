module 0xe23120dae1a64fb48f38f1fc9a6e9ab4dd5b8bc9e6c54b5bf02286e3fc622faa::result {
    struct PriceResult<phantom T0> has copy, drop {
        aggregated_price: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float,
    }

    public fun aggregated_price<T0>(arg0: &PriceResult<T0>) : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float {
        arg0.aggregated_price
    }

    public(friend) fun new<T0>(arg0: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float) : PriceResult<T0> {
        PriceResult<T0>{aggregated_price: arg0}
    }

    // decompiled from Move bytecode v7
}

