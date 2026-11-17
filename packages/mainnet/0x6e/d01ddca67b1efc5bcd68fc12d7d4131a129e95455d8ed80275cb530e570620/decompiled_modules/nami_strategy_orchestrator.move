module 0x6ed01ddca67b1efc5bcd68fc12d7d4131a129e95455d8ed80275cb530e570620::nami_strategy_orchestrator {
    struct NAMI_STRATEGY_ORCHESTRATOR has drop {
        dummy_field: bool,
    }

    struct InitDone has key {
        id: 0x2::object::UID,
    }

    struct StrategyInitCap has key {
        id: 0x2::object::UID,
    }

    public fun initialize(arg0: &0x2::package::Publisher, arg1: StrategyInitCap, arg2: address, arg3: address, arg4: &mut 0x2::tx_context::TxContext) : 0x6ed01ddca67b1efc5bcd68fc12d7d4131a129e95455d8ed80275cb530e570620::nami_master_strategy_config::MasterStrategyCap {
        assert!(0x2::package::from_module<NAMI_STRATEGY_ORCHESTRATOR>(arg0), 0);
        let StrategyInitCap { id: v0 } = arg1;
        0x2::object::delete(v0);
        0x6ed01ddca67b1efc5bcd68fc12d7d4131a129e95455d8ed80275cb530e570620::nami_adapter_registry::initialize(arg4);
        let v1 = InitDone{id: 0x2::object::new(arg4)};
        0x2::transfer::share_object<InitDone>(v1);
        0x6ed01ddca67b1efc5bcd68fc12d7d4131a129e95455d8ed80275cb530e570620::nami_master_strategy_config::initialize(arg2, arg3, arg4)
    }

    fun init(arg0: NAMI_STRATEGY_ORCHESTRATOR, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<NAMI_STRATEGY_ORCHESTRATOR>(arg0, arg1), 0x2::tx_context::sender(arg1));
        let v0 = StrategyInitCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<StrategyInitCap>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

