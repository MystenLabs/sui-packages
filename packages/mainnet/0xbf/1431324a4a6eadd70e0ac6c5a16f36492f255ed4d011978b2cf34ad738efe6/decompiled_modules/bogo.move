module 0xbf1431324a4a6eadd70e0ac6c5a16f36492f255ed4d011978b2cf34ad738efe6::bogo {
    struct BogoApp has drop {
        dummy_field: bool,
    }

    struct UsedInDayOnePromo has copy, drop, store {
        dummy_field: bool,
    }

    public fun claim(arg0: &mut 0xbf1431324a4a6eadd70e0ac6c5a16f36492f255ed4d011978b2cf34ad738efe6::day_one::DayOne, arg1: &mut 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS, arg2: &mut 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration, arg3: 0x1::string::String, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration {
        0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::assert_app_is_authorized<BogoApp>(arg1);
        assert!(!used_in_promo(arg2), 0);
        assert!(0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::expiration_timestamp_ms(arg2) <= 1721499031000, 1);
        let v0 = 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::domain::new(arg3);
        let v1 = domain_length(&v0);
        let v2 = 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::domain(arg2);
        let v3 = domain_length(&v2);
        0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::config::assert_valid_user_registerable_domain(&v0);
        let v4 = (v3 < 5 || v1 < 5) && v3 != v1;
        assert!(!v4, 2);
        if (!0xbf1431324a4a6eadd70e0ac6c5a16f36492f255ed4d011978b2cf34ad738efe6::day_one::is_active(arg0)) {
            0xbf1431324a4a6eadd70e0ac6c5a16f36492f255ed4d011978b2cf34ad738efe6::day_one::activate(arg0);
        };
        let v5 = BogoApp{dummy_field: false};
        let v6 = 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::registry::add_record(0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::app_registry_mut<BogoApp, 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::registry::Registry>(v5, arg1), v0, 1, arg4, arg5);
        mark_domain_as_used(arg2);
        let v7 = &mut v6;
        mark_domain_as_used(v7);
        v6
    }

    fun domain_length(arg0: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::domain::Domain) : u64 {
        0x1::string::length(0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::domain::sld(arg0))
    }

    public fun last_valid_expiration() : u64 {
        1721499031000
    }

    fun mark_domain_as_used(arg0: &mut 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration) {
        let v0 = UsedInDayOnePromo{dummy_field: false};
        0x2::dynamic_field::add<UsedInDayOnePromo, bool>(0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::uid_mut(arg0), v0, true);
    }

    public fun used_in_promo(arg0: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration) : bool {
        let v0 = UsedInDayOnePromo{dummy_field: false};
        0x2::dynamic_field::exists_<UsedInDayOnePromo>(0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::uid(arg0), v0)
    }

    // decompiled from Move bytecode v6
}

