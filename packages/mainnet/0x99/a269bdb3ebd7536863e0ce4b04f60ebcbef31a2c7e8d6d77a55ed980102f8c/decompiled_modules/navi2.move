module 0xe5f0d6754d60b48e51b98306e1216197fed169d6d70ef80673ae2d4839c6684b::navi2 {
    struct Session {
        debt: 0x1::type_name::TypeName,
        coll: 0x1::type_name::TypeName,
        debt_asset: u8,
        coll_asset: u8,
        user: address,
        cap: u64,
        min_profit: u64,
        liquidated: bool,
    }

    public fun begin<T0, T1>(arg0: &0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::config::Config, arg1: &0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::config::OperatorCap, arg2: 0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::freshness::FreshnessTicket, arg3: 0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::freshness::FreshnessTicket, arg4: 0xe5f0d6754d60b48e51b98306e1216197fed169d6d70ef80673ae2d4839c6684b::strike::NaviArgs, arg5: &0x2::clock::Clock, arg6: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg8: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>) : (u64, Session) {
        let v0 = pre<T0, T1>(arg0, arg1, arg2, arg3, &arg4, arg5, arg6, arg7, arg8);
        (v0, new_session<T0, T1>(0xe5f0d6754d60b48e51b98306e1216197fed169d6d70ef80673ae2d4839c6684b::strike::navi_debt_asset(&arg4), 0xe5f0d6754d60b48e51b98306e1216197fed169d6d70ef80673ae2d4839c6684b::strike::navi_coll_asset(&arg4), 0xe5f0d6754d60b48e51b98306e1216197fed169d6d70ef80673ae2d4839c6684b::strike::navi_user(&arg4), v0, 0xe5f0d6754d60b48e51b98306e1216197fed169d6d70ef80673ae2d4839c6684b::strike::navi_min_profit(&arg4)))
    }

    fun close(arg0: Session) : u64 {
        let Session {
            debt       : _,
            coll       : _,
            debt_asset : _,
            coll_asset : _,
            user       : _,
            cap        : _,
            min_profit : v6,
            liquidated : v7,
        } = arg0;
        assert!(v7, 132);
        v6
    }

    public fun finish<T0>(arg0: &0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::config::Config, arg1: Session, arg2: 0x2::balance::Balance<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::payout::settle<T0>(arg0, arg2, close(arg1), arg3);
    }

    fun liq<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: u8, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg5: 0x2::balance::Balance<T0>, arg6: u8, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg8: address, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg11: &mut 0x3::sui_system::SuiSystemState, arg12: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, 0x2::balance::Balance<T0>) {
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::liquidation_v2<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12)
    }

    public fun liquidate<T0, T1>(arg0: &mut Session, arg1: &0x2::clock::Clock, arg2: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg5: 0x2::balance::Balance<T0>, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg9: &mut 0x3::sui_system::SuiSystemState, arg10: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, 0x2::balance::Balance<T0>) {
        mark_liquidated<T0, T1>(arg0, 0x2::balance::value<T0>(&arg5));
        liq<T0, T1>(arg1, arg2, arg3, arg0.debt_asset, arg4, arg5, arg0.coll_asset, arg6, arg0.user, arg7, arg8, arg9, arg10)
    }

    fun mark_liquidated<T0, T1>(arg0: &mut Session, arg1: u64) {
        assert!(arg0.debt == 0x1::type_name::with_defining_ids<T0>() && arg0.coll == 0x1::type_name::with_defining_ids<T1>(), 130);
        assert!(!arg0.liquidated, 131);
        assert!(arg1 > 0 && arg1 <= arg0.cap, 133);
        arg0.liquidated = true;
    }

    public fun navi2_bluefin_cd<T0, T1>(arg0: &0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::config::Config, arg1: &0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::config::OperatorCap, arg2: 0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::freshness::FreshnessTicket, arg3: 0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::freshness::FreshnessTicket, arg4: 0xe5f0d6754d60b48e51b98306e1216197fed169d6d70ef80673ae2d4839c6684b::strike::NaviArgs, arg5: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg11: &mut 0x3::sui_system::SuiSystemState, arg12: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg13: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg14: u128, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) {
        let v0 = pre<T1, T0>(arg0, arg1, arg2, arg3, &arg4, arg15, arg5, arg6, arg7);
        let (v1, v2, v3) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, T1>(arg15, arg12, arg13, true, false, v0, arg14);
        let v4 = v3;
        let (v5, v6) = liq<T1, T0>(arg15, arg5, arg6, 0xe5f0d6754d60b48e51b98306e1216197fed169d6d70ef80673ae2d4839c6684b::strike::navi_debt_asset(&arg4), arg7, v2, 0xe5f0d6754d60b48e51b98306e1216197fed169d6d70ef80673ae2d4839c6684b::strike::navi_coll_asset(&arg4), arg8, 0xe5f0d6754d60b48e51b98306e1216197fed169d6d70ef80673ae2d4839c6684b::strike::navi_user(&arg4), arg9, arg10, arg11, arg16);
        let v7 = settle_owed<T0, T1>(arg0, v5, v6, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T0, T1>(&v4), 0xe5f0d6754d60b48e51b98306e1216197fed169d6d70ef80673ae2d4839c6684b::strike::navi_min_profit(&arg4), arg16);
        0x2::balance::join<T0>(&mut v7, v1);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, T1>(arg12, arg13, v7, 0x2::balance::zero<T1>(), v4);
    }

    public fun navi2_bluefin_dc<T0, T1>(arg0: &0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::config::Config, arg1: &0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::config::OperatorCap, arg2: 0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::freshness::FreshnessTicket, arg3: 0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::freshness::FreshnessTicket, arg4: 0xe5f0d6754d60b48e51b98306e1216197fed169d6d70ef80673ae2d4839c6684b::strike::NaviArgs, arg5: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg11: &mut 0x3::sui_system::SuiSystemState, arg12: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg13: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T0>, arg14: u128, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) {
        let v0 = pre<T1, T0>(arg0, arg1, arg2, arg3, &arg4, arg15, arg5, arg6, arg7);
        let (v1, v2, v3) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T1, T0>(arg15, arg12, arg13, false, false, v0, arg14);
        let v4 = v3;
        let (v5, v6) = liq<T1, T0>(arg15, arg5, arg6, 0xe5f0d6754d60b48e51b98306e1216197fed169d6d70ef80673ae2d4839c6684b::strike::navi_debt_asset(&arg4), arg7, v1, 0xe5f0d6754d60b48e51b98306e1216197fed169d6d70ef80673ae2d4839c6684b::strike::navi_coll_asset(&arg4), arg8, 0xe5f0d6754d60b48e51b98306e1216197fed169d6d70ef80673ae2d4839c6684b::strike::navi_user(&arg4), arg9, arg10, arg11, arg16);
        let v7 = settle_owed<T0, T1>(arg0, v5, v6, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T1, T0>(&v4), 0xe5f0d6754d60b48e51b98306e1216197fed169d6d70ef80673ae2d4839c6684b::strike::navi_min_profit(&arg4), arg16);
        0x2::balance::join<T0>(&mut v7, v2);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T1, T0>(arg12, arg13, 0x2::balance::zero<T1>(), v7, v4);
    }

    public fun navi2_cetus_cd<T0, T1>(arg0: &0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::config::Config, arg1: &0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::config::OperatorCap, arg2: 0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::freshness::FreshnessTicket, arg3: 0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::freshness::FreshnessTicket, arg4: 0xe5f0d6754d60b48e51b98306e1216197fed169d6d70ef80673ae2d4839c6684b::strike::NaviArgs, arg5: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg11: &mut 0x3::sui_system::SuiSystemState, arg12: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg13: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg14: u128, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) {
        let v0 = pre<T1, T0>(arg0, arg1, arg2, arg3, &arg4, arg15, arg5, arg6, arg7);
        let (v1, v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg12, arg13, true, false, v0, arg14, arg15);
        let v4 = v3;
        let (v5, v6) = liq<T1, T0>(arg15, arg5, arg6, 0xe5f0d6754d60b48e51b98306e1216197fed169d6d70ef80673ae2d4839c6684b::strike::navi_debt_asset(&arg4), arg7, v2, 0xe5f0d6754d60b48e51b98306e1216197fed169d6d70ef80673ae2d4839c6684b::strike::navi_coll_asset(&arg4), arg8, 0xe5f0d6754d60b48e51b98306e1216197fed169d6d70ef80673ae2d4839c6684b::strike::navi_user(&arg4), arg9, arg10, arg11, arg16);
        let v7 = settle_owed<T0, T1>(arg0, v5, v6, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v4), 0xe5f0d6754d60b48e51b98306e1216197fed169d6d70ef80673ae2d4839c6684b::strike::navi_min_profit(&arg4), arg16);
        0x2::balance::join<T0>(&mut v7, v1);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg12, arg13, v7, 0x2::balance::zero<T1>(), v4);
    }

    public fun navi2_cetus_dc<T0, T1>(arg0: &0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::config::Config, arg1: &0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::config::OperatorCap, arg2: 0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::freshness::FreshnessTicket, arg3: 0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::freshness::FreshnessTicket, arg4: 0xe5f0d6754d60b48e51b98306e1216197fed169d6d70ef80673ae2d4839c6684b::strike::NaviArgs, arg5: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg11: &mut 0x3::sui_system::SuiSystemState, arg12: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg13: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T0>, arg14: u128, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) {
        let v0 = pre<T1, T0>(arg0, arg1, arg2, arg3, &arg4, arg15, arg5, arg6, arg7);
        let (v1, v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T1, T0>(arg12, arg13, false, false, v0, arg14, arg15);
        let v4 = v3;
        let (v5, v6) = liq<T1, T0>(arg15, arg5, arg6, 0xe5f0d6754d60b48e51b98306e1216197fed169d6d70ef80673ae2d4839c6684b::strike::navi_debt_asset(&arg4), arg7, v1, 0xe5f0d6754d60b48e51b98306e1216197fed169d6d70ef80673ae2d4839c6684b::strike::navi_coll_asset(&arg4), arg8, 0xe5f0d6754d60b48e51b98306e1216197fed169d6d70ef80673ae2d4839c6684b::strike::navi_user(&arg4), arg9, arg10, arg11, arg16);
        let v7 = settle_owed<T0, T1>(arg0, v5, v6, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T1, T0>(&v4), 0xe5f0d6754d60b48e51b98306e1216197fed169d6d70ef80673ae2d4839c6684b::strike::navi_min_profit(&arg4), arg16);
        0x2::balance::join<T0>(&mut v7, v2);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T1, T0>(arg12, arg13, 0x2::balance::zero<T1>(), v7, v4);
    }

    fun new_session<T0, T1>(arg0: u8, arg1: u8, arg2: address, arg3: u64, arg4: u64) : Session {
        Session{
            debt       : 0x1::type_name::with_defining_ids<T0>(),
            coll       : 0x1::type_name::with_defining_ids<T1>(),
            debt_asset : arg0,
            coll_asset : arg1,
            user       : arg2,
            cap        : arg3,
            min_profit : arg4,
            liquidated : false,
        }
    }

    fun pre<T0, T1>(arg0: &0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::config::Config, arg1: &0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::config::OperatorCap, arg2: 0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::freshness::FreshnessTicket, arg3: 0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::freshness::FreshnessTicket, arg4: &0xe5f0d6754d60b48e51b98306e1216197fed169d6d70ef80673ae2d4839c6684b::strike::NaviArgs, arg5: &0x2::clock::Clock, arg6: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg8: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>) : u64 {
        0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::config::assert_can_strike(arg0, arg1);
        0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::freshness::consume_pair<T0, T1>(arg0, arg2, arg3);
        0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::guard::require_deadline(arg5, 0xe5f0d6754d60b48e51b98306e1216197fed169d6d70ef80673ae2d4839c6684b::strike::navi_deadline_ms(arg4));
        0xe5f0d6754d60b48e51b98306e1216197fed169d6d70ef80673ae2d4839c6684b::proto::navi_guard<T0>(arg5, arg6, arg7, arg8, 0xe5f0d6754d60b48e51b98306e1216197fed169d6d70ef80673ae2d4839c6684b::strike::navi_debt_asset(arg4), 0xe5f0d6754d60b48e51b98306e1216197fed169d6d70ef80673ae2d4839c6684b::strike::navi_user(arg4), 0xe5f0d6754d60b48e51b98306e1216197fed169d6d70ef80673ae2d4839c6684b::strike::navi_min_debt(arg4), 0xe5f0d6754d60b48e51b98306e1216197fed169d6d70ef80673ae2d4839c6684b::strike::navi_max_repay(arg4))
    }

    public fun session_cap(arg0: &Session) : u64 {
        arg0.cap
    }

    fun settle_owed<T0, T1>(arg0: &0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::config::Config, arg1: 0x2::balance::Balance<T0>, arg2: 0x2::balance::Balance<T1>, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::guard::require_cover(0x2::balance::value<T0>(&arg1), arg3, arg4);
        0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::payout::pay<T0>(arg0, arg1, arg5);
        0x5f3f395eb3b80e2bfad9007175b020823d76b58cc97bdc50361aa4fcb423ca11::payout::pay<T1>(arg0, arg2, arg5);
        0x2::balance::split<T0>(&mut arg1, arg3)
    }

    // decompiled from Move bytecode v7
}

