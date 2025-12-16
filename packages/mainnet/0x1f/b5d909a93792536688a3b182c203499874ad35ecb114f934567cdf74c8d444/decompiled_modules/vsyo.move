module 0x1fb5d909a93792536688a3b182c203499874ad35ecb114f934567cdf74c8d444::vsyo {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Market has store, key {
        id: 0x2::object::UID,
        description: 0x1::string::String,
        deadline: u64,
        yes_shares_sold: u64,
        no_shares_sold: u64,
        total_funds: 0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>,
        resolved: bool,
        outcome: 0x1::option::Option<bool>,
    }

    struct Position has store, key {
        id: 0x2::object::UID,
        market_id: 0x2::object::ID,
        is_yes: bool,
        shares: u64,
        cost_basis: u64,
    }

    struct MarketCreated has copy, drop {
        market_id: 0x2::object::ID,
        description: 0x1::string::String,
        deadline: u64,
    }

    struct PositionBought has copy, drop {
        market_id: 0x2::object::ID,
        user: address,
        is_yes: bool,
        shares: u64,
        cost: u64,
    }

    struct MarketResolved has copy, drop {
        market_id: 0x2::object::ID,
        outcome: bool,
    }

    struct PositionSold has copy, drop {
        market_id: 0x2::object::ID,
        user: address,
        is_yes: bool,
        shares: u64,
        payout: u64,
    }

    struct WinningsClaimed has copy, drop {
        market_id: 0x2::object::ID,
        user: address,
        amount: u64,
    }

    public fun buy_no(arg0: &mut Market, arg1: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        buy_position(arg0, arg1, false, arg2, arg3, arg4);
    }

    fun buy_position(arg0: &mut Market, arg1: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg2: bool, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.resolved, 7);
        assert!(0x2::clock::timestamp_ms(arg4) < arg0.deadline, 2);
        assert!(arg3 > 0, 4);
        assert!(0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg1) >= arg3, 4);
        assert!(0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg0.total_funds) + arg3 >= arg0.yes_shares_sold + arg0.no_shares_sold + arg3, 9);
        let v0 = 0x2::coin::into_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg1);
        0x2::balance::join<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.total_funds, 0x2::balance::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut v0, arg3));
        if (0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&v0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(0x2::coin::from_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v0, arg5), 0x2::tx_context::sender(arg5));
        } else {
            0x2::balance::destroy_zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v0);
        };
        if (arg2) {
            arg0.yes_shares_sold = arg0.yes_shares_sold + arg3;
        } else {
            arg0.no_shares_sold = arg0.no_shares_sold + arg3;
        };
        let v1 = Position{
            id         : 0x2::object::new(arg5),
            market_id  : 0x2::object::uid_to_inner(&arg0.id),
            is_yes     : arg2,
            shares     : arg3,
            cost_basis : arg3,
        };
        let v2 = PositionBought{
            market_id : 0x2::object::uid_to_inner(&arg0.id),
            user      : 0x2::tx_context::sender(arg5),
            is_yes    : arg2,
            shares    : arg3,
            cost      : arg3,
        };
        0x2::event::emit<PositionBought>(v2);
        0x2::transfer::transfer<Position>(v1, 0x2::tx_context::sender(arg5));
    }

    public fun buy_yes(arg0: &mut Market, arg1: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        buy_position(arg0, arg1, true, arg2, arg3, arg4);
    }

    public fun claim_winnings(arg0: &mut Market, arg1: Position, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.resolved, 1);
        assert!(arg1.market_id == 0x2::object::uid_to_inner(&arg0.id), 6);
        assert!(0x1::option::is_some<bool>(&arg0.outcome), 1);
        let v0 = *0x1::option::borrow<bool>(&arg0.outcome);
        assert!(arg1.is_yes == v0, 5);
        if (v0) {
        };
        let v1 = 0x2::balance::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.total_funds, arg1.shares);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(0x2::coin::from_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v1, arg2), 0x2::tx_context::sender(arg2));
        let v2 = WinningsClaimed{
            market_id : arg1.market_id,
            user      : 0x2::tx_context::sender(arg2),
            amount    : 0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&v1),
        };
        0x2::event::emit<WinningsClaimed>(v2);
        let Position {
            id         : v3,
            market_id  : _,
            is_yes     : _,
            shares     : _,
            cost_basis : _,
        } = arg1;
        0x2::object::delete(v3);
    }

    public fun create_market(arg0: &AdminCap, arg1: 0x1::string::String, arg2: u64, arg3: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg3) > 0, 4);
        let v0 = Market{
            id              : 0x2::object::new(arg4),
            description     : arg1,
            deadline        : arg2,
            yes_shares_sold : 0,
            no_shares_sold  : 0,
            total_funds     : 0x2::coin::into_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg3),
            resolved        : false,
            outcome         : 0x1::option::none<bool>(),
        };
        let v1 = MarketCreated{
            market_id   : 0x2::object::uid_to_inner(&v0.id),
            description : v0.description,
            deadline    : v0.deadline,
        };
        0x2::event::emit<MarketCreated>(v1);
        0x2::transfer::share_object<Market>(v0);
    }

    public fun get_market_info(arg0: &Market) : (0x1::string::String, u64, bool, 0x1::option::Option<bool>) {
        (arg0.description, arg0.deadline, arg0.resolved, arg0.outcome)
    }

    public fun get_market_shares(arg0: &Market) : (u64, u64) {
        (arg0.yes_shares_sold, arg0.no_shares_sold)
    }

    public fun get_no_price(arg0: &Market) : u64 {
        10000 - get_yes_price(arg0)
    }

    public fun get_position_info(arg0: &Position) : (0x2::object::ID, bool, u64, u64) {
        (arg0.market_id, arg0.is_yes, arg0.shares, arg0.cost_basis)
    }

    public fun get_total_funds(arg0: &Market) : u64 {
        0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg0.total_funds)
    }

    public fun get_yes_price(arg0: &Market) : u64 {
        let v0 = arg0.yes_shares_sold + arg0.no_shares_sold;
        if (v0 == 0) {
            5000
        } else {
            arg0.yes_shares_sold * 10000 / v0
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun resolve_market(arg0: &AdminCap, arg1: &mut Market, arg2: bool, arg3: &0x2::clock::Clock) {
        assert!(!arg1.resolved, 7);
        assert!(0x2::clock::timestamp_ms(arg3) >= arg1.deadline, 3);
        arg1.resolved = true;
        arg1.outcome = 0x1::option::some<bool>(arg2);
        let v0 = MarketResolved{
            market_id : 0x2::object::uid_to_inner(&arg1.id),
            outcome   : arg2,
        };
        0x2::event::emit<MarketResolved>(v0);
    }

    public fun sell_partial(arg0: &mut Market, arg1: &mut Position, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.resolved, 7);
        assert!(0x2::clock::timestamp_ms(arg3) < arg0.deadline, 2);
        assert!(arg1.market_id == 0x2::object::uid_to_inner(&arg0.id), 6);
        assert!(arg2 > 0 && arg2 <= arg1.shares, 8);
        let v0 = arg1.is_yes;
        assert!(0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg0.total_funds) >= arg2, 9);
        if (v0) {
            arg0.yes_shares_sold = arg0.yes_shares_sold - arg2;
        } else {
            arg0.no_shares_sold = arg0.no_shares_sold - arg2;
        };
        arg1.shares = arg1.shares - arg2;
        0x2::transfer::public_transfer<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(0x2::coin::from_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0x2::balance::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.total_funds, arg2), arg4), 0x2::tx_context::sender(arg4));
        let v1 = PositionSold{
            market_id : arg1.market_id,
            user      : 0x2::tx_context::sender(arg4),
            is_yes    : v0,
            shares    : arg2,
            payout    : arg2,
        };
        0x2::event::emit<PositionSold>(v1);
    }

    public fun sell_position(arg0: &mut Market, arg1: Position, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.resolved, 7);
        assert!(0x2::clock::timestamp_ms(arg2) < arg0.deadline, 2);
        assert!(arg1.market_id == 0x2::object::uid_to_inner(&arg0.id), 6);
        let v0 = arg1.shares;
        let v1 = arg1.is_yes;
        assert!(0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg0.total_funds) >= v0, 9);
        if (v1) {
            arg0.yes_shares_sold = arg0.yes_shares_sold - v0;
        } else {
            arg0.no_shares_sold = arg0.no_shares_sold - v0;
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(0x2::coin::from_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0x2::balance::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.total_funds, v0), arg3), 0x2::tx_context::sender(arg3));
        let v2 = PositionSold{
            market_id : arg1.market_id,
            user      : 0x2::tx_context::sender(arg3),
            is_yes    : v1,
            shares    : v0,
            payout    : v0,
        };
        0x2::event::emit<PositionSold>(v2);
        let Position {
            id         : v3,
            market_id  : _,
            is_yes     : _,
            shares     : _,
            cost_basis : _,
        } = arg1;
        0x2::object::delete(v3);
    }

    // decompiled from Move bytecode v6
}

