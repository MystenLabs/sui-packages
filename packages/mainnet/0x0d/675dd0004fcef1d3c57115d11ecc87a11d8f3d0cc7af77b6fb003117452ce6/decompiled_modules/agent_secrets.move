module 0xd675dd0004fcef1d3c57115d11ecc87a11d8f3d0cc7af77b6fb003117452ce6::agent_secrets {
    struct SecretStore has key {
        id: 0x2::object::UID,
        owner: address,
        encrypted_blobs: vector<vector<u8>>,
    }

    struct SecretPolicy has store, key {
        id: 0x2::object::UID,
        owner: address,
        required_approvals: u64,
        current_approvals: u64,
        unlock_time_ms: u64,
        approvers: vector<address>,
    }

    public fun add_encrypted_blob(arg0: &mut SecretStore, arg1: vector<u8>, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 0);
        0x1::vector::push_back<vector<u8>>(&mut arg0.encrypted_blobs, arg1);
    }

    public fun approve_policy(arg0: &mut SecretPolicy, arg1: &0xd675dd0004fcef1d3c57115d11ecc87a11d8f3d0cc7af77b6fb003117452ce6::types::AgentCap) {
        let v0 = 0xd675dd0004fcef1d3c57115d11ecc87a11d8f3d0cc7af77b6fb003117452ce6::types::agent_cap_owner(arg1);
        if (!0x1::vector::contains<address>(&arg0.approvers, &v0)) {
            0x1::vector::push_back<address>(&mut arg0.approvers, v0);
            arg0.current_approvals = arg0.current_approvals + 1;
        };
    }

    public fun create_policy(arg0: u64, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = SecretPolicy{
            id                 : 0x2::object::new(arg2),
            owner              : 0x2::tx_context::sender(arg2),
            required_approvals : arg0,
            current_approvals  : 0,
            unlock_time_ms     : arg1,
            approvers          : vector[],
        };
        0x2::transfer::public_share_object<SecretPolicy>(v0);
    }

    public fun create_secret_store(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = SecretStore{
            id              : 0x2::object::new(arg0),
            owner           : 0x2::tx_context::sender(arg0),
            encrypted_blobs : vector[],
        };
        0x2::transfer::transfer<SecretStore>(v0, 0x2::tx_context::sender(arg0));
    }

    entry fun seal_approve(arg0: vector<u8>, arg1: &0xd675dd0004fcef1d3c57115d11ecc87a11d8f3d0cc7af77b6fb003117452ce6::types::AgentCap, arg2: &SecretPolicy, arg3: &0x2::clock::Clock) {
        assert!(0xd675dd0004fcef1d3c57115d11ecc87a11d8f3d0cc7af77b6fb003117452ce6::types::agent_cap_owner(arg1) == arg2.owner, 0);
        assert!(arg2.current_approvals >= arg2.required_approvals, 0);
        assert!(0x2::clock::timestamp_ms(arg3) >= arg2.unlock_time_ms, 0);
    }

    entry fun seal_approve_owner(arg0: vector<u8>, arg1: &0xd675dd0004fcef1d3c57115d11ecc87a11d8f3d0cc7af77b6fb003117452ce6::types::AgentCap) {
    }

    // decompiled from Move bytecode v7
}

