module 0x9847c85dea39cd9b43451a3f19d9829c676d1dc962df69856b1d370ba646be67::suidex {
    fun addr<T0, T1>(arg0: &0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::Pool<T0, T1>) : address {
        0x2::object::id_address<0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::Pool<T0, T1>>(arg0)
    }

    public fun flash_borrow_a2b<T0, T1>(arg0: &mut 0x9847c85dea39cd9b43451a3f19d9829c676d1dc962df69856b1d370ba646be67::session::Session, arg1: &mut 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::Pool<T0, T1>, arg2: &0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::version::Version, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) : 0x1::option::Option<0x9847c85dea39cd9b43451a3f19d9829c676d1dc962df69856b1d370ba646be67::ll::LL<0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::trade::FlashSwapReceipt>> {
        let v0 = 0x9847c85dea39cd9b43451a3f19d9829c676d1dc962df69856b1d370ba646be67::session::principal(arg0);
        let (v1, v2, v3) = 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::trade::flash_swap<T0, T1>(arg1, true, true, v0, limit(true), arg3, arg2, arg4);
        0x2::balance::destroy_zero<T0>(v1);
        0x9847c85dea39cd9b43451a3f19d9829c676d1dc962df69856b1d370ba646be67::session::seed<T1>(arg0, v2);
        0x9847c85dea39cd9b43451a3f19d9829c676d1dc962df69856b1d370ba646be67::ll::some<0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::trade::FlashSwapReceipt>(v3, v0)
    }

    public fun flash_borrow_b2a<T0, T1>(arg0: &mut 0x9847c85dea39cd9b43451a3f19d9829c676d1dc962df69856b1d370ba646be67::session::Session, arg1: &mut 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::Pool<T0, T1>, arg2: &0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::version::Version, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) : 0x1::option::Option<0x9847c85dea39cd9b43451a3f19d9829c676d1dc962df69856b1d370ba646be67::ll::LL<0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::trade::FlashSwapReceipt>> {
        let v0 = 0x9847c85dea39cd9b43451a3f19d9829c676d1dc962df69856b1d370ba646be67::session::principal(arg0);
        let (v1, v2, v3) = 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::trade::flash_swap<T0, T1>(arg1, false, true, v0, limit(false), arg3, arg2, arg4);
        0x2::balance::destroy_zero<T1>(v2);
        0x9847c85dea39cd9b43451a3f19d9829c676d1dc962df69856b1d370ba646be67::session::seed<T0>(arg0, v1);
        0x9847c85dea39cd9b43451a3f19d9829c676d1dc962df69856b1d370ba646be67::ll::some<0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::trade::FlashSwapReceipt>(v3, v0)
    }

    public fun flash_repay_a2b<T0, T1>(arg0: &mut 0x9847c85dea39cd9b43451a3f19d9829c676d1dc962df69856b1d370ba646be67::session::Session, arg1: &mut 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::Pool<T0, T1>, arg2: &0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::version::Version, arg3: 0x1::option::Option<0x9847c85dea39cd9b43451a3f19d9829c676d1dc962df69856b1d370ba646be67::ll::LL<0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::trade::FlashSwapReceipt>>, arg4: &0x2::tx_context::TxContext) {
        let (v0, _) = 0x9847c85dea39cd9b43451a3f19d9829c676d1dc962df69856b1d370ba646be67::ll::open<0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::trade::FlashSwapReceipt>(arg3);
        let v2 = v0;
        let (v3, _) = 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::trade::swap_receipt_debts(&v2);
        let v5 = 0x9847c85dea39cd9b43451a3f19d9829c676d1dc962df69856b1d370ba646be67::session::take_final<T0>(arg0);
        0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::trade::repay_flash_swap<T0, T1>(arg1, v2, 0x2::balance::split<T0>(&mut v5, v3), 0x2::balance::zero<T1>(), arg2, arg4);
        0x9847c85dea39cd9b43451a3f19d9829c676d1dc962df69856b1d370ba646be67::session::settle<T0>(arg0, v5);
    }

    public fun flash_repay_b2a<T0, T1>(arg0: &mut 0x9847c85dea39cd9b43451a3f19d9829c676d1dc962df69856b1d370ba646be67::session::Session, arg1: &mut 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::Pool<T0, T1>, arg2: &0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::version::Version, arg3: 0x1::option::Option<0x9847c85dea39cd9b43451a3f19d9829c676d1dc962df69856b1d370ba646be67::ll::LL<0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::trade::FlashSwapReceipt>>, arg4: &0x2::tx_context::TxContext) {
        let (v0, _) = 0x9847c85dea39cd9b43451a3f19d9829c676d1dc962df69856b1d370ba646be67::ll::open<0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::trade::FlashSwapReceipt>(arg3);
        let v2 = v0;
        let (_, v4) = 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::trade::swap_receipt_debts(&v2);
        let v5 = 0x9847c85dea39cd9b43451a3f19d9829c676d1dc962df69856b1d370ba646be67::session::take_final<T1>(arg0);
        0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::trade::repay_flash_swap<T0, T1>(arg1, v2, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut v5, v4), arg2, arg4);
        0x9847c85dea39cd9b43451a3f19d9829c676d1dc962df69856b1d370ba646be67::session::settle<T1>(arg0, v5);
    }

    fun limit(arg0: bool) : u128 {
        if (arg0) {
            0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::tick_math::min_sqrt_price()
        } else {
            0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::tick_math::max_sqrt_price()
        }
    }

    public fun peek<T0, T1>(arg0: &0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::Pool<T0, T1>, arg1: bool, arg2: u64) : u64 {
        if (arg2 == 0) {
            return 0
        };
        let v0 = 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::trade::compute_swap_result<T0, T1>(arg0, arg1, true, limit(arg1), arg2);
        if (0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::trade::get_state_amount_specified(&v0) > 0) {
            return 0
        };
        0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::trade::get_state_amount_calculated(&v0)
    }

    public fun r_a2b<T0, T1>(arg0: &mut 0x9847c85dea39cd9b43451a3f19d9829c676d1dc962df69856b1d370ba646be67::session::Session, arg1: &mut 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::Pool<T0, T1>, arg2: &0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::version::Version, arg3: &0x2::clock::Clock, arg4: u8, arg5: &0x2::tx_context::TxContext) {
        let v0 = 0x9847c85dea39cd9b43451a3f19d9829c676d1dc962df69856b1d370ba646be67::session::take_in<T0>(arg0, arg4);
        let v1 = 0x2::balance::value<T0>(&v0);
        if (v1 == 0) {
            0x2::balance::destroy_zero<T0>(v0);
            0x9847c85dea39cd9b43451a3f19d9829c676d1dc962df69856b1d370ba646be67::session::put_out<T1>(arg0, arg4, 0x2::balance::zero<T1>(), addr<T0, T1>(arg1));
            return
        };
        let (v2, v3, v4) = 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::trade::flash_swap<T0, T1>(arg1, true, true, v1, limit(true), arg3, arg2, arg5);
        0x2::balance::destroy_zero<T0>(v2);
        0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::trade::repay_flash_swap<T0, T1>(arg1, v4, v0, 0x2::balance::zero<T1>(), arg2, arg5);
        0x9847c85dea39cd9b43451a3f19d9829c676d1dc962df69856b1d370ba646be67::session::put_out<T1>(arg0, arg4, v3, addr<T0, T1>(arg1));
    }

    public fun r_b2a<T0, T1>(arg0: &mut 0x9847c85dea39cd9b43451a3f19d9829c676d1dc962df69856b1d370ba646be67::session::Session, arg1: &mut 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::Pool<T0, T1>, arg2: &0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::version::Version, arg3: &0x2::clock::Clock, arg4: u8, arg5: &0x2::tx_context::TxContext) {
        let v0 = 0x9847c85dea39cd9b43451a3f19d9829c676d1dc962df69856b1d370ba646be67::session::take_in<T1>(arg0, arg4);
        let v1 = 0x2::balance::value<T1>(&v0);
        if (v1 == 0) {
            0x2::balance::destroy_zero<T1>(v0);
            0x9847c85dea39cd9b43451a3f19d9829c676d1dc962df69856b1d370ba646be67::session::put_out<T0>(arg0, arg4, 0x2::balance::zero<T0>(), addr<T0, T1>(arg1));
            return
        };
        let (v2, v3, v4) = 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::trade::flash_swap<T0, T1>(arg1, false, true, v1, limit(false), arg3, arg2, arg5);
        0x2::balance::destroy_zero<T1>(v3);
        0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::trade::repay_flash_swap<T0, T1>(arg1, v4, 0x2::balance::zero<T0>(), v0, arg2, arg5);
        0x9847c85dea39cd9b43451a3f19d9829c676d1dc962df69856b1d370ba646be67::session::put_out<T0>(arg0, arg4, v2, addr<T0, T1>(arg1));
    }

    // decompiled from Move bytecode v7
}

