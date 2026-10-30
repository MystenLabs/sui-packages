module 0x9554bc7daa13f61008966e5491285979ea462812bdac6b29f3e21832a7bbcd1c::navi5 {
    struct Paid has copy, drop {
        coin: 0x1::type_name::TypeName,
        amount: u64,
        recipient: address,
    }

    public fun early_navi<T0>(arg0: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg1: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg2: u8, arg3: address, arg4: u64) {
        race_check(0x9554bc7daa13f61008966e5491285979ea462812bdac6b29f3e21832a7bbcd1c::proto::navi_debt<T0>(arg0, arg1, arg2, arg3), arg4);
    }

    public fun early_navi_health<T0>(arg0: &0x2::clock::Clock, arg1: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg4: u8, arg5: address, arg6: u64) {
        race_check(0x9554bc7daa13f61008966e5491285979ea462812bdac6b29f3e21832a7bbcd1c::proto::navi_debt<T0>(arg2, arg3, arg4, arg5), arg6);
        health_check(0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::is_health(arg0, arg1, arg2, arg5));
    }

    fun health_check(arg0: bool) {
        assert!(!arg0, 151);
    }

    public fun navi5_ownfunds_ab<T0, T1>(arg0: &0xe81cbcc6c8d4f5e03c0039d5054cedf23957ef1508a445a7606c557f53b39533::config::Config, arg1: &0xe81cbcc6c8d4f5e03c0039d5054cedf23957ef1508a445a7606c557f53b39533::config::OperatorCap, arg2: 0x9554bc7daa13f61008966e5491285979ea462812bdac6b29f3e21832a7bbcd1c::strike::NaviArgs, arg3: u8, arg4: u8, arg5: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg11: &mut 0x3::sui_system::SuiSystemState, arg12: 0x2::funds_accumulator::Withdrawal<0x2::balance::Balance<T0>>, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        0xe81cbcc6c8d4f5e03c0039d5054cedf23957ef1508a445a7606c557f53b39533::config::assert_can_strike(arg0, arg1);
        race_check(0x9554bc7daa13f61008966e5491285979ea462812bdac6b29f3e21832a7bbcd1c::proto::navi_debt<T0>(arg6, arg7, 0x9554bc7daa13f61008966e5491285979ea462812bdac6b29f3e21832a7bbcd1c::strike::navi_debt_asset(&arg2), 0x9554bc7daa13f61008966e5491285979ea462812bdac6b29f3e21832a7bbcd1c::strike::navi_user(&arg2)), 0x9554bc7daa13f61008966e5491285979ea462812bdac6b29f3e21832a7bbcd1c::strike::navi_min_debt(&arg2));
        0xe81cbcc6c8d4f5e03c0039d5054cedf23957ef1508a445a7606c557f53b39533::guard::require_deadline(arg13, 0x9554bc7daa13f61008966e5491285979ea462812bdac6b29f3e21832a7bbcd1c::strike::navi_deadline_ms(&arg2));
        0x9554bc7daa13f61008966e5491285979ea462812bdac6b29f3e21832a7bbcd1c::navi3::require_navi_fresh(arg13, arg5, arg3, arg4);
        let v0 = 0x2::balance::redeem_funds<T0>(arg12);
        pay_ab<T0>(arg0, v0);
        let (v1, v2) = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::liquidation_v2<T0, T1>(arg13, arg5, arg6, 0x9554bc7daa13f61008966e5491285979ea462812bdac6b29f3e21832a7bbcd1c::strike::navi_debt_asset(&arg2), arg7, 0x2::balance::split<T0>(&mut v0, repay_size(0x2::balance::value<T0>(&v0), 0x9554bc7daa13f61008966e5491285979ea462812bdac6b29f3e21832a7bbcd1c::proto::navi_guard<T0>(arg13, arg5, arg6, arg7, 0x9554bc7daa13f61008966e5491285979ea462812bdac6b29f3e21832a7bbcd1c::strike::navi_debt_asset(&arg2), 0x9554bc7daa13f61008966e5491285979ea462812bdac6b29f3e21832a7bbcd1c::strike::navi_user(&arg2), 0x9554bc7daa13f61008966e5491285979ea462812bdac6b29f3e21832a7bbcd1c::strike::navi_min_debt(&arg2), 0x9554bc7daa13f61008966e5491285979ea462812bdac6b29f3e21832a7bbcd1c::strike::navi_max_repay(&arg2)))), 0x9554bc7daa13f61008966e5491285979ea462812bdac6b29f3e21832a7bbcd1c::strike::navi_coll_asset(&arg2), arg8, 0x9554bc7daa13f61008966e5491285979ea462812bdac6b29f3e21832a7bbcd1c::strike::navi_user(&arg2), arg9, arg10, arg11, arg14);
        let v3 = v1;
        pay_ab<T0>(arg0, v2);
        0xe81cbcc6c8d4f5e03c0039d5054cedf23957ef1508a445a7606c557f53b39533::guard::require_min_profit<T1>(&v3, 0x9554bc7daa13f61008966e5491285979ea462812bdac6b29f3e21832a7bbcd1c::strike::navi_min_profit(&arg2));
        pay_ab<T1>(arg0, v3);
    }

    public fun pay_ab<T0>(arg0: &0xe81cbcc6c8d4f5e03c0039d5054cedf23957ef1508a445a7606c557f53b39533::config::Config, arg1: 0x2::balance::Balance<T0>) {
        let v0 = 0x2::balance::value<T0>(&arg1);
        if (v0 == 0) {
            0x2::balance::destroy_zero<T0>(arg1);
            return
        };
        let v1 = 0xe81cbcc6c8d4f5e03c0039d5054cedf23957ef1508a445a7606c557f53b39533::config::recipient(arg0);
        let v2 = Paid{
            coin      : 0x1::type_name::with_defining_ids<T0>(),
            amount    : v0,
            recipient : v1,
        };
        0x2::event::emit<Paid>(v2);
        0x2::balance::send_funds<T0>(arg1, v1);
    }

    fun race_check(arg0: u64, arg1: u64) {
        let v0 = if (arg1 == 0) {
            1
        } else {
            arg1
        };
        assert!(arg0 >= v0, 150);
    }

    fun repay_size(arg0: u64, arg1: u64) : u64 {
        let v0 = if (arg0 < arg1) {
            arg0
        } else {
            arg1
        };
        assert!(v0 > 0, 152);
        v0
    }

    public fun tidy_coin<T0>(arg0: &0xe81cbcc6c8d4f5e03c0039d5054cedf23957ef1508a445a7606c557f53b39533::config::Config, arg1: 0x2::coin::Coin<T0>) {
        pay_ab<T0>(arg0, 0x2::coin::into_balance<T0>(arg1));
    }

    // decompiled from Move bytecode v7
}

