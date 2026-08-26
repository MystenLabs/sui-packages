module 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::authorization {
    struct AgentSkillAuthorization has store, key {
        id: 0x2::object::UID,
    }

    struct AgentSkillAuthorizationInnerV1 has store {
        agent_id: 0x2::object::ID,
        skill_id: u64,
        interface_version: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::version::InterfaceVersion,
        vertex_authorization_grants: vector<0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::authorization::Grant<AgentVertexAuthorization>>,
    }

    struct AgentVertexAuthorization has copy, drop, store {
        skill_id: u64,
        interface_version: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::version::InterfaceVersion,
        dag_id: 0x2::object::ID,
        vertex: 0x1::ascii::String,
        task_id: 0x2::object::ID,
    }

    struct AgentVertexAuthorizationContext has copy, drop, store {
        agent_id: 0x2::object::ID,
        skill_id: u64,
        interface_version: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::version::InterfaceVersion,
        execution_id: 0x2::object::ID,
        vertex: 0x1::ascii::String,
        task_id: 0x2::object::ID,
    }

    struct AgentVertexAuthorizationStamp has copy, drop, store {
        context: AgentVertexAuthorizationContext,
        input_commitment: vector<u8>,
    }

    public fun agent_skill_authorization_agent_id(arg0: &AgentSkillAuthorization) : 0x2::object::ID {
        load_v1(arg0).agent_id
    }

    public fun agent_skill_authorization_grant_count(arg0: &AgentSkillAuthorization) : u64 {
        0x1::vector::length<0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::authorization::Grant<AgentVertexAuthorization>>(&load_v1(arg0).vertex_authorization_grants)
    }

    public fun agent_skill_authorization_interface_version(arg0: &AgentSkillAuthorization) : 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::version::InterfaceVersion {
        load_v1(arg0).interface_version
    }

    public fun agent_skill_authorization_skill_id(arg0: &AgentSkillAuthorization) : u64 {
        load_v1(arg0).skill_id
    }

    public fun agent_vertex_authorization_context(arg0: 0x2::object::ID, arg1: u64, arg2: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::version::InterfaceVersion, arg3: 0x2::object::ID, arg4: 0x1::ascii::String, arg5: 0x2::object::ID) : AgentVertexAuthorizationContext {
        AgentVertexAuthorizationContext{
            agent_id          : arg0,
            skill_id          : arg1,
            interface_version : arg2,
            execution_id      : arg3,
            vertex            : arg4,
            task_id           : arg5,
        }
    }

    public fun agent_vertex_authorization_dag_id(arg0: &AgentVertexAuthorization) : 0x2::object::ID {
        arg0.dag_id
    }

    public fun agent_vertex_authorization_interface_version(arg0: &AgentVertexAuthorization) : 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::version::InterfaceVersion {
        arg0.interface_version
    }

    public fun agent_vertex_authorization_skill_id(arg0: &AgentVertexAuthorization) : u64 {
        arg0.skill_id
    }

    public fun agent_vertex_authorization_stamp(arg0: AgentVertexAuthorizationContext, arg1: vector<u8>) : AgentVertexAuthorizationStamp {
        assert!(0x1::vector::length<u8>(&arg1) == 32, 13906834805703573505);
        AgentVertexAuthorizationStamp{
            context          : arg0,
            input_commitment : arg1,
        }
    }

    public fun agent_vertex_authorization_stamp_input_commitment(arg0: &AgentVertexAuthorizationStamp) : vector<u8> {
        arg0.input_commitment
    }

    public fun agent_vertex_authorization_task_id(arg0: &AgentVertexAuthorization) : 0x2::object::ID {
        arg0.task_id
    }

    public fun agent_vertex_authorization_vertex(arg0: &AgentVertexAuthorization) : 0x1::ascii::String {
        arg0.vertex
    }

    public fun authorization_matches_worksheet(arg0: &AgentVertexAuthorization, arg1: 0x2::object::ID, arg2: &0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::proof_of_uid::ProofOfUID, arg3: &AgentVertexAuthorizationStamp) : bool {
        let v0 = AgentVertexAuthorizationStamp{
            context          : agent_vertex_authorization_context(arg1, arg0.skill_id, arg0.interface_version, 0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::proof_of_uid::created_from(arg2), arg0.vertex, arg0.task_id),
            input_commitment : arg3.input_commitment,
        };
        let v1 = 0x1::bcs::to_bytes<AgentVertexAuthorizationStamp>(&v0);
        0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::proof_of_uid::has_stamp_with_data(arg2, 0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::proof_of_uid::created_from(arg2), &v1)
    }

    public fun consume_verified_for_worksheet_as_recipient(arg0: 0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::authorization::ProvenValue<AgentVertexAuthorization>, arg1: &0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::proof_of_uid::ProofOfUID, arg2: &0x2::object::UID, arg3: vector<u8>) : bool {
        let v0 = 0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::authorization::recipient<AgentVertexAuthorization>(&arg0);
        if (0x1::option::is_none<0x2::object::ID>(&v0)) {
            0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::authorization::drop<AgentVertexAuthorization>(arg0);
            return false
        };
        if (*0x1::option::borrow<0x2::object::ID>(&v0) != 0x2::object::uid_to_inner(arg2)) {
            0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::authorization::drop<AgentVertexAuthorization>(arg0);
            return false
        };
        let v1 = 0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::authorization::by<AgentVertexAuthorization>(&arg0);
        let v2 = 0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::authorization::unwrap_as_recipient<AgentVertexAuthorization>(arg0, arg2);
        let v3 = agent_vertex_authorization_stamp(agent_vertex_authorization_context(v1, v2.skill_id, v2.interface_version, 0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::proof_of_uid::created_from(arg1), v2.vertex, v2.task_id), arg3);
        authorization_matches_worksheet(&v2, v1, arg1, &v3)
    }

    public fun copy_agent_skill_authorization_vertex_grant(arg0: &AgentSkillAuthorization, arg1: u64) : 0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::authorization::Grant<AgentVertexAuthorization> {
        *0x1::vector::borrow<0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::authorization::Grant<AgentVertexAuthorization>>(&load_v1(arg0).vertex_authorization_grants, arg1)
    }

    public fun destroy_agent_skill_authorization(arg0: AgentSkillAuthorization) {
        let AgentSkillAuthorization { id: v0 } = arg0;
        let AgentSkillAuthorizationInnerV1 {
            agent_id                    : _,
            skill_id                    : _,
            interface_version           : _,
            vertex_authorization_grants : _,
        } = 0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::object_state::destroy<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::era::V1, AgentSkillAuthorizationInnerV1>(v0);
    }

    public fun encode_agent_vertex_authorization_context(arg0: 0x2::object::ID, arg1: u64, arg2: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::version::InterfaceVersion, arg3: 0x2::object::ID, arg4: 0x1::ascii::String, arg5: 0x2::object::ID) : vector<u8> {
        let v0 = agent_vertex_authorization_context(arg0, arg1, arg2, arg3, arg4, arg5);
        0x1::bcs::to_bytes<AgentVertexAuthorizationContext>(&v0)
    }

    fun load_v1(arg0: &AgentSkillAuthorization) : &AgentSkillAuthorizationInnerV1 {
        0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::object_state::inner<AgentSkillAuthorizationInnerV1>(&arg0.id)
    }

    public(friend) fun new_agent_skill_authorization(arg0: &0x2::object::UID, arg1: 0x2::object::ID, arg2: u64, arg3: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::version::InterfaceVersion, arg4: vector<0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::authorization::Grant<AgentVertexAuthorization>>, arg5: &mut 0x2::tx_context::TxContext) : AgentSkillAuthorization {
        assert!(0x2::object::uid_to_inner(arg0) == arg1, 13906835213725466625);
        let v0 = &arg4;
        let v1 = 0;
        while (v1 < 0x1::vector::length<0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::authorization::Grant<AgentVertexAuthorization>>(v0)) {
            let v2 = 0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::authorization::grant_value<AgentVertexAuthorization>(0x1::vector::borrow<0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::authorization::Grant<AgentVertexAuthorization>>(v0, v1));
            assert!(v2.skill_id == arg2, 13906835226610368513);
            assert!(v2.interface_version == arg3, 13906835230905335809);
            v1 = v1 + 1;
        };
        let v3 = AgentSkillAuthorization{id: 0x2::object::new(arg5)};
        let v4 = AgentSkillAuthorizationInnerV1{
            agent_id                    : arg1,
            skill_id                    : arg2,
            interface_version           : arg3,
            vertex_authorization_grants : arg4,
        };
        0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::object_state::add<0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::era::V1, AgentSkillAuthorizationInnerV1>(&mut v3.id, 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::era::v1(), v4);
        v3
    }

    public(friend) fun new_agent_vertex_authorization(arg0: u64, arg1: 0x23333bd0bed47abb5e9fabfabd32a08fa6557bd89c5a6f61e2a44c1054f054ee::version::InterfaceVersion, arg2: 0x2::object::ID, arg3: 0x1::ascii::String, arg4: 0x2::object::ID) : AgentVertexAuthorization {
        AgentVertexAuthorization{
            skill_id          : arg0,
            interface_version : arg1,
            dag_id            : arg2,
            vertex            : arg3,
            task_id           : arg4,
        }
    }

    public fun worksheet_input_commitment(arg0: &0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::proof_of_uid::ProofOfUID, arg1: &AgentVertexAuthorizationStamp) : vector<u8> {
        let v0 = 0x1::bcs::to_bytes<AgentVertexAuthorizationStamp>(arg1);
        assert!(0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::proof_of_uid::has_stamp_with_data(arg0, 0xd44a0624c3e607933273e80140766f11aa35259ae64b4c47ee683afa044c1e6::proof_of_uid::created_from(arg0), &v0), 13906834895897886721);
        arg1.input_commitment
    }

    // decompiled from Move bytecode v7
}

