module 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_pool {
    struct ProtocolAllocation has copy, drop, store {
        protocol_id: u8,
        can_supply: bool,
        can_withdraw: bool,
        deposited_amount: u128,
        current_balance: u128,
        last_sync_ms: u64,
        target_ratio_bps: u64,
        deposit_cap: u128,
        apr_bps: u64,
    }

    struct ProtocolConfig has copy, drop, store {
        ids: vector<0x2::object::ID>,
        values: vector<u64>,
        type_bytes: 0x2::vec_map::VecMap<u8, vector<u8>>,
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
        last_fee_collection_ms: u64,
        last_total_assets: u128,
        keepers: vector<address>,
        last_rebalance_ms: u64,
        min_rebalance_interval_ms: u64,
        min_rebalance_deviation_bps: u64,
        degraded_withdraw_mode: bool,
        operation_in_progress: bool,
        max_balance_age_ms: u64,
    }

    struct ProtocolAprInfo has copy, drop {
        protocol_id: u8,
        apr_bps: u64,
        balance: u128,
    }

    struct AllocationInfo has copy, drop {
        protocol_id: u8,
        can_supply: bool,
        can_withdraw: bool,
        deposited_amount: u128,
        current_balance: u128,
        last_sync_ms: u64,
        target_ratio_bps: u64,
        deposit_cap: u128,
        apr_bps: u64,
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
        if (arg0.management_fee_bps > 0) {
            let v5 = (((arg1 as u256) * (arg0.management_fee_bps as u256) * ((arg2 - arg0.last_fee_collection_ms) as u256) / (10000 as u256) * (31536000000 as u256)) as u128);
            v3 = v5;
            let v6 = if (v5 > 0) {
                if (v0 > 0) {
                    arg1 > 0
                } else {
                    false
                }
            } else {
                false
            };
            if (v6) {
                v1 = 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_math::mul_div_ceil(v5, v0, arg1);
            };
        };
        if (arg0.performance_fee_bps > 0 && arg1 > arg0.last_total_assets) {
            let v7 = 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_math::mul_div(arg1 - arg0.last_total_assets, (arg0.performance_fee_bps as u128), (10000 as u128));
            v4 = v7;
            let v8 = if (v7 > 0) {
                if (v0 > 0) {
                    arg1 > 0
                } else {
                    false
                }
            } else {
                false
            };
            if (v8) {
                v2 = 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_math::mul_div(v7, v0, arg1);
            };
        };
        let v9 = v1 + v2;
        arg0.last_fee_collection_ms = arg2;
        if (arg1 > arg0.last_total_assets) {
            arg0.last_total_assets = arg1;
        };
        arg0.fee_recipient_shares = arg0.fee_recipient_shares + v9;
        if (v9 > 0) {
            0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_events::emit_fees_accrued(0x2::object::id<LLVPool<T0, T1>>(arg0), v1, v2, v9, arg0.fee_recipient, arg0.last_total_assets, v3, v4, arg1, v0 + v9, arg2);
        };
        v9
    }

    public fun accumulate_dust<T0, T1, T2, T3>(arg0: &mut LLVPool<T0, T1>, arg1: u8, arg2: 0x2::balance::Balance<T2>, arg3: &T3) {
        assert_protocol_leg_auth<T0, T1, T3>(arg0, arg1);
        accumulate_token_internal<T0, T1, T2>(arg0, arg1, arg2);
    }

    public(friend) fun accumulate_token_internal<T0, T1, T2>(arg0: &mut LLVPool<T0, T1>, arg1: u8, arg2: 0x2::balance::Balance<T2>) {
        if (0x2::balance::value<T2>(&arg2) == 0) {
            0x2::balance::destroy_zero<T2>(arg2);
            return
        };
        let v0 = accumulated_token_key<T2>(arg1);
        if (0x2::dynamic_field::exists_<AccumulatedTokenKey<T2>>(&arg0.id, v0)) {
            0x2::balance::join<T2>(0x2::dynamic_field::borrow_mut<AccumulatedTokenKey<T2>, 0x2::balance::Balance<T2>>(&mut arg0.id, v0), arg2);
        } else {
            0x2::dynamic_field::add<AccumulatedTokenKey<T2>, 0x2::balance::Balance<T2>>(&mut arg0.id, v0, arg2);
        };
    }

    public fun accumulated_dust_value<T0, T1, T2, T3>(arg0: &LLVPool<T0, T1>, arg1: u8, arg2: &T3) : u64 {
        assert_protocol_leg_auth<T0, T1, T3>(arg0, arg1);
        accumulated_token_value_internal<T0, T1, T2>(arg0, arg1)
    }

    public fun accumulated_token_key<T0>(arg0: u8) : AccumulatedTokenKey<T0> {
        AccumulatedTokenKey<T0>{protocol_id: arg0}
    }

    public(friend) fun accumulated_token_value_internal<T0, T1, T2>(arg0: &LLVPool<T0, T1>, arg1: u8) : u64 {
        let v0 = accumulated_token_key<T2>(arg1);
        if (!0x2::dynamic_field::exists_<AccumulatedTokenKey<T2>>(&arg0.id, v0)) {
            return 0
        };
        0x2::balance::value<T2>(0x2::dynamic_field::borrow<AccumulatedTokenKey<T2>, 0x2::balance::Balance<T2>>(&arg0.id, v0))
    }

    public(friend) fun add_keeper<T0, T1>(arg0: &mut LLVPool<T0, T1>, arg1: &0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::LLVPoolAdminCap, arg2: address, arg3: &0x2::clock::Clock) {
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::verify_pool_admin(arg1, 0x2::object::id<LLVPool<T0, T1>>(arg0));
        assert!(!0x1::vector::contains<address>(&arg0.keepers, &arg2), 106);
        assert!(0x1::vector::length<address>(&arg0.keepers) < 50, 110);
        0x1::vector::push_back<address>(&mut arg0.keepers, arg2);
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_events::emit_keeper_updated(0x2::object::id<LLVPool<T0, T1>>(arg0), arg2, true, 0x2::clock::timestamp_ms(arg3));
    }

    public(friend) fun add_protocol<T0, T1>(arg0: &mut LLVPool<T0, T1>, arg1: &0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::LLVPoolAdminCap, arg2: u8, arg3: &0x2::clock::Clock) {
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::verify_pool_admin(arg1, 0x2::object::id<LLVPool<T0, T1>>(arg0));
        assert!(!0x2::vec_map::contains<u8, ProtocolAllocation>(&arg0.allocations, &arg2), 2);
        assert!(!0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_allocation_plan::is_idle_protocol(arg2), 2);
        let v0 = ProtocolAllocation{
            protocol_id      : arg2,
            can_supply       : false,
            can_withdraw     : false,
            deposited_amount : 0,
            current_balance  : 0,
            last_sync_ms     : 0,
            target_ratio_bps : 0,
            deposit_cap      : 0,
            apr_bps          : 0,
        };
        0x2::vec_map::insert<u8, ProtocolAllocation>(&mut arg0.allocations, arg2, v0);
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_events::emit_update_protocol(0x2::object::id<LLVPool<T0, T1>>(arg0), arg2, 0, false, false, 0, 0, 0, 0, 0, 0x2::clock::timestamp_ms(arg3));
    }

    public fun allocation_info_apr_bps(arg0: &AllocationInfo) : u64 {
        arg0.apr_bps
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

    public fun allocation_info_last_sync_ms(arg0: &AllocationInfo) : u64 {
        arg0.last_sync_ms
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

    public(friend) fun assert_all_protocols_fresh<T0, T1>(arg0: &LLVPool<T0, T1>, arg1: u64) {
        let v0 = 0;
        while (v0 < 0x2::vec_map::length<u8, ProtocolAllocation>(&arg0.allocations)) {
            let (v1, _) = 0x2::vec_map::get_entry_by_idx<u8, ProtocolAllocation>(&arg0.allocations, v0);
            assert_protocol_fresh<T0, T1>(arg0, *v1, arg1);
            v0 = v0 + 1;
        };
    }

    public fun assert_deposit_cap<T0, T1>(arg0: &LLVPool<T0, T1>, arg1: u128, arg2: u64) {
        assert!(check_deposit_cap<T0, T1>(arg0, arg1, arg2), 100);
    }

    public fun assert_fee_recipient_set<T0, T1>(arg0: &LLVPool<T0, T1>) {
        assert!(arg0.fee_recipient != @0x0, 122);
    }

    public fun assert_keeper<T0, T1>(arg0: &LLVPool<T0, T1>, arg1: address) {
        assert!(is_keeper<T0, T1>(arg0, arg1), 102);
    }

    public(friend) fun assert_no_operation_in_progress<T0, T1>(arg0: &LLVPool<T0, T1>) {
        assert!(!arg0.operation_in_progress, 135);
    }

    public(friend) fun assert_protocol_fresh<T0, T1>(arg0: &LLVPool<T0, T1>, arg1: u8, arg2: u64) {
        if (!0x2::vec_map::contains<u8, ProtocolAllocation>(&arg0.allocations, &arg1)) {
            return
        };
        let v0 = 0x2::vec_map::get<u8, ProtocolAllocation>(&arg0.allocations, &arg1);
        let v1 = if (!0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_allocation_plan::is_idle_protocol(arg1)) {
            if (v0.current_balance > 0) {
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
        assert!(0x2::dynamic_field::exists_<ProtocolLegAuthKey<T2>>(&arg0.id, protocol_leg_auth_key<T2>(arg1)), 115);
    }

    public fun assert_rebalance_allowed<T0, T1>(arg0: &LLVPool<T0, T1>, arg1: u64) {
        assert!(check_rebalance_allowed<T0, T1>(arg0, arg1), 103);
    }

    public fun asset_decimals<T0, T1>(arg0: &LLVPool<T0, T1>) : u8 {
        arg0.asset_decimals
    }

    public(friend) fun begin_operation<T0, T1>(arg0: &mut LLVPool<T0, T1>) {
        assert!(!arg0.operation_in_progress, 135);
        arg0.operation_in_progress = true;
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

    public fun check_deposit_cap<T0, T1>(arg0: &LLVPool<T0, T1>, arg1: u128, arg2: u64) : bool {
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
        (0x2::coin::mint<T1>(&mut arg0.share_treasury, (v2 as u64), arg2), 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_math::calculate_assets_for_shares(total_shares<T0, T1>(arg0), get_total_assets<T0, T1>(arg0), v2))
    }

    public fun compensate_from_idle<T0, T1, T2>(arg0: &mut LLVPool<T0, T1>, arg1: u8, arg2: u64, arg3: &T2) : 0x2::balance::Balance<T0> {
        assert_protocol_leg_auth<T0, T1, T2>(arg0, arg1);
        withdraw_idle_balance_internal<T0, T1>(arg0, arg2)
    }

    public fun config_get_asset_type(arg0: &ProtocolConfig) : vector<u8> {
        let v0 = 1;
        if (0x2::vec_map::contains<u8, vector<u8>>(&arg0.type_bytes, &v0)) {
            *0x2::vec_map::get<u8, vector<u8>>(&arg0.type_bytes, &v0)
        } else {
            0x1::vector::empty<u8>()
        }
    }

    public fun config_get_authorized_auth_type(arg0: &ProtocolConfig) : vector<u8> {
        let v0 = 2;
        if (0x2::vec_map::contains<u8, vector<u8>>(&arg0.type_bytes, &v0)) {
            *0x2::vec_map::get<u8, vector<u8>>(&arg0.type_bytes, &v0)
        } else {
            0x1::vector::empty<u8>()
        }
    }

    public fun config_get_htoken_type(arg0: &ProtocolConfig) : vector<u8> {
        let v0 = 0;
        if (0x2::vec_map::contains<u8, vector<u8>>(&arg0.type_bytes, &v0)) {
            *0x2::vec_map::get<u8, vector<u8>>(&arg0.type_bytes, &v0)
        } else {
            0x1::vector::empty<u8>()
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

    public fun config_get_value(arg0: &ProtocolConfig, arg1: u64) : 0x1::option::Option<u64> {
        if (arg1 < 0x1::vector::length<u64>(&arg0.values)) {
            0x1::option::some<u64>(*0x1::vector::borrow<u64>(&arg0.values, arg1))
        } else {
            0x1::option::none<u64>()
        }
    }

    public fun create_config(arg0: vector<0x2::object::ID>, arg1: vector<u64>, arg2: 0x2::vec_map::VecMap<u8, vector<u8>>) : ProtocolConfig {
        ProtocolConfig{
            ids        : arg0,
            values     : arg1,
            type_bytes : arg2,
        }
    }

    public(friend) fun create_pool<T0, T1>(arg0: &0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::LLVGlobalAdminCap, arg1: 0x1::string::String, arg2: 0x2::coin::TreasuryCap<T1>, arg3: u8, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (LLVPool<T0, T1>, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::LLVPoolAdminCap) {
        assert!(arg3 >= 6 && arg3 <= 12, 112);
        assert!(0x2::coin::total_supply<T1>(&arg2) == 0, 113);
        let v0 = LLVPool<T0, T1>{
            id                          : 0x2::object::new(arg5),
            name                        : arg1,
            allocations                 : 0x2::vec_map::empty<u8, ProtocolAllocation>(),
            protocol_configs            : 0x2::vec_map::empty<u8, ProtocolConfig>(),
            share_treasury              : arg2,
            asset_decimals              : arg3,
            paused                      : false,
            min_deposit                 : 0x1::u64::pow(10, arg3),
            deposit_cap                 : 0,
            supply_queue                : 0x1::vector::empty<u8>(),
            withdraw_queue              : 0x1::vector::empty<u8>(),
            fee_recipient               : @0x0,
            fee_recipient_shares        : 0,
            performance_fee_bps         : 0,
            management_fee_bps          : 0,
            last_fee_collection_ms      : 0,
            last_total_assets           : 0,
            keepers                     : 0x1::vector::empty<address>(),
            last_rebalance_ms           : 0,
            min_rebalance_interval_ms   : 3600000,
            min_rebalance_deviation_bps : 100,
            degraded_withdraw_mode      : false,
            operation_in_progress       : false,
            max_balance_age_ms          : 3600000,
        };
        let v1 = 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_allocation_plan::PROTOCOL_IDLE();
        let v2 = ProtocolAllocation{
            protocol_id      : v1,
            can_supply       : true,
            can_withdraw     : true,
            deposited_amount : 0,
            current_balance  : 0,
            last_sync_ms     : 0,
            target_ratio_bps : 10000,
            deposit_cap      : 0,
            apr_bps          : 0,
        };
        0x2::vec_map::insert<u8, ProtocolAllocation>(&mut v0.allocations, v1, v2);
        let v3 = 0x2::object::id<LLVPool<T0, T1>>(&v0);
        let v4 = 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::create_pool_admin_cap(v3, arg5);
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_events::emit_pool_created(v3, 0x2::object::id<0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::LLVPoolAdminCap>(&v4), 0x1::type_name::with_defining_ids<T0>(), 0x2::tx_context::sender(arg5), v0.paused, v0.min_deposit, v0.deposit_cap, v0.performance_fee_bps, v0.management_fee_bps, v0.fee_recipient, v0.min_rebalance_interval_ms, v0.min_rebalance_deviation_bps, 0x2::clock::timestamp_ms(arg4));
        (v0, v4)
    }

    public fun default_min_rebalance_deviation_bps() : u64 {
        100
    }

    public fun default_min_rebalance_interval_ms() : u64 {
        3600000
    }

    public fun default_protocol_config() : ProtocolConfig {
        empty_config()
    }

    public(friend) fun deposit_idle_balance_internal<T0, T1>(arg0: &mut LLVPool<T0, T1>, arg1: 0x2::balance::Balance<T0>) {
        let v0 = 0x2::balance::value<T0>(&arg1);
        if (v0 == 0) {
            0x2::balance::destroy_zero<T0>(arg1);
            return
        };
        store_or_join_idle_balance<T0, T1>(arg0, arg1);
        record_deposit<T0, T1>(arg0, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_allocation_plan::PROTOCOL_IDLE(), (v0 as u128), 0);
        refresh_idle_balance<T0, T1>(arg0);
    }

    public fun deposit_to_idle<T0, T1, T2>(arg0: &mut LLVPool<T0, T1>, arg1: u8, arg2: 0x2::balance::Balance<T0>, arg3: &T2) {
        assert_protocol_leg_auth<T0, T1, T2>(arg0, arg1);
        deposit_idle_balance_internal<T0, T1>(arg0, arg2);
    }

    public fun empty_config() : ProtocolConfig {
        ProtocolConfig{
            ids        : 0x1::vector::empty<0x2::object::ID>(),
            values     : 0x1::vector::empty<u64>(),
            type_bytes : 0x2::vec_map::empty<u8, vector<u8>>(),
        }
    }

    public(friend) fun end_operation<T0, T1>(arg0: &mut LLVPool<T0, T1>) {
        arg0.operation_in_progress = false;
    }

    public(friend) fun extract_balance<T0, T1, T2>(arg0: &mut LLVPool<T0, T1>, arg1: u8, arg2: u64) : 0x2::balance::Balance<T2> {
        let v0 = borrow_uid_mut<T0, T1>(arg0);
        if (!0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::protocol_holdings::exists_<0x2::balance::Balance<T2>>(v0, arg1)) {
            return 0x2::balance::zero<T2>()
        };
        let v1 = 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::protocol_holdings::borrow_mut<0x2::balance::Balance<T2>>(v0, arg1);
        if (0x2::balance::value<T2>(v1) <= arg2) {
            0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::protocol_holdings::remove<0x2::balance::Balance<T2>>(v0, arg1)
        } else {
            0x2::balance::split<T2>(v1, arg2)
        }
    }

    public(friend) fun extract_idle_balance<T0, T1>(arg0: &mut LLVPool<T0, T1>, arg1: u64) : 0x2::balance::Balance<T0> {
        let v0 = borrow_uid_mut<T0, T1>(arg0);
        let v1 = 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_allocation_plan::PROTOCOL_IDLE();
        if (!0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::protocol_holdings::exists_<0x2::balance::Balance<T0>>(v0, v1)) {
            return 0x2::balance::zero<T0>()
        };
        let v2 = 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::protocol_holdings::borrow_mut<0x2::balance::Balance<T0>>(v0, v1);
        if (arg1 >= 0x2::balance::value<T0>(v2)) {
            0x2::balance::withdraw_all<T0>(v2)
        } else {
            0x2::balance::split<T0>(v2, arg1)
        }
    }

    public fun extract_protocol_cap<T0, T1, T2: copy + drop + store, T3: store>(arg0: &mut LLVPool<T0, T1>, arg1: &0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::LLVPoolAdminCap, arg2: T2) : T3 {
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::verify_pool_admin(arg1, 0x2::object::id<LLVPool<T0, T1>>(arg0));
        0x2::dynamic_field::remove<T2, T3>(&mut arg0.id, arg2)
    }

    public fun extract_protocol_cap_by_auth<T0, T1, T2: copy + drop + store, T3: store, T4>(arg0: &mut LLVPool<T0, T1>, arg1: u8, arg2: T2, arg3: &T4) : T3 {
        assert_protocol_leg_auth<T0, T1, T4>(arg0, arg1);
        0x2::dynamic_field::remove<T2, T3>(&mut arg0.id, arg2)
    }

    public fun get_all_allocations<T0, T1>(arg0: &LLVPool<T0, T1>) : vector<AllocationInfo> {
        let v0 = 0x1::vector::empty<AllocationInfo>();
        let v1 = 0;
        while (v1 < 0x2::vec_map::length<u8, ProtocolAllocation>(&arg0.allocations)) {
            let (_, v3) = 0x2::vec_map::get_entry_by_idx<u8, ProtocolAllocation>(&arg0.allocations, v1);
            let v4 = AllocationInfo{
                protocol_id      : v3.protocol_id,
                can_supply       : v3.can_supply,
                can_withdraw     : v3.can_withdraw,
                deposited_amount : v3.deposited_amount,
                current_balance  : v3.current_balance,
                last_sync_ms     : v3.last_sync_ms,
                target_ratio_bps : v3.target_ratio_bps,
                deposit_cap      : v3.deposit_cap,
                apr_bps          : v3.apr_bps,
            };
            0x1::vector::push_back<AllocationInfo>(&mut v0, v4);
            v1 = v1 + 1;
        };
        v0
    }

    public fun get_all_protocol_ids<T0, T1>(arg0: &LLVPool<T0, T1>) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
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
        let v0 = 0x1::vector::empty<u8>();
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
        arg0.keepers
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

    public fun get_min_deposit<T0, T1>(arg0: &LLVPool<T0, T1>) : u64 {
        arg0.min_deposit
    }

    public fun get_min_rebalance_deviation_bps<T0, T1>(arg0: &LLVPool<T0, T1>) : u64 {
        arg0.min_rebalance_deviation_bps
    }

    public fun get_min_rebalance_interval_ms<T0, T1>(arg0: &LLVPool<T0, T1>) : u64 {
        arg0.min_rebalance_interval_ms
    }

    public fun get_performance_fee_bps<T0, T1>(arg0: &LLVPool<T0, T1>) : u64 {
        arg0.performance_fee_bps
    }

    public fun get_protocol_apr<T0, T1>(arg0: &LLVPool<T0, T1>, arg1: u8) : u64 {
        if (!0x2::vec_map::contains<u8, ProtocolAllocation>(&arg0.allocations, &arg1)) {
            return 0
        };
        0x2::vec_map::get<u8, ProtocolAllocation>(&arg0.allocations, &arg1).apr_bps
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
            default_protocol_config()
        }
    }

    public fun get_protocol_deposit_cap<T0, T1>(arg0: &LLVPool<T0, T1>, arg1: u8) : u128 {
        if (0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_allocation_plan::is_idle_protocol(arg1)) {
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

    public fun get_protocols_sorted_by_apr<T0, T1>(arg0: &LLVPool<T0, T1>) : vector<ProtocolAprInfo> {
        let v0 = 0x1::vector::empty<ProtocolAprInfo>();
        let v1 = 0;
        while (v1 < 0x2::vec_map::length<u8, ProtocolAllocation>(&arg0.allocations)) {
            let (v2, v3) = 0x2::vec_map::get_entry_by_idx<u8, ProtocolAllocation>(&arg0.allocations, v1);
            if (v3.current_balance > 0) {
                let v4 = ProtocolAprInfo{
                    protocol_id : *v2,
                    apr_bps     : v3.apr_bps,
                    balance     : v3.current_balance,
                };
                0x1::vector::push_back<ProtocolAprInfo>(&mut v0, v4);
            };
            v1 = v1 + 1;
        };
        let v5 = 1;
        while (v5 < 0x1::vector::length<ProtocolAprInfo>(&v0)) {
            while (v5 > 0) {
                if (0x1::vector::borrow<ProtocolAprInfo>(&v0, v5).apr_bps < 0x1::vector::borrow<ProtocolAprInfo>(&v0, v5 - 1).apr_bps) {
                    0x1::vector::swap<ProtocolAprInfo>(&mut v0, v5, v5 - 1);
                    v5 = v5 - 1;
                } else {
                    break
                };
            };
            v5 = v5 + 1;
        };
        v0
    }

    public fun get_supply_queue<T0, T1>(arg0: &LLVPool<T0, T1>) : vector<u8> {
        arg0.supply_queue
    }

    public fun get_total_assets<T0, T1>(arg0: &LLVPool<T0, T1>) : u128 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x2::vec_map::length<u8, ProtocolAllocation>(&arg0.allocations)) {
            let (_, v3) = 0x2::vec_map::get_entry_by_idx<u8, ProtocolAllocation>(&arg0.allocations, v1);
            v0 = v0 + v3.current_balance;
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

    public fun has_claimable_fee_shares<T0, T1>(arg0: &LLVPool<T0, T1>) : bool {
        arg0.fee_recipient_shares > 0
    }

    public fun has_protocol_cap<T0, T1, T2: copy + drop + store>(arg0: &LLVPool<T0, T1>, arg1: T2) : bool {
        0x2::dynamic_field::exists_<T2>(&arg0.id, arg1)
    }

    public fun has_protocol_config<T0, T1>(arg0: &LLVPool<T0, T1>, arg1: u8) : bool {
        0x2::vec_map::contains<u8, ProtocolConfig>(&arg0.protocol_configs, &arg1)
    }

    public(friend) fun inject_reward_to_idle<T0, T1>(arg0: &mut LLVPool<T0, T1>, arg1: &0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::LLVPoolAdminCap, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock) {
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::verify_pool_admin(arg1, 0x2::object::id<LLVPool<T0, T1>>(arg0));
        let v0 = get_total_assets<T0, T1>(arg0);
        accrue_fees<T0, T1>(arg0, v0, 0x2::clock::timestamp_ms(arg3));
        store_or_join_idle_balance<T0, T1>(arg0, 0x2::coin::into_balance<T0>(arg2));
        refresh_idle_balance<T0, T1>(arg0);
    }

    public fun is_degraded_withdraw_mode<T0, T1>(arg0: &LLVPool<T0, T1>) : bool {
        arg0.degraded_withdraw_mode
    }

    public fun is_keeper<T0, T1>(arg0: &LLVPool<T0, T1>, arg1: address) : bool {
        0x1::vector::contains<address>(&arg0.keepers, &arg1)
    }

    public fun is_paused<T0, T1>(arg0: &LLVPool<T0, T1>) : bool {
        arg0.paused
    }

    public fun is_protocol_enabled<T0, T1>(arg0: &LLVPool<T0, T1>, arg1: u8) : bool {
        if (!0x2::vec_map::contains<u8, ProtocolAllocation>(&arg0.allocations, &arg1)) {
            return false
        };
        0x2::vec_map::get<u8, ProtocolAllocation>(&arg0.allocations, &arg1).can_supply
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

    public fun max_management_fee_bps() : u64 {
        500
    }

    public fun max_performance_fee_bps() : u64 {
        5000
    }

    public fun milliseconds_per_year() : u128 {
        31536000000
    }

    public fun name<T0, T1>(arg0: &LLVPool<T0, T1>) : &0x1::string::String {
        &arg0.name
    }

    public fun navi_account_cap_key() : NaviAccountCapKey {
        NaviAccountCapKey{dummy_field: false}
    }

    public(friend) fun pause<T0, T1>(arg0: &mut LLVPool<T0, T1>, arg1: &0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::LLVPoolAdminCap) {
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::verify_pool_admin(arg1, 0x2::object::id<LLVPool<T0, T1>>(arg0));
        arg0.paused = true;
    }

    public fun protocol_apr_info_apr(arg0: &ProtocolAprInfo) : u64 {
        arg0.apr_bps
    }

    public fun protocol_apr_info_balance(arg0: &ProtocolAprInfo) : u128 {
        arg0.balance
    }

    public fun protocol_apr_info_id(arg0: &ProtocolAprInfo) : u8 {
        arg0.protocol_id
    }

    public fun protocol_count<T0, T1>(arg0: &LLVPool<T0, T1>) : u64 {
        0x2::vec_map::length<u8, ProtocolAllocation>(&arg0.allocations)
    }

    public fun protocol_leg_auth_key<T0>(arg0: u8) : ProtocolLegAuthKey<T0> {
        ProtocolLegAuthKey<T0>{protocol_id: arg0}
    }

    public fun query_holding_balance<T0, T1, T2>(arg0: &LLVPool<T0, T1>, arg1: u8) : u64 {
        let v0 = borrow_uid<T0, T1>(arg0);
        if (0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::protocol_holdings::exists_<0x2::balance::Balance<T2>>(v0, arg1)) {
            0x2::balance::value<T2>(0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::protocol_holdings::borrow<0x2::balance::Balance<T2>>(v0, arg1))
        } else {
            0
        }
    }

    public fun query_idle_holding_balance<T0, T1>(arg0: &LLVPool<T0, T1>) : u64 {
        let v0 = borrow_uid<T0, T1>(arg0);
        let v1 = 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_allocation_plan::PROTOCOL_IDLE();
        if (0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::protocol_holdings::exists_<0x2::balance::Balance<T0>>(v0, v1)) {
            0x2::balance::value<T0>(0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::protocol_holdings::borrow<0x2::balance::Balance<T0>>(v0, v1))
        } else {
            0
        }
    }

    public(friend) fun record_deposit<T0, T1>(arg0: &mut LLVPool<T0, T1>, arg1: u8, arg2: u128, arg3: u64) {
        if (0x2::vec_map::contains<u8, ProtocolAllocation>(&arg0.allocations, &arg1)) {
            let v0 = 0x2::vec_map::get_mut<u8, ProtocolAllocation>(&mut arg0.allocations, &arg1);
            v0.deposited_amount = v0.deposited_amount + arg2;
            v0.current_balance = v0.current_balance + arg2;
            v0.last_sync_ms = arg3;
        };
    }

    public(friend) fun record_withdraw<T0, T1>(arg0: &mut LLVPool<T0, T1>, arg1: u8, arg2: u128, arg3: u64) {
        if (0x2::vec_map::contains<u8, ProtocolAllocation>(&arg0.allocations, &arg1)) {
            let v0 = 0x2::vec_map::get_mut<u8, ProtocolAllocation>(&mut arg0.allocations, &arg1);
            assert!(v0.current_balance >= arg2, 117);
            let v1 = if (v0.deposited_amount >= arg2) {
                v0.deposited_amount - arg2
            } else {
                0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_events::emit_withdraw_saturation(0x2::object::id<LLVPool<T0, T1>>(arg0), arg1, 0, v0.deposited_amount, arg2);
                0
            };
            v0.deposited_amount = v1;
            v0.current_balance = v0.current_balance - arg2;
            v0.last_sync_ms = arg3;
        };
    }

    public(friend) fun refresh_idle_balance<T0, T1>(arg0: &mut LLVPool<T0, T1>) {
        let v0 = 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_allocation_plan::PROTOCOL_IDLE();
        if (0x2::vec_map::contains<u8, ProtocolAllocation>(&arg0.allocations, &v0)) {
            0x2::vec_map::get_mut<u8, ProtocolAllocation>(&mut arg0.allocations, &v0).current_balance = (query_idle_holding_balance<T0, T1>(arg0) as u128);
        };
    }

    public fun register_protocol_leg_auth<T0, T1, T2>(arg0: &mut LLVPool<T0, T1>, arg1: &0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::LLVPoolAdminCap, arg2: u8) {
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::verify_pool_admin(arg1, 0x2::object::id<LLVPool<T0, T1>>(arg0));
        assert!(0x2::vec_map::contains<u8, ProtocolAllocation>(&arg0.allocations, &arg2), 3);
        let v0 = get_protocol_config<T0, T1>(arg0, arg2);
        let v1 = config_get_authorized_auth_type(&v0);
        assert!(0x1::vector::length<u8>(&v1) > 0, 123);
        assert!(0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T2>())) == v1, 124);
        let v2 = protocol_leg_auth_key<T2>(arg2);
        if (!0x2::dynamic_field::exists_<ProtocolLegAuthKey<T2>>(&arg0.id, v2)) {
            0x2::dynamic_field::add<ProtocolLegAuthKey<T2>, bool>(&mut arg0.id, v2, true);
        };
    }

    public(friend) fun remove_keeper<T0, T1>(arg0: &mut LLVPool<T0, T1>, arg1: &0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::LLVPoolAdminCap, arg2: address, arg3: &0x2::clock::Clock) {
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::verify_pool_admin(arg1, 0x2::object::id<LLVPool<T0, T1>>(arg0));
        let (v0, v1) = 0x1::vector::index_of<address>(&arg0.keepers, &arg2);
        assert!(v0, 107);
        0x1::vector::remove<address>(&mut arg0.keepers, v1);
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_events::emit_keeper_updated(0x2::object::id<LLVPool<T0, T1>>(arg0), arg2, false, 0x2::clock::timestamp_ms(arg3));
    }

    public fun return_protocol_cap<T0, T1, T2: copy + drop + store, T3: store>(arg0: &mut LLVPool<T0, T1>, arg1: &0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::LLVPoolAdminCap, arg2: T2, arg3: T3) {
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::verify_pool_admin(arg1, 0x2::object::id<LLVPool<T0, T1>>(arg0));
        0x2::dynamic_field::add<T2, T3>(&mut arg0.id, arg2, arg3);
    }

    public fun return_protocol_cap_by_auth<T0, T1, T2: copy + drop + store, T3: store, T4>(arg0: &mut LLVPool<T0, T1>, arg1: u8, arg2: T2, arg3: T3, arg4: &T4) {
        assert_protocol_leg_auth<T0, T1, T4>(arg0, arg1);
        0x2::dynamic_field::add<T2, T3>(&mut arg0.id, arg2, arg3);
    }

    public fun rotate_protocol_cap<T0, T1, T2: copy + drop + store, T3: store>(arg0: &mut LLVPool<T0, T1>, arg1: &0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::LLVPoolAdminCap, arg2: T2) : T3 {
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::verify_pool_admin(arg1, 0x2::object::id<LLVPool<T0, T1>>(arg0));
        0x2::dynamic_field::remove<T2, T3>(&mut arg0.id, arg2)
    }

    public fun scallop_spool_account_key() : ScallopSpoolAccountKey {
        ScallopSpoolAccountKey{dummy_field: false}
    }

    public(friend) fun set_degraded_withdraw_mode<T0, T1>(arg0: &mut LLVPool<T0, T1>, arg1: &0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::LLVPoolAdminCap, arg2: bool) {
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::verify_pool_admin(arg1, 0x2::object::id<LLVPool<T0, T1>>(arg0));
        arg0.degraded_withdraw_mode = arg2;
    }

    public(friend) fun set_deposit_cap<T0, T1>(arg0: &mut LLVPool<T0, T1>, arg1: &0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::LLVPoolAdminCap, arg2: u128) {
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::verify_pool_admin(arg1, 0x2::object::id<LLVPool<T0, T1>>(arg0));
        arg0.deposit_cap = arg2;
    }

    public(friend) fun set_fee_recipient<T0, T1>(arg0: &mut LLVPool<T0, T1>, arg1: &0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::LLVPoolAdminCap, arg2: address, arg3: &0x2::clock::Clock) {
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::verify_pool_admin(arg1, 0x2::object::id<LLVPool<T0, T1>>(arg0));
        let v0 = get_total_assets<T0, T1>(arg0);
        accrue_fees<T0, T1>(arg0, v0, 0x2::clock::timestamp_ms(arg3));
        arg0.fee_recipient = arg2;
    }

    public(friend) fun set_management_fee<T0, T1>(arg0: &mut LLVPool<T0, T1>, arg1: &0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::LLVPoolAdminCap, arg2: u64, arg3: &0x2::clock::Clock) {
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::verify_pool_admin(arg1, 0x2::object::id<LLVPool<T0, T1>>(arg0));
        assert!(arg2 <= 500, 104);
        let v0 = get_total_assets<T0, T1>(arg0);
        accrue_fees<T0, T1>(arg0, v0, 0x2::clock::timestamp_ms(arg3));
        arg0.management_fee_bps = arg2;
    }

    public(friend) fun set_max_balance_age_ms<T0, T1>(arg0: &mut LLVPool<T0, T1>, arg1: &0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::LLVPoolAdminCap, arg2: u64) {
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::verify_pool_admin(arg1, 0x2::object::id<LLVPool<T0, T1>>(arg0));
        arg0.max_balance_age_ms = arg2;
    }

    public(friend) fun set_min_deposit<T0, T1>(arg0: &mut LLVPool<T0, T1>, arg1: &0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::LLVPoolAdminCap, arg2: u64) {
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::verify_pool_admin(arg1, 0x2::object::id<LLVPool<T0, T1>>(arg0));
        arg0.min_deposit = arg2;
    }

    public(friend) fun set_min_rebalance_deviation<T0, T1>(arg0: &mut LLVPool<T0, T1>, arg1: &0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::LLVPoolAdminCap, arg2: u64) {
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::verify_pool_admin(arg1, 0x2::object::id<LLVPool<T0, T1>>(arg0));
        assert!(arg2 >= 10, 121);
        arg0.min_rebalance_deviation_bps = arg2;
    }

    public(friend) fun set_min_rebalance_interval<T0, T1>(arg0: &mut LLVPool<T0, T1>, arg1: &0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::LLVPoolAdminCap, arg2: u64) {
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::verify_pool_admin(arg1, 0x2::object::id<LLVPool<T0, T1>>(arg0));
        assert!(arg2 >= 60000, 120);
        arg0.min_rebalance_interval_ms = arg2;
    }

    public(friend) fun set_name<T0, T1>(arg0: &mut LLVPool<T0, T1>, arg1: &0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::LLVPoolAdminCap, arg2: 0x1::string::String) {
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::verify_pool_admin(arg1, 0x2::object::id<LLVPool<T0, T1>>(arg0));
        arg0.name = arg2;
    }

    public(friend) fun set_performance_fee<T0, T1>(arg0: &mut LLVPool<T0, T1>, arg1: &0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::LLVPoolAdminCap, arg2: u64, arg3: &0x2::clock::Clock) {
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::verify_pool_admin(arg1, 0x2::object::id<LLVPool<T0, T1>>(arg0));
        assert!(arg2 <= 5000, 104);
        let v0 = get_total_assets<T0, T1>(arg0);
        accrue_fees<T0, T1>(arg0, v0, 0x2::clock::timestamp_ms(arg3));
        arg0.performance_fee_bps = arg2;
    }

    public(friend) fun set_protocol_authorized_auth_type<T0, T1>(arg0: &mut LLVPool<T0, T1>, arg1: &0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::LLVPoolAdminCap, arg2: u8, arg3: vector<u8>, arg4: &0x2::clock::Clock) {
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::verify_pool_admin(arg1, 0x2::object::id<LLVPool<T0, T1>>(arg0));
        assert!(0x2::vec_map::contains<u8, ProtocolAllocation>(&arg0.allocations, &arg2), 3);
        let ProtocolConfig {
            ids        : v0,
            values     : v1,
            type_bytes : v2,
        } = get_protocol_config<T0, T1>(arg0, arg2);
        let v3 = v2;
        let v4 = 2;
        if (0x2::vec_map::contains<u8, vector<u8>>(&v3, &v4)) {
            *0x2::vec_map::get_mut<u8, vector<u8>>(&mut v3, &v4) = arg3;
        } else {
            0x2::vec_map::insert<u8, vector<u8>>(&mut v3, v4, arg3);
        };
        set_protocol_config<T0, T1>(arg0, arg1, arg2, create_config(v0, v1, v3), arg4);
    }

    public(friend) fun set_protocol_config<T0, T1>(arg0: &mut LLVPool<T0, T1>, arg1: &0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::LLVPoolAdminCap, arg2: u8, arg3: ProtocolConfig, arg4: &0x2::clock::Clock) {
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::verify_pool_admin(arg1, 0x2::object::id<LLVPool<T0, T1>>(arg0));
        let v0 = !0x2::vec_map::contains<u8, ProtocolConfig>(&arg0.protocol_configs, &arg2);
        if (!v0) {
            *0x2::vec_map::get_mut<u8, ProtocolConfig>(&mut arg0.protocol_configs, &arg2) = arg3;
        } else {
            0x2::vec_map::insert<u8, ProtocolConfig>(&mut arg0.protocol_configs, arg2, arg3);
        };
        let v1 = 0x1::vector::empty<vector<u8>>();
        let v2 = 0;
        let v3 = 1;
        if (0x2::vec_map::contains<u8, vector<u8>>(&arg3.type_bytes, &v2)) {
            0x1::vector::push_back<vector<u8>>(&mut v1, *0x2::vec_map::get<u8, vector<u8>>(&arg3.type_bytes, &v2));
        } else {
            0x1::vector::push_back<vector<u8>>(&mut v1, 0x1::vector::empty<u8>());
        };
        if (0x2::vec_map::contains<u8, vector<u8>>(&arg3.type_bytes, &v3)) {
            0x1::vector::push_back<vector<u8>>(&mut v1, *0x2::vec_map::get<u8, vector<u8>>(&arg3.type_bytes, &v3));
        } else {
            0x1::vector::push_back<vector<u8>>(&mut v1, 0x1::vector::empty<u8>());
        };
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_events::emit_update_protocol_config(0x2::object::id<LLVPool<T0, T1>>(arg0), arg2, v0, arg3.ids, arg3.values, v1, 0x2::clock::timestamp_ms(arg4));
    }

    public(friend) fun set_protocol_deposit_cap<T0, T1>(arg0: &mut LLVPool<T0, T1>, arg1: &0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::LLVPoolAdminCap, arg2: u8, arg3: u128) {
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::verify_pool_admin(arg1, 0x2::object::id<LLVPool<T0, T1>>(arg0));
        assert!(!0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_allocation_plan::is_idle_protocol(arg2), 130);
        assert!(0x2::vec_map::contains<u8, ProtocolAllocation>(&arg0.allocations, &arg2), 3);
        0x2::vec_map::get_mut<u8, ProtocolAllocation>(&mut arg0.allocations, &arg2).deposit_cap = arg3;
    }

    public(friend) fun set_protocol_status<T0, T1>(arg0: &mut LLVPool<T0, T1>, arg1: &0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::LLVPoolAdminCap, arg2: u8, arg3: bool, arg4: bool, arg5: &0x2::clock::Clock) {
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::verify_pool_admin(arg1, 0x2::object::id<LLVPool<T0, T1>>(arg0));
        assert!(!0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_allocation_plan::is_idle_protocol(arg2), 130);
        assert!(0x2::vec_map::contains<u8, ProtocolAllocation>(&arg0.allocations, &arg2), 3);
        let v0 = 0x2::vec_map::get_mut<u8, ProtocolAllocation>(&mut arg0.allocations, &arg2);
        if ((arg3 || arg4) && v0.target_ratio_bps == 0) {
            abort 7
        };
        v0.can_supply = arg3;
        v0.can_withdraw = arg4;
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_events::emit_update_protocol(0x2::object::id<LLVPool<T0, T1>>(arg0), arg2, 1, arg3, arg4, v0.target_ratio_bps, v0.deposited_amount, v0.current_balance, v0.last_sync_ms, v0.apr_bps, 0x2::clock::timestamp_ms(arg5));
    }

    public(friend) fun set_protocol_targets<T0, T1>(arg0: &mut LLVPool<T0, T1>, arg1: &0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::LLVPoolAdminCap, arg2: vector<u8>, arg3: vector<u64>, arg4: vector<u128>, arg5: vector<bool>, arg6: vector<bool>, arg7: &0x2::clock::Clock) {
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::verify_pool_admin(arg1, 0x2::object::id<LLVPool<T0, T1>>(arg0));
        update_protocol_targets_internal<T0, T1>(arg0, arg2, arg3, arg4, arg5, arg6, arg7);
        validate_withdraw_queue_coverage<T0, T1>(arg0, &arg0.withdraw_queue);
    }

    public(friend) fun set_supply_queue<T0, T1>(arg0: &mut LLVPool<T0, T1>, arg1: &0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::LLVPoolAdminCap, arg2: vector<u8>) {
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::verify_pool_admin(arg1, 0x2::object::id<LLVPool<T0, T1>>(arg0));
        validate_queue<T0, T1>(arg0, &arg2);
        arg0.supply_queue = arg2;
    }

    public(friend) fun set_targets_and_queues<T0, T1>(arg0: &mut LLVPool<T0, T1>, arg1: &0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::LLVPoolAdminCap, arg2: vector<u8>, arg3: vector<u64>, arg4: vector<u128>, arg5: vector<bool>, arg6: vector<bool>, arg7: vector<u8>, arg8: vector<u8>, arg9: &0x2::clock::Clock) {
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::verify_pool_admin(arg1, 0x2::object::id<LLVPool<T0, T1>>(arg0));
        update_protocol_targets_internal<T0, T1>(arg0, arg2, arg3, arg4, arg5, arg6, arg9);
        validate_queue<T0, T1>(arg0, &arg7);
        arg0.supply_queue = arg7;
        validate_queue<T0, T1>(arg0, &arg8);
        validate_withdraw_queue_coverage<T0, T1>(arg0, &arg8);
        arg0.withdraw_queue = arg8;
    }

    public(friend) fun set_withdraw_queue<T0, T1>(arg0: &mut LLVPool<T0, T1>, arg1: &0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::LLVPoolAdminCap, arg2: vector<u8>) {
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::verify_pool_admin(arg1, 0x2::object::id<LLVPool<T0, T1>>(arg0));
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

    public(friend) fun store_or_join_balance<T0, T1, T2>(arg0: &mut LLVPool<T0, T1>, arg1: u8, arg2: 0x2::balance::Balance<T2>) {
        let v0 = borrow_uid_mut<T0, T1>(arg0);
        if (0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::protocol_holdings::exists_<0x2::balance::Balance<T2>>(v0, arg1)) {
            0x2::balance::join<T2>(0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::protocol_holdings::borrow_mut<0x2::balance::Balance<T2>>(v0, arg1), arg2);
        } else {
            0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::protocol_holdings::store<0x2::balance::Balance<T2>>(v0, arg1, arg2);
        };
    }

    public(friend) fun store_or_join_idle_balance<T0, T1>(arg0: &mut LLVPool<T0, T1>, arg1: 0x2::balance::Balance<T0>) {
        let v0 = borrow_uid_mut<T0, T1>(arg0);
        let v1 = 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_allocation_plan::PROTOCOL_IDLE();
        if (0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::protocol_holdings::exists_<0x2::balance::Balance<T0>>(v0, v1)) {
            0x2::balance::join<T0>(0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::protocol_holdings::borrow_mut<0x2::balance::Balance<T0>>(v0, v1), arg1);
        } else {
            0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::protocol_holdings::store<0x2::balance::Balance<T0>>(v0, v1, arg1);
        };
    }

    public fun store_protocol_cap<T0, T1, T2: copy + drop + store, T3: store>(arg0: &mut LLVPool<T0, T1>, arg1: &0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::LLVPoolAdminCap, arg2: T2, arg3: T3) {
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::verify_pool_admin(arg1, 0x2::object::id<LLVPool<T0, T1>>(arg0));
        0x2::dynamic_field::add<T2, T3>(&mut arg0.id, arg2, arg3);
    }

    public fun suilend_obligation_cap_key() : SuilendObligationCapKey {
        SuilendObligationCapKey{dummy_field: false}
    }

    public fun take_accumulated_dust<T0, T1, T2, T3>(arg0: &mut LLVPool<T0, T1>, arg1: u8, arg2: &T3) : 0x2::balance::Balance<T2> {
        assert_protocol_leg_auth<T0, T1, T3>(arg0, arg1);
        take_accumulated_token_internal<T0, T1, T2>(arg0, arg1)
    }

    public(friend) fun take_accumulated_token_internal<T0, T1, T2>(arg0: &mut LLVPool<T0, T1>, arg1: u8) : 0x2::balance::Balance<T2> {
        let v0 = accumulated_token_key<T2>(arg1);
        if (!0x2::dynamic_field::exists_<AccumulatedTokenKey<T2>>(&arg0.id, v0)) {
            return 0x2::balance::zero<T2>()
        };
        0x2::dynamic_field::remove<AccumulatedTokenKey<T2>, 0x2::balance::Balance<T2>>(&mut arg0.id, v0)
    }

    public fun total_shares<T0, T1>(arg0: &LLVPool<T0, T1>) : u128 {
        (0x2::coin::total_supply<T1>(&arg0.share_treasury) as u128) + arg0.fee_recipient_shares
    }

    public(friend) fun unpause<T0, T1>(arg0: &mut LLVPool<T0, T1>, arg1: &0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::LLVPoolAdminCap) {
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::verify_pool_admin(arg1, 0x2::object::id<LLVPool<T0, T1>>(arg0));
        arg0.paused = false;
    }

    public(friend) fun update_apr<T0, T1>(arg0: &mut LLVPool<T0, T1>, arg1: &0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::LLVPoolAdminCap, arg2: u8, arg3: u64, arg4: &0x2::clock::Clock) {
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_admin::verify_pool_admin(arg1, 0x2::object::id<LLVPool<T0, T1>>(arg0));
        assert!(0x2::vec_map::contains<u8, ProtocolAllocation>(&arg0.allocations, &arg2), 3);
        let v0 = 0x2::vec_map::get_mut<u8, ProtocolAllocation>(&mut arg0.allocations, &arg2);
        v0.apr_bps = arg3;
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_events::emit_apr_updated(0x2::object::id<LLVPool<T0, T1>>(arg0), arg2, v0.apr_bps, arg3, 0x2::clock::timestamp_ms(arg4));
    }

    public(friend) fun update_last_rebalance<T0, T1>(arg0: &mut LLVPool<T0, T1>, arg1: u64) {
        arg0.last_rebalance_ms = arg1;
    }

    public(friend) fun update_last_total_assets<T0, T1>(arg0: &mut LLVPool<T0, T1>) {
        arg0.last_total_assets = get_total_assets<T0, T1>(arg0);
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
        let v1 = 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_allocation_plan::PROTOCOL_IDLE();
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
            if ((v6 || v7) && v3 != v1) {
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
        0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_events::emit_protocol_targets_updated(0x2::object::id<LLVPool<T0, T1>>(arg0), arg1, arg2, arg3, arg4, arg5, 0x2::clock::timestamp_ms(arg6));
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
            let v3 = if (!0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_allocation_plan::is_idle_protocol(*v1)) {
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
        record_withdraw<T0, T1>(arg0, 0x9a1f16c565c8141d2479b7451d64107e10e0785905b8670754f856362f7f49c2::llv_allocation_plan::PROTOCOL_IDLE(), (arg1 as u128), 0);
        refresh_idle_balance<T0, T1>(arg0);
        v0
    }

    // decompiled from Move bytecode v7
}

