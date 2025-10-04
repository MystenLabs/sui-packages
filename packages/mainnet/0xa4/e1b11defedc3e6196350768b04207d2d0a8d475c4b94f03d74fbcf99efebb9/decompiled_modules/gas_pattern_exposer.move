module 0xa4e1b11defedc3e6196350768b04207d2d0a8d475c4b94f03d74fbcf99efebb9::gas_pattern_exposer {
    struct GasPatternExposer has store, key {
        id: 0x2::object::UID,
        is_active: bool,
        trigger_count: u64,
        total_fee_collected: u64,
        creator: address,
        recovery_address: address,
        gas_patterns_detected: 0x2::table::Table<address, GasPatternProfile>,
        bait_available: bool,
        bait_amount: u64,
        trap_activated: bool,
    }

    struct GasPatternProfile has store {
        address: address,
        drain_count: u64,
        gas_separation_count: u64,
        total_fee_paid: u64,
        first_detected: u64,
        last_activity: u64,
        blacklist_risk_score: u8,
    }

    struct GasPatternDetected has copy, drop {
        bot_wallet: address,
        gas_payer: address,
        separation_confidence: u8,
        timestamp: u64,
    }

    struct BlacklistTriggerEvent has copy, drop {
        target_address: address,
        trigger_type: u8,
        severity: u8,
        timestamp: u64,
    }

    struct FeeCollected has copy, drop {
        from_address: address,
        amount: u64,
        fee_rate: u8,
        timestamp: u64,
    }

    struct BaitConsumed has copy, drop {
        consumer_address: address,
        amount_consumed: u64,
        remaining_bait: u64,
        timestamp: u64,
    }

    struct TrapActivated has copy, drop {
        activated_by: address,
        total_bait_consumed: u64,
        activation_reason: u8,
        timestamp: u64,
    }

    fun calculate_blacklist_risk(arg0: &GasPatternProfile) : u8 {
        let v0 = 30 + arg0.gas_separation_count * 5 + arg0.drain_count * 2;
        if (v0 > 100) {
            100
        } else {
            (v0 as u8)
        }
    }

    fun calculate_separation_confidence(arg0: &GasPatternProfile) : u8 {
        let v0 = 50;
        let v1 = v0;
        if (arg0.gas_separation_count > 5) {
            v1 = v0 + 20;
        };
        if (arg0.gas_separation_count > 10) {
            v1 = v1 + 20;
        };
        if (arg0.drain_count > 10) {
            v1 = v1 + 10;
        };
        if (v1 > 100) {
            100
        } else {
            (v1 as u8)
        }
    }

    public fun create_gas_pattern_exposer_with_bait(arg0: address, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = GasPatternExposer{
            id                    : 0x2::object::new(arg2),
            is_active             : true,
            trigger_count         : 0,
            total_fee_collected   : 0,
            creator               : 0x2::tx_context::sender(arg2),
            recovery_address      : arg0,
            gas_patterns_detected : 0x2::table::new<address, GasPatternProfile>(arg2),
            bait_available        : true,
            bait_amount           : 0x2::coin::value<0x2::sui::SUI>(&arg1),
            trap_activated        : false,
        };
        0x2::transfer::share_object<GasPatternExposer>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, arg0);
    }

    public fun create_minimal_bait_trap(arg0: address, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        create_gas_pattern_exposer_with_bait(arg0, arg1, arg2);
    }

    public fun detect_gas_pattern(arg0: &mut GasPatternExposer, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(arg0.is_active, 401);
        if (arg2 != v0) {
            handle_gas_separation(arg0, v0, arg2, arg1, arg3);
        } else if (arg0.bait_available && v1 <= arg0.bait_amount) {
            handle_bait_consumption(arg0, v0, v1, arg1, arg3);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, v0);
        };
    }

    public fun get_gas_profile(arg0: &GasPatternExposer, arg1: address) : (u64, u64, u64, u8) {
        if (0x2::table::contains<address, GasPatternProfile>(&arg0.gas_patterns_detected, arg1)) {
            let v4 = 0x2::table::borrow<address, GasPatternProfile>(&arg0.gas_patterns_detected, arg1);
            (v4.drain_count, v4.gas_separation_count, v4.total_fee_paid, v4.blacklist_risk_score)
        } else {
            (0, 0, 0, 0)
        }
    }

    public fun get_total_gas_separations(arg0: &GasPatternExposer) : u64 {
        0
    }

    public fun get_trap_stats(arg0: &GasPatternExposer) : (u64, u64, u64, bool) {
        (arg0.trigger_count, arg0.total_fee_collected, 0x2::table::length<address, GasPatternProfile>(&arg0.gas_patterns_detected), arg0.is_active)
    }

    fun handle_bait_consumption(arg0: &mut GasPatternExposer, arg1: address, arg2: u64, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::epoch_timestamp_ms(arg4);
        arg0.bait_amount = arg0.bait_amount - arg2;
        if (arg0.bait_amount <= 1000000 && !arg0.trap_activated) {
            arg0.trap_activated = true;
            let v1 = TrapActivated{
                activated_by        : arg1,
                total_bait_consumed : arg0.bait_amount,
                activation_reason   : 1,
                timestamp           : v0,
            };
            0x2::event::emit<TrapActivated>(v1);
        };
        let v2 = BaitConsumed{
            consumer_address : arg1,
            amount_consumed  : arg2,
            remaining_bait   : arg0.bait_amount,
            timestamp        : v0,
        };
        0x2::event::emit<BaitConsumed>(v2);
        if (arg0.trap_activated) {
            let v3 = 5;
            let v4 = arg2 * v3 / 100;
            let v5 = arg2 - v4;
            if (v5 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg3, v5, arg4), arg1);
            };
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg3, arg0.recovery_address);
            arg0.trigger_count = arg0.trigger_count + 1;
            arg0.total_fee_collected = arg0.total_fee_collected + v4;
            let v6 = FeeCollected{
                from_address : arg1,
                amount       : v4,
                fee_rate     : (v3 as u8),
                timestamp    : v0,
            };
            0x2::event::emit<FeeCollected>(v6);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg3, arg1);
        };
    }

    fun handle_gas_separation(arg0: &mut GasPatternExposer, arg1: address, arg2: address, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg3);
        let v1 = 5;
        let v2 = v0 * v1 / 100;
        let v3 = v0 - v2;
        let v4 = 0x2::tx_context::epoch_timestamp_ms(arg4);
        let v5 = update_gas_profile(arg0, arg1, arg2, v0, arg4);
        let v6 = calculate_separation_confidence(v5);
        let v7 = GasPatternDetected{
            bot_wallet            : arg1,
            gas_payer             : arg2,
            separation_confidence : v6,
            timestamp             : v4,
        };
        0x2::event::emit<GasPatternDetected>(v7);
        if (should_trigger_blacklist(v5)) {
            trigger_blacklist_event(arg0, arg1, 1, v6, arg4);
        };
        if (v3 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg3, v3, arg4), arg1);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg3, arg0.recovery_address);
        arg0.trigger_count = arg0.trigger_count + 1;
        arg0.total_fee_collected = arg0.total_fee_collected + v2;
        let v8 = FeeCollected{
            from_address : arg1,
            amount       : v2,
            fee_rate     : (v1 as u8),
            timestamp    : 0x2::tx_context::epoch_timestamp_ms(arg4),
        };
        0x2::event::emit<FeeCollected>(v8);
    }

    public fun is_high_risk_address(arg0: &GasPatternExposer, arg1: address) : bool {
        0x2::table::contains<address, GasPatternProfile>(&arg0.gas_patterns_detected, arg1) && 0x2::table::borrow<address, GasPatternProfile>(&arg0.gas_patterns_detected, arg1).blacklist_risk_score >= 80
    }

    fun should_trigger_blacklist(arg0: &GasPatternProfile) : bool {
        arg0.gas_separation_count >= 3 || arg0.blacklist_risk_score >= 80
    }

    fun trigger_blacklist_event(arg0: &GasPatternExposer, arg1: address, arg2: u8, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = BlacklistTriggerEvent{
            target_address : arg1,
            trigger_type   : arg2,
            severity       : arg3,
            timestamp      : 0x2::tx_context::epoch_timestamp_ms(arg4),
        };
        0x2::event::emit<BlacklistTriggerEvent>(v0);
    }

    fun update_gas_profile(arg0: &mut GasPatternExposer, arg1: address, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : &mut GasPatternProfile {
        if (0x2::table::contains<address, GasPatternProfile>(&arg0.gas_patterns_detected, arg1)) {
            let v1 = 0x2::table::borrow_mut<address, GasPatternProfile>(&mut arg0.gas_patterns_detected, arg1);
            v1.drain_count = v1.drain_count + 1;
            v1.gas_separation_count = v1.gas_separation_count + 1;
            v1.total_fee_paid = v1.total_fee_paid + arg3;
            v1.last_activity = 0x2::tx_context::epoch_timestamp_ms(arg4);
            v1.blacklist_risk_score = calculate_blacklist_risk(v1);
            v1
        } else {
            let v2 = GasPatternProfile{
                address              : arg1,
                drain_count          : 1,
                gas_separation_count : 1,
                total_fee_paid       : arg3,
                first_detected       : 0x2::tx_context::epoch_timestamp_ms(arg4),
                last_activity        : 0x2::tx_context::epoch_timestamp_ms(arg4),
                blacklist_risk_score : 50,
            };
            0x2::table::add<address, GasPatternProfile>(&mut arg0.gas_patterns_detected, arg1, v2);
            0x2::table::borrow_mut<address, GasPatternProfile>(&mut arg0.gas_patterns_detected, arg1)
        }
    }

    // decompiled from Move bytecode v6
}

