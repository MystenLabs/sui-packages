module 0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::airdrop {
    struct TGE_Pool<phantom T0> has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        project_id: 0x2::object::ID,
        profile_id: 0x2::object::ID,
    }

    fun assert_tge_pool_profile_match<T0>(arg0: &TGE_Pool<T0>, arg1: &0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::project_profile::ProjectProfile) {
        assert!(arg0.profile_id == 0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::project_profile::profile_id(arg1), 0);
        assert!(arg0.project_id == 0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::project_profile::project_id(arg1), 0);
    }

    public fun redeem_points<T0>(arg0: &0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::global_config::GlobalConfig, arg1: &mut 0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::scoreboard::Scoreboard, arg2: &mut TGE_Pool<T0>, arg3: &0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::project_profile::ProjectProfile, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::global_config::assert_domain_enabled(arg0, 0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::global_config::airdrop_domain());
        let v0 = arg2.project_id;
        assert!(&v0 == 0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::scoreboard::get_scoreboard_project_ID(arg1), 0);
        assert_tge_pool_profile_match<T0>(arg2, arg3);
        let (v1, v2, _) = 0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::point_math::points_to_coin_floor(0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::scoreboard::get_unconverted_score_by_address(arg1, arg4, 0x2::tx_context::sender(arg5)), 0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::project_profile::coin_point_ratio(arg3));
        assert!(v1 > 0, 1);
        0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::scoreboard::calculate_convert_amount(arg1, arg4, 0x2::tx_context::sender(arg5), v2);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg2.balance, v1), arg5)
    }

    public fun redeem_tokens<T0>(arg0: &0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::global_config::GlobalConfig, arg1: &mut 0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::token::TokenHoldingRegistry<T0>, arg2: 0x2::token::Token<T0>, arg3: &mut 0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::token::TreasuryCapStore<T0>, arg4: &mut TGE_Pool<T0>, arg5: &0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::project_profile::ProjectProfile, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::global_config::assert_domain_enabled(arg0, 0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::global_config::airdrop_domain());
        assert!(0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::token::treasury_cap_store_project_id<T0>(arg3) == arg4.project_id, 0);
        assert!(0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::token::token_holding_registry_project_id<T0>(arg1) == arg4.project_id, 0);
        assert!(0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::token::token_holding_registry_profile_id<T0>(arg1) == 0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::project_profile::profile_id(arg5), 0);
        assert!(0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::token::token_holding_registry_scale<T0>(arg1) == 0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::project_profile::token_point_scale(arg5), 0);
        assert_tge_pool_profile_match<T0>(arg4, arg5);
        let (v0, _) = 0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::point_math::token_amount_to_coin_exact(0x2::token::value<T0>(&arg2), 0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::project_profile::token_point_scale(arg5), 0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::project_profile::coin_point_ratio(arg5));
        assert!(v0 > 0, 1);
        0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::token::decrease_holding_by_token_amount<T0>(arg1, 0x2::tx_context::sender(arg6), 0x2::token::value<T0>(&arg2));
        0x2::token::burn<T0>(0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::token::internal_borrow_mut_treasury_cap<T0>(arg3), arg2);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg4.balance, v0), arg6)
    }

    public fun tge_setting<T0>(arg0: &0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::global_config::GlobalConfig, arg1: &0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::project_cap::ProjectCap, arg2: &0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::project_profile::ProjectProfile, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::global_config::assert_domain_enabled(arg0, 0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::global_config::airdrop_domain());
        assert!(0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::project_profile::project_id(arg2) == 0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::scoreboard::get_project_cap_ID(arg1), 0);
        assert!(0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::project_profile::coin_point_ratio(arg2) > 0, 2);
        let v0 = TGE_Pool<T0>{
            id         : 0x2::object::new(arg4),
            balance    : 0x2::coin::into_balance<T0>(arg3),
            project_id : 0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::scoreboard::get_project_cap_ID(arg1),
            profile_id : 0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::project_profile::profile_id(arg2),
        };
        0x2::transfer::share_object<TGE_Pool<T0>>(v0);
    }

    public fun withdraw_tge_coin<T0>(arg0: &0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::global_config::GlobalConfig, arg1: &0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::project_cap::ProjectCap, arg2: &mut TGE_Pool<T0>, arg3: &0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::project_profile::ProjectProfile, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::global_config::assert_domain_enabled(arg0, 0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::global_config::airdrop_domain());
        assert!(arg2.project_id == 0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::project_cap::get_project_cap_ID(arg1), 0);
        assert_tge_pool_profile_match<T0>(arg2, arg3);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg2.balance, arg4), arg5)
    }

    // decompiled from Move bytecode v7
}

