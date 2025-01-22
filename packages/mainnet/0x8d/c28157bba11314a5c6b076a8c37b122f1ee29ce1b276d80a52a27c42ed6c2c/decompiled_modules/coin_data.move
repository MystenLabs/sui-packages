module 0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::coin_data {
    struct CoinData<phantom T0> has store {
        coin_management: 0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::coin_management::CoinManagement<T0>,
        coin_info: 0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::coin_info::CoinInfo<T0>,
    }

    public(friend) fun coin_info<T0>(arg0: &CoinData<T0>) : &0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::coin_info::CoinInfo<T0> {
        &arg0.coin_info
    }

    public(friend) fun coin_management_mut<T0>(arg0: &mut CoinData<T0>) : &mut 0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::coin_management::CoinManagement<T0> {
        &mut arg0.coin_management
    }

    public(friend) fun new<T0>(arg0: 0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::coin_management::CoinManagement<T0>, arg1: 0x8dc28157bba11314a5c6b076a8c37b122f1ee29ce1b276d80a52a27c42ed6c2c::coin_info::CoinInfo<T0>) : CoinData<T0> {
        CoinData<T0>{
            coin_management : arg0,
            coin_info       : arg1,
        }
    }

    // decompiled from Move bytecode v6
}

