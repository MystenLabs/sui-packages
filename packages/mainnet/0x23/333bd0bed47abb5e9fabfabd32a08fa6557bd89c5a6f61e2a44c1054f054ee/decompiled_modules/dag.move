module 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::dag {
    struct OverDAG has drop {
        dummy_field: bool,
    }

    struct DAG has store, key {
        id: 0x2::object::UID,
    }

    struct DAGInnerV1 has store {
        finalized: bool,
        vertices: 0x2::linked_table::LinkedTable<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::Vertex, 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::VertexInfo>,
        entry_groups: 0x2::vec_map::VecMap<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::EntryGroup, 0x2::vec_map::VecMap<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::Vertex, 0x2::vec_set::VecSet<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::InputPort>>>,
        edges: 0x2::table::Table<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::Vertex, vector<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::Edge>>,
        outputs: 0x2::table::Table<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::Vertex, vector<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::OutputVariantPort>>,
        defaults_to_input_ports: 0x2::table::Table<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::VertexInputPort, 0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::data::NexusData>,
        post_failure_action: 0x1::option::Option<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::PostFailureAction>,
    }

    struct DAGCreatedEvent has copy, drop {
        dag: 0x2::object::ID,
    }

    struct DAGVertexAddedEvent has copy, drop {
        dag: 0x2::object::ID,
        vertex: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::Vertex,
        kind: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::VertexKind,
    }

    struct DAGEntryVertexInputPortAddedEvent has copy, drop {
        dag: 0x2::object::ID,
        vertex: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::Vertex,
        entry_port: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::InputPort,
        entry_group: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::EntryGroup,
    }

    struct DAGEdgeAddedEvent has copy, drop {
        dag: 0x2::object::ID,
        from_vertex: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::Vertex,
        edge: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::Edge,
    }

    struct DAGOutputAddedEvent has copy, drop {
        dag: 0x2::object::ID,
        vertex: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::Vertex,
        output: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::OutputVariantPort,
    }

    struct DAGDefaultValueAddedEvent has copy, drop {
        dag: 0x2::object::ID,
        vertex: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::Vertex,
        port: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::InputPort,
        value: 0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::data::NexusData,
    }

    struct DAGFinalizedEvent has copy, drop {
        dag: 0x2::object::ID,
    }

    public fun new(arg0: &mut 0x2::tx_context::TxContext) : (DAG, 0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::owner_cap::CloneableOwnerCap<OverDAG>) {
        let v0 = DAG{id: 0x2::object::new(arg0)};
        let v1 = DAGInnerV1{
            finalized               : false,
            vertices                : 0x2::linked_table::new<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::Vertex, 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::VertexInfo>(arg0),
            entry_groups            : 0x2::vec_map::empty<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::EntryGroup, 0x2::vec_map::VecMap<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::Vertex, 0x2::vec_set::VecSet<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::InputPort>>>(),
            edges                   : 0x2::table::new<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::Vertex, vector<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::Edge>>(arg0),
            outputs                 : 0x2::table::new<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::Vertex, vector<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::OutputVariantPort>>(arg0),
            defaults_to_input_ports : 0x2::table::new<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::VertexInputPort, 0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::data::NexusData>(arg0),
            post_failure_action     : 0x1::option::none<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::PostFailureAction>(),
        };
        0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::object_state::add<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::era::V1, DAGInnerV1>(&mut v0.id, 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::era::v1(), v1);
        let v2 = OverDAG{dummy_field: false};
        let v3 = DAGCreatedEvent{dag: 0x2::object::id<DAG>(&v0)};
        0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::event::emit<DAGCreatedEvent>(v3);
        (v0, 0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::owner_cap::new_cloneable_drop<OverDAG>(v2, &v0.id, arg0))
    }

    public fun add_vertex(arg0: &mut DAG, arg1: &mut 0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::owner_cap::CloneableOwnerCap<OverDAG>, arg2: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::Vertex, arg3: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::VertexKind, arg4: 0x2::object::ID, arg5: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::meta_schema::MetaSchema) {
        assert_dag_owner(arg0, arg1);
        let v0 = 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::vertex_info_new(arg3);
        0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::vertex_info_set_tool(&mut v0, arg4, arg5);
        let v1 = load_mut(arg0);
        0x2::linked_table::push_back<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::Vertex, 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::VertexInfo>(&mut v1.vertices, arg2, v0);
        let v2 = DAGVertexAddedEvent{
            dag    : 0x2::object::id<DAG>(arg0),
            vertex : arg2,
            kind   : arg3,
        };
        0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::event::emit<DAGVertexAddedEvent>(v2);
    }

    public fun assert_dag_owner(arg0: &DAG, arg1: &mut 0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::owner_cap::CloneableOwnerCap<OverDAG>) {
        assert!(0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::owner_cap::is_for<OverDAG, DAG>(arg1, arg0), 13906836433497096207);
    }

    public fun assert_finalized(arg0: &DAG) {
        assert!(is_finalized(arg0), 13906836412022521875);
    }

    fun assert_input_port_declared(arg0: &DAG, arg1: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::Vertex, arg2: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::InputPort) {
        input_port_schema(arg0, arg1, arg2);
    }

    public fun dag_runtime_vertex_tool_fqn(arg0: &DAG, arg1: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::RuntimeVertex) : 0x1::ascii::String {
        dag_vertex_tool_fqn(arg0, 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::vertex_name(&arg1))
    }

    fun dag_vertex_is_bound(arg0: &DAG, arg1: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::Vertex) : bool {
        let v0 = load(arg0);
        assert!(0x2::linked_table::contains<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::Vertex, 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::VertexInfo>(&v0.vertices, arg1), 13906836635359641601);
        0x1::option::is_some<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::meta_schema::MetaSchema>(0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::vertex_info_meta_schema(0x2::linked_table::borrow<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::Vertex, 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::VertexInfo>(&v0.vertices, arg1)))
    }

    public fun dag_vertex_meta_schema(arg0: &DAG, arg1: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::Vertex) : &0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::meta_schema::MetaSchema {
        let v0 = load(arg0);
        assert!(0x2::linked_table::contains<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::Vertex, 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::VertexInfo>(&v0.vertices, arg1), 13906836665424412673);
        let v1 = 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::vertex_info_meta_schema(0x2::linked_table::borrow<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::Vertex, 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::VertexInfo>(&v0.vertices, arg1));
        assert!(0x1::option::is_some<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::meta_schema::MetaSchema>(v1), 13906836674015658005);
        0x1::option::borrow<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::meta_schema::MetaSchema>(v1)
    }

    public fun dag_vertex_post_failure_action(arg0: &DAG, arg1: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::Vertex, arg2: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::verifier::FailureEvidenceKind) : 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::PostFailureAction {
        let v0 = load(arg0);
        assert!(0x2::linked_table::contains<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::Vertex, 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::VertexInfo>(&v0.vertices, arg1), 13906836755618725889);
        let v1 = 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::vertex_info_post_failure_action(0x2::linked_table::borrow<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::Vertex, 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::VertexInfo>(&v0.vertices, arg1));
        if (0x1::option::is_some<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::PostFailureAction>(v1)) {
            *0x1::option::borrow<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::PostFailureAction>(v1)
        } else if (0x1::option::is_some<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::PostFailureAction>(&v0.post_failure_action)) {
            *0x1::option::borrow<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::PostFailureAction>(&v0.post_failure_action)
        } else {
            0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::post_failure_action_terminate()
        }
    }

    public fun dag_vertex_tool_fqn(arg0: &DAG, arg1: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::Vertex) : 0x1::ascii::String {
        let v0 = load(arg0);
        assert!(0x2::linked_table::contains<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::Vertex, 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::VertexInfo>(&v0.vertices, arg1), 13906836467855917057);
        0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::vertex_kind_tool_fqn(0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::vertex_info_kind(0x2::linked_table::borrow<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::Vertex, 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::VertexInfo>(&v0.vertices, arg1)))
    }

    public fun dag_vertex_tool_id(arg0: &DAG, arg1: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::Vertex) : 0x2::object::ID {
        let v0 = load(arg0);
        assert!(0x2::linked_table::contains<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::Vertex, 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::VertexInfo>(&v0.vertices, arg1), 13906836600999903233);
        0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::vertex_info_tool_id(0x2::linked_table::borrow<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::Vertex, 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::VertexInfo>(&v0.vertices, arg1))
    }

    public fun dag_vertex_verifier_mode(arg0: &DAG, arg1: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::Vertex) : 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::verifier::ToolVerifierMode {
        let v0 = load(arg0);
        assert!(0x2::linked_table::contains<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::Vertex, 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::VertexInfo>(&v0.vertices, arg1), 13906836704079118337);
        assert!(is_vertex_offchain_tool(arg0, arg1), 13906836708374872077);
        0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::vertex_info_verifier_mode(0x2::linked_table::borrow<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::Vertex, 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::VertexInfo>(&v0.vertices, arg1))
    }

    public fun default_value_for_input(arg0: &DAG, arg1: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::VertexInputPort) : 0x1::option::Option<0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::data::NexusData> {
        let v0 = load(arg0);
        if (0x2::table::contains<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::VertexInputPort, 0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::data::NexusData>(&v0.defaults_to_input_ports, arg1)) {
            0x1::option::some<0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::data::NexusData>(*0x2::table::borrow<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::VertexInputPort, 0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::data::NexusData>(&v0.defaults_to_input_ports, arg1))
        } else {
            0x1::option::none<0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::data::NexusData>()
        }
    }

    public(friend) fun edge_shape_is_valid(arg0: bool, arg1: bool, arg2: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::EdgeKind) : bool {
        if (arg2 == 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::edge_kind_for_each()) {
            return arg0 && !arg1
        };
        if (arg2 == 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::edge_kind_collect()) {
            return !arg0 && arg1
        };
        arg0 == arg1
    }

    public fun edges_from(arg0: &DAG, arg1: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::Vertex) : &vector<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::Edge> {
        0x2::table::borrow<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::Vertex, vector<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::Edge>>(&load(arg0).edges, arg1)
    }

    public fun effective_input_payload_sha256(arg0: &DAG, arg1: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::RuntimeVertex, arg2: &0x2::vec_map::VecMap<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::InputPort, 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::PortData>) : vector<u8> {
        let v0 = 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::vertex_name(&arg1);
        assert!(dag_vertex_is_bound(arg0, v0), 13906837039087878165);
        let v1 = 0x1::vector::empty<0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::data::NexusData>();
        let v2 = dag_vertex_meta_schema(arg0, v0);
        let v3 = 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::meta_schema::input_ports(v2);
        let v4 = 0;
        while (v4 < 0x1::vector::length<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::meta_schema::PortSchema>(v3)) {
            let v5 = effective_runtime_vertex_input(arg0, arg1, 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::input_port_from_string(0x1::ascii::string(*0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::meta_schema::port_name(0x1::vector::borrow<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::meta_schema::PortSchema>(v3, v4)))), arg2);
            if (0x1::option::is_none<0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::data::NexusData>(&v5)) {
                return b""
            };
            0x1::vector::push_back<0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::data::NexusData>(&mut v1, 0x1::option::destroy_some<0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::data::NexusData>(v5));
            v4 = v4 + 1;
        };
        if (!0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::meta_schema::conforms_complete_input(v2, &v1)) {
            return b""
        };
        0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::meta_schema::input_hash_for_stored(v2, &v1)
    }

    fun effective_runtime_vertex_input(arg0: &DAG, arg1: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::RuntimeVertex, arg2: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::InputPort, arg3: &0x2::vec_map::VecMap<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::InputPort, 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::PortData>) : 0x1::option::Option<0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::data::NexusData> {
        if (0x2::vec_map::contains<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::InputPort, 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::PortData>(arg3, &arg2)) {
            return 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::port_data_runtime_vertex_input(0x2::vec_map::get<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::InputPort, 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::PortData>(arg3, &arg2), &arg1)
        };
        let v0 = default_value_for_input(arg0, 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::vertex_input_port(0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::vertex_name(&arg1), arg2));
        if (0x1::option::is_some<0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::data::NexusData>(&v0)) {
            return v0
        };
        0x1::option::none<0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::data::NexusData>()
    }

    public fun entry_group_vertex_count(arg0: &DAG, arg1: &0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::EntryGroup) : u64 {
        0x2::vec_map::length<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::Vertex, 0x2::vec_set::VecSet<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::InputPort>>(0x2::vec_map::get<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::EntryGroup, 0x2::vec_map::VecMap<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::Vertex, 0x2::vec_set::VecSet<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::InputPort>>>(&load(arg0).entry_groups, arg1))
    }

    public fun entry_group_vertex_port_count(arg0: &DAG, arg1: &0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::EntryGroup, arg2: &0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::Vertex) : u64 {
        0x2::vec_set::length<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::InputPort>(0x2::vec_map::get<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::Vertex, 0x2::vec_set::VecSet<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::InputPort>>(0x2::vec_map::get<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::EntryGroup, 0x2::vec_map::VecMap<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::Vertex, 0x2::vec_set::VecSet<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::InputPort>>>(&load(arg0).entry_groups, arg1), arg2))
    }

    public fun err_eval_record_outcome_for_variant(arg0: &DAG, arg1: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::RuntimeVertex, arg2: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::verifier::FailureEvidenceKind, arg3: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::OutputVariant) : 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::PostFailureAction {
        if (arg2 == 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::verifier::failure_evidence_kind_tool_evidence() && has_outgoing_edges_for_variant(arg0, 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::vertex_name(&arg1), arg3)) {
            0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::post_failure_action_transient_continue()
        } else {
            resolve_err_eval_failure_policy(arg0, arg1, arg2)
        }
    }

    public fun finalize(arg0: DAG, arg1: 0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::owner_cap::CloneableOwnerCap<OverDAG>) {
        assert!(0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::owner_cap::is_for<OverDAG, DAG>(&arg1, &arg0), 13906835106352201743);
        assert!(!is_finalized(&arg0), 13906835110647300113);
        0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::object_state::inner_mut<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::era::V1, DAGInnerV1>(&mut arg0.id).finalized = true;
        0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::owner_cap::destroy<OverDAG>(arg1);
        let v0 = DAGFinalizedEvent{dag: 0x2::object::id<DAG>(&arg0)};
        0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::event::emit<DAGFinalizedEvent>(v0);
        0x2::transfer::public_freeze_object<DAG>(arg0);
    }

    public fun has_edges_from(arg0: &DAG, arg1: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::Vertex) : bool {
        0x2::table::contains<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::Vertex, vector<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::Edge>>(&load(arg0).edges, arg1)
    }

    public fun has_entry_group(arg0: &DAG, arg1: &0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::EntryGroup) : bool {
        0x2::vec_map::contains<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::EntryGroup, 0x2::vec_map::VecMap<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::Vertex, 0x2::vec_set::VecSet<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::InputPort>>>(&load(arg0).entry_groups, arg1)
    }

    public fun has_outgoing_edges_for_variant(arg0: &DAG, arg1: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::Vertex, arg2: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::OutputVariant) : bool {
        if (!has_edges_from(arg0, arg1)) {
            return false
        };
        let v0 = edges_from(arg0, arg1);
        let v1 = 0;
        let v2;
        while (v1 < 0x1::vector::length<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::Edge>(v0)) {
            if (0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::edge_from_variant(0x1::vector::borrow<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::Edge>(v0, v1)) == arg2) {
                v2 = true;
                return v2
            };
            v1 = v1 + 1;
        };
        v2 = false;
        v2
    }

    public fun has_vertex(arg0: &DAG, arg1: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::Vertex) : bool {
        0x2::linked_table::contains<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::Vertex, 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::VertexInfo>(&load(arg0).vertices, arg1)
    }

    fun input_port_schema(arg0: &DAG, arg1: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::Vertex, arg2: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::InputPort) : 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::meta_schema::PortSchema {
        let v0 = 0x1::ascii::into_bytes(0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::input_port_into_string(arg2));
        let v1 = 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::meta_schema::find_input_port(dag_vertex_meta_schema(arg0, arg1), &v0);
        assert!(0x1::option::is_some<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::meta_schema::PortSchema>(&v1), 13906837657563168789);
        0x1::option::destroy_some<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::meta_schema::PortSchema>(v1)
    }

    fun insert_edge(arg0: &mut DAGInnerV1, arg1: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::Vertex, arg2: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::Edge) {
        if (0x2::table::contains<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::Vertex, vector<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::Edge>>(&arg0.edges, arg1)) {
            0x1::vector::push_back<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::Edge>(0x2::table::borrow_mut<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::Vertex, vector<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::Edge>>(&mut arg0.edges, arg1), arg2);
        } else {
            let v0 = 0x1::vector::empty<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::Edge>();
            0x1::vector::push_back<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::Edge>(&mut v0, arg2);
            0x2::table::add<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::Vertex, vector<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::Edge>>(&mut arg0.edges, arg1, v0);
        };
    }

    public fun is_entry_group_vertex(arg0: &DAG, arg1: &0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::EntryGroup, arg2: &0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::Vertex) : bool {
        0x2::vec_map::contains<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::Vertex, 0x2::vec_set::VecSet<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::InputPort>>(0x2::vec_map::get<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::EntryGroup, 0x2::vec_map::VecMap<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::Vertex, 0x2::vec_set::VecSet<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::InputPort>>>(&load(arg0).entry_groups, arg1), arg2)
    }

    public fun is_entry_group_vertex_port(arg0: &DAG, arg1: &0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::EntryGroup, arg2: &0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::Vertex, arg3: &0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::InputPort) : bool {
        0x2::vec_set::contains<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::InputPort>(0x2::vec_map::get<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::Vertex, 0x2::vec_set::VecSet<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::InputPort>>(0x2::vec_map::get<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::EntryGroup, 0x2::vec_map::VecMap<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::Vertex, 0x2::vec_set::VecSet<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::InputPort>>>(&load(arg0).entry_groups, arg1), arg2), arg3)
    }

    fun is_entry_input_port(arg0: &DAGInnerV1, arg1: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::Vertex, arg2: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::InputPort) : bool {
        let v0 = 0x2::vec_map::keys<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::EntryGroup, 0x2::vec_map::VecMap<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::Vertex, 0x2::vec_set::VecSet<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::InputPort>>>(&arg0.entry_groups);
        let v1 = &v0;
        let v2 = 0;
        let v3;
        while (v2 < 0x1::vector::length<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::EntryGroup>(v1)) {
            let v4 = 0x2::vec_map::get<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::EntryGroup, 0x2::vec_map::VecMap<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::Vertex, 0x2::vec_set::VecSet<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::InputPort>>>(&arg0.entry_groups, 0x1::vector::borrow<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::EntryGroup>(v1, v2));
            if (0x2::vec_map::contains<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::Vertex, 0x2::vec_set::VecSet<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::InputPort>>(v4, &arg1) && 0x2::vec_set::contains<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::InputPort>(0x2::vec_map::get<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::Vertex, 0x2::vec_set::VecSet<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::InputPort>>(v4, &arg1), &arg2)) {
                v3 = true;
                return v3
            };
            v2 = v2 + 1;
        };
        v3 = false;
        v3
    }

    public fun is_finalized(arg0: &DAG) : bool {
        load(arg0).finalized
    }

    public fun is_vertex_offchain_tool(arg0: &DAG, arg1: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::Vertex) : bool {
        let v0 = load(arg0);
        assert!(0x2::linked_table::contains<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::Vertex, 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::VertexInfo>(&v0.vertices, arg1), 13906837232360095745);
        0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::vertex_kind_is_off_chain(0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::vertex_info_kind(0x2::linked_table::borrow<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::Vertex, 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::VertexInfo>(&v0.vertices, arg1)))
    }

    public fun is_vertex_onchain_tool(arg0: &DAG, arg1: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::Vertex) : bool {
        let v0 = load(arg0);
        assert!(0x2::linked_table::contains<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::Vertex, 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::VertexInfo>(&v0.vertices, arg1), 13906836540870361089);
        0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::vertex_kind_is_on_chain(0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::vertex_info_kind(0x2::linked_table::borrow<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::Vertex, 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::VertexInfo>(&v0.vertices, arg1)))
    }

    fun load(arg0: &DAG) : &DAGInnerV1 {
        0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::object_state::inner<DAGInnerV1>(&arg0.id)
    }

    fun load_mut(arg0: &mut DAG) : &mut DAGInnerV1 {
        assert!(!is_finalized(arg0), 13906838001160290321);
        0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::object_state::inner_mut<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::era::V1, DAGInnerV1>(&mut arg0.id)
    }

    public fun new_with_owner_cap(arg0: &mut 0x2::tx_context::TxContext) : (DAG, 0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::owner_cap::CloneableOwnerCap<OverDAG>) {
        new(arg0)
    }

    fun output_port_schema(arg0: &DAG, arg1: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::Vertex, arg2: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::OutputVariant, arg3: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::OutputPort) : 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::meta_schema::PortSchema {
        let v0 = 0x1::ascii::into_bytes(0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::output_variant_into_string(arg2));
        let v1 = 0x1::ascii::into_bytes(0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::output_port_into_string(arg3));
        if (v0 == 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::meta_schema::failure_variant()) {
            assert!(v1 == 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::meta_schema::failure_port(), 13906837717692710933);
            return 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::meta_schema::port_schema(v1, false, 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::meta_schema::value_kind_data())
        };
        let v2 = 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::meta_schema::find_variant_port(dag_vertex_meta_schema(arg0, arg1), &v0, &v1);
        assert!(0x1::option::is_some<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::meta_schema::PortSchema>(&v2), 13906837773527285781);
        0x1::option::destroy_some<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::meta_schema::PortSchema>(v2)
    }

    fun prepare_edge_target(arg0: &mut DAGInnerV1, arg1: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::Vertex, arg2: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::InputPort) {
        assert!(!is_entry_input_port(arg0, arg1, arg2), 13906837803591008261);
        assert!(!0x2::table::contains<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::VertexInputPort, 0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::data::NexusData>(&arg0.defaults_to_input_ports, 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::vertex_input_port(arg1, arg2)), 13906837820770746371);
        let v0 = 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::vertex_info_input_ports_mut(0x2::linked_table::borrow_mut<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::Vertex, 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::VertexInfo>(&mut arg0.vertices, arg1));
        if (!0x2::vec_set::contains<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::InputPort>(v0, &arg2)) {
            0x2::vec_set::insert<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::InputPort>(v0, arg2);
        };
    }

    public fun rebuild(arg0: DAG, arg1: 0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::owner_cap::CloneableOwnerCap<OverDAG>, arg2: &mut 0x2::tx_context::TxContext) : (DAG, 0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::owner_cap::CloneableOwnerCap<OverDAG>) {
        assert!(0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::owner_cap::is_for<OverDAG, DAG>(&arg1, &arg0), 13906836313238011919);
        assert!(!is_finalized(&arg0), 13906836317533110289);
        let DAG { id: v0 } = arg0;
        0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::owner_cap::destroy<OverDAG>(arg1);
        let v1 = DAG{id: 0x2::object::new(arg2)};
        0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::object_state::add<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::era::V1, DAGInnerV1>(&mut v1.id, 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::era::v1(), 0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::object_state::destroy<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::era::V1, DAGInnerV1>(v0));
        let v2 = OverDAG{dummy_field: false};
        (v1, 0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::owner_cap::new_cloneable_drop<OverDAG>(v2, &v1.id, arg2))
    }

    public fun resolve_err_eval_failure_policy(arg0: &DAG, arg1: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::RuntimeVertex, arg2: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::verifier::FailureEvidenceKind) : 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::PostFailureAction {
        if (arg2 == 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::verifier::failure_evidence_kind_tool_evidence()) {
            dag_vertex_post_failure_action(arg0, 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::vertex_name(&arg1), 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::verifier::failure_evidence_kind_tool_evidence())
        } else {
            0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::post_failure_action_terminate()
        }
    }

    public fun set_vertex_verifier_mode(arg0: &mut DAG, arg1: &mut 0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::owner_cap::CloneableOwnerCap<OverDAG>, arg2: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::Vertex, arg3: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::verifier::ToolVerifierMode) {
        assert_dag_owner(arg0, arg1);
        assert!(0x2::linked_table::contains<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::Vertex, 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::VertexInfo>(&load(arg0).vertices, arg2), 13906835385524158465);
        assert!(is_vertex_offchain_tool(arg0, arg2), 13906835389819912205);
        0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::vertex_info_set_verifier_mode(0x2::linked_table::borrow_mut<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::Vertex, 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::VertexInfo>(&mut load_mut(arg0).vertices, arg2), arg3);
    }

    public fun sorted_input_ports_for_vertex(arg0: &DAG, arg1: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::Vertex) : vector<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::InputPort> {
        let v0 = load(arg0);
        assert!(0x2::linked_table::contains<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::Vertex, 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::VertexInfo>(&v0.vertices, arg1), 13906837193705390081);
        0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::sorted_input_ports(0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::vertex_info_input_ports(0x2::linked_table::borrow<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::Vertex, 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::VertexInfo>(&v0.vertices, arg1)))
    }

    public fun vertex_count(arg0: &DAG) : u64 {
        0x2::linked_table::length<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::Vertex, 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::VertexInfo>(&load(arg0).vertices)
    }

    public fun vertex_input_ports_len(arg0: &DAG, arg1: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::Vertex) : u64 {
        let v0 = load(arg0);
        assert!(0x2::linked_table::contains<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::Vertex, 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::VertexInfo>(&v0.vertices, arg1), 13906837155050684417);
        0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::vertex_info_input_ports_len(0x2::linked_table::borrow<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::Vertex, 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::VertexInfo>(&v0.vertices, arg1))
    }

    public fun vertex_names(arg0: &DAG) : vector<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::Vertex> {
        let v0 = 0x1::vector::empty<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::Vertex>();
        let v1 = &load(arg0).vertices;
        let v2 = 0x2::linked_table::front<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::Vertex, 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::VertexInfo>(v1);
        while (0x1::option::is_some<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::Vertex>(v2)) {
            let v3 = *0x1::option::borrow<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::Vertex>(v2);
            0x1::vector::push_back<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::Vertex>(&mut v0, v3);
            v2 = 0x2::linked_table::next<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::Vertex, 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::VertexInfo>(v1, v3);
        };
        v0
    }

    public fun vertex_tool_fqns(arg0: &DAG) : vector<0x1::ascii::String> {
        let v0 = 0x1::vector::empty<0x1::ascii::String>();
        let v1 = &load(arg0).vertices;
        let v2 = 0x2::linked_table::front<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::Vertex, 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::VertexInfo>(v1);
        while (0x1::option::is_some<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::Vertex>(v2)) {
            let v3 = *0x1::option::borrow<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::Vertex>(v2);
            0x1::vector::push_back<0x1::ascii::String>(&mut v0, dag_vertex_tool_fqn(arg0, v3));
            v2 = 0x2::linked_table::next<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::Vertex, 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::VertexInfo>(v1, v3);
        };
        v0
    }

    public fun with_default_value(arg0: DAG, arg1: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::Vertex, arg2: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::InputPort, arg3: 0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::data::NexusData) : DAG {
        assert!(0x2::linked_table::contains<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::Vertex, 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::VertexInfo>(&load(&arg0).vertices, arg1), 13906836137143435265);
        let v0 = input_port_schema(&arg0, arg1, arg2);
        assert!(0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::meta_schema::conforms_input_port(&v0, &arg3), 13906836145734680597);
        let v1 = &mut arg0;
        let v2 = load_mut(v1);
        assert!(!0x2::vec_set::contains<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::InputPort>(0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::vertex_info_input_ports(0x2::linked_table::borrow<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::Vertex, 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::VertexInfo>(&v2.vertices, arg1)), &arg2), 13906836171503304707);
        let v3 = 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::vertex_input_port(arg1, arg2);
        assert!(!0x2::table::contains<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::VertexInputPort, 0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::data::NexusData>(&v2.defaults_to_input_ports, v3), 13906836192978403335);
        0x2::table::add<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::VertexInputPort, 0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::data::NexusData>(&mut v2.defaults_to_input_ports, v3, arg3);
        let v4 = DAGDefaultValueAddedEvent{
            dag    : 0x2::object::id<DAG>(&arg0),
            vertex : arg1,
            port   : arg2,
            value  : arg3,
        };
        0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::event::emit<DAGDefaultValueAddedEvent>(v4);
        arg0
    }

    public fun with_edge(arg0: DAG, arg1: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::Vertex, arg2: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::OutputVariant, arg3: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::OutputPort, arg4: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::Vertex, arg5: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::InputPort, arg6: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::EdgeKind) : DAG {
        assert!(0x2::linked_table::contains<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::Vertex, 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::VertexInfo>(&load(&arg0).vertices, arg1), 13906835866560495617);
        assert!(0x2::linked_table::contains<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::Vertex, 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::VertexInfo>(&load(&arg0).vertices, arg4), 13906835870855462913);
        assert!(!0x2::table::contains<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::Vertex, vector<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::OutputVariantPort>>(&load(&arg0).outputs, arg1), 13906835875151085579);
        let v0 = output_port_schema(&arg0, arg1, arg2, arg3);
        let v1 = input_port_schema(&arg0, arg4, arg5);
        assert!(0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::meta_schema::value_kinds_compatible(&v0, &v1) && edge_shape_is_valid(0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::meta_schema::port_is_many(&v0), 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::meta_schema::port_is_many(&v1), arg6), 13906835922396512279);
        let v2 = &mut arg0;
        let v3 = load_mut(v2);
        prepare_edge_target(v3, arg4, arg5);
        let v4 = 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::edge(0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::output_variant_port(arg2, arg3), 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::vertex_input_port(arg4, arg5), arg6);
        insert_edge(v3, arg1, v4);
        let v5 = DAGEdgeAddedEvent{
            dag         : 0x2::object::id<DAG>(&arg0),
            from_vertex : arg1,
            edge        : v4,
        };
        0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::event::emit<DAGEdgeAddedEvent>(v5);
        arg0
    }

    public fun with_entry(arg0: DAG, arg1: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::Vertex) : DAG {
        with_entry_in_group(arg0, arg1, 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::default_entry_group())
    }

    public fun with_entry_in_group(arg0: DAG, arg1: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::Vertex, arg2: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::EntryGroup) : DAG {
        assert!(0x2::linked_table::contains<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::Vertex, 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::VertexInfo>(&load(&arg0).vertices, arg1), 13906835733416509441);
        assert!(dag_vertex_is_bound(&arg0, arg1), 13906835737712787477);
        let v0 = &mut arg0;
        let v1 = load_mut(v0);
        if (0x2::vec_map::contains<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::EntryGroup, 0x2::vec_map::VecMap<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::Vertex, 0x2::vec_set::VecSet<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::InputPort>>>(&v1.entry_groups, &arg2)) {
            let v2 = 0x2::vec_map::get_mut<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::EntryGroup, 0x2::vec_map::VecMap<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::Vertex, 0x2::vec_set::VecSet<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::InputPort>>>(&mut v1.entry_groups, &arg2);
            if (!0x2::vec_map::contains<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::Vertex, 0x2::vec_set::VecSet<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::InputPort>>(v2, &arg1)) {
                0x2::vec_map::insert<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::Vertex, 0x2::vec_set::VecSet<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::InputPort>>(v2, arg1, 0x2::vec_set::empty<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::InputPort>());
            };
        } else {
            let v3 = 0x2::vec_map::empty<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::Vertex, 0x2::vec_set::VecSet<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::InputPort>>();
            0x2::vec_map::insert<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::Vertex, 0x2::vec_set::VecSet<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::InputPort>>(&mut v3, arg1, 0x2::vec_set::empty<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::InputPort>());
            0x2::vec_map::insert<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::EntryGroup, 0x2::vec_map::VecMap<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::Vertex, 0x2::vec_set::VecSet<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::InputPort>>>(&mut v1.entry_groups, arg2, v3);
        };
        arg0
    }

    public fun with_entry_port(arg0: DAG, arg1: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::Vertex, arg2: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::InputPort) : DAG {
        with_entry_port_in_group(arg0, arg1, arg2, 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::default_entry_group())
    }

    public fun with_entry_port_in_group(arg0: DAG, arg1: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::Vertex, arg2: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::InputPort, arg3: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::EntryGroup) : DAG {
        assert!(0x2::linked_table::contains<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::Vertex, 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::VertexInfo>(&load(&arg0).vertices, arg1), 13906835467128537089);
        assert_input_port_declared(&arg0, arg1, arg2);
        let v0 = &mut arg0;
        let v1 = load_mut(v0);
        assert!(!0x2::table::contains<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::VertexInputPort, 0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::data::NexusData>(&v1.defaults_to_input_ports, 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::vertex_input_port(arg1, arg2)), 13906835488603504643);
        if (0x2::vec_set::contains<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::InputPort>(0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::vertex_info_input_ports(0x2::linked_table::borrow<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::Vertex, 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::VertexInfo>(&v1.vertices, arg1)), &arg2)) {
            assert!(is_entry_input_port(v1, arg1, arg2), 13906835514373439493);
        };
        if (0x2::vec_map::contains<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::EntryGroup, 0x2::vec_map::VecMap<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::Vertex, 0x2::vec_set::VecSet<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::InputPort>>>(&v1.entry_groups, &arg3)) {
            let v2 = 0x2::vec_map::get_mut<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::EntryGroup, 0x2::vec_map::VecMap<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::Vertex, 0x2::vec_set::VecSet<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::InputPort>>>(&mut v1.entry_groups, &arg3);
            if (0x2::vec_map::contains<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::Vertex, 0x2::vec_set::VecSet<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::InputPort>>(v2, &arg1)) {
                0x2::vec_set::insert<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::InputPort>(0x2::vec_map::get_mut<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::Vertex, 0x2::vec_set::VecSet<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::InputPort>>(v2, &arg1), arg2);
            } else {
                0x2::vec_map::insert<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::Vertex, 0x2::vec_set::VecSet<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::InputPort>>(v2, arg1, 0x2::vec_set::singleton<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::InputPort>(arg2));
            };
        } else {
            let v3 = 0x2::vec_map::empty<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::Vertex, 0x2::vec_set::VecSet<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::InputPort>>();
            0x2::vec_map::insert<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::Vertex, 0x2::vec_set::VecSet<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::InputPort>>(&mut v3, arg1, 0x2::vec_set::singleton<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::InputPort>(arg2));
            0x2::vec_map::insert<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::EntryGroup, 0x2::vec_map::VecMap<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::Vertex, 0x2::vec_set::VecSet<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::InputPort>>>(&mut v1.entry_groups, arg3, v3);
        };
        let v4 = 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::vertex_info_input_ports_mut(0x2::linked_table::borrow_mut<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::Vertex, 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::VertexInfo>(&mut v1.vertices, arg1));
        if (!0x2::vec_set::contains<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::InputPort>(v4, &arg2)) {
            0x2::vec_set::insert<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::InputPort>(v4, arg2);
        };
        let v5 = DAGEntryVertexInputPortAddedEvent{
            dag         : 0x2::object::id<DAG>(&arg0),
            vertex      : arg1,
            entry_port  : arg2,
            entry_group : arg3,
        };
        0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::event::emit<DAGEntryVertexInputPortAddedEvent>(v5);
        arg0
    }

    public fun with_output(arg0: DAG, arg1: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::Vertex, arg2: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::OutputVariant, arg3: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::OutputPort) : DAG {
        assert!(0x2::linked_table::contains<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::Vertex, 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::VertexInfo>(&load(&arg0).vertices, arg1), 13906836029769252865);
        assert!(!0x2::table::contains<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::Vertex, vector<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::Edge>>(&load(&arg0).edges, arg1), 13906836034064744457);
        output_port_schema(&arg0, arg1, arg2, arg3);
        let v0 = &mut arg0;
        let v1 = load_mut(v0);
        let v2 = 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::output_variant_port(arg2, arg3);
        if (0x2::table::contains<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::Vertex, vector<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::OutputVariantPort>>(&v1.outputs, arg1)) {
            0x1::vector::push_back<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::OutputVariantPort>(0x2::table::borrow_mut<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::Vertex, vector<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::OutputVariantPort>>(&mut v1.outputs, arg1), v2);
        } else {
            let v3 = 0x1::vector::empty<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::OutputVariantPort>();
            0x1::vector::push_back<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::OutputVariantPort>(&mut v3, v2);
            0x2::table::add<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::Vertex, vector<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::OutputVariantPort>>(&mut v1.outputs, arg1, v3);
        };
        let v4 = DAGOutputAddedEvent{
            dag    : 0x2::object::id<DAG>(&arg0),
            vertex : arg1,
            output : v2,
        };
        0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::event::emit<DAGOutputAddedEvent>(v4);
        arg0
    }

    public fun with_post_failure_action(arg0: DAG, arg1: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::PostFailureAction) : DAG {
        let v0 = &mut arg0;
        load_mut(v0).post_failure_action = 0x1::option::some<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::PostFailureAction>(arg1);
        arg0
    }

    public fun with_vertex_post_failure_action(arg0: DAG, arg1: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::Vertex, arg2: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::PostFailureAction) : DAG {
        let v0 = &mut arg0;
        let v1 = load_mut(v0);
        assert!(0x2::linked_table::contains<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::Vertex, 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::VertexInfo>(&v1.vertices, arg1), 13906835325394616321);
        0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::vertex_info_set_post_failure_action(0x2::linked_table::borrow_mut<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::Vertex, 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::graph::VertexInfo>(&mut v1.vertices, arg1), arg2);
        arg0
    }

    // decompiled from Move bytecode v7
}

