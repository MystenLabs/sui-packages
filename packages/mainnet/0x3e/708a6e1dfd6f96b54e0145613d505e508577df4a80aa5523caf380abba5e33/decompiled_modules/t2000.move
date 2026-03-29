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

    public fun army_size(arg0: &Armory) : u64 {
        arg0.count
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

    public fun total_collected(arg0: &Armory) : u64 {
        arg0.total_collected_mist
    }

    // decompiled from Move bytecode v6
}

