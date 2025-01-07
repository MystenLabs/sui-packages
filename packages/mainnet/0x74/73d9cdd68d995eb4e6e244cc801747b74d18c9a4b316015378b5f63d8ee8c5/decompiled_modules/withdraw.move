module 0x7473d9cdd68d995eb4e6e244cc801747b74d18c9a4b316015378b5f63d8ee8c5::withdraw {
    public fun withdraw<T0, T1, T2>(arg0: &mut 0x7473d9cdd68d995eb4e6e244cc801747b74d18c9a4b316015378b5f63d8ee8c5::vault::Vault<T0, T1, T2>, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: 0x2::coin::Coin<T2>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert!(0x2::coin::value<T2>(&arg3) > 0, 0);
        let (v0, v1) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::remove_liquidity<T0, T1>(arg2, arg1, 0x7473d9cdd68d995eb4e6e244cc801747b74d18c9a4b316015378b5f63d8ee8c5::vault::position_borrow_mut<T0, T1, T2>(arg0), (0x2::coin::value<T2>(&arg3) as u128) * 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(0x7473d9cdd68d995eb4e6e244cc801747b74d18c9a4b316015378b5f63d8ee8c5::vault::position_borrow<T0, T1, T2>(arg0)) / (0x7473d9cdd68d995eb4e6e244cc801747b74d18c9a4b316015378b5f63d8ee8c5::vault::total_supply<T0, T1, T2>(arg0) as u128), arg4);
        0x7473d9cdd68d995eb4e6e244cc801747b74d18c9a4b316015378b5f63d8ee8c5::vault::burn_vault_coin<T0, T1, T2>(arg0, arg3);
        (0x2::coin::from_balance<T0>(v0, arg5), 0x2::coin::from_balance<T1>(v1, arg5))
    }

    public entry fun withdraw_entry<T0, T1, T2>(arg0: &mut 0x7473d9cdd68d995eb4e6e244cc801747b74d18c9a4b316015378b5f63d8ee8c5::vault::Vault<T0, T1, T2>, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: 0x2::coin::Coin<T2>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = withdraw<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg5));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v1, 0x2::tx_context::sender(arg5));
    }

    // decompiled from Move bytecode v6
}

