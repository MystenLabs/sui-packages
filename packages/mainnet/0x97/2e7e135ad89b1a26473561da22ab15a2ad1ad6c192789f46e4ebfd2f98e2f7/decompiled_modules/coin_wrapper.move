module 0x972e7e135ad89b1a26473561da22ab15a2ad1ad6c192789f46e4ebfd2f98e2f7::coin_wrapper {
    struct CoinWrapper has key {
        id: 0x2::object::UID,
    }

    struct CoinStore<phantom T0> has store {
        balance: 0x2::balance::Balance<T0>,
    }

    public entry fun unwrap<T0>(arg0: CoinWrapper, arg1: &mut 0x2::tx_context::TxContext) {
        let CoinWrapper { id: v0 } = arg0;
        let CoinStore { balance: v1 } = 0x2::dynamic_field::remove<vector<u8>, CoinStore<T0>>(&mut v0, b"coin");
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v1, arg1), 0x2::tx_context::sender(arg1));
        0x2::object::delete(v0);
    }

    public entry fun wrap_and_transfer<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = CoinWrapper{id: 0x2::object::new(arg2)};
        let v1 = CoinStore<T0>{balance: 0x2::coin::into_balance<T0>(arg0)};
        0x2::dynamic_field::add<vector<u8>, CoinStore<T0>>(&mut v0.id, b"coin", v1);
        0x2::transfer::transfer<CoinWrapper>(v0, arg1);
    }

    // decompiled from Move bytecode v6
}

