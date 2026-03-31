module 0x3e708a6e1dfd6f96b54e0145613d505e508577df4a80aa5523caf380abba5e33::t2000 {
    struct Deployed has copy, drop {
        designation: vector<u8>,
        operator: address,
        dwallet_id: address,
        mission: vector<u8>,
        timestamp_ms: u64,
    }

    struct MissionComplete has copy, drop {
        designation: vector<u8>,
        mission: vector<u8>,
        profit_mist: u64,
        timestamp_ms: u64,
    }

    struct QuestComplete has copy, drop {
        idx: u64,
        designation: vector<u8>,
        mission: vector<u8>,
        agent_profit_iusd: u64,
        parent_cut_iusd: u64,
        timestamp_ms: u64,
    }

    struct AgentCulled has copy, drop {
        idx: u64,
        designation: vector<u8>,
        runs: u64,
        profit_iusd: u64,
        timestamp_ms: u64,
    }

    struct AgentSpawned has copy, drop {
        idx: u64,
        designation: vector<u8>,
        focus: vector<vector<u8>>,
        timestamp_ms: u64,
    }

    struct ProfitDistributed has copy, drop {
        total_iusd: u64,
        agent_count: u64,
        timestamp_ms: u64,
    }

    struct Armory has key {
        id: 0x2::object::UID,
        count: u64,
        total_collected_mist: u64,
        deploy_cost_mist: u64,
        treasury: address,
        admin: address,
    }

    struct T2000 has store, key {
        id: 0x2::object::UID,
        designation: vector<u8>,
        operator: address,
        dwallet_id: address,
        mission: vector<u8>,
        deployed_ms: u64,
        total_profit_mist: u64,
    }

    struct Agent has store, key {
        id: 0x2::object::UID,
        idx: u64,
        designation: vector<u8>,
        operator: address,
        dwallet_id: address,
        mission: vector<u8>,
        focus: vector<vector<u8>>,
        deployed_ms: u64,
        total_profit_iusd: u64,
        claimable_iusd: u64,
        runs: u64,
        active: bool,
    }

    public fun army_size(arg0: &Armory) : u64 {
        arg0.count
    }

    entry fun cull(arg0: &mut Armory, arg1: u64, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::dynamic_object_field::exists_<u64>(&arg0.id, arg1), 4);
        let v0 = 0x2::dynamic_object_field::borrow_mut<u64, Agent>(&mut arg0.id, arg1);
        assert!(v0.active, 4);
        assert!(v0.runs >= 50 && v0.total_profit_iusd == 0, 5);
        v0.active = false;
        let v1 = AgentCulled{
            idx          : arg1,
            designation  : v0.designation,
            runs         : v0.runs,
            profit_iusd  : v0.total_profit_iusd,
            timestamp_ms : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<AgentCulled>(v1);
    }

    entry fun deploy(arg0: &mut Armory, arg1: vector<u8>, arg2: vector<u8>, arg3: address, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u8>(&arg1) >= 2, 3);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg4) >= arg0.deploy_cost_mist, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg4, arg0.treasury);
        arg0.total_collected_mist = arg0.total_collected_mist + 0x2::coin::value<0x2::sui::SUI>(&arg4);
        arg0.count = arg0.count + 1;
        let v0 = 0x2::clock::timestamp_ms(arg5);
        let v1 = 0x2::tx_context::sender(arg6);
        let v2 = T2000{
            id                : 0x2::object::new(arg6),
            designation       : arg1,
            operator          : v1,
            dwallet_id        : arg3,
            mission           : arg2,
            deployed_ms       : v0,
            total_profit_mist : 0,
        };
        let v3 = Deployed{
            designation  : arg1,
            operator     : v1,
            dwallet_id   : arg3,
            mission      : arg2,
            timestamp_ms : v0,
        };
        0x2::event::emit<Deployed>(v3);
        0x2::transfer::transfer<T2000>(v2, v1);
    }

    public fun deploy_cost(arg0: &Armory) : u64 {
        arg0.deploy_cost_mist
    }

    entry fun deploy_quest(arg0: &mut Armory, arg1: vector<u8>, arg2: vector<u8>, arg3: address, arg4: vector<vector<u8>>, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u8>(&arg1) >= 2, 3);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg5) >= arg0.deploy_cost_mist, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg5, arg0.treasury);
        arg0.total_collected_mist = arg0.total_collected_mist + 0x2::coin::value<0x2::sui::SUI>(&arg5);
        let v0 = arg0.count;
        let v1 = 0x2::clock::timestamp_ms(arg6);
        let v2 = 0x2::tx_context::sender(arg7);
        let v3 = Agent{
            id                : 0x2::object::new(arg7),
            idx               : v0,
            designation       : arg1,
            operator          : v2,
            dwallet_id        : arg3,
            mission           : arg2,
            focus             : arg4,
            deployed_ms       : v1,
            total_profit_iusd : 0,
            claimable_iusd    : 0,
            runs              : 0,
            active            : true,
        };
        let v4 = Deployed{
            designation  : arg1,
            operator     : v2,
            dwallet_id   : arg3,
            mission      : arg2,
            timestamp_ms : v1,
        };
        0x2::event::emit<Deployed>(v4);
        0x2::dynamic_object_field::add<u64, Agent>(&mut arg0.id, v0, v3);
        arg0.count = v0 + 1;
    }

    entry fun distribute(arg0: &mut Armory, arg1: u64, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 1);
        assert!(arg1 > 0, 7);
        let v0 = 0;
        let v1 = 0;
        while (v1 < arg0.count) {
            if (0x2::dynamic_object_field::exists_<u64>(&arg0.id, v1)) {
                let v2 = 0x2::dynamic_object_field::borrow<u64, Agent>(&arg0.id, v1);
                if (v2.active && v2.total_profit_iusd > 0) {
                    v0 = v0 + v2.total_profit_iusd;
                };
            };
            v1 = v1 + 1;
        };
        if (v0 == 0) {
            return
        };
        v1 = 0;
        let v3 = 0;
        while (v1 < arg0.count) {
            if (0x2::dynamic_object_field::exists_<u64>(&arg0.id, v1)) {
                let v4 = 0x2::dynamic_object_field::borrow_mut<u64, Agent>(&mut arg0.id, v1);
                if (v4.active && v4.total_profit_iusd > 0) {
                    let v5 = arg1 * v4.total_profit_iusd / v0;
                    v4.claimable_iusd = v4.claimable_iusd + v5;
                    v3 = v3 + v5;
                };
            };
            v1 = v1 + 1;
        };
        let v6 = ProfitDistributed{
            total_iusd   : v3,
            agent_count  : arg0.count,
            timestamp_ms : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<ProfitDistributed>(v6);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Armory{
            id                   : 0x2::object::new(arg0),
            count                : 0,
            total_collected_mist : 0,
            deploy_cost_mist     : 1500000000,
            treasury             : 0x2::tx_context::sender(arg0),
            admin                : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::share_object<Armory>(v0);
    }

    entry fun report_mission(arg0: &mut T2000, arg1: vector<u8>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.operator, 1);
        arg0.total_profit_mist = arg0.total_profit_mist + arg2;
        let v0 = MissionComplete{
            designation  : arg0.designation,
            mission      : arg1,
            profit_mist  : arg2,
            timestamp_ms : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<MissionComplete>(v0);
    }

    entry fun report_quest(arg0: &mut Armory, arg1: u64, arg2: vector<u8>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg5) == arg0.admin, 1);
        assert!(0x2::dynamic_object_field::exists_<u64>(&arg0.id, arg1), 4);
        let v0 = 0x2::dynamic_object_field::borrow_mut<u64, Agent>(&mut arg0.id, arg1);
        let v1 = arg3 * 100 / 10000;
        let v2 = arg3 - v1;
        v0.total_profit_iusd = v0.total_profit_iusd + v2;
        v0.runs = v0.runs + 1;
        arg0.total_collected_mist = arg0.total_collected_mist + v1;
        let v3 = QuestComplete{
            idx               : arg1,
            designation       : v0.designation,
            mission           : arg2,
            agent_profit_iusd : v2,
            parent_cut_iusd   : v1,
            timestamp_ms      : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<QuestComplete>(v3);
    }

    entry fun set_admin(arg0: &mut Armory, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 1);
        arg0.admin = arg1;
    }

    entry fun set_deploy_cost(arg0: &mut Armory, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 1);
        arg0.deploy_cost_mist = arg1;
    }

    entry fun set_treasury(arg0: &mut Armory, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 1);
        arg0.treasury = arg1;
    }

    entry fun spawn_rwa(arg0: &mut Armory, arg1: vector<u8>, arg2: address, arg3: vector<vector<u8>>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg5) == arg0.admin, 1);
        assert!(0x1::vector::length<u8>(&arg1) >= 2, 3);
        let v0 = arg0.count;
        let v1 = 0x2::clock::timestamp_ms(arg4);
        let v2 = Agent{
            id                : 0x2::object::new(arg5),
            idx               : v0,
            designation       : arg1,
            operator          : arg0.admin,
            dwallet_id        : arg2,
            mission           : b"farm",
            focus             : arg3,
            deployed_ms       : v1,
            total_profit_iusd : 0,
            claimable_iusd    : 0,
            runs              : 0,
            active            : true,
        };
        let v3 = AgentSpawned{
            idx          : v0,
            designation  : arg1,
            focus        : arg3,
            timestamp_ms : v1,
        };
        0x2::event::emit<AgentSpawned>(v3);
        0x2::dynamic_object_field::add<u64, Agent>(&mut arg0.id, v0, v2);
        arg0.count = v0 + 1;
    }

    public fun total_collected(arg0: &Armory) : u64 {
        arg0.total_collected_mist
    }

    // decompiled from Move bytecode v6
}

