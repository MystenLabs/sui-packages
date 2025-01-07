module 0x6a6ea140e095ddd82f7c745905054b3203129dd04a09d0375416c31161932d2d::discounts {
    struct DiscountKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct DiscountConfig has copy, drop, store {
        three_char_price: u64,
        four_char_price: u64,
        five_plus_char_price: u64,
    }

    fun assert_config_exists<T0>(arg0: &mut 0x6a6ea140e095ddd82f7c745905054b3203129dd04a09d0375416c31161932d2d::house::DiscountHouse) {
        let v0 = DiscountKey<T0>{dummy_field: false};
        assert!(0x2::dynamic_field::exists_with_type<DiscountKey<T0>, DiscountConfig>(0x6a6ea140e095ddd82f7c745905054b3203129dd04a09d0375416c31161932d2d::house::uid_mut(arg0), v0), 2);
    }

    public fun authorize_type<T0>(arg0: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::AdminCap, arg1: &mut 0x6a6ea140e095ddd82f7c745905054b3203129dd04a09d0375416c31161932d2d::house::DiscountHouse, arg2: u64, arg3: u64, arg4: u64) {
        0x6a6ea140e095ddd82f7c745905054b3203129dd04a09d0375416c31161932d2d::house::assert_version_is_valid(arg1);
        let v0 = DiscountKey<T0>{dummy_field: false};
        assert!(!0x2::dynamic_field::exists_<DiscountKey<T0>>(0x6a6ea140e095ddd82f7c745905054b3203129dd04a09d0375416c31161932d2d::house::uid_mut(arg1), v0), 1);
        let v1 = DiscountKey<T0>{dummy_field: false};
        let v2 = DiscountConfig{
            three_char_price     : arg2,
            four_char_price      : arg3,
            five_plus_char_price : arg4,
        };
        0x2::dynamic_field::add<DiscountKey<T0>, DiscountConfig>(0x6a6ea140e095ddd82f7c745905054b3203129dd04a09d0375416c31161932d2d::house::uid_mut(arg1), v1, v2);
    }

    public fun calculate_price(arg0: &DiscountConfig, arg1: u8) : u64 {
        if (arg1 == 3) {
            arg0.three_char_price
        } else if (arg1 == 4) {
            arg0.four_char_price
        } else {
            arg0.five_plus_char_price
        }
    }

    public fun deauthorize_type<T0>(arg0: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::AdminCap, arg1: &mut 0x6a6ea140e095ddd82f7c745905054b3203129dd04a09d0375416c31161932d2d::house::DiscountHouse) {
        0x6a6ea140e095ddd82f7c745905054b3203129dd04a09d0375416c31161932d2d::house::assert_version_is_valid(arg1);
        assert_config_exists<T0>(arg1);
        let v0 = DiscountKey<T0>{dummy_field: false};
        0x2::dynamic_field::remove<DiscountKey<T0>, DiscountConfig>(0x6a6ea140e095ddd82f7c745905054b3203129dd04a09d0375416c31161932d2d::house::uid_mut(arg1), v0);
    }

    fun internal_register_name<T0>(arg0: &mut 0x6a6ea140e095ddd82f7c745905054b3203129dd04a09d0375416c31161932d2d::house::DiscountHouse, arg1: &mut 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS, arg2: 0x1::string::String, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration {
        0x6a6ea140e095ddd82f7c745905054b3203129dd04a09d0375416c31161932d2d::house::assert_version_is_valid(arg0);
        assert_config_exists<T0>(arg0);
        let v0 = 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::domain::new(arg2);
        let v1 = DiscountKey<T0>{dummy_field: false};
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) == calculate_price(0x2::dynamic_field::borrow<DiscountKey<T0>, DiscountConfig>(0x6a6ea140e095ddd82f7c745905054b3203129dd04a09d0375416c31161932d2d::house::uid_mut(arg0), v1), (0x1::string::length(0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::domain::sld(&v0)) as u8)), 3);
        0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::app_add_balance<0x6a6ea140e095ddd82f7c745905054b3203129dd04a09d0375416c31161932d2d::house::DiscountHouseApp>(0x6a6ea140e095ddd82f7c745905054b3203129dd04a09d0375416c31161932d2d::house::suins_app_auth(), arg1, 0x2::coin::into_balance<0x2::sui::SUI>(arg3));
        0x6a6ea140e095ddd82f7c745905054b3203129dd04a09d0375416c31161932d2d::house::friend_add_registry_entry(arg1, v0, arg4, arg5)
    }

    public fun register<T0>(arg0: &mut 0x6a6ea140e095ddd82f7c745905054b3203129dd04a09d0375416c31161932d2d::house::DiscountHouse, arg1: &mut 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS, arg2: &T0, arg3: 0x1::string::String, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &0x2::clock::Clock, arg6: 0x1::option::Option<0x1::string::String>, arg7: &mut 0x2::tx_context::TxContext) : 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration {
        assert!(0x1::type_name::into_string(0x1::type_name::get<T0>()) != 0x1::type_name::into_string(0x1::type_name::get<0xbf1431324a4a6eadd70e0ac6c5a16f36492f255ed4d011978b2cf34ad738efe6::day_one::DayOne>()), 4);
        internal_register_name<T0>(arg0, arg1, arg3, arg4, arg5, arg7)
    }

    public fun register_with_day_one(arg0: &mut 0x6a6ea140e095ddd82f7c745905054b3203129dd04a09d0375416c31161932d2d::house::DiscountHouse, arg1: &mut 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS, arg2: &0xbf1431324a4a6eadd70e0ac6c5a16f36492f255ed4d011978b2cf34ad738efe6::day_one::DayOne, arg3: 0x1::string::String, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &0x2::clock::Clock, arg6: 0x1::option::Option<0x1::string::String>, arg7: &mut 0x2::tx_context::TxContext) : 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration {
        assert!(0xbf1431324a4a6eadd70e0ac6c5a16f36492f255ed4d011978b2cf34ad738efe6::day_one::is_active(arg2), 5);
        internal_register_name<0xbf1431324a4a6eadd70e0ac6c5a16f36492f255ed4d011978b2cf34ad738efe6::day_one::DayOne>(arg0, arg1, arg3, arg4, arg5, arg7)
    }

    // decompiled from Move bytecode v6
}

