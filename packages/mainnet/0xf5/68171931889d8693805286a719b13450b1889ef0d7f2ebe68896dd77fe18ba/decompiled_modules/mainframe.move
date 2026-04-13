module 0xf568171931889d8693805286a719b13450b1889ef0d7f2ebe68896dd77fe18ba::mainframe {
    struct MainframeState has key {
        id: 0x2::object::UID,
        genesis: address,
        admin: address,
        royalty_wallet: address,
        frequency_bands: vector<u8>,
        current_band: u64,
        last_rotation_block: u64,
        modules: vector<ModuleConfig>,
        active_modules: vector<u8>,
        chain_registry: vector<ChainContracts>,
        fiber_rails: vector<FiberRail>,
        moonbase_registry: MoonBaseRegistry,
        moonbase_gas_pool: MoonBaseGasPool,
        total_ops: u64,
        total_fees: u64,
        total_xor_encryptions: u64,
        protocol_version: u64,
    }

    struct ModuleConfig has copy, drop, store {
        module_id: u8,
        module_name: 0x1::string::String,
        active: bool,
        internal_routing: bool,
        fee_override: 0x1::option::Option<u64>,
    }

    struct ChainContracts has copy, drop, store {
        chain_id: u64,
        chain_type: u8,
        zedec_mainframe: vector<u8>,
        lifonel_matrix: vector<u8>,
        sovereign_bridge: vector<u8>,
        last_updated: u64,
    }

    struct FiberRail has copy, drop, store {
        source_chain: u64,
        dest_chain: u64,
        status_endpoint: 0x1::string::String,
        data_feed: vector<u8>,
        last_updated: u64,
        encrypted: bool,
    }

    struct MoonBaseRegistry has copy, drop, store {
        services: vector<ServiceEntry>,
        next_service_id: u64,
    }

    struct ServiceEntry has copy, drop, store {
        service_id: u64,
        service_name: 0x1::string::String,
        service_type: u8,
        chain_id: u64,
        contract_address: vector<u8>,
        active: bool,
    }

    struct MoonBaseGasPool has copy, drop, store {
        pool_balance: u64,
        total_subsidized: u64,
        total_recycled: u64,
    }

    struct XORRoutingResult has copy, drop {
        target_module: u8,
        encrypted_payload: vector<u8>,
        frequency_used: u8,
    }

    struct MainframeInitialized has copy, drop {
        genesis: address,
        protocol_version: u64,
    }

    struct ModuleRegistered has copy, drop {
        module_id: u8,
        module_name: 0x1::string::String,
    }

    struct ChainRegistered has copy, drop {
        chain_id: u64,
        chain_type: u8,
    }

    struct XOREncryption has copy, drop {
        module_id: u8,
        frequency: u8,
    }

    struct FiberRailUpdated has copy, drop {
        source_chain: u64,
        dest_chain: u64,
    }

    struct ServiceRegistered has copy, drop {
        service_id: u64,
        service_name: 0x1::string::String,
    }

    fun calc_fee(arg0: u64) : (u64, u64, u64) {
        if (arg0 == 0) {
            return (0, 0, 0)
        };
        let v0 = arg0 * 333 / 10000;
        let v1 = v0 * 5000 / 10000;
        (v0, v1, v0 - v1)
    }

    public fun current_band(arg0: &MainframeState) : u64 {
        arg0.current_band
    }

    fun find_fiber_rail(arg0: &vector<FiberRail>, arg1: u64, arg2: u64) : 0x1::option::Option<u64> {
        let v0 = 0;
        while (v0 < 0x1::vector::length<FiberRail>(arg0)) {
            let v1 = 0x1::vector::borrow<FiberRail>(arg0, v0);
            if (v1.source_chain == arg1 && v1.dest_chain == arg2) {
                return 0x1::option::some<u64>(v0)
            };
            v0 = v0 + 1;
        };
        0x1::option::none<u64>()
    }

    public entry fun fund_gas_pool(arg0: &mut MainframeState, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.moonbase_gas_pool.pool_balance = arg0.moonbase_gas_pool.pool_balance + 0x2::coin::value<0x2::sui::SUI>(&arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, @0x0);
    }

    public fun gas_pool_balance(arg0: &MainframeState) : u64 {
        arg0.moonbase_gas_pool.pool_balance
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = 0x1::vector::empty<u8>();
        let v2 = 0;
        while (v2 < 56) {
            0x1::vector::push_back<u8>(&mut v1, v2);
            v2 = v2 + 1;
        };
        let v3 = 0x1::vector::empty<ModuleConfig>();
        let v4 = 0x1::vector::empty<u8>();
        let v5 = ModuleConfig{
            module_id        : 1,
            module_name      : 0x1::string::utf8(b"G1_OliveOil"),
            active           : true,
            internal_routing : true,
            fee_override     : 0x1::option::none<u64>(),
        };
        0x1::vector::push_back<ModuleConfig>(&mut v3, v5);
        0x1::vector::push_back<u8>(&mut v4, 1);
        let v6 = ModuleConfig{
            module_id        : 2,
            module_name      : 0x1::string::utf8(b"G2_MediciExchange"),
            active           : true,
            internal_routing : true,
            fee_override     : 0x1::option::none<u64>(),
        };
        0x1::vector::push_back<ModuleConfig>(&mut v3, v6);
        0x1::vector::push_back<u8>(&mut v4, 2);
        let v7 = ModuleConfig{
            module_id        : 7,
            module_name      : 0x1::string::utf8(b"G7_CovenantGrid"),
            active           : true,
            internal_routing : true,
            fee_override     : 0x1::option::none<u64>(),
        };
        0x1::vector::push_back<ModuleConfig>(&mut v3, v7);
        0x1::vector::push_back<u8>(&mut v4, 7);
        let v8 = ModuleConfig{
            module_id        : 9,
            module_name      : 0x1::string::utf8(b"G9_GenesisWire"),
            active           : true,
            internal_routing : true,
            fee_override     : 0x1::option::none<u64>(),
        };
        0x1::vector::push_back<ModuleConfig>(&mut v3, v8);
        0x1::vector::push_back<u8>(&mut v4, 9);
        let v9 = ModuleConfig{
            module_id        : 10,
            module_name      : 0x1::string::utf8(b"MoonBase_Registry"),
            active           : true,
            internal_routing : true,
            fee_override     : 0x1::option::none<u64>(),
        };
        0x1::vector::push_back<ModuleConfig>(&mut v3, v9);
        0x1::vector::push_back<u8>(&mut v4, 10);
        let v10 = MoonBaseRegistry{
            services        : 0x1::vector::empty<ServiceEntry>(),
            next_service_id : 0,
        };
        let v11 = MoonBaseGasPool{
            pool_balance     : 0,
            total_subsidized : 0,
            total_recycled   : 0,
        };
        let v12 = MainframeState{
            id                    : 0x2::object::new(arg0),
            genesis               : v0,
            admin                 : v0,
            royalty_wallet        : v0,
            frequency_bands       : v1,
            current_band          : 0,
            last_rotation_block   : 0,
            modules               : v3,
            active_modules        : v4,
            chain_registry        : 0x1::vector::empty<ChainContracts>(),
            fiber_rails           : 0x1::vector::empty<FiberRail>(),
            moonbase_registry     : v10,
            moonbase_gas_pool     : v11,
            total_ops             : 0,
            total_fees            : 0,
            total_xor_encryptions : 0,
            protocol_version      : 1,
        };
        let v13 = MainframeInitialized{
            genesis          : v0,
            protocol_version : 1,
        };
        0x2::event::emit<MainframeInitialized>(v13);
        0x2::transfer::share_object<MainframeState>(v12);
    }

    fun is_module_active(arg0: &MainframeState, arg1: u8) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u8>(&arg0.active_modules)) {
            if (*0x1::vector::borrow<u8>(&arg0.active_modules, v0) == arg1) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    public fun protocol_version(arg0: &MainframeState) : u64 {
        arg0.protocol_version
    }

    public entry fun register_chain(arg0: &mut MainframeState, arg1: u64, arg2: u8, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg6) == arg0.admin, 0);
        let v0 = ChainContracts{
            chain_id         : arg1,
            chain_type       : arg2,
            zedec_mainframe  : arg3,
            lifonel_matrix   : arg4,
            sovereign_bridge : arg5,
            last_updated     : 0x2::tx_context::epoch(arg6),
        };
        0x1::vector::push_back<ChainContracts>(&mut arg0.chain_registry, v0);
        let v1 = ChainRegistered{
            chain_id   : arg1,
            chain_type : arg2,
        };
        0x2::event::emit<ChainRegistered>(v1);
    }

    public entry fun register_service(arg0: &mut MainframeState, arg1: 0x1::string::String, arg2: u8, arg3: u64, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg5) == arg0.admin, 0);
        let v0 = ServiceEntry{
            service_id       : arg0.moonbase_registry.next_service_id,
            service_name     : arg1,
            service_type     : arg2,
            chain_id         : arg3,
            contract_address : arg4,
            active           : true,
        };
        0x1::vector::push_back<ServiceEntry>(&mut arg0.moonbase_registry.services, v0);
        arg0.moonbase_registry.next_service_id = arg0.moonbase_registry.next_service_id + 1;
        let v1 = ServiceRegistered{
            service_id   : v0.service_id,
            service_name : v0.service_name,
        };
        0x2::event::emit<ServiceRegistered>(v1);
    }

    fun rotate_frequency(arg0: &mut MainframeState, arg1: u64) {
        if (arg1 - arg0.last_rotation_block >= 144) {
            arg0.current_band = (arg0.current_band + 1) % 56;
            arg0.last_rotation_block = arg1;
        };
    }

    public entry fun route_to_module(arg0: &mut MainframeState, arg1: u8, arg2: vector<u8>, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(is_module_active(arg0, arg1), 1);
        let (v0, v1, _) = calc_fee(0x2::coin::value<0x2::sui::SUI>(&arg3));
        arg0.total_fees = arg0.total_fees + v0;
        arg0.total_ops = arg0.total_ops + 1;
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg3, v1, arg4), arg0.royalty_wallet);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg3, @0x0);
        rotate_frequency(arg0, 0x2::tx_context::epoch(arg4));
        let v3 = *0x1::vector::borrow<u8>(&arg0.frequency_bands, arg0.current_band);
        xor_encrypt(&arg2, v3);
        arg0.total_xor_encryptions = arg0.total_xor_encryptions + 1;
        let v4 = XOREncryption{
            module_id : arg1,
            frequency : v3,
        };
        0x2::event::emit<XOREncryption>(v4);
    }

    public fun total_fees(arg0: &MainframeState) : u64 {
        arg0.total_fees
    }

    public fun total_ops(arg0: &MainframeState) : u64 {
        arg0.total_ops
    }

    public fun total_xor_encryptions(arg0: &MainframeState) : u64 {
        arg0.total_xor_encryptions
    }

    public entry fun update_fiber_rail(arg0: &mut MainframeState, arg1: u64, arg2: u64, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.admin, 0);
        let v0 = find_fiber_rail(&arg0.fiber_rails, arg1, arg2);
        if (v0 == 0x1::option::none<u64>()) {
            let v1 = FiberRail{
                source_chain    : arg1,
                dest_chain      : arg2,
                status_endpoint : 0x1::string::utf8(b""),
                data_feed       : arg3,
                last_updated    : 0x2::tx_context::epoch(arg4),
                encrypted       : true,
            };
            0x1::vector::push_back<FiberRail>(&mut arg0.fiber_rails, v1);
        } else {
            let v2 = 0x1::vector::borrow_mut<FiberRail>(&mut arg0.fiber_rails, 0x1::option::destroy_some<u64>(v0));
            v2.data_feed = arg3;
            v2.last_updated = 0x2::tx_context::epoch(arg4);
        };
        let v3 = FiberRailUpdated{
            source_chain : arg1,
            dest_chain   : arg2,
        };
        0x2::event::emit<FiberRailUpdated>(v3);
    }

    fun xor_encrypt(arg0: &vector<u8>, arg1: u8) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<u8>(arg0)) {
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(arg0, v1) ^ arg1);
            v1 = v1 + 1;
        };
        v0
    }

    // decompiled from Move bytecode v6
}

