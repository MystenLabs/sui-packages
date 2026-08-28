module 0xad874f2df79f059a1c71821b063a60b8312eb9ea97a6778509090827fcdda522::curator_fee_helper {
    struct CuratorHelperOperatorCap has store, key {
        id: 0x2::object::UID,
        helper_id: address,
    }

    struct CuratorHelperAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct CuratorVaultHelper<phantom T0> has key {
        id: 0x2::object::UID,
        version: u64,
        vault_id: address,
        last_price_ratio: u256,
        last_claimed_ms: u64,
        claim_window_ms: u64,
        fee_rate_bps: u64,
        recipient: address,
        tolerance_bps: u64,
        curator_position_id: address,
    }

    struct CuratorHelperCreated has copy, drop {
        helper_id: address,
        vault_id: address,
        recipient: address,
        fee_rate_bps: u64,
        initial_price_ratio: u256,
    }

    struct CuratorPerformanceFeeRecord has copy, drop {
        helper_id: address,
        vault_id: address,
        fee_amount: u64,
        expected_fee: u64,
        recipient: address,
        old_price_ratio: u256,
        share_price_ratio: u256,
        new_price_ratio: u256,
        total_shares: u256,
        principal_based_tvl: u256,
        total_usd_value: u256,
        principal_price: u256,
        recorded_at_ms: u64,
    }

    struct StateReset has copy, drop {
        helper_id: address,
        old_price_ratio: u256,
        new_price_ratio: u256,
        old_last_claimed_ms: u64,
        new_last_claimed_ms: u64,
    }

    struct ConfigUpdated has copy, drop {
        helper_id: address,
        fee_rate_bps: u64,
        recipient: address,
        claim_window_ms: u64,
        tolerance_bps: u64,
    }

    fun compute_fee(arg0: u256, arg1: u256, arg2: u256, arg3: u64) : u256 {
        if (arg0 <= arg1) {
            return 0
        };
        arg2 * (arg0 - arg1) * (arg3 as u256) / 1000000000 * 10000
    }

    public fun create_helper<T0>(arg0: &CuratorHelperAdminCap, arg1: &0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::Vault<T0>, arg2: &0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault_oracle::OracleConfig, arg3: &0x2::clock::Clock, arg4: u64, arg5: address, arg6: u64, arg7: u64, arg8: address, arg9: &mut 0x2::tx_context::TxContext) : CuratorHelperOperatorCap {
        assert!(arg4 <= 5000, 5);
        assert!(0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::total_shares<T0>(arg1) > 0, 8);
        let v0 = current_coin_ratio<T0>(arg1, arg2, arg3);
        let v1 = 0x2::object::new(arg9);
        let v2 = 0x2::object::uid_to_address(&v1);
        let v3 = 0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::vault_id<T0>(arg1);
        let v4 = CuratorVaultHelper<T0>{
            id                  : v1,
            version             : 1,
            vault_id            : v3,
            last_price_ratio    : v0,
            last_claimed_ms     : 0x2::clock::timestamp_ms(arg3),
            claim_window_ms     : arg6,
            fee_rate_bps        : arg4,
            recipient           : arg5,
            tolerance_bps       : arg7,
            curator_position_id : arg8,
        };
        let v5 = CuratorHelperCreated{
            helper_id           : v2,
            vault_id            : v3,
            recipient           : arg5,
            fee_rate_bps        : arg4,
            initial_price_ratio : v0,
        };
        0x2::event::emit<CuratorHelperCreated>(v5);
        0x2::transfer::share_object<CuratorVaultHelper<T0>>(v4);
        CuratorHelperOperatorCap{
            id        : 0x2::object::new(arg9),
            helper_id : v2,
        }
    }

    public fun curator_position_id<T0>(arg0: &CuratorVaultHelper<T0>) : address {
        arg0.curator_position_id
    }

    fun current_coin_ratio<T0>(arg0: &0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::Vault<T0>, arg1: &0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault_oracle::OracleConfig, arg2: &0x2::clock::Clock) : u256 {
        let (v0, _, _, _, _) = current_state<T0>(arg0, arg1, arg2);
        v0
    }

    public fun current_ratio_view<T0>(arg0: &0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::Vault<T0>, arg1: &0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault_oracle::OracleConfig, arg2: &0x2::clock::Clock) : u256 {
        current_coin_ratio<T0>(arg0, arg1, arg2)
    }

    fun current_state<T0>(arg0: &0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::Vault<T0>, arg1: &0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault_oracle::OracleConfig, arg2: &0x2::clock::Clock) : (u256, u256, u256, u256, u256) {
        0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::validate_total_usd_value_updated<T0>(arg0, arg2);
        let v0 = 0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::get_total_usd_value_without_update<T0>(arg0);
        let v1 = 0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault_oracle::get_normalized_asset_price(arg1, arg2, 0x1::type_name::into_string(0x1::type_name::get<T0>()));
        let v2 = 0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault_utils::div_with_oracle_price(v0, v1);
        let v3 = 0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::total_shares<T0>(arg0);
        let v4 = if (v3 == 0) {
            0
        } else {
            0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault_utils::div_d(v2, v3)
        };
        (v4, v2, v0, v1, v3)
    }

    public fun helper_vault_id<T0>(arg0: &CuratorVaultHelper<T0>) : address {
        arg0.vault_id
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = CuratorHelperAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<CuratorHelperAdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun last_claimed_ms<T0>(arg0: &CuratorVaultHelper<T0>) : u64 {
        arg0.last_claimed_ms
    }

    public fun last_price_ratio<T0>(arg0: &CuratorVaultHelper<T0>) : u256 {
        arg0.last_price_ratio
    }

    public fun migrate<T0>(arg0: &CuratorHelperAdminCap, arg1: &mut CuratorVaultHelper<T0>) {
        assert!(arg1.version < 1, 10);
        arg1.version = 1;
    }

    public fun needed_free_principal<T0>(arg0: &CuratorVaultHelper<T0>, arg1: &0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::Vault<T0>, arg2: &0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::curator_position::CuratorConfig, arg3: &0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault_oracle::OracleConfig, arg4: &0x2::clock::Clock, arg5: u256, arg6: u64, arg7: u64) : u64 {
        assert!(arg0.version == 1, 10);
        assert!(0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::vault_id<T0>(arg1) == arg0.vault_id, 1);
        assert!(0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::curator_position::curator_position_vault_id(arg2, arg0.curator_position_id) == 0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::vault_id<T0>(arg1), 12);
        let v0 = 0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::total_shares<T0>(arg1);
        assert!(v0 > 0, 8);
        let v1 = if (arg6 > arg7) {
            ((arg6 - arg7) as u256)
        } else {
            0
        };
        let v2 = compute_fee(0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault_utils::div_d(simulated_principal_tvl<T0>(arg1, arg3, arg4, arg5), v0), arg0.last_price_ratio, v0, arg0.fee_rate_bps) + v1;
        let v3 = (0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::free_principal<T0>(arg1) as u256);
        let v4 = if (v2 > v3) {
            v2 - v3
        } else {
            0
        };
        assert!(v4 <= 18446744073709551615, 6);
        (v4 as u64)
    }

    fun next_reference_ratio(arg0: u256, arg1: u256, arg2: u256, arg3: u256, arg4: u256, arg5: u256, arg6: u64) : u256 {
        let v0 = if (arg2 > arg4) {
            arg2 - arg4
        } else {
            0
        };
        let v1 = 0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault_utils::div_d(v0, arg5);
        let v2 = if (arg4 >= arg3) {
            v1
        } else {
            let v3 = arg0 + ratio_advance_from_fee(arg4, arg5, arg6);
            let v4 = if (v3 < arg1) {
                v3
            } else {
                arg1
            };
            let v5 = arg1 - v4;
            if (v1 > v5) {
                v1 - v5
            } else {
                0
            }
        };
        if (v2 > arg0) {
            v2
        } else {
            arg0
        }
    }

    public fun preview_settlement<T0>(arg0: &CuratorVaultHelper<T0>, arg1: &0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::Vault<T0>, arg2: &0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault_oracle::OracleConfig, arg3: &0x2::clock::Clock, arg4: u256) : (u64, u256, u256, u256, u256) {
        assert!(arg0.version == 1, 10);
        assert!(0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::vault_id<T0>(arg1) == arg0.vault_id, 1);
        let v0 = 0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::total_shares<T0>(arg1);
        assert!(v0 > 0, 8);
        let v1 = simulated_principal_tvl<T0>(arg1, arg2, arg3, arg4);
        let v2 = 0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault_utils::div_d(v1, v0);
        let v3 = compute_fee(v2, arg0.last_price_ratio, v0, arg0.fee_rate_bps);
        assert!(v3 <= 18446744073709551615, 6);
        ((v3 as u64), v2, 0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault_utils::div_d(v1 - v3, v0), v0, v1)
    }

    fun ratio_advance_from_fee(arg0: u256, arg1: u256, arg2: u64) : u256 {
        arg0 * 1000000000 * 10000 / arg1 * (arg2 as u256)
    }

    public fun record_execution_no_fee<T0>(arg0: &mut CuratorVaultHelper<T0>, arg1: &CuratorHelperOperatorCap, arg2: &0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::Vault<T0>, arg3: &0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault_oracle::OracleConfig, arg4: &0x2::clock::Clock) {
        assert!(arg0.version == 1, 10);
        assert!(arg1.helper_id == 0x2::object::uid_to_address(&arg0.id), 7);
        assert!(0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::vault_id<T0>(arg2) == arg0.vault_id, 1);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        assert!(v0 >= arg0.last_claimed_ms && v0 - arg0.last_claimed_ms >= arg0.claim_window_ms, 3);
        let (v1, v2, v3, v4, v5) = current_state<T0>(arg2, arg3, arg4);
        assert!(v5 > 0, 8);
        assert!(compute_fee(v1, arg0.last_price_ratio, v5, arg0.fee_rate_bps) == 0, 11);
        arg0.last_price_ratio = v1;
        arg0.last_claimed_ms = v0;
        let v6 = CuratorPerformanceFeeRecord{
            helper_id           : 0x2::object::uid_to_address(&arg0.id),
            vault_id            : arg0.vault_id,
            fee_amount          : 0,
            expected_fee        : 0,
            recipient           : arg0.recipient,
            old_price_ratio     : arg0.last_price_ratio,
            share_price_ratio   : v1,
            new_price_ratio     : arg0.last_price_ratio,
            total_shares        : v5,
            principal_based_tvl : v2,
            total_usd_value     : v3,
            principal_price     : v4,
            recorded_at_ms      : v0,
        };
        0x2::event::emit<CuratorPerformanceFeeRecord>(v6);
    }

    public fun reset_state<T0>(arg0: &CuratorHelperAdminCap, arg1: &mut CuratorVaultHelper<T0>, arg2: u256, arg3: u64) {
        assert!(arg1.version == 1, 10);
        let v0 = StateReset{
            helper_id           : 0x2::object::uid_to_address(&arg1.id),
            old_price_ratio     : arg1.last_price_ratio,
            new_price_ratio     : arg2,
            old_last_claimed_ms : arg1.last_claimed_ms,
            new_last_claimed_ms : arg3,
        };
        0x2::event::emit<StateReset>(v0);
        arg1.last_price_ratio = arg2;
        arg1.last_claimed_ms = arg3;
    }

    public fun simulate_fee<T0>(arg0: &0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::Vault<T0>, arg1: &0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault_oracle::OracleConfig, arg2: &0x2::clock::Clock, arg3: u256, arg4: u64) : u64 {
        let v0 = compute_fee(current_coin_ratio<T0>(arg0, arg1, arg2), arg3, 0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::total_shares<T0>(arg0), arg4);
        assert!(v0 <= 18446744073709551615, 6);
        (v0 as u64)
    }

    fun simulated_principal_tvl<T0>(arg0: &0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::Vault<T0>, arg1: &0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault_oracle::OracleConfig, arg2: &0x2::clock::Clock, arg3: u256) : u256 {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        let (v1, _) = 0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::get_asset_value<T0>(arg0, v0);
        let (v3, _) = 0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::get_asset_value<T0>(arg0, 0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault_utils::parse_key<0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::curator_position::CuratorPosition>(0));
        (0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::free_principal<T0>(arg0) as u256) + arg3 + 0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault_utils::div_with_oracle_price(0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::get_total_usd_value_without_update<T0>(arg0) - v1 - v3, 0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault_oracle::get_normalized_asset_price(arg1, arg2, v0))
    }

    public fun unclaimed_performance_fee<T0>(arg0: &CuratorVaultHelper<T0>, arg1: &0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::Vault<T0>, arg2: &0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault_oracle::OracleConfig, arg3: &0x2::clock::Clock) : u64 {
        assert!(0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::vault_id<T0>(arg1) == arg0.vault_id, 1);
        let v0 = compute_fee(current_coin_ratio<T0>(arg1, arg2, arg3), arg0.last_price_ratio, 0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::total_shares<T0>(arg1), arg0.fee_rate_bps);
        assert!(v0 <= 18446744073709551615, 6);
        (v0 as u64)
    }

    public fun update_config<T0>(arg0: &CuratorHelperAdminCap, arg1: &mut CuratorVaultHelper<T0>, arg2: u64, arg3: address, arg4: u64, arg5: u64) {
        assert!(arg1.version == 1, 10);
        assert!(arg2 <= 5000, 5);
        arg1.fee_rate_bps = arg2;
        arg1.recipient = arg3;
        arg1.claim_window_ms = arg4;
        arg1.tolerance_bps = arg5;
        let v0 = ConfigUpdated{
            helper_id       : 0x2::object::uid_to_address(&arg1.id),
            fee_rate_bps    : arg2,
            recipient       : arg3,
            claim_window_ms : arg4,
            tolerance_bps   : arg5,
        };
        0x2::event::emit<ConfigUpdated>(v0);
    }

    public fun verify_and_record_performance_fee<T0>(arg0: &mut CuratorVaultHelper<T0>, arg1: &CuratorHelperOperatorCap, arg2: &0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::Vault<T0>, arg3: &0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault_oracle::OracleConfig, arg4: &0x2::balance::Balance<T0>, arg5: address, arg6: &0x2::clock::Clock) {
        assert!(arg0.version == 1, 10);
        let v0 = 0x2::object::uid_to_address(&arg0.id);
        assert!(arg1.helper_id == v0, 7);
        assert!(0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::vault_id<T0>(arg2) == arg0.vault_id, 1);
        assert!(arg5 == arg0.recipient, 2);
        let v1 = 0x2::clock::timestamp_ms(arg6);
        assert!(v1 >= arg0.last_claimed_ms && v1 - arg0.last_claimed_ms >= arg0.claim_window_ms, 3);
        let (v2, v3, v4, v5, v6) = current_state<T0>(arg2, arg3, arg6);
        assert!(v6 > 0, 8);
        let v7 = compute_fee(v2, arg0.last_price_ratio, v6, arg0.fee_rate_bps);
        assert!(v7 > 0, 9);
        let v8 = (0x2::balance::value<T0>(arg4) as u256);
        assert!(v8 > 0, 4);
        assert!(within_tolerance(v8, v7, arg0.tolerance_bps), 4);
        let v9 = arg0.last_price_ratio;
        let v10 = next_reference_ratio(v9, v2, v3, v7, v8, v6, arg0.fee_rate_bps);
        arg0.last_price_ratio = v10;
        arg0.last_claimed_ms = v1;
        assert!(v7 <= 18446744073709551615, 6);
        let v11 = CuratorPerformanceFeeRecord{
            helper_id           : v0,
            vault_id            : arg0.vault_id,
            fee_amount          : 0x2::balance::value<T0>(arg4),
            expected_fee        : (v7 as u64),
            recipient           : arg5,
            old_price_ratio     : v9,
            share_price_ratio   : v2,
            new_price_ratio     : v10,
            total_shares        : v6,
            principal_based_tvl : v3,
            total_usd_value     : v4,
            principal_price     : v5,
            recorded_at_ms      : v1,
        };
        0x2::event::emit<CuratorPerformanceFeeRecord>(v11);
    }

    public fun verify_settlement_liquidity<T0>(arg0: &CuratorVaultHelper<T0>, arg1: &0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault::Vault<T0>, arg2: &0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::curator_position::CuratorConfig, arg3: &0x1cd46539840a60ea47f12b6b3b20c4afa2ebbba5eb6efdd077bb03cfef11ca8::vault_oracle::OracleConfig, arg4: &0x2::clock::Clock, arg5: u256, arg6: u64, arg7: u64) {
        assert!(needed_free_principal<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7) == 0, 13);
    }

    fun within_tolerance(arg0: u256, arg1: u256, arg2: u64) : bool {
        let v0 = if (arg0 > arg1) {
            arg0 - arg1
        } else {
            arg1 - arg0
        };
        let v1 = arg1 * (arg2 as u256) / 10000;
        let v2 = if (v1 == 0 && arg2 > 0) {
            1
        } else {
            v1
        };
        v0 <= v2
    }

    // decompiled from Move bytecode v7
}

