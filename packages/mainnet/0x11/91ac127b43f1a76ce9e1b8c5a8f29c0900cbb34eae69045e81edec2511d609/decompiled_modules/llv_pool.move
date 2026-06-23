module 0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_pool {
    struct ProtocolAllocation has copy, drop, store {
        protocol_id: u8,
        can_supply: bool,
        can_withdraw: bool,
        deposited_amount: u128,
        current_balance: u128,
        last_sync_ms: u64,
        target_ratio_bps: u64,
        deposit_cap: u128,
        min_deposit: u64,
        dust_recorded_value: u128,
    }

    struct ProtocolConfig has copy, drop, store {
        ids: vector<0x2::object::ID>,
        values: vector<u64>,
        type_bytes: 0x2::vec_map::VecMap<u8, vector<u8>>,
        typed_ids: 0x2::vec_map::VecMap<vector<u8>, 0x2::object::ID>,
    }

    struct FeeAccrualState has copy, drop, store {
        management_share_remainder: u128,
        performance_asset_remainder: u128,
        performance_pending_assets: u128,
    }

    struct RewardCompoundReceipt {
        pool_id: 0x2::object::ID,
        protocol_id: u8,
        sender: address,
        claimed_reward_amount: u64,
    }

    struct LLVPool<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        allocations: 0x2::vec_map::VecMap<u8, ProtocolAllocation>,
        protocol_configs: 0x2::vec_map::VecMap<u8, ProtocolConfig>,
        share_treasury: 0x2::coin::TreasuryCap<T1>,
        asset_decimals: u8,
        paused: bool,
        min_deposit: u64,
        deposit_cap: u128,
        supply_queue: vector<u8>,
        withdraw_queue: vector<u8>,
        fee_recipient: address,
        fee_recipient_shares: u128,
        performance_fee_bps: u64,
        management_fee_bps: u64,
        management_fee_cap_bps: u64,
        last_fee_collection_ms: u64,
        last_total_assets: u128,
        fee_accrual_state: FeeAccrualState,
        acl: 0x2::vec_map::VecMap<address, u64>,
        last_rebalance_ms: u64,
        min_rebalance_interval_ms: u64,
        min_rebalance_deviation_bps: u64,
        max_sync_deviation_bps: u64,
        max_accounted_value_gap_bps: u64,
        operation_in_progress: bool,
        max_balance_age_ms: u64,
        min_shares: u128,
        min_real_shares_guard: u128,
    }

    struct AllocationInfo has copy, drop {
        protocol_id: u8,
        can_supply: bool,
        can_withdraw: bool,
        deposited_amount: u128,
        current_balance: u128,
        dust_recorded_value: u128,
        last_sync_ms: u64,
        target_ratio_bps: u64,
        deposit_cap: u128,
        min_deposit: u64,
    }

    struct ProtocolConfigInfo has copy, drop {
        protocol_id: u8,
        config: ProtocolConfig,
    }

    struct NaviAccountCapKey has copy, drop, store {
        dummy_field: bool,
    }

    struct AlphaLendPositionCapKey has copy, drop, store {
        dummy_field: bool,
    }

    struct SuilendObligationCapKey has copy, drop, store {
        dummy_field: bool,
    }

    struct ScallopSpoolAccountKey has copy, drop, store {
        dummy_field: bool,
    }

    struct ProtocolLegAuthKey<phantom T0> has copy, drop, store {
        protocol_id: u8,
    }

    struct AccumulatedTokenKey<phantom T0> has copy, drop, store {
        protocol_id: u8,
    }

    public fun id<T0, T1>(arg0: &LLVPool<T0, T1>) : 0x2::object::ID {
        0x2::object::id<LLVPool<T0, T1>>(arg0)
    }

    public(friend) fun accrue_fees<T0, T1>(arg0: &mut LLVPool<T0, T1>, arg1: u128, arg2: u64) : u128 {
        if (arg0.management_fee_bps == 0 && arg0.performance_fee_bps == 0) {
            return 0
        };
        if (arg0.fee_recipient == @0x0) {
            arg0.last_fee_collection_ms = arg2;
            arg0.last_total_assets = arg1;
            return 0
        };
        if (arg0.last_fee_collection_ms == 0) {
            arg0.last_fee_collection_ms = arg2;
            arg0.last_total_assets = arg1;
            return 0
        };
        let v0 = total_shares<T0, T1>(arg0);
        let v1 = 0;
        let v2 = 0;
        let v3 = 0;
        let v4 = 0;
        let v5 = arg0.management_fee_bps;
        let v6 = arg0.performance_fee_bps;
        let v7 = arg0.last_total_assets;
        let v8 = &mut arg0.fee_accrual_state;
        let v9 = if (v5 > 0) {
            if (v0 > 0) {
                arg1 > 0
            } else {
                false
            }
        } else {
            false
        };
        if (v9) {
            let v10 = (v0 as u256) * (v5 as u256) * ((arg2 - arg0.last_fee_collection_ms) as u256) + (v8.management_share_remainder as u256);
            let v11 = (10000 as u256) * (31536000000 as u256);
            let v12 = ((v10 / v11) as u128);
            v1 = v12;
            v8.management_share_remainder = ((v10 % v11) as u128);
            if (v12 > 0) {
                v3 = 0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_math::mul_div(v12, arg1, v0);
            };
        };
        let v13 = if (v6 > 0) {
            if (v0 > 0) {
                arg1 > v7
            } else {
                false
            }
        } else {
            false
        };
        if (v13) {
            let v14 = ((arg1 - v7) as u256) * (v6 as u256) + (v8.performance_asset_remainder as u256);
            let v15 = (10000 as u256);
            v8.performance_asset_remainder = ((v14 % v15) as u128);
            let v16 = (v8.performance_pending_assets as u256) + (((v14 / v15) as u128) as u256);
            assert!(v16 <= (340282366920938463463374607431768211455 as u256), 114);
            v8.performance_pending_assets = (v16 as u128);
        };
        let v17 = if (v6 > 0) {
            if (v8.performance_pending_assets > 0) {
                if (v0 > 0) {
                    arg1 > 0
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        if (v17) {
            let v18 = 0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_math::mul_div(v8.performance_pending_assets, v0, arg1);
            v2 = v18;
            if (v18 > 0) {
                let v19 = 0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_math::mul_div_ceil(v18, arg1, v0);
                let v20 = v19;
                if (v19 > v8.performance_pending_assets) {
                    v20 = v8.performance_pending_assets;
                };
                v8.performance_pending_assets = v8.performance_pending_assets - v20;
                v4 = v20;
            };
        };
        let v21 = v1 + v2;
        arg0.last_fee_collection_ms = arg2;
        if (arg1 > arg0.last_total_assets) {
            arg0.last_total_assets = arg1;
        };
        arg0.fee_recipient_shares = arg0.fee_recipient_shares + v21;
        if (v21 > 0) {
            0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_events::emit_fees_accrued(0x2::object::id<LLVPool<T0, T1>>(arg0), v1, v2, v21, arg0.fee_recipient, v7, v3, v4, arg1, v0 + v21, arg2);
        };
        v21
    }

    public fun accumulate_dust<T0, T1, T2, T3>(arg0: &mut LLVPool<T0, T1>, arg1: u8, arg2: 0x2::balance::Balance<T2>, arg3: u128, arg4: &T3) {
        assert_protocol_leg_auth<T0, T1, T3>(arg0, arg1);
        accumulate_token_internal<T0, T1, T2>(arg0, arg1, arg2);
        if (arg3 > 0 && 0x2::vec_map::contains<u8, ProtocolAllocation>(&arg0.allocations, &arg1)) {
            let v0 = 0x2::vec_map::get_mut<u8, ProtocolAllocation>(&mut arg0.allocations, &arg1);
            v0.dust_recorded_value = v0.dust_recorded_value + arg3;
        };
    }

    public(friend) fun accumulate_token_internal<T0, T1, T2>(arg0: &mut LLVPool<T0, T1>, arg1: u8, arg2: 0x2::balance::Balance<T2>) {
        if (0x2::balance::value<T2>(&arg2) == 0) {
            0x2::balance::destroy_zero<T2>(arg2);
            return
        };
        let v0 = accumulated_token_key<T2>(arg1);
        if (0x2::dynamic_field::exists<AccumulatedTokenKey<T2>>(&arg0.id, v0)) {
            0x2::balance::join<T2>(0x2::dynamic_field::borrow_mut<AccumulatedTokenKey<T2>, 0x2::balance::Balance<T2>>(&mut arg0.id, v0), arg2);
        } else {
            0x2::dynamic_field::add<AccumulatedTokenKey<T2>, 0x2::balance::Balance<T2>>(&mut arg0.id, v0, arg2);
        };
    }

    public fun accumulated_dust_value<T0, T1, T2, T3>(arg0: &LLVPool<T0, T1>, arg1: u8, arg2: &T3) : u64 {
        assert_protocol_leg_auth<T0, T1, T3>(arg0, arg1);
        accumulated_token_value_internal<T0, T1, T2>(arg0, arg1)
    }

    fun accumulated_token_key<T0>(arg0: u8) : AccumulatedTokenKey<T0> {
        AccumulatedTokenKey<T0>{protocol_id: arg0}
    }

    public(friend) fun accumulated_token_value_internal<T0, T1, T2>(arg0: &LLVPool<T0, T1>, arg1: u8) : u64 {
        let v0 = accumulated_token_key<T2>(arg1);
        if (!0x2::dynamic_field::exists<AccumulatedTokenKey<T2>>(&arg0.id, v0)) {
            return 0
        };
        0x2::balance::value<T2>(0x2::dynamic_field::borrow<AccumulatedTokenKey<T2>, 0x2::balance::Balance<T2>>(&arg0.id, v0))
    }

    public(friend) fun add_keeper<T0, T1>(arg0: &mut LLVPool<T0, T1>, arg1: &0x2::tx_context::TxContext, arg2: address, arg3: &0x2::clock::Clock) {
        assert_pool_admin<T0, T1>(arg0, 0x2::tx_context::sender(arg1));
        assert!(arg2 != @0x0, 151);
        if (is_pool_admin<T0, T1>(arg0, arg2)) {
            return
        };
        assert!(get_acl_role<T0, T1>(arg0, arg2) != 2, 106);
        assert!(keeper_count<T0, T1>(arg0) < 50, 110);
        set_acl_role_internal<T0, T1>(arg0, arg2, 2);
        0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_events::emit_keeper_updated(0x2::object::id<LLVPool<T0, T1>>(arg0), arg2, true, 0x2::clock::timestamp_ms(arg3));
    }

    public(friend) fun add_protocol<T0, T1>(arg0: &mut LLVPool<T0, T1>, arg1: &0x2::tx_context::TxContext, arg2: u8, arg3: &0x2::clock::Clock) {
        assert_pool_admin<T0, T1>(arg0, 0x2::tx_context::sender(arg1));
        assert!(!0x2::vec_map::contains<u8, ProtocolAllocation>(&arg0.allocations, &arg2), 2);
        assert!(!0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_allocation_plan::is_idle_protocol(arg2), 2);
        let v0 = ProtocolAllocation{
            protocol_id         : arg2,
            can_supply          : false,
            can_withdraw        : false,
            deposited_amount    : 0,
            current_balance     : 0,
            last_sync_ms        : 0,
            target_ratio_bps    : 0,
            deposit_cap         : 0,
            min_deposit         : 0,
            dust_recorded_value : 0,
        };
        0x2::vec_map::insert<u8, ProtocolAllocation>(&mut arg0.allocations, arg2, v0);
        0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_events::emit_update_protocol(0x2::object::id<LLVPool<T0, T1>>(arg0), arg2, 0, false, false, 0, 0, 0, 0, 0x2::clock::timestamp_ms(arg3));
    }

    public fun allocation_info_can_supply(arg0: &AllocationInfo) : bool {
        arg0.can_supply
    }

    public fun allocation_info_can_withdraw(arg0: &AllocationInfo) : bool {
        arg0.can_withdraw
    }

    public fun allocation_info_current_balance(arg0: &AllocationInfo) : u128 {
        arg0.current_balance
    }

    public fun allocation_info_deposit_cap(arg0: &AllocationInfo) : u128 {
        arg0.deposit_cap
    }

    public fun allocation_info_deposited_amount(arg0: &AllocationInfo) : u128 {
        arg0.deposited_amount
    }

    public fun allocation_info_dust_recorded_value(arg0: &AllocationInfo) : u128 {
        arg0.dust_recorded_value
    }

    public fun allocation_info_last_sync_ms(arg0: &AllocationInfo) : u64 {
        arg0.last_sync_ms
    }

    public fun allocation_info_min_deposit(arg0: &AllocationInfo) : u64 {
        arg0.min_deposit
    }

    public fun allocation_info_protocol_id(arg0: &AllocationInfo) : u8 {
        arg0.protocol_id
    }

    public fun allocation_info_target_ratio_bps(arg0: &AllocationInfo) : u64 {
        arg0.target_ratio_bps
    }

    public fun alphalend_position_cap_key() : AlphaLendPositionCapKey {
        AlphaLendPositionCapKey{dummy_field: false}
    }

    fun anchor_fee_collection_if_first_enabled<T0, T1>(arg0: &mut LLVPool<T0, T1>, arg1: bool, arg2: u128, arg3: u64) {
        if (arg1 && (arg0.management_fee_bps > 0 || arg0.performance_fee_bps > 0)) {
            arg0.last_fee_collection_ms = arg3;
            arg0.last_total_assets = arg2;
            reset_fee_accrual_state<T0, T1>(arg0);
        };
    }

    public(friend) fun assert_all_protocols_fresh<T0, T1>(arg0: &LLVPool<T0, T1>, arg1: u64) {
        let v0 = 0;
        while (v0 < 0x2::vec_map::length<u8, ProtocolAllocation>(&arg0.allocations)) {
            let (v1, _) = 0x2::vec_map::get_entry_by_idx<u8, ProtocolAllocation>(&arg0.allocations, v0);
            assert_protocol_fresh<T0, T1>(arg0, *v1, arg1);
            v0 = v0 + 1;
        };
    }

    public(friend) fun assert_deposit_cap<T0, T1>(arg0: &LLVPool<T0, T1>, arg1: u128, arg2: u64) {
        assert!(check_deposit_cap<T0, T1>(arg0, arg1, arg2), 100);
    }

    public fun assert_fee_recipient_set<T0, T1>(arg0: &LLVPool<T0, T1>) {
        assert!(arg0.fee_recipient != @0x0, 122);
    }

    public fun assert_keeper<T0, T1>(arg0: &LLVPool<T0, T1>, arg1: address) {
        assert!(is_keeper<T0, T1>(arg0, arg1), 102);
    }

    public fun assert_keeper_or_pool_admin<T0, T1>(arg0: &LLVPool<T0, T1>, arg1: address) {
        assert!(is_keeper<T0, T1>(arg0, arg1), 102);
    }

    public fun assert_keeper_reward_claim_prologue<T0, T1>(arg0: &0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_admin::LLVGlobal, arg1: &LLVPool<T0, T1>, arg2: address) {
        0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_admin::assert_version(arg0);
        assert_keeper<T0, T1>(arg1, arg2);
        assert_fee_recipient_set<T0, T1>(arg1);
    }

    public fun assert_no_active_operation_for_maintenance<T0, T1>(arg0: &LLVPool<T0, T1>) {
        assert_no_operation_in_progress<T0, T1>(arg0);
    }

    public(friend) fun assert_no_operation_in_progress<T0, T1>(arg0: &LLVPool<T0, T1>) {
        assert!(!arg0.operation_in_progress, 135);
    }

    public fun assert_pool_admin<T0, T1>(arg0: &LLVPool<T0, T1>, arg1: address) {
        assert!(is_pool_admin<T0, T1>(arg0, arg1), 147);
    }

    public(friend) fun assert_protocol_fresh<T0, T1>(arg0: &LLVPool<T0, T1>, arg1: u8, arg2: u64) {
        if (!0x2::vec_map::contains<u8, ProtocolAllocation>(&arg0.allocations, &arg1)) {
            return
        };
        let v0 = 0x2::vec_map::get<u8, ProtocolAllocation>(&arg0.allocations, &arg1);
        let v1 = if (!0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_allocation_plan::is_idle_protocol(arg1)) {
            if (v0.current_balance + v0.dust_recorded_value > 0) {
                arg0.max_balance_age_ms > 0
            } else {
                false
            }
        } else {
            false
        };
        if (v1) {
            let v2 = if (arg2 > v0.last_sync_ms) {
                arg2 - v0.last_sync_ms
            } else {
                0
            };
            assert!(v2 <= arg0.max_balance_age_ms, 136);
        };
    }

    public(friend) fun assert_protocol_leg_auth<T0, T1, T2>(arg0: &LLVPool<T0, T1>, arg1: u8) {
        assert!(0x2::dynamic_field::exists<ProtocolLegAuthKey<T2>>(&arg0.id, protocol_leg_auth_key<T2>(arg1)), 115);
        let v0 = get_protocol_config<T0, T1>(arg0, arg1);
        let v1 = config_get_authorized_auth_type(&v0);
        assert!(0x1::vector::length<u8>(&v1) > 0, 123);
        assert!(0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T2>())) == v1, 124);
    }

    public fun assert_real_shares_guard_for_deposit<T0, T1>(arg0: &LLVPool<T0, T1>, arg1: u128) {
        if (arg1 == 0) {
            return
        };
        assert!(real_share_supply<T0, T1>(arg0) >= arg0.min_real_shares_guard, 146);
    }

    public fun assert_rebalance_allowed<T0, T1>(arg0: &LLVPool<T0, T1>, arg1: u64) {
        assert!(check_rebalance_allowed<T0, T1>(arg0, arg1), 103);
    }

    public fun assert_refresh_gate<T0, T1>(arg0: &LLVPool<T0, T1>, arg1: u8, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert_keeper_or_pool_admin<T0, T1>(arg0, 0x2::tx_context::sender(arg3));
    }

    public fun asset_decimals<T0, T1>(arg0: &LLVPool<T0, T1>) : u8 {
        arg0.asset_decimals
    }

    public(friend) fun begin_operation<T0, T1>(arg0: &mut LLVPool<T0, T1>) {
        assert!(!arg0.operation_in_progress, 135);
        arg0.operation_in_progress = true;
    }

    public fun begin_reward_compound<T0, T1>(arg0: &LLVPool<T0, T1>, arg1: u8, arg2: u64, arg3: &0x2::tx_context::TxContext) : RewardCompoundReceipt {
        RewardCompoundReceipt{
            pool_id               : 0x2::object::id<LLVPool<T0, T1>>(arg0),
            protocol_id           : arg1,
            sender                : 0x2::tx_context::sender(arg3),
            claimed_reward_amount : arg2,
        }
    }

    public(friend) fun borrow_uid<T0, T1>(arg0: &LLVPool<T0, T1>) : &0x2::object::UID {
        &arg0.id
    }

    public(friend) fun borrow_uid_mut<T0, T1>(arg0: &mut LLVPool<T0, T1>) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public fun bps_denominator() : u64 {
        10000
    }

    fun check_deposit_cap<T0, T1>(arg0: &LLVPool<T0, T1>, arg1: u128, arg2: u64) : bool {
        if (arg0.deposit_cap == 0) {
            return true
        };
        arg1 + (arg2 as u128) <= arg0.deposit_cap
    }

    public fun check_rebalance_allowed<T0, T1>(arg0: &LLVPool<T0, T1>, arg1: u64) : bool {
        if (arg0.last_rebalance_ms == 0) {
            return true
        };
        arg1 >= arg0.last_rebalance_ms + arg0.min_rebalance_interval_ms
    }

    public(friend) fun claim_fee_shares<T0, T1>(arg0: &mut LLVPool<T0, T1>, arg1: address, arg2: &mut 0x2::tx_context::TxContext, arg3: &0x2::clock::Clock) : (0x2::coin::Coin<T1>, u128) {
        assert!(!arg0.operation_in_progress, 135);
        assert!(arg1 == arg0.fee_recipient, 108);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        let v1 = get_total_assets<T0, T1>(arg0);
        accrue_fees<T0, T1>(arg0, v1, v0);
        let v2 = arg0.fee_recipient_shares;
        assert!(v2 > 0, 109);
        arg0.fee_recipient_shares = 0;
        arg0.last_fee_collection_ms = v0;
        assert!(v2 <= 18446744073709551615, 114);
        (0x2::coin::mint<T1>(&mut arg0.share_treasury, (v2 as u64), arg2), 0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_math::calculate_assets_for_shares(total_shares<T0, T1>(arg0), get_total_assets<T0, T1>(arg0), v2))
    }

    public fun compensate_from_idle<T0, T1, T2>(arg0: &mut LLVPool<T0, T1>, arg1: u8, arg2: u64, arg3: &T2) : 0x2::balance::Balance<T0> {
        assert_protocol_leg_auth<T0, T1, T2>(arg0, arg1);
        withdraw_idle_balance_internal<T0, T1>(arg0, arg2)
    }

    public fun complete_reward_compound<T0, T1>(arg0: RewardCompoundReceipt, arg1: &LLVPool<T0, T1>, arg2: u8, arg3: &0x2::tx_context::TxContext) : u64 {
        let RewardCompoundReceipt {
            pool_id               : v0,
            protocol_id           : v1,
            sender                : v2,
            claimed_reward_amount : v3,
        } = arg0;
        assert!(v0 == 0x2::object::id<LLVPool<T0, T1>>(arg1), 156);
        assert!(v1 == arg2, 156);
        assert!(v2 == 0x2::tx_context::sender(arg3), 156);
        v3
    }

    public fun config_get_asset_type(arg0: &ProtocolConfig) : vector<u8> {
        let v0 = 1;
        if (0x2::vec_map::contains<u8, vector<u8>>(&arg0.type_bytes, &v0)) {
            *0x2::vec_map::get<u8, vector<u8>>(&arg0.type_bytes, &v0)
        } else {
            b""
        }
    }

    public fun config_get_authorized_auth_type(arg0: &ProtocolConfig) : vector<u8> {
        let v0 = 2;
        if (0x2::vec_map::contains<u8, vector<u8>>(&arg0.type_bytes, &v0)) {
            *0x2::vec_map::get<u8, vector<u8>>(&arg0.type_bytes, &v0)
        } else {
            b""
        }
    }

    public fun config_get_htoken_type(arg0: &ProtocolConfig) : vector<u8> {
        let v0 = 0;
        if (0x2::vec_map::contains<u8, vector<u8>>(&arg0.type_bytes, &v0)) {
            *0x2::vec_map::get<u8, vector<u8>>(&arg0.type_bytes, &v0)
        } else {
            b""
        }
    }

    public fun config_get_id(arg0: &ProtocolConfig, arg1: u64) : 0x1::option::Option<0x2::object::ID> {
        if (arg1 < 0x1::vector::length<0x2::object::ID>(&arg0.ids)) {
            0x1::option::some<0x2::object::ID>(*0x1::vector::borrow<0x2::object::ID>(&arg0.ids, arg1))
        } else {
            0x1::option::none<0x2::object::ID>()
        }
    }

    public fun config_get_pool_id(arg0: &ProtocolConfig) : 0x2::object::ID {
        assert!(0x1::vector::length<0x2::object::ID>(&arg0.ids) > 0, 133);
        *0x1::vector::borrow<0x2::object::ID>(&arg0.ids, 0)
    }

    public fun config_get_typed_id(arg0: &ProtocolConfig, arg1: &vector<u8>) : 0x1::option::Option<0x2::object::ID> {
        if (0x2::vec_map::contains<vector<u8>, 0x2::object::ID>(&arg0.typed_ids, arg1)) {
            0x1::option::some<0x2::object::ID>(*0x2::vec_map::get<vector<u8>, 0x2::object::ID>(&arg0.typed_ids, arg1))
        } else {
            0x1::option::none<0x2::object::ID>()
        }
    }

    public fun config_get_value(arg0: &ProtocolConfig, arg1: u64) : 0x1::option::Option<u64> {
        if (arg1 < 0x1::vector::length<u64>(&arg0.values)) {
            0x1::option::some<u64>(*0x1::vector::borrow<u64>(&arg0.values, arg1))
        } else {
            0x1::option::none<u64>()
        }
    }

    public fun config_id_count(arg0: &ProtocolConfig) : u64 {
        0x1::vector::length<0x2::object::ID>(&arg0.ids)
    }

    public fun config_info_config(arg0: &ProtocolConfigInfo) : &ProtocolConfig {
        &arg0.config
    }

    public fun config_info_protocol_id(arg0: &ProtocolConfigInfo) : u8 {
        arg0.protocol_id
    }

    public(friend) fun create_config(arg0: vector<0x2::object::ID>, arg1: vector<u64>, arg2: 0x2::vec_map::VecMap<u8, vector<u8>>) : ProtocolConfig {
        ProtocolConfig{
            ids        : arg0,
            values     : arg1,
            type_bytes : arg2,
            typed_ids  : 0x2::vec_map::empty<vector<u8>, 0x2::object::ID>(),
        }
    }

    public(friend) fun create_pool<T0, T1>(arg0: &0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_admin::LLVGlobalAdminCap, arg1: 0x1::string::String, arg2: address, arg3: 0x2::coin::TreasuryCap<T1>, arg4: u8, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : LLVPool<T0, T1> {
        assert!(arg4 >= 6 && arg4 <= 12, 112);
        assert!(0x2::coin::total_supply<T1>(&arg3) == 0, 113);
        assert!(arg2 != @0x0, 122);
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::push_back<u8>(&mut v0, 0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_allocation_plan::PROTOCOL_IDLE());
        let v1 = LLVPool<T0, T1>{
            id                          : 0x2::object::new(arg6),
            name                        : arg1,
            allocations                 : 0x2::vec_map::empty<u8, ProtocolAllocation>(),
            protocol_configs            : 0x2::vec_map::empty<u8, ProtocolConfig>(),
            share_treasury              : arg3,
            asset_decimals              : arg4,
            paused                      : false,
            min_deposit                 : 0x1::u64::pow(10, arg4),
            deposit_cap                 : 0,
            supply_queue                : b"",
            withdraw_queue              : v0,
            fee_recipient               : arg2,
            fee_recipient_shares        : 0,
            performance_fee_bps         : 0,
            management_fee_bps          : 0,
            management_fee_cap_bps      : 500,
            last_fee_collection_ms      : 0,
            last_total_assets           : 0,
            fee_accrual_state           : empty_fee_accrual_state(),
            acl                         : 0x2::vec_map::empty<address, u64>(),
            last_rebalance_ms           : 0,
            min_rebalance_interval_ms   : 60000,
            min_rebalance_deviation_bps : 100,
            max_sync_deviation_bps      : 100,
            max_accounted_value_gap_bps : 5,
            operation_in_progress       : false,
            max_balance_age_ms          : 300000,
            min_shares                  : min_shares_floor(arg4),
            min_real_shares_guard       : min_shares_floor(arg4),
        };
        0x2::vec_map::insert<address, u64>(&mut v1.acl, 0x2::tx_context::sender(arg6), 1);
        let v2 = 0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_allocation_plan::PROTOCOL_IDLE();
        let v3 = ProtocolAllocation{
            protocol_id         : v2,
            can_supply          : true,
            can_withdraw        : true,
            deposited_amount    : 0,
            current_balance     : 0,
            last_sync_ms        : 0,
            target_ratio_bps    : 10000,
            deposit_cap         : 0,
            min_deposit         : 0,
            dust_recorded_value : 0,
        };
        0x2::vec_map::insert<u8, ProtocolAllocation>(&mut v1.allocations, v2, v3);
        0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_events::emit_pool_created(0x2::object::id<LLVPool<T0, T1>>(&v1), 0x1::type_name::with_defining_ids<T0>(), 0x2::tx_context::sender(arg6), v1.paused, v1.min_deposit, v1.deposit_cap, v1.performance_fee_bps, v1.management_fee_bps, v1.fee_recipient, v1.min_rebalance_interval_ms, v1.min_rebalance_deviation_bps, 0x2::clock::timestamp_ms(arg5));
        v1
    }

    public fun default_management_fee_cap_bps() : u64 {
        500
    }

    public fun default_max_accounted_value_gap_bps() : u64 {
        5
    }

    public fun default_max_sync_deviation_bps() : u64 {
        100
    }

    public fun default_min_rebalance_deviation_bps() : u64 {
        100
    }

    public fun default_min_rebalance_interval_ms() : u64 {
        60000
    }

    public(friend) fun deposit_idle_balance_internal<T0, T1>(arg0: &mut LLVPool<T0, T1>, arg1: 0x2::balance::Balance<T0>) {
        let v0 = 0x2::balance::value<T0>(&arg1);
        if (v0 == 0) {
            0x2::balance::destroy_zero<T0>(arg1);
            return
        };
        store_or_join_idle_balance<T0, T1>(arg0, arg1);
        record_deposit<T0, T1>(arg0, 0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_allocation_plan::PROTOCOL_IDLE(), (v0 as u128), 0);
        refresh_idle_balance<T0, T1>(arg0);
    }

    public fun deposit_to_idle<T0, T1, T2>(arg0: &mut LLVPool<T0, T1>, arg1: u8, arg2: 0x2::balance::Balance<T0>, arg3: &T2) {
        assert_protocol_leg_auth<T0, T1, T2>(arg0, arg1);
        deposit_idle_balance_internal<T0, T1>(arg0, arg2);
    }

    public(friend) fun empty_config() : ProtocolConfig {
        ProtocolConfig{
            ids        : 0x1::vector::empty<0x2::object::ID>(),
            values     : vector[],
            type_bytes : 0x2::vec_map::empty<u8, vector<u8>>(),
            typed_ids  : 0x2::vec_map::empty<vector<u8>, 0x2::object::ID>(),
        }
    }

    fun empty_fee_accrual_state() : FeeAccrualState {
        FeeAccrualState{
            management_share_remainder  : 0,
            performance_asset_remainder : 0,
            performance_pending_assets  : 0,
        }
    }

    public(friend) fun end_operation<T0, T1>(arg0: &mut LLVPool<T0, T1>) {
        arg0.operation_in_progress = false;
    }

    public(friend) fun extract_balance<T0, T1, T2>(arg0: &mut LLVPool<T0, T1>, arg1: u8, arg2: u64) : 0x2::balance::Balance<T2> {
        let v0 = borrow_uid_mut<T0, T1>(arg0);
        if (!0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::protocol_holdings::exists<0x2::balance::Balance<T2>>(v0, arg1)) {
            return 0x2::balance::zero<T2>()
        };
        let v1 = 0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::protocol_holdings::borrow_mut<0x2::balance::Balance<T2>>(v0, arg1);
        if (0x2::balance::value<T2>(v1) <= arg2) {
            0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::protocol_holdings::remove<0x2::balance::Balance<T2>>(v0, arg1)
        } else {
            0x2::balance::split<T2>(v1, arg2)
        }
    }

    public(friend) fun extract_idle_balance<T0, T1>(arg0: &mut LLVPool<T0, T1>, arg1: u64) : 0x2::balance::Balance<T0> {
        let v0 = borrow_uid_mut<T0, T1>(arg0);
        let v1 = 0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_allocation_plan::PROTOCOL_IDLE();
        if (!0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::protocol_holdings::exists<0x2::balance::Balance<T0>>(v0, v1)) {
            return 0x2::balance::zero<T0>()
        };
        let v2 = 0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::protocol_holdings::borrow_mut<0x2::balance::Balance<T0>>(v0, v1);
        if (arg1 >= 0x2::balance::value<T0>(v2)) {
            0x2::balance::withdraw_all<T0>(v2)
        } else {
            0x2::balance::split<T0>(v2, arg1)
        }
    }

    public fun extract_protocol_cap_by_auth<T0, T1, T2: copy + drop + store, T3: store, T4>(arg0: &mut LLVPool<T0, T1>, arg1: u8, arg2: T2, arg3: &T4) : T3 {
        assert_protocol_leg_auth<T0, T1, T4>(arg0, arg1);
        0x2::dynamic_field::remove<T2, T3>(&mut arg0.id, arg2)
    }

    public fun get_acl_role<T0, T1>(arg0: &LLVPool<T0, T1>, arg1: address) : u64 {
        if (0x2::vec_map::contains<address, u64>(&arg0.acl, &arg1)) {
            *0x2::vec_map::get<address, u64>(&arg0.acl, &arg1)
        } else {
            0
        }
    }

    public fun get_all_allocations<T0, T1>(arg0: &LLVPool<T0, T1>) : vector<AllocationInfo> {
        let v0 = 0x1::vector::empty<AllocationInfo>();
        let v1 = 0;
        while (v1 < 0x2::vec_map::length<u8, ProtocolAllocation>(&arg0.allocations)) {
            let (_, v3) = 0x2::vec_map::get_entry_by_idx<u8, ProtocolAllocation>(&arg0.allocations, v1);
            let v4 = AllocationInfo{
                protocol_id         : v3.protocol_id,
                can_supply          : v3.can_supply,
                can_withdraw        : v3.can_withdraw,
                deposited_amount    : v3.deposited_amount,
                current_balance     : v3.current_balance,
                dust_recorded_value : v3.dust_recorded_value,
                last_sync_ms        : v3.last_sync_ms,
                target_ratio_bps    : v3.target_ratio_bps,
                deposit_cap         : v3.deposit_cap,
                min_deposit         : v3.min_deposit,
            };
            0x1::vector::push_back<AllocationInfo>(&mut v0, v4);
            v1 = v1 + 1;
        };
        v0
    }

    public fun get_all_protocol_configs<T0, T1>(arg0: &LLVPool<T0, T1>) : vector<ProtocolConfigInfo> {
        let v0 = 0x1::vector::empty<ProtocolConfigInfo>();
        let v1 = 0;
        while (v1 < 0x2::vec_map::length<u8, ProtocolConfig>(&arg0.protocol_configs)) {
            let (v2, v3) = 0x2::vec_map::get_entry_by_idx<u8, ProtocolConfig>(&arg0.protocol_configs, v1);
            let v4 = ProtocolConfigInfo{
                protocol_id : *v2,
                config      : *v3,
            };
            0x1::vector::push_back<ProtocolConfigInfo>(&mut v0, v4);
            v1 = v1 + 1;
        };
        v0
    }

    public fun get_all_protocol_ids<T0, T1>(arg0: &LLVPool<T0, T1>) : vector<u8> {
        let v0 = b"";
        let v1 = 0;
        while (v1 < 0x2::vec_map::length<u8, ProtocolAllocation>(&arg0.allocations)) {
            let (v2, _) = 0x2::vec_map::get_entry_by_idx<u8, ProtocolAllocation>(&arg0.allocations, v1);
            0x1::vector::push_back<u8>(&mut v0, *v2);
            v1 = v1 + 1;
        };
        v0
    }

    public fun get_deposit_cap<T0, T1>(arg0: &LLVPool<T0, T1>) : u128 {
        arg0.deposit_cap
    }

    public fun get_enabled_protocol_ids<T0, T1>(arg0: &LLVPool<T0, T1>) : vector<u8> {
        let v0 = b"";
        let v1 = 0;
        while (v1 < 0x2::vec_map::length<u8, ProtocolAllocation>(&arg0.allocations)) {
            let (v2, v3) = 0x2::vec_map::get_entry_by_idx<u8, ProtocolAllocation>(&arg0.allocations, v1);
            if (v3.can_supply || v3.can_withdraw) {
                0x1::vector::push_back<u8>(&mut v0, *v2);
            };
            v1 = v1 + 1;
        };
        v0
    }

    public fun get_fee_recipient<T0, T1>(arg0: &LLVPool<T0, T1>) : address {
        arg0.fee_recipient
    }

    public fun get_fee_recipient_shares<T0, T1>(arg0: &LLVPool<T0, T1>) : u128 {
        arg0.fee_recipient_shares
    }

    public fun get_keepers<T0, T1>(arg0: &LLVPool<T0, T1>) : vector<address> {
        let v0 = vector[];
        let v1 = 0;
        while (v1 < 0x2::vec_map::length<address, u64>(&arg0.acl)) {
            let (v2, v3) = 0x2::vec_map::get_entry_by_idx<address, u64>(&arg0.acl, v1);
            if (*v3 == 2) {
                0x1::vector::push_back<address>(&mut v0, *v2);
            };
            v1 = v1 + 1;
        };
        v0
    }

    public fun get_last_fee_collection_ms<T0, T1>(arg0: &LLVPool<T0, T1>) : u64 {
        arg0.last_fee_collection_ms
    }

    public fun get_last_rebalance_ms<T0, T1>(arg0: &LLVPool<T0, T1>) : u64 {
        arg0.last_rebalance_ms
    }

    public fun get_last_total_assets<T0, T1>(arg0: &LLVPool<T0, T1>) : u128 {
        arg0.last_total_assets
    }

    public fun get_management_fee_bps<T0, T1>(arg0: &LLVPool<T0, T1>) : u64 {
        arg0.management_fee_bps
    }

    public fun get_management_fee_cap_bps<T0, T1>(arg0: &LLVPool<T0, T1>) : u64 {
        arg0.management_fee_cap_bps
    }

    public fun get_max_accounted_value_gap_bps<T0, T1>(arg0: &LLVPool<T0, T1>) : u64 {
        arg0.max_accounted_value_gap_bps
    }

    public fun get_max_balance_age_ms<T0, T1>(arg0: &LLVPool<T0, T1>) : u64 {
        arg0.max_balance_age_ms
    }

    public fun get_max_sync_deviation_bps<T0, T1>(arg0: &LLVPool<T0, T1>) : u64 {
        arg0.max_sync_deviation_bps
    }

    public fun get_min_deposit<T0, T1>(arg0: &LLVPool<T0, T1>) : u64 {
        arg0.min_deposit
    }

    public fun get_min_real_shares_guard<T0, T1>(arg0: &LLVPool<T0, T1>) : u128 {
        arg0.min_real_shares_guard
    }

    public fun get_min_rebalance_deviation_bps<T0, T1>(arg0: &LLVPool<T0, T1>) : u64 {
        arg0.min_rebalance_deviation_bps
    }

    public fun get_min_rebalance_interval_ms<T0, T1>(arg0: &LLVPool<T0, T1>) : u64 {
        arg0.min_rebalance_interval_ms
    }

    public fun get_min_shares<T0, T1>(arg0: &LLVPool<T0, T1>) : u128 {
        arg0.min_shares
    }

    public fun get_performance_fee_bps<T0, T1>(arg0: &LLVPool<T0, T1>) : u64 {
        arg0.performance_fee_bps
    }

    public fun get_pool_state_snapshot<T0, T1>(arg0: &LLVPool<T0, T1>) : (vector<u8>, vector<u8>, vector<AllocationInfo>, vector<ProtocolConfigInfo>, u128, u128) {
        (arg0.supply_queue, arg0.withdraw_queue, get_all_allocations<T0, T1>(arg0), get_all_protocol_configs<T0, T1>(arg0), total_shares<T0, T1>(arg0), get_total_assets<T0, T1>(arg0))
    }

    public fun get_protocol_balance<T0, T1>(arg0: &LLVPool<T0, T1>, arg1: u8) : u128 {
        if (!0x2::vec_map::contains<u8, ProtocolAllocation>(&arg0.allocations, &arg1)) {
            return 0
        };
        0x2::vec_map::get<u8, ProtocolAllocation>(&arg0.allocations, &arg1).current_balance
    }

    public fun get_protocol_config<T0, T1>(arg0: &LLVPool<T0, T1>, arg1: u8) : ProtocolConfig {
        if (0x2::vec_map::contains<u8, ProtocolConfig>(&arg0.protocol_configs, &arg1)) {
            *0x2::vec_map::get<u8, ProtocolConfig>(&arg0.protocol_configs, &arg1)
        } else {
            empty_config()
        }
    }

    public fun get_protocol_deposit_cap<T0, T1>(arg0: &LLVPool<T0, T1>, arg1: u8) : u128 {
        if (0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_allocation_plan::is_idle_protocol(arg1)) {
            return 0
        };
        if (!0x2::vec_map::contains<u8, ProtocolAllocation>(&arg0.allocations, &arg1)) {
            return 0
        };
        0x2::vec_map::get<u8, ProtocolAllocation>(&arg0.allocations, &arg1).deposit_cap
    }

    public fun get_protocol_deposited_amount<T0, T1>(arg0: &LLVPool<T0, T1>, arg1: u8) : u128 {
        if (!0x2::vec_map::contains<u8, ProtocolAllocation>(&arg0.allocations, &arg1)) {
            return 0
        };
        0x2::vec_map::get<u8, ProtocolAllocation>(&arg0.allocations, &arg1).deposited_amount
    }

    public fun get_protocol_last_sync_ms<T0, T1>(arg0: &LLVPool<T0, T1>, arg1: u8) : u64 {
        if (!0x2::vec_map::contains<u8, ProtocolAllocation>(&arg0.allocations, &arg1)) {
            return 0
        };
        0x2::vec_map::get<u8, ProtocolAllocation>(&arg0.allocations, &arg1).last_sync_ms
    }

    public fun get_protocol_min_deposit<T0, T1>(arg0: &LLVPool<T0, T1>, arg1: u8) : u64 {
        if (0x2::vec_map::contains<u8, ProtocolAllocation>(&arg0.allocations, &arg1)) {
            0x2::vec_map::get<u8, ProtocolAllocation>(&arg0.allocations, &arg1).min_deposit
        } else {
            0
        }
    }

    public fun get_protocol_ratio<T0, T1>(arg0: &LLVPool<T0, T1>, arg1: u8) : u64 {
        if (!0x2::vec_map::contains<u8, ProtocolAllocation>(&arg0.allocations, &arg1)) {
            return 0
        };
        0x2::vec_map::get<u8, ProtocolAllocation>(&arg0.allocations, &arg1).target_ratio_bps
    }

    public fun get_protocol_remaining_capacity<T0, T1>(arg0: &LLVPool<T0, T1>, arg1: u8) : u128 {
        if (!0x2::vec_map::contains<u8, ProtocolAllocation>(&arg0.allocations, &arg1)) {
            return 0
        };
        let v0 = get_protocol_deposit_cap<T0, T1>(arg0, arg1);
        let v1 = get_protocol_balance<T0, T1>(arg0, arg1);
        if (v0 == 0) {
            340282366920938463463374607431768211455
        } else if (v0 > v1) {
            v0 - v1
        } else {
            0
        }
    }

    public fun get_required_idle_balance<T0, T1>(arg0: &LLVPool<T0, T1>) : u128 {
        get_total_assets<T0, T1>(arg0) * (get_protocol_ratio<T0, T1>(arg0, 0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_allocation_plan::PROTOCOL_IDLE()) as u128) / (10000 as u128)
    }

    public fun get_supply_queue<T0, T1>(arg0: &LLVPool<T0, T1>) : vector<u8> {
        arg0.supply_queue
    }

    public fun get_total_assets<T0, T1>(arg0: &LLVPool<T0, T1>) : u128 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x2::vec_map::length<u8, ProtocolAllocation>(&arg0.allocations)) {
            let (_, v3) = 0x2::vec_map::get_entry_by_idx<u8, ProtocolAllocation>(&arg0.allocations, v1);
            let v4 = v0 + v3.current_balance;
            v0 = v4 + v3.dust_recorded_value;
            v1 = v1 + 1;
        };
        v0
    }

    public fun get_total_enabled_ratio<T0, T1>(arg0: &LLVPool<T0, T1>) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x2::vec_map::length<u8, ProtocolAllocation>(&arg0.allocations)) {
            let (_, v3) = 0x2::vec_map::get_entry_by_idx<u8, ProtocolAllocation>(&arg0.allocations, v1);
            if (v3.can_supply || v3.can_withdraw) {
                v0 = v0 + v3.target_ratio_bps;
            };
            v1 = v1 + 1;
        };
        v0
    }

    public fun get_withdraw_queue<T0, T1>(arg0: &LLVPool<T0, T1>) : vector<u8> {
        arg0.withdraw_queue
    }

    public(friend) fun grant_pool_admin<T0, T1>(arg0: &mut LLVPool<T0, T1>, arg1: &0x2::tx_context::TxContext, arg2: address) {
        assert_pool_admin<T0, T1>(arg0, 0x2::tx_context::sender(arg1));
        assert!(arg2 != @0x0, 151);
        assert!(!is_pool_admin<T0, T1>(arg0, arg2), 148);
        set_acl_role_internal<T0, T1>(arg0, arg2, 1);
    }

    public fun has_claimable_fee_shares<T0, T1>(arg0: &LLVPool<T0, T1>) : bool {
        arg0.fee_recipient_shares > 0
    }

    public fun has_protocol_cap<T0, T1, T2: copy + drop + store>(arg0: &LLVPool<T0, T1>, arg1: T2) : bool {
        0x2::dynamic_field::exists<T2>(&arg0.id, arg1)
    }

    public fun has_protocol_config<T0, T1>(arg0: &LLVPool<T0, T1>, arg1: u8) : bool {
        0x2::vec_map::contains<u8, ProtocolConfig>(&arg0.protocol_configs, &arg1)
    }

    public(friend) fun inject_reward_to_idle<T0, T1>(arg0: &mut LLVPool<T0, T1>, arg1: &0x2::tx_context::TxContext, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock) {
        assert_keeper_or_pool_admin<T0, T1>(arg0, 0x2::tx_context::sender(arg1));
        assert!(real_share_supply<T0, T1>(arg0) >= required_real_shares_for_reward_injection<T0, T1>(arg0, 0x2::coin::value<T0>(&arg2)), 146);
        let v0 = get_total_assets<T0, T1>(arg0);
        accrue_fees<T0, T1>(arg0, v0, 0x2::clock::timestamp_ms(arg3));
        store_or_join_idle_balance<T0, T1>(arg0, 0x2::coin::into_balance<T0>(arg2));
        refresh_idle_balance<T0, T1>(arg0);
    }

    public fun is_keeper<T0, T1>(arg0: &LLVPool<T0, T1>, arg1: address) : bool {
        let v0 = get_acl_role<T0, T1>(arg0, arg1);
        v0 == 2 || v0 == 1
    }

    public fun is_paused<T0, T1>(arg0: &LLVPool<T0, T1>) : bool {
        arg0.paused
    }

    public fun is_pool_admin<T0, T1>(arg0: &LLVPool<T0, T1>, arg1: address) : bool {
        get_acl_role<T0, T1>(arg0, arg1) == 1
    }

    public fun is_protocol_registered<T0, T1>(arg0: &LLVPool<T0, T1>, arg1: u8) : bool {
        0x2::vec_map::contains<u8, ProtocolAllocation>(&arg0.allocations, &arg1)
    }

    public fun is_protocol_supply_enabled<T0, T1>(arg0: &LLVPool<T0, T1>, arg1: u8) : bool {
        if (!0x2::vec_map::contains<u8, ProtocolAllocation>(&arg0.allocations, &arg1)) {
            return false
        };
        0x2::vec_map::get<u8, ProtocolAllocation>(&arg0.allocations, &arg1).can_supply
    }

    public fun is_protocol_withdraw_enabled<T0, T1>(arg0: &LLVPool<T0, T1>, arg1: u8) : bool {
        if (!0x2::vec_map::contains<u8, ProtocolAllocation>(&arg0.allocations, &arg1)) {
            return false
        };
        0x2::vec_map::get<u8, ProtocolAllocation>(&arg0.allocations, &arg1).can_withdraw
    }

    fun keeper_count<T0, T1>(arg0: &LLVPool<T0, T1>) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x2::vec_map::length<address, u64>(&arg0.acl)) {
            let (_, v3) = 0x2::vec_map::get_entry_by_idx<address, u64>(&arg0.acl, v1);
            if (*v3 == 2) {
                v0 = v0 + 1;
            };
            v1 = v1 + 1;
        };
        v0
    }

    public fun max_accounted_value_gap_for_input<T0, T1>(arg0: &LLVPool<T0, T1>, arg1: u64) : u64 {
        if (arg1 == 0 || arg0.max_accounted_value_gap_bps == 0) {
            return 0
        };
        let v0 = 0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_math::mul_div_ceil((arg1 as u128), (arg0.max_accounted_value_gap_bps as u128), (10000 as u128));
        if (v0 > 18446744073709551615) {
            18446744073709551615
        } else {
            (v0 as u64)
        }
    }

    public fun max_management_fee_cap_bps() : u64 {
        2000
    }

    public fun max_performance_fee_bps() : u64 {
        5000
    }

    public fun milliseconds_per_year() : u128 {
        31536000000
    }

    public fun min_shares_floor(arg0: u8) : u128 {
        let v0 = if (arg0 >= 5 + 3) {
            arg0 - 3
        } else {
            5
        };
        0x1::u128::pow(10, v0)
    }

    public fun name<T0, T1>(arg0: &LLVPool<T0, T1>) : &0x1::string::String {
        &arg0.name
    }

    public fun navi_account_cap_key() : NaviAccountCapKey {
        NaviAccountCapKey{dummy_field: false}
    }

    public(friend) fun pause<T0, T1>(arg0: &mut LLVPool<T0, T1>, arg1: &0x2::tx_context::TxContext) {
        assert_pool_admin<T0, T1>(arg0, 0x2::tx_context::sender(arg1));
        arg0.paused = true;
    }

    fun pool_admin_count<T0, T1>(arg0: &LLVPool<T0, T1>) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x2::vec_map::length<address, u64>(&arg0.acl)) {
            let (v2, v3) = 0x2::vec_map::get_entry_by_idx<address, u64>(&arg0.acl, v1);
            if (*v3 == 1 && *v2 != @0x0) {
                v0 = v0 + 1;
            };
            v1 = v1 + 1;
        };
        v0
    }

    public fun protocol_count<T0, T1>(arg0: &LLVPool<T0, T1>) : u64 {
        0x2::vec_map::length<u8, ProtocolAllocation>(&arg0.allocations)
    }

    fun protocol_leg_auth_key<T0>(arg0: u8) : ProtocolLegAuthKey<T0> {
        ProtocolLegAuthKey<T0>{protocol_id: arg0}
    }

    public fun query_dust_recorded_value<T0, T1>(arg0: &LLVPool<T0, T1>, arg1: u8) : u128 {
        if (0x2::vec_map::contains<u8, ProtocolAllocation>(&arg0.allocations, &arg1)) {
            0x2::vec_map::get<u8, ProtocolAllocation>(&arg0.allocations, &arg1).dust_recorded_value
        } else {
            0
        }
    }

    public fun query_holding_balance<T0, T1, T2>(arg0: &LLVPool<T0, T1>, arg1: u8) : u64 {
        let v0 = borrow_uid<T0, T1>(arg0);
        if (0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::protocol_holdings::exists<0x2::balance::Balance<T2>>(v0, arg1)) {
            0x2::balance::value<T2>(0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::protocol_holdings::borrow<0x2::balance::Balance<T2>>(v0, arg1))
        } else {
            0
        }
    }

    public fun query_idle_holding_balance<T0, T1>(arg0: &LLVPool<T0, T1>) : u64 {
        query_holding_balance<T0, T1, T0>(arg0, 0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_allocation_plan::PROTOCOL_IDLE())
    }

    public(friend) fun real_share_supply<T0, T1>(arg0: &LLVPool<T0, T1>) : u128 {
        (0x2::coin::total_supply<T1>(&arg0.share_treasury) as u128)
    }

    public(friend) fun record_deposit<T0, T1>(arg0: &mut LLVPool<T0, T1>, arg1: u8, arg2: u128, arg3: u64) {
        assert!(0x2::vec_map::contains<u8, ProtocolAllocation>(&arg0.allocations, &arg1), 3);
        let v0 = 0x2::vec_map::get_mut<u8, ProtocolAllocation>(&mut arg0.allocations, &arg1);
        v0.deposited_amount = v0.deposited_amount + arg2;
        v0.current_balance = v0.current_balance + arg2;
        v0.last_sync_ms = arg3;
    }

    public fun record_leg_side_deduction<T0, T1, T2>(arg0: &mut LLVPool<T0, T1>, arg1: u8, arg2: u128, arg3: &T2) {
        assert_protocol_leg_auth<T0, T1, T2>(arg0, arg1);
        if (arg2 == 0) {
            return
        };
        let v0 = 0x2::vec_map::get_idx_opt<u8, ProtocolAllocation>(&arg0.allocations, &arg1);
        if (0x1::option::is_none<u64>(&v0)) {
            return
        };
        let (_, v2) = 0x2::vec_map::get_entry_by_idx_mut<u8, ProtocolAllocation>(&mut arg0.allocations, *0x1::option::borrow<u64>(&v0));
        let v3 = if (v2.deposited_amount >= arg2) {
            v2.deposited_amount - arg2
        } else {
            0
        };
        v2.deposited_amount = v3;
        let v4 = if (v2.current_balance >= arg2) {
            v2.current_balance - arg2
        } else {
            0
        };
        v2.current_balance = v4;
    }

    public(friend) fun record_withdraw<T0, T1>(arg0: &mut LLVPool<T0, T1>, arg1: u8, arg2: u128, arg3: u64) {
        assert!(0x2::vec_map::contains<u8, ProtocolAllocation>(&arg0.allocations, &arg1), 3);
        let v0 = 0x2::vec_map::get_mut<u8, ProtocolAllocation>(&mut arg0.allocations, &arg1);
        assert!(v0.current_balance >= arg2, 117);
        let v1 = if (v0.deposited_amount >= arg2) {
            v0.deposited_amount - arg2
        } else {
            0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_events::emit_withdraw_saturation(0x2::object::id<LLVPool<T0, T1>>(arg0), arg1, 0, v0.deposited_amount, arg2);
            0
        };
        v0.deposited_amount = v1;
        v0.current_balance = v0.current_balance - arg2;
        v0.last_sync_ms = arg3;
    }

    public(friend) fun refresh_idle_balance<T0, T1>(arg0: &mut LLVPool<T0, T1>) {
        let v0 = 0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_allocation_plan::PROTOCOL_IDLE();
        if (0x2::vec_map::contains<u8, ProtocolAllocation>(&arg0.allocations, &v0)) {
            0x2::vec_map::get_mut<u8, ProtocolAllocation>(&mut arg0.allocations, &v0).current_balance = (query_idle_holding_balance<T0, T1>(arg0) as u128);
        };
    }

    public fun register_protocol_leg_auth<T0, T1, T2>(arg0: &mut LLVPool<T0, T1>, arg1: u8, arg2: &0x2::tx_context::TxContext) {
        register_protocol_leg_auth_internal<T0, T1, T2>(arg0, 0x2::tx_context::sender(arg2), arg1);
    }

    fun register_protocol_leg_auth_internal<T0, T1, T2>(arg0: &mut LLVPool<T0, T1>, arg1: address, arg2: u8) {
        assert_pool_admin<T0, T1>(arg0, arg1);
        assert!(0x2::vec_map::contains<u8, ProtocolAllocation>(&arg0.allocations, &arg2), 3);
        let v0 = get_protocol_config<T0, T1>(arg0, arg2);
        let v1 = config_get_authorized_auth_type(&v0);
        assert!(0x1::vector::length<u8>(&v1) > 0, 123);
        assert!(0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T2>())) == v1, 124);
        let v2 = protocol_leg_auth_key<T2>(arg2);
        if (!0x2::dynamic_field::exists<ProtocolLegAuthKey<T2>>(&arg0.id, v2)) {
            0x2::dynamic_field::add<ProtocolLegAuthKey<T2>, bool>(&mut arg0.id, v2, true);
        };
    }

    public(friend) fun remove_keeper<T0, T1>(arg0: &mut LLVPool<T0, T1>, arg1: &0x2::tx_context::TxContext, arg2: address, arg3: &0x2::clock::Clock) {
        assert_pool_admin<T0, T1>(arg0, 0x2::tx_context::sender(arg1));
        assert!(get_acl_role<T0, T1>(arg0, arg2) == 2, 107);
        let (_, _) = 0x2::vec_map::remove<address, u64>(&mut arg0.acl, &arg2);
        0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_events::emit_keeper_updated(0x2::object::id<LLVPool<T0, T1>>(arg0), arg2, false, 0x2::clock::timestamp_ms(arg3));
    }

    fun required_real_shares_for_reward_injection<T0, T1>(arg0: &LLVPool<T0, T1>, arg1: u64) : u128 {
        let v0 = (arg1 as u128) * 10;
        let v1 = arg0.min_real_shares_guard;
        if (v0 > v1) {
            v0
        } else {
            v1
        }
    }

    fun reset_fee_accrual_state<T0, T1>(arg0: &mut LLVPool<T0, T1>) {
        let v0 = &mut arg0.fee_accrual_state;
        v0.management_share_remainder = 0;
        v0.performance_asset_remainder = 0;
        v0.performance_pending_assets = 0;
    }

    public fun return_protocol_cap_by_auth<T0, T1, T2: copy + drop + store, T3: store, T4>(arg0: &mut LLVPool<T0, T1>, arg1: u8, arg2: T2, arg3: T3, arg4: &T4) {
        assert_protocol_leg_auth<T0, T1, T4>(arg0, arg1);
        0x2::dynamic_field::add<T2, T3>(&mut arg0.id, arg2, arg3);
    }

    public(friend) fun revoke_pool_admin<T0, T1>(arg0: &mut LLVPool<T0, T1>, arg1: &0x2::tx_context::TxContext, arg2: address) {
        assert_pool_admin<T0, T1>(arg0, 0x2::tx_context::sender(arg1));
        assert!(is_pool_admin<T0, T1>(arg0, arg2), 149);
        assert!(pool_admin_count<T0, T1>(arg0) > 1, 150);
        let (_, _) = 0x2::vec_map::remove<address, u64>(&mut arg0.acl, &arg2);
    }

    public fun role_keeper() : u64 {
        2
    }

    public fun role_pool_admin() : u64 {
        1
    }

    public fun scallop_spool_account_key() : ScallopSpoolAccountKey {
        ScallopSpoolAccountKey{dummy_field: false}
    }

    fun set_acl_role_internal<T0, T1>(arg0: &mut LLVPool<T0, T1>, arg1: address, arg2: u64) {
        if (0x2::vec_map::contains<address, u64>(&arg0.acl, &arg1)) {
            *0x2::vec_map::get_mut<address, u64>(&mut arg0.acl, &arg1) = arg2;
        } else {
            0x2::vec_map::insert<address, u64>(&mut arg0.acl, arg1, arg2);
        };
    }

    public(friend) fun set_deposit_cap<T0, T1>(arg0: &mut LLVPool<T0, T1>, arg1: &0x2::tx_context::TxContext, arg2: u128) {
        assert_pool_admin<T0, T1>(arg0, 0x2::tx_context::sender(arg1));
        arg0.deposit_cap = arg2;
    }

    public(friend) fun set_fee_recipient<T0, T1>(arg0: &mut LLVPool<T0, T1>, arg1: &0x2::tx_context::TxContext, arg2: address, arg3: &0x2::clock::Clock) {
        assert_pool_admin<T0, T1>(arg0, 0x2::tx_context::sender(arg1));
        assert!(arg2 != @0x0, 122);
        let v0 = get_total_assets<T0, T1>(arg0);
        accrue_fees<T0, T1>(arg0, v0, 0x2::clock::timestamp_ms(arg3));
        arg0.fee_recipient = arg2;
    }

    public(friend) fun set_management_fee<T0, T1>(arg0: &mut LLVPool<T0, T1>, arg1: &0x2::tx_context::TxContext, arg2: u64, arg3: &0x2::clock::Clock) {
        assert_pool_admin<T0, T1>(arg0, 0x2::tx_context::sender(arg1));
        assert!(arg2 <= get_management_fee_cap_bps<T0, T1>(arg0), 104);
        let v0 = if (arg0.management_fee_bps == 0) {
            arg0.performance_fee_bps == 0
        } else {
            false
        };
        let v1 = get_total_assets<T0, T1>(arg0);
        let v2 = 0x2::clock::timestamp_ms(arg3);
        accrue_fees<T0, T1>(arg0, v1, v2);
        arg0.management_fee_bps = arg2;
        anchor_fee_collection_if_first_enabled<T0, T1>(arg0, v0, v1, v2);
        if (arg0.management_fee_bps == 0 && arg0.performance_fee_bps == 0) {
            reset_fee_accrual_state<T0, T1>(arg0);
        };
    }

    public(friend) fun set_management_fee_cap_bps<T0, T1>(arg0: &mut LLVPool<T0, T1>, arg1: &0x2::tx_context::TxContext, arg2: u64) {
        assert_pool_admin<T0, T1>(arg0, 0x2::tx_context::sender(arg1));
        assert!(arg2 <= 2000, 104);
        assert!(arg2 >= arg0.management_fee_bps, 104);
        arg0.management_fee_cap_bps = arg2;
    }

    public(friend) fun set_max_accounted_value_gap_bps<T0, T1>(arg0: &mut LLVPool<T0, T1>, arg1: &0x2::tx_context::TxContext, arg2: u64) {
        assert_pool_admin<T0, T1>(arg0, 0x2::tx_context::sender(arg1));
        assert!(arg2 <= 100, 145);
        arg0.max_accounted_value_gap_bps = arg2;
    }

    public(friend) fun set_max_balance_age_ms<T0, T1>(arg0: &mut LLVPool<T0, T1>, arg1: &0x2::tx_context::TxContext, arg2: u64) {
        assert_pool_admin<T0, T1>(arg0, 0x2::tx_context::sender(arg1));
        arg0.max_balance_age_ms = arg2;
    }

    public(friend) fun set_max_sync_deviation_bps<T0, T1>(arg0: &mut LLVPool<T0, T1>, arg1: &0x2::tx_context::TxContext, arg2: u64) {
        assert_pool_admin<T0, T1>(arg0, 0x2::tx_context::sender(arg1));
        arg0.max_sync_deviation_bps = arg2;
    }

    public(friend) fun set_min_deposit<T0, T1>(arg0: &mut LLVPool<T0, T1>, arg1: &0x2::tx_context::TxContext, arg2: u64) {
        assert_pool_admin<T0, T1>(arg0, 0x2::tx_context::sender(arg1));
        arg0.min_deposit = arg2;
    }

    public(friend) fun set_min_real_shares_guard<T0, T1>(arg0: &mut LLVPool<T0, T1>, arg1: &0x2::tx_context::TxContext, arg2: u128) {
        assert_pool_admin<T0, T1>(arg0, 0x2::tx_context::sender(arg1));
        arg0.min_real_shares_guard = arg2;
    }

    public(friend) fun set_min_rebalance_deviation<T0, T1>(arg0: &mut LLVPool<T0, T1>, arg1: &0x2::tx_context::TxContext, arg2: u64) {
        assert_pool_admin<T0, T1>(arg0, 0x2::tx_context::sender(arg1));
        assert!(arg2 >= 10, 121);
        arg0.min_rebalance_deviation_bps = arg2;
    }

    public(friend) fun set_min_rebalance_interval<T0, T1>(arg0: &mut LLVPool<T0, T1>, arg1: &0x2::tx_context::TxContext, arg2: u64) {
        assert_pool_admin<T0, T1>(arg0, 0x2::tx_context::sender(arg1));
        assert!(arg2 >= 60000, 120);
        arg0.min_rebalance_interval_ms = arg2;
    }

    public(friend) fun set_min_shares<T0, T1>(arg0: &mut LLVPool<T0, T1>, arg1: &0x2::tx_context::TxContext, arg2: u128) {
        assert_pool_admin<T0, T1>(arg0, 0x2::tx_context::sender(arg1));
        arg0.min_shares = arg2;
    }

    public(friend) fun set_name<T0, T1>(arg0: &mut LLVPool<T0, T1>, arg1: &0x2::tx_context::TxContext, arg2: 0x1::string::String) {
        assert_pool_admin<T0, T1>(arg0, 0x2::tx_context::sender(arg1));
        arg0.name = arg2;
    }

    public(friend) fun set_performance_fee<T0, T1>(arg0: &mut LLVPool<T0, T1>, arg1: &0x2::tx_context::TxContext, arg2: u64, arg3: &0x2::clock::Clock) {
        assert_pool_admin<T0, T1>(arg0, 0x2::tx_context::sender(arg1));
        assert!(arg2 <= 5000, 104);
        let v0 = if (arg0.management_fee_bps == 0) {
            arg0.performance_fee_bps == 0
        } else {
            false
        };
        let v1 = get_total_assets<T0, T1>(arg0);
        let v2 = 0x2::clock::timestamp_ms(arg3);
        accrue_fees<T0, T1>(arg0, v1, v2);
        arg0.performance_fee_bps = arg2;
        anchor_fee_collection_if_first_enabled<T0, T1>(arg0, v0, v1, v2);
        if (arg0.management_fee_bps == 0 && arg0.performance_fee_bps == 0) {
            reset_fee_accrual_state<T0, T1>(arg0);
        };
    }

    public(friend) fun set_protocol_authorized_auth_type<T0, T1>(arg0: &mut LLVPool<T0, T1>, arg1: &0x2::tx_context::TxContext, arg2: u8, arg3: vector<u8>, arg4: &0x2::clock::Clock) {
        set_protocol_authorized_auth_type_internal<T0, T1>(arg0, 0x2::tx_context::sender(arg1), arg2, arg3, arg4);
    }

    fun set_protocol_authorized_auth_type_internal<T0, T1>(arg0: &mut LLVPool<T0, T1>, arg1: address, arg2: u8, arg3: vector<u8>, arg4: &0x2::clock::Clock) {
        assert_pool_admin<T0, T1>(arg0, arg1);
        assert!(0x2::vec_map::contains<u8, ProtocolAllocation>(&arg0.allocations, &arg2), 3);
        let ProtocolConfig {
            ids        : v0,
            values     : v1,
            type_bytes : v2,
            typed_ids  : v3,
        } = get_protocol_config<T0, T1>(arg0, arg2);
        let v4 = v2;
        let v5 = 2;
        if (0x2::vec_map::contains<u8, vector<u8>>(&v4, &v5)) {
            *0x2::vec_map::get_mut<u8, vector<u8>>(&mut v4, &v5) = arg3;
        } else {
            0x2::vec_map::insert<u8, vector<u8>>(&mut v4, v5, arg3);
        };
        let v6 = ProtocolConfig{
            ids        : v0,
            values     : v1,
            type_bytes : v4,
            typed_ids  : v3,
        };
        set_protocol_config_internal<T0, T1>(arg0, arg1, arg2, v6, arg4);
    }

    public(friend) fun set_protocol_config<T0, T1>(arg0: &mut LLVPool<T0, T1>, arg1: &0x2::tx_context::TxContext, arg2: u8, arg3: ProtocolConfig, arg4: &0x2::clock::Clock) {
        set_protocol_config_internal<T0, T1>(arg0, 0x2::tx_context::sender(arg1), arg2, arg3, arg4);
    }

    fun set_protocol_config_internal<T0, T1>(arg0: &mut LLVPool<T0, T1>, arg1: address, arg2: u8, arg3: ProtocolConfig, arg4: &0x2::clock::Clock) {
        assert_pool_admin<T0, T1>(arg0, arg1);
        let v0 = !0x2::vec_map::contains<u8, ProtocolConfig>(&arg0.protocol_configs, &arg2);
        if (!v0) {
            *0x2::vec_map::get_mut<u8, ProtocolConfig>(&mut arg0.protocol_configs, &arg2) = arg3;
        } else {
            0x2::vec_map::insert<u8, ProtocolConfig>(&mut arg0.protocol_configs, arg2, arg3);
        };
        let v1 = vector[];
        let v2 = 0;
        let v3 = 1;
        if (0x2::vec_map::contains<u8, vector<u8>>(&arg3.type_bytes, &v2)) {
            0x1::vector::push_back<vector<u8>>(&mut v1, *0x2::vec_map::get<u8, vector<u8>>(&arg3.type_bytes, &v2));
        } else {
            0x1::vector::push_back<vector<u8>>(&mut v1, b"");
        };
        if (0x2::vec_map::contains<u8, vector<u8>>(&arg3.type_bytes, &v3)) {
            0x1::vector::push_back<vector<u8>>(&mut v1, *0x2::vec_map::get<u8, vector<u8>>(&arg3.type_bytes, &v3));
        } else {
            0x1::vector::push_back<vector<u8>>(&mut v1, b"");
        };
        0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_events::emit_update_protocol_config(0x2::object::id<LLVPool<T0, T1>>(arg0), arg2, v0, arg3.ids, arg3.values, v1, 0x2::clock::timestamp_ms(arg4));
    }

    public(friend) fun set_protocol_deposit_cap<T0, T1>(arg0: &mut LLVPool<T0, T1>, arg1: &0x2::tx_context::TxContext, arg2: u8, arg3: u128) {
        assert_pool_admin<T0, T1>(arg0, 0x2::tx_context::sender(arg1));
        assert!(!0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_allocation_plan::is_idle_protocol(arg2), 130);
        assert!(0x2::vec_map::contains<u8, ProtocolAllocation>(&arg0.allocations, &arg2), 3);
        0x2::vec_map::get_mut<u8, ProtocolAllocation>(&mut arg0.allocations, &arg2).deposit_cap = arg3;
    }

    public(friend) fun set_protocol_min_deposit<T0, T1>(arg0: &mut LLVPool<T0, T1>, arg1: &0x2::tx_context::TxContext, arg2: u8, arg3: u64) {
        assert_pool_admin<T0, T1>(arg0, 0x2::tx_context::sender(arg1));
        assert!(!0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_allocation_plan::is_idle_protocol(arg2), 130);
        assert!(0x2::vec_map::contains<u8, ProtocolAllocation>(&arg0.allocations, &arg2), 3);
        0x2::vec_map::get_mut<u8, ProtocolAllocation>(&mut arg0.allocations, &arg2).min_deposit = arg3;
    }

    public(friend) fun set_protocol_status<T0, T1>(arg0: &mut LLVPool<T0, T1>, arg1: &0x2::tx_context::TxContext, arg2: u8, arg3: bool, arg4: bool, arg5: &0x2::clock::Clock) {
        assert_pool_admin<T0, T1>(arg0, 0x2::tx_context::sender(arg1));
        assert!(!0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_allocation_plan::is_idle_protocol(arg2), 130);
        assert!(0x2::vec_map::contains<u8, ProtocolAllocation>(&arg0.allocations, &arg2), 3);
        let v0 = 0x2::vec_map::get_mut<u8, ProtocolAllocation>(&mut arg0.allocations, &arg2);
        if (arg3 && v0.target_ratio_bps == 0) {
            abort 7
        };
        v0.can_supply = arg3;
        v0.can_withdraw = arg4;
        validate_withdraw_queue_coverage<T0, T1>(arg0, &arg0.withdraw_queue);
        0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_events::emit_update_protocol(0x2::object::id<LLVPool<T0, T1>>(arg0), arg2, 1, arg3, arg4, v0.target_ratio_bps, v0.deposited_amount, v0.current_balance, v0.last_sync_ms, 0x2::clock::timestamp_ms(arg5));
    }

    public(friend) fun set_protocol_targets<T0, T1>(arg0: &mut LLVPool<T0, T1>, arg1: &0x2::tx_context::TxContext, arg2: vector<u8>, arg3: vector<u64>, arg4: vector<u128>, arg5: vector<bool>, arg6: vector<bool>, arg7: &0x2::clock::Clock) {
        assert_pool_admin<T0, T1>(arg0, 0x2::tx_context::sender(arg1));
        update_protocol_targets_internal<T0, T1>(arg0, arg2, arg3, arg4, arg5, arg6, arg7);
        validate_withdraw_queue_coverage<T0, T1>(arg0, &arg0.withdraw_queue);
    }

    public(friend) fun set_supply_queue<T0, T1>(arg0: &mut LLVPool<T0, T1>, arg1: &0x2::tx_context::TxContext, arg2: vector<u8>) {
        assert_pool_admin<T0, T1>(arg0, 0x2::tx_context::sender(arg1));
        validate_queue<T0, T1>(arg0, &arg2);
        arg0.supply_queue = arg2;
    }

    public(friend) fun set_targets_and_queues<T0, T1>(arg0: &mut LLVPool<T0, T1>, arg1: &0x2::tx_context::TxContext, arg2: vector<u8>, arg3: vector<u64>, arg4: vector<u128>, arg5: vector<bool>, arg6: vector<bool>, arg7: vector<u8>, arg8: vector<u8>, arg9: &0x2::clock::Clock) {
        assert_pool_admin<T0, T1>(arg0, 0x2::tx_context::sender(arg1));
        update_protocol_targets_internal<T0, T1>(arg0, arg2, arg3, arg4, arg5, arg6, arg9);
        validate_queue<T0, T1>(arg0, &arg7);
        arg0.supply_queue = arg7;
        validate_queue<T0, T1>(arg0, &arg8);
        validate_withdraw_queue_coverage<T0, T1>(arg0, &arg8);
        arg0.withdraw_queue = arg8;
    }

    public(friend) fun set_withdraw_queue<T0, T1>(arg0: &mut LLVPool<T0, T1>, arg1: &0x2::tx_context::TxContext, arg2: vector<u8>) {
        assert_pool_admin<T0, T1>(arg0, 0x2::tx_context::sender(arg1));
        validate_queue<T0, T1>(arg0, &arg2);
        validate_withdraw_queue_coverage<T0, T1>(arg0, &arg2);
        arg0.withdraw_queue = arg2;
    }

    public(friend) fun share_pool<T0, T1>(arg0: LLVPool<T0, T1>) {
        0x2::transfer::share_object<LLVPool<T0, T1>>(arg0);
    }

    public(friend) fun share_treasury_mut<T0, T1>(arg0: &mut LLVPool<T0, T1>) : &mut 0x2::coin::TreasuryCap<T1> {
        &mut arg0.share_treasury
    }

    public fun should_trigger_accrue<T0, T1>(arg0: &LLVPool<T0, T1>, arg1: u8, arg2: &0x2::clock::Clock) : bool {
        get_protocol_last_sync_ms<T0, T1>(arg0, arg1) != 0x2::clock::timestamp_ms(arg2)
    }

    public(friend) fun store_or_join_balance<T0, T1, T2>(arg0: &mut LLVPool<T0, T1>, arg1: u8, arg2: 0x2::balance::Balance<T2>) {
        let v0 = borrow_uid_mut<T0, T1>(arg0);
        if (0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::protocol_holdings::exists<0x2::balance::Balance<T2>>(v0, arg1)) {
            0x2::balance::join<T2>(0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::protocol_holdings::borrow_mut<0x2::balance::Balance<T2>>(v0, arg1), arg2);
        } else {
            0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::protocol_holdings::store<0x2::balance::Balance<T2>>(v0, arg1, arg2);
        };
    }

    public(friend) fun store_or_join_idle_balance<T0, T1>(arg0: &mut LLVPool<T0, T1>, arg1: 0x2::balance::Balance<T0>) {
        store_or_join_balance<T0, T1, T0>(arg0, 0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_allocation_plan::PROTOCOL_IDLE(), arg1);
    }

    public fun store_protocol_cap<T0, T1, T2: copy + drop + store, T3: store>(arg0: &mut LLVPool<T0, T1>, arg1: T2, arg2: T3, arg3: &0x2::tx_context::TxContext) {
        assert_pool_admin<T0, T1>(arg0, 0x2::tx_context::sender(arg3));
        0x2::dynamic_field::add<T2, T3>(&mut arg0.id, arg1, arg2);
    }

    public fun suilend_obligation_cap_key() : SuilendObligationCapKey {
        SuilendObligationCapKey{dummy_field: false}
    }

    public fun take_accumulated_dust<T0, T1, T2, T3>(arg0: &mut LLVPool<T0, T1>, arg1: u8, arg2: &T3) : (0x2::balance::Balance<T2>, u128) {
        assert_protocol_leg_auth<T0, T1, T3>(arg0, arg1);
        let v0 = take_accumulated_token_internal<T0, T1, T2>(arg0, arg1);
        let v1 = if (0x2::vec_map::contains<u8, ProtocolAllocation>(&arg0.allocations, &arg1)) {
            let v2 = 0x2::vec_map::get_mut<u8, ProtocolAllocation>(&mut arg0.allocations, &arg1);
            v2.dust_recorded_value = 0;
            v2.dust_recorded_value
        } else {
            0
        };
        (v0, v1)
    }

    public(friend) fun take_accumulated_token_internal<T0, T1, T2>(arg0: &mut LLVPool<T0, T1>, arg1: u8) : 0x2::balance::Balance<T2> {
        let v0 = accumulated_token_key<T2>(arg1);
        if (!0x2::dynamic_field::exists<AccumulatedTokenKey<T2>>(&arg0.id, v0)) {
            return 0x2::balance::zero<T2>()
        };
        0x2::dynamic_field::remove<AccumulatedTokenKey<T2>, 0x2::balance::Balance<T2>>(&mut arg0.id, v0)
    }

    public fun total_shares<T0, T1>(arg0: &LLVPool<T0, T1>) : u128 {
        (0x2::coin::total_supply<T1>(&arg0.share_treasury) as u128) + arg0.fee_recipient_shares
    }

    public(friend) fun unpause<T0, T1>(arg0: &mut LLVPool<T0, T1>, arg1: &0x2::tx_context::TxContext) {
        assert_pool_admin<T0, T1>(arg0, 0x2::tx_context::sender(arg1));
        arg0.paused = false;
    }

    public(friend) fun update_last_rebalance<T0, T1>(arg0: &mut LLVPool<T0, T1>, arg1: u64) {
        arg0.last_rebalance_ms = arg1;
    }

    public(friend) fun update_last_total_assets<T0, T1>(arg0: &mut LLVPool<T0, T1>, arg1: u128) {
        let v0 = total_shares<T0, T1>(arg0);
        let v1 = if (arg0.last_total_assets == 0) {
            true
        } else if (arg1 == 0) {
            true
        } else {
            v0 == 0
        };
        if (v1) {
            arg0.last_total_assets = get_total_assets<T0, T1>(arg0);
            return
        };
        arg0.last_total_assets = 0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_math::mul_div_ceil(arg0.last_total_assets, v0, arg1);
    }

    public(friend) fun update_protocol_balance<T0, T1>(arg0: &mut LLVPool<T0, T1>, arg1: u8, arg2: u128, arg3: u64) {
        if (0x2::vec_map::contains<u8, ProtocolAllocation>(&arg0.allocations, &arg1)) {
            let v0 = 0x2::vec_map::get_mut<u8, ProtocolAllocation>(&mut arg0.allocations, &arg1);
            v0.current_balance = arg2;
            v0.last_sync_ms = arg3;
        };
    }

    fun update_protocol_targets_internal<T0, T1>(arg0: &mut LLVPool<T0, T1>, arg1: vector<u8>, arg2: vector<u64>, arg3: vector<u128>, arg4: vector<bool>, arg5: vector<bool>, arg6: &0x2::clock::Clock) {
        let v0 = 0x1::vector::length<u8>(&arg1);
        assert!(v0 == 0x1::vector::length<u64>(&arg2), 131);
        assert!(v0 == 0x1::vector::length<u128>(&arg3), 131);
        assert!(v0 == 0x1::vector::length<bool>(&arg4), 131);
        assert!(v0 == 0x1::vector::length<bool>(&arg5), 131);
        assert!(v0 == 0x2::vec_map::length<u8, ProtocolAllocation>(&arg0.allocations), 132);
        let v1 = 0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_allocation_plan::PROTOCOL_IDLE();
        let v2 = 0;
        while (v2 < v0) {
            let v3 = *0x1::vector::borrow<u8>(&arg1, v2);
            let v4 = *0x1::vector::borrow<u64>(&arg2, v2);
            let v5 = *0x1::vector::borrow<u128>(&arg3, v2);
            let v6 = *0x1::vector::borrow<bool>(&arg4, v2);
            let v7 = *0x1::vector::borrow<bool>(&arg5, v2);
            assert!(0x2::vec_map::contains<u8, ProtocolAllocation>(&arg0.allocations, &v3), 3);
            let v8 = 0;
            while (v8 < v2) {
                assert!(*0x1::vector::borrow<u8>(&arg1, v8) != v3, 132);
                v8 = v8 + 1;
            };
            if (v3 == v1) {
                assert!(v6 && v7, 130);
                assert!(v5 == 0, 130);
            };
            if (v6 && v3 != v1) {
                assert!(v4 > 0, 7);
            };
            let v9 = 0x2::vec_map::get_mut<u8, ProtocolAllocation>(&mut arg0.allocations, &v3);
            v9.target_ratio_bps = v4;
            v9.deposit_cap = v5;
            v9.can_supply = v6;
            v9.can_withdraw = v7;
            v2 = v2 + 1;
        };
        assert!(get_total_enabled_ratio<T0, T1>(arg0) == 10000, 6);
        0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_events::emit_protocol_targets_updated(0x2::object::id<LLVPool<T0, T1>>(arg0), arg1, arg2, arg3, arg4, arg5, 0x2::clock::timestamp_ms(arg6));
    }

    public(friend) fun upsert_protocol_typed_id<T0, T1>(arg0: &mut LLVPool<T0, T1>, arg1: &0x2::tx_context::TxContext, arg2: u8, arg3: vector<u8>, arg4: 0x2::object::ID) {
        assert_pool_admin<T0, T1>(arg0, 0x2::tx_context::sender(arg1));
        assert!(0x2::vec_map::contains<u8, ProtocolConfig>(&arg0.protocol_configs, &arg2), 138);
        let v0 = 0x2::vec_map::get_mut<u8, ProtocolConfig>(&mut arg0.protocol_configs, &arg2);
        if (0x2::vec_map::contains<vector<u8>, 0x2::object::ID>(&v0.typed_ids, &arg3)) {
            *0x2::vec_map::get_mut<vector<u8>, 0x2::object::ID>(&mut v0.typed_ids, &arg3) = arg4;
        } else {
            0x2::vec_map::insert<vector<u8>, 0x2::object::ID>(&mut v0.typed_ids, arg3, arg4);
        };
    }

    fun validate_queue<T0, T1>(arg0: &LLVPool<T0, T1>, arg1: &vector<u8>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u8>(arg1)) {
            let v1 = *0x1::vector::borrow<u8>(arg1, v0);
            assert!(0x2::vec_map::contains<u8, ProtocolAllocation>(&arg0.allocations, &v1), 105);
            let v2 = 0;
            while (v2 < v0) {
                assert!(*0x1::vector::borrow<u8>(arg1, v2) != v1, 105);
                v2 = v2 + 1;
            };
            v0 = v0 + 1;
        };
    }

    public fun validate_total_ratio<T0, T1>(arg0: &LLVPool<T0, T1>) {
        assert!(get_total_enabled_ratio<T0, T1>(arg0) <= 10000, 6);
    }

    fun validate_withdraw_queue_coverage<T0, T1>(arg0: &LLVPool<T0, T1>, arg1: &vector<u8>) {
        let v0 = 0;
        while (v0 < 0x2::vec_map::length<u8, ProtocolAllocation>(&arg0.allocations)) {
            let (v1, v2) = 0x2::vec_map::get_entry_by_idx<u8, ProtocolAllocation>(&arg0.allocations, v0);
            let v3 = if (!0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_allocation_plan::is_idle_protocol(*v1)) {
                if (v2.can_withdraw) {
                    v2.current_balance > 0 || v2.target_ratio_bps > 0
                } else {
                    false
                }
            } else {
                false
            };
            if (v3) {
                assert!(0x1::vector::contains<u8>(arg1, v1), 137);
            };
            v0 = v0 + 1;
        };
    }

    public(friend) fun withdraw_idle_balance_internal<T0, T1>(arg0: &mut LLVPool<T0, T1>, arg1: u64) : 0x2::balance::Balance<T0> {
        if (arg1 == 0) {
            return 0x2::balance::zero<T0>()
        };
        assert!(query_idle_holding_balance<T0, T1>(arg0) >= arg1, 134);
        let v0 = extract_idle_balance<T0, T1>(arg0, arg1);
        record_withdraw<T0, T1>(arg0, 0x1191ac127b43f1a76ce9e1b8c5a8f29c0900cbb34eae69045e81edec2511d609::llv_allocation_plan::PROTOCOL_IDLE(), (arg1 as u128), 0);
        refresh_idle_balance<T0, T1>(arg0);
        v0
    }

    // decompiled from Move bytecode v7
}

