module 0x3f625d805339b1b0235ba8c503fa6ea62c88c02ddf14cd9d246d9e1febc0c76::free_claims {
    struct FreeClaimsApp has drop {
        dummy_field: bool,
    }

    struct FreeClaimsKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct FreeClaimsConfig has store {
        domain_length_range: 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::pricing_config::Range,
        used_objects: 0x2::linked_table::LinkedTable<0x2::object::ID, bool>,
    }

    fun assert_config_exists<T0>(arg0: &mut 0x3f625d805339b1b0235ba8c503fa6ea62c88c02ddf14cd9d246d9e1febc0c76::house::DiscountHouse) {
        let v0 = FreeClaimsKey<T0>{dummy_field: false};
        assert!(0x2::dynamic_field::exists_with_type<FreeClaimsKey<T0>, FreeClaimsConfig>(0x3f625d805339b1b0235ba8c503fa6ea62c88c02ddf14cd9d246d9e1febc0c76::house::uid_mut(arg0), v0), 2);
    }

    public fun authorize_type<T0: key>(arg0: &mut 0x3f625d805339b1b0235ba8c503fa6ea62c88c02ddf14cd9d246d9e1febc0c76::house::DiscountHouse, arg1: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::AdminCap, arg2: 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::pricing_config::Range, arg3: &mut 0x2::tx_context::TxContext) {
        0x3f625d805339b1b0235ba8c503fa6ea62c88c02ddf14cd9d246d9e1febc0c76::house::assert_version_is_valid(arg0);
        let v0 = FreeClaimsKey<T0>{dummy_field: false};
        assert!(!0x2::dynamic_field::exists_<FreeClaimsKey<T0>>(0x3f625d805339b1b0235ba8c503fa6ea62c88c02ddf14cd9d246d9e1febc0c76::house::uid_mut(arg0), v0), 1);
        let v1 = FreeClaimsKey<T0>{dummy_field: false};
        let v2 = FreeClaimsConfig{
            domain_length_range : arg2,
            used_objects        : 0x2::linked_table::new<0x2::object::ID, bool>(arg3),
        };
        0x2::dynamic_field::add<FreeClaimsKey<T0>, FreeClaimsConfig>(0x3f625d805339b1b0235ba8c503fa6ea62c88c02ddf14cd9d246d9e1febc0c76::house::uid_mut(arg0), v1, v2);
    }

    fun config_mut<T0>(arg0: &mut 0x3f625d805339b1b0235ba8c503fa6ea62c88c02ddf14cd9d246d9e1febc0c76::house::DiscountHouse) : &mut FreeClaimsConfig {
        let v0 = FreeClaimsKey<T0>{dummy_field: false};
        0x2::dynamic_field::borrow_mut<FreeClaimsKey<T0>, FreeClaimsConfig>(0x3f625d805339b1b0235ba8c503fa6ea62c88c02ddf14cd9d246d9e1febc0c76::house::uid_mut(arg0), v0)
    }

    public fun deauthorize_type<T0>(arg0: &mut 0x3f625d805339b1b0235ba8c503fa6ea62c88c02ddf14cd9d246d9e1febc0c76::house::DiscountHouse, arg1: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::AdminCap) : 0x2::linked_table::LinkedTable<0x2::object::ID, bool> {
        0x3f625d805339b1b0235ba8c503fa6ea62c88c02ddf14cd9d246d9e1febc0c76::house::assert_version_is_valid(arg0);
        assert_config_exists<T0>(arg0);
        let v0 = FreeClaimsKey<T0>{dummy_field: false};
        let FreeClaimsConfig {
            domain_length_range : _,
            used_objects        : v2,
        } = 0x2::dynamic_field::remove<FreeClaimsKey<T0>, FreeClaimsConfig>(0x3f625d805339b1b0235ba8c503fa6ea62c88c02ddf14cd9d246d9e1febc0c76::house::uid_mut(arg0), v0);
        v2
    }

    public fun free_claim<T0: key>(arg0: &mut 0x3f625d805339b1b0235ba8c503fa6ea62c88c02ddf14cd9d246d9e1febc0c76::house::DiscountHouse, arg1: &mut 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS, arg2: &mut 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::payment::PaymentIntent, arg3: &T0, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::type_name::get<T0>() != 0x1::type_name::get<0xbf1431324a4a6eadd70e0ac6c5a16f36492f255ed4d011978b2cf34ad738efe6::day_one::DayOne>(), 5);
        internal_apply_full_discount<T0>(arg0, arg1, arg2, 0x2::object::id<T0>(arg3), arg4);
    }

    public fun free_claim_with_day_one(arg0: &mut 0x3f625d805339b1b0235ba8c503fa6ea62c88c02ddf14cd9d246d9e1febc0c76::house::DiscountHouse, arg1: &mut 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS, arg2: &mut 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::payment::PaymentIntent, arg3: &0xbf1431324a4a6eadd70e0ac6c5a16f36492f255ed4d011978b2cf34ad738efe6::day_one::DayOne, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0xbf1431324a4a6eadd70e0ac6c5a16f36492f255ed4d011978b2cf34ad738efe6::day_one::is_active(arg3), 6);
        internal_apply_full_discount<0xbf1431324a4a6eadd70e0ac6c5a16f36492f255ed4d011978b2cf34ad738efe6::day_one::DayOne>(arg0, arg1, arg2, 0x2::object::id<0xbf1431324a4a6eadd70e0ac6c5a16f36492f255ed4d011978b2cf34ad738efe6::day_one::DayOne>(arg3), arg4);
    }

    fun internal_apply_full_discount<T0: key>(arg0: &mut 0x3f625d805339b1b0235ba8c503fa6ea62c88c02ddf14cd9d246d9e1febc0c76::house::DiscountHouse, arg1: &mut 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS, arg2: &mut 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::payment::PaymentIntent, arg3: 0x2::object::ID, arg4: &mut 0x2::tx_context::TxContext) {
        0x3f625d805339b1b0235ba8c503fa6ea62c88c02ddf14cd9d246d9e1febc0c76::house::assert_version_is_valid(arg0);
        assert_config_exists<T0>(arg0);
        let v0 = config_mut<T0>(arg0);
        assert!(!0x2::linked_table::contains<0x2::object::ID, bool>(&v0.used_objects, arg3), 4);
        0x2::linked_table::push_back<0x2::object::ID, bool>(&mut v0.used_objects, arg3, true);
        assert!(0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::pricing_config::is_between_inclusive(&v0.domain_length_range, 0x1::string::length(0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::domain::sld(0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::payment::domain(0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::payment::request_data(arg2))))), 3);
        assert!(0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::payment::years(0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::payment::request_data(arg2)) == 1, 7);
        let v1 = FreeClaimsApp{dummy_field: false};
        0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::payment::apply_percentage_discount<FreeClaimsApp>(arg2, arg1, v1, 0x1::string::utf8(b"object_discount"), 100, false);
    }

    // decompiled from Move bytecode v6
}

