module 0x351469211bb89243d4124dba8b1ccbafc8ee968c064c6392730213f77235f6ad::arena_domain {
    struct DomainTagged has copy, drop {
        tunnel_id: 0x2::object::ID,
        domain: vector<u8>,
    }

    struct DomainBatchTagged has copy, drop {
        tunnel_ids: vector<0x2::object::ID>,
        domains: vector<vector<u8>>,
    }

    public fun tag<T0>(arg0: &0x351469211bb89243d4124dba8b1ccbafc8ee968c064c6392730213f77235f6ad::tunnel::Tunnel<T0>, arg1: vector<u8>) {
        let v0 = DomainTagged{
            tunnel_id : 0x2::object::id<0x351469211bb89243d4124dba8b1ccbafc8ee968c064c6392730213f77235f6ad::tunnel::Tunnel<T0>>(arg0),
            domain    : arg1,
        };
        0x2::event::emit<DomainTagged>(v0);
    }

    public fun tag_batch(arg0: vector<0x2::object::ID>, arg1: vector<vector<u8>>) {
        assert!(0x1::vector::length<0x2::object::ID>(&arg0) == 0x1::vector::length<vector<u8>>(&arg1), 0);
        let v0 = DomainBatchTagged{
            tunnel_ids : arg0,
            domains    : arg1,
        };
        0x2::event::emit<DomainBatchTagged>(v0);
    }

    public fun tag_id(arg0: 0x2::object::ID, arg1: vector<u8>) {
        let v0 = DomainTagged{
            tunnel_id : arg0,
            domain    : arg1,
        };
        0x2::event::emit<DomainTagged>(v0);
    }

    // decompiled from Move bytecode v7
}

