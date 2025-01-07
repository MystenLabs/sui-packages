module 0xf7854c81cf500d60a4437f4599f7ff3b89abd13f645ae08f62345c7a25317bee::direct_setup {
    struct DirectSetup has drop {
        dummy_field: bool,
    }

    public fun set_reverse_lookup(arg0: &mut 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS, arg1: 0x1::string::String, arg2: &0x2::tx_context::TxContext) {
        0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::registry::set_reverse_lookup(registry_mut(arg0), 0x2::tx_context::sender(arg2), 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::domain::new(arg1));
    }

    public fun set_target_address(arg0: &mut 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS, arg1: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration, arg2: 0x1::option::Option<address>, arg3: &0x2::clock::Clock) {
        let v0 = registry_mut(arg0);
        0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::registry::assert_nft_is_authorized(v0, arg1, arg3);
        0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::registry::set_target_address(v0, 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::domain(arg1), arg2);
    }

    public fun unset_reverse_lookup(arg0: &mut 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS, arg1: &0x2::tx_context::TxContext) {
        0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::registry::unset_reverse_lookup(registry_mut(arg0), 0x2::tx_context::sender(arg1));
    }

    public fun burn_expired(arg0: &mut 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS, arg1: 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration, arg2: &0x2::clock::Clock) {
        0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::registry::burn_registration_object(registry_mut(arg0), arg1, arg2);
    }

    public fun burn_expired_subname(arg0: &mut 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS, arg1: 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::subdomain_registration::SubDomainRegistration, arg2: &0x2::clock::Clock) {
        0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::registry::burn_subdomain_object(registry_mut(arg0), arg1, arg2);
    }

    fun registry_mut(arg0: &mut 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS) : &mut 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::registry::Registry {
        let v0 = DirectSetup{dummy_field: false};
        0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::app_registry_mut<DirectSetup, 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::registry::Registry>(v0, arg0)
    }

    public fun set_user_data(arg0: &mut 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS, arg1: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &0x2::clock::Clock) {
        let v0 = registry_mut(arg0);
        let v1 = *0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::registry::get_data(v0, 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::domain(arg1));
        0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::registry::assert_nft_is_authorized(v0, arg1, arg4);
        let v2 = *0x1::string::bytes(&arg2);
        assert!(v2 == b"avatar" || v2 == b"content_hash", 1);
        if (0x2::vec_map::contains<0x1::string::String, 0x1::string::String>(&v1, &arg2)) {
            let (_, _) = 0x2::vec_map::remove<0x1::string::String, 0x1::string::String>(&mut v1, &arg2);
        };
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v1, arg2, arg3);
        0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::registry::set_data(v0, 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::domain(arg1), v1);
    }

    public fun unset_user_data(arg0: &mut 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS, arg1: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration, arg2: 0x1::string::String, arg3: &0x2::clock::Clock) {
        let v0 = registry_mut(arg0);
        let v1 = *0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::registry::get_data(v0, 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::domain(arg1));
        0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::registry::assert_nft_is_authorized(v0, arg1, arg3);
        if (0x2::vec_map::contains<0x1::string::String, 0x1::string::String>(&v1, &arg2)) {
            let (_, _) = 0x2::vec_map::remove<0x1::string::String, 0x1::string::String>(&mut v1, &arg2);
        };
        0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::registry::set_data(v0, 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::domain(arg1), v1);
    }

    // decompiled from Move bytecode v6
}

