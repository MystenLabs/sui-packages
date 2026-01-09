module 0x22f174163427b4cd62e956a2536f707b89a7e919e6241cc02fbb027969c2e2a3::suins_domains_manager {
    struct SuiNSDomains has key {
        id: 0x2::object::UID,
        version: u8,
        managed_domains: 0x2::bag::Bag,
        authorized: 0x2::vec_set::VecSet<address>,
        subdomains: 0x2::bag::Bag,
        attach_domain_fee_type: 0x1::type_name::TypeName,
        attach_domain_fee: u64,
        claim_subdomain_fee_percentage: u8,
        fees_recipient: address,
    }

    struct SuiNSDomainsCap has store, key {
        id: 0x2::object::UID,
    }

    struct SuiNSManagedKey has copy, drop, store {
        id: 0x2::object::ID,
    }

    struct SuiNSManagedValue has store {
        owner: address,
        storage: 0x2::object::UID,
    }

    struct SuiNSDomainKey has copy, drop, store {
        dummy_field: bool,
    }

    struct ReturnPromise {
        id: 0x2::object::ID,
    }

    struct FeeRequirementsMet {
        community_id: 0x2::object::ID,
    }

    public fun attach_domain<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS, arg2: &mut SuiNSDomains, arg3: 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration, arg4: &mut 0x22f174163427b4cd62e956a2536f707b89a7e919e6241cc02fbb027969c2e2a3::suins_communities::Community, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        validate_version(arg2);
        if (!0x22f174163427b4cd62e956a2536f707b89a7e919e6241cc02fbb027969c2e2a3::suins_communities::faucet_fee_paid(arg4)) {
            assert!(0x1::type_name::with_defining_ids<T0>() == arg2.attach_domain_fee_type, 7);
            assert!(0x2::coin::value<T0>(&arg0) == arg2.attach_domain_fee, 8);
            0x22f174163427b4cd62e956a2536f707b89a7e919e6241cc02fbb027969c2e2a3::suins_communities::set_faucet_fee_paid(arg4, true);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg2.fees_recipient);
        } else {
            assert!(0x2::coin::value<T0>(&arg0) == 0, 8);
            0x2::balance::destroy_zero<T0>(0x2::coin::into_balance<T0>(arg0));
        };
        assert!(0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::domain_name(&arg3) == 0x22f174163427b4cd62e956a2536f707b89a7e919e6241cc02fbb027969c2e2a3::suins_communities::name(arg4), 6);
        0x22f174163427b4cd62e956a2536f707b89a7e919e6241cc02fbb027969c2e2a3::suins_communities::validate_name_ownership_and_status(arg1, 0x22f174163427b4cd62e956a2536f707b89a7e919e6241cc02fbb027969c2e2a3::suins_communities::name(arg4), arg5, arg6);
        0x22f174163427b4cd62e956a2536f707b89a7e919e6241cc02fbb027969c2e2a3::suins_communities::set_linked_domain_id(arg4, 0x1::option::some<0x2::object::ID>(0x2::object::id<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration>(&arg3)));
        0x22f174163427b4cd62e956a2536f707b89a7e919e6241cc02fbb027969c2e2a3::suins_communities::set_faucet_enabled(arg4, true);
        let v0 = SuiNSManagedKey{id: 0x2::object::id<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration>(&arg3)};
        let v1 = SuiNSManagedValue{
            owner   : 0x2::tx_context::sender(arg6),
            storage : 0x2::object::new(arg6),
        };
        let v2 = SuiNSDomainKey{dummy_field: false};
        0x2::dynamic_object_field::add<SuiNSDomainKey, 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration>(&mut v1.storage, v2, arg3);
        0x2::bag::add<SuiNSManagedKey, SuiNSManagedValue>(&mut arg2.managed_domains, v0, v1);
    }

    public fun attach_domain_fee(arg0: &SuiNSDomains) : u64 {
        validate_version(arg0);
        arg0.attach_domain_fee
    }

    public fun attach_domain_fee_type(arg0: &SuiNSDomains) : 0x1::type_name::TypeName {
        validate_version(arg0);
        arg0.attach_domain_fee_type
    }

    public fun authorize(arg0: &mut SuiNSDomains, arg1: &SuiNSDomainsCap, arg2: address) {
        validate_version(arg0);
        assert!(!is_authorized(arg0, arg2), 0);
        0x2::vec_set::insert<address>(&mut arg0.authorized, arg2);
    }

    public fun borrow_domain(arg0: &mut SuiNSDomains, arg1: 0x2::object::ID, arg2: &0x2::tx_context::TxContext) : (0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration, ReturnPromise) {
        validate_version(arg0);
        let v0 = is_authorized(arg0, 0x2::tx_context::sender(arg2));
        let (v1, v2, v3) = borrow_domain_unsafe(arg0, arg1, arg2);
        assert!(v0 || v1.owner == 0x2::tx_context::sender(arg2), 4);
        (v2, v3)
    }

    fun borrow_domain_unsafe(arg0: &mut SuiNSDomains, arg1: 0x2::object::ID, arg2: &0x2::tx_context::TxContext) : (&mut SuiNSManagedValue, 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration, ReturnPromise) {
        let v0 = get_value_unsafe(arg0, arg1);
        let v1 = SuiNSDomainKey{dummy_field: false};
        let v2 = ReturnPromise{id: arg1};
        (v0, 0x2::dynamic_object_field::remove<SuiNSDomainKey, 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration>(&mut v0.storage, v1), v2)
    }

    public fun claim_subdomain(arg0: &0x22f174163427b4cd62e956a2536f707b89a7e919e6241cc02fbb027969c2e2a3::suins_communities::Community, arg1: &mut 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS, arg2: &mut SuiNSDomains, arg3: 0x2::object::ID, arg4: 0x1::string::String, arg5: address, arg6: &0x2::clock::Clock, arg7: 0x1::option::Option<FeeRequirementsMet>, arg8: &mut 0x2::tx_context::TxContext) {
        validate_version(arg2);
        assert!(0x22f174163427b4cd62e956a2536f707b89a7e919e6241cc02fbb027969c2e2a3::suins_communities::linked_domain_id(arg0) == 0x1::option::some<0x2::object::ID>(arg3), 16);
        validate_faucet_requirements(arg2, arg0, arg5, arg7, arg8);
        validate_subdomain_recipient(arg2, 0x22f174163427b4cd62e956a2536f707b89a7e919e6241cc02fbb027969c2e2a3::suins_communities::name(arg0), arg5);
        let (_, v1, v2) = borrow_domain_unsafe(arg2, arg3, arg8);
        let v3 = v1;
        0xe177697e191327901637f8d2c5ffbbde8b1aaac27ec1024c4b62d1ebd1cd7430::subdomains::new_leaf(arg1, &v3, arg6, arg4, arg5, arg8);
        return_domain(arg2, v3, v2, arg8);
        register_subdomain_recipient(arg2, 0x22f174163427b4cd62e956a2536f707b89a7e919e6241cc02fbb027969c2e2a3::suins_communities::name(arg0), arg4, arg5);
    }

    public fun claim_subdomain_fee_percentage(arg0: &SuiNSDomains) : u8 {
        validate_version(arg0);
        arg0.claim_subdomain_fee_percentage
    }

    public fun deauthorize(arg0: &mut SuiNSDomains, arg1: &SuiNSDomainsCap, arg2: address) {
        validate_version(arg0);
        assert!(is_authorized(arg0, arg2), 1);
        0x2::vec_set::remove<address>(&mut arg0.authorized, &arg2);
    }

    public fun deauthorize_self(arg0: &mut SuiNSDomains, arg1: &0x2::tx_context::TxContext) {
        validate_version(arg0);
        assert!(is_authorized(arg0, 0x2::tx_context::sender(arg1)), 1);
        let v0 = 0x2::tx_context::sender(arg1);
        0x2::vec_set::remove<address>(&mut arg0.authorized, &v0);
    }

    public fun fees_recipient(arg0: &SuiNSDomains) : address {
        validate_version(arg0);
        arg0.fees_recipient
    }

    fun get_subdomain_key(arg0: address, arg1: 0x1::string::String) : 0x1::string::String {
        let v0 = 0x2::address::to_string(arg0);
        0x1::string::append(&mut v0, 0x1::string::utf8(b","));
        0x1::string::append(&mut v0, arg1);
        v0
    }

    fun get_value_unsafe(arg0: &mut SuiNSDomains, arg1: 0x2::object::ID) : &mut SuiNSManagedValue {
        let v0 = SuiNSManagedKey{id: arg1};
        assert!(0x2::bag::contains<SuiNSManagedKey>(&arg0.managed_domains, v0), 3);
        let v1 = SuiNSManagedKey{id: arg1};
        0x2::bag::borrow_mut<SuiNSManagedKey, SuiNSManagedValue>(&mut arg0.managed_domains, v1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = SuiNSDomains{
            id                             : 0x2::object::new(arg0),
            version                        : 4,
            managed_domains                : 0x2::bag::new(arg0),
            authorized                     : 0x2::vec_set::empty<address>(),
            subdomains                     : 0x2::bag::new(arg0),
            attach_domain_fee_type         : 0x1::type_name::with_defining_ids<0x2::sui::SUI>(),
            attach_domain_fee              : 0,
            claim_subdomain_fee_percentage : 10,
            fees_recipient                 : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::share_object<SuiNSDomains>(v0);
        let v1 = SuiNSDomainsCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<SuiNSDomainsCap>(v1, 0x2::tx_context::sender(arg0));
    }

    fun is_authorized(arg0: &SuiNSDomains, arg1: address) : bool {
        0x2::vec_set::contains<address>(&arg0.authorized, &arg1)
    }

    entry fun migrate(arg0: &SuiNSDomainsCap, arg1: &mut SuiNSDomains) {
        assert!(arg1.version < 4, 15);
        arg1.version = 4;
    }

    public fun module_version() : u8 {
        4
    }

    public fun reclaim_domain(arg0: &mut SuiNSDomains, arg1: &mut 0x22f174163427b4cd62e956a2536f707b89a7e919e6241cc02fbb027969c2e2a3::suins_communities::Community, arg2: 0x2::object::ID, arg3: &0x2::tx_context::TxContext) : 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration {
        validate_version(arg0);
        let v0 = SuiNSManagedKey{id: arg2};
        assert!(0x2::bag::contains<SuiNSManagedKey>(&arg0.managed_domains, v0), 3);
        assert!(0x22f174163427b4cd62e956a2536f707b89a7e919e6241cc02fbb027969c2e2a3::suins_communities::linked_domain_id(arg1) == 0x1::option::some<0x2::object::ID>(arg2), 16);
        let v1 = SuiNSManagedKey{id: arg2};
        let SuiNSManagedValue {
            owner   : v2,
            storage : v3,
        } = 0x2::bag::remove<SuiNSManagedKey, SuiNSManagedValue>(&mut arg0.managed_domains, v1);
        let v4 = v3;
        assert!(v2 == 0x2::tx_context::sender(arg3), 4);
        let v5 = SuiNSDomainKey{dummy_field: false};
        0x22f174163427b4cd62e956a2536f707b89a7e919e6241cc02fbb027969c2e2a3::suins_communities::set_faucet_enabled(arg1, false);
        0x22f174163427b4cd62e956a2536f707b89a7e919e6241cc02fbb027969c2e2a3::suins_communities::set_linked_domain_id(arg1, 0x1::option::none<0x2::object::ID>());
        0x2::object::delete(v4);
        0x2::dynamic_object_field::remove<SuiNSDomainKey, 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration>(&mut v4, v5)
    }

    fun register_subdomain_recipient(arg0: &mut SuiNSDomains, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: address) {
        0x2::bag::add<0x1::string::String, 0x1::string::String>(&mut arg0.subdomains, get_subdomain_key(arg3, arg1), arg2);
    }

    public fun return_domain(arg0: &mut SuiNSDomains, arg1: 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration, arg2: ReturnPromise, arg3: &0x2::tx_context::TxContext) {
        validate_version(arg0);
        let ReturnPromise { id: v0 } = arg2;
        assert!(0x2::object::id<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration>(&arg1) == v0, 5);
        let v1 = SuiNSManagedKey{id: v0};
        let v2 = SuiNSDomainKey{dummy_field: false};
        0x2::dynamic_object_field::add<SuiNSDomainKey, 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration>(&mut 0x2::bag::borrow_mut<SuiNSManagedKey, SuiNSManagedValue>(&mut arg0.managed_domains, v1).storage, v2, arg1);
    }

    public fun set_attach_domain_fee<T0>(arg0: &SuiNSDomainsCap, arg1: &mut SuiNSDomains, arg2: u64) {
        validate_version(arg1);
        arg1.attach_domain_fee = arg2;
        arg1.attach_domain_fee_type = 0x1::type_name::with_defining_ids<T0>();
    }

    public fun set_claim_subdomain_fee_percentage(arg0: &SuiNSDomainsCap, arg1: &mut SuiNSDomains, arg2: u8) {
        validate_version(arg1);
        assert!(arg2 < 100, 13);
        arg1.claim_subdomain_fee_percentage = arg2;
    }

    public fun set_fees_recipient(arg0: &SuiNSDomainsCap, arg1: &mut SuiNSDomains, arg2: address) {
        validate_version(arg1);
        arg1.fees_recipient = arg2;
    }

    public fun update_version(arg0: &mut SuiNSDomains, arg1: &SuiNSDomainsCap, arg2: u8) {
        validate_version(arg0);
        arg0.version = arg2;
    }

    fun validate_faucet_requirements(arg0: &SuiNSDomains, arg1: &0x22f174163427b4cd62e956a2536f707b89a7e919e6241cc02fbb027969c2e2a3::suins_communities::Community, arg2: address, arg3: 0x1::option::Option<FeeRequirementsMet>, arg4: &0x2::tx_context::TxContext) {
        let v0 = 0x22f174163427b4cd62e956a2536f707b89a7e919e6241cc02fbb027969c2e2a3::suins_communities::fee_requirements(arg1);
        let v1 = !0x2::vec_map::is_empty<0x1::type_name::TypeName, u64>(0x22f174163427b4cd62e956a2536f707b89a7e919e6241cc02fbb027969c2e2a3::suins_communities::who_requirements(arg1)) || 0x22f174163427b4cd62e956a2536f707b89a7e919e6241cc02fbb027969c2e2a3::suins_communities::wallet_age_requirement(arg1) > 0;
        if (!is_authorized(arg0, 0x2::tx_context::sender(arg4))) {
            assert!(arg2 == 0x2::tx_context::sender(arg4), 14);
            if (0x2::vec_map::is_empty<0x1::type_name::TypeName, u64>(v0)) {
                assert!(!v1, 9);
            } else {
                assert!(0x1::option::is_some<FeeRequirementsMet>(&arg3), 11);
                let v2 = 0x2::object::id<0x22f174163427b4cd62e956a2536f707b89a7e919e6241cc02fbb027969c2e2a3::suins_communities::Community>(arg1);
                assert!(&0x1::option::borrow<FeeRequirementsMet>(&arg3).community_id == &v2, 6);
            };
        };
        if (0x1::option::is_some<FeeRequirementsMet>(&arg3)) {
            let FeeRequirementsMet {  } = 0x1::option::destroy_some<FeeRequirementsMet>(arg3);
        } else {
            0x1::option::destroy_none<FeeRequirementsMet>(arg3);
        };
    }

    fun validate_subdomain_recipient(arg0: &SuiNSDomains, arg1: 0x1::string::String, arg2: address) {
        assert!(!0x2::bag::contains<0x1::string::String>(&arg0.subdomains, get_subdomain_key(arg2, arg1)), 12);
    }

    fun validate_version(arg0: &SuiNSDomains) {
        assert!(arg0.version == 4, 2);
    }

    public fun verify_fee_requirement<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &0x22f174163427b4cd62e956a2536f707b89a7e919e6241cc02fbb027969c2e2a3::suins_communities::Community, arg2: &mut 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS, arg3: &SuiNSDomains, arg4: &mut 0x2::tx_context::TxContext) : FeeRequirementsMet {
        validate_version(arg3);
        let v0 = 0x22f174163427b4cd62e956a2536f707b89a7e919e6241cc02fbb027969c2e2a3::suins_communities::fee_requirements(arg1);
        assert!(!0x2::vec_map::is_empty<0x1::type_name::TypeName, u64>(v0), 10);
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        let v2 = 0x2::coin::value<T0>(&arg0);
        assert!(&v2 == 0x2::vec_map::get<0x1::type_name::TypeName, u64>(v0, &v1), 11);
        let v3 = 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::registry::lookup(0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::registry<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::registry::Registry>(arg2), 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::domain::new(0x22f174163427b4cd62e956a2536f707b89a7e919e6241cc02fbb027969c2e2a3::suins_communities::name(arg1)));
        let v4 = 0x1::option::extract<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::name_record::NameRecord>(&mut v3);
        let v5 = 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::name_record::target_address(&v4);
        if (arg3.claim_subdomain_fee_percentage > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg0, 0x2::coin::value<T0>(&arg0) * (arg3.claim_subdomain_fee_percentage as u64) / 100, arg4), arg3.fees_recipient);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x1::option::extract<address>(&mut v5));
        FeeRequirementsMet{community_id: 0x2::object::id<0x22f174163427b4cd62e956a2536f707b89a7e919e6241cc02fbb027969c2e2a3::suins_communities::Community>(arg1)}
    }

    // decompiled from Move bytecode v6
}

