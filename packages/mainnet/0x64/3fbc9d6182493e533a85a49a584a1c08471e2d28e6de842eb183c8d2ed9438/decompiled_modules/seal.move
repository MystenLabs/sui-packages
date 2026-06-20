module 0x643fbc9d6182493e533a85a49a584a1c08471e2d28e6de842eb183c8d2ed9438::seal {
    struct SealRef has copy, drop, store {
        identity: vector<u8>,
        threshold: u8,
        policy_version: u64,
    }

    public fun current_policy_version() : u64 {
        1
    }

    public fun default_threshold() : u8 {
        2
    }

    public fun derive_identity(arg0: 0x2::object::ID, arg1: 0x1::string::String) : vector<u8> {
        let v0 = 0x643fbc9d6182493e533a85a49a584a1c08471e2d28e6de842eb183c8d2ed9438::util::id_bytes(arg0);
        0x1::vector::append<u8>(&mut v0, 0x1::string::into_bytes(arg1));
        v0
    }

    public fun identity(arg0: &SealRef) : vector<u8> {
        arg0.identity
    }

    public fun new_ref(arg0: vector<u8>, arg1: u8) : SealRef {
        assert!(arg1 >= 1, 1);
        SealRef{
            identity       : arg0,
            threshold      : arg1,
            policy_version : 1,
        }
    }

    public fun policy_version(arg0: &SealRef) : u64 {
        arg0.policy_version
    }

    public fun threshold(arg0: &SealRef) : u8 {
        arg0.threshold
    }

    // decompiled from Move bytecode v7
}

