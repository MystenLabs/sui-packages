module 0xa13e6c29dd8c213331e0d5717f86f25f56437121a9cfe06049345f99453a68b7::layer2_container {
    struct ContractReference has copy, drop, store {
        chain_id: u64,
        contract_address: 0x1::string::String,
        registered_at: u64,
    }

    struct Layer2Container has key {
        id: 0x2::object::UID,
        owner: address,
        layer1_contract: 0x1::option::Option<0x1::string::String>,
        xor_seed: u64,
        xor_modulus: u64,
        contract_references: 0x2::table::Table<u64, ContractReference>,
        active_chain_ids: 0x2::vec_set::VecSet<u64>,
        total_contracts: u64,
        global_interaction_count: u64,
        current_layer: u64,
        layer_88_active: bool,
        layer_108_active: bool,
        layer_162_active: bool,
    }

    struct Layer2State has copy, drop {
        owner: address,
        layer1_contract: 0x1::option::Option<0x1::string::String>,
        xor_seed: u64,
        xor_modulus: u64,
        total_contracts: u64,
        global_interaction_count: u64,
        current_layer: u64,
        layer_88_active: bool,
        layer_108_active: bool,
        layer_162_active: bool,
    }

    struct ContractRegistered has copy, drop {
        chain_id: u64,
        contract_address: 0x1::string::String,
        timestamp: u64,
    }

    struct InteractionRecorded has copy, drop {
        source_chain_id: u64,
        interaction_count: u64,
        timestamp: u64,
    }

    struct LayerActivated has copy, drop {
        layer_number: u64,
        total_contracts: u64,
        timestamp: u64,
    }

    public fun calculate_xor_route(arg0: &Layer2Container, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0x2::clock::timestamp_ms(arg3) + arg0.xor_seed + arg1 + arg2;
        while (v1 > 0) {
            0x1::vector::push_back<u8>(&mut v0, ((v1 & 255) as u8));
            v1 = v1 >> 8;
        };
        0x1::hash::sha3_256(v0)
    }

    fun check_layer_thresholds(arg0: &mut Layer2Container, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        if (arg0.total_contracts >= 88 && !arg0.layer_88_active) {
            arg0.layer_88_active = true;
            arg0.current_layer = 88;
            let v0 = LayerActivated{
                layer_number    : 88,
                total_contracts : arg0.total_contracts,
                timestamp       : 0x2::clock::timestamp_ms(arg1),
            };
            0x2::event::emit<LayerActivated>(v0);
        };
        if (arg0.total_contracts >= 108 && !arg0.layer_108_active) {
            arg0.layer_108_active = true;
            arg0.current_layer = 108;
            let v1 = LayerActivated{
                layer_number    : 108,
                total_contracts : arg0.total_contracts,
                timestamp       : 0x2::clock::timestamp_ms(arg1),
            };
            0x2::event::emit<LayerActivated>(v1);
        };
        if (arg0.total_contracts >= 162 && !arg0.layer_162_active) {
            arg0.layer_162_active = true;
            arg0.current_layer = 162;
            let v2 = LayerActivated{
                layer_number    : 162,
                total_contracts : arg0.total_contracts,
                timestamp       : 0x2::clock::timestamp_ms(arg1),
            };
            0x2::event::emit<LayerActivated>(v2);
        };
    }

    public fun get_contract_reference(arg0: &Layer2Container, arg1: u64) : &ContractReference {
        0x2::table::borrow<u64, ContractReference>(&arg0.contract_references, arg1)
    }

    public fun get_state(arg0: &Layer2Container) : Layer2State {
        Layer2State{
            owner                    : arg0.owner,
            layer1_contract          : arg0.layer1_contract,
            xor_seed                 : arg0.xor_seed,
            xor_modulus              : arg0.xor_modulus,
            total_contracts          : arg0.total_contracts,
            global_interaction_count : arg0.global_interaction_count,
            current_layer            : arg0.current_layer,
            layer_88_active          : arg0.layer_88_active,
            layer_108_active         : arg0.layer_108_active,
            layer_162_active         : arg0.layer_162_active,
        }
    }

    public entry fun initialize(arg0: address, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Layer2Container{
            id                       : 0x2::object::new(arg2),
            owner                    : arg0,
            layer1_contract          : 0x1::option::none<0x1::string::String>(),
            xor_seed                 : 13881,
            xor_modulus              : 162,
            contract_references      : 0x2::table::new<u64, ContractReference>(arg2),
            active_chain_ids         : 0x2::vec_set::empty<u64>(),
            total_contracts          : 0,
            global_interaction_count : 0,
            current_layer            : 1,
            layer_88_active          : false,
            layer_108_active         : false,
            layer_162_active         : false,
        };
        0x2::transfer::share_object<Layer2Container>(v0);
    }

    public entry fun record_interaction(arg0: &mut Layer2Container, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<u64, ContractReference>(&arg0.contract_references, arg1), 2);
        arg0.global_interaction_count = arg0.global_interaction_count + 1;
        let v0 = InteractionRecorded{
            source_chain_id   : arg1,
            interaction_count : arg0.global_interaction_count,
            timestamp         : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<InteractionRecorded>(v0);
    }

    public entry fun register_contract(arg0: &mut Layer2Container, arg1: u64, arg2: 0x1::string::String, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.owner, 0);
        let v0 = ContractReference{
            chain_id         : arg1,
            contract_address : arg2,
            registered_at    : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::table::add<u64, ContractReference>(&mut arg0.contract_references, arg1, v0);
        0x2::vec_set::insert<u64>(&mut arg0.active_chain_ids, arg1);
        arg0.total_contracts = arg0.total_contracts + 1;
        let v1 = ContractRegistered{
            chain_id         : arg1,
            contract_address : arg2,
            timestamp        : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<ContractRegistered>(v1);
        check_layer_thresholds(arg0, arg3, arg4);
    }

    public entry fun set_admin(arg0: &mut Layer2Container, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 0);
        arg0.owner = arg1;
    }

    public entry fun set_layer1_contract(arg0: &mut Layer2Container, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 0);
        arg0.layer1_contract = 0x1::option::some<0x1::string::String>(arg1);
    }

    // decompiled from Move bytecode v6
}

