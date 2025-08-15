module 0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::borrow {
    struct BorrowEvent has copy, drop {
        borrower: address,
        market: 0x1::type_name::TypeName,
        obligation: 0x2::object::ID,
        asset: 0x1::type_name::TypeName,
        amount: u64,
        time: u64,
    }

    public fun borrow<T0, T1>(arg0: &0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::obligation::ObligationOwnerCap, arg1: &mut 0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::market::Market<T0>, arg2: &0x6a79a9f82463e3c554cd5106e3878882c40568d264f0d43002bc4e9eba025159::coin_decimals_registry::CoinDecimalsRegistry, arg3: u64, arg4: &0x8df1d001c6cb220f28cf2ba330ed7ea9febaac2d797329e2196133eb02bec894::x_oracle::XOracle, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::clock::timestamp_ms(arg5) / 1000;
        let v1 = BorrowEvent{
            borrower   : 0x2::tx_context::sender(arg6),
            market     : 0x1::type_name::get<T0>(),
            obligation : 0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::obligation::id(arg0),
            asset      : 0x1::type_name::get<T1>(),
            amount     : arg3,
            time       : v0,
        };
        0x2::event::emit<BorrowEvent>(v1);
        0x2::coin::from_balance<T1>(0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::market::handle_borrow<T0, T1>(arg1, 0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::obligation::id(arg0), arg3, arg2, arg4, arg5, v0), arg6)
    }

    // decompiled from Move bytecode v6
}

