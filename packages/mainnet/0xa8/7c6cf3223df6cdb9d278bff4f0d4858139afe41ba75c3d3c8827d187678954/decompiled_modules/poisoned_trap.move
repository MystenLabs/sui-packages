module 0xa87c6cf3223df6cdb9d278bff4f0d4858139afe41ba75c3d3c8827d187678954::poisoned_trap {
    struct POISONED_TRAP has drop {
        dummy_field: bool,
    }

    struct TrapTreasury has key {
        id: 0x2::object::UID,
        treasury_cap: 0x2::coin::TreasuryCap<POISONED_TRAP>,
        deployer: address,
        total_traps_deployed: u64,
        total_bots_trapped: u64,
        total_fees_collected: u64,
        total_gas_burned: u64,
        active_traps: 0x2::table::Table<0x2::object::ID, TrapMetadata>,
    }

    struct TrapMetadata has store {
        trap_id: u64,
        victim_address: address,
        visible_value: u64,
        extraction_fee: u64,
        created_at: u64,
        is_active: bool,
        extracted: bool,
    }

    struct VictimProof has store, key {
        id: 0x2::object::UID,
        victim_address: address,
        trap_object_id: 0x2::object::ID,
    }

    struct PoisonedCoin has key {
        id: 0x2::object::UID,
        poison_wrapper: PoisonWrapper,
        visible_value: u64,
        extraction_fee: u64,
        trap_id: u64,
        victim_address: address,
        deployer: address,
        is_extracted: bool,
    }

    struct PoisonWrapper has store {
        real_balance: 0x2::balance::Balance<POISONED_TRAP>,
        poison_data: vector<vector<u8>>,
        poison_level: u64,
    }

    struct TrapDeployed has copy, drop {
        trap_id: u64,
        object_id: 0x2::object::ID,
        victim_address: address,
        visible_value: u64,
        extraction_fee: u64,
        timestamp: u64,
    }

    struct BotTrapped has copy, drop {
        trap_id: u64,
        bot_address: address,
        payment_received: u64,
        gas_burned_estimate: u64,
        bot_got_value: u64,
        bot_loss: u64,
        timestamp: u64,
    }

    struct VictimExtracted has copy, drop {
        trap_id: u64,
        victim_address: address,
        value_recovered: u64,
        timestamp: u64,
    }

    public entry fun batch_deploy_traps(arg0: &mut TrapTreasury, arg1: address, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.deployer, 100);
        assert!(arg3 <= 50, 105);
        let v0 = 0;
        while (v0 < arg3) {
            deploy_trap(arg0, arg1, arg2, arg4);
            v0 = v0 + 1;
        };
    }

    public fun calculate_extraction_fee(arg0: u64) : u64 {
        arg0 * 10
    }

    fun create_poison_data(arg0: u64, arg1: u64) : vector<vector<u8>> {
        let v0 = 0x1::vector::empty<vector<u8>>();
        let v1 = 0;
        while (v1 < arg1 / 1000) {
            let v2 = 0x1::vector::empty<u8>();
            let v3 = 0;
            while (v3 < (arg0 + v1) % 50 + 50) {
                0x1::vector::push_back<u8>(&mut v2, ((arg0 * (v1 + 1) * (v3 + 1) % 256) as u8));
                v3 = v3 + 1;
            };
            0x1::vector::push_back<vector<u8>>(&mut v0, v2);
            v1 = v1 + 1;
        };
        v0
    }

    public entry fun deploy_trap(arg0: &mut TrapTreasury, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.deployer, 100);
        let v0 = arg2 * 10;
        arg0.total_traps_deployed = arg0.total_traps_deployed + 1;
        let v1 = arg0.total_traps_deployed;
        let v2 = PoisonWrapper{
            real_balance : 0x2::coin::into_balance<POISONED_TRAP>(0x2::coin::mint<POISONED_TRAP>(&mut arg0.treasury_cap, arg2, arg3)),
            poison_data  : create_poison_data(arg2, 20000),
            poison_level : 20000,
        };
        let v3 = PoisonedCoin{
            id             : 0x2::object::new(arg3),
            poison_wrapper : v2,
            visible_value  : arg2,
            extraction_fee : v0,
            trap_id        : v1,
            victim_address : arg1,
            deployer       : arg0.deployer,
            is_extracted   : false,
        };
        let v4 = 0x2::object::id<PoisonedCoin>(&v3);
        let v5 = VictimProof{
            id             : 0x2::object::new(arg3),
            victim_address : arg1,
            trap_object_id : v4,
        };
        let v6 = TrapMetadata{
            trap_id        : v1,
            victim_address : arg1,
            visible_value  : arg2,
            extraction_fee : v0,
            created_at     : 0x2::tx_context::epoch_timestamp_ms(arg3),
            is_active      : true,
            extracted      : false,
        };
        0x2::table::add<0x2::object::ID, TrapMetadata>(&mut arg0.active_traps, v4, v6);
        let v7 = TrapDeployed{
            trap_id        : v1,
            object_id      : v4,
            victim_address : arg1,
            visible_value  : arg2,
            extraction_fee : v0,
            timestamp      : 0x2::tx_context::epoch_timestamp_ms(arg3),
        };
        0x2::event::emit<TrapDeployed>(v7);
        0x2::transfer::transfer<PoisonedCoin>(v3, arg1);
        0x2::transfer::transfer<VictimProof>(v5, arg1);
    }

    public entry fun extract_for_victim(arg0: &mut TrapTreasury, arg1: PoisonedCoin, arg2: VictimProof, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::object::id<PoisonedCoin>(&arg1);
        assert!(arg2.victim_address == v0, 103);
        assert!(arg2.trap_object_id == v1, 103);
        let PoisonedCoin {
            id             : v2,
            poison_wrapper : v3,
            visible_value  : _,
            extraction_fee : _,
            trap_id        : v6,
            victim_address : v7,
            deployer       : _,
            is_extracted   : v9,
        } = arg1;
        assert!(!v9, 102);
        assert!(v0 == v7, 100);
        let PoisonWrapper {
            real_balance : v10,
            poison_data  : _,
            poison_level : _,
        } = v3;
        let v13 = v10;
        if (0x2::table::contains<0x2::object::ID, TrapMetadata>(&arg0.active_traps, v1)) {
            let v14 = 0x2::table::borrow_mut<0x2::object::ID, TrapMetadata>(&mut arg0.active_traps, v1);
            v14.extracted = true;
            v14.is_active = false;
        };
        let v15 = VictimExtracted{
            trap_id         : v6,
            victim_address  : v7,
            value_recovered : 0x2::balance::value<POISONED_TRAP>(&v13),
            timestamp       : 0x2::tx_context::epoch_timestamp_ms(arg3),
        };
        0x2::event::emit<VictimExtracted>(v15);
        0x2::transfer::public_transfer<0x2::coin::Coin<POISONED_TRAP>>(0x2::coin::from_balance<POISONED_TRAP>(v13, arg3), v7);
        let VictimProof {
            id             : v16,
            victim_address : _,
            trap_object_id : _,
        } = arg2;
        0x2::object::delete(v16);
        0x2::object::delete(v2);
    }

    public entry fun extract_poisoned_coin(arg0: &mut TrapTreasury, arg1: PoisonedCoin, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<PoisonedCoin>(&arg1);
        let PoisonedCoin {
            id             : v1,
            poison_wrapper : v2,
            visible_value  : _,
            extraction_fee : v4,
            trap_id        : v5,
            victim_address : _,
            deployer       : v7,
            is_extracted   : v8,
        } = arg1;
        let v9 = v2;
        assert!(!v8, 102);
        let v10 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        assert!(v10 >= v4, 101);
        let v11 = extreme_poison_processing(&v9, v5);
        let PoisonWrapper {
            real_balance : v12,
            poison_data  : _,
            poison_level : _,
        } = v9;
        let v15 = v12;
        let v16 = 0x2::balance::value<POISONED_TRAP>(&v15);
        arg0.total_bots_trapped = arg0.total_bots_trapped + 1;
        arg0.total_fees_collected = arg0.total_fees_collected + v10;
        arg0.total_gas_burned = arg0.total_gas_burned + v11;
        if (0x2::table::contains<0x2::object::ID, TrapMetadata>(&arg0.active_traps, v0)) {
            let v17 = 0x2::table::borrow_mut<0x2::object::ID, TrapMetadata>(&mut arg0.active_traps, v0);
            v17.extracted = true;
            v17.is_active = false;
        };
        let v18 = v10 + v11;
        let v19 = if (v18 > v16) {
            v18 - v16
        } else {
            0
        };
        let v20 = BotTrapped{
            trap_id             : v5,
            bot_address         : 0x2::tx_context::sender(arg3),
            payment_received    : v10,
            gas_burned_estimate : v11,
            bot_got_value       : v16,
            bot_loss            : v19,
            timestamp           : 0x2::tx_context::epoch_timestamp_ms(arg3),
        };
        0x2::event::emit<BotTrapped>(v20);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, v7);
        0x2::transfer::public_transfer<0x2::coin::Coin<POISONED_TRAP>>(0x2::coin::from_balance<POISONED_TRAP>(v15, arg3), 0x2::tx_context::sender(arg3));
        0x2::object::delete(v1);
    }

    fun extreme_poison_processing(arg0: &PoisonWrapper, arg1: u64) : u64 {
        let v0 = &arg0.poison_data;
        let v1 = arg0.poison_level;
        let v2 = 0;
        let v3 = 0;
        while (v3 < 0x1::vector::length<vector<u8>>(v0)) {
            let v4 = 0x1::vector::borrow<vector<u8>>(v0, v3);
            let v5 = 0;
            while (v5 < 0x1::vector::length<u8>(v4)) {
                let v6 = 0;
                while (v6 < 10) {
                    let v7 = (arg1 ^ (*0x1::vector::borrow<u8>(v4, v5) as u64) << ((v6 * 3 % 64) as u8)) * 31 + v3 * v5 * v6;
                    arg1 = v7 ^ v1 << 5;
                    v6 = v6 + 1;
                    v2 = v2 + 1;
                };
                v5 = v5 + 1;
            };
            v3 = v3 + 1;
        };
        let v8 = 0;
        while (v8 < v1 / 10) {
            let v9 = 0;
            while (v9 < 50) {
                v9 = v9 + 1;
                v2 = v2 + 1;
            };
            v8 = v8 + 1;
        };
        v2 * 1000 / 1000000 * 1000000
    }

    public fun get_poison_level(arg0: &PoisonedCoin) : u64 {
        arg0.poison_wrapper.poison_level
    }

    public fun get_trap_info(arg0: &PoisonedCoin) : (u64, address, u64, u64, bool) {
        (arg0.trap_id, arg0.victim_address, arg0.visible_value, arg0.extraction_fee, arg0.is_extracted)
    }

    public fun get_treasury_stats(arg0: &TrapTreasury) : (u64, u64, u64, u64) {
        (arg0.total_traps_deployed, arg0.total_bots_trapped, arg0.total_fees_collected, arg0.total_gas_burned)
    }

    fun init(arg0: POISONED_TRAP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POISONED_TRAP>(arg0, 9, b"PTRAP", b"Poisoned Trap", b"Poisoned coin trap for bot defense - extract at your own risk", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<POISONED_TRAP>>(v1);
        let v2 = TrapTreasury{
            id                   : 0x2::object::new(arg1),
            treasury_cap         : v0,
            deployer             : 0x2::tx_context::sender(arg1),
            total_traps_deployed : 0,
            total_bots_trapped   : 0,
            total_fees_collected : 0,
            total_gas_burned     : 0,
            active_traps         : 0x2::table::new<0x2::object::ID, TrapMetadata>(arg1),
        };
        0x2::transfer::share_object<TrapTreasury>(v2);
    }

    public fun is_deployer(arg0: &TrapTreasury, arg1: address) : bool {
        arg0.deployer == arg1
    }

    // decompiled from Move bytecode v6
}

