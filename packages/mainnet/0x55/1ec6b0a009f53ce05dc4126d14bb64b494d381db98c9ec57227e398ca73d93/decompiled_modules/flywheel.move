module 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::flywheel {
    public fun buyback_and_burn<T0>(arg0: &0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::config::HopConfig, arg1: &0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::dynamic_fee::DynamicFee, arg2: &mut 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::pool::Pool<T0, 0x2::sui::SUI>, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::coin_registry::Currency<T0>, arg5: u128, arg6: &mut 0x2::tx_context::TxContext) {
        0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::config::enforce_min_version(arg0);
        0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::config::enforce_flywheel_enabled(arg0);
        let (v0, v1) = 0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::trade::swap_returns<T0, 0x2::sui::SUI>(arg0, arg1, arg2, 0x2::coin::zero<T0>(arg6), arg3, false, true, arg5, arg6);
        let v2 = v1;
        let v3 = v0;
        let v4 = 0x2::coin::value<0x2::sui::SUI>(&arg3) - 0x2::coin::value<0x2::sui::SUI>(&v2);
        0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::pool::add_buybacks_amount_y<T0, 0x2::sui::SUI>(arg2, v4);
        if (0x2::coin::value<0x2::sui::SUI>(&v2) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v2, 0x2::tx_context::sender(arg6));
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(v2);
        };
        let v5 = 0x2::coin::value<T0>(&v3);
        0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::pool::add_buybacks_amount_x_burned<T0, 0x2::sui::SUI>(arg2, v5);
        0x2::coin_registry::burn<T0>(arg4, v3);
        0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::events::emit_flywheel_buy_event(0xd41e5cb31a5310f14d66f35cda3d2b3d0ab078959cbc015e63fff9829b83bf12::pool::id<T0, 0x2::sui::SUI>(arg2), 0x2::tx_context::sender(arg6), v4, v5);
    }

    // decompiled from Move bytecode v6
}

