module 0xd5e5f74126e7934e35991643b0111c3361827fc0564c83fa810668837c6f0b0f::renew {
    struct Renew has drop {
        dummy_field: bool,
    }

    struct NameRenewed has copy, drop {
        domain: 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::domain::Domain,
        amount: u64,
    }

    struct RenewalConfig has drop, store {
        config: 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::config::Config,
    }

    public fun renew(arg0: &mut 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS, arg1: &mut 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration, arg2: u8, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &0x2::clock::Clock) {
        let v0 = 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::domain(arg1);
        0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::config::assert_valid_user_registerable_domain(&v0);
        validate_payment(arg0, &arg3, &v0, arg2);
        let v1 = Renew{dummy_field: false};
        let v2 = 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::app_registry_mut<Renew, 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::registry::Registry>(v1, arg0);
        0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::registry::set_expiration_timestamp_ms(v2, arg1, v0, target_expiration(v2, arg1, v0, arg4, arg2));
        let v3 = NameRenewed{
            domain : v0,
            amount : 0x2::coin::value<0x2::sui::SUI>(&arg3),
        };
        0x2::event::emit<NameRenewed>(v3);
        let v4 = Renew{dummy_field: false};
        0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::app_add_balance<Renew>(v4, arg0, 0x2::coin::into_balance<0x2::sui::SUI>(arg3));
    }

    public fun setup(arg0: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::AdminCap, arg1: &mut 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS, arg2: 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::config::Config) {
        let v0 = RenewalConfig{config: arg2};
        0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::add_config<RenewalConfig>(arg0, arg1, v0);
    }

    fun target_expiration(arg0: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::registry::Registry, arg1: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration, arg2: 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::domain::Domain, arg3: &0x2::clock::Clock, arg4: u8) : u64 {
        let v0 = 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::registry::lookup(arg0, arg2);
        assert!(0x1::option::is_some<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::name_record::NameRecord>(&v0), 3);
        let v1 = 0x1::option::destroy_some<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::name_record::NameRecord>(v0);
        assert!(!0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::name_record::has_expired_past_grace_period(&v1, arg3), 5);
        assert!(0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::name_record::nft_id(&v1) == 0x2::object::id<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration>(arg1), 4);
        assert!(0 < arg4 && arg4 <= 5, 0);
        let v2 = 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::name_record::expiration_timestamp_ms(&v1) + (arg4 as u64) * 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::constants::year_ms();
        assert!(v2 < 0x2::clock::timestamp_ms(arg3) + 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::constants::year_ms() * 6, 2);
        v2
    }

    fun validate_payment(arg0: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS, arg1: &0x2::coin::Coin<0x2::sui::SUI>, arg2: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::domain::Domain, arg3: u8) {
        assert!(0x2::coin::value<0x2::sui::SUI>(arg1) == 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::config::calculate_price(&0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::get_config<RenewalConfig>(arg0).config, (0x1::string::length(0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::domain::sld(arg2)) as u8), arg3), 1);
    }

    // decompiled from Move bytecode v6
}

