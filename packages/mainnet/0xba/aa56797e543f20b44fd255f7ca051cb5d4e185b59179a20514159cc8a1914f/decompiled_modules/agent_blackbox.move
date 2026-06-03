module 0xbaaa56797e543f20b44fd255f7ca051cb5d4e185b59179a20514159cc8a1914f::agent_blackbox {
    struct AgentSessionProof has store, key {
        id: 0x2::object::UID,
        session_id: 0x1::string::String,
        agent_mode: 0x1::string::String,
        input_hash: 0x1::string::String,
        result_hash: 0x1::string::String,
        trace_hash: 0x1::string::String,
        walrus_blob_id: 0x1::string::String,
        walrus_object_id: 0x1::string::String,
        upload_job_id: 0x1::string::String,
        upload_adapter: 0x1::string::String,
        storage_provider: 0x1::string::String,
        storage_network: 0x1::string::String,
        owner: address,
        created_at_ms: u64,
        status: 0x1::string::String,
    }

    struct AgentSessionProofCreated has copy, drop {
        proof_id: 0x2::object::ID,
        session_id: 0x1::string::String,
        owner: address,
        trace_hash: 0x1::string::String,
        result_hash: 0x1::string::String,
        input_hash: 0x1::string::String,
        walrus_blob_id: 0x1::string::String,
        storage_network: 0x1::string::String,
        created_at_ms: u64,
    }

    public entry fun create_session_proof(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: 0x1::string::String, arg11: u64, arg12: 0x1::string::String, arg13: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg13);
        let v1 = AgentSessionProof{
            id               : 0x2::object::new(arg13),
            session_id       : arg0,
            agent_mode       : arg1,
            input_hash       : arg2,
            result_hash      : arg3,
            trace_hash       : arg4,
            walrus_blob_id   : arg5,
            walrus_object_id : arg6,
            upload_job_id    : arg7,
            upload_adapter   : arg8,
            storage_provider : arg9,
            storage_network  : arg10,
            owner            : v0,
            created_at_ms    : arg11,
            status           : arg12,
        };
        let v2 = AgentSessionProofCreated{
            proof_id        : 0x2::object::id<AgentSessionProof>(&v1),
            session_id      : arg0,
            owner           : v0,
            trace_hash      : arg4,
            result_hash     : arg3,
            input_hash      : arg2,
            walrus_blob_id  : arg5,
            storage_network : arg10,
            created_at_ms   : arg11,
        };
        0x2::event::emit<AgentSessionProofCreated>(v2);
        0x2::transfer::public_transfer<AgentSessionProof>(v1, v0);
    }

    // decompiled from Move bytecode v7
}

