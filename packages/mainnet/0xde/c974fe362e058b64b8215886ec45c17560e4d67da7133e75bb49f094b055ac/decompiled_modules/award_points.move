module 0xdec974fe362e058b64b8215886ec45c17560e4d67da7133e75bb49f094b055ac::award_points {
    struct TokenAward has drop {
        _dummy: bool,
    }

    struct AwardPointsWhitelistedModule has store, key {
        id: 0x2::object::UID,
        modules: vector<0x1::string::String>,
    }

    public fun award_points<T0: drop>(arg0: &AwardPointsWhitelistedModule, arg1: &mut 0x2::token::TokenPolicy<0xdec974fe362e058b64b8215886ec45c17560e4d67da7133e75bb49f094b055ac::voultron_points::VOULTRON_POINTS>, arg2: &mut 0xdec974fe362e058b64b8215886ec45c17560e4d67da7133e75bb49f094b055ac::voultron_points::PointsTreasuryCapOwner, arg3: T0, arg4: u64, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xdec974fe362e058b64b8215886ec45c17560e4d67da7133e75bb49f094b055ac::voultron_points::get_mut_treasury_cap(arg2);
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        let v2 = 0x1::string::from_ascii(0x1::type_name::address_string(&v1));
        assert!(0x1::vector::contains<0x1::string::String>(&arg0.modules, &v2), 0);
        let v3 = 0x2::token::transfer<0xdec974fe362e058b64b8215886ec45c17560e4d67da7133e75bb49f094b055ac::voultron_points::VOULTRON_POINTS>(0x2::token::mint<0xdec974fe362e058b64b8215886ec45c17560e4d67da7133e75bb49f094b055ac::voultron_points::VOULTRON_POINTS>(v0, arg4, arg6), arg5, arg6);
        let v4 = TokenAward{_dummy: true};
        0x2::token::add_approval<0xdec974fe362e058b64b8215886ec45c17560e4d67da7133e75bb49f094b055ac::voultron_points::VOULTRON_POINTS, TokenAward>(v4, &mut v3, arg6);
        let (_, _, _, _) = 0x2::token::confirm_request<0xdec974fe362e058b64b8215886ec45c17560e4d67da7133e75bb49f094b055ac::voultron_points::VOULTRON_POINTS>(arg1, v3, arg6);
    }

    public fun admin_destroy_award_points_whitelisted_module(arg0: &0xf0dae60bfd1150410c634793dab8c0548ad78ea87899ac5f15a3b30fc747c6a8::voultron_admins::Admins, arg1: AwardPointsWhitelistedModule, arg2: &mut 0x2::tx_context::TxContext) {
        0xf0dae60bfd1150410c634793dab8c0548ad78ea87899ac5f15a3b30fc747c6a8::voultron_admins::check_admin(arg0, arg2);
        let AwardPointsWhitelistedModule {
            id      : v0,
            modules : _,
        } = arg1;
        0x2::object::delete(v0);
    }

    public fun admin_whitelist_modules(arg0: &0xf0dae60bfd1150410c634793dab8c0548ad78ea87899ac5f15a3b30fc747c6a8::voultron_admins::Admins, arg1: &mut AwardPointsWhitelistedModule, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        0xf0dae60bfd1150410c634793dab8c0548ad78ea87899ac5f15a3b30fc747c6a8::voultron_admins::check_admin(arg0, arg3);
        0x1::vector::push_back<0x1::string::String>(&mut arg1.modules, arg2);
    }

    public fun get_whitelisted_modules(arg0: &AwardPointsWhitelistedModule) : &vector<0x1::string::String> {
        &arg0.modules
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AwardPointsWhitelistedModule{
            id      : 0x2::object::new(arg0),
            modules : 0x1::vector::empty<0x1::string::String>(),
        };
        0x2::transfer::share_object<AwardPointsWhitelistedModule>(v0);
    }

    public fun install_rule(arg0: &mut 0x2::token::TokenPolicy<0xdec974fe362e058b64b8215886ec45c17560e4d67da7133e75bb49f094b055ac::voultron_points::VOULTRON_POINTS>, arg1: &0x2::token::TokenPolicyCap<0xdec974fe362e058b64b8215886ec45c17560e4d67da7133e75bb49f094b055ac::voultron_points::VOULTRON_POINTS>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::token::add_rule_for_action<0xdec974fe362e058b64b8215886ec45c17560e4d67da7133e75bb49f094b055ac::voultron_points::VOULTRON_POINTS, TokenAward>(arg0, arg1, 0x2::token::transfer_action(), arg2);
    }

    // decompiled from Move bytecode v6
}

