module 0xe177697e191327901637f8d2c5ffbbde8b1aaac27ec1024c4b62d1ebd1cd7430::subdomains {
    struct SubDomains has drop {
        dummy_field: bool,
    }

    struct ParentKey has copy, drop, store {
        dummy_field: bool,
    }

    public fun new(arg0: &mut 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS, arg1: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration, arg2: &0x2::clock::Clock, arg3: 0x1::string::String, arg4: u64, arg5: bool, arg6: bool, arg7: &mut 0x2::tx_context::TxContext) : 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::subdomain_registration::SubDomainRegistration {
        assert!(!0xc967b7862d926720761ee15fbd0254a975afa928712abcaa4f7c17bb2b38d38b::denylist::is_blocked_name(arg0, arg3), 6);
        let v0 = 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::domain::new(arg3);
        internal_validate_nft_can_manage_subdomain(arg0, arg1, arg2, v0, true);
        assert!(arg4 >= 0x2::clock::timestamp_ms(arg2) + 0xe177697e191327901637f8d2c5ffbbde8b1aaac27ec1024c4b62d1ebd1cd7430::config::minimum_duration(app_config(arg0)), 1);
        assert!(arg4 <= 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::expiration_timestamp_ms(arg1), 1);
        let v1 = registry_mut(arg0);
        if (arg5) {
            internal_set_flag(arg0, v0, 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::constants::subdomain_allow_creation_key(), arg5);
        };
        if (arg6) {
            internal_set_flag(arg0, v0, 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::constants::subdomain_allow_extension_key(), arg6);
        };
        internal_create_subdomain(v1, v0, arg4, 0x2::object::id<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration>(arg1), arg2, arg7)
    }

    public fun parent(arg0: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration) : 0x2::object::ID {
        let v0 = ParentKey{dummy_field: false};
        *0x2::dynamic_field::borrow<ParentKey, 0x2::object::ID>(0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::uid(arg0), v0)
    }

    fun registry(arg0: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS) : &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::registry::Registry {
        0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::registry<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::registry::Registry>(arg0)
    }

    fun app_config(arg0: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS) : &0xe177697e191327901637f8d2c5ffbbde8b1aaac27ec1024c4b62d1ebd1cd7430::config::SubDomainConfig {
        0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::get_config<0xe177697e191327901637f8d2c5ffbbde8b1aaac27ec1024c4b62d1ebd1cd7430::config::SubDomainConfig>(arg0)
    }

    public fun burn(arg0: &mut 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS, arg1: 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::subdomain_registration::SubDomainRegistration, arg2: &0x2::clock::Clock) {
        0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::registry::burn_subdomain_object(registry_mut(arg0), arg1, arg2);
    }

    public fun edit_setup(arg0: &mut 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS, arg1: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration, arg2: &0x2::clock::Clock, arg3: 0x1::string::String, arg4: bool, arg5: bool) {
        0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::registry::assert_nft_is_authorized(registry(arg0), arg1, arg2);
        let v0 = 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::domain(arg1);
        let v1 = 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::domain::new(arg3);
        0xe177697e191327901637f8d2c5ffbbde8b1aaac27ec1024c4b62d1ebd1cd7430::config::assert_is_valid_subdomain(&v0, &v1, app_config(arg0));
        internal_set_flag(arg0, v1, 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::constants::subdomain_allow_creation_key(), arg4);
        internal_set_flag(arg0, v1, 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::constants::subdomain_allow_extension_key(), arg5);
    }

    public fun extend_expiration(arg0: &mut 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS, arg1: &mut 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::subdomain_registration::SubDomainRegistration, arg2: u64) {
        let v0 = registry(arg0);
        let v1 = 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::subdomain_registration::nft_mut(arg1);
        let v2 = 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::domain(v1);
        let v3 = record_metadata(arg0, v2);
        assert!(is_extension_allowed(&v3), 3);
        let v4 = 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::registry::lookup(v0, v2);
        let v5 = 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::registry::lookup(v0, 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::domain::parent(&v2));
        assert!(0x1::option::is_some<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::name_record::NameRecord>(&v4) && 0x1::option::is_some<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::name_record::NameRecord>(&v5), 4);
        assert!(parent(v1) == 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::name_record::nft_id(0x1::option::borrow<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::name_record::NameRecord>(&v5)), 5);
        assert!(arg2 > 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::expiration_timestamp_ms(v1), 1);
        assert!(arg2 <= 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::name_record::expiration_timestamp_ms(0x1::option::borrow<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::name_record::NameRecord>(&v5)), 1);
        0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::registry::set_expiration_timestamp_ms(registry_mut(arg0), v1, v2, arg2);
    }

    fun internal_assert_parent_can_create_subdomains(arg0: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS, arg1: 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::domain::Domain) {
        if (!0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::domain::is_subdomain(&arg1)) {
            return
        };
        let v0 = record_metadata(arg0, arg1);
        assert!(is_creation_allowed(&v0), 2);
    }

    fun internal_create_subdomain(arg0: &mut 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::registry::Registry, arg1: 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::domain::Domain, arg2: u64, arg3: 0x2::object::ID, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::subdomain_registration::SubDomainRegistration {
        let v0 = 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::registry::add_record_ignoring_grace_period(arg0, arg1, 1, arg4, arg5);
        0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::registry::set_expiration_timestamp_ms(arg0, &mut v0, arg1, arg2);
        let v1 = ParentKey{dummy_field: false};
        0x2::dynamic_field::add<ParentKey, 0x2::object::ID>(0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::uid_mut(&mut v0), v1, arg3);
        0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::registry::wrap_subdomain(arg0, v0, arg4, arg5)
    }

    fun internal_set_flag(arg0: &mut 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS, arg1: 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::domain::Domain, arg2: 0x1::string::String, arg3: bool) {
        let v0 = record_metadata(arg0, arg1);
        let v1 = 0x2::vec_map::contains<0x1::string::String, 0x1::string::String>(&v0, &arg2);
        if (arg3 && !v1) {
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, arg2, 0x1::string::utf8(b"1"));
        };
        if (!arg3 && v1) {
            let (_, _) = 0x2::vec_map::remove<0x1::string::String, 0x1::string::String>(&mut v0, &arg2);
        };
        0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::registry::set_data(registry_mut(arg0), arg1, v0);
    }

    fun internal_validate_nft_can_manage_subdomain(arg0: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS, arg1: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration, arg2: &0x2::clock::Clock, arg3: 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::domain::Domain, arg4: bool) {
        0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::registry::assert_nft_is_authorized(registry(arg0), arg1, arg2);
        if (arg4) {
            internal_assert_parent_can_create_subdomains(arg0, 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::domain(arg1));
        };
        let v0 = 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::domain(arg1);
        0xe177697e191327901637f8d2c5ffbbde8b1aaac27ec1024c4b62d1ebd1cd7430::config::assert_is_valid_subdomain(&v0, &arg3, app_config(arg0));
    }

    fun is_creation_allowed(arg0: &0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>) : bool {
        let v0 = 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::constants::subdomain_allow_creation_key();
        0x2::vec_map::contains<0x1::string::String, 0x1::string::String>(arg0, &v0)
    }

    fun is_extension_allowed(arg0: &0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>) : bool {
        let v0 = 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::constants::subdomain_allow_extension_key();
        0x2::vec_map::contains<0x1::string::String, 0x1::string::String>(arg0, &v0)
    }

    public fun new_leaf(arg0: &mut 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS, arg1: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration, arg2: &0x2::clock::Clock, arg3: 0x1::string::String, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!0xc967b7862d926720761ee15fbd0254a975afa928712abcaa4f7c17bb2b38d38b::denylist::is_blocked_name(arg0, arg3), 6);
        let v0 = 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::domain::new(arg3);
        internal_validate_nft_can_manage_subdomain(arg0, arg1, arg2, v0, true);
        0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::registry::add_leaf_record(registry_mut(arg0), v0, arg2, arg4, arg5);
    }

    fun record_metadata(arg0: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS, arg1: 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::domain::Domain) : 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String> {
        *0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::registry::get_data(registry(arg0), arg1)
    }

    fun registry_mut(arg0: &mut 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS) : &mut 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::registry::Registry {
        let v0 = SubDomains{dummy_field: false};
        0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::app_registry_mut<SubDomains, 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::registry::Registry>(v0, arg0)
    }

    public fun remove_leaf(arg0: &mut 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS, arg1: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration, arg2: &0x2::clock::Clock, arg3: 0x1::string::String) {
        let v0 = 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::domain::new(arg3);
        internal_validate_nft_can_manage_subdomain(arg0, arg1, arg2, v0, false);
        0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::registry::remove_leaf_record(registry_mut(arg0), v0);
    }

    // decompiled from Move bytecode v6
}

