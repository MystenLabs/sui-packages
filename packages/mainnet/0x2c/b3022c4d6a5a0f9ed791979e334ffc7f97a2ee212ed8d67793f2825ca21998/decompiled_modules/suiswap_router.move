module 0x2cb3022c4d6a5a0f9ed791979e334ffc7f97a2ee212ed8d67793f2825ca21998::suiswap_router {
    public fun swap<T0, T1>(arg0: &mut 0x3d4964588ec53d5495071af008abad2a3f0927ea00bf8b7f394dee2444cee89::aggregator::SwapSession, arg1: &mut 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::Pool<T0, T1>, arg2: bool, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        if (arg2) {
            swap_x_to_y<T0, T1>(arg0, arg1, arg3, arg4, arg5);
        } else {
            swap_y_to_x<T0, T1>(arg0, arg1, arg3, arg4, arg5);
        };
    }

    fun swap_x_to_y<T0, T1>(arg0: &mut 0x3d4964588ec53d5495071af008abad2a3f0927ea00bf8b7f394dee2444cee89::aggregator::SwapSession, arg1: &mut 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::Pool<T0, T1>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x3d4964588ec53d5495071af008abad2a3f0927ea00bf8b7f394dee2444cee89::aggregator::take_balance<T0>(arg0, arg2);
        let v1 = 0x2::balance::value<T0>(&v0);
        if (v1 == 0) {
            0x2::balance::destroy_zero<T0>(v0);
            return
        };
        let v2 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
        0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v2, 0x2::coin::from_balance<T0>(v0, arg4));
        let (v3, v4) = 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::do_swap_x_to_y_direct<T0, T1>(arg1, v2, v1, arg3, arg4);
        let v5 = v4;
        let v6 = v3;
        if (0x2::coin::value<T0>(&v6) > 0) {
            0x3d4964588ec53d5495071af008abad2a3f0927ea00bf8b7f394dee2444cee89::aggregator::merge_balance<T0>(arg0, 0x2::coin::into_balance<T0>(v6));
        } else {
            0x2::coin::destroy_zero<T0>(v6);
        };
        0x3d4964588ec53d5495071af008abad2a3f0927ea00bf8b7f394dee2444cee89::aggregator::merge_balance<T1>(arg0, 0x2::coin::into_balance<T1>(v5));
        0x3d4964588ec53d5495071af008abad2a3f0927ea00bf8b7f394dee2444cee89::aggregator::emit_swap_event<T0, T1>(arg0, b"suiswap", 0x2::object::id<0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::Pool<T0, T1>>(arg1), v1, 0x2::coin::value<T1>(&v5), 0);
    }

    fun swap_y_to_x<T0, T1>(arg0: &mut 0x3d4964588ec53d5495071af008abad2a3f0927ea00bf8b7f394dee2444cee89::aggregator::SwapSession, arg1: &mut 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::Pool<T0, T1>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x3d4964588ec53d5495071af008abad2a3f0927ea00bf8b7f394dee2444cee89::aggregator::take_balance<T1>(arg0, arg2);
        let v1 = 0x2::balance::value<T1>(&v0);
        if (v1 == 0) {
            0x2::balance::destroy_zero<T1>(v0);
            return
        };
        let v2 = 0x1::vector::empty<0x2::coin::Coin<T1>>();
        0x1::vector::push_back<0x2::coin::Coin<T1>>(&mut v2, 0x2::coin::from_balance<T1>(v0, arg4));
        let (v3, v4) = 0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::do_swap_y_to_x_direct<T0, T1>(arg1, v2, v1, arg3, arg4);
        let v5 = v4;
        let v6 = v3;
        if (0x2::coin::value<T1>(&v6) > 0) {
            0x3d4964588ec53d5495071af008abad2a3f0927ea00bf8b7f394dee2444cee89::aggregator::merge_balance<T1>(arg0, 0x2::coin::into_balance<T1>(v6));
        } else {
            0x2::coin::destroy_zero<T1>(v6);
        };
        0x3d4964588ec53d5495071af008abad2a3f0927ea00bf8b7f394dee2444cee89::aggregator::merge_balance<T0>(arg0, 0x2::coin::into_balance<T0>(v5));
        0x3d4964588ec53d5495071af008abad2a3f0927ea00bf8b7f394dee2444cee89::aggregator::emit_swap_event<T1, T0>(arg0, b"suiswap", 0x2::object::id<0x361dd589b98e8fcda9a7ee53b85efabef3569d00416640d2faa516e3801d7ffc::pool::Pool<T0, T1>>(arg1), v1, 0x2::coin::value<T0>(&v5), 0);
    }

    // decompiled from Move bytecode v6
}

