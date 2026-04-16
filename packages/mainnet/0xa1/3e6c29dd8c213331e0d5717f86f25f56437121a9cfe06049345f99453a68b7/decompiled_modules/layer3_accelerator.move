module 0xa13e6c29dd8c213331e0d5717f86f25f56437121a9cfe06049345f99453a68b7::layer3_accelerator {
    struct NodeReference has copy, drop, store {
        node_id: u64,
        chain_id: u64,
        node_address: 0x1::string::String,
        registered_at: u64,
        energy_contribution: u64,
    }

    struct ReactorState has copy, drop, store {
        energy_level: u64,
        chain_reaction_depth: u64,
        is_critical: bool,
        is_perpetual: bool,
        last_activation: u64,
    }

    struct Layer3Accelerator has key {
        id: 0x2::object::UID,
        owner: address,
        layer2_container: 0x1::option::Option<0x1::string::String>,
        node_references: 0x2::table::Table<u64, NodeReference>,
        active_node_ids: 0x2::vec_set::VecSet<u64>,
        total_nodes: u64,
        reactor_state: ReactorState,
        gravitational_constant: u64,
        global_energy: u64,
        chain_reaction_count: u64,
    }

    struct Layer3State has copy, drop {
        owner: address,
        layer2_container: 0x1::option::Option<0x1::string::String>,
        total_nodes: u64,
        energy_level: u64,
        chain_reaction_depth: u64,
        is_critical: bool,
        is_perpetual: bool,
    }

    struct NodeRegistered has copy, drop {
        node_id: u64,
        chain_id: u64,
        energy_contribution: u64,
        timestamp: u64,
    }

    struct EnergyInjected has copy, drop {
        node_id: u64,
        energy_amount: u64,
        total_energy: u64,
        timestamp: u64,
    }

    struct ChainReactionTriggered has copy, drop {
        reaction_depth: u64,
        nodes_activated: u64,
        timestamp: u64,
    }

    struct CriticalMassReached has copy, drop {
        energy_level: u64,
        nodes_active: u64,
        timestamp: u64,
    }

    fun activate_gravitational_well(arg0: &mut Layer3Accelerator) {
        arg0.reactor_state.is_critical = true;
        arg0.reactor_state.chain_reaction_depth = arg0.reactor_state.chain_reaction_depth + 1;
    }

    public fun calculate_reverse_xor(arg0: &Layer3Accelerator, arg1: u64, arg2: u64) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 13881 + arg1 + arg2 + arg0.gravitational_constant;
        while (v1 > 0) {
            0x1::vector::push_back<u8>(&mut v0, ((v1 & 255) as u8));
            v1 = v1 >> 8;
        };
        0x1::hash::sha3_256(v0)
    }

    fun check_critical_mass(arg0: &mut Layer3Accelerator, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = if (arg0.total_nodes >= 88) {
            if (arg0.global_energy >= 8800000) {
                !arg0.reactor_state.is_critical
            } else {
                false
            }
        } else {
            false
        };
        if (v0) {
            arg0.reactor_state.is_critical = true;
            arg0.reactor_state.energy_level = arg0.global_energy;
            let v1 = CriticalMassReached{
                energy_level : arg0.global_energy,
                nodes_active : arg0.total_nodes,
                timestamp    : 0x2::clock::timestamp_ms(arg1),
            };
            0x2::event::emit<CriticalMassReached>(v1);
            activate_gravitational_well(arg0);
        };
    }

    public fun get_node_reference(arg0: &Layer3Accelerator, arg1: u64) : &NodeReference {
        0x2::table::borrow<u64, NodeReference>(&arg0.node_references, arg1)
    }

    public fun get_state(arg0: &Layer3Accelerator) : Layer3State {
        Layer3State{
            owner                : arg0.owner,
            layer2_container     : arg0.layer2_container,
            total_nodes          : arg0.total_nodes,
            energy_level         : arg0.reactor_state.energy_level,
            chain_reaction_depth : arg0.reactor_state.chain_reaction_depth,
            is_critical          : arg0.reactor_state.is_critical,
            is_perpetual         : arg0.reactor_state.is_perpetual,
        }
    }

    public entry fun initialize(arg0: address, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = ReactorState{
            energy_level         : 0,
            chain_reaction_depth : 0,
            is_critical          : false,
            is_perpetual         : false,
            last_activation      : 0,
        };
        let v1 = Layer3Accelerator{
            id                     : 0x2::object::new(arg2),
            owner                  : arg0,
            layer2_container       : 0x1::option::none<0x1::string::String>(),
            node_references        : 0x2::table::new<u64, NodeReference>(arg2),
            active_node_ids        : 0x2::vec_set::empty<u64>(),
            total_nodes            : 0,
            reactor_state          : v0,
            gravitational_constant : 987654321,
            global_energy          : 0,
            chain_reaction_count   : 0,
        };
        0x2::transfer::share_object<Layer3Accelerator>(v1);
    }

    public entry fun inject_energy(arg0: &mut Layer3Accelerator, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<u64, NodeReference>(&arg0.node_references, arg1), 1);
        arg0.reactor_state.energy_level = arg0.reactor_state.energy_level + arg2;
        arg0.global_energy = arg0.global_energy + arg2;
        let v0 = EnergyInjected{
            node_id       : arg1,
            energy_amount : arg2,
            total_energy  : arg0.global_energy,
            timestamp     : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<EnergyInjected>(v0);
        check_critical_mass(arg0, arg3, arg4);
    }

    public entry fun register_node(arg0: &mut Layer3Accelerator, arg1: u64, arg2: u64, arg3: 0x1::string::String, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg6) == arg0.owner, 0);
        let v0 = NodeReference{
            node_id             : arg1,
            chain_id            : arg2,
            node_address        : arg3,
            registered_at       : 0x2::clock::timestamp_ms(arg5),
            energy_contribution : arg4,
        };
        0x2::table::add<u64, NodeReference>(&mut arg0.node_references, arg1, v0);
        0x2::vec_set::insert<u64>(&mut arg0.active_node_ids, arg1);
        arg0.total_nodes = arg0.total_nodes + 1;
        arg0.global_energy = arg0.global_energy + arg4;
        let v1 = NodeRegistered{
            node_id             : arg1,
            chain_id            : arg2,
            energy_contribution : arg4,
            timestamp           : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<NodeRegistered>(v1);
        check_critical_mass(arg0, arg5, arg6);
    }

    public entry fun set_admin(arg0: &mut Layer3Accelerator, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 0);
        arg0.owner = arg1;
    }

    public entry fun set_layer2_container(arg0: &mut Layer3Accelerator, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 0);
        arg0.layer2_container = 0x1::option::some<0x1::string::String>(arg1);
    }

    public entry fun trigger_chain_reaction(arg0: &mut Layer3Accelerator, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 0);
        assert!(arg0.reactor_state.is_critical, 2);
        arg0.reactor_state.chain_reaction_depth = arg0.reactor_state.chain_reaction_depth + 1;
        arg0.chain_reaction_count = arg0.chain_reaction_count + 1;
        arg0.reactor_state.last_activation = 0x2::clock::timestamp_ms(arg1);
        let v0 = ChainReactionTriggered{
            reaction_depth  : arg0.reactor_state.chain_reaction_depth,
            nodes_activated : 0x2::vec_set::length<u64>(&arg0.active_node_ids),
            timestamp       : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<ChainReactionTriggered>(v0);
        if (arg0.reactor_state.chain_reaction_depth >= 144) {
            arg0.reactor_state.is_perpetual = true;
        };
    }

    // decompiled from Move bytecode v6
}

