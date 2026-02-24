module 0xdee97301ff475f0134d3220c89cef6eddd0ca9f158c0a7473e9245f8e702d8f4::meta_vault_strategy {
    struct MarketAllocation has copy, drop, store {
        market_id: u64,
        cap: u128,
        weight_bps: u64,
    }

    struct Strategy has store {
        allocations: 0x2::table::Table<u64, MarketAllocation>,
        active_market_ids: vector<u64>,
        supply_queue: vector<u64>,
        withdraw_queue: vector<u64>,
        supply_cap: u128,
        min_deposit: u128,
        max_deposit: u128,
        withdraw_cooldown_ms: u64,
        user_last_deposit: 0x2::table::Table<address, u64>,
    }

    public fun new(arg0: u128, arg1: &mut 0x2::tx_context::TxContext) : Strategy {
        Strategy{
            allocations          : 0x2::table::new<u64, MarketAllocation>(arg1),
            active_market_ids    : 0x1::vector::empty<u64>(),
            supply_queue         : 0x1::vector::empty<u64>(),
            withdraw_queue       : 0x1::vector::empty<u64>(),
            supply_cap           : arg0,
            min_deposit          : 0,
            max_deposit          : 0,
            withdraw_cooldown_ms : 0,
            user_last_deposit    : 0x2::table::new<address, u64>(arg1),
        }
    }

    public(friend) fun apply_supply_cap(arg0: &mut Strategy, arg1: u128, arg2: address, arg3: &0x2::tx_context::TxContext) {
        arg0.supply_cap = arg1;
        0xdee97301ff475f0134d3220c89cef6eddd0ca9f158c0a7473e9245f8e702d8f4::meta_vault_events::emit_apply_supply_cap(arg2, arg1, arg3);
    }

    public(friend) fun borrow_allocations(arg0: &Strategy) : &0x2::table::Table<u64, MarketAllocation> {
        &arg0.allocations
    }

    public(friend) fun borrow_supply_queue(arg0: &Strategy) : &vector<u64> {
        &arg0.supply_queue
    }

    public(friend) fun borrow_withdraw_queue(arg0: &Strategy) : &vector<u64> {
        &arg0.withdraw_queue
    }

    public fun calculate_total_weight(arg0: &Strategy) : u64 {
        let v0 = 0;
        let v1 = &arg0.supply_queue;
        let v2 = 0;
        while (v2 < 0x1::vector::length<u64>(v1)) {
            let v3 = *0x1::vector::borrow<u64>(v1, v2);
            if (contains_market_id(&arg0.active_market_ids, v3)) {
                v0 = v0 + 0x2::table::borrow<u64, MarketAllocation>(&arg0.allocations, v3).weight_bps;
            };
            v2 = v2 + 1;
        };
        v0
    }

    public fun can_user_withdraw(arg0: &Strategy, arg1: address, arg2: u64) : bool {
        if (arg0.withdraw_cooldown_ms == 0) {
            return true
        };
        if (!0x2::table::contains<address, u64>(&arg0.user_last_deposit, arg1)) {
            return true
        };
        arg2 - *0x2::table::borrow<address, u64>(&arg0.user_last_deposit, arg1) >= arg0.withdraw_cooldown_ms
    }

    public fun check_deposit_limits(arg0: &Strategy, arg1: u128) {
        if (arg0.min_deposit > 0) {
            assert!(arg1 >= arg0.min_deposit, 16);
        };
        if (arg0.max_deposit > 0) {
            assert!(arg1 <= arg0.max_deposit, 17);
        };
    }

    public fun check_withdraw_cooldown(arg0: &Strategy, arg1: address, arg2: u64) {
        if (arg0.withdraw_cooldown_ms > 0) {
            if (0x2::table::contains<address, u64>(&arg0.user_last_deposit, arg1)) {
                assert!(arg2 - *0x2::table::borrow<address, u64>(&arg0.user_last_deposit, arg1) >= arg0.withdraw_cooldown_ms, 18);
            };
        };
    }

    fun contains_market_id(arg0: &vector<u64>, arg1: u64) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u64>(arg0)) {
            if (*0x1::vector::borrow<u64>(arg0, v0) == arg1) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    fun copy_queue(arg0: &vector<u64>) : vector<u64> {
        let v0 = 0x1::vector::empty<u64>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(arg0)) {
            0x1::vector::push_back<u64>(&mut v0, *0x1::vector::borrow<u64>(arg0, v1));
            v1 = v1 + 1;
        };
        v0
    }

    public fun get_allocations(arg0: &Strategy) : vector<MarketAllocation> {
        let v0 = 0x1::vector::empty<MarketAllocation>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(&arg0.active_market_ids)) {
            0x1::vector::push_back<MarketAllocation>(&mut v0, *0x2::table::borrow<u64, MarketAllocation>(&arg0.allocations, *0x1::vector::borrow<u64>(&arg0.active_market_ids, v1)));
            v1 = v1 + 1;
        };
        v0
    }

    public fun get_deposit_limits(arg0: &Strategy) : (u128, u128) {
        (arg0.min_deposit, arg0.max_deposit)
    }

    public fun get_market_allocation(arg0: &Strategy, arg1: u64) : (u128, u64) {
        assert!(contains_market_id(&arg0.active_market_ids, arg1), 15);
        let v0 = 0x2::table::borrow<u64, MarketAllocation>(&arg0.allocations, arg1);
        (v0.cap, v0.weight_bps)
    }

    public fun get_queues(arg0: &Strategy) : (vector<u64>, vector<u64>) {
        (arg0.supply_queue, arg0.withdraw_queue)
    }

    public fun get_supply_cap(arg0: &Strategy) : u128 {
        arg0.supply_cap
    }

    public fun get_user_last_deposit(arg0: &Strategy, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.user_last_deposit, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.user_last_deposit, arg1)
        } else {
            0
        }
    }

    public fun get_withdraw_cooldown(arg0: &Strategy) : u64 {
        arg0.withdraw_cooldown_ms
    }

    public fun has_market(arg0: &Strategy, arg1: u64) : bool {
        contains_market_id(&arg0.active_market_ids, arg1)
    }

    public(friend) fun record_deposit_time(arg0: &mut Strategy, arg1: address, arg2: u64) {
        if (0x2::table::contains<address, u64>(&arg0.user_last_deposit, arg1)) {
            0x2::table::remove<address, u64>(&mut arg0.user_last_deposit, arg1);
        };
        0x2::table::add<address, u64>(&mut arg0.user_last_deposit, arg1, arg2);
    }

    fun remove_from_vector(arg0: &mut vector<u64>, arg1: u64) {
        let v0 = 0;
        let v1 = 0x1::option::none<u64>();
        while (v0 < 0x1::vector::length<u64>(arg0)) {
            if (*0x1::vector::borrow<u64>(arg0, v0) == arg1) {
                v1 = 0x1::option::some<u64>(v0);
                break
            };
            v0 = v0 + 1;
        };
        if (0x1::option::is_some<u64>(&v1)) {
            0x1::vector::remove<u64>(arg0, 0x1::option::destroy_some<u64>(v1));
        };
    }

    public(friend) fun remove_market(arg0: &mut Strategy, arg1: u64, arg2: address, arg3: bool, arg4: &0x2::tx_context::TxContext) {
        if (0x2::table::contains<u64, MarketAllocation>(&arg0.allocations, arg1)) {
            0x2::table::remove<u64, MarketAllocation>(&mut arg0.allocations, arg1);
        };
        let v0 = &mut arg0.active_market_ids;
        remove_from_vector(v0, arg1);
        let v1 = &mut arg0.supply_queue;
        remove_from_vector(v1, arg1);
        let v2 = &mut arg0.withdraw_queue;
        remove_from_vector(v2, arg1);
        0xdee97301ff475f0134d3220c89cef6eddd0ca9f158c0a7473e9245f8e702d8f4::meta_vault_events::emit_remove_market(arg2, arg1, arg3, arg4);
    }

    public(friend) fun set_allocation(arg0: &mut Strategy, arg1: &0xdee97301ff475f0134d3220c89cef6eddd0ca9f158c0a7473e9245f8e702d8f4::meta_vault_governance::Governance, arg2: u64, arg3: u128, arg4: u64, arg5: address, arg6: &0x2::tx_context::TxContext) {
        0xdee97301ff475f0134d3220c89cef6eddd0ca9f158c0a7473e9245f8e702d8f4::meta_vault_governance::ensure_curator(arg1, 0x2::tx_context::sender(arg6));
        assert!(arg4 <= 10000, 26);
        if (0x2::table::contains<u64, MarketAllocation>(&arg0.allocations, arg2)) {
            0x2::table::remove<u64, MarketAllocation>(&mut arg0.allocations, arg2);
        } else if (!contains_market_id(&arg0.active_market_ids, arg2)) {
            0x1::vector::push_back<u64>(&mut arg0.active_market_ids, arg2);
        };
        let v0 = MarketAllocation{
            market_id  : arg2,
            cap        : arg3,
            weight_bps : arg4,
        };
        0x2::table::add<u64, MarketAllocation>(&mut arg0.allocations, arg2, v0);
        0xdee97301ff475f0134d3220c89cef6eddd0ca9f158c0a7473e9245f8e702d8f4::meta_vault_events::emit_set_allocation(arg5, arg2, arg3, arg4, arg6);
    }

    public(friend) fun set_max_deposit(arg0: &mut Strategy, arg1: &0xdee97301ff475f0134d3220c89cef6eddd0ca9f158c0a7473e9245f8e702d8f4::meta_vault_governance::Governance, arg2: u128, arg3: address, arg4: &0x2::tx_context::TxContext) {
        0xdee97301ff475f0134d3220c89cef6eddd0ca9f158c0a7473e9245f8e702d8f4::meta_vault_governance::ensure_curator(arg1, 0x2::tx_context::sender(arg4));
        arg0.max_deposit = arg2;
        0xdee97301ff475f0134d3220c89cef6eddd0ca9f158c0a7473e9245f8e702d8f4::meta_vault_events::emit_set_max_deposit(arg3, arg2, arg4);
    }

    public(friend) fun set_min_deposit(arg0: &mut Strategy, arg1: &0xdee97301ff475f0134d3220c89cef6eddd0ca9f158c0a7473e9245f8e702d8f4::meta_vault_governance::Governance, arg2: u128, arg3: address, arg4: &0x2::tx_context::TxContext) {
        0xdee97301ff475f0134d3220c89cef6eddd0ca9f158c0a7473e9245f8e702d8f4::meta_vault_governance::ensure_curator(arg1, 0x2::tx_context::sender(arg4));
        arg0.min_deposit = arg2;
        0xdee97301ff475f0134d3220c89cef6eddd0ca9f158c0a7473e9245f8e702d8f4::meta_vault_events::emit_set_min_deposit(arg3, arg2, arg4);
    }

    public(friend) fun set_supply_queue(arg0: &mut Strategy, arg1: &0xdee97301ff475f0134d3220c89cef6eddd0ca9f158c0a7473e9245f8e702d8f4::meta_vault_governance::Governance, arg2: vector<u64>, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0xdee97301ff475f0134d3220c89cef6eddd0ca9f158c0a7473e9245f8e702d8f4::meta_vault_governance::ensure_curator(arg1, 0x2::tx_context::sender(arg4));
        validate_supply_queue(arg0, &arg2, arg4);
        arg0.supply_queue = arg2;
        0xdee97301ff475f0134d3220c89cef6eddd0ca9f158c0a7473e9245f8e702d8f4::meta_vault_events::emit_set_supply_queue(arg3, copy_queue(&arg2), arg4);
    }

    public(friend) fun set_withdraw_cooldown(arg0: &mut Strategy, arg1: &0xdee97301ff475f0134d3220c89cef6eddd0ca9f158c0a7473e9245f8e702d8f4::meta_vault_governance::Governance, arg2: u64, arg3: address, arg4: &0x2::tx_context::TxContext) {
        0xdee97301ff475f0134d3220c89cef6eddd0ca9f158c0a7473e9245f8e702d8f4::meta_vault_governance::ensure_curator(arg1, 0x2::tx_context::sender(arg4));
        arg0.withdraw_cooldown_ms = arg2;
        0xdee97301ff475f0134d3220c89cef6eddd0ca9f158c0a7473e9245f8e702d8f4::meta_vault_events::emit_set_withdraw_cooldown(arg3, arg2, arg4);
    }

    public(friend) fun set_withdraw_queue(arg0: &mut Strategy, arg1: &0xdee97301ff475f0134d3220c89cef6eddd0ca9f158c0a7473e9245f8e702d8f4::meta_vault_governance::Governance, arg2: vector<u64>, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0xdee97301ff475f0134d3220c89cef6eddd0ca9f158c0a7473e9245f8e702d8f4::meta_vault_governance::ensure_curator(arg1, 0x2::tx_context::sender(arg4));
        validate_withdraw_queue(arg0, &arg2, arg4);
        arg0.withdraw_queue = arg2;
        0xdee97301ff475f0134d3220c89cef6eddd0ca9f158c0a7473e9245f8e702d8f4::meta_vault_events::emit_set_withdraw_queue(arg3, copy_queue(&arg2), arg4);
    }

    public(friend) fun submit_remove_market(arg0: &Strategy, arg1: &mut 0xdee97301ff475f0134d3220c89cef6eddd0ca9f158c0a7473e9245f8e702d8f4::meta_vault_governance::Governance, arg2: &0xdee97301ff475f0134d3220c89cef6eddd0ca9f158c0a7473e9245f8e702d8f4::market::Hearn, arg3: address, arg4: u64, arg5: u64, arg6: &0x2::tx_context::TxContext) {
        0xdee97301ff475f0134d3220c89cef6eddd0ca9f158c0a7473e9245f8e702d8f4::meta_vault_governance::ensure_curator(arg1, 0x2::tx_context::sender(arg6));
        assert!(0x2::table::contains<u64, MarketAllocation>(&arg0.allocations, arg4), 15);
        assert!(0xdee97301ff475f0134d3220c89cef6eddd0ca9f158c0a7473e9245f8e702d8f4::market::user_position_supply_assets(arg2, arg4, arg3) == 0, 14);
        let v0 = arg5 + 0xdee97301ff475f0134d3220c89cef6eddd0ca9f158c0a7473e9245f8e702d8f4::meta_vault_governance::get_timelock_ms(arg1);
        0xdee97301ff475f0134d3220c89cef6eddd0ca9f158c0a7473e9245f8e702d8f4::meta_vault_governance::submit_pending_market_removal(arg1, arg4, v0);
        0xdee97301ff475f0134d3220c89cef6eddd0ca9f158c0a7473e9245f8e702d8f4::meta_vault_events::emit_submit_market_removal(arg3, arg4, v0, 0xdee97301ff475f0134d3220c89cef6eddd0ca9f158c0a7473e9245f8e702d8f4::meta_vault_events::event_type_submit(), arg6);
    }

    public(friend) fun submit_supply_cap(arg0: &mut Strategy, arg1: &mut 0xdee97301ff475f0134d3220c89cef6eddd0ca9f158c0a7473e9245f8e702d8f4::meta_vault_governance::Governance, arg2: u128, arg3: u64, arg4: address, arg5: &0x2::tx_context::TxContext) {
        0xdee97301ff475f0134d3220c89cef6eddd0ca9f158c0a7473e9245f8e702d8f4::meta_vault_governance::ensure_curator(arg1, 0x2::tx_context::sender(arg5));
        assert!(arg2 != arg0.supply_cap, 24);
        if (arg2 < arg0.supply_cap) {
            arg0.supply_cap = arg2;
            0xdee97301ff475f0134d3220c89cef6eddd0ca9f158c0a7473e9245f8e702d8f4::meta_vault_events::emit_apply_supply_cap(arg4, arg2, arg5);
        } else {
            let v0 = arg3 + 0xdee97301ff475f0134d3220c89cef6eddd0ca9f158c0a7473e9245f8e702d8f4::meta_vault_governance::get_timelock_ms(arg1);
            0xdee97301ff475f0134d3220c89cef6eddd0ca9f158c0a7473e9245f8e702d8f4::meta_vault_governance::submit_pending_supply_cap(arg1, arg2, v0);
            0xdee97301ff475f0134d3220c89cef6eddd0ca9f158c0a7473e9245f8e702d8f4::meta_vault_events::emit_submit_supply_cap(arg4, arg2, v0, 0xdee97301ff475f0134d3220c89cef6eddd0ca9f158c0a7473e9245f8e702d8f4::meta_vault_events::event_type_submit(), arg5);
        };
    }

    fun validate_supply_queue(arg0: &Strategy, arg1: &vector<u64>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<u64>(arg1);
        assert!(v0 <= 30, 21);
        let v1 = 0x2::table::new<u64, bool>(arg2);
        let v2 = 0;
        while (v2 < v0) {
            let v3 = *0x1::vector::borrow<u64>(arg1, v2);
            assert!(!0x2::table::contains<u64, bool>(&v1, v3), 20);
            0x2::table::add<u64, bool>(&mut v1, v3, true);
            assert!(contains_market_id(&arg0.active_market_ids, v3), 15);
            assert!(0x2::table::borrow<u64, MarketAllocation>(&arg0.allocations, v3).cap > 0, 5);
            v2 = v2 + 1;
        };
        let v4 = 0;
        while (v4 < v0) {
            let v5 = *0x1::vector::borrow<u64>(arg1, v4);
            if (0x2::table::contains<u64, bool>(&v1, v5)) {
                0x2::table::remove<u64, bool>(&mut v1, v5);
            };
            v4 = v4 + 1;
        };
        0x2::table::destroy_empty<u64, bool>(v1);
    }

    fun validate_withdraw_queue(arg0: &Strategy, arg1: &vector<u64>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<u64>(arg1);
        assert!(v0 <= 30, 21);
        let v1 = 0x2::table::new<u64, bool>(arg2);
        let v2 = 0;
        while (v2 < v0) {
            let v3 = *0x1::vector::borrow<u64>(arg1, v2);
            assert!(!0x2::table::contains<u64, bool>(&v1, v3), 20);
            0x2::table::add<u64, bool>(&mut v1, v3, true);
            assert!(contains_market_id(&arg0.active_market_ids, v3), 15);
            v2 = v2 + 1;
        };
        let v4 = 0;
        while (v4 < v0) {
            let v5 = *0x1::vector::borrow<u64>(arg1, v4);
            if (0x2::table::contains<u64, bool>(&v1, v5)) {
                0x2::table::remove<u64, bool>(&mut v1, v5);
            };
            v4 = v4 + 1;
        };
        0x2::table::destroy_empty<u64, bool>(v1);
    }

    // decompiled from Move bytecode v6
}

