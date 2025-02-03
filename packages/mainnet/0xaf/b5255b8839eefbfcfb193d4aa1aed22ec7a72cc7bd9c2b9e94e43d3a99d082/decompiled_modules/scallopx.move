module 0x639e0be521805da4d5142412312f24c2d1c68cc8bed299bffae7f5be5c139dbf::scallopx {
    fun init_module(arg0: &mut 0x2::tx_context::TxContext) {
    }

    fun long<T0>(arg0: &0x639e0be521805da4d5142412312f24c2d1c68cc8bed299bffae7f5be5c139dbf::version::Version, arg1: &mut 0x639e0be521805da4d5142412312f24c2d1c68cc8bed299bffae7f5be5c139dbf::obligation::Obligation, arg2: &0x639e0be521805da4d5142412312f24c2d1c68cc8bed299bffae7f5be5c139dbf::obligation::ObligationKey, arg3: &mut 0x639e0be521805da4d5142412312f24c2d1c68cc8bed299bffae7f5be5c139dbf::market::Market, arg4: &0x639e0be521805da4d5142412312f24c2d1c68cc8bed299bffae7f5be5c139dbf::coin_decimals_registry::CoinDecimalsRegistry, arg5: &0x639e0be521805da4d5142412312f24c2d1c68cc8bed299bffae7f5be5c139dbf::x_oracle::XOracle, arg6: &0x2::clock::Clock, arg7: 0x2::coin::Coin<0x2::sui::SUI>, arg8: &mut 0x2::tx_context::TxContext) {
        0x639e0be521805da4d5142412312f24c2d1c68cc8bed299bffae7f5be5c139dbf::deposit_collateral::deposit_collateral<0x2::sui::SUI>(arg0, arg1, arg3, arg7, arg8);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x639e0be521805da4d5142412312f24c2d1c68cc8bed299bffae7f5be5c139dbf::borrow::borrow<T0>(arg0, arg1, arg2, arg3, arg4, 0x639e0be521805da4d5142412312f24c2d1c68cc8bed299bffae7f5be5c139dbf::borrow_withdraw_evaluator::max_borrow_amount<T0>(arg1, arg3, arg4, arg5, arg6), arg5, arg6, arg8), 0x2::tx_context::sender(arg8));
    }

    // decompiled from Move bytecode v6
}

