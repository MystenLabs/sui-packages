module 0x60cf8f32a33b03c7d2f03cae94bb30dc4c500c285a35b0d480ee2a1963131a32::default_tap {
    struct DefaultTAP has key {
        id: 0x2::object::UID,
        witness: 0x2::object_bag::ObjectBag,
        iv: 0x8585d9584893de6c197fd2eaf759f369cecf3a1eb6a94cc762a0a0674b2f197b::version::InterfaceVersion,
    }

    struct BeginDagExecutionWitness has drop {
        dummy_field: bool,
    }

    struct DefaultTAPV1Witness has store, key {
        id: 0x2::object::UID,
        iv: 0x8585d9584893de6c197fd2eaf759f369cecf3a1eb6a94cc762a0a0674b2f197b::version::InterfaceVersion,
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : DefaultTAP {
        let v0 = 0x2::object::new(arg0);
        let v1 = 0x2::object::uid_to_inner(&v0);
        let v2 = DefaultTAPV1Witness{
            id : 0x2::object::new(arg0),
            iv : 0x8585d9584893de6c197fd2eaf759f369cecf3a1eb6a94cc762a0a0674b2f197b::version::v(1),
        };
        0x2::dynamic_field::add<0x8585d9584893de6c197fd2eaf759f369cecf3a1eb6a94cc762a0a0674b2f197b::version::InterfaceVersion, 0x8585d9584893de6c197fd2eaf759f369cecf3a1eb6a94cc762a0a0674b2f197b::v1::InterfacePackageConfig>(&mut v2.id, v2.iv, 0x8585d9584893de6c197fd2eaf759f369cecf3a1eb6a94cc762a0a0674b2f197b::v1::new_interface_package_config(shared_objects_config_v1(v1)));
        let v3 = 0x2::object_bag::new(arg0);
        0x2::object_bag::add<vector<u8>, DefaultTAPV1Witness>(&mut v3, b"witness", v2);
        let v4 = DefaultTAP{
            id      : v0,
            witness : v3,
            iv      : 0x8585d9584893de6c197fd2eaf759f369cecf3a1eb6a94cc762a0a0674b2f197b::version::v(1),
        };
        let v5 = get_witness(&v4);
        0x8585d9584893de6c197fd2eaf759f369cecf3a1eb6a94cc762a0a0674b2f197b::v1::announce_interface_package<DefaultTAPV1Witness>(&v5.id, v5, shared_objects_config_v1(v1));
        v4
    }

    public fun confirm_tool_eval_for_walk(arg0: &DefaultTAP, arg1: 0xe465ec2863d8208a4943744f056f978fefa502d67d0a021de65efdee209ee83a::proof_of_uid::ProofOfUID) {
        0x8585d9584893de6c197fd2eaf759f369cecf3a1eb6a94cc762a0a0674b2f197b::version::expect_v(&arg0.iv, 1);
        0xe465ec2863d8208a4943744f056f978fefa502d67d0a021de65efdee209ee83a::proof_of_uid::consume(arg1, &get_witness(arg0).id);
    }

    fun get_witness(arg0: &DefaultTAP) : &DefaultTAPV1Witness {
        0x2::object_bag::borrow<vector<u8>, DefaultTAPV1Witness>(&arg0.witness, b"witness")
    }

    public fun prepare_dag_execution(arg0: &mut DefaultTAP, arg1: &0x60cf8f32a33b03c7d2f03cae94bb30dc4c500c285a35b0d480ee2a1963131a32::dag::DAG, arg2: &mut 0x60cf8f32a33b03c7d2f03cae94bb30dc4c500c285a35b0d480ee2a1963131a32::gas::GasService, arg3: &0x60cf8f32a33b03c7d2f03cae94bb30dc4c500c285a35b0d480ee2a1963131a32::tool_registry::ToolRegistry, arg4: 0x2::object::ID, arg5: 0x60cf8f32a33b03c7d2f03cae94bb30dc4c500c285a35b0d480ee2a1963131a32::dag::EntryGroup, arg6: 0x2::vec_map::VecMap<0x60cf8f32a33b03c7d2f03cae94bb30dc4c500c285a35b0d480ee2a1963131a32::dag::Vertex, 0x2::vec_map::VecMap<0x60cf8f32a33b03c7d2f03cae94bb30dc4c500c285a35b0d480ee2a1963131a32::dag::InputPort, 0xe465ec2863d8208a4943744f056f978fefa502d67d0a021de65efdee209ee83a::data::NexusData>>, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (0x60cf8f32a33b03c7d2f03cae94bb30dc4c500c285a35b0d480ee2a1963131a32::dag::RequestWalkExecution, 0x60cf8f32a33b03c7d2f03cae94bb30dc4c500c285a35b0d480ee2a1963131a32::dag::DAGExecution, 0x60cf8f32a33b03c7d2f03cae94bb30dc4c500c285a35b0d480ee2a1963131a32::gas::ExecutionGas) {
        0x8585d9584893de6c197fd2eaf759f369cecf3a1eb6a94cc762a0a0674b2f197b::version::expect_v(&arg0.iv, 1);
        let v0 = worksheet(arg0);
        let (v1, v2) = 0x60cf8f32a33b03c7d2f03cae94bb30dc4c500c285a35b0d480ee2a1963131a32::dag::begin_execution_with_config(arg1, arg3, &mut v0, 0x60cf8f32a33b03c7d2f03cae94bb30dc4c500c285a35b0d480ee2a1963131a32::dag::new_dag_execution_config(0x2::object::id<0x60cf8f32a33b03c7d2f03cae94bb30dc4c500c285a35b0d480ee2a1963131a32::dag::DAG>(arg1), arg4, arg5, arg6, arg7, arg9), arg8, arg9);
        let v3 = v1;
        0xe465ec2863d8208a4943744f056f978fefa502d67d0a021de65efdee209ee83a::proof_of_uid::consume(v0, &get_witness(arg0).id);
        (v2, v3, 0x60cf8f32a33b03c7d2f03cae94bb30dc4c500c285a35b0d480ee2a1963131a32::gas::create_execution_gas(arg2, arg1, &v3, arg9))
    }

    public fun prepare_dag_execution_from_scheduler(arg0: &mut DefaultTAP, arg1: &mut 0x60cf8f32a33b03c7d2f03cae94bb30dc4c500c285a35b0d480ee2a1963131a32::scheduler::Task, arg2: &0x60cf8f32a33b03c7d2f03cae94bb30dc4c500c285a35b0d480ee2a1963131a32::dag::DAG, arg3: &mut 0x60cf8f32a33b03c7d2f03cae94bb30dc4c500c285a35b0d480ee2a1963131a32::gas::GasService, arg4: &0x60cf8f32a33b03c7d2f03cae94bb30dc4c500c285a35b0d480ee2a1963131a32::tool_registry::ToolRegistry, arg5: &0xe465ec2863d8208a4943744f056f978fefa502d67d0a021de65efdee209ee83a::owner_cap::CloneableOwnerCap<0x60cf8f32a33b03c7d2f03cae94bb30dc4c500c285a35b0d480ee2a1963131a32::leader_cap::OverNetwork>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x60cf8f32a33b03c7d2f03cae94bb30dc4c500c285a35b0d480ee2a1963131a32::dag::RequestWalkExecution, 0x60cf8f32a33b03c7d2f03cae94bb30dc4c500c285a35b0d480ee2a1963131a32::dag::DAGExecution, 0x60cf8f32a33b03c7d2f03cae94bb30dc4c500c285a35b0d480ee2a1963131a32::gas::ExecutionGas) {
        0x8585d9584893de6c197fd2eaf759f369cecf3a1eb6a94cc762a0a0674b2f197b::version::expect_v(&arg0.iv, 1);
        let v0 = *0xe465ec2863d8208a4943744f056f978fefa502d67d0a021de65efdee209ee83a::policy::borrow_config<BeginDagExecutionWitness, 0x60cf8f32a33b03c7d2f03cae94bb30dc4c500c285a35b0d480ee2a1963131a32::scheduler::Execution, 0x60cf8f32a33b03c7d2f03cae94bb30dc4c500c285a35b0d480ee2a1963131a32::dag::DagExecutionConfig>(0x60cf8f32a33b03c7d2f03cae94bb30dc4c500c285a35b0d480ee2a1963131a32::scheduler::borrow_execution(arg1));
        0x60cf8f32a33b03c7d2f03cae94bb30dc4c500c285a35b0d480ee2a1963131a32::dag::assert_config_matches_leader_cap(&v0, arg5);
        let v1 = worksheet(arg0);
        let (v2, v3) = 0x60cf8f32a33b03c7d2f03cae94bb30dc4c500c285a35b0d480ee2a1963131a32::dag::begin_execution_with_config(arg2, arg4, &mut v1, v0, arg6, arg7);
        let v4 = v2;
        0xe465ec2863d8208a4943744f056f978fefa502d67d0a021de65efdee209ee83a::proof_of_uid::consume(v1, &get_witness(arg0).id);
        let v5 = BeginDagExecutionWitness{dummy_field: false};
        0x60cf8f32a33b03c7d2f03cae94bb30dc4c500c285a35b0d480ee2a1963131a32::scheduler::advance_execution_with_witness<BeginDagExecutionWitness>(arg1, v5);
        (v3, v4, 0x60cf8f32a33b03c7d2f03cae94bb30dc4c500c285a35b0d480ee2a1963131a32::gas::create_execution_gas(arg3, arg2, &v4, arg7))
    }

    public fun register_begin_execution(arg0: &mut 0xe465ec2863d8208a4943744f056f978fefa502d67d0a021de65efdee209ee83a::policy::Policy<0x60cf8f32a33b03c7d2f03cae94bb30dc4c500c285a35b0d480ee2a1963131a32::scheduler::Execution>, arg1: 0x60cf8f32a33b03c7d2f03cae94bb30dc4c500c285a35b0d480ee2a1963131a32::dag::DagExecutionConfig) {
        0xe465ec2863d8208a4943744f056f978fefa502d67d0a021de65efdee209ee83a::policy::register<BeginDagExecutionWitness, 0x60cf8f32a33b03c7d2f03cae94bb30dc4c500c285a35b0d480ee2a1963131a32::scheduler::Execution, 0x60cf8f32a33b03c7d2f03cae94bb30dc4c500c285a35b0d480ee2a1963131a32::dag::DagExecutionConfig>(arg0, arg1);
    }

    public(friend) fun share(arg0: DefaultTAP) {
        0x2::transfer::share_object<DefaultTAP>(arg0);
    }

    fun shared_objects_config_v1(arg0: 0x2::object::ID) : vector<0x8585d9584893de6c197fd2eaf759f369cecf3a1eb6a94cc762a0a0674b2f197b::v1::SharedObjectRef> {
        let v0 = 0x1::vector::empty<0x8585d9584893de6c197fd2eaf759f369cecf3a1eb6a94cc762a0a0674b2f197b::v1::SharedObjectRef>();
        0x1::vector::push_back<0x8585d9584893de6c197fd2eaf759f369cecf3a1eb6a94cc762a0a0674b2f197b::v1::SharedObjectRef>(&mut v0, 0x8585d9584893de6c197fd2eaf759f369cecf3a1eb6a94cc762a0a0674b2f197b::v1::shared_object_ref_imm(arg0));
        v0
    }

    public fun worksheet(arg0: &DefaultTAP) : 0xe465ec2863d8208a4943744f056f978fefa502d67d0a021de65efdee209ee83a::proof_of_uid::ProofOfUID {
        0x8585d9584893de6c197fd2eaf759f369cecf3a1eb6a94cc762a0a0674b2f197b::version::expect_v(&arg0.iv, 1);
        0xe465ec2863d8208a4943744f056f978fefa502d67d0a021de65efdee209ee83a::proof_of_uid::new_with_type<DefaultTAPV1Witness>(&get_witness(arg0).id, get_witness(arg0))
    }

    // decompiled from Move bytecode v6
}

