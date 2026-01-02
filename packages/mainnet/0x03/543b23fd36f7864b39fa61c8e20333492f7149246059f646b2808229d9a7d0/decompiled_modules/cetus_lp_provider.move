module 0xb9204c991f982e4ec53dd9161ed56ff837716c81861929853e894d77eec71bea::cetus_lp_provider {
    struct CetusLp has drop {
        dummy_field: bool,
    }

    struct CetusLpProvider has key {
        id: 0x2::object::UID,
        abstract_account: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::Account,
        managers: 0x2::vec_set::VecSet<address>,
        usdb_a_positions: vector<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>,
        usdb_b_positions: vector<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>,
    }

    fun account_req_opt(arg0: &CetusLpProvider) : 0x1::option::Option<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::AccountRequest> {
        0x1::option::some<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::AccountRequest>(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::request_with_account(&arg0.abstract_account))
    }

    public fun add_manager(arg0: &mut CetusLpProvider, arg1: &0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::admin::AdminCap, arg2: address) {
        0x2::vec_set::insert<address>(&mut arg0.managers, arg2);
    }

    public fun add_usdb_a_liquidity<T0>(arg0: &mut CetusLpProvider, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB, T0>, arg3: u32, arg4: u32, arg5: &0x2::clock::Clock, arg6: &mut 0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::Treasury, arg7: &mut 0xc2ae6693383e4a81285136effc8190c7baaf0e75aafa36d1c69cd2170cfc3803::pool::Pool<T0>, arg8: &0xf2ab9aa60c5e879675351a1a89f47131de9dea7cc927327dd0e7282e295c7f5e::result::PriceResult<T0>, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        assert_sender_is_manager(arg0, arg10);
        let v0 = true;
        let v1 = has_position<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB, T0>(arg0, arg2, arg3, arg4, v0);
        let v2 = if (0x1::option::is_some<u64>(&v1)) {
            0x1::vector::borrow_mut<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.usdb_a_positions, 0x1::option::destroy_some<u64>(v1))
        } else {
            0x1::vector::push_back<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.usdb_a_positions, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::open_position<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB, T0>(arg1, arg2, arg3, arg4, arg10));
            0x1::vector::borrow_mut<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.usdb_a_positions, 0x1::vector::length<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.usdb_a_positions))
        };
        let v3 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_fix_coin<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB, T0>(arg1, arg2, v2, arg9, !v0, arg5);
        let (v4, v5) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_pay_amount<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB, T0>(&v3);
        let v6 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::floor(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::mul(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::from(v5), 0xc2ae6693383e4a81285136effc8190c7baaf0e75aafa36d1c69cd2170cfc3803::pool::conversion_rate<T0>(arg7)));
        let v7 = CetusLp{dummy_field: false};
        let v8 = 0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::mint<CetusLp>(arg6, v7, package_version(), v4 + v6, arg10);
        let v9 = account_req_opt(arg0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_add_liquidity<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB, T0>(arg1, arg2, 0x2::coin::into_balance<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>(v8), 0x2::coin::into_balance<T0>(0xc2ae6693383e4a81285136effc8190c7baaf0e75aafa36d1c69cd2170cfc3803::pool::swap_out<T0>(arg7, arg6, arg8, 0x2::coin::split<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>(&mut v8, v6, arg10), &v9, arg10)), v3);
    }

    public fun add_usdb_b_liquidity<T0>(arg0: &mut CetusLpProvider, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>, arg3: u32, arg4: u32, arg5: &0x2::clock::Clock, arg6: &mut 0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::Treasury, arg7: &mut 0xc2ae6693383e4a81285136effc8190c7baaf0e75aafa36d1c69cd2170cfc3803::pool::Pool<T0>, arg8: &0xf2ab9aa60c5e879675351a1a89f47131de9dea7cc927327dd0e7282e295c7f5e::result::PriceResult<T0>, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        assert_sender_is_manager(arg0, arg10);
        let v0 = false;
        let v1 = has_position<T0, 0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>(arg0, arg2, arg3, arg4, v0);
        let v2 = if (0x1::option::is_some<u64>(&v1)) {
            0x1::vector::borrow_mut<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.usdb_b_positions, 0x1::option::destroy_some<u64>(v1))
        } else {
            0x1::vector::push_back<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.usdb_b_positions, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::open_position<T0, 0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>(arg1, arg2, arg3, arg4, arg10));
            0x1::vector::borrow_mut<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.usdb_b_positions, 0x1::vector::length<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&arg0.usdb_b_positions))
        };
        let v3 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_fix_coin<T0, 0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>(arg1, arg2, v2, arg9, !v0, arg5);
        let (v4, v5) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::add_liquidity_pay_amount<T0, 0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>(&v3);
        let v6 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::floor(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::mul(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::from(v5), 0xc2ae6693383e4a81285136effc8190c7baaf0e75aafa36d1c69cd2170cfc3803::pool::conversion_rate<T0>(arg7)));
        let v7 = CetusLp{dummy_field: false};
        let v8 = 0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::mint<CetusLp>(arg6, v7, package_version(), v4 + v6, arg10);
        let v9 = account_req_opt(arg0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_add_liquidity<T0, 0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>(arg1, arg2, 0x2::coin::into_balance<T0>(0xc2ae6693383e4a81285136effc8190c7baaf0e75aafa36d1c69cd2170cfc3803::pool::swap_out<T0>(arg7, arg6, arg8, 0x2::coin::split<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>(&mut v8, v6, arg10), &v9, arg10)), 0x2::coin::into_balance<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>(v8), v3);
    }

    public fun assert_sender_is_manager(arg0: &mut CetusLpProvider, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        if (!0x2::vec_set::contains<address>(&arg0.managers, &v0)) {
            err_sender_is_not_manager();
        };
    }

    public fun claim_fees<T0, T1>(arg0: &mut CetusLpProvider, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: u64, arg4: &mut 0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::Treasury) {
        let v0 = if (0x1::type_name::with_defining_ids<T0>() == 0x1::type_name::with_defining_ids<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>()) {
            0x1::vector::borrow_mut<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.usdb_a_positions, arg3)
        } else {
            0x1::vector::borrow_mut<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.usdb_b_positions, arg3)
        };
        let (v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_fee<T0, T1>(arg1, arg2, v0, true);
        let v3 = CetusLp{dummy_field: false};
        0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::collect<T0, CetusLp>(arg4, v3, fee_memo(), v1);
        let v4 = CetusLp{dummy_field: false};
        0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::collect<T1, CetusLp>(arg4, v4, fee_memo(), v2);
    }

    public fun claim_fees_and_rewards<T0, T1, T2>(arg0: &mut CetusLpProvider, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg4: &0x2::clock::Clock, arg5: u64, arg6: &mut 0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::Treasury) {
        let v0 = if (0x1::type_name::with_defining_ids<T0>() == 0x1::type_name::with_defining_ids<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>()) {
            0x1::vector::borrow_mut<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.usdb_a_positions, arg5)
        } else {
            0x1::vector::borrow_mut<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.usdb_b_positions, arg5)
        };
        let (v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_fee<T0, T1>(arg1, arg2, v0, true);
        let v3 = CetusLp{dummy_field: false};
        0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::collect<T0, CetusLp>(arg6, v3, fee_memo(), v1);
        let v4 = CetusLp{dummy_field: false};
        0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::collect<T1, CetusLp>(arg6, v4, fee_memo(), v2);
        let v5 = CetusLp{dummy_field: false};
        0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::collect<T2, CetusLp>(arg6, v5, fee_memo(), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_reward<T0, T1, T2>(arg1, arg2, v0, arg3, true, arg4));
    }

    public fun claim_rewards<T0, T1, T2>(arg0: &mut CetusLpProvider, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg4: &0x2::clock::Clock, arg5: u64, arg6: &mut 0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::Treasury) {
        let v0 = if (0x1::type_name::with_defining_ids<T0>() == 0x1::type_name::with_defining_ids<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>()) {
            0x1::vector::borrow_mut<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.usdb_a_positions, arg5)
        } else {
            0x1::vector::borrow_mut<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.usdb_b_positions, arg5)
        };
        let v1 = CetusLp{dummy_field: false};
        0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::collect<T2, CetusLp>(arg6, v1, fee_memo(), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::collect_reward<T0, T1, T2>(arg1, arg2, v0, arg3, true, arg4));
    }

    fun err_invalid_remove_ratio() {
        abort 2
    }

    fun err_sender_is_not_manager() {
        abort 1
    }

    fun fee_memo() : 0x1::string::String {
        fee_memo()
    }

    public fun has_position<T0, T1>(arg0: &CetusLpProvider, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: u32, arg3: u32, arg4: bool) : 0x1::option::Option<u64> {
        let v0 = if (arg4) {
            &arg0.usdb_a_positions
        } else {
            &arg0.usdb_b_positions
        };
        let v1 = 0;
        let v2;
        while (v1 < 0x1::vector::length<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(v0)) {
            let v3 = 0x1::vector::borrow<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(v0, v1);
            let (v4, v5) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::tick_range(v3);
            let v6 = if (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::pool_id(v3) == 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1)) {
                if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(v4) == arg2) {
                    0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(v5) == arg3
                } else {
                    false
                }
            } else {
                false
            };
            if (v6) {
                v2 = 0x1::option::some<u64>(v1);
                return v2
            };
            v1 = v1 + 1;
        };
        v2 = 0x1::option::none<u64>();
        v2
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = CetusLpProvider{
            id               : 0x2::object::new(arg0),
            abstract_account : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::new(0x1::option::some<0x1::string::String>(0x1::string::utf8(b"")), arg0),
            managers         : 0x2::vec_set::singleton<address>(0x2::tx_context::sender(arg0)),
            usdb_a_positions : 0x1::vector::empty<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(),
            usdb_b_positions : 0x1::vector::empty<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(),
        };
        0x2::transfer::share_object<CetusLpProvider>(v0);
    }

    public fun package_version() : u16 {
        5
    }

    public fun remove_manager(arg0: &mut CetusLpProvider, arg1: &0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::admin::AdminCap, arg2: address) {
        0x2::vec_set::remove<address>(&mut arg0.managers, &arg2);
    }

    public fun remove_usdb_a_liquidity<T0>(arg0: &mut CetusLpProvider, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB, T0>, arg3: &0x2::clock::Clock, arg4: u64, arg5: &mut 0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::Treasury, arg6: &mut 0xc2ae6693383e4a81285136effc8190c7baaf0e75aafa36d1c69cd2170cfc3803::pool::Pool<T0>, arg7: &0xf2ab9aa60c5e879675351a1a89f47131de9dea7cc927327dd0e7282e295c7f5e::result::PriceResult<T0>, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        assert_sender_is_manager(arg0, arg9);
        let v0 = 0x1::vector::borrow_mut<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.usdb_a_positions, arg4);
        if (arg8 > 100) {
            err_invalid_remove_ratio();
        };
        let (v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::remove_liquidity<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB, T0>(arg1, arg2, v0, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::mul_div_round(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(v0), (arg8 as u128), 100), arg3);
        if (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(v0) == 0) {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::close_position<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB, T0>(arg1, arg2, 0x1::vector::remove<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.usdb_a_positions, arg4));
        };
        let v3 = account_req_opt(arg0);
        let v4 = 0xc2ae6693383e4a81285136effc8190c7baaf0e75aafa36d1c69cd2170cfc3803::pool::swap_in<T0>(arg6, arg5, arg7, 0x2::coin::from_balance<T0>(v2, arg9), &v3, arg9);
        0x2::balance::join<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>(0x2::coin::balance_mut<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>(&mut v4), v1);
        let v5 = 0x1::type_name::with_defining_ids<CetusLp>();
        let v6 = 0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::limited_supply::supply(0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::limited_supply(0x2::vec_map::get<0x1::type_name::TypeName, 0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::ModuleConfig>(0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::module_config_map(arg5), &v5)));
        if (0x2::coin::value<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>(&v4) > v6) {
            let v7 = CetusLp{dummy_field: false};
            0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::collect<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB, CetusLp>(arg5, v7, fee_memo(), 0x2::balance::split<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>(0x2::coin::balance_mut<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>(&mut v4), 0x2::coin::value<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>(&v4) - v6));
        };
        let v8 = CetusLp{dummy_field: false};
        0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::burn<CetusLp>(arg5, v8, package_version(), v4);
    }

    public fun remove_usdb_b_liquidity<T0>(arg0: &mut CetusLpProvider, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>, arg3: &0x2::clock::Clock, arg4: u64, arg5: &mut 0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::Treasury, arg6: &mut 0xc2ae6693383e4a81285136effc8190c7baaf0e75aafa36d1c69cd2170cfc3803::pool::Pool<T0>, arg7: &0xf2ab9aa60c5e879675351a1a89f47131de9dea7cc927327dd0e7282e295c7f5e::result::PriceResult<T0>, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        assert_sender_is_manager(arg0, arg9);
        let v0 = 0x1::vector::borrow_mut<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.usdb_b_positions, arg4);
        if (arg8 > 100) {
            err_invalid_remove_ratio();
        };
        let (v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::remove_liquidity<T0, 0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>(arg1, arg2, v0, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::mul_div_round(0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(v0), (arg8 as u128), 100), arg3);
        if (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::liquidity(v0) == 0) {
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::close_position<T0, 0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>(arg1, arg2, 0x1::vector::remove<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(&mut arg0.usdb_b_positions, arg4));
        };
        let v3 = account_req_opt(arg0);
        let v4 = 0xc2ae6693383e4a81285136effc8190c7baaf0e75aafa36d1c69cd2170cfc3803::pool::swap_in<T0>(arg6, arg5, arg7, 0x2::coin::from_balance<T0>(v1, arg9), &v3, arg9);
        0x2::balance::join<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>(0x2::coin::balance_mut<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>(&mut v4), v2);
        let v5 = 0x1::type_name::with_defining_ids<CetusLp>();
        let v6 = 0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::limited_supply::supply(0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::limited_supply(0x2::vec_map::get<0x1::type_name::TypeName, 0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::ModuleConfig>(0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::module_config_map(arg5), &v5)));
        if (0x2::coin::value<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>(&v4) > v6) {
            let v7 = CetusLp{dummy_field: false};
            0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::collect<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB, CetusLp>(arg5, v7, fee_memo(), 0x2::balance::split<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>(0x2::coin::balance_mut<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>(&mut v4), 0x2::coin::value<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>(&v4) - v6));
        };
        let v8 = CetusLp{dummy_field: false};
        0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::burn<CetusLp>(arg5, v8, package_version(), v4);
    }

    // decompiled from Move bytecode v6
}

