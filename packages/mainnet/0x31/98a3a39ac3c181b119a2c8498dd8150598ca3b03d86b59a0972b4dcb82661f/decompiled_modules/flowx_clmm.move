module 0x3198a3a39ac3c181b119a2c8498dd8150598ca3b03d86b59a0972b4dcb82661f::flowx_clmm {
    public fun close_position_and_decrease_liquidity<T0, T1, T2>(arg0: &mut 0x3198a3a39ac3c181b119a2c8498dd8150598ca3b03d86b59a0972b4dcb82661f::portfolio::PositionManager, arg1: &0x3198a3a39ac3c181b119a2c8498dd8150598ca3b03d86b59a0972b4dcb82661f::portfolio::ManagerCap, arg2: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position_manager::PositionRegistry, arg3: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::PoolRegistry, arg4: 0x2::object::ID, arg5: u64, arg6: u32, arg7: u32, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg16: &0x2::clock::Clock, arg17: &mut 0x2::tx_context::TxContext) {
        assert!(0x3198a3a39ac3c181b119a2c8498dd8150598ca3b03d86b59a0972b4dcb82661f::portfolio::verify_manager_cap(arg0, arg1), 0);
        assert!(0x3198a3a39ac3c181b119a2c8498dd8150598ca3b03d86b59a0972b4dcb82661f::portfolio::position_exists<T0, T1>(arg0, arg4, arg6, arg7), 1);
        0x3198a3a39ac3c181b119a2c8498dd8150598ca3b03d86b59a0972b4dcb82661f::portfolio::remove_df_position<T0, T1>(arg0, arg4, arg6, arg7);
        let v0 = 0x3198a3a39ac3c181b119a2c8498dd8150598ca3b03d86b59a0972b4dcb82661f::portfolio::remove_dof_position<0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position::Position>(arg0, arg4);
        0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position_manager::decrease_liquidity<T0, T1>(arg3, &mut v0, 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position::liquidity(&v0), arg8, arg9, arg14, arg15, arg16, arg17);
        let (v1, v2) = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position_manager::collect<T0, T1>(arg3, &mut v0, arg10, arg11, arg15, arg16, arg17);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, 0x3198a3a39ac3c181b119a2c8498dd8150598ca3b03d86b59a0972b4dcb82661f::portfolio::get_manager_owner(arg0));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v2, 0x3198a3a39ac3c181b119a2c8498dd8150598ca3b03d86b59a0972b4dcb82661f::portfolio::get_manager_owner(arg0));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position_manager::collect_pool_reward<T0, T1, T0>(arg3, &mut v0, arg12, arg15, arg16, arg17), 0x3198a3a39ac3c181b119a2c8498dd8150598ca3b03d86b59a0972b4dcb82661f::portfolio::get_manager_owner(arg0));
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position_manager::collect_pool_reward<T0, T1, T2>(arg3, &mut v0, arg12, arg15, arg16, arg17), 0x3198a3a39ac3c181b119a2c8498dd8150598ca3b03d86b59a0972b4dcb82661f::portfolio::get_manager_owner(arg0));
        0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position_manager::close_position(arg2, v0, arg15, arg17);
    }

    public fun open_position_and_increase_liquidity<T0, T1>(arg0: &mut 0x3198a3a39ac3c181b119a2c8498dd8150598ca3b03d86b59a0972b4dcb82661f::portfolio::PositionManager, arg1: &0x3198a3a39ac3c181b119a2c8498dd8150598ca3b03d86b59a0972b4dcb82661f::portfolio::OwnerCap, arg2: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position_manager::PositionRegistry, arg3: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::PoolRegistry, arg4: 0x2::object::ID, arg5: u64, arg6: u32, arg7: u32, arg8: 0x2::coin::Coin<T0>, arg9: 0x2::coin::Coin<T1>, arg10: u64, arg11: u64, arg12: u64, arg13: &mut 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::versioned::Versioned, arg14: &0x2::clock::Clock, arg15: &mut 0x2::tx_context::TxContext) {
        0x3198a3a39ac3c181b119a2c8498dd8150598ca3b03d86b59a0972b4dcb82661f::portfolio::open_position<T0, T1>(arg0, arg1, arg4, arg6, arg7, arg15);
        let v0 = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position_manager::open_position<T0, T1>(arg2, arg3, arg5, 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::i32::neg_from(arg6), 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::i32::neg_from(arg7), arg13, arg15);
        0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position_manager::increase_liquidity<T0, T1>(arg3, &mut v0, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15);
        0x3198a3a39ac3c181b119a2c8498dd8150598ca3b03d86b59a0972b4dcb82661f::portfolio::add_dof_manager<0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::position::Position>(arg0, arg4, v0);
    }

    // decompiled from Move bytecode v6
}

