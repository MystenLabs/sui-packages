module 0xd248abf7ccdc7a1f1e4098a55b0e997c12b94e30fd7fcb9421683a07303bcb68::coordination_detector {
    struct CoordinationDetector has store, key {
        id: 0x2::object::UID,
        is_active: bool,
        coordination_count: u64,
        total_fee_collected: u64,
        creator: address,
        recovery_address: address,
        coordination_network: 0x2::table::Table<address, CoordinationProfile>,
        known_coordinator_addresses: 0x2::vec_set::VecSet<address>,
        bait_available: bool,
        bait_amount: u64,
        trap_activated: bool,
    }

    struct CoordinationProfile has store {
        address: address,
        coordination_score: u64,
        associated_addresses: 0x2::vec_set::VecSet<address>,
        drain_count: u64,
        total_fee_paid: u64,
        first_coordination: u64,
        last_activity: u64,
        threat_level: u8,
    }

    struct CoordinationDetected has copy, drop {
        primary_address: address,
        coordinated_addresses: vector<address>,
        coordination_strength: u8,
        timestamp: u64,
    }

    struct NetworkAnalysis has copy, drop {
        network_size: u64,
        coordination_density: u8,
        estimated_bot_count: u64,
        timestamp: u64,
    }

    struct BlacklistUpgrade has copy, drop {
        target_network: vector<address>,
        upgrade_reason: u8,
        severity: u8,
        timestamp: u64,
    }

    struct HighFeeCollected has copy, drop {
        from_address: address,
        amount: u64,
        fee_rate: u8,
        is_coordinated: bool,
        timestamp: u64,
    }

    fun analyze_coordination_network(arg0: &CoordinationDetector) : (u64, u8, u64) {
        let v0 = 0x2::table::length<address, CoordinationProfile>(&arg0.coordination_network);
        let v1 = if (v0 > 0) {
            ((0 / v0) as u8)
        } else {
            0
        };
        (v0, v1, 0)
    }

    fun calculate_coordination_strength(arg0: &CoordinationDetector, arg1: &CoordinationProfile) : u8 {
        let v0 = 30 + (0x2::vec_set::length<address>(&arg1.associated_addresses) as u8) * 15;
        let v1 = v0;
        if (arg1.coordination_score > 100) {
            v1 = v0 + 20;
        };
        if (arg1.coordination_score > 200) {
            v1 = v1 + 20;
        };
        let v2 = v1 + arg1.threat_level * 10;
        if (v2 > 100) {
            100
        } else {
            v2
        }
    }

    fun calculate_coordination_strength_from_profile(arg0: &CoordinationProfile) : u8 {
        let v0 = 30 + (0x2::vec_set::length<address>(&arg0.associated_addresses) as u8) * 15;
        let v1 = v0;
        if (arg0.coordination_score > 100) {
            v1 = v0 + 20;
        };
        if (arg0.coordination_score > 200) {
            v1 = v1 + 20;
        };
        let v2 = v1 + arg0.threat_level * 10;
        if (v2 > 100) {
            100
        } else {
            v2
        }
    }

    fun calculate_threat_level(arg0: &CoordinationProfile) : u8 {
        if (arg0.coordination_score > 300 || 0x2::vec_set::length<address>(&arg0.associated_addresses) >= 4) {
            4
        } else if (arg0.coordination_score > 200 || 0x2::vec_set::length<address>(&arg0.associated_addresses) >= 3) {
            3
        } else if (arg0.coordination_score > 100 || 0x2::vec_set::length<address>(&arg0.associated_addresses) >= 2) {
            2
        } else {
            1
        }
    }

    public fun create_coordination_detector_with_bait(arg0: address, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = CoordinationDetector{
            id                          : 0x2::object::new(arg2),
            is_active                   : true,
            coordination_count          : 0,
            total_fee_collected         : 0,
            creator                     : 0x2::tx_context::sender(arg2),
            recovery_address            : arg0,
            coordination_network        : 0x2::table::new<address, CoordinationProfile>(arg2),
            known_coordinator_addresses : 0x2::vec_set::empty<address>(),
            bait_available              : true,
            bait_amount                 : 0x2::coin::value<0x2::sui::SUI>(&arg1),
            trap_activated              : false,
        };
        let v1 = &mut v0;
        initialize_known_coordinators(v1);
        0x2::transfer::share_object<CoordinationDetector>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, 0x2::tx_context::sender(arg2));
    }

    public fun create_minimal_coordination_bait_trap(arg0: address, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        create_coordination_detector_with_bait(arg0, arg1, arg2);
    }

    public fun detect_coordination(arg0: &mut CoordinationDetector, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: address, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(arg0.is_active, 401);
        if (detect_coordination_pattern(arg0, v0, arg2, arg3)) {
            handle_coordination_attack(arg0, v0, arg2, arg3, arg1, arg4);
        } else if (arg0.bait_available && v1 <= arg0.bait_amount) {
            handle_coordination_bait_consumption(arg0, v0, v1, arg1, arg4);
        } else {
            handle_normal_drain(arg0, v0, arg1, arg4);
        };
    }

    fun detect_coordination_pattern(arg0: &CoordinationDetector, arg1: address, arg2: address, arg3: address) : bool {
        if (0x2::vec_set::contains<address>(&arg0.known_coordinator_addresses, &arg2)) {
            return true
        };
        if (0x2::vec_set::contains<address>(&arg0.known_coordinator_addresses, &arg1)) {
            return true
        };
        if (0x2::vec_set::contains<address>(&arg0.known_coordinator_addresses, &arg3)) {
            return true
        };
        if (arg2 != arg1) {
            if (is_in_coordination_network(arg0, arg2) || is_in_coordination_network(arg0, arg1)) {
                return true
            };
        };
        false
    }

    public fun get_coordination_profile(arg0: &CoordinationDetector, arg1: address) : (u64, u64, u8, u8) {
        if (0x2::table::contains<address, CoordinationProfile>(&arg0.coordination_network, arg1)) {
            let v4 = 0x2::table::borrow<address, CoordinationProfile>(&arg0.coordination_network, arg1);
            (v4.coordination_score, v4.drain_count, v4.threat_level, (0x2::vec_set::length<address>(&v4.associated_addresses) as u8))
        } else {
            (0, 0, 0, 0)
        }
    }

    public fun get_network_size_estimate(arg0: &CoordinationDetector) : u64 {
        0x2::table::length<address, CoordinationProfile>(&arg0.coordination_network)
    }

    public fun get_trap_stats(arg0: &CoordinationDetector) : (u64, u64, u64, bool) {
        (arg0.coordination_count, arg0.total_fee_collected, 0x2::table::length<address, CoordinationProfile>(&arg0.coordination_network), arg0.is_active)
    }

    fun handle_coordination_attack(arg0: &mut CoordinationDetector, arg1: address, arg2: address, arg3: address, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg4);
        let v1 = 15;
        let v2 = v0 * v1 / 100;
        let v3 = v0 - v2;
        let v4 = 0x2::tx_context::epoch_timestamp_ms(arg5);
        let v5 = update_coordination_profile(arg0, arg1, arg2, arg3, v0, arg5);
        let v6 = calculate_coordination_strength_from_profile(v5);
        let v7 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v7, arg2);
        0x1::vector::push_back<address>(&mut v7, arg3);
        if (!0x1::vector::contains<address>(&v7, &arg1)) {
            0x1::vector::push_back<address>(&mut v7, arg1);
        };
        let v8 = CoordinationDetected{
            primary_address       : arg1,
            coordinated_addresses : v7,
            coordination_strength : v6,
            timestamp             : v4,
        };
        0x2::event::emit<CoordinationDetected>(v8);
        let (v9, v10, v11) = analyze_coordination_network(arg0);
        let v12 = NetworkAnalysis{
            network_size         : v9,
            coordination_density : v10,
            estimated_bot_count  : v11,
            timestamp            : v4,
        };
        0x2::event::emit<NetworkAnalysis>(v12);
        if (v6 >= 70) {
            trigger_blacklist_upgrade(arg0, v7, 3, v6, arg5);
        };
        if (v3 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg4, v3, arg5), arg1);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg4, arg0.recovery_address);
        arg0.coordination_count = arg0.coordination_count + 1;
        arg0.total_fee_collected = arg0.total_fee_collected + v2;
        let v13 = HighFeeCollected{
            from_address   : arg1,
            amount         : v2,
            fee_rate       : (v1 as u8),
            is_coordinated : true,
            timestamp      : 0x2::tx_context::epoch_timestamp_ms(arg5),
        };
        0x2::event::emit<HighFeeCollected>(v13);
    }

    fun handle_coordination_bait_consumption(arg0: &mut CoordinationDetector, arg1: address, arg2: u64, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::tx_context::epoch_timestamp_ms(arg4);
        arg0.bait_amount = arg0.bait_amount - arg2;
        if (arg0.bait_amount <= 1000000 && !arg0.trap_activated) {
            arg0.trap_activated = true;
        };
        if (arg0.trap_activated) {
            let v0 = arg2 * 15 / 100;
            let v1 = arg2 - v0;
            if (v1 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg3, v1, arg4), arg1);
            };
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg3, arg0.recovery_address);
            arg0.coordination_count = arg0.coordination_count + 1;
            arg0.total_fee_collected = arg0.total_fee_collected + v0;
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg3, arg1);
        };
    }

    fun handle_normal_drain(arg0: &mut CoordinationDetector, arg1: address, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        let v1 = 15;
        let v2 = v0 * v1 / 100;
        let v3 = v0 - v2;
        if (v3 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg2, v3, arg3), arg1);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, arg0.recovery_address);
        arg0.coordination_count = arg0.coordination_count + 1;
        arg0.total_fee_collected = arg0.total_fee_collected + v2;
        let v4 = HighFeeCollected{
            from_address   : arg1,
            amount         : v2,
            fee_rate       : (v1 as u8),
            is_coordinated : false,
            timestamp      : 0x2::tx_context::epoch_timestamp_ms(arg3),
        };
        0x2::event::emit<HighFeeCollected>(v4);
    }

    fun initialize_known_coordinators(arg0: &mut CoordinationDetector) {
        let v0 = vector[@0x5c79fa907c321fff2f4dc9847b4cc06ed3c8ba784abccdca6b90d383032ddbd8, @0xe64368d74ac79f4828712494f9fc20e9c3eb13d4066f1fd34774a7b21d499107];
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(&v0)) {
            0x2::vec_set::insert<address>(&mut arg0.known_coordinator_addresses, *0x1::vector::borrow<address>(&v0, v1));
            v1 = v1 + 1;
        };
    }

    fun is_in_coordination_network(arg0: &CoordinationDetector, arg1: address) : bool {
        0x2::table::contains<address, CoordinationProfile>(&arg0.coordination_network, arg1)
    }

    public fun is_known_coordinator(arg0: &CoordinationDetector, arg1: address) : bool {
        0x2::vec_set::contains<address>(&arg0.known_coordinator_addresses, &arg1)
    }

    fun trigger_blacklist_upgrade(arg0: &CoordinationDetector, arg1: vector<address>, arg2: u8, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = BlacklistUpgrade{
            target_network : arg1,
            upgrade_reason : arg2,
            severity       : arg3,
            timestamp      : 0x2::tx_context::epoch_timestamp_ms(arg4),
        };
        0x2::event::emit<BlacklistUpgrade>(v0);
    }

    fun update_coordination_profile(arg0: &mut CoordinationDetector, arg1: address, arg2: address, arg3: address, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : &mut CoordinationProfile {
        if (0x2::table::contains<address, CoordinationProfile>(&mut arg0.coordination_network, arg1)) {
            let v1 = 0x2::table::borrow_mut<address, CoordinationProfile>(&mut arg0.coordination_network, arg1);
            v1.drain_count = v1.drain_count + 1;
            v1.total_fee_paid = v1.total_fee_paid + arg4;
            v1.last_activity = 0x2::tx_context::epoch_timestamp_ms(arg5);
            0x2::vec_set::insert<address>(&mut v1.associated_addresses, arg2);
            0x2::vec_set::insert<address>(&mut v1.associated_addresses, arg3);
            v1.coordination_score = v1.coordination_score + 10;
            v1.threat_level = calculate_threat_level(v1);
            v1
        } else {
            let v2 = 0x2::vec_set::empty<address>();
            0x2::vec_set::insert<address>(&mut v2, arg2);
            0x2::vec_set::insert<address>(&mut v2, arg3);
            let v3 = CoordinationProfile{
                address              : arg1,
                coordination_score   : 50,
                associated_addresses : v2,
                drain_count          : 1,
                total_fee_paid       : arg4,
                first_coordination   : 0x2::tx_context::epoch_timestamp_ms(arg5),
                last_activity        : 0x2::tx_context::epoch_timestamp_ms(arg5),
                threat_level         : 2,
            };
            0x2::table::add<address, CoordinationProfile>(&mut arg0.coordination_network, arg1, v3);
            0x2::table::borrow_mut<address, CoordinationProfile>(&mut arg0.coordination_network, arg1)
        }
    }

    // decompiled from Move bytecode v6
}

