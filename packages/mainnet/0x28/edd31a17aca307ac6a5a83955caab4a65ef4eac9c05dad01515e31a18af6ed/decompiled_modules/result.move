module 0x28edd31a17aca307ac6a5a83955caab4a65ef4eac9c05dad01515e31a18af6ed::result {
    struct PriceResult<phantom T0> has copy, drop {
        aggregated_price: 0x89495ef31f30a6edbd08f8a28f4e5419401d2c133c34a617a7983928d5697797::float::Float,
    }

    public fun aggregated_price<T0>(arg0: &PriceResult<T0>) : 0x89495ef31f30a6edbd08f8a28f4e5419401d2c133c34a617a7983928d5697797::float::Float {
        arg0.aggregated_price
    }

    public(friend) fun new<T0>(arg0: 0x89495ef31f30a6edbd08f8a28f4e5419401d2c133c34a617a7983928d5697797::float::Float) : PriceResult<T0> {
        PriceResult<T0>{aggregated_price: arg0}
    }

    // decompiled from Move bytecode v6
}

