module 0x314331c1a831f18b6e95244f23746dc6cb415ae335a97320e60c4829797d8e91::coin_wrapper {
    struct CoinWrapper has key {
        id: 0x2::object::UID,
    }

    struct CoinStore<phantom T0> has store {
        coin: 0x2::coin::Coin<T0>,
    }

    public entry fun unwrap<T0>(arg0: CoinWrapper, arg1: &mut 0x2::tx_context::TxContext) {
        let CoinWrapper { id: v0 } = arg0;
        let CoinStore { coin: v1 } = 0x2::dynamic_field::remove<vector<u8>, CoinStore<T0>>(&mut v0, b"coin");
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, 0x2::tx_context::sender(arg1));
        0x2::object::delete(v0);
    }

    public entry fun wrap_and_transfer<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = CoinWrapper{id: 0x2::object::new(arg2)};
        let v1 = CoinStore<T0>{coin: arg0};
        0x2::dynamic_field::add<vector<u8>, CoinStore<T0>>(&mut v0.id, b"coin", v1);
        0x2::transfer::transfer<CoinWrapper>(v0, arg1);
    }

    // decompiled from Move bytecode v6
}

