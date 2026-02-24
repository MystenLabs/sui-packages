module 0x947f38d7f2dcf874202e0f76e5c6750045be91432f86174a4d4726462e3da88e::gme {
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

    public fun alp(arg0: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>, arg1: &mut 0xd4ae6ec0edf229ed93d33b9bef0a605aa6d15872e6f12fef85c12e8fa6a0a681::km::CKM, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg4: &0x2::clock::Clock, arg5: u32, arg6: u32, arg7: u64, arg8: bool, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) {
        if (0x2::clock::timestamp_ms(arg4) > arg9) {
            abort 13906834457811222529
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
        let v2 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::open_position<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>(arg3, arg0, arg5, arg6, arg11);
        let v3 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::add_liquidity_fix_coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>(arg3, arg0, &mut v2, v1, !arg8, arg4, arg11);
        let (v4, v5) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::add_liquidity_pay_amount<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>(&v3);
        0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::repay_add_liquidity<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>(arg3, arg0, 0x2::coin::into_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0xd4ae6ec0edf229ed93d33b9bef0a605aa6d15872e6f12fef85c12e8fa6a0a681::km::ab_dbk<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg1, arg2, v4, arg11)), 0x2::coin::into_balance<0x2::sui::SUI>(0xd4ae6ec0edf229ed93d33b9bef0a605aa6d15872e6f12fef85c12e8fa6a0a681::km::ab_dbk<0x2::sui::SUI>(arg1, arg2, v5, arg11)), v3);
        let v6 = LA{
            pk : arg10,
            tl : arg5,
            tu : arg6,
            sa : v5,
            ua : v4,
        };
        0x2::event::emit<LA>(v6);
        0xd4ae6ec0edf229ed93d33b9bef0a605aa6d15872e6f12fef85c12e8fa6a0a681::km::ez_stl<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::Position>(arg1, arg10, v2, arg11);
    }

    fun assert_known_rewards(arg0: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>) {
        let v0 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::rewarder::rewarders(0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::rewarder_manager<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>(arg0));
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::rewarder::Rewarder>(&v0)) {
            let v2 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::rewarder::reward_coin(0x1::vector::borrow<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::rewarder::Rewarder>(&v0, v1));
            assert!(v2 == 0x1::type_name::with_defining_ids<0x2::sui::SUI>() || v2 == 0x1::type_name::with_defining_ids<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(), 13906834337552269315);
            v1 = v1 + 1;
        };
    }

    public fun rlp(arg0: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>, arg1: &mut 0xd4ae6ec0edf229ed93d33b9bef0a605aa6d15872e6f12fef85c12e8fa6a0a681::km::CKM, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg3: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg4: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::rewarder::RewarderGlobalVault, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xd4ae6ec0edf229ed93d33b9bef0a605aa6d15872e6f12fef85c12e8fa6a0a681::km::ab_stl<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::Position>(arg1, arg5, arg7);
        let (v1, v2) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::remove_liquidity<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>(arg3, arg0, &mut v0, 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::position::liquidity(&v0), arg6);
        let v3 = v2;
        let v4 = v1;
        let (v5, v6) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::collect_fee<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>(arg3, arg0, &v0, false);
        let v7 = v6;
        let v8 = v5;
        let v9 = LR{
            pk : arg5,
            sl : 0x2::balance::value<0x2::sui::SUI>(&v3),
            ul : 0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&v4),
            sf : 0x2::balance::value<0x2::sui::SUI>(&v7),
            uf : 0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&v8),
        };
        0x2::event::emit<LR>(v9);
        0x2::balance::join<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut v4, v8);
        0x2::balance::join<0x2::sui::SUI>(&mut v3, v7);
        let v10 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::rewarder::rewarder_index<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::rewarder_manager<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>(arg0));
        if (0x1::option::is_some<u64>(&v10)) {
            let v11 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::collect_reward<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg3, arg0, &v0, arg4, false, arg6);
            let v12 = 0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&v11);
            if (v12 > 0) {
                let v13 = RC{
                    pk : arg5,
                    rt : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>()),
                    a  : v12,
                };
                0x2::event::emit<RC>(v13);
            };
            0x2::balance::join<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut v4, v11);
        };
        let v14 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::rewarder::rewarder_index<0x2::sui::SUI>(0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::rewarder_manager<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>(arg0));
        if (0x1::option::is_some<u64>(&v14)) {
            let v15 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::collect_reward<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI, 0x2::sui::SUI>(arg3, arg0, &v0, arg4, false, arg6);
            let v16 = 0x2::balance::value<0x2::sui::SUI>(&v15);
            if (v16 > 0) {
                let v17 = RC{
                    pk : arg5,
                    rt : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<0x2::sui::SUI>()),
                    a  : v16,
                };
                0x2::event::emit<RC>(v17);
            };
            0x2::balance::join<0x2::sui::SUI>(&mut v3, v15);
        };
        0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::close_position<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, 0x2::sui::SUI>(arg3, arg0, v0);
        0xd4ae6ec0edf229ed93d33b9bef0a605aa6d15872e6f12fef85c12e8fa6a0a681::km::ez_dbk<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg1, arg2, 0x2::coin::from_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v4, arg7), arg7);
        0xd4ae6ec0edf229ed93d33b9bef0a605aa6d15872e6f12fef85c12e8fa6a0a681::km::ez_dbk<0x2::sui::SUI>(arg1, arg2, 0x2::coin::from_balance<0x2::sui::SUI>(v3, arg7), arg7);
    }

    // decompiled from Move bytecode v6
}

