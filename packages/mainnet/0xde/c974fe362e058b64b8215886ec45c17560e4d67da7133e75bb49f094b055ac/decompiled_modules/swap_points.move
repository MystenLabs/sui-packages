module 0xdec974fe362e058b64b8215886ec45c17560e4d67da7133e75bb49f094b055ac::swap_points {
    struct SwapConfig<phantom T0> has key {
        id: 0x2::object::UID,
        rate: u64,
        scaling_factor: u64,
    }

    struct PointsShop has drop {
        dummy_field: bool,
    }

    struct FHCap has drop {
        dummy_field: bool,
    }

    public fun admin_destroy_swap_config<T0>(arg0: &0xf0dae60bfd1150410c634793dab8c0548ad78ea87899ac5f15a3b30fc747c6a8::voultron_admins::Admins, arg1: SwapConfig<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0xf0dae60bfd1150410c634793dab8c0548ad78ea87899ac5f15a3b30fc747c6a8::voultron_admins::check_admin(arg0, arg2);
        let SwapConfig {
            id             : v0,
            rate           : _,
            scaling_factor : _,
        } = arg1;
        0x2::object::delete(v0);
    }

    public fun create_swap_config<T0>(arg0: &0xf0dae60bfd1150410c634793dab8c0548ad78ea87899ac5f15a3b30fc747c6a8::voultron_admins::Admins, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0xf0dae60bfd1150410c634793dab8c0548ad78ea87899ac5f15a3b30fc747c6a8::voultron_admins::check_admin(arg0, arg3);
        let v0 = SwapConfig<T0>{
            id             : 0x2::object::new(arg3),
            rate           : arg1,
            scaling_factor : arg2,
        };
        0x2::transfer::share_object<SwapConfig<T0>>(v0);
    }

    public fun get_rate<T0>(arg0: &SwapConfig<T0>) : u64 {
        arg0.rate
    }

    public fun install_rule(arg0: &mut 0x2::token::TokenPolicy<0xdec974fe362e058b64b8215886ec45c17560e4d67da7133e75bb49f094b055ac::voultron_points::VOULTRON_POINTS>, arg1: &0x2::token::TokenPolicyCap<0xdec974fe362e058b64b8215886ec45c17560e4d67da7133e75bb49f094b055ac::voultron_points::VOULTRON_POINTS>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::token::add_rule_for_action<0xdec974fe362e058b64b8215886ec45c17560e4d67da7133e75bb49f094b055ac::voultron_points::VOULTRON_POINTS, PointsShop>(arg0, arg1, 0x2::token::spend_action(), arg2);
    }

    public fun swap_points_for_token<T0>(arg0: &mut SwapConfig<T0>, arg1: 0x2::token::Token<0xdec974fe362e058b64b8215886ec45c17560e4d67da7133e75bb49f094b055ac::voultron_points::VOULTRON_POINTS>, arg2: &0x930c7f9155da8239d928358abb8b40627f44bdc0be7b3a5a34b3b5e428fe3086::voultron_treasury::TreasuryWhitelistedModules, arg3: &mut 0x930c7f9155da8239d928358abb8b40627f44bdc0be7b3a5a34b3b5e428fe3086::voultron_treasury::Treasury<T0>, arg4: &mut 0xdec974fe362e058b64b8215886ec45c17560e4d67da7133e75bb49f094b055ac::voultron_points::PointsTreasuryCapOwner, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = (((0x2::token::value<0xdec974fe362e058b64b8215886ec45c17560e4d67da7133e75bb49f094b055ac::voultron_points::VOULTRON_POINTS>(&arg1) as u128) * (arg0.rate as u128) / (arg0.scaling_factor as u128)) as u64);
        assert!(v0 >= arg5, 0);
        0x2::token::burn<0xdec974fe362e058b64b8215886ec45c17560e4d67da7133e75bb49f094b055ac::voultron_points::VOULTRON_POINTS>(0xdec974fe362e058b64b8215886ec45c17560e4d67da7133e75bb49f094b055ac::voultron_points::get_mut_treasury_cap(arg4), arg1);
        let v1 = FHCap{dummy_field: false};
        0x930c7f9155da8239d928358abb8b40627f44bdc0be7b3a5a34b3b5e428fe3086::voultron_treasury::remove_from_treasury<FHCap, T0>(arg3, arg2, v1, v0, arg6)
    }

    public fun update_swap_config<T0>(arg0: &0xf0dae60bfd1150410c634793dab8c0548ad78ea87899ac5f15a3b30fc747c6a8::voultron_admins::Admins, arg1: &mut SwapConfig<T0>, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0xf0dae60bfd1150410c634793dab8c0548ad78ea87899ac5f15a3b30fc747c6a8::voultron_admins::check_admin(arg0, arg4);
        arg1.rate = arg2;
        arg1.scaling_factor = arg3;
    }

    // decompiled from Move bytecode v6
}

