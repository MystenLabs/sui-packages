module 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::create {
    fun create_pool<T0, T1>(arg0: &0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::config::HopConfig, arg1: u8, arg2: u64, arg3: u32, arg4: u64, arg5: u128, arg6: u32, arg7: u32, arg8: 0x2::coin::Coin<T0>, arg9: 0x2::coin::Coin<T1>, arg10: bool, arg11: bool, arg12: address, arg13: bool, arg14: 0x1::option::Option<address>, arg15: &mut 0x2::tx_context::TxContext) : (0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::pool::Pool<T0, T1>, 0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::config::enforce_min_version(arg0);
        0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::config::enforce_create_enabled(arg0);
        let v0 = 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::pool::create<T0, T1>(arg5, arg3, arg4, arg13, arg14, arg1, arg2, arg15);
        0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::events::emit_create_pool_event(0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::pool::id<T0, T1>(&v0), 0x1::type_name::with_defining_ids<T0>(), 0x1::type_name::with_defining_ids<T1>(), arg13);
        let v1 = 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::liquidity::open_position_internal<T0, T1>(arg0, &v0, arg6, arg7, arg15);
        let (v2, v3) = 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::liquidity::add_liquidity_internal<T0, T1>(arg0, &mut v0, &mut v1, arg8, arg9, arg10, 0, 0, arg15);
        if (arg11) {
            0x2::transfer::public_share_object<0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::position::LockedPosition>(0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::position::lock(v1, arg12, arg15));
        } else {
            0x2::transfer::public_transfer<0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::position::Position>(v1, 0x2::tx_context::sender(arg15));
        };
        (v0, v2, v3)
    }

    public fun create_pool_dynamic<T0>(arg0: &0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::config::HopConfig, arg1: &0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::dynamic_fee::DynamicFee, arg2: u8, arg3: u64, arg4: u128, arg5: u32, arg6: 0x2::coin::Coin<T0>, arg7: 0x2::coin::Coin<0x2::sui::SUI>, arg8: bool, arg9: bool, arg10: address, arg11: address, arg12: &mut 0x2::tx_context::TxContext) : (0x2::object::ID, 0x2::coin::Coin<T0>, 0x2::coin::Coin<0x2::sui::SUI>) {
        0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::config::enforce_min_version(arg0);
        let (v0, v1, v2) = create_pool<T0, 0x2::sui::SUI>(arg0, arg2, arg3, 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::dynamic_fee::tick_spacing(arg1), 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::dynamic_fee::lp_fee(arg1), arg4, arg5, 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::tick_math::tick_bound() - 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::tick_math::tick_bound() % 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::dynamic_fee::tick_spacing(arg1), arg6, arg7, arg8, arg9, arg10, true, 0x1::option::some<address>(arg11), arg12);
        let v3 = v0;
        0x2::transfer::public_share_object<0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::pool::Pool<T0, 0x2::sui::SUI>>(v3);
        (0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::pool::id<T0, 0x2::sui::SUI>(&v3), v1, v2)
    }

    public fun create_pool_dynamic_and_buy<T0>(arg0: &0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::config::HopConfig, arg1: &0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::dynamic_fee::DynamicFee, arg2: u8, arg3: u64, arg4: u128, arg5: u32, arg6: 0x2::coin::Coin<T0>, arg7: 0x2::coin::Coin<0x2::sui::SUI>, arg8: bool, arg9: bool, arg10: address, arg11: address, arg12: 0x2::coin::Coin<0x2::sui::SUI>, arg13: &mut 0x2::tx_context::TxContext) : (0x2::object::ID, 0x2::coin::Coin<T0>, 0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<T0>) {
        0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::config::enforce_min_version(arg0);
        let (v0, v1, v2) = create_pool<T0, 0x2::sui::SUI>(arg0, arg2, arg3, 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::dynamic_fee::tick_spacing(arg1), 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::dynamic_fee::lp_fee(arg1), arg4, arg5, 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::tick_math::tick_bound() - 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::tick_math::tick_bound() % 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::dynamic_fee::tick_spacing(arg1), arg6, arg7, arg8, arg9, arg10, true, 0x1::option::some<address>(arg11), arg13);
        let v3 = v0;
        let (v4, v5) = 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::trade::swap_returns<T0, 0x2::sui::SUI>(arg0, arg1, &mut v3, 0x2::coin::zero<T0>(arg13), arg12, false, true, 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::tick_math::max_sqrt_price(), arg13);
        let v6 = v5;
        0x2::transfer::public_share_object<0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::pool::Pool<T0, 0x2::sui::SUI>>(v3);
        if (0x2::coin::value<0x2::sui::SUI>(&v6) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v6, 0x2::tx_context::sender(arg13));
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(v6);
        };
        (0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::pool::id<T0, 0x2::sui::SUI>(&v3), v1, v2, v4)
    }

    // decompiled from Move bytecode v6
}

