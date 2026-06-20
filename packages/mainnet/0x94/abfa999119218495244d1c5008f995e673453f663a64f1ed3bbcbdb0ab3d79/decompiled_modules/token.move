module 0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::token {
    struct TreasuryCapStore<phantom T0> has key {
        id: 0x2::object::UID,
        project_id: 0x2::object::ID,
        treasury_cap: 0x2::coin::TreasuryCap<T0>,
    }

    struct TokenHoldingRegistry<phantom T0> has key {
        id: 0x2::object::UID,
        project_id: 0x2::object::ID,
        profile_id: 0x2::object::ID,
        scale: u64,
        holdings: 0x2::table::Table<address, u64>,
    }

    public fun mint<T0>(arg0: &0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::global_config::GlobalConfig, arg1: &mut TokenHoldingRegistry<T0>, arg2: &mut TreasuryCapStore<T0>, arg3: &mut 0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::scoreboard::Scoreboard, arg4: &0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::project_profile::ProjectProfile, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::global_config::assert_domain_enabled(arg0, 0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::global_config::token_domain());
        assert!(arg2.project_id == *0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::scoreboard::get_scoreboard_project_ID(arg3), 0);
        assert_registry_match<T0>(arg1, arg2);
        assert_registry_profile_match<T0>(arg1, arg4);
        let v0 = 0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::point_math::points_to_token_amount(0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::scoreboard::calculate_convert(arg3, arg5, 0x2::tx_context::sender(arg6)), 0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::project_profile::token_point_scale(arg4));
        internal_mint_token<T0>(arg2, v0, arg6);
        increase_holding_by_token_amount<T0>(arg1, 0x2::tx_context::sender(arg6), v0);
    }

    fun assert_registry_match<T0>(arg0: &TokenHoldingRegistry<T0>, arg1: &TreasuryCapStore<T0>) {
        assert!(arg0.project_id == arg1.project_id, 2);
        assert_valid_scale(arg0.scale);
    }

    fun assert_registry_profile_match<T0>(arg0: &TokenHoldingRegistry<T0>, arg1: &0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::project_profile::ProjectProfile) {
        assert!(arg0.profile_id == 0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::project_profile::profile_id(arg1), 2);
        assert!(arg0.project_id == 0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::project_profile::project_id(arg1), 2);
        assert!(arg0.scale == 0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::project_profile::token_point_scale(arg1), 2);
    }

    fun assert_valid_scale(arg0: u64) {
        0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::point_math::assert_valid_token_scale(arg0);
    }

    public fun create_new_treasury_cap_store<T0>(arg0: &0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::global_config::GlobalConfig, arg1: &0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::system::ProtocolAdminCap, arg2: &0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::scoreboard::Scoreboard, arg3: 0x2::coin::TreasuryCap<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::global_config::assert_domain_enabled(arg0, 0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::global_config::token_domain());
        let v0 = TreasuryCapStore<T0>{
            id           : 0x2::object::new(arg4),
            project_id   : *0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::scoreboard::get_scoreboard_project_ID(arg2),
            treasury_cap : arg3,
        };
        0x2::transfer::share_object<TreasuryCapStore<T0>>(v0);
    }

    public fun create_token_holding_registry<T0>(arg0: &0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::global_config::GlobalConfig, arg1: &0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::system::ProtocolAdminCap, arg2: &TreasuryCapStore<T0>, arg3: &0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::project_profile::ProjectProfile, arg4: &mut 0x2::tx_context::TxContext) {
        0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::global_config::assert_domain_enabled(arg0, 0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::global_config::token_domain());
        assert!(arg2.project_id == 0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::project_profile::project_id(arg3), 0);
        let v0 = 0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::project_profile::token_point_scale(arg3);
        assert_valid_scale(v0);
        let v1 = TokenHoldingRegistry<T0>{
            id         : 0x2::object::new(arg4),
            project_id : arg2.project_id,
            profile_id : 0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::project_profile::profile_id(arg3),
            scale      : v0,
            holdings   : 0x2::table::new<address, u64>(arg4),
        };
        0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::event::emit_token_holding_registry_created(0x2::object::id<TokenHoldingRegistry<T0>>(&v1), v1.project_id, v1.profile_id, v1.scale);
        0x2::transfer::share_object<TokenHoldingRegistry<T0>>(v1);
    }

    public(friend) fun decrease_holding_by_token_amount<T0>(arg0: &mut TokenHoldingRegistry<T0>, arg1: address, arg2: u64) {
        let v0 = holding_token_amount_by_address<T0>(arg0, arg1);
        assert!(v0 >= arg2, 3);
        let v1 = v0 - arg2;
        assert!(0x2::table::contains<address, u64>(&arg0.holdings, arg1), 3);
        *0x2::table::borrow_mut<address, u64>(&mut arg0.holdings, arg1) = v1;
        0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::event::emit_token_holding_updated(0x2::object::id<TokenHoldingRegistry<T0>>(arg0), arg0.project_id, arg1, false, arg2, arg2 / arg0.scale, v0, v1);
    }

    public fun holding_point_amount_by_address<T0>(arg0: &TokenHoldingRegistry<T0>, arg1: address) : u64 {
        holding_token_amount_by_address<T0>(arg0, arg1) / arg0.scale
    }

    public fun holding_token_amount_by_address<T0>(arg0: &TokenHoldingRegistry<T0>, arg1: address) : u64 {
        if (!0x2::table::contains<address, u64>(&arg0.holdings, arg1)) {
            0
        } else {
            *0x2::table::borrow<address, u64>(&arg0.holdings, arg1)
        }
    }

    public(friend) fun increase_holding_by_token_amount<T0>(arg0: &mut TokenHoldingRegistry<T0>, arg1: address, arg2: u64) {
        let v0 = holding_token_amount_by_address<T0>(arg0, arg1);
        let v1 = 0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::point_math::checked_add(v0, arg2);
        if (0x2::table::contains<address, u64>(&arg0.holdings, arg1)) {
            *0x2::table::borrow_mut<address, u64>(&mut arg0.holdings, arg1) = v1;
        } else {
            0x2::table::add<address, u64>(&mut arg0.holdings, arg1, v1);
        };
        0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::event::emit_token_holding_updated(0x2::object::id<TokenHoldingRegistry<T0>>(arg0), arg0.project_id, arg1, true, arg2, arg2 / arg0.scale, v0, v1);
    }

    public(friend) fun internal_borrow_mut_treasury_cap<T0>(arg0: &mut TreasuryCapStore<T0>) : &mut 0x2::coin::TreasuryCap<T0> {
        &mut arg0.treasury_cap
    }

    public(friend) fun internal_mint_token<T0>(arg0: &mut TreasuryCapStore<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::token::from_coin<T0>(0x2::coin::mint<T0>(&mut arg0.treasury_cap, arg1, arg2), arg2);
        let (_, _, _, _) = 0x2::token::confirm_with_treasury_cap<T0>(&mut arg0.treasury_cap, v1, arg2);
        let (_, _, _, _) = 0x2::token::confirm_with_treasury_cap<T0>(&mut arg0.treasury_cap, 0x2::token::transfer<T0>(v0, 0x2::tx_context::sender(arg2), arg2), arg2);
    }

    public fun merge_token<T0>(arg0: &0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::global_config::GlobalConfig, arg1: 0x2::token::Token<T0>, arg2: 0x2::token::Token<T0>) : 0x2::token::Token<T0> {
        0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::global_config::assert_domain_enabled(arg0, 0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::global_config::token_domain());
        0x2::token::join<T0>(&mut arg1, arg2);
        arg1
    }

    public fun restore_score_from_tokens<T0>(arg0: &0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::global_config::GlobalConfig, arg1: &mut TokenHoldingRegistry<T0>, arg2: &mut TreasuryCapStore<T0>, arg3: &mut 0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::scoreboard::Scoreboard, arg4: &0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::project_profile::ProjectProfile, arg5: 0x2::token::Token<T0>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::global_config::assert_domain_enabled(arg0, 0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::global_config::token_domain());
        assert!(arg2.project_id == *0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::scoreboard::get_scoreboard_project_ID(arg3), 0);
        assert_registry_match<T0>(arg1, arg2);
        assert_registry_profile_match<T0>(arg1, arg4);
        let v0 = 0x2::token::value<T0>(&arg5);
        let v1 = 0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::point_math::token_amount_to_points_exact(v0, 0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::project_profile::token_point_scale(arg4));
        decrease_holding_by_token_amount<T0>(arg1, 0x2::tx_context::sender(arg7), v0);
        0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::scoreboard::restore_tokenized_score(arg3, arg6, 0x2::tx_context::sender(arg7), v1);
        0x2::token::burn<T0>(internal_borrow_mut_treasury_cap<T0>(arg2), arg5);
        0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::event::emit_tokenized_points_restored(0x2::object::id<TokenHoldingRegistry<T0>>(arg1), 0x2::object::id<0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::scoreboard::Scoreboard>(arg3), arg1.project_id, 0x2::tx_context::sender(arg7), v0, v1);
    }

    public fun split_token<T0>(arg0: &0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::global_config::GlobalConfig, arg1: 0x2::token::Token<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (0x2::token::Token<T0>, 0x2::token::Token<T0>) {
        0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::global_config::assert_domain_enabled(arg0, 0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::global_config::token_domain());
        (arg1, 0x2::token::split<T0>(&mut arg1, arg2, arg3))
    }

    public(friend) fun token_holding_registry_profile_id<T0>(arg0: &TokenHoldingRegistry<T0>) : 0x2::object::ID {
        arg0.profile_id
    }

    public(friend) fun token_holding_registry_project_id<T0>(arg0: &TokenHoldingRegistry<T0>) : 0x2::object::ID {
        arg0.project_id
    }

    public fun token_holding_registry_scale<T0>(arg0: &TokenHoldingRegistry<T0>) : u64 {
        arg0.scale
    }

    public fun transfer_token<T0>(arg0: &0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::global_config::GlobalConfig, arg1: &mut TokenHoldingRegistry<T0>, arg2: &mut TreasuryCapStore<T0>, arg3: 0x2::token::Token<T0>, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::global_config::assert_domain_enabled(arg0, 0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::global_config::token_domain());
        assert_registry_match<T0>(arg1, arg2);
        let v0 = 0x2::token::value<T0>(&arg3);
        decrease_holding_by_token_amount<T0>(arg1, 0x2::tx_context::sender(arg5), v0);
        increase_holding_by_token_amount<T0>(arg1, arg4, v0);
        let (_, _, _, _) = 0x2::token::confirm_with_treasury_cap<T0>(&mut arg2.treasury_cap, 0x2::token::transfer<T0>(arg3, arg4, arg5), arg5);
    }

    public(friend) fun treasury_cap_store_project_id<T0>(arg0: &TreasuryCapStore<T0>) : 0x2::object::ID {
        arg0.project_id
    }

    // decompiled from Move bytecode v7
}

