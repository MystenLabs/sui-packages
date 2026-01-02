module 0x266588b4ade88033ebe61e158ca25504b772fb7c1cdb89294a2c25c9073c3ecf::bluefin_lp_provider {
    struct BluefinLp has drop {
        dummy_field: bool,
    }

    struct BluefinLpProvider has key {
        id: 0x2::object::UID,
        abstract_account: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::Account,
        managers: 0x2::vec_set::VecSet<address>,
        usdb_a_positions: vector<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>,
        usdb_b_positions: vector<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>,
    }

    fun account_req_opt(arg0: &BluefinLpProvider) : 0x1::option::Option<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::AccountRequest> {
        0x1::option::some<0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::AccountRequest>(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::request_with_account(&arg0.abstract_account))
    }

    public fun add_manager(arg0: &mut BluefinLpProvider, arg1: &0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::admin::AdminCap, arg2: address) {
        0x2::vec_set::insert<address>(&mut arg0.managers, arg2);
    }

    public fun add_usdb_a_liquidity<T0>(arg0: &mut BluefinLpProvider, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB, T0>, arg3: u32, arg4: u32, arg5: &0x2::clock::Clock, arg6: &mut 0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::Treasury, arg7: &mut 0xc2ae6693383e4a81285136effc8190c7baaf0e75aafa36d1c69cd2170cfc3803::pool::Pool<T0>, arg8: &0xf2ab9aa60c5e879675351a1a89f47131de9dea7cc927327dd0e7282e295c7f5e::result::PriceResult<T0>, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        assert_sender_is_manager(arg0, arg10);
        let v0 = true;
        let v1 = account_req_opt(arg0);
        let v2 = has_position<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB, T0>(arg0, arg2, arg3, arg4, v0);
        let v3 = if (0x1::option::is_some<u64>(&v2)) {
            0x1::vector::borrow_mut<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut arg0.usdb_a_positions, 0x1::option::destroy_some<u64>(v2))
        } else {
            0x1::vector::push_back<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut arg0.usdb_a_positions, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::open_position<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB, T0>(arg1, arg2, arg3, arg4, arg10));
            0x1::vector::borrow_mut<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut arg0.usdb_a_positions, 0x1::vector::length<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&arg0.usdb_a_positions))
        };
        let (v4, v5, v6) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_liquidity_by_amount(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::lower_tick(v3), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::upper_tick(v3), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB, T0>(arg2), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB, T0>(arg2), arg9, !v0);
        let v7 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::floor(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::mul(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::from(v6), 0xc2ae6693383e4a81285136effc8190c7baaf0e75aafa36d1c69cd2170cfc3803::pool::conversion_rate<T0>(arg7)));
        let v8 = BluefinLp{dummy_field: false};
        let v9 = 0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::mint<BluefinLp>(arg6, v8, package_version(), v5 + v7, arg10);
        let (_, _, v12, v13) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::add_liquidity<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB, T0>(arg5, arg1, arg2, v3, 0x2::coin::into_balance<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>(v9), 0x2::coin::into_balance<T0>(0xc2ae6693383e4a81285136effc8190c7baaf0e75aafa36d1c69cd2170cfc3803::pool::swap_out<T0>(arg7, arg6, arg8, 0x2::coin::split<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>(&mut v9, v7, arg10), &v1, arg10)), v4);
        let v14 = BluefinLp{dummy_field: false};
        0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::collect<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB, BluefinLp>(arg6, v14, fee_memo(), v12);
        let v15 = BluefinLp{dummy_field: false};
        0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::collect<T0, BluefinLp>(arg6, v15, fee_memo(), v13);
    }

    public fun add_usdb_b_liquidity<T0>(arg0: &mut BluefinLpProvider, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, 0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>, arg3: u32, arg4: u32, arg5: &0x2::clock::Clock, arg6: &mut 0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::Treasury, arg7: &mut 0xc2ae6693383e4a81285136effc8190c7baaf0e75aafa36d1c69cd2170cfc3803::pool::Pool<T0>, arg8: &0xf2ab9aa60c5e879675351a1a89f47131de9dea7cc927327dd0e7282e295c7f5e::result::PriceResult<T0>, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        assert_sender_is_manager(arg0, arg10);
        let v0 = false;
        let v1 = account_req_opt(arg0);
        let v2 = has_position<T0, 0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>(arg0, arg2, arg3, arg4, v0);
        let v3 = if (0x1::option::is_some<u64>(&v2)) {
            0x1::vector::borrow_mut<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut arg0.usdb_b_positions, 0x1::option::destroy_some<u64>(v2))
        } else {
            0x1::vector::push_back<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut arg0.usdb_b_positions, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::open_position<T0, 0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>(arg1, arg2, arg3, arg4, arg10));
            0x1::vector::borrow_mut<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut arg0.usdb_b_positions, 0x1::vector::length<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&arg0.usdb_b_positions))
        };
        let (v4, v5, v6) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_liquidity_by_amount(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::lower_tick(v3), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::upper_tick(v3), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, 0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>(arg2), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, 0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>(arg2), arg9, !v0);
        let v7 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::floor(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::mul(0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::from(v5), 0xc2ae6693383e4a81285136effc8190c7baaf0e75aafa36d1c69cd2170cfc3803::pool::conversion_rate<T0>(arg7)));
        let v8 = BluefinLp{dummy_field: false};
        let v9 = 0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::mint<BluefinLp>(arg6, v8, package_version(), v6 + v7, arg10);
        let (_, _, v12, v13) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::add_liquidity<T0, 0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>(arg5, arg1, arg2, v3, 0x2::coin::into_balance<T0>(0xc2ae6693383e4a81285136effc8190c7baaf0e75aafa36d1c69cd2170cfc3803::pool::swap_out<T0>(arg7, arg6, arg8, 0x2::coin::split<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>(&mut v9, v7, arg10), &v1, arg10)), 0x2::coin::into_balance<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>(v9), v4);
        let v14 = BluefinLp{dummy_field: false};
        0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::collect<T0, BluefinLp>(arg6, v14, fee_memo(), v12);
        let v15 = BluefinLp{dummy_field: false};
        0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::collect<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB, BluefinLp>(arg6, v15, fee_memo(), v13);
    }

    public fun assert_sender_is_manager(arg0: &mut BluefinLpProvider, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        if (!0x2::vec_set::contains<address>(&arg0.managers, &v0)) {
            err_sender_is_not_manager();
        };
    }

    public fun claim_fees<T0, T1>(arg0: &mut BluefinLpProvider, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock, arg4: u64, arg5: &mut 0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::Treasury) {
        let v0 = if (0x1::type_name::with_defining_ids<T0>() == 0x1::type_name::with_defining_ids<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>()) {
            0x1::vector::borrow_mut<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut arg0.usdb_a_positions, arg4)
        } else {
            0x1::vector::borrow_mut<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut arg0.usdb_b_positions, arg4)
        };
        let (_, _, v3, v4) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_fee<T0, T1>(arg3, arg1, arg2, v0);
        let v5 = BluefinLp{dummy_field: false};
        0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::collect<T0, BluefinLp>(arg5, v5, fee_memo(), v3);
        let v6 = BluefinLp{dummy_field: false};
        0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::collect<T1, BluefinLp>(arg5, v6, fee_memo(), v4);
    }

    public fun claim_fees_and_rewards<T0, T1, T2>(arg0: &mut BluefinLpProvider, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock, arg4: u64, arg5: &mut 0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::Treasury) {
        let v0 = if (0x1::type_name::with_defining_ids<T0>() == 0x1::type_name::with_defining_ids<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>()) {
            0x1::vector::borrow_mut<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut arg0.usdb_a_positions, arg4)
        } else {
            0x1::vector::borrow_mut<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut arg0.usdb_b_positions, arg4)
        };
        let (_, _, v3, v4) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_fee<T0, T1>(arg3, arg1, arg2, v0);
        let v5 = BluefinLp{dummy_field: false};
        0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::collect<T0, BluefinLp>(arg5, v5, fee_memo(), v3);
        let v6 = BluefinLp{dummy_field: false};
        0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::collect<T1, BluefinLp>(arg5, v6, fee_memo(), v4);
        let v7 = BluefinLp{dummy_field: false};
        0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::collect<T2, BluefinLp>(arg5, v7, fee_memo(), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T0, T1, T2>(arg3, arg1, arg2, v0));
    }

    public fun claim_rewards<T0, T1, T2>(arg0: &mut BluefinLpProvider, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock, arg4: u64, arg5: &mut 0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::Treasury) {
        let v0 = if (0x1::type_name::with_defining_ids<T0>() == 0x1::type_name::with_defining_ids<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>()) {
            0x1::vector::borrow_mut<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut arg0.usdb_a_positions, arg4)
        } else {
            0x1::vector::borrow_mut<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut arg0.usdb_b_positions, arg4)
        };
        let v1 = BluefinLp{dummy_field: false};
        0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::collect<T2, BluefinLp>(arg5, v1, fee_memo(), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T0, T1, T2>(arg3, arg1, arg2, v0));
    }

    fun err_invalid_remove_ratio() {
        abort 2
    }

    fun err_sender_is_not_manager() {
        abort 1
    }

    fun fee_memo() : 0x1::string::String {
        0x1::string::utf8(b"market_making")
    }

    public fun has_position<T0, T1>(arg0: &BluefinLpProvider, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: u32, arg3: u32, arg4: bool) : 0x1::option::Option<u64> {
        let v0 = if (arg4) {
            &arg0.usdb_a_positions
        } else {
            &arg0.usdb_b_positions
        };
        let v1 = 0;
        let v2;
        while (v1 < 0x1::vector::length<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(v0)) {
            let v3 = 0x1::vector::borrow<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(v0, v1);
            let v4 = if (0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::pool_id(v3) == 0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>>(arg1)) {
                if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::lower_tick(v3)) == arg2) {
                    0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::upper_tick(v3)) == arg3
                } else {
                    false
                }
            } else {
                false
            };
            if (v4) {
                v2 = 0x1::option::some<u64>(v1);
                return v2
            };
            v1 = v1 + 1;
        };
        v2 = 0x1::option::none<u64>();
        v2
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = BluefinLpProvider{
            id               : 0x2::object::new(arg0),
            abstract_account : 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::new(0x1::option::some<0x1::string::String>(0x1::string::utf8(b"")), arg0),
            managers         : 0x2::vec_set::singleton<address>(0x2::tx_context::sender(arg0)),
            usdb_a_positions : 0x1::vector::empty<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(),
            usdb_b_positions : 0x1::vector::empty<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(),
        };
        0x2::transfer::share_object<BluefinLpProvider>(v0);
    }

    public fun package_version() : u16 {
        5
    }

    public fun remove_manager(arg0: &mut BluefinLpProvider, arg1: &0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::admin::AdminCap, arg2: address) {
        0x2::vec_set::remove<address>(&mut arg0.managers, &arg2);
    }

    public fun remove_usdb_a_liquidity<T0>(arg0: &mut BluefinLpProvider, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB, T0>, arg3: &0x2::clock::Clock, arg4: u64, arg5: &mut 0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::Treasury, arg6: &mut 0xc2ae6693383e4a81285136effc8190c7baaf0e75aafa36d1c69cd2170cfc3803::pool::Pool<T0>, arg7: &0xf2ab9aa60c5e879675351a1a89f47131de9dea7cc927327dd0e7282e295c7f5e::result::PriceResult<T0>, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        assert_sender_is_manager(arg0, arg9);
        let v0 = 0x1::vector::borrow_mut<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut arg0.usdb_a_positions, arg4);
        if (arg8 > 100) {
            err_invalid_remove_ratio();
        };
        let (_, _, v3, v4) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::remove_liquidity<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB, T0>(arg1, arg2, v0, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::mul_div_round(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::liquidity(v0), (arg8 as u128), 100), arg3);
        if (0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::liquidity(v0) == 0) {
            0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::close_position_v2<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB, T0>(arg3, arg1, arg2, 0x1::vector::remove<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut arg0.usdb_a_positions, arg4));
        };
        let v5 = account_req_opt(arg0);
        let v6 = 0xc2ae6693383e4a81285136effc8190c7baaf0e75aafa36d1c69cd2170cfc3803::pool::swap_in<T0>(arg6, arg5, arg7, 0x2::coin::from_balance<T0>(v4, arg9), &v5, arg9);
        0x2::balance::join<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>(0x2::coin::balance_mut<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>(&mut v6), v3);
        let v7 = 0x1::type_name::with_defining_ids<BluefinLp>();
        let v8 = 0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::limited_supply::supply(0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::limited_supply(0x2::vec_map::get<0x1::type_name::TypeName, 0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::ModuleConfig>(0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::module_config_map(arg5), &v7)));
        if (0x2::coin::value<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>(&v6) > v8) {
            let v9 = BluefinLp{dummy_field: false};
            0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::collect<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB, BluefinLp>(arg5, v9, fee_memo(), 0x2::balance::split<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>(0x2::coin::balance_mut<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>(&mut v6), 0x2::coin::value<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>(&v6) - v8));
        };
        let v10 = BluefinLp{dummy_field: false};
        0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::burn<BluefinLp>(arg5, v10, package_version(), v6);
    }

    public fun remove_usdb_b_liquidity<T0>(arg0: &mut BluefinLpProvider, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, 0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>, arg3: &0x2::clock::Clock, arg4: u64, arg5: &mut 0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::Treasury, arg6: &mut 0xc2ae6693383e4a81285136effc8190c7baaf0e75aafa36d1c69cd2170cfc3803::pool::Pool<T0>, arg7: &0xf2ab9aa60c5e879675351a1a89f47131de9dea7cc927327dd0e7282e295c7f5e::result::PriceResult<T0>, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        assert_sender_is_manager(arg0, arg9);
        let v0 = 0x1::vector::borrow_mut<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut arg0.usdb_b_positions, arg4);
        if (arg8 > 100) {
            err_invalid_remove_ratio();
        };
        let (_, _, v3, v4) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::remove_liquidity<T0, 0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>(arg1, arg2, v0, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::mul_div_round(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::liquidity(v0), (arg8 as u128), 100), arg3);
        if (0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::liquidity(v0) == 0) {
            0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::close_position_v2<T0, 0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>(arg3, arg1, arg2, 0x1::vector::remove<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(&mut arg0.usdb_b_positions, arg4));
        };
        let v5 = account_req_opt(arg0);
        let v6 = 0xc2ae6693383e4a81285136effc8190c7baaf0e75aafa36d1c69cd2170cfc3803::pool::swap_in<T0>(arg6, arg5, arg7, 0x2::coin::from_balance<T0>(v3, arg9), &v5, arg9);
        0x2::balance::join<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>(0x2::coin::balance_mut<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>(&mut v6), v4);
        let v7 = 0x1::type_name::with_defining_ids<BluefinLp>();
        let v8 = 0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::limited_supply::supply(0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::limited_supply(0x2::vec_map::get<0x1::type_name::TypeName, 0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::ModuleConfig>(0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::module_config_map(arg5), &v7)));
        if (0x2::coin::value<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>(&v6) > v8) {
            let v9 = BluefinLp{dummy_field: false};
            0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::collect<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB, BluefinLp>(arg5, v9, fee_memo(), 0x2::balance::split<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>(0x2::coin::balance_mut<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>(&mut v6), 0x2::coin::value<0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::USDB>(&v6) - v8));
        };
        let v10 = BluefinLp{dummy_field: false};
        0xe14726c336e81b32328e92afc37345d159f5b550b09fa92bd43640cfdd0a0cfd::usdb::burn<BluefinLp>(arg5, v10, package_version(), v6);
    }

    // decompiled from Move bytecode v6
}

