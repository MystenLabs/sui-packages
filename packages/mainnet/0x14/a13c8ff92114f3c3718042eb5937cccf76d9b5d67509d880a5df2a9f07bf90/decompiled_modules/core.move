module 0x14a13c8ff92114f3c3718042eb5937cccf76d9b5d67509d880a5df2a9f07bf90::core {
    struct CORE has drop {
        dummy_field: bool,
    }

    struct CapRegistry<phantom T0> has store, key {
        id: 0x2::object::UID,
        clt_expiration: bool,
    }

    struct Promise<phantom T0> {
        dummy_field: bool,
    }

    struct AdminCap<phantom T0> has key {
        id: 0x2::object::UID,
        permanent: bool,
    }

    public fun admin_transfer<T0>(arg0: &0xeea8da3ccfbf41ea8be72d36a7fb8171204694c80634fa503d72b66e2e1450a3::custom_token::TokenPolicyCap<T0>, arg1: 0xeea8da3ccfbf41ea8be72d36a7fb8171204694c80634fa503d72b66e2e1450a3::custom_token::Token<T0>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let (_, _, _, _, _) = 0xeea8da3ccfbf41ea8be72d36a7fb8171204694c80634fa503d72b66e2e1450a3::custom_token::confirm_with_policy_cap<T0>(arg0, 0xeea8da3ccfbf41ea8be72d36a7fb8171204694c80634fa503d72b66e2e1450a3::custom_token::transfer<T0>(arg1, arg2, arg3), arg3);
    }

    public fun borrow_caps<T0>(arg0: &AdminCap<T0>, arg1: &mut CapRegistry<T0>) : (0x2::coin::TreasuryCap<T0>, 0xeea8da3ccfbf41ea8be72d36a7fb8171204694c80634fa503d72b66e2e1450a3::custom_token::TokenPolicyCap<T0>, Promise<T0>) {
        let v0 = Promise<T0>{dummy_field: false};
        (0x2::dynamic_object_field::remove<0x1::string::String, 0x2::coin::TreasuryCap<T0>>(&mut arg1.id, 0x1::string::utf8(b"treasury_cap_key")), 0x2::dynamic_object_field::remove<0x1::string::String, 0xeea8da3ccfbf41ea8be72d36a7fb8171204694c80634fa503d72b66e2e1450a3::custom_token::TokenPolicyCap<T0>>(&mut arg1.id, 0x1::string::utf8(b"token_policy_cap_key")), v0)
    }

    fun borrow_treasury_cap<T0>(arg0: &mut CapRegistry<T0>) : &mut 0x2::coin::TreasuryCap<T0> {
        0x2::dynamic_object_field::borrow_mut<0x1::string::String, 0x2::coin::TreasuryCap<T0>>(&mut arg0.id, 0x1::string::utf8(b"treasury_cap_key"))
    }

    public fun burn_expired<T0>(arg0: &mut CapRegistry<T0>, arg1: 0xeea8da3ccfbf41ea8be72d36a7fb8171204694c80634fa503d72b66e2e1450a3::custom_token::Token<T0>, arg2: &0x2::clock::Clock) {
        assert!(arg0.clt_expiration, 1);
        assert!(0xeea8da3ccfbf41ea8be72d36a7fb8171204694c80634fa503d72b66e2e1450a3::custom_token::expiration_value<T0>(&arg1) < 0x2::clock::timestamp_ms(arg2), 0);
        0xeea8da3ccfbf41ea8be72d36a7fb8171204694c80634fa503d72b66e2e1450a3::custom_token::burn<T0>(borrow_treasury_cap<T0>(arg0), arg1);
    }

    public fun create_registry<T0>(arg0: 0x2::coin::TreasuryCap<T0>, arg1: 0xeea8da3ccfbf41ea8be72d36a7fb8171204694c80634fa503d72b66e2e1450a3::custom_token::TokenPolicyCap<T0>, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = CapRegistry<T0>{
            id             : 0x2::object::new(arg3),
            clt_expiration : arg2,
        };
        let v1 = AdminCap<T0>{
            id        : 0x2::object::new(arg3),
            permanent : true,
        };
        0x2::dynamic_object_field::add<0x1::string::String, 0x2::coin::TreasuryCap<T0>>(&mut v0.id, 0x1::string::utf8(b"treasury_cap_key"), arg0);
        0x2::dynamic_object_field::add<0x1::string::String, 0xeea8da3ccfbf41ea8be72d36a7fb8171204694c80634fa503d72b66e2e1450a3::custom_token::TokenPolicyCap<T0>>(&mut v0.id, 0x1::string::utf8(b"token_policy_cap_key"), arg1);
        0x2::transfer::transfer<AdminCap<T0>>(v1, 0x2::tx_context::sender(arg3));
        0x2::transfer::share_object<CapRegistry<T0>>(v0);
    }

    public fun delete_admin_cap<T0>(arg0: AdminCap<T0>) {
        assert!(arg0.permanent == false, 2);
        let AdminCap {
            id        : v0,
            permanent : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    fun init(arg0: CORE, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<CORE>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    public fun mint_as_admin<T0>(arg0: &AdminCap<T0>, arg1: &mut CapRegistry<T0>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.clt_expiration, 1);
        let v0 = borrow_treasury_cap<T0>(arg1);
        let (_, _, _, _, _) = 0xeea8da3ccfbf41ea8be72d36a7fb8171204694c80634fa503d72b66e2e1450a3::custom_token::confirm_with_treasury_cap<T0>(v0, 0xeea8da3ccfbf41ea8be72d36a7fb8171204694c80634fa503d72b66e2e1450a3::custom_token::transfer<T0>(0xeea8da3ccfbf41ea8be72d36a7fb8171204694c80634fa503d72b66e2e1450a3::custom_token::mint<T0>(v0, arg2, arg4), arg3, arg4), arg4);
    }

    public fun mint_as_admin_with_expiration<T0>(arg0: &AdminCap<T0>, arg1: &mut CapRegistry<T0>, arg2: &0x2::clock::Clock, arg3: u64, arg4: u64, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.clt_expiration, 1);
        let v0 = borrow_treasury_cap<T0>(arg1);
        let (_, _, _, _, _) = 0xeea8da3ccfbf41ea8be72d36a7fb8171204694c80634fa503d72b66e2e1450a3::custom_token::confirm_with_treasury_cap<T0>(v0, 0xeea8da3ccfbf41ea8be72d36a7fb8171204694c80634fa503d72b66e2e1450a3::custom_token::transfer<T0>(0xeea8da3ccfbf41ea8be72d36a7fb8171204694c80634fa503d72b66e2e1450a3::custom_token::mint_with_expiration<T0>(v0, arg2, arg3, arg4, arg6), arg5, arg6), arg6);
    }

    public fun new_admin_cap<T0>(arg0: &AdminCap<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.permanent == true, 3);
        let v0 = AdminCap<T0>{
            id        : 0x2::object::new(arg2),
            permanent : false,
        };
        0x2::transfer::transfer<AdminCap<T0>>(v0, arg1);
    }

    public fun return_caps<T0>(arg0: &mut CapRegistry<T0>, arg1: 0x2::coin::TreasuryCap<T0>, arg2: 0xeea8da3ccfbf41ea8be72d36a7fb8171204694c80634fa503d72b66e2e1450a3::custom_token::TokenPolicyCap<T0>, arg3: Promise<T0>) {
        let Promise {  } = arg3;
        0x2::dynamic_object_field::add<0x1::string::String, 0x2::coin::TreasuryCap<T0>>(&mut arg0.id, 0x1::string::utf8(b"treasury_cap_key"), arg1);
        0x2::dynamic_object_field::add<0x1::string::String, 0xeea8da3ccfbf41ea8be72d36a7fb8171204694c80634fa503d72b66e2e1450a3::custom_token::TokenPolicyCap<T0>>(&mut arg0.id, 0x1::string::utf8(b"token_policy_cap_key"), arg2);
    }

    public fun revoke_permanent_cap<T0>(arg0: AdminCap<T0>, arg1: address) {
        assert!(arg0.permanent == true, 3);
        0x2::transfer::transfer<AdminCap<T0>>(arg0, arg1);
    }

    public fun set_rules<T0>(arg0: &mut 0xeea8da3ccfbf41ea8be72d36a7fb8171204694c80634fa503d72b66e2e1450a3::custom_token::TokenPolicy<T0>, arg1: &0xeea8da3ccfbf41ea8be72d36a7fb8171204694c80634fa503d72b66e2e1450a3::custom_token::TokenPolicyCap<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0xeea8da3ccfbf41ea8be72d36a7fb8171204694c80634fa503d72b66e2e1450a3::custom_token::add_rule_for_action<T0, 0x14a13c8ff92114f3c3718042eb5937cccf76d9b5d67509d880a5df2a9f07bf90::denylist_rule::Denylist>(arg0, arg1, 0xeea8da3ccfbf41ea8be72d36a7fb8171204694c80634fa503d72b66e2e1450a3::custom_token::spend_action(), arg2);
        0xeea8da3ccfbf41ea8be72d36a7fb8171204694c80634fa503d72b66e2e1450a3::custom_token::add_rule_for_action<T0, 0x14a13c8ff92114f3c3718042eb5937cccf76d9b5d67509d880a5df2a9f07bf90::expired_rule::Expired>(arg0, arg1, 0xeea8da3ccfbf41ea8be72d36a7fb8171204694c80634fa503d72b66e2e1450a3::custom_token::spend_action(), arg2);
    }

    // decompiled from Move bytecode v6
}

