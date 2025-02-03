module 0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::unregistered_coin_data {
    struct UnregisteredCoinData<phantom T0> has store {
        treasury_cap: 0x2::coin::TreasuryCap<T0>,
        coin_metadata: 0x2::coin::CoinMetadata<T0>,
    }

    public(friend) fun destroy<T0>(arg0: UnregisteredCoinData<T0>) : (0x2::coin::TreasuryCap<T0>, 0x2::coin::CoinMetadata<T0>) {
        let UnregisteredCoinData {
            treasury_cap  : v0,
            coin_metadata : v1,
        } = arg0;
        (v0, v1)
    }

    public(friend) fun new<T0>(arg0: 0x2::coin::TreasuryCap<T0>, arg1: 0x2::coin::CoinMetadata<T0>) : UnregisteredCoinData<T0> {
        UnregisteredCoinData<T0>{
            treasury_cap  : arg0,
            coin_metadata : arg1,
        }
    }

    // decompiled from Move bytecode v6
}

