module 0x3f625d805339b1b0235ba8c503fa6ea62c88c02ddf14cd9d246d9e1febc0c76::discounts {
    struct RegularDiscountsApp has drop {
        dummy_field: bool,
    }

    struct DiscountKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    public fun apply_day_one_discount(arg0: &mut 0x3f625d805339b1b0235ba8c503fa6ea62c88c02ddf14cd9d246d9e1febc0c76::house::DiscountHouse, arg1: &mut 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::payment::PaymentIntent, arg2: &mut 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS, arg3: &mut 0xbf1431324a4a6eadd70e0ac6c5a16f36492f255ed4d011978b2cf34ad738efe6::day_one::DayOne, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0xbf1431324a4a6eadd70e0ac6c5a16f36492f255ed4d011978b2cf34ad738efe6::day_one::is_active(arg3), 9223372363272683527);
        internal_apply_discount<0xbf1431324a4a6eadd70e0ac6c5a16f36492f255ed4d011978b2cf34ad738efe6::day_one::DayOne>(arg0, arg1, arg2, arg4);
    }

    public fun apply_percentage_discount<T0>(arg0: &mut 0x3f625d805339b1b0235ba8c503fa6ea62c88c02ddf14cd9d246d9e1febc0c76::house::DiscountHouse, arg1: &mut 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::payment::PaymentIntent, arg2: &mut 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS, arg3: &mut T0, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::type_name::get<T0>() != 0x1::type_name::get<0xbf1431324a4a6eadd70e0ac6c5a16f36492f255ed4d011978b2cf34ad738efe6::day_one::DayOne>(), 9223372290258370569);
        internal_apply_discount<T0>(arg0, arg1, arg2, arg4);
    }

    fun assert_config_exists<T0>(arg0: &mut 0x3f625d805339b1b0235ba8c503fa6ea62c88c02ddf14cd9d246d9e1febc0c76::house::DiscountHouse) {
        let v0 = DiscountKey<T0>{dummy_field: false};
        assert!(0x2::dynamic_field::exists_with_type<DiscountKey<T0>, 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::pricing_config::PricingConfig>(0x3f625d805339b1b0235ba8c503fa6ea62c88c02ddf14cd9d246d9e1febc0c76::house::uid_mut(arg0), v0), 9223372642445295619);
    }

    public fun authorize_type<T0>(arg0: &mut 0x3f625d805339b1b0235ba8c503fa6ea62c88c02ddf14cd9d246d9e1febc0c76::house::DiscountHouse, arg1: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::AdminCap, arg2: 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::pricing_config::PricingConfig) {
        let v0 = DiscountKey<T0>{dummy_field: false};
        assert!(!0x2::dynamic_field::exists_<DiscountKey<T0>>(0x3f625d805339b1b0235ba8c503fa6ea62c88c02ddf14cd9d246d9e1febc0c76::house::uid_mut(arg0), v0), 9223372427696799745);
        let (_, v2) = 0x2::vec_map::into_keys_values<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::pricing_config::Range, u64>(*0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::pricing_config::pricing(&arg2));
        let v3 = v2;
        let v4 = &v3;
        let v5 = 0;
        let v6;
        while (v5 < 0x1::vector::length<u64>(v4)) {
            if (*0x1::vector::borrow<u64>(v4, v5) > 99) {
                v6 = true;
                /* label 9 */
                assert!(!v6, 9223372440581963781);
                let v7 = DiscountKey<T0>{dummy_field: false};
                0x2::dynamic_field::add<DiscountKey<T0>, 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::pricing_config::PricingConfig>(0x3f625d805339b1b0235ba8c503fa6ea62c88c02ddf14cd9d246d9e1febc0c76::house::uid_mut(arg0), v7, arg2);
                return
            };
            v5 = v5 + 1;
        };
        v6 = false;
        /* goto 9 */
    }

    fun config<T0>(arg0: &mut 0x3f625d805339b1b0235ba8c503fa6ea62c88c02ddf14cd9d246d9e1febc0c76::house::DiscountHouse) : &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::pricing_config::PricingConfig {
        assert_config_exists<T0>(arg0);
        let v0 = DiscountKey<T0>{dummy_field: false};
        0x2::dynamic_field::borrow<DiscountKey<T0>, 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::pricing_config::PricingConfig>(0x3f625d805339b1b0235ba8c503fa6ea62c88c02ddf14cd9d246d9e1febc0c76::house::uid_mut(arg0), v0)
    }

    public fun deauthorize_type<T0>(arg0: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::AdminCap, arg1: &mut 0x3f625d805339b1b0235ba8c503fa6ea62c88c02ddf14cd9d246d9e1febc0c76::house::DiscountHouse) {
        0x3f625d805339b1b0235ba8c503fa6ea62c88c02ddf14cd9d246d9e1febc0c76::house::assert_version_is_valid(arg1);
        assert_config_exists<T0>(arg1);
        let v0 = DiscountKey<T0>{dummy_field: false};
        0x2::dynamic_field::remove<DiscountKey<T0>, 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::pricing_config::PricingConfig>(0x3f625d805339b1b0235ba8c503fa6ea62c88c02ddf14cd9d246d9e1febc0c76::house::uid_mut(arg1), v0);
    }

    fun internal_apply_discount<T0>(arg0: &mut 0x3f625d805339b1b0235ba8c503fa6ea62c88c02ddf14cd9d246d9e1febc0c76::house::DiscountHouse, arg1: &mut 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::payment::PaymentIntent, arg2: &mut 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = RegularDiscountsApp{dummy_field: false};
        0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::payment::apply_percentage_discount<RegularDiscountsApp>(arg1, arg2, v0, 0x1::string::utf8(b"object_discount"), (0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::pricing_config::calculate_base_price(config<T0>(arg0), 0x1::string::length(0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::domain::sld(0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::payment::domain(0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::payment::request_data(arg1))))) as u8), false);
    }

    // decompiled from Move bytecode v6
}

