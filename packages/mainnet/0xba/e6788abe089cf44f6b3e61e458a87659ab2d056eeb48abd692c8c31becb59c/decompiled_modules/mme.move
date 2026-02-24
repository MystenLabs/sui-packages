module 0xbae6788abe089cf44f6b3e61e458a87659ab2d056eeb48abd692c8c31becb59c::mme {
    struct LA has copy, drop {
        pk: u64,
        tl: u32,
        tu: u32,
        sa: u64,
        ua: u64,
    }

    struct LR has copy, drop {
        pk: u64,
        sl: u64,
        ul: u64,
        sf: u64,
        uf: u64,
    }

    struct RC has copy, drop {
        pk: u64,
        rt: 0x1::ascii::String,
        a: u64,
    }

    public fun alp(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg1: &mut 0xd4ae6ec0edf229ed93d33b9bef0a605aa6d15872e6f12fef85c12e8fa6a0a681::km::CKM, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg4: &0x2::clock::Clock, arg5: u32, arg6: u32, arg7: u64, arg8: bool, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        if (0x2::clock::timestamp_ms(arg4) > arg9) {
            abort 13906834543710699523
        };
        assert_known_rewards(arg0);
        let v0 = if (arg8) {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<0x2::sui::SUI>(arg2)
        } else {
            0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2)
        };
        let v1 = if (arg7 > v0) {
            v0
        } else {
            arg7
        };
        let v2 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::from_u32(arg5);
        let v3 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::from_u32(arg6);
        let v4 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::sqrt_price<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg0);
        let v5 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick_math::get_sqrt_price_at_tick(v2);
        let v6 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick_math::get_sqrt_price_at_tick(v3);
        let (v7, v8) = if (arg8) {
            (v1, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::liquidity_math::get_amount_y_for_liquidity(v5, v4, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::liquidity_math::get_liquidity_for_amount_x(v4, v6, v1), true))
        } else {
            (0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::liquidity_math::get_amount_x_for_liquidity(v4, v6, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::liquidity_math::get_liquidity_for_amount_y(v5, v4, v1), true), v1)
        };
        assert!(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::liquidity_math::get_liquidity_for_amounts(v4, v5, v6, v7, v8) > 0, 13906834779933769729);
        let v9 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::liquidity::open_position<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg0, v2, v3, arg3, arg11);
        let (v10, v11) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::liquidity::add_liquidity<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg0, &mut v9, 0xd4ae6ec0edf229ed93d33b9bef0a605aa6d15872e6f12fef85c12e8fa6a0a681::km::ab_dbk<0x2::sui::SUI>(arg1, arg2, v7, arg11), 0xd4ae6ec0edf229ed93d33b9bef0a605aa6d15872e6f12fef85c12e8fa6a0a681::km::ab_dbk<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg1, arg2, v8, arg11), 0, 0, arg4, arg3, arg11);
        let v12 = v11;
        let v13 = v10;
        let v14 = LA{
            pk : arg10,
            tl : arg5,
            tu : arg6,
            sa : v7 - 0x2::coin::value<0x2::sui::SUI>(&v13),
            ua : v8 - 0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&v12),
        };
        0x2::event::emit<LA>(v14);
        0xd4ae6ec0edf229ed93d33b9bef0a605aa6d15872e6f12fef85c12e8fa6a0a681::km::ez_dbk<0x2::sui::SUI>(arg1, arg2, v13, arg11);
        0xd4ae6ec0edf229ed93d33b9bef0a605aa6d15872e6f12fef85c12e8fa6a0a681::km::ez_dbk<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg1, arg2, v12, arg11);
        0xd4ae6ec0edf229ed93d33b9bef0a605aa6d15872e6f12fef85c12e8fa6a0a681::km::ez_stl<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(arg1, arg10, v9, arg11);
    }

    fun assert_known_rewards(arg0: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>) {
        let v0 = 0;
        while (v0 < 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::reward_length<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg0)) {
            let v1 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::reward_coin_type<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg0, v0);
            let v2 = if (v1 == 0x1::type_name::with_defining_ids<0x2::sui::SUI>()) {
                true
            } else if (v1 == 0x1::type_name::with_defining_ids<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>()) {
                true
            } else {
                v1 == 0x1::type_name::with_defining_ids<0x2b6602099970374cf58a2a1b9d96f005fccceb81e92eb059873baf420eb6c717::x_sui::X_SUI>()
            };
            assert!(v2, 13906834419156779013);
            v0 = v0 + 1;
        };
    }

    fun pool_has_reward<T0>(arg0: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>) : bool {
        let v0 = 0;
        while (v0 < 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::reward_length<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg0)) {
            if (0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::reward_coin_type<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg0, v0) == 0x1::type_name::with_defining_ids<T0>()) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    public fun rlp(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg1: &mut 0xd4ae6ec0edf229ed93d33b9bef0a605aa6d15872e6f12fef85c12e8fa6a0a681::km::CKM, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xd4ae6ec0edf229ed93d33b9bef0a605aa6d15872e6f12fef85c12e8fa6a0a681::km::ab_stl<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(arg1, arg4, arg6);
        let (v1, v2) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::liquidity::remove_liquidity<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg0, &mut v0, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::liquidity(&v0), 0, 0, arg5, arg3, arg6);
        let v3 = v2;
        let v4 = v1;
        let (v5, v6) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::collect::fee<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg0, &mut v0, arg5, arg3, arg6);
        let v7 = v6;
        let v8 = v5;
        let v9 = LR{
            pk : arg4,
            sl : 0x2::coin::value<0x2::sui::SUI>(&v4),
            ul : 0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&v3),
            sf : 0x2::coin::value<0x2::sui::SUI>(&v8),
            uf : 0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&v7),
        };
        0x2::event::emit<LR>(v9);
        0x2::coin::join<0x2::sui::SUI>(&mut v4, v8);
        0x2::coin::join<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut v3, v7);
        if (pool_has_reward<0x2::sui::SUI>(arg0)) {
            let v10 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::collect::reward<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>(arg0, &mut v0, arg5, arg3, arg6);
            let v11 = 0x2::coin::value<0x2::sui::SUI>(&v10);
            if (v11 > 0) {
                let v12 = RC{
                    pk : arg4,
                    rt : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<0x2::sui::SUI>()),
                    a  : v11,
                };
                0x2::event::emit<RC>(v12);
            };
            0x2::coin::join<0x2::sui::SUI>(&mut v4, v10);
        };
        if (pool_has_reward<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg0)) {
            let v13 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::collect::reward<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg0, &mut v0, arg5, arg3, arg6);
            let v14 = 0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&v13);
            if (v14 > 0) {
                let v15 = RC{
                    pk : arg4,
                    rt : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>()),
                    a  : v14,
                };
                0x2::event::emit<RC>(v15);
            };
            0x2::coin::join<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut v3, v13);
        };
        if (pool_has_reward<0x2b6602099970374cf58a2a1b9d96f005fccceb81e92eb059873baf420eb6c717::x_sui::X_SUI>(arg0)) {
            let v16 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::collect::reward<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2b6602099970374cf58a2a1b9d96f005fccceb81e92eb059873baf420eb6c717::x_sui::X_SUI>(arg0, &mut v0, arg5, arg3, arg6);
            let v17 = 0x2::coin::value<0x2b6602099970374cf58a2a1b9d96f005fccceb81e92eb059873baf420eb6c717::x_sui::X_SUI>(&v16);
            if (v17 > 0) {
                let v18 = RC{
                    pk : arg4,
                    rt : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<0x2b6602099970374cf58a2a1b9d96f005fccceb81e92eb059873baf420eb6c717::x_sui::X_SUI>()),
                    a  : v17,
                };
                0x2::event::emit<RC>(v18);
                0xd4ae6ec0edf229ed93d33b9bef0a605aa6d15872e6f12fef85c12e8fa6a0a681::km::ez_dbk<0x2b6602099970374cf58a2a1b9d96f005fccceb81e92eb059873baf420eb6c717::x_sui::X_SUI>(arg1, arg2, v16, arg6);
            } else {
                0x2::coin::destroy_zero<0x2b6602099970374cf58a2a1b9d96f005fccceb81e92eb059873baf420eb6c717::x_sui::X_SUI>(v16);
            };
        };
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::liquidity::close_position(v0, arg3, arg6);
        0xd4ae6ec0edf229ed93d33b9bef0a605aa6d15872e6f12fef85c12e8fa6a0a681::km::ez_dbk<0x2::sui::SUI>(arg1, arg2, v4, arg6);
        0xd4ae6ec0edf229ed93d33b9bef0a605aa6d15872e6f12fef85c12e8fa6a0a681::km::ez_dbk<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg1, arg2, v3, arg6);
    }

    // decompiled from Move bytecode v6
}

