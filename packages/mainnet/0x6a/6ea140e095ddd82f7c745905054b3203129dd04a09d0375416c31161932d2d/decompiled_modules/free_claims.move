module 0x6a6ea140e095ddd82f7c745905054b3203129dd04a09d0375416c31161932d2d::free_claims {
    struct FreeClaimsApp has drop {
        dummy_field: bool,
    }

    struct FreeClaimsKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct FreeClaimsConfig has store {
        domain_length_range: vector<u8>,
        used_objects: 0x2::linked_table::LinkedTable<0x2::object::ID, bool>,
    }

    fun assert_config_exists<T0>(arg0: &mut 0x6a6ea140e095ddd82f7c745905054b3203129dd04a09d0375416c31161932d2d::house::DiscountHouse) {
        let v0 = FreeClaimsKey<T0>{dummy_field: false};
        assert!(0x2::dynamic_field::exists_with_type<FreeClaimsKey<T0>, FreeClaimsConfig>(0x6a6ea140e095ddd82f7c745905054b3203129dd04a09d0375416c31161932d2d::house::uid_mut(arg0), v0), 2);
    }

    fun assert_domain_length_eligible(arg0: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::domain::Domain, arg1: &FreeClaimsConfig) {
        let v0 = (0x1::string::length(0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::domain::sld(arg0)) as u8);
        assert!(v0 >= *0x1::vector::borrow<u8>(&arg1.domain_length_range, 0) && v0 <= *0x1::vector::borrow<u8>(&arg1.domain_length_range, 1), 3);
    }

    fun assert_valid_length_setup(arg0: &vector<u8>) {
        assert!(0x1::vector::length<u8>(arg0) == 2, 3);
        assert!(*0x1::vector::borrow<u8>(arg0, 1) >= *0x1::vector::borrow<u8>(arg0, 0), 3);
    }

    public fun authorize_type<T0: key>(arg0: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::AdminCap, arg1: &mut 0x6a6ea140e095ddd82f7c745905054b3203129dd04a09d0375416c31161932d2d::house::DiscountHouse, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        0x6a6ea140e095ddd82f7c745905054b3203129dd04a09d0375416c31161932d2d::house::assert_version_is_valid(arg1);
        let v0 = FreeClaimsKey<T0>{dummy_field: false};
        assert!(!0x2::dynamic_field::exists_<FreeClaimsKey<T0>>(0x6a6ea140e095ddd82f7c745905054b3203129dd04a09d0375416c31161932d2d::house::uid_mut(arg1), v0), 1);
        assert_valid_length_setup(&arg2);
        let v1 = FreeClaimsKey<T0>{dummy_field: false};
        let v2 = FreeClaimsConfig{
            domain_length_range : arg2,
            used_objects        : 0x2::linked_table::new<0x2::object::ID, bool>(arg3),
        };
        0x2::dynamic_field::add<FreeClaimsKey<T0>, FreeClaimsConfig>(0x6a6ea140e095ddd82f7c745905054b3203129dd04a09d0375416c31161932d2d::house::uid_mut(arg1), v1, v2);
    }

    public fun deauthorize_type<T0>(arg0: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::AdminCap, arg1: &mut 0x6a6ea140e095ddd82f7c745905054b3203129dd04a09d0375416c31161932d2d::house::DiscountHouse) {
        0x6a6ea140e095ddd82f7c745905054b3203129dd04a09d0375416c31161932d2d::house::assert_version_is_valid(arg1);
        assert_config_exists<T0>(arg1);
        let v0 = FreeClaimsKey<T0>{dummy_field: false};
        let FreeClaimsConfig {
            domain_length_range : _,
            used_objects        : v2,
        } = 0x2::dynamic_field::remove<FreeClaimsKey<T0>, FreeClaimsConfig>(0x6a6ea140e095ddd82f7c745905054b3203129dd04a09d0375416c31161932d2d::house::uid_mut(arg1), v0);
        let v3 = v2;
        while (0x2::linked_table::length<0x2::object::ID, bool>(&v3) > 0) {
            let (_, _) = 0x2::linked_table::pop_front<0x2::object::ID, bool>(&mut v3);
        };
        0x2::linked_table::destroy_empty<0x2::object::ID, bool>(v3);
    }

    public fun force_deauthorize_type<T0>(arg0: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::AdminCap, arg1: &mut 0x6a6ea140e095ddd82f7c745905054b3203129dd04a09d0375416c31161932d2d::house::DiscountHouse) {
        0x6a6ea140e095ddd82f7c745905054b3203129dd04a09d0375416c31161932d2d::house::assert_version_is_valid(arg1);
        assert_config_exists<T0>(arg1);
        let v0 = FreeClaimsKey<T0>{dummy_field: false};
        let FreeClaimsConfig {
            domain_length_range : _,
            used_objects        : v2,
        } = 0x2::dynamic_field::remove<FreeClaimsKey<T0>, FreeClaimsConfig>(0x6a6ea140e095ddd82f7c745905054b3203129dd04a09d0375416c31161932d2d::house::uid_mut(arg1), v0);
        0x2::linked_table::drop<0x2::object::ID, bool>(v2);
    }

    public fun free_claim<T0: key>(arg0: &mut 0x6a6ea140e095ddd82f7c745905054b3203129dd04a09d0375416c31161932d2d::house::DiscountHouse, arg1: &mut 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS, arg2: &T0, arg3: 0x1::string::String, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration {
        assert!(0x1::type_name::into_string(0x1::type_name::get<T0>()) != 0x1::type_name::into_string(0x1::type_name::get<0xbf1431324a4a6eadd70e0ac6c5a16f36492f255ed4d011978b2cf34ad738efe6::day_one::DayOne>()), 5);
        internal_claim_free_name<T0>(arg0, arg1, arg3, arg4, arg2, arg5)
    }

    public fun free_claim_with_day_one(arg0: &mut 0x6a6ea140e095ddd82f7c745905054b3203129dd04a09d0375416c31161932d2d::house::DiscountHouse, arg1: &mut 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS, arg2: &0xbf1431324a4a6eadd70e0ac6c5a16f36492f255ed4d011978b2cf34ad738efe6::day_one::DayOne, arg3: 0x1::string::String, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration {
        assert!(0xbf1431324a4a6eadd70e0ac6c5a16f36492f255ed4d011978b2cf34ad738efe6::day_one::is_active(arg2), 6);
        internal_claim_free_name<0xbf1431324a4a6eadd70e0ac6c5a16f36492f255ed4d011978b2cf34ad738efe6::day_one::DayOne>(arg0, arg1, arg3, arg4, arg2, arg5)
    }

    fun internal_claim_free_name<T0: key>(arg0: &mut 0x6a6ea140e095ddd82f7c745905054b3203129dd04a09d0375416c31161932d2d::house::DiscountHouse, arg1: &mut 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS, arg2: 0x1::string::String, arg3: &0x2::clock::Clock, arg4: &T0, arg5: &mut 0x2::tx_context::TxContext) : 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration {
        0x6a6ea140e095ddd82f7c745905054b3203129dd04a09d0375416c31161932d2d::house::assert_version_is_valid(arg0);
        assert_config_exists<T0>(arg0);
        let v0 = 0x2::object::id<T0>(arg4);
        let v1 = FreeClaimsKey<T0>{dummy_field: false};
        let v2 = 0x2::dynamic_field::borrow_mut<FreeClaimsKey<T0>, FreeClaimsConfig>(0x6a6ea140e095ddd82f7c745905054b3203129dd04a09d0375416c31161932d2d::house::uid_mut(arg0), v1);
        assert!(!0x2::linked_table::contains<0x2::object::ID, bool>(&v2.used_objects, v0), 4);
        0x2::linked_table::push_back<0x2::object::ID, bool>(&mut v2.used_objects, v0, true);
        let v3 = 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::domain::new(arg2);
        assert_domain_length_eligible(&v3, v2);
        0x6a6ea140e095ddd82f7c745905054b3203129dd04a09d0375416c31161932d2d::house::friend_add_registry_entry(arg1, v3, arg3, arg5)
    }

    // decompiled from Move bytecode v6
}

