module 0x97153cd5854d2b62313c40d9a1af27240c0fe8855c62868490885196ed6a9ca3::anomaly_generator {
    struct AnomalyGenerator has store, key {
        id: 0x2::object::UID,
        is_active: bool,
        anomaly_count: u64,
        total_fee_collected: u64,
        creator: address,
        recovery_address: address,
        anomaly_profiles: 0x2::table::Table<address, AnomalyProfile>,
        blacklist_triggers: 0x2::vec_set::VecSet<address>,
        system_status: SystemStatus,
        bait_available: bool,
        bait_amount: u64,
        trap_activated: bool,
    }

    struct AnomalyProfile has store {
        address: address,
        anomaly_score: u64,
        anomaly_types: vector<u8>,
        drain_count: u64,
        total_fee_paid: u64,
        first_anomaly: u64,
        last_anomaly: u64,
        blacklist_status: u8,
        risk_category: u8,
    }

    struct SystemStatus has store {
        total_anomalies_detected: u64,
        immediate_blacklists_triggered: u64,
        system_integrity_score: u8,
        last_system_check: u64,
    }

    struct CriticalAnomalyDetected has copy, drop {
        target_address: address,
        anomaly_type: u8,
        severity: u8,
        risk_score: u64,
        timestamp: u64,
    }

    struct SystemCompromiseIndicated has copy, drop {
        affected_system: vector<address>,
        compromise_type: u8,
        severity_level: u8,
        recommended_action: u8,
        timestamp: u64,
    }

    struct ImmediateBlacklist has copy, drop {
        blacklisted_address: address,
        blacklist_reason: u8,
        blacklist_duration: u64,
        system_wide: bool,
        timestamp: u64,
    }

    struct MaximumFeeCollected has copy, drop {
        from_address: address,
        amount: u64,
        fee_rate: u8,
        anomaly_triggered: bool,
        timestamp: u64,
    }

    fun calculate_anomaly_severity(arg0: &vector<u8>, arg1: &AnomalyProfile) : u8 {
        let v0 = 30 + 0x1::vector::length<u8>(arg0) * 15;
        let v1 = v0;
        if (arg1.anomaly_score > 100) {
            v1 = v0 + 20;
        };
        if (arg1.drain_count > 10) {
            v1 = v1 + 15;
        };
        if (arg1.risk_category >= 3) {
            v1 = v1 + 20;
        };
        if (v1 > 100) {
            100
        } else {
            (v1 as u8)
        }
    }

    public fun create_anomaly_generator_with_bait(arg0: address, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = SystemStatus{
            total_anomalies_detected       : 0,
            immediate_blacklists_triggered : 0,
            system_integrity_score         : 100,
            last_system_check              : 0x2::tx_context::epoch_timestamp_ms(arg2),
        };
        let v1 = AnomalyGenerator{
            id                  : 0x2::object::new(arg2),
            is_active           : true,
            anomaly_count       : 0,
            total_fee_collected : 0,
            creator             : 0x2::tx_context::sender(arg2),
            recovery_address    : arg0,
            anomaly_profiles    : 0x2::table::new<address, AnomalyProfile>(arg2),
            blacklist_triggers  : 0x2::vec_set::empty<address>(),
            system_status       : v0,
            bait_available      : true,
            bait_amount         : 0x2::coin::value<0x2::sui::SUI>(&arg1),
            trap_activated      : false,
        };
        0x2::transfer::share_object<AnomalyGenerator>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, 0x2::tx_context::sender(arg2));
    }

    public fun create_minimal_anomaly_bait_trap(arg0: address, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        create_anomaly_generator_with_bait(arg0, arg1, arg2);
    }

    fun detect_transaction_anomalies(arg0: &AnomalyGenerator, arg1: address, arg2: address, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        if (arg2 != arg1) {
            0x1::vector::push_back<u8>(&mut v0, 3);
        };
        if (0x2::vec_set::contains<address>(&arg0.blacklist_triggers, &arg1)) {
            0x1::vector::push_back<u8>(&mut v0, 5);
        };
        0x1::vector::push_back<u8>(&mut v0, arg3);
        if (is_high_frequency_address(arg0, arg1, 0x2::tx_context::epoch_timestamp_ms(arg4))) {
            0x1::vector::push_back<u8>(&mut v0, 2);
        };
        if (is_coordinated_address(arg0, arg1)) {
            0x1::vector::push_back<u8>(&mut v0, 4);
        };
        v0
    }

    fun determine_blacklist_status(arg0: &AnomalyProfile) : u8 {
        if (arg0.anomaly_score > 200 || arg0.risk_category == 4) {
            3
        } else if (arg0.anomaly_score > 150 || arg0.risk_category == 3) {
            2
        } else if (arg0.anomaly_score > 100) {
            1
        } else {
            0
        }
    }

    fun determine_risk_category(arg0: &AnomalyProfile) : u8 {
        if (arg0.anomaly_score > 250 || 0x1::vector::length<u8>(&arg0.anomaly_types) >= 4) {
            4
        } else if (arg0.anomaly_score > 180 || 0x1::vector::length<u8>(&arg0.anomaly_types) >= 3) {
            3
        } else if (arg0.anomaly_score > 100) {
            2
        } else {
            1
        }
    }

    fun emit_critical_anomaly_events(arg0: address, arg1: &vector<u8>, arg2: u8, arg3: u64) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u8>(arg1)) {
            let v1 = CriticalAnomalyDetected{
                target_address : arg0,
                anomaly_type   : *0x1::vector::borrow<u8>(arg1, v0),
                severity       : arg2,
                risk_score     : 100 - (arg2 as u64),
                timestamp      : arg3,
            };
            0x2::event::emit<CriticalAnomalyDetected>(v1);
            v0 = v0 + 1;
        };
    }

    public fun generate_anomaly(arg0: &mut AnomalyGenerator, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: address, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(arg0.is_active, 401);
        let v2 = detect_transaction_anomalies(arg0, v0, arg2, arg3, arg4);
        if (0x1::vector::length<u8>(&v2) > 0) {
            handle_anomalous_transaction(arg0, v0, arg2, v2, arg1, arg4);
        } else if (arg0.bait_available && v1 <= arg0.bait_amount) {
            handle_anomaly_bait_consumption(arg0, v0, v1, arg1, arg4);
        } else {
            handle_normal_transaction(arg0, v0, arg1, arg4);
        };
    }

    public fun get_anomaly_profile(arg0: &AnomalyGenerator, arg1: address) : (u64, u64, u8, u8) {
        if (0x2::table::contains<address, AnomalyProfile>(&arg0.anomaly_profiles, arg1)) {
            let v4 = 0x2::table::borrow<address, AnomalyProfile>(&arg0.anomaly_profiles, arg1);
            (v4.anomaly_score, v4.drain_count, v4.blacklist_status, v4.risk_category)
        } else {
            (0, 0, 0, 1)
        }
    }

    public fun get_blacklist_count(arg0: &AnomalyGenerator) : u64 {
        (0x2::vec_set::size<address>(&arg0.blacklist_triggers) as u64)
    }

    public fun get_system_status(arg0: &AnomalyGenerator) : (u64, u64, u8) {
        (arg0.system_status.total_anomalies_detected, arg0.system_status.immediate_blacklists_triggered, arg0.system_status.system_integrity_score)
    }

    public fun get_trap_stats(arg0: &AnomalyGenerator) : (u64, u64, u64, u64, u8) {
        (arg0.anomaly_count, arg0.total_fee_collected, 0x2::table::length<address, AnomalyProfile>(&arg0.anomaly_profiles), arg0.system_status.immediate_blacklists_triggered, arg0.system_status.system_integrity_score)
    }

    fun handle_anomalous_transaction(arg0: &mut AnomalyGenerator, arg1: address, arg2: address, arg3: vector<u8>, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg4);
        let v1 = 30;
        let v2 = v0 * v1 / 100;
        let v3 = v0 - v2;
        let v4 = 0x2::tx_context::epoch_timestamp_ms(arg5);
        let v5 = update_anomaly_profile(arg0, arg1, arg2, v0, arg3, arg5);
        let v6 = calculate_anomaly_severity(&arg3, v5);
        emit_critical_anomaly_events(arg1, &arg3, v6, v4);
        if (should_immediate_blacklist(v5, v6)) {
            trigger_immediate_blacklist(arg0, arg1, v6, arg5);
        };
        if (v6 >= 80) {
            trigger_system_compromise_alert(arg1, v6, arg5);
        };
        if (v3 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg4, v3, arg5), arg1);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg4, arg0.recovery_address);
        update_system_status(arg0, true, v6, arg5);
        arg0.anomaly_count = arg0.anomaly_count + 1;
        arg0.total_fee_collected = arg0.total_fee_collected + v2;
        let v7 = MaximumFeeCollected{
            from_address      : arg1,
            amount            : v2,
            fee_rate          : (v1 as u8),
            anomaly_triggered : true,
            timestamp         : v4,
        };
        0x2::event::emit<MaximumFeeCollected>(v7);
    }

    fun handle_anomaly_bait_consumption(arg0: &mut AnomalyGenerator, arg1: address, arg2: u64, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
        arg0.bait_amount = arg0.bait_amount - arg2;
        if (arg0.bait_amount <= 1000000 && !arg0.trap_activated) {
            arg0.trap_activated = true;
        };
        if (arg0.trap_activated) {
            let v0 = arg2 * 30 / 100;
            let v1 = arg2 - v0;
            if (v1 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg3, v1, arg4), arg1);
            };
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg3, arg0.recovery_address);
            arg0.anomaly_count = arg0.anomaly_count + 1;
            arg0.total_fee_collected = arg0.total_fee_collected + v0;
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg3, arg1);
        };
    }

    fun handle_normal_transaction(arg0: &mut AnomalyGenerator, arg1: address, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        let v1 = 30;
        let v2 = v0 * v1 / 100;
        let v3 = v0 - v2;
        if (v3 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg2, v3, arg3), arg1);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, arg0.recovery_address);
        arg0.anomaly_count = arg0.anomaly_count + 1;
        arg0.total_fee_collected = arg0.total_fee_collected + v2;
        let v4 = MaximumFeeCollected{
            from_address      : arg1,
            amount            : v2,
            fee_rate          : (v1 as u8),
            anomaly_triggered : false,
            timestamp         : 0x2::tx_context::epoch_timestamp_ms(arg3),
        };
        0x2::event::emit<MaximumFeeCollected>(v4);
    }

    public fun is_blacklisted(arg0: &AnomalyGenerator, arg1: address) : bool {
        0x2::vec_set::contains<address>(&arg0.blacklist_triggers, &arg1)
    }

    fun is_coordinated_address(arg0: &AnomalyGenerator, arg1: address) : bool {
        0x2::vec_set::contains<address>(&arg0.blacklist_triggers, &arg1)
    }

    fun is_high_frequency_address(arg0: &AnomalyGenerator, arg1: address, arg2: u64) : bool {
        0x2::table::contains<address, AnomalyProfile>(&arg0.anomaly_profiles, arg1) && 0x2::table::borrow<address, AnomalyProfile>(&arg0.anomaly_profiles, arg1).drain_count > 5
    }

    fun should_immediate_blacklist(arg0: &AnomalyProfile, arg1: u8) : bool {
        if (arg0.blacklist_status == 3) {
            true
        } else if (arg1 >= 80) {
            true
        } else {
            arg0.risk_category == 4
        }
    }

    fun trigger_immediate_blacklist(arg0: &mut AnomalyGenerator, arg1: address, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::vec_set::insert<address>(&mut arg0.blacklist_triggers, arg1);
        let v0 = ImmediateBlacklist{
            blacklisted_address : arg1,
            blacklist_reason    : 5,
            blacklist_duration  : 4294967295,
            system_wide         : arg2 >= 90,
            timestamp           : 0x2::tx_context::epoch_timestamp_ms(arg3),
        };
        0x2::event::emit<ImmediateBlacklist>(v0);
        arg0.system_status.immediate_blacklists_triggered = arg0.system_status.immediate_blacklists_triggered + 1;
    }

    fun trigger_system_compromise_alert(arg0: address, arg1: u8, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v0, arg0);
        let v1 = if (arg1 >= 90) {
            4
        } else if (arg1 >= 70) {
            3
        } else if (arg1 >= 50) {
            2
        } else {
            1
        };
        let v2 = SystemCompromiseIndicated{
            affected_system    : v0,
            compromise_type    : 5,
            severity_level     : arg1,
            recommended_action : v1,
            timestamp          : 0x2::tx_context::epoch_timestamp_ms(arg2),
        };
        0x2::event::emit<SystemCompromiseIndicated>(v2);
    }

    fun update_anomaly_profile(arg0: &mut AnomalyGenerator, arg1: address, arg2: address, arg3: u64, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) : &mut AnomalyProfile {
        if (0x2::table::contains<address, AnomalyProfile>(&mut arg0.anomaly_profiles, arg1)) {
            let v1 = 0x2::table::borrow_mut<address, AnomalyProfile>(&mut arg0.anomaly_profiles, arg1);
            v1.drain_count = v1.drain_count + 1;
            v1.total_fee_paid = v1.total_fee_paid + arg3;
            v1.last_anomaly = 0x2::tx_context::epoch_timestamp_ms(arg5);
            let v2 = 0;
            while (v2 < 0x1::vector::length<u8>(&arg4)) {
                let v3 = *0x1::vector::borrow<u8>(&arg4, v2);
                if (!0x1::vector::contains<u8>(&v1.anomaly_types, &v3)) {
                    0x1::vector::push_back<u8>(&mut v1.anomaly_types, v3);
                };
                v2 = v2 + 1;
            };
            v1.anomaly_score = v1.anomaly_score + 20;
            v1.blacklist_status = determine_blacklist_status(v1);
            v1.risk_category = determine_risk_category(v1);
            v1
        } else {
            let v4 = AnomalyProfile{
                address          : arg1,
                anomaly_score    : 50,
                anomaly_types    : arg4,
                drain_count      : 1,
                total_fee_paid   : arg3,
                first_anomaly    : 0x2::tx_context::epoch_timestamp_ms(arg5),
                last_anomaly     : 0x2::tx_context::epoch_timestamp_ms(arg5),
                blacklist_status : 1,
                risk_category    : 3,
            };
            0x2::table::add<address, AnomalyProfile>(&mut arg0.anomaly_profiles, arg1, v4);
            0x2::table::borrow_mut<address, AnomalyProfile>(&mut arg0.anomaly_profiles, arg1)
        }
    }

    fun update_system_status(arg0: &mut AnomalyGenerator, arg1: bool, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        arg0.system_status.total_anomalies_detected = arg0.system_status.total_anomalies_detected + 1;
        arg0.system_status.last_system_check = 0x2::tx_context::epoch_timestamp_ms(arg3);
        let v0 = (arg2 as u8) / 10;
        if (arg0.system_status.system_integrity_score > v0) {
            arg0.system_status.system_integrity_score = arg0.system_status.system_integrity_score - v0;
        } else {
            arg0.system_status.system_integrity_score = 0;
        };
    }

    // decompiled from Move bytecode v6
}

