module 0x94d6ef0a563955eb3cca10752e7dda02729b6d3d5f11493d5c1e5971e9bde2af::ferra_lp_provider {
    struct FerraLp has drop {
        dummy_field: bool,
    }

    struct FerraLpProvider has key {
        id: 0x2::object::UID,
        abstract_account: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::Account,
        managers: 0x2::vec_set::VecSet<address>,
        positions: vector<0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_position::LBPosition>,
    }

    fun account_req_opt(arg0: &FerraLpProvider) : 0x1::option::Option<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::AccountRequest> {
        0x1::option::some<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::AccountRequest>(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::request_with_account(&arg0.abstract_account))
    }

    public fun add_manager(arg0: &mut FerraLpProvider, arg1: &0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::admin::AdminCap, arg2: address) {
        0x2::vec_set::insert<address>(&mut arg0.managers, arg2);
    }

    public fun add_usdb_a_liquidity<T0>(arg0: &mut FerraLpProvider, arg1: &0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::config::GlobalConfig, arg2: &mut 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::LBPair<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB, T0>, arg3: vector<u32>, arg4: vector<u64>, arg5: vector<u64>, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::Treasury, arg10: &mut 0xc2ae6693383e4a81285136effc8190c7baaf0e75aafa36d1c69cd2170cfc3803::pool::Pool<T0>, arg11: &0xf2ab9aa60c5e879675351a1a89f47131de9dea7cc927327dd0e7282e295c7f5e::result::PriceResult<T0>, arg12: &mut 0x2::tx_context::TxContext) {
        assert_sender_is_manager(arg0, arg12);
        let v0 = account_req_opt(arg0);
        let v1 = try_get_position_idx<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB, T0>(arg0, arg2);
        let v2 = if (0x1::option::is_some<u64>(&v1)) {
            0x1::vector::borrow_mut<0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_position::LBPosition>(&mut arg0.positions, 0x1::option::destroy_some<u64>(v1))
        } else {
            0x1::vector::push_back<0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_position::LBPosition>(&mut arg0.positions, 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::open_position<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB, T0>(arg1, arg2, arg12));
            0x1::vector::borrow_mut<0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_position::LBPosition>(&mut arg0.positions, 0x1::vector::length<0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_position::LBPosition>(&arg0.positions))
        };
        let v3 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::floor(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::mul(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::from(arg7), 0xc2ae6693383e4a81285136effc8190c7baaf0e75aafa36d1c69cd2170cfc3803::pool::conversion_rate<T0>(arg10)));
        let v4 = FerraLp{dummy_field: false};
        let v5 = 0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::mint<FerraLp>(arg9, v4, package_version(), arg6 + v3, arg12);
        let (v6, v7) = 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::add_liquidity_return_left_coin<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB, T0>(arg1, arg2, v2, arg3, arg4, arg5, v5, 0xc2ae6693383e4a81285136effc8190c7baaf0e75aafa36d1c69cd2170cfc3803::pool::swap_out<T0>(arg10, arg9, arg11, 0x2::coin::split<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>(&mut v5, v3, arg12), &v0, arg12), 0, 0, arg8, arg12);
        let v8 = v6;
        0x2::coin::join<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>(&mut v8, 0xc2ae6693383e4a81285136effc8190c7baaf0e75aafa36d1c69cd2170cfc3803::pool::swap_in<T0>(arg10, arg9, arg11, v7, &v0, arg12));
        let v9 = FerraLp{dummy_field: false};
        0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::burn<FerraLp>(arg9, v9, package_version(), v8);
    }

    public fun add_usdb_b_liquidity<T0>(arg0: &mut FerraLpProvider, arg1: &0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::config::GlobalConfig, arg2: &mut 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::LBPair<T0, 0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>, arg3: vector<u32>, arg4: vector<u64>, arg5: vector<u64>, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::Treasury, arg10: &mut 0xc2ae6693383e4a81285136effc8190c7baaf0e75aafa36d1c69cd2170cfc3803::pool::Pool<T0>, arg11: &0xf2ab9aa60c5e879675351a1a89f47131de9dea7cc927327dd0e7282e295c7f5e::result::PriceResult<T0>, arg12: &mut 0x2::tx_context::TxContext) {
        assert_sender_is_manager(arg0, arg12);
        let v0 = account_req_opt(arg0);
        let v1 = try_get_position_idx<T0, 0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>(arg0, arg2);
        let v2 = if (0x1::option::is_some<u64>(&v1)) {
            0x1::vector::borrow_mut<0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_position::LBPosition>(&mut arg0.positions, 0x1::option::destroy_some<u64>(v1))
        } else {
            0x1::vector::push_back<0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_position::LBPosition>(&mut arg0.positions, 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::open_position<T0, 0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>(arg1, arg2, arg12));
            0x1::vector::borrow_mut<0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_position::LBPosition>(&mut arg0.positions, 0x1::vector::length<0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_position::LBPosition>(&arg0.positions))
        };
        let v3 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::floor(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::mul(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::from(arg6), 0xc2ae6693383e4a81285136effc8190c7baaf0e75aafa36d1c69cd2170cfc3803::pool::conversion_rate<T0>(arg10)));
        let v4 = FerraLp{dummy_field: false};
        let v5 = 0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::mint<FerraLp>(arg9, v4, package_version(), arg7 + v3, arg12);
        let (v6, v7) = 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::add_liquidity_return_left_coin<T0, 0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>(arg1, arg2, v2, arg3, arg4, arg5, 0xc2ae6693383e4a81285136effc8190c7baaf0e75aafa36d1c69cd2170cfc3803::pool::swap_out<T0>(arg10, arg9, arg11, 0x2::coin::split<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>(&mut v5, v3, arg12), &v0, arg12), v5, 0, 0, arg8, arg12);
        let v8 = v7;
        0x2::coin::join<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>(&mut v8, 0xc2ae6693383e4a81285136effc8190c7baaf0e75aafa36d1c69cd2170cfc3803::pool::swap_in<T0>(arg10, arg9, arg11, v6, &v0, arg12));
        let v9 = FerraLp{dummy_field: false};
        0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::burn<FerraLp>(arg9, v9, package_version(), v8);
    }

    public fun assert_sender_is_manager(arg0: &mut FerraLpProvider, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        if (!0x2::vec_set::contains<address>(&arg0.managers, &v0)) {
            err_sender_is_not_manager();
        };
    }

    public fun burn_usdb(arg0: &mut 0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::Treasury, arg1: 0x2::coin::Coin<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>) {
        0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::assert_valid_module_version<FerraLp>(arg0, package_version());
        let v0 = FerraLp{dummy_field: false};
        0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::burn<FerraLp>(arg0, v0, package_version(), arg1);
    }

    public fun claim_fees<T0, T1>(arg0: &mut FerraLpProvider, arg1: &0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::config::GlobalConfig, arg2: &mut 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::LBPair<T0, T1>, arg3: vector<u32>, arg4: &mut 0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::Treasury, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = try_get_position_idx<T0, T1>(arg0, arg2);
        if (0x1::option::is_none<u64>(&v0)) {
            return
        };
        let (v1, v2) = 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::collect_position_fees<T0, T1>(arg1, arg2, 0x1::vector::borrow_mut<0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_position::LBPosition>(&mut arg0.positions, 0x1::option::destroy_some<u64>(v0)), arg3, arg5);
        let v3 = FerraLp{dummy_field: false};
        0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::collect<T0, FerraLp>(arg4, v3, 0x1::string::utf8(b"swap_fee"), 0x2::coin::into_balance<T0>(v1));
        let v4 = FerraLp{dummy_field: false};
        0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::collect<T1, FerraLp>(arg4, v4, 0x1::string::utf8(b"swap_fee"), 0x2::coin::into_balance<T1>(v2));
    }

    public fun claim_fees_and_rewards<T0, T1, T2>(arg0: &mut FerraLpProvider, arg1: &0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::config::GlobalConfig, arg2: &mut 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::LBPair<T0, T1>, arg3: vector<u32>, arg4: &mut 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::rewarder::RewarderGlobalVault, arg5: &0x2::clock::Clock, arg6: &mut 0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::Treasury, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = try_get_position_idx<T0, T1>(arg0, arg2);
        if (0x1::option::is_none<u64>(&v0)) {
            return
        };
        let v1 = 0x1::vector::borrow_mut<0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_position::LBPosition>(&mut arg0.positions, 0x1::option::destroy_some<u64>(v0));
        let (v2, v3) = 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::collect_position_fees<T0, T1>(arg1, arg2, v1, arg3, arg7);
        let v4 = FerraLp{dummy_field: false};
        0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::collect<T0, FerraLp>(arg6, v4, 0x1::string::utf8(b"swap_fee"), 0x2::coin::into_balance<T0>(v2));
        let v5 = FerraLp{dummy_field: false};
        0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::collect<T1, FerraLp>(arg6, v5, 0x1::string::utf8(b"swap_fee"), 0x2::coin::into_balance<T1>(v3));
        let v6 = FerraLp{dummy_field: false};
        0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::collect<T2, FerraLp>(arg6, v6, 0x1::string::utf8(b"incentive_reward"), 0x2::coin::into_balance<T2>(0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::collect_position_rewards<T0, T1, T2>(arg1, arg2, arg3, v1, arg4, arg5, arg7)));
    }

    fun err_position_not_exists() {
        abort 2
    }

    fun err_sender_is_not_manager() {
        abort 1
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = FerraLpProvider{
            id               : 0x2::object::new(arg0),
            abstract_account : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::new(0x1::option::some<0x1::string::String>(0x1::string::utf8(b"")), arg0),
            managers         : 0x2::vec_set::singleton<address>(0x2::tx_context::sender(arg0)),
            positions        : 0x1::vector::empty<0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_position::LBPosition>(),
        };
        0x2::transfer::share_object<FerraLpProvider>(v0);
    }

    public fun package_version() : u16 {
        1
    }

    public fun remove_manager(arg0: &mut FerraLpProvider, arg1: &0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::admin::AdminCap, arg2: address) {
        0x2::vec_set::remove<address>(&mut arg0.managers, &arg2);
    }

    public fun remove_usdb_a_liquidity<T0>(arg0: &mut FerraLpProvider, arg1: &0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::config::GlobalConfig, arg2: &mut 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::LBPair<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB, T0>, arg3: vector<u32>, arg4: &0x2::clock::Clock, arg5: &mut 0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::Treasury, arg6: &mut 0xc2ae6693383e4a81285136effc8190c7baaf0e75aafa36d1c69cd2170cfc3803::pool::Pool<T0>, arg7: &0xf2ab9aa60c5e879675351a1a89f47131de9dea7cc927327dd0e7282e295c7f5e::result::PriceResult<T0>, arg8: &mut 0x2::tx_context::TxContext) {
        assert_sender_is_manager(arg0, arg8);
        let v0 = try_get_position_idx<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB, T0>(arg0, arg2);
        if (0x1::option::is_none<u64>(&v0)) {
            err_position_not_exists();
        };
        let (v1, v2) = 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::remove_liquidity<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB, T0>(arg1, arg2, 0x1::vector::borrow_mut<0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_position::LBPosition>(&mut arg0.positions, 0x1::option::destroy_some<u64>(v0)), arg3, 0, 0, arg4, arg8);
        let v3 = account_req_opt(arg0);
        let v4 = 0xc2ae6693383e4a81285136effc8190c7baaf0e75aafa36d1c69cd2170cfc3803::pool::swap_in<T0>(arg6, arg5, arg7, v2, &v3, arg8);
        0x2::coin::join<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>(&mut v4, v1);
        let v5 = 0x1::type_name::with_defining_ids<FerraLp>();
        let v6 = 0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::limited_supply::supply(0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::limited_supply(0x2::vec_map::get<0x1::type_name::TypeName, 0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::ModuleConfig>(0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::module_config_map(arg5), &v5)));
        if (0x2::coin::value<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>(&v4) > v6) {
            let v7 = FerraLp{dummy_field: false};
            0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::collect<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB, FerraLp>(arg5, v7, 0x1::string::utf8(b"unbalance"), 0x2::balance::split<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>(0x2::coin::balance_mut<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>(&mut v4), 0x2::coin::value<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>(&v4) - v6));
        };
        let v8 = FerraLp{dummy_field: false};
        0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::burn<FerraLp>(arg5, v8, package_version(), v4);
    }

    public fun remove_usdb_b_liquidity<T0>(arg0: &mut FerraLpProvider, arg1: &0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::config::GlobalConfig, arg2: &mut 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::LBPair<T0, 0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>, arg3: vector<u32>, arg4: &0x2::clock::Clock, arg5: &mut 0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::Treasury, arg6: &mut 0xc2ae6693383e4a81285136effc8190c7baaf0e75aafa36d1c69cd2170cfc3803::pool::Pool<T0>, arg7: &0xf2ab9aa60c5e879675351a1a89f47131de9dea7cc927327dd0e7282e295c7f5e::result::PriceResult<T0>, arg8: &mut 0x2::tx_context::TxContext) {
        assert_sender_is_manager(arg0, arg8);
        let v0 = try_get_position_idx<T0, 0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>(arg0, arg2);
        if (0x1::option::is_none<u64>(&v0)) {
            err_position_not_exists();
        };
        let (v1, v2) = 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::remove_liquidity<T0, 0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>(arg1, arg2, 0x1::vector::borrow_mut<0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_position::LBPosition>(&mut arg0.positions, 0x1::option::destroy_some<u64>(v0)), arg3, 0, 0, arg4, arg8);
        let v3 = account_req_opt(arg0);
        let v4 = 0xc2ae6693383e4a81285136effc8190c7baaf0e75aafa36d1c69cd2170cfc3803::pool::swap_in<T0>(arg6, arg5, arg7, v1, &v3, arg8);
        0x2::coin::join<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>(&mut v4, v2);
        let v5 = 0x1::type_name::with_defining_ids<FerraLp>();
        let v6 = 0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::limited_supply::supply(0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::limited_supply(0x2::vec_map::get<0x1::type_name::TypeName, 0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::ModuleConfig>(0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::module_config_map(arg5), &v5)));
        if (0x2::coin::value<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>(&v4) > v6) {
            let v7 = FerraLp{dummy_field: false};
            0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::collect<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB, FerraLp>(arg5, v7, 0x1::string::utf8(b"unbalance"), 0x2::balance::split<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>(0x2::coin::balance_mut<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>(&mut v4), 0x2::coin::value<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>(&v4) - v6));
        };
        let v8 = FerraLp{dummy_field: false};
        0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::burn<FerraLp>(arg5, v8, package_version(), v4);
    }

    public fun try_get_position_idx<T0, T1>(arg0: &FerraLpProvider, arg1: &0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::LBPair<T0, T1>) : 0x1::option::Option<u64> {
        let v0 = &arg0.positions;
        let v1 = 0;
        let v2;
        while (v1 < 0x1::vector::length<0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_position::LBPosition>(v0)) {
            if (0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_position::pair_id(0x1::vector::borrow<0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_position::LBPosition>(v0, v1)) == 0x2::object::id<0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::LBPair<T0, T1>>(arg1)) {
                v2 = 0x1::option::some<u64>(v1);
                return v2
            };
            v1 = v1 + 1;
        };
        v2 = 0x1::option::none<u64>();
        v2
    }

    // decompiled from Move bytecode v6
}

