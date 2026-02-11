module 0x5667a7dc1be251c009dd0cc157e30c41de02974b38b0424f51048a0783bf694d::llv_pool {
    struct ProtocolAllocation has copy, drop, store {
        protocol_id: u8,
        enabled: bool,
        deposited_amount: u128,
        current_balance: u128,
        last_sync_ms: u64,
        target_ratio_bps: u64,
        apr_bps: u64,
    }

    struct ProtocolConfig has copy, drop, store {
        ids: vector<0x2::object::ID>,
        values: vector<u64>,
        type_bytes: 0x2::vec_map::VecMap<u8, vector<u8>>,
    }

    struct LLVPool<phantom T0> has store, key {
        id: 0x2::object::UID,
        allocations: 0x2::vec_map::VecMap<u8, ProtocolAllocation>,
        protocol_configs: 0x2::vec_map::VecMap<u8, ProtocolConfig>,
        total_shares: u128,
        global_yield_index: u128,
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
    }

    struct ProtocolAprInfo has copy, drop {
        protocol_id: u8,
        apr_bps: u64,
        balance: u128,
    }

    struct NaviAccountCapKey has copy, drop, store {
        dummy_field: bool,
    }

    public fun id<T0>(arg0: &LLVPool<T0>) : 0x2::object::ID {
        0x2::object::id<LLVPool<T0>>(arg0)
    }

    public(friend) fun accrue_fees<T0>(arg0: &mut LLVPool<T0>, arg1: u128, arg2: u64) : u128 {
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
        let v0 = 0;
        let v1 = 0;
        if (arg0.management_fee_bps > 0) {
            let v2 = (((arg1 as u256) * (arg0.management_fee_bps as u256) * ((arg2 - arg0.last_fee_collection_ms) as u256) / (10000 as u256) * (31536000000 as u256)) as u128);
            let v3 = if (v2 > 0) {
                if (arg0.total_shares > 0) {
                    arg1 > 0
                } else {
                    false
                }
            } else {
                false
            };
            if (v3) {
                v0 = 0x5667a7dc1be251c009dd0cc157e30c41de02974b38b0424f51048a0783bf694d::llv_math::mul_div(v2, arg0.total_shares, arg1);
            };
        };
        if (arg0.performance_fee_bps > 0 && arg1 > arg0.last_total_assets) {
            let v4 = 0x5667a7dc1be251c009dd0cc157e30c41de02974b38b0424f51048a0783bf694d::llv_math::mul_div(arg1 - arg0.last_total_assets, (arg0.performance_fee_bps as u128), (10000 as u128));
            let v5 = if (v4 > 0) {
                if (arg0.total_shares > 0) {
                    arg1 > 0
                } else {
                    false
                }
            } else {
                false
            };
            if (v5) {
                v1 = 0x5667a7dc1be251c009dd0cc157e30c41de02974b38b0424f51048a0783bf694d::llv_math::mul_div(v4, arg0.total_shares, arg1);
            };
        };
        let v6 = v0 + v1;
        arg0.last_fee_collection_ms = arg2;
        arg0.last_total_assets = arg1;
        arg0.total_shares = arg0.total_shares + v6;
        arg0.fee_recipient_shares = arg0.fee_recipient_shares + v6;
        if (v6 > 0) {
            0x5667a7dc1be251c009dd0cc157e30c41de02974b38b0424f51048a0783bf694d::llv_events::emit_fees_accrued(0x2::object::id<LLVPool<T0>>(arg0), v0, v1, v6, arg0.fee_recipient, arg2);
        };
        v6
    }

    public(friend) fun add_keeper<T0>(arg0: &mut LLVPool<T0>, arg1: &0x5667a7dc1be251c009dd0cc157e30c41de02974b38b0424f51048a0783bf694d::llv_admin::LLVPoolAdminCap, arg2: address, arg3: &0x2::clock::Clock) {
        0x5667a7dc1be251c009dd0cc157e30c41de02974b38b0424f51048a0783bf694d::llv_admin::verify_pool_admin(arg1, 0x2::object::id<LLVPool<T0>>(arg0));
        assert!(!0x1::vector::contains<address>(&arg0.keepers, &arg2), 106);
        assert!(0x1::vector::length<address>(&arg0.keepers) < 50, 110);
        0x1::vector::push_back<address>(&mut arg0.keepers, arg2);
        0x5667a7dc1be251c009dd0cc157e30c41de02974b38b0424f51048a0783bf694d::llv_events::emit_keeper_updated(0x2::object::id<LLVPool<T0>>(arg0), arg2, true, 0x2::clock::timestamp_ms(arg3));
    }

    public(friend) fun add_protocol<T0>(arg0: &mut LLVPool<T0>, arg1: &0x5667a7dc1be251c009dd0cc157e30c41de02974b38b0424f51048a0783bf694d::llv_admin::LLVPoolAdminCap, arg2: u8, arg3: u64, arg4: bool, arg5: &0x2::clock::Clock) {
        0x5667a7dc1be251c009dd0cc157e30c41de02974b38b0424f51048a0783bf694d::llv_admin::verify_pool_admin(arg1, 0x2::object::id<LLVPool<T0>>(arg0));
        assert!(!0x2::vec_map::contains<u8, ProtocolAllocation>(&arg0.allocations, &arg2), 2);
        if (arg4) {
            assert!(arg3 > 0, 7);
        };
        let v0 = ProtocolAllocation{
            protocol_id      : arg2,
            enabled          : arg4,
            deposited_amount : 0,
            current_balance  : 0,
            last_sync_ms     : 0,
            target_ratio_bps : arg3,
            apr_bps          : 0,
        };
        0x2::vec_map::insert<u8, ProtocolAllocation>(&mut arg0.allocations, arg2, v0);
        if (arg4) {
            validate_total_ratio<T0>(arg0);
        };
        0x5667a7dc1be251c009dd0cc157e30c41de02974b38b0424f51048a0783bf694d::llv_events::emit_update_protocol(0x2::object::id<LLVPool<T0>>(arg0), arg2, 0, arg4, arg3, 0, 0, 0, 0, 0x2::clock::timestamp_ms(arg5));
    }

    public fun assert_deposit_cap<T0>(arg0: &LLVPool<T0>, arg1: u128, arg2: u64) {
        assert!(check_deposit_cap<T0>(arg0, arg1, arg2), 100);
    }

    public fun assert_keeper<T0>(arg0: &LLVPool<T0>, arg1: address) {
        assert!(is_keeper<T0>(arg0, arg1), 102);
    }

    public fun assert_rebalance_allowed<T0>(arg0: &LLVPool<T0>, arg1: u64) {
        assert!(check_rebalance_allowed<T0>(arg0, arg1), 103);
    }

    public(friend) fun borrow_allocations_mut<T0>(arg0: &mut LLVPool<T0>) : &mut 0x2::vec_map::VecMap<u8, ProtocolAllocation> {
        &mut arg0.allocations
    }

    public(friend) fun borrow_uid<T0>(arg0: &LLVPool<T0>) : &0x2::object::UID {
        &arg0.id
    }

    public(friend) fun borrow_uid_mut<T0>(arg0: &mut LLVPool<T0>) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public fun bps_denominator() : u64 {
        10000
    }

    public fun check_deposit_cap<T0>(arg0: &LLVPool<T0>, arg1: u128, arg2: u64) : bool {
        if (arg0.deposit_cap == 0) {
            return true
        };
        arg1 + (arg2 as u128) <= arg0.deposit_cap
    }

    public fun check_rebalance_allowed<T0>(arg0: &LLVPool<T0>, arg1: u64) : bool {
        if (arg0.last_rebalance_ms == 0) {
            return true
        };
        arg1 >= arg0.last_rebalance_ms + arg0.min_rebalance_interval_ms
    }

    public(friend) fun claim_fee_shares<T0>(arg0: &mut LLVPool<T0>, arg1: address) : (u128, u128) {
        assert!(arg1 == arg0.fee_recipient, 108);
        let v0 = arg0.fee_recipient_shares;
        assert!(v0 > 0, 109);
        arg0.fee_recipient_shares = 0;
        (v0, 0x5667a7dc1be251c009dd0cc157e30c41de02974b38b0424f51048a0783bf694d::llv_math::calculate_assets_for_shares(arg0.total_shares, get_total_assets<T0>(arg0), v0))
    }

    public fun config_get_asset_type(arg0: &ProtocolConfig) : vector<u8> {
        let v0 = 1;
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
        assert!(0x1::vector::length<0x2::object::ID>(&arg0.ids) > 0, 0);
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

    public(friend) fun create_pool<T0>(arg0: &0x5667a7dc1be251c009dd0cc157e30c41de02974b38b0424f51048a0783bf694d::llv_admin::LLVGlobalAdminCap, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : (LLVPool<T0>, 0x5667a7dc1be251c009dd0cc157e30c41de02974b38b0424f51048a0783bf694d::llv_admin::LLVPoolAdminCap) {
        let v0 = LLVPool<T0>{
            id                          : 0x2::object::new(arg2),
            allocations                 : 0x2::vec_map::empty<u8, ProtocolAllocation>(),
            protocol_configs            : 0x2::vec_map::empty<u8, ProtocolConfig>(),
            total_shares                : 0,
            global_yield_index          : 0x5667a7dc1be251c009dd0cc157e30c41de02974b38b0424f51048a0783bf694d::llv_math::scale(),
            paused                      : false,
            min_deposit                 : 1000,
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
        };
        let v1 = 0x2::object::id<LLVPool<T0>>(&v0);
        let v2 = 0x5667a7dc1be251c009dd0cc157e30c41de02974b38b0424f51048a0783bf694d::llv_admin::create_pool_admin_cap(v1, arg2);
        0x5667a7dc1be251c009dd0cc157e30c41de02974b38b0424f51048a0783bf694d::llv_events::emit_pool_created(v1, 0x2::object::id<0x5667a7dc1be251c009dd0cc157e30c41de02974b38b0424f51048a0783bf694d::llv_admin::LLVPoolAdminCap>(&v2), 0x1::type_name::with_defining_ids<T0>(), 0x2::tx_context::sender(arg2), v0.paused, v0.min_deposit, v0.deposit_cap, v0.performance_fee_bps, v0.management_fee_bps, v0.fee_recipient, v0.min_rebalance_interval_ms, v0.min_rebalance_deviation_bps, 0x2::clock::timestamp_ms(arg1));
        (v0, v2)
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

    public(friend) fun emergency_withdraw_protocol<T0>(arg0: &mut LLVPool<T0>, arg1: &0x5667a7dc1be251c009dd0cc157e30c41de02974b38b0424f51048a0783bf694d::llv_admin::LLVPoolAdminCap, arg2: u8) : u128 {
        0x5667a7dc1be251c009dd0cc157e30c41de02974b38b0424f51048a0783bf694d::llv_admin::verify_pool_admin(arg1, 0x2::object::id<LLVPool<T0>>(arg0));
        assert!(arg0.paused, 5);
        assert!(0x2::vec_map::contains<u8, ProtocolAllocation>(&arg0.allocations, &arg2), 3);
        let v0 = 0x2::vec_map::get_mut<u8, ProtocolAllocation>(&mut arg0.allocations, &arg2);
        v0.current_balance = 0;
        v0.deposited_amount = 0;
        v0.current_balance
    }

    public fun empty_config() : ProtocolConfig {
        ProtocolConfig{
            ids        : 0x1::vector::empty<0x2::object::ID>(),
            values     : 0x1::vector::empty<u64>(),
            type_bytes : 0x2::vec_map::empty<u8, vector<u8>>(),
        }
    }

    public fun get_all_protocol_ids<T0>(arg0: &LLVPool<T0>) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0;
        while (v1 < 0x2::vec_map::length<u8, ProtocolAllocation>(&arg0.allocations)) {
            let (v2, _) = 0x2::vec_map::get_entry_by_idx<u8, ProtocolAllocation>(&arg0.allocations, v1);
            0x1::vector::push_back<u8>(&mut v0, *v2);
            v1 = v1 + 1;
        };
        v0
    }

    public fun get_deposit_cap<T0>(arg0: &LLVPool<T0>) : u128 {
        arg0.deposit_cap
    }

    public fun get_enabled_protocol_ids<T0>(arg0: &LLVPool<T0>) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0;
        while (v1 < 0x2::vec_map::length<u8, ProtocolAllocation>(&arg0.allocations)) {
            let (v2, v3) = 0x2::vec_map::get_entry_by_idx<u8, ProtocolAllocation>(&arg0.allocations, v1);
            if (v3.enabled) {
                0x1::vector::push_back<u8>(&mut v0, *v2);
            };
            v1 = v1 + 1;
        };
        v0
    }

    public fun get_fee_recipient<T0>(arg0: &LLVPool<T0>) : address {
        arg0.fee_recipient
    }

    public fun get_fee_recipient_shares<T0>(arg0: &LLVPool<T0>) : u128 {
        arg0.fee_recipient_shares
    }

    public fun get_keepers<T0>(arg0: &LLVPool<T0>) : vector<address> {
        arg0.keepers
    }

    public fun get_last_fee_collection_ms<T0>(arg0: &LLVPool<T0>) : u64 {
        arg0.last_fee_collection_ms
    }

    public fun get_last_rebalance_ms<T0>(arg0: &LLVPool<T0>) : u64 {
        arg0.last_rebalance_ms
    }

    public fun get_last_total_assets<T0>(arg0: &LLVPool<T0>) : u128 {
        arg0.last_total_assets
    }

    public fun get_management_fee_bps<T0>(arg0: &LLVPool<T0>) : u64 {
        arg0.management_fee_bps
    }

    public fun get_min_deposit<T0>(arg0: &LLVPool<T0>) : u64 {
        arg0.min_deposit
    }

    public fun get_min_rebalance_deviation_bps<T0>(arg0: &LLVPool<T0>) : u64 {
        arg0.min_rebalance_deviation_bps
    }

    public fun get_min_rebalance_interval_ms<T0>(arg0: &LLVPool<T0>) : u64 {
        arg0.min_rebalance_interval_ms
    }

    public fun get_performance_fee_bps<T0>(arg0: &LLVPool<T0>) : u64 {
        arg0.performance_fee_bps
    }

    public fun get_protocol_apr<T0>(arg0: &LLVPool<T0>, arg1: u8) : u64 {
        if (!0x2::vec_map::contains<u8, ProtocolAllocation>(&arg0.allocations, &arg1)) {
            return 0
        };
        0x2::vec_map::get<u8, ProtocolAllocation>(&arg0.allocations, &arg1).apr_bps
    }

    public fun get_protocol_balance<T0>(arg0: &LLVPool<T0>, arg1: u8) : u128 {
        if (!0x2::vec_map::contains<u8, ProtocolAllocation>(&arg0.allocations, &arg1)) {
            return 0
        };
        0x2::vec_map::get<u8, ProtocolAllocation>(&arg0.allocations, &arg1).current_balance
    }

    public fun get_protocol_config<T0>(arg0: &LLVPool<T0>, arg1: u8) : ProtocolConfig {
        if (0x2::vec_map::contains<u8, ProtocolConfig>(&arg0.protocol_configs, &arg1)) {
            *0x2::vec_map::get<u8, ProtocolConfig>(&arg0.protocol_configs, &arg1)
        } else {
            default_protocol_config()
        }
    }

    public fun get_protocol_ratio<T0>(arg0: &LLVPool<T0>, arg1: u8) : u64 {
        if (!0x2::vec_map::contains<u8, ProtocolAllocation>(&arg0.allocations, &arg1)) {
            return 0
        };
        0x2::vec_map::get<u8, ProtocolAllocation>(&arg0.allocations, &arg1).target_ratio_bps
    }

    public fun get_protocols_sorted_by_apr<T0>(arg0: &LLVPool<T0>) : vector<ProtocolAprInfo> {
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

    public fun get_supply_queue<T0>(arg0: &LLVPool<T0>) : vector<u8> {
        arg0.supply_queue
    }

    public fun get_total_assets<T0>(arg0: &LLVPool<T0>) : u128 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x2::vec_map::length<u8, ProtocolAllocation>(&arg0.allocations)) {
            let (_, v3) = 0x2::vec_map::get_entry_by_idx<u8, ProtocolAllocation>(&arg0.allocations, v1);
            v0 = v0 + v3.current_balance;
            v1 = v1 + 1;
        };
        v0
    }

    public fun get_total_enabled_ratio<T0>(arg0: &LLVPool<T0>) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x2::vec_map::length<u8, ProtocolAllocation>(&arg0.allocations)) {
            let (_, v3) = 0x2::vec_map::get_entry_by_idx<u8, ProtocolAllocation>(&arg0.allocations, v1);
            if (v3.enabled) {
                v0 = v0 + v3.target_ratio_bps;
            };
            v1 = v1 + 1;
        };
        v0
    }

    public fun get_withdraw_queue<T0>(arg0: &LLVPool<T0>) : vector<u8> {
        arg0.withdraw_queue
    }

    public fun global_yield_index<T0>(arg0: &LLVPool<T0>) : u128 {
        arg0.global_yield_index
    }

    public fun has_claimable_fee_shares<T0>(arg0: &LLVPool<T0>) : bool {
        arg0.fee_recipient_shares > 0
    }

    public fun has_protocol_config<T0>(arg0: &LLVPool<T0>, arg1: u8) : bool {
        0x2::vec_map::contains<u8, ProtocolConfig>(&arg0.protocol_configs, &arg1)
    }

    public fun is_keeper<T0>(arg0: &LLVPool<T0>, arg1: address) : bool {
        0x1::vector::contains<address>(&arg0.keepers, &arg1)
    }

    public fun is_paused<T0>(arg0: &LLVPool<T0>) : bool {
        arg0.paused
    }

    public fun is_protocol_enabled<T0>(arg0: &LLVPool<T0>, arg1: u8) : bool {
        if (!0x2::vec_map::contains<u8, ProtocolAllocation>(&arg0.allocations, &arg1)) {
            return false
        };
        0x2::vec_map::get<u8, ProtocolAllocation>(&arg0.allocations, &arg1).enabled
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

    public fun navi_account_cap_key() : NaviAccountCapKey {
        NaviAccountCapKey{dummy_field: false}
    }

    public(friend) fun pause<T0>(arg0: &mut LLVPool<T0>, arg1: &0x5667a7dc1be251c009dd0cc157e30c41de02974b38b0424f51048a0783bf694d::llv_admin::LLVPoolAdminCap) {
        0x5667a7dc1be251c009dd0cc157e30c41de02974b38b0424f51048a0783bf694d::llv_admin::verify_pool_admin(arg1, 0x2::object::id<LLVPool<T0>>(arg0));
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

    public fun protocol_count<T0>(arg0: &LLVPool<T0>) : u64 {
        0x2::vec_map::length<u8, ProtocolAllocation>(&arg0.allocations)
    }

    public(friend) fun record_deposit<T0>(arg0: &mut LLVPool<T0>, arg1: u8, arg2: u128) {
        if (0x2::vec_map::contains<u8, ProtocolAllocation>(&arg0.allocations, &arg1)) {
            let v0 = 0x2::vec_map::get_mut<u8, ProtocolAllocation>(&mut arg0.allocations, &arg1);
            v0.deposited_amount = v0.deposited_amount + arg2;
            v0.current_balance = v0.current_balance + arg2;
        };
    }

    public(friend) fun record_withdraw<T0>(arg0: &mut LLVPool<T0>, arg1: u8, arg2: u128) {
        if (0x2::vec_map::contains<u8, ProtocolAllocation>(&arg0.allocations, &arg1)) {
            let v0 = 0x2::vec_map::get_mut<u8, ProtocolAllocation>(&mut arg0.allocations, &arg1);
            let v1 = if (v0.deposited_amount >= arg2) {
                v0.deposited_amount - arg2
            } else {
                0
            };
            v0.deposited_amount = v1;
            let v2 = if (v0.current_balance >= arg2) {
                v0.current_balance - arg2
            } else {
                0
            };
            v0.current_balance = v2;
        };
    }

    public(friend) fun remove_keeper<T0>(arg0: &mut LLVPool<T0>, arg1: &0x5667a7dc1be251c009dd0cc157e30c41de02974b38b0424f51048a0783bf694d::llv_admin::LLVPoolAdminCap, arg2: address, arg3: &0x2::clock::Clock) {
        0x5667a7dc1be251c009dd0cc157e30c41de02974b38b0424f51048a0783bf694d::llv_admin::verify_pool_admin(arg1, 0x2::object::id<LLVPool<T0>>(arg0));
        let (v0, v1) = 0x1::vector::index_of<address>(&arg0.keepers, &arg2);
        assert!(v0, 107);
        0x1::vector::remove<address>(&mut arg0.keepers, v1);
        0x5667a7dc1be251c009dd0cc157e30c41de02974b38b0424f51048a0783bf694d::llv_events::emit_keeper_updated(0x2::object::id<LLVPool<T0>>(arg0), arg2, false, 0x2::clock::timestamp_ms(arg3));
    }

    public(friend) fun remove_protocol<T0>(arg0: &mut LLVPool<T0>, arg1: &0x5667a7dc1be251c009dd0cc157e30c41de02974b38b0424f51048a0783bf694d::llv_admin::LLVPoolAdminCap, arg2: u8, arg3: &0x2::clock::Clock) {
        0x5667a7dc1be251c009dd0cc157e30c41de02974b38b0424f51048a0783bf694d::llv_admin::verify_pool_admin(arg1, 0x2::object::id<LLVPool<T0>>(arg0));
        assert!(0x2::vec_map::contains<u8, ProtocolAllocation>(&arg0.allocations, &arg2), 3);
        let v0 = 0x2::vec_map::get<u8, ProtocolAllocation>(&arg0.allocations, &arg2);
        assert!(v0.current_balance == 0, 4);
        let v1 = v0.apr_bps;
        let (_, _) = 0x2::vec_map::remove<u8, ProtocolAllocation>(&mut arg0.allocations, &arg2);
        validate_total_ratio<T0>(arg0);
        0x5667a7dc1be251c009dd0cc157e30c41de02974b38b0424f51048a0783bf694d::llv_events::emit_update_protocol(0x2::object::id<LLVPool<T0>>(arg0), arg2, 2, v0.enabled, v0.target_ratio_bps, v0.deposited_amount, v0.current_balance, v0.last_sync_ms, v1, 0x2::clock::timestamp_ms(arg3));
    }

    public(friend) fun set_deposit_cap<T0>(arg0: &mut LLVPool<T0>, arg1: &0x5667a7dc1be251c009dd0cc157e30c41de02974b38b0424f51048a0783bf694d::llv_admin::LLVPoolAdminCap, arg2: u128) {
        0x5667a7dc1be251c009dd0cc157e30c41de02974b38b0424f51048a0783bf694d::llv_admin::verify_pool_admin(arg1, 0x2::object::id<LLVPool<T0>>(arg0));
        arg0.deposit_cap = arg2;
    }

    public(friend) fun set_fee_recipient<T0>(arg0: &mut LLVPool<T0>, arg1: &0x5667a7dc1be251c009dd0cc157e30c41de02974b38b0424f51048a0783bf694d::llv_admin::LLVPoolAdminCap, arg2: address) {
        0x5667a7dc1be251c009dd0cc157e30c41de02974b38b0424f51048a0783bf694d::llv_admin::verify_pool_admin(arg1, 0x2::object::id<LLVPool<T0>>(arg0));
        assert!(arg0.fee_recipient_shares == 0, 111);
        arg0.fee_recipient = arg2;
    }

    public(friend) fun set_management_fee<T0>(arg0: &mut LLVPool<T0>, arg1: &0x5667a7dc1be251c009dd0cc157e30c41de02974b38b0424f51048a0783bf694d::llv_admin::LLVPoolAdminCap, arg2: u64) {
        0x5667a7dc1be251c009dd0cc157e30c41de02974b38b0424f51048a0783bf694d::llv_admin::verify_pool_admin(arg1, 0x2::object::id<LLVPool<T0>>(arg0));
        assert!(arg2 <= 500, 104);
        arg0.management_fee_bps = arg2;
    }

    public(friend) fun set_min_deposit<T0>(arg0: &mut LLVPool<T0>, arg1: &0x5667a7dc1be251c009dd0cc157e30c41de02974b38b0424f51048a0783bf694d::llv_admin::LLVPoolAdminCap, arg2: u64) {
        0x5667a7dc1be251c009dd0cc157e30c41de02974b38b0424f51048a0783bf694d::llv_admin::verify_pool_admin(arg1, 0x2::object::id<LLVPool<T0>>(arg0));
        arg0.min_deposit = arg2;
    }

    public(friend) fun set_min_rebalance_deviation<T0>(arg0: &mut LLVPool<T0>, arg1: &0x5667a7dc1be251c009dd0cc157e30c41de02974b38b0424f51048a0783bf694d::llv_admin::LLVPoolAdminCap, arg2: u64) {
        0x5667a7dc1be251c009dd0cc157e30c41de02974b38b0424f51048a0783bf694d::llv_admin::verify_pool_admin(arg1, 0x2::object::id<LLVPool<T0>>(arg0));
        assert!(arg2 >= 10, 121);
        arg0.min_rebalance_deviation_bps = arg2;
    }

    public(friend) fun set_min_rebalance_interval<T0>(arg0: &mut LLVPool<T0>, arg1: &0x5667a7dc1be251c009dd0cc157e30c41de02974b38b0424f51048a0783bf694d::llv_admin::LLVPoolAdminCap, arg2: u64) {
        0x5667a7dc1be251c009dd0cc157e30c41de02974b38b0424f51048a0783bf694d::llv_admin::verify_pool_admin(arg1, 0x2::object::id<LLVPool<T0>>(arg0));
        assert!(arg2 >= 60000, 120);
        arg0.min_rebalance_interval_ms = arg2;
    }

    public(friend) fun set_performance_fee<T0>(arg0: &mut LLVPool<T0>, arg1: &0x5667a7dc1be251c009dd0cc157e30c41de02974b38b0424f51048a0783bf694d::llv_admin::LLVPoolAdminCap, arg2: u64) {
        0x5667a7dc1be251c009dd0cc157e30c41de02974b38b0424f51048a0783bf694d::llv_admin::verify_pool_admin(arg1, 0x2::object::id<LLVPool<T0>>(arg0));
        assert!(arg2 <= 5000, 104);
        arg0.performance_fee_bps = arg2;
    }

    public(friend) fun set_protocol_config<T0>(arg0: &mut LLVPool<T0>, arg1: &0x5667a7dc1be251c009dd0cc157e30c41de02974b38b0424f51048a0783bf694d::llv_admin::LLVPoolAdminCap, arg2: u8, arg3: ProtocolConfig, arg4: &0x2::clock::Clock) {
        0x5667a7dc1be251c009dd0cc157e30c41de02974b38b0424f51048a0783bf694d::llv_admin::verify_pool_admin(arg1, 0x2::object::id<LLVPool<T0>>(arg0));
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
        0x5667a7dc1be251c009dd0cc157e30c41de02974b38b0424f51048a0783bf694d::llv_events::emit_update_protocol_config(0x2::object::id<LLVPool<T0>>(arg0), arg2, v0, arg3.ids, arg3.values, v1, 0x2::clock::timestamp_ms(arg4));
    }

    public(friend) fun set_supply_queue<T0>(arg0: &mut LLVPool<T0>, arg1: &0x5667a7dc1be251c009dd0cc157e30c41de02974b38b0424f51048a0783bf694d::llv_admin::LLVPoolAdminCap, arg2: vector<u8>) {
        0x5667a7dc1be251c009dd0cc157e30c41de02974b38b0424f51048a0783bf694d::llv_admin::verify_pool_admin(arg1, 0x2::object::id<LLVPool<T0>>(arg0));
        validate_queue<T0>(arg0, &arg2);
        arg0.supply_queue = arg2;
    }

    public(friend) fun set_total_shares<T0>(arg0: &mut LLVPool<T0>, arg1: u128) {
        arg0.total_shares = arg1;
    }

    public(friend) fun set_withdraw_queue<T0>(arg0: &mut LLVPool<T0>, arg1: &0x5667a7dc1be251c009dd0cc157e30c41de02974b38b0424f51048a0783bf694d::llv_admin::LLVPoolAdminCap, arg2: vector<u8>) {
        0x5667a7dc1be251c009dd0cc157e30c41de02974b38b0424f51048a0783bf694d::llv_admin::verify_pool_admin(arg1, 0x2::object::id<LLVPool<T0>>(arg0));
        validate_queue<T0>(arg0, &arg2);
        arg0.withdraw_queue = arg2;
    }

    public(friend) fun set_yield_index<T0>(arg0: &mut LLVPool<T0>, arg1: u128) {
        arg0.global_yield_index = arg1;
    }

    public fun total_shares<T0>(arg0: &LLVPool<T0>) : u128 {
        arg0.total_shares
    }

    public(friend) fun unpause<T0>(arg0: &mut LLVPool<T0>, arg1: &0x5667a7dc1be251c009dd0cc157e30c41de02974b38b0424f51048a0783bf694d::llv_admin::LLVPoolAdminCap) {
        0x5667a7dc1be251c009dd0cc157e30c41de02974b38b0424f51048a0783bf694d::llv_admin::verify_pool_admin(arg1, 0x2::object::id<LLVPool<T0>>(arg0));
        arg0.paused = false;
    }

    public(friend) fun update_apr<T0>(arg0: &mut LLVPool<T0>, arg1: &0x5667a7dc1be251c009dd0cc157e30c41de02974b38b0424f51048a0783bf694d::llv_admin::LLVPoolAdminCap, arg2: u8, arg3: u64, arg4: &0x2::clock::Clock) {
        0x5667a7dc1be251c009dd0cc157e30c41de02974b38b0424f51048a0783bf694d::llv_admin::verify_pool_admin(arg1, 0x2::object::id<LLVPool<T0>>(arg0));
        assert!(0x2::vec_map::contains<u8, ProtocolAllocation>(&arg0.allocations, &arg2), 3);
        let v0 = 0x2::vec_map::get_mut<u8, ProtocolAllocation>(&mut arg0.allocations, &arg2);
        v0.apr_bps = arg3;
        0x5667a7dc1be251c009dd0cc157e30c41de02974b38b0424f51048a0783bf694d::llv_events::emit_apr_updated(0x2::object::id<LLVPool<T0>>(arg0), arg2, v0.apr_bps, arg3, 0x2::clock::timestamp_ms(arg4));
    }

    public(friend) fun update_last_rebalance<T0>(arg0: &mut LLVPool<T0>, arg1: u64) {
        arg0.last_rebalance_ms = arg1;
    }

    public(friend) fun update_last_total_assets<T0>(arg0: &mut LLVPool<T0>) {
        arg0.last_total_assets = get_total_assets<T0>(arg0);
    }

    public(friend) fun update_protocol<T0>(arg0: &mut LLVPool<T0>, arg1: &0x5667a7dc1be251c009dd0cc157e30c41de02974b38b0424f51048a0783bf694d::llv_admin::LLVPoolAdminCap, arg2: u8, arg3: u64, arg4: bool, arg5: &0x2::clock::Clock) {
        0x5667a7dc1be251c009dd0cc157e30c41de02974b38b0424f51048a0783bf694d::llv_admin::verify_pool_admin(arg1, 0x2::object::id<LLVPool<T0>>(arg0));
        assert!(0x2::vec_map::contains<u8, ProtocolAllocation>(&arg0.allocations, &arg2), 3);
        if (arg4) {
            assert!(arg3 > 0, 7);
        };
        let v0 = 0x2::vec_map::get_mut<u8, ProtocolAllocation>(&mut arg0.allocations, &arg2);
        v0.target_ratio_bps = arg3;
        v0.enabled = arg4;
        validate_total_ratio<T0>(arg0);
        0x5667a7dc1be251c009dd0cc157e30c41de02974b38b0424f51048a0783bf694d::llv_events::emit_update_protocol(0x2::object::id<LLVPool<T0>>(arg0), arg2, 1, arg4, arg3, v0.deposited_amount, v0.current_balance, v0.last_sync_ms, v0.apr_bps, 0x2::clock::timestamp_ms(arg5));
    }

    public(friend) fun update_protocol_balance<T0>(arg0: &mut LLVPool<T0>, arg1: u8, arg2: u128, arg3: u64) {
        if (0x2::vec_map::contains<u8, ProtocolAllocation>(&arg0.allocations, &arg1)) {
            let v0 = 0x2::vec_map::get_mut<u8, ProtocolAllocation>(&mut arg0.allocations, &arg1);
            v0.current_balance = arg2;
            v0.last_sync_ms = arg3;
        };
    }

    fun validate_queue<T0>(arg0: &LLVPool<T0>, arg1: &vector<u8>) {
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

    public fun validate_total_ratio<T0>(arg0: &LLVPool<T0>) {
        assert!(get_total_enabled_ratio<T0>(arg0) <= 10000, 6);
    }

    // decompiled from Move bytecode v6
}

