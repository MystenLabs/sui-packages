module 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::subdomain_registration {
    struct SubDomainRegistration has store, key {
        id: 0x2::object::UID,
        nft: 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration,
    }

    public(friend) fun new(arg0: 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : SubDomainRegistration {
        let v0 = 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::domain(&arg0);
        assert!(0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::domain::is_subdomain(&v0), 2);
        assert!(!0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::has_expired(&arg0, arg1), 1);
        SubDomainRegistration{
            id  : 0x2::object::new(arg2),
            nft : arg0,
        }
    }

    public(friend) fun burn(arg0: SubDomainRegistration, arg1: &0x2::clock::Clock) : 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration {
        assert!(0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::has_expired(&arg0.nft, arg1), 3);
        let SubDomainRegistration {
            id  : v0,
            nft : v1,
        } = arg0;
        0x2::object::delete(v0);
        v1
    }

    public fun nft(arg0: &SubDomainRegistration) : &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration {
        &arg0.nft
    }

    public fun nft_mut(arg0: &mut SubDomainRegistration) : &mut 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration {
        &mut arg0.nft
    }

    // decompiled from Move bytecode v6
}

