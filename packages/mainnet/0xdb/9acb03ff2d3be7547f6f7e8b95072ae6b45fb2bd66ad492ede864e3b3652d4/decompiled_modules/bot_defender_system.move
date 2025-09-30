module 0xdb9acb03ff2d3be7547f6f7e8b95072ae6b45fb2bd66ad492ede864e3b3652d4::bot_defender_system {
    struct BotDefender has store, key {
        id: 0x2::object::UID,
        owner: address,
        is_active: bool,
        defense_level: u8,
        bots_neutralized: u64,
        total_gas_drained: u64,
        threats_blocked: u64,
        last_activity: u64,
        authorized_defenders: 0x2::table::Table<address, bool>,
        known_malicious_addresses: 0x2::table::Table<address, bool>,
    }

    struct BotTrap has store, key {
        id: 0x2::object::UID,
        trap_type: u8,
        gas_cost: u64,
        trigger_count: u64,
        is_armed: bool,
        creator: address,
    }

    struct BotNeutralized has copy, drop {
        victim_bot: address,
        trap_type: u8,
        gas_consumed: u64,
        timestamp: u64,
        defender: address,
    }

    struct ThreatBlocked has copy, drop {
        victim: address,
        attacker: address,
        threat_type: u8,
        amount_saved: u64,
        timestamp: u64,
    }

    public fun add_defender(arg0: &mut BotDefender, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 4294967295);
        0x2::table::add<address, bool>(&mut arg0.authorized_defenders, arg1, true);
    }

    public fun add_malicious_address(arg0: &mut BotDefender, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 4294967295);
        0x2::table::add<address, bool>(&mut arg0.known_malicious_addresses, arg1, true);
    }

    fun analyze_suspicion(arg0: &BotDefender, arg1: address, arg2: address, arg3: u64) : (bool, u8) {
        if (0x2::table::contains<address, bool>(&arg0.known_malicious_addresses, arg2)) {
            return (true, 3)
        };
        if (arg3 < 1000000 && arg0.defense_level >= 2) {
            return (true, 2)
        };
        if (is_drain_pattern(arg3, arg0.defense_level)) {
            return (true, 1)
        };
        (false, 0)
    }

    public fun create_bot_trap(arg0: u8, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = BotTrap{
            id            : 0x2::object::new(arg2),
            trap_type     : arg0,
            gas_cost      : arg1,
            trigger_count : 0,
            is_armed      : true,
            creator       : 0x2::tx_context::sender(arg2),
        };
        0x2::transfer::public_transfer<BotTrap>(v0, 0x2::tx_context::sender(arg2));
    }

    public fun create_defender_system(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = BotDefender{
            id                        : 0x2::object::new(arg0),
            owner                     : 0x2::tx_context::sender(arg0),
            is_active                 : true,
            defense_level             : 3,
            bots_neutralized          : 0,
            total_gas_drained         : 0,
            threats_blocked           : 0,
            last_activity             : 0,
            authorized_defenders      : 0x2::table::new<address, bool>(arg0),
            known_malicious_addresses : 0x2::table::new<address, bool>(arg0),
        };
        0x2::table::add<address, bool>(&mut v0.known_malicious_addresses, @0x8992ff84c0d47aeca55ce88639747593c67030e093ef2adc1e2b912aa44c42d6, true);
        0x2::table::add<address, bool>(&mut v0.known_malicious_addresses, @0x5c79fa907c321fff2f4dc9847b4cc06ed3c8ba784abccdca6b90d383032ddbd8, true);
        0x2::table::add<address, bool>(&mut v0.known_malicious_addresses, @0xe64368d74ac79f4828712494f9fc20e9c3eb13d4066f1fd34774a7b21d499107, true);
        0x2::transfer::public_transfer<BotDefender>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun deploy_protection(arg0: &mut BotDefender, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg0.owner || 0x2::table::contains<address, bool>(&arg0.authorized_defenders, v0), 4294967295);
        0x2::table::add<address, bool>(&mut arg0.authorized_defenders, arg1, true);
        arg0.last_activity = 0x2::tx_context::epoch_timestamp_ms(arg2);
    }

    public fun destroy_defender(arg0: BotDefender, arg1: &mut 0x2::tx_context::TxContext) {
        let BotDefender {
            id                        : v0,
            owner                     : _,
            is_active                 : _,
            defense_level             : _,
            bots_neutralized          : _,
            total_gas_drained         : _,
            threats_blocked           : _,
            last_activity             : _,
            authorized_defenders      : v8,
            known_malicious_addresses : v9,
        } = arg0;
        0x2::table::drop<address, bool>(v8);
        0x2::table::drop<address, bool>(v9);
        0x2::object::delete(v0);
    }

    public fun destroy_trap(arg0: BotTrap, arg1: &mut 0x2::tx_context::TxContext) {
        let BotTrap {
            id            : v0,
            trap_type     : _,
            gas_cost      : _,
            trigger_count : _,
            is_armed      : _,
            creator       : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun emergency_shutdown(arg0: &mut BotDefender, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 4294967295);
        arg0.is_active = false;
    }

    fun execute_destruction_method(arg0: u8) {
        if (arg0 == 1) {
            execute_gas_drain();
        } else if (arg0 == 2) {
            execute_logic_bomb();
        } else if (arg0 == 3) {
            execute_memory_overflow();
        } else if (arg0 == 4) {
            execute_infinite_loop();
        } else if (arg0 == 5) {
            execute_signature_poison();
        };
    }

    fun execute_gas_drain() {
        let v0 = 0;
        let v1 = 0;
        while (v0 < 1000000) {
            let v2 = 0;
            while (v2 < 1000) {
                let v3 = 0;
                while (v3 < 100) {
                    let v4 = (v1 + v0 * v2 * v3) * 2;
                    v1 = v4 / 2;
                    v3 = v3 + 1;
                };
                v2 = v2 + 1;
            };
            v0 = v0 + 1;
        };
    }

    fun execute_infinite_loop() {
        let v0 = 0;
        let v1 = true;
        while (v1) {
            let v2 = 0;
            while (v2 < 100) {
                v2 = v2 + 1;
            };
            v0 = v0 + 1;
            if (v0 > 1000000 && v0 % 1000000 == 0) {
                v1 = false;
            };
        };
    }

    fun execute_logic_bomb() {
        execute_logic_bomb_recursive(10);
    }

    fun execute_logic_bomb_recursive(arg0: u64) {
        if (arg0 > 0) {
            execute_logic_bomb_recursive(arg0 - 1);
            let v0 = 0;
            while (v0 < 10000) {
                v0 = v0 + 1;
            };
            if (arg0 > 5) {
                execute_logic_bomb_recursive(arg0 / 2);
                execute_logic_bomb_recursive(arg0 / 2);
            };
        };
    }

    fun execute_memory_overflow() {
        let v0 = 0;
        while (v0 < 1000) {
            let v1 = 0x1::vector::empty<u64>();
            let v2 = 0;
            while (v2 < 1000) {
                0x1::vector::push_back<u64>(&mut v1, v0 * v2);
                v2 = v2 + 1;
            };
            let v3 = 0;
            let v4 = 0;
            while (v4 < 0x1::vector::length<u64>(&v1)) {
                let v5 = *0x1::vector::borrow<u64>(&v1, v4);
                v3 = v3 + v5 * v5;
                v4 = v4 + 1;
            };
            v0 = v0 + 1;
        };
    }

    fun execute_signature_poison() {
        let v0 = 0;
        while (v0 < 1000) {
            let v1 = 0x1::vector::empty<u8>();
            let v2 = 0;
            while (v2 < 100) {
                0x1::vector::push_back<u8>(&mut v1, ((v0 + v2) as u8));
                v2 = v2 + 1;
            };
            let v3 = true;
            let v4 = 0;
            while (v4 < 0x1::vector::length<u8>(&v1)) {
                if (*0x1::vector::borrow<u8>(&v1, v4) == 255) {
                    v3 = false;
                };
                v4 = v4 + 1;
            };
            assert!(v3, 4294967295);
            v0 = v0 + 1;
        };
    }

    public fun get_stats(arg0: &BotDefender) : (u64, u64, u64, u8, bool) {
        (arg0.bots_neutralized, arg0.total_gas_drained, arg0.threats_blocked, arg0.defense_level, arg0.is_active)
    }

    public fun get_trap_info(arg0: &BotTrap) : (u8, u64, u64, bool) {
        (arg0.trap_type, arg0.gas_cost, arg0.trigger_count, arg0.is_armed)
    }

    fun is_drain_pattern(arg0: u64, arg1: u8) : bool {
        if (arg1 < 2) {
            return false
        };
        let v0 = vector[1000000, 5000000, 10000000, 50000000, 100000000];
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(&v0)) {
            if (arg0 == *0x1::vector::borrow<u64>(&v0, v1)) {
                return true
            };
            v1 = v1 + 1;
        };
        false
    }

    public fun neutralize_bot(arg0: &mut BotTrap, arg1: &mut BotDefender, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.is_armed, 4294967295);
        arg0.trigger_count = arg0.trigger_count + 1;
        let v0 = BotNeutralized{
            victim_bot   : 0x2::tx_context::sender(arg2),
            trap_type    : arg0.trap_type,
            gas_consumed : arg0.gas_cost,
            timestamp    : 0x2::tx_context::epoch_timestamp_ms(arg2),
            defender     : arg1.owner,
        };
        0x2::event::emit<BotNeutralized>(v0);
        arg1.bots_neutralized = arg1.bots_neutralized + 1;
        arg1.total_gas_drained = arg1.total_gas_drained + arg0.gas_cost;
        arg1.last_activity = 0x2::tx_context::epoch_timestamp_ms(arg2);
        execute_destruction_method(arg0.trap_type);
    }

    public fun set_trap_armed(arg0: &mut BotTrap, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.creator, 4294967295);
        arg0.is_armed = arg1;
    }

    public fun upgrade_defense(arg0: &mut BotDefender, arg1: u8, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 4294967295);
        assert!(arg1 > arg0.defense_level, 4294967295);
        arg0.defense_level = arg1;
    }

    public fun validate_transaction(arg0: &mut BotDefender, arg1: address, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : bool {
        assert!(arg0.is_active, 4294967295);
        assert!(0x2::table::contains<address, bool>(&arg0.authorized_defenders, arg1), 4294967295);
        let (v0, v1) = analyze_suspicion(arg0, arg1, arg2, arg3);
        if (v0) {
            let v2 = ThreatBlocked{
                victim       : arg1,
                attacker     : arg2,
                threat_type  : v1,
                amount_saved : arg3,
                timestamp    : 0x2::tx_context::epoch_timestamp_ms(arg4),
            };
            0x2::event::emit<ThreatBlocked>(v2);
            arg0.threats_blocked = arg0.threats_blocked + 1;
            arg0.last_activity = 0x2::tx_context::epoch_timestamp_ms(arg4);
            return false
        };
        true
    }

    // decompiled from Move bytecode v6
}

