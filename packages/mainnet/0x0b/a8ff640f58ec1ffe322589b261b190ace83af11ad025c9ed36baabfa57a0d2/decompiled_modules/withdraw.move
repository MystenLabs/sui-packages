module 0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::withdraw {
    struct WithdrawEvent has copy, drop {
        redeemer: address,
        market: 0x1::type_name::TypeName,
        obligation: 0x2::object::ID,
        withdraw_asset: 0x1::type_name::TypeName,
        withdraw_amount: u64,
        burn_asset: 0x1::type_name::TypeName,
        burn_amount: u64,
        time: u64,
    }

    public fun withdraw<T0, T1>(arg0: &mut 0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::market::Market<T0>, arg1: &0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::obligation::ObligationOwnerCap, arg2: &0x6a79a9f82463e3c554cd5106e3878882c40568d264f0d43002bc4e9eba025159::coin_decimals_registry::CoinDecimalsRegistry, arg3: u64, arg4: &0x8df1d001c6cb220f28cf2ba330ed7ea9febaac2d797329e2196133eb02bec894::x_oracle::XOracle, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = withdraw_as_coin<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v0, 0x2::tx_context::sender(arg6));
    }

    public fun withdraw_as_coin<T0, T1>(arg0: &mut 0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::market::Market<T0>, arg1: &0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::obligation::ObligationOwnerCap, arg2: &0x6a79a9f82463e3c554cd5106e3878882c40568d264f0d43002bc4e9eba025159::coin_decimals_registry::CoinDecimalsRegistry, arg3: u64, arg4: &0x8df1d001c6cb220f28cf2ba330ed7ea9febaac2d797329e2196133eb02bec894::x_oracle::XOracle, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::clock::timestamp_ms(arg5) / 1000;
        let (v1, v2) = 0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::market::handle_withdraw<T0, T1>(arg0, 0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::obligation::id(arg1), arg3, arg2, arg4, arg5, v0, arg6);
        let v3 = v1;
        let v4 = WithdrawEvent{
            redeemer        : 0x2::tx_context::sender(arg6),
            market          : 0x1::type_name::get<T0>(),
            obligation      : 0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::obligation::id(arg1),
            withdraw_asset  : 0x1::type_name::get<T1>(),
            withdraw_amount : 0x2::coin::value<T1>(&v3),
            burn_asset      : 0x1::type_name::get<0xba8ff640f58ec1ffe322589b261b190ace83af11ad025c9ed36baabfa57a0d2::ctoken::CToken<T0, T1>>(),
            burn_amount     : v2,
            time            : v0,
        };
        0x2::event::emit<WithdrawEvent>(v4);
        v3
    }

    // decompiled from Move bytecode v6
}

