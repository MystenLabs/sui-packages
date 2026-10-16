module 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::token {
    struct PointTokenMarket<phantom T0> has key {
        id: 0x2::object::UID,
        project_id: 0x2::object::ID,
        scoreboard_id: 0x2::object::ID,
        scale: u64,
        treasury_cap: 0x2::coin::TreasuryCap<T0>,
        holdings: 0x2::table::Table<address, u64>,
    }

    struct PointsTokenized has copy, drop {
        point_token_market_id: 0x2::object::ID,
        scoreboard_id: 0x2::object::ID,
        owner: address,
        point_amount: u64,
        token_amount: u64,
    }

    struct PointTokensTransferred has copy, drop {
        point_token_market_id: 0x2::object::ID,
        sender: address,
        recipient: address,
        token_amount: u64,
    }

    public fun mint<T0>(arg0: &0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::GlobalConfig, arg1: &mut PointTokenMarket<T0>, arg2: &mut 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::scoreboard::Scoreboard, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::package_version::assert_domain_enabled(arg0, 0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::token_domain());
        assert_scoreboard_match<T0>(arg1, arg2);
        let v0 = 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::scoreboard::calculate_convert(arg2, arg3, 0x2::tx_context::sender(arg4));
        let v1 = 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::point_math::points_to_token_amount(v0, arg1.scale);
        internal_mint_token<T0>(arg1, v1, arg4);
        increase_holding_by_token_amount<T0>(arg1, 0x2::tx_context::sender(arg4), v1);
        let v2 = PointsTokenized{
            point_token_market_id : 0x2::object::id<PointTokenMarket<T0>>(arg1),
            scoreboard_id         : 0x2::object::id<0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::scoreboard::Scoreboard>(arg2),
            owner                 : 0x2::tx_context::sender(arg4),
            point_amount          : v0,
            token_amount          : v1,
        };
        0x2::event::emit<PointsTokenized>(v2);
    }

    fun assert_scoreboard_match<T0>(arg0: &PointTokenMarket<T0>, arg1: &0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::scoreboard::Scoreboard) {
        assert!(arg0.scoreboard_id == 0x2::object::id<0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::scoreboard::Scoreboard>(arg1), 0);
        assert!(arg0.project_id == *0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::scoreboard::get_scoreboard_project_ID(arg1), 0);
    }

    fun assert_valid_scale(arg0: u64) {
        0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::point_math::assert_valid_token_scale(arg0);
    }

    public fun create_point_token_market<T0>(arg0: &0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::GlobalConfig, arg1: &0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::admin::AdminCap, arg2: &0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::scoreboard::Scoreboard, arg3: 0x2::coin::TreasuryCap<T0>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::package_version::assert_domain_enabled(arg0, 0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::token_domain());
        assert_valid_scale(arg4);
        let v0 = PointTokenMarket<T0>{
            id            : 0x2::object::new(arg5),
            project_id    : *0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::scoreboard::get_scoreboard_project_ID(arg2),
            scoreboard_id : 0x2::object::id<0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::scoreboard::Scoreboard>(arg2),
            scale         : arg4,
            treasury_cap  : arg3,
            holdings      : 0x2::table::new<address, u64>(arg5),
        };
        0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::event::emit_point_token_market_created(0x2::object::id<PointTokenMarket<T0>>(&v0), v0.project_id, v0.scoreboard_id, v0.scale);
        0x2::transfer::share_object<PointTokenMarket<T0>>(v0);
    }

    public(friend) fun decrease_holding_by_token_amount<T0>(arg0: &mut PointTokenMarket<T0>, arg1: address, arg2: u64) {
        let v0 = holding_token_amount_by_address<T0>(arg0, arg1);
        assert!(v0 >= arg2, 1);
        let v1 = v0 - arg2;
        assert!(0x2::table::contains<address, u64>(&arg0.holdings, arg1), 1);
        *0x2::table::borrow_mut<address, u64>(&mut arg0.holdings, arg1) = v1;
        0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::event::emit_token_holding_updated(0x2::object::id<PointTokenMarket<T0>>(arg0), arg0.project_id, arg1, false, arg2, arg2 / arg0.scale, v0, v1);
    }

    public fun holding_point_amount_by_address<T0>(arg0: &PointTokenMarket<T0>, arg1: address) : u64 {
        holding_token_amount_by_address<T0>(arg0, arg1) / arg0.scale
    }

    public fun holding_token_amount_by_address<T0>(arg0: &PointTokenMarket<T0>, arg1: address) : u64 {
        if (!0x2::table::contains<address, u64>(&arg0.holdings, arg1)) {
            0
        } else {
            *0x2::table::borrow<address, u64>(&arg0.holdings, arg1)
        }
    }

    public(friend) fun increase_holding_by_token_amount<T0>(arg0: &mut PointTokenMarket<T0>, arg1: address, arg2: u64) {
        let v0 = holding_token_amount_by_address<T0>(arg0, arg1);
        let v1 = 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::point_math::checked_add(v0, arg2);
        if (0x2::table::contains<address, u64>(&arg0.holdings, arg1)) {
            *0x2::table::borrow_mut<address, u64>(&mut arg0.holdings, arg1) = v1;
        } else {
            0x2::table::add<address, u64>(&mut arg0.holdings, arg1, v1);
        };
        0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::event::emit_token_holding_updated(0x2::object::id<PointTokenMarket<T0>>(arg0), arg0.project_id, arg1, true, arg2, arg2 / arg0.scale, v0, v1);
    }

    public(friend) fun internal_borrow_mut_treasury_cap<T0>(arg0: &mut PointTokenMarket<T0>) : &mut 0x2::coin::TreasuryCap<T0> {
        &mut arg0.treasury_cap
    }

    public(friend) fun internal_mint_token<T0>(arg0: &mut PointTokenMarket<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::token::from_coin<T0>(0x2::coin::mint<T0>(&mut arg0.treasury_cap, arg1, arg2), arg2);
        let (_, _, _, _) = 0x2::token::confirm_with_treasury_cap<T0>(&mut arg0.treasury_cap, v1, arg2);
        let v6 = 0x2::tx_context::sender(arg2);
        transfer_token_to<T0>(arg0, v0, v6, arg2);
    }

    public fun merge_token<T0>(arg0: &0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::GlobalConfig, arg1: 0x2::token::Token<T0>, arg2: 0x2::token::Token<T0>) : 0x2::token::Token<T0> {
        0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::package_version::assert_domain_enabled(arg0, 0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::token_domain());
        0x2::token::join<T0>(&mut arg1, arg2);
        arg1
    }

    public fun point_token_market_id<T0>(arg0: &PointTokenMarket<T0>) : 0x2::object::ID {
        0x2::object::id<PointTokenMarket<T0>>(arg0)
    }

    public fun point_token_market_project_id<T0>(arg0: &PointTokenMarket<T0>) : 0x2::object::ID {
        arg0.project_id
    }

    public fun point_token_market_scale<T0>(arg0: &PointTokenMarket<T0>) : u64 {
        arg0.scale
    }

    public fun point_token_market_scoreboard_id<T0>(arg0: &PointTokenMarket<T0>) : 0x2::object::ID {
        arg0.scoreboard_id
    }

    public fun restore_score_from_tokens<T0>(arg0: &0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::GlobalConfig, arg1: &mut PointTokenMarket<T0>, arg2: &mut 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::scoreboard::Scoreboard, arg3: 0x2::token::Token<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::package_version::assert_domain_enabled(arg0, 0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::token_domain());
        assert_scoreboard_match<T0>(arg1, arg2);
        let v0 = 0x2::token::value<T0>(&arg3);
        let v1 = 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::point_math::token_amount_to_points_exact(v0, arg1.scale);
        decrease_holding_by_token_amount<T0>(arg1, 0x2::tx_context::sender(arg5), v0);
        0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::scoreboard::restore_tokenized_score(arg2, arg4, 0x2::tx_context::sender(arg5), v1);
        0x2::token::burn<T0>(&mut arg1.treasury_cap, arg3);
        0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::event::emit_tokenized_points_restored(0x2::object::id<PointTokenMarket<T0>>(arg1), 0x2::object::id<0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::scoreboard::Scoreboard>(arg2), arg1.project_id, 0x2::tx_context::sender(arg5), v0, v1);
    }

    public fun split_token<T0>(arg0: &0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::GlobalConfig, arg1: 0x2::token::Token<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (0x2::token::Token<T0>, 0x2::token::Token<T0>) {
        0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::package_version::assert_domain_enabled(arg0, 0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::token_domain());
        (arg1, 0x2::token::split<T0>(&mut arg1, arg2, arg3))
    }

    public fun transfer_token<T0>(arg0: &0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::GlobalConfig, arg1: &mut PointTokenMarket<T0>, arg2: 0x2::token::Token<T0>, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::package_version::assert_domain_enabled(arg0, 0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::token_domain());
        let v0 = 0x2::token::value<T0>(&arg2);
        decrease_holding_by_token_amount<T0>(arg1, 0x2::tx_context::sender(arg4), v0);
        increase_holding_by_token_amount<T0>(arg1, arg3, v0);
        let v1 = PointTokensTransferred{
            point_token_market_id : 0x2::object::id<PointTokenMarket<T0>>(arg1),
            sender                : 0x2::tx_context::sender(arg4),
            recipient             : arg3,
            token_amount          : v0,
        };
        0x2::event::emit<PointTokensTransferred>(v1);
        transfer_token_to<T0>(arg1, arg2, arg3, arg4);
    }

    public(friend) fun transfer_token_to<T0>(arg0: &mut PointTokenMarket<T0>, arg1: 0x2::token::Token<T0>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let (_, _, _, _) = 0x2::token::confirm_with_treasury_cap<T0>(&mut arg0.treasury_cap, 0x2::token::transfer<T0>(arg1, arg2, arg3), arg3);
    }

    // decompiled from Move bytecode v7
}

