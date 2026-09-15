module 0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::ownership {
    struct ExecutionOwnership has key {
        id: 0x2::object::UID,
        profile_version: u16,
        execution_id: vector<u8>,
        tunnel_id: 0x2::object::ID,
        policy_digest: vector<u8>,
        controller_public_key: vector<u8>,
        attestation_policy_digest: vector<u8>,
        ownership_epoch: u64,
        runtime_public_key: vector<u8>,
    }

    struct ExecutionOwnershipCreated has copy, drop {
        ownership_id: 0x2::object::ID,
        tunnel_id: 0x2::object::ID,
        execution_id: vector<u8>,
        ownership_epoch: u64,
    }

    struct OwnershipAdvanced has copy, drop {
        ownership_id: 0x2::object::ID,
        previous_epoch: u64,
        ownership_epoch: u64,
        runtime_public_key: vector<u8>,
    }

    public fun advance_ownership(arg0: &mut ExecutionOwnership, arg1: u64, arg2: u64, arg3: vector<u8>, arg4: vector<u8>, arg5: u64, arg6: vector<u8>, arg7: vector<u8>) {
        assert!(arg0.ownership_epoch == arg1, 13906834539415797764);
        assert!(arg2 > arg1, 13906834543710896134);
        assert!(0x1::vector::length<u8>(&arg3) == 32, 13906834548006387726);
        assert!(0x1::vector::length<u8>(&arg6) == 64, 13906834552300961800);
        assert!(0x1::vector::length<u8>(&arg7) == 64, 13906834556596060170);
        let v0 = arg0.execution_id;
        0x1::vector::append<u8>(&mut v0, arg4);
        0x1::vector::append<u8>(&mut v0, arg3);
        0x1::vector::append<u8>(&mut v0, 0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::signature::u64_to_be_bytes(arg2));
        0x1::vector::append<u8>(&mut v0, 0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::signature::u64_to_be_bytes(arg5));
        assert!(0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::signature::verify(0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::signature::ed25519(), &arg0.controller_public_key, &v0, &arg6), 13906834582365732872);
        assert!(0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::signature::verify(0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::signature::ed25519(), &arg3, &v0, &arg7), 13906834586660831242);
        arg0.ownership_epoch = arg2;
        arg0.runtime_public_key = arg3;
        let v1 = OwnershipAdvanced{
            ownership_id       : 0x2::object::id<ExecutionOwnership>(arg0),
            previous_epoch     : arg0.ownership_epoch,
            ownership_epoch    : arg2,
            runtime_public_key : arg0.runtime_public_key,
        };
        0x2::event::emit<OwnershipAdvanced>(v1);
    }

    public fun create(arg0: vector<u8>, arg1: 0x2::object::ID, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: &mut 0x2::tx_context::TxContext) : ExecutionOwnership {
        assert!(0x1::vector::length<u8>(&arg0) == 32, 13906834440632205326);
        assert!(0x1::vector::length<u8>(&arg2) == 32, 13906834444927172622);
        assert!(0x1::vector::length<u8>(&arg3) == 32, 13906834449222139918);
        assert!(0x1::vector::length<u8>(&arg4) == 32, 13906834453517107214);
        assert!(0x1::vector::length<u8>(&arg5) == 32, 13906834457812074510);
        let v0 = ExecutionOwnership{
            id                        : 0x2::object::new(arg6),
            profile_version           : 1,
            execution_id              : arg0,
            tunnel_id                 : arg1,
            policy_digest             : arg2,
            controller_public_key     : arg3,
            attestation_policy_digest : arg4,
            ownership_epoch           : 1,
            runtime_public_key        : arg5,
        };
        let v1 = ExecutionOwnershipCreated{
            ownership_id    : 0x2::object::id<ExecutionOwnership>(&v0),
            tunnel_id       : arg1,
            execution_id    : v0.execution_id,
            ownership_epoch : 1,
        };
        0x2::event::emit<ExecutionOwnershipCreated>(v1);
        v0
    }

    public fun ownership_epoch(arg0: &ExecutionOwnership) : u64 {
        arg0.ownership_epoch
    }

    public fun ownership_id(arg0: &ExecutionOwnership) : 0x2::object::ID {
        0x2::object::id<ExecutionOwnership>(arg0)
    }

    public fun profile_version(arg0: &ExecutionOwnership) : u16 {
        arg0.profile_version
    }

    public fun runtime_public_key(arg0: &ExecutionOwnership) : vector<u8> {
        arg0.runtime_public_key
    }

    public fun verify_runtime_endorsement(arg0: &ExecutionOwnership, arg1: 0x2::object::ID, arg2: vector<u8>, arg3: u64, arg4: u8, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>) {
        assert!(arg0.tunnel_id == arg1, 13906834663970504718);
        assert!(arg0.ownership_epoch == arg3, 13906834668264816644);
        assert!(0x1::vector::length<u8>(&arg2) == 32, 13906834672560570384);
        assert!(0x1::vector::length<u8>(&arg5) == 32, 13906834676855275532);
        assert!(0x1::vector::length<u8>(&arg6) == 32, 13906834681150242828);
        assert!(0x1::vector::length<u8>(&arg7) == 64, 13906834685445210124);
        0x1::vector::append<u8>(&mut arg2, arg0.execution_id);
        0x1::vector::append<u8>(&mut arg2, 0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::signature::u64_to_be_bytes(arg3));
        0x1::vector::push_back<u8>(&mut arg2, arg4);
        0x1::vector::append<u8>(&mut arg2, arg5);
        0x1::vector::append<u8>(&mut arg2, arg6);
        assert!(0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::signature::verify(0xf151da12b5fc5891089364f86a03f1b06a81b319843c6e320883bf28654b7cb::signature::ed25519(), &arg0.runtime_public_key, &arg2, &arg7), 13906834715509981196);
    }

    // decompiled from Move bytecode v7
}

