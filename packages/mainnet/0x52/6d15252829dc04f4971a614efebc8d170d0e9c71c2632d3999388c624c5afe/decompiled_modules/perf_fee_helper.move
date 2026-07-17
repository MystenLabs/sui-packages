module 0xa15d315338751ec89a95849bf4b5a43b5d5b222e3051e4ac9c2c15eec18553f4::perf_fee_helper {
    struct HelperOperatorCap has store, key {
        id: 0x2::object::UID,
        helper_id: address,
    }

    struct HelperAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct VaultHelper<phantom T0> has key {
        id: 0x2::object::UID,
        version: u64,
        vault_id: address,
        last_price_ratio: u256,
        last_claimed_ms: u64,
        claim_window_ms: u64,
        fee_rate_bps: u64,
        recipient: address,
        tolerance_bps: u64,
    }

    struct HelperCreated has copy, drop {
        helper_id: address,
        vault_id: address,
        recipient: address,
        fee_rate_bps: u64,
        initial_price_ratio: u256,
    }

    struct ExecutionRecorded has copy, drop {
        helper_id: address,
        vault_id: address,
        old_price_ratio: u256,
        new_price_ratio: u256,
        recorded_at_ms: u64,
    }

    struct PerformanceFeeVerified has copy, drop {
        helper_id: address,
        vault_id: address,
        fee_amount: u64,
        expected_fee: u64,
        recipient: address,
        old_price_ratio: u256,
        new_price_ratio: u256,
        claimed_at_ms: u64,
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

    public fun create_helper<T0>(arg0: &HelperAdminCap, arg1: &0xcd86f77503a755c48fe6c87e1b8e9a137ec0c1bf37aac8878b6083262b27fefa::vault::Vault<T0>, arg2: &0xcd86f77503a755c48fe6c87e1b8e9a137ec0c1bf37aac8878b6083262b27fefa::vault_oracle::OracleConfig, arg3: &0x2::clock::Clock, arg4: u64, arg5: address, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) : HelperOperatorCap {
        assert!(arg4 <= 5000, 5);
        assert!(0xcd86f77503a755c48fe6c87e1b8e9a137ec0c1bf37aac8878b6083262b27fefa::vault::total_shares<T0>(arg1) > 0, 8);
        let v0 = current_coin_ratio<T0>(arg1, arg2, arg3);
        let v1 = 0x2::object::new(arg8);
        let v2 = 0x2::object::uid_to_address(&v1);
        let v3 = 0xcd86f77503a755c48fe6c87e1b8e9a137ec0c1bf37aac8878b6083262b27fefa::vault::vault_id<T0>(arg1);
        let v4 = VaultHelper<T0>{
            id               : v1,
            version          : 1,
            vault_id         : v3,
            last_price_ratio : v0,
            last_claimed_ms  : 0x2::clock::timestamp_ms(arg3),
            claim_window_ms  : arg6,
            fee_rate_bps     : arg4,
            recipient        : arg5,
            tolerance_bps    : arg7,
        };
        let v5 = HelperCreated{
            helper_id           : v2,
            vault_id            : v3,
            recipient           : arg5,
            fee_rate_bps        : arg4,
            initial_price_ratio : v0,
        };
        0x2::event::emit<HelperCreated>(v5);
        0x2::transfer::share_object<VaultHelper<T0>>(v4);
        HelperOperatorCap{
            id        : 0x2::object::new(arg8),
            helper_id : v2,
        }
    }

    fun current_coin_ratio<T0>(arg0: &0xcd86f77503a755c48fe6c87e1b8e9a137ec0c1bf37aac8878b6083262b27fefa::vault::Vault<T0>, arg1: &0xcd86f77503a755c48fe6c87e1b8e9a137ec0c1bf37aac8878b6083262b27fefa::vault_oracle::OracleConfig, arg2: &0x2::clock::Clock) : u256 {
        0xcd86f77503a755c48fe6c87e1b8e9a137ec0c1bf37aac8878b6083262b27fefa::vault::validate_total_usd_value_updated<T0>(arg0, arg2);
        let v0 = 0xcd86f77503a755c48fe6c87e1b8e9a137ec0c1bf37aac8878b6083262b27fefa::vault::total_shares<T0>(arg0);
        if (v0 == 0) {
            return 0
        };
        0xcd86f77503a755c48fe6c87e1b8e9a137ec0c1bf37aac8878b6083262b27fefa::vault_utils::div_d(0xcd86f77503a755c48fe6c87e1b8e9a137ec0c1bf37aac8878b6083262b27fefa::vault_utils::div_with_oracle_price(0xcd86f77503a755c48fe6c87e1b8e9a137ec0c1bf37aac8878b6083262b27fefa::vault::get_total_usd_value_without_update<T0>(arg0), 0xcd86f77503a755c48fe6c87e1b8e9a137ec0c1bf37aac8878b6083262b27fefa::vault_oracle::get_normalized_asset_price(arg1, arg2, 0x1::type_name::into_string(0x1::type_name::get<T0>()))), v0)
    }

    public fun current_ratio_view<T0>(arg0: &0xcd86f77503a755c48fe6c87e1b8e9a137ec0c1bf37aac8878b6083262b27fefa::vault::Vault<T0>, arg1: &0xcd86f77503a755c48fe6c87e1b8e9a137ec0c1bf37aac8878b6083262b27fefa::vault_oracle::OracleConfig, arg2: &0x2::clock::Clock) : u256 {
        current_coin_ratio<T0>(arg0, arg1, arg2)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = HelperAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<HelperAdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun migrate<T0>(arg0: &HelperAdminCap, arg1: &mut VaultHelper<T0>) {
        assert!(arg1.version < 1, 10);
        arg1.version = 1;
    }

    fun next_high_water_mark(arg0: u256, arg1: u256, arg2: u256, arg3: u256, arg4: u64) : u256 {
        let v0 = arg0 + ratio_advance_from_fee(arg2, arg3, arg4);
        let v1 = if (v0 < arg1) {
            v0
        } else {
            arg1
        };
        if (v1 > arg0) {
            v1
        } else {
            arg0
        }
    }

    fun ratio_advance_from_fee(arg0: u256, arg1: u256, arg2: u64) : u256 {
        arg0 * 1000000000 * 10000 / arg1 * (arg2 as u256)
    }

    public fun record_execution_no_fee<T0>(arg0: &mut VaultHelper<T0>, arg1: &HelperOperatorCap, arg2: &0xcd86f77503a755c48fe6c87e1b8e9a137ec0c1bf37aac8878b6083262b27fefa::vault::Vault<T0>, arg3: &0xcd86f77503a755c48fe6c87e1b8e9a137ec0c1bf37aac8878b6083262b27fefa::vault_oracle::OracleConfig, arg4: &0x2::clock::Clock) {
        assert!(arg0.version == 1, 10);
        assert!(arg1.helper_id == 0x2::object::uid_to_address(&arg0.id), 7);
        assert!(0xcd86f77503a755c48fe6c87e1b8e9a137ec0c1bf37aac8878b6083262b27fefa::vault::vault_id<T0>(arg2) == arg0.vault_id, 1);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        assert!(v0 >= arg0.last_claimed_ms && v0 - arg0.last_claimed_ms >= arg0.claim_window_ms, 3);
        let v1 = 0xcd86f77503a755c48fe6c87e1b8e9a137ec0c1bf37aac8878b6083262b27fefa::vault::total_shares<T0>(arg2);
        assert!(v1 > 0, 8);
        let v2 = current_coin_ratio<T0>(arg2, arg3, arg4);
        assert!(compute_fee(v2, arg0.last_price_ratio, v1, arg0.fee_rate_bps) == 0, 11);
        arg0.last_price_ratio = v2;
        arg0.last_claimed_ms = v0;
        let v3 = ExecutionRecorded{
            helper_id       : 0x2::object::uid_to_address(&arg0.id),
            vault_id        : arg0.vault_id,
            old_price_ratio : arg0.last_price_ratio,
            new_price_ratio : arg0.last_price_ratio,
            recorded_at_ms  : v0,
        };
        0x2::event::emit<ExecutionRecorded>(v3);
    }

    public fun reset_state<T0>(arg0: &HelperAdminCap, arg1: &mut VaultHelper<T0>, arg2: u256, arg3: u64) {
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

    public fun simulate_fee<T0>(arg0: &0xcd86f77503a755c48fe6c87e1b8e9a137ec0c1bf37aac8878b6083262b27fefa::vault::Vault<T0>, arg1: &0xcd86f77503a755c48fe6c87e1b8e9a137ec0c1bf37aac8878b6083262b27fefa::vault_oracle::OracleConfig, arg2: &0x2::clock::Clock, arg3: u256, arg4: u64) : u64 {
        let v0 = compute_fee(current_coin_ratio<T0>(arg0, arg1, arg2), arg3, 0xcd86f77503a755c48fe6c87e1b8e9a137ec0c1bf37aac8878b6083262b27fefa::vault::total_shares<T0>(arg0), arg4);
        assert!(v0 <= 18446744073709551615, 6);
        (v0 as u64)
    }

    public fun unclaimed_performance_fee<T0>(arg0: &VaultHelper<T0>, arg1: &0xcd86f77503a755c48fe6c87e1b8e9a137ec0c1bf37aac8878b6083262b27fefa::vault::Vault<T0>, arg2: &0xcd86f77503a755c48fe6c87e1b8e9a137ec0c1bf37aac8878b6083262b27fefa::vault_oracle::OracleConfig, arg3: &0x2::clock::Clock) : u64 {
        assert!(0xcd86f77503a755c48fe6c87e1b8e9a137ec0c1bf37aac8878b6083262b27fefa::vault::vault_id<T0>(arg1) == arg0.vault_id, 1);
        let v0 = compute_fee(current_coin_ratio<T0>(arg1, arg2, arg3), arg0.last_price_ratio, 0xcd86f77503a755c48fe6c87e1b8e9a137ec0c1bf37aac8878b6083262b27fefa::vault::total_shares<T0>(arg1), arg0.fee_rate_bps);
        assert!(v0 <= 18446744073709551615, 6);
        (v0 as u64)
    }

    public fun update_config<T0>(arg0: &HelperAdminCap, arg1: &mut VaultHelper<T0>, arg2: u64, arg3: address, arg4: u64, arg5: u64) {
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

    public fun verify_and_record_performance_fee<T0>(arg0: &mut VaultHelper<T0>, arg1: &HelperOperatorCap, arg2: &0xcd86f77503a755c48fe6c87e1b8e9a137ec0c1bf37aac8878b6083262b27fefa::vault::Vault<T0>, arg3: &0xcd86f77503a755c48fe6c87e1b8e9a137ec0c1bf37aac8878b6083262b27fefa::vault_oracle::OracleConfig, arg4: &0x2::balance::Balance<T0>, arg5: address, arg6: &0x2::clock::Clock) {
        assert!(arg0.version == 1, 10);
        let v0 = 0x2::object::uid_to_address(&arg0.id);
        assert!(arg1.helper_id == v0, 7);
        assert!(0xcd86f77503a755c48fe6c87e1b8e9a137ec0c1bf37aac8878b6083262b27fefa::vault::vault_id<T0>(arg2) == arg0.vault_id, 1);
        assert!(arg5 == arg0.recipient, 2);
        let v1 = 0x2::clock::timestamp_ms(arg6);
        assert!(v1 >= arg0.last_claimed_ms && v1 - arg0.last_claimed_ms >= arg0.claim_window_ms, 3);
        let v2 = 0xcd86f77503a755c48fe6c87e1b8e9a137ec0c1bf37aac8878b6083262b27fefa::vault::total_shares<T0>(arg2);
        assert!(v2 > 0, 8);
        let v3 = current_coin_ratio<T0>(arg2, arg3, arg6);
        let v4 = compute_fee(v3, arg0.last_price_ratio, v2, arg0.fee_rate_bps);
        assert!(v4 > 0, 9);
        let v5 = (0x2::balance::value<T0>(arg4) as u256);
        assert!(within_tolerance(v5, v4, arg0.tolerance_bps), 4);
        let v6 = arg0.last_price_ratio;
        let v7 = next_high_water_mark(v6, v3, v5, v2, arg0.fee_rate_bps);
        arg0.last_price_ratio = v7;
        arg0.last_claimed_ms = v1;
        assert!(v4 <= 18446744073709551615, 6);
        let v8 = PerformanceFeeVerified{
            helper_id       : v0,
            vault_id        : arg0.vault_id,
            fee_amount      : 0x2::balance::value<T0>(arg4),
            expected_fee    : (v4 as u64),
            recipient       : arg5,
            old_price_ratio : v6,
            new_price_ratio : v7,
            claimed_at_ms   : v1,
        };
        0x2::event::emit<PerformanceFeeVerified>(v8);
    }

    fun within_tolerance(arg0: u256, arg1: u256, arg2: u64) : bool {
        let v0 = if (arg0 > arg1) {
            arg0 - arg1
        } else {
            arg1 - arg0
        };
        v0 <= arg1 * (arg2 as u256) / 10000
    }

    // decompiled from Move bytecode v7
}

