module 0xdc815c5b6818f80cba2ae0124a06b129b88c6edc76fde209c0a3ac937b86b43c::leverage_reduce_to_collateral_coin {
    public fun withdraw_leverage<T0, T1, T2>(arg0: &mut 0x1b18a58a0132da273021b9aa880affa34759802eb3ae78dcd249f4cd44cb9899::market::Market<T0>, arg1: &mut 0xdc815c5b6818f80cba2ae0124a06b129b88c6edc76fde209c0a3ac937b86b43c::leverage_obligation::LeverageMarketOwnerCap, arg2: u64, arg3: &0x1a0736fb2df41236bd00010023e95f2503bed82339e54f13c0b4c032e69697ec::x_oracle::XOracle, arg4: &0x2::clock::Clock, arg5: &0x1b18a58a0132da273021b9aa880affa34759802eb3ae78dcd249f4cd44cb9899::coin_decimals_registry::CoinDecimalsRegistry, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xdc815c5b6818f80cba2ae0124a06b129b88c6edc76fde209c0a3ac937b86b43c::leverage_obligation::ensure_same_market<T0>(arg1);
        0xdc815c5b6818f80cba2ae0124a06b129b88c6edc76fde209c0a3ac937b86b43c::leverage_obligation::ensure_coins_match<T1, T2>(arg1);
        0xdc815c5b6818f80cba2ae0124a06b129b88c6edc76fde209c0a3ac937b86b43c::leverage_reduce_to_borrow_coin::emit_reduce_leverage_event(0xdc815c5b6818f80cba2ae0124a06b129b88c6edc76fde209c0a3ac937b86b43c::leverage_obligation::id(arg1), arg2, 0, 0xdc815c5b6818f80cba2ae0124a06b129b88c6edc76fde209c0a3ac937b86b43c::leverage_obligation::get_collateral_price<T1, T2>(arg3, arg4));
        0x1b18a58a0132da273021b9aa880affa34759802eb3ae78dcd249f4cd44cb9899::withdraw::withdraw_as_coin<T0, T1>(arg0, 0xdc815c5b6818f80cba2ae0124a06b129b88c6edc76fde209c0a3ac937b86b43c::leverage_obligation::market_obligation(arg1), arg5, 0xdc815c5b6818f80cba2ae0124a06b129b88c6edc76fde209c0a3ac937b86b43c::leverage_reduce_to_borrow_coin::enforce_ctoken_deduciton<T0, T1>(arg0, arg1, arg2), arg3, arg4, arg6)
    }

    public fun withdraw_size<T0, T1, T2>(arg0: &mut 0x1b18a58a0132da273021b9aa880affa34759802eb3ae78dcd249f4cd44cb9899::market::Market<T0>, arg1: &mut 0xdc815c5b6818f80cba2ae0124a06b129b88c6edc76fde209c0a3ac937b86b43c::leverage_obligation::LeverageMarketOwnerCap, arg2: u8, arg3: &0x1a0736fb2df41236bd00010023e95f2503bed82339e54f13c0b4c032e69697ec::x_oracle::XOracle, arg4: &0x2::clock::Clock, arg5: &0x1b18a58a0132da273021b9aa880affa34759802eb3ae78dcd249f4cd44cb9899::coin_decimals_registry::CoinDecimalsRegistry, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xdc815c5b6818f80cba2ae0124a06b129b88c6edc76fde209c0a3ac937b86b43c::leverage_obligation::ensure_same_market<T0>(arg1);
        0xdc815c5b6818f80cba2ae0124a06b129b88c6edc76fde209c0a3ac937b86b43c::leverage_obligation::ensure_coins_match<T1, T2>(arg1);
        let (v0, v1) = 0xdc815c5b6818f80cba2ae0124a06b129b88c6edc76fde209c0a3ac937b86b43c::leverage_reduce_to_borrow_coin::enforce_collateral_deduciton_by_percentage<T0, T1>(arg0, arg1, arg2);
        0xdc815c5b6818f80cba2ae0124a06b129b88c6edc76fde209c0a3ac937b86b43c::leverage_reduce_to_borrow_coin::emit_reduce_size_event(0xdc815c5b6818f80cba2ae0124a06b129b88c6edc76fde209c0a3ac937b86b43c::leverage_obligation::id(arg1), v1, 0, 0xdc815c5b6818f80cba2ae0124a06b129b88c6edc76fde209c0a3ac937b86b43c::leverage_obligation::get_collateral_price<T1, T2>(arg3, arg4));
        0x1b18a58a0132da273021b9aa880affa34759802eb3ae78dcd249f4cd44cb9899::withdraw::withdraw_as_coin<T0, T1>(arg0, 0xdc815c5b6818f80cba2ae0124a06b129b88c6edc76fde209c0a3ac937b86b43c::leverage_obligation::market_obligation(arg1), arg5, v0, arg3, arg4, arg6)
    }

    // decompiled from Move bytecode v6
}

