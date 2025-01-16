module 0x6d14ca3049be747ec87166e6dce5d0d9a30f3b3c281c55d6e518958a236f8b97::coupon_house {
    struct CouponsApp has drop {
        dummy_field: bool,
    }

    struct AppKey<phantom T0: drop> has copy, drop, store {
        dummy_field: bool,
    }

    struct CouponHouse has store {
        data: 0x6d14ca3049be747ec87166e6dce5d0d9a30f3b3c281c55d6e518958a236f8b97::data::Data,
        version: u8,
        storage: 0x2::object::UID,
    }

    public fun admin_add_coupon(arg0: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::AdminCap, arg1: &mut 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS, arg2: 0x1::string::String, arg3: u8, arg4: u64, arg5: 0x6d14ca3049be747ec87166e6dce5d0d9a30f3b3c281c55d6e518958a236f8b97::rules::CouponRules, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = coupon_house_mut(arg1);
        assert_version_is_valid(v0);
        0x6d14ca3049be747ec87166e6dce5d0d9a30f3b3c281c55d6e518958a236f8b97::data::save_coupon(&mut v0.data, arg2, 0x6d14ca3049be747ec87166e6dce5d0d9a30f3b3c281c55d6e518958a236f8b97::coupon::new(arg3, arg4, arg5, arg6));
    }

    public fun admin_remove_coupon(arg0: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::AdminCap, arg1: &mut 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS, arg2: 0x1::string::String) {
        let v0 = coupon_house_mut(arg1);
        assert_version_is_valid(v0);
        0x6d14ca3049be747ec87166e6dce5d0d9a30f3b3c281c55d6e518958a236f8b97::data::remove_coupon(&mut v0.data, arg2);
    }

    public fun app_add_coupon(arg0: &mut 0x6d14ca3049be747ec87166e6dce5d0d9a30f3b3c281c55d6e518958a236f8b97::data::Data, arg1: 0x1::string::String, arg2: u8, arg3: u64, arg4: 0x6d14ca3049be747ec87166e6dce5d0d9a30f3b3c281c55d6e518958a236f8b97::rules::CouponRules, arg5: &mut 0x2::tx_context::TxContext) {
        0x6d14ca3049be747ec87166e6dce5d0d9a30f3b3c281c55d6e518958a236f8b97::data::save_coupon(arg0, arg1, 0x6d14ca3049be747ec87166e6dce5d0d9a30f3b3c281c55d6e518958a236f8b97::coupon::new(arg2, arg3, arg4, arg5));
    }

    public fun app_data_mut<T0: drop>(arg0: &mut 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS, arg1: T0) : &mut 0x6d14ca3049be747ec87166e6dce5d0d9a30f3b3c281c55d6e518958a236f8b97::data::Data {
        let v0 = coupon_house_mut(arg0);
        assert_version_is_valid(v0);
        assert_app_is_authorized<T0>(v0);
        &mut v0.data
    }

    public fun app_remove_coupon(arg0: &mut 0x6d14ca3049be747ec87166e6dce5d0d9a30f3b3c281c55d6e518958a236f8b97::data::Data, arg1: 0x1::string::String) {
        0x6d14ca3049be747ec87166e6dce5d0d9a30f3b3c281c55d6e518958a236f8b97::data::remove_coupon(arg0, arg1);
    }

    public fun apply_coupon(arg0: &mut 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS, arg1: &mut 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::payment::PaymentIntent, arg2: 0x1::string::String, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = coupon_house_mut(arg0);
        assert!(0x2::bag::contains<0x1::string::String>(0x6d14ca3049be747ec87166e6dce5d0d9a30f3b3c281c55d6e518958a236f8b97::data::coupons(&v0.data), arg2), 3);
        let v1 = 0x2::bag::borrow_mut<0x1::string::String, 0x6d14ca3049be747ec87166e6dce5d0d9a30f3b3c281c55d6e518958a236f8b97::coupon::Coupon>(0x6d14ca3049be747ec87166e6dce5d0d9a30f3b3c281c55d6e518958a236f8b97::data::coupons_mut(&mut v0.data), arg2);
        0x6d14ca3049be747ec87166e6dce5d0d9a30f3b3c281c55d6e518958a236f8b97::rules::assert_coupon_valid_for_domain_size(0x6d14ca3049be747ec87166e6dce5d0d9a30f3b3c281c55d6e518958a236f8b97::coupon::rules(v1), (0x1::string::length(0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::domain::sld(0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::payment::domain(0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::payment::request_data(arg1)))) as u8));
        0x6d14ca3049be747ec87166e6dce5d0d9a30f3b3c281c55d6e518958a236f8b97::rules::decrease_available_claims(0x6d14ca3049be747ec87166e6dce5d0d9a30f3b3c281c55d6e518958a236f8b97::coupon::rules_mut(v1));
        0x6d14ca3049be747ec87166e6dce5d0d9a30f3b3c281c55d6e518958a236f8b97::rules::assert_coupon_valid_for_address(0x6d14ca3049be747ec87166e6dce5d0d9a30f3b3c281c55d6e518958a236f8b97::coupon::rules(v1), 0x2::tx_context::sender(arg4));
        0x6d14ca3049be747ec87166e6dce5d0d9a30f3b3c281c55d6e518958a236f8b97::rules::assert_coupon_is_not_expired(0x6d14ca3049be747ec87166e6dce5d0d9a30f3b3c281c55d6e518958a236f8b97::coupon::rules(v1), arg3);
        0x6d14ca3049be747ec87166e6dce5d0d9a30f3b3c281c55d6e518958a236f8b97::rules::assert_coupon_valid_for_domain_years(0x6d14ca3049be747ec87166e6dce5d0d9a30f3b3c281c55d6e518958a236f8b97::coupon::rules(v1), 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::payment::years(0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::payment::request_data(arg1)));
        if (!0x6d14ca3049be747ec87166e6dce5d0d9a30f3b3c281c55d6e518958a236f8b97::rules::has_available_claims(0x6d14ca3049be747ec87166e6dce5d0d9a30f3b3c281c55d6e518958a236f8b97::coupon::rules(v1))) {
            0x6d14ca3049be747ec87166e6dce5d0d9a30f3b3c281c55d6e518958a236f8b97::data::remove_coupon(&mut v0.data, arg2);
        };
        let v2 = CouponsApp{dummy_field: false};
        0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::payment::apply_percentage_discount<CouponsApp>(arg1, arg0, v2, 0x1::string::utf8(b"coupon"), (0x6d14ca3049be747ec87166e6dce5d0d9a30f3b3c281c55d6e518958a236f8b97::coupon::discount_percentage(v1) as u8), false);
    }

    fun assert_app_is_authorized<T0: drop>(arg0: &CouponHouse) {
        assert!(is_app_authorized<T0>(arg0), 1);
    }

    public fun assert_version_is_valid(arg0: &CouponHouse) {
        assert!(arg0.version == 1, 2);
    }

    public fun authorize_app<T0: drop>(arg0: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::AdminCap, arg1: &mut 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS) {
        let v0 = AppKey<T0>{dummy_field: false};
        0x2::dynamic_field::add<AppKey<T0>, bool>(&mut coupon_house_mut(arg1).storage, v0, true);
    }

    public fun calculate_sale_price(arg0: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS, arg1: u64, arg2: 0x1::string::String) : u64 {
        abort 1337
    }

    fun coupon_house_mut(arg0: &mut 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS) : &mut CouponHouse {
        0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::assert_app_is_authorized<CouponsApp>(arg0);
        let v0 = CouponsApp{dummy_field: false};
        let v1 = 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::app_registry_mut<CouponsApp, CouponHouse>(v0, arg0);
        assert_version_is_valid(v1);
        v1
    }

    public fun deauthorize_app<T0: drop>(arg0: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::AdminCap, arg1: &mut 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS) : bool {
        let v0 = AppKey<T0>{dummy_field: false};
        0x2::dynamic_field::remove<AppKey<T0>, bool>(&mut coupon_house_mut(arg1).storage, v0)
    }

    fun is_app_authorized<T0: drop>(arg0: &CouponHouse) : bool {
        let v0 = AppKey<T0>{dummy_field: false};
        0x2::dynamic_field::exists_<AppKey<T0>>(&arg0.storage, v0)
    }

    public fun register_with_coupon(arg0: &mut 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: u8, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration {
        abort 1337
    }

    public fun set_version(arg0: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::AdminCap, arg1: &mut 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS, arg2: u8) {
        coupon_house_mut(arg1).version = arg2;
    }

    public fun setup(arg0: &mut 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS, arg1: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = CouponHouse{
            data    : 0x6d14ca3049be747ec87166e6dce5d0d9a30f3b3c281c55d6e518958a236f8b97::data::new(arg2),
            version : 1,
            storage : 0x2::object::new(arg2),
        };
        0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::add_registry<CouponHouse>(arg1, arg0, v0);
    }

    // decompiled from Move bytecode v6
}

