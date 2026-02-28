module 0xd8dde43392dc9fc320e4bc43c5e2ebbf0ebfc1ebb819b3e8356e1404da5528dc::taco_strategy_fund {
    struct StrategyFund<phantom T0> has key {
        id: 0x2::object::UID,
        manager: address,
        pair_id: address,
        idle_balance: 0x2::balance::Balance<T0>,
        total_shares: u256,
        investor_shares: 0x2::table::Table<address, u256>,
        positions: 0x2::object_table::ObjectTable<address, 0xd8dde43392dc9fc320e4bc43c5e2ebbf0ebfc1ebb819b3e8356e1404da5528dc::trading_pair::Position<T0>>,
        tracked_position_ids: vector<address>,
    }

    struct StrategyFundManagerCap has key {
        id: 0x2::object::UID,
        fund_id: address,
    }

    struct SharesDeposited has copy, drop {
        user: address,
        amount: u256,
        shares_minted: u256,
        share_price: u256,
    }

    struct SharesWithdrawn has copy, drop {
        user: address,
        shares_burned: u256,
        amount_out: u256,
        share_price: u256,
    }

    struct StrategyPositionOpened has copy, drop {
        position_key: address,
        collateral: u256,
        leverage: u256,
        is_long: bool,
    }

    struct StrategyPositionSettled has copy, drop {
        position_key: address,
        payout: u256,
    }

    struct StrategyLiquidationExecuted has copy, drop {
        target_position_id: u256,
        returned_amount: u256,
    }

    fun add_investor_shares(arg0: &mut 0x2::table::Table<address, u256>, arg1: address, arg2: u256) {
        if (0x2::table::contains<address, u256>(arg0, arg1)) {
            let v0 = 0x2::table::borrow_mut<address, u256>(arg0, arg1);
            *v0 = *v0 + arg2;
        } else {
            0x2::table::add<address, u256>(arg0, arg1, arg2);
        };
    }

    fun assert_manager<T0>(arg0: &StrategyFund<T0>, arg1: &StrategyFundManagerCap) {
        assert!(0x2::object::id_address<StrategyFund<T0>>(arg0) == arg1.fund_id, 17001);
    }

    fun assert_pair_matches<T0>(arg0: &StrategyFund<T0>, arg1: &0xd8dde43392dc9fc320e4bc43c5e2ebbf0ebfc1ebb819b3e8356e1404da5528dc::trading_pair::TradingPair<T0>) {
        assert!(0x2::object::id_address<0xd8dde43392dc9fc320e4bc43c5e2ebbf0ebfc1ebb819b3e8356e1404da5528dc::trading_pair::TradingPair<T0>>(arg1) == arg0.pair_id, 17002);
    }

    fun calculate_minted_shares(arg0: u256, arg1: u256, arg2: u256) : u256 {
        if (arg2 == 0 || arg1 == 0) {
            return arg0 * 1000000000000000000
        };
        arg0 * arg2 / arg1
    }

    fun calculate_withdraw_amount(arg0: u256, arg1: u256, arg2: u256) : u256 {
        assert!(arg2 > 0, 17007);
        arg0 * arg1 / arg2
    }

    public fun close_position<T0>(arg0: &mut StrategyFund<T0>, arg1: &StrategyFundManagerCap, arg2: &mut 0xd8dde43392dc9fc320e4bc43c5e2ebbf0ebfc1ebb819b3e8356e1404da5528dc::trading_pair::TradingPair<T0>, arg3: address, arg4: &0xd8dde43392dc9fc320e4bc43c5e2ebbf0ebfc1ebb819b3e8356e1404da5528dc::p2_oracle::Oracle, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert_manager<T0>(arg0, arg1);
        assert_pair_matches<T0>(arg0, arg2);
        assert!(0x2::object_table::contains<address, 0xd8dde43392dc9fc320e4bc43c5e2ebbf0ebfc1ebb819b3e8356e1404da5528dc::trading_pair::Position<T0>>(&arg0.positions, arg3), 17005);
        let v0 = 0x2::object_table::borrow<address, 0xd8dde43392dc9fc320e4bc43c5e2ebbf0ebfc1ebb819b3e8356e1404da5528dc::trading_pair::Position<T0>>(&arg0.positions, arg3);
        0x2::balance::join<T0>(&mut arg0.idle_balance, 0x2::coin::into_balance<T0>(0xd8dde43392dc9fc320e4bc43c5e2ebbf0ebfc1ebb819b3e8356e1404da5528dc::trading_pair::close_position_ptb<T0>(arg2, v0, arg4, arg5, arg6)));
        let v1 = 0xd8dde43392dc9fc320e4bc43c5e2ebbf0ebfc1ebb819b3e8356e1404da5528dc::trading_pair::claim_position_balance_ptb<T0>(arg2, v0, arg6);
        0x2::balance::join<T0>(&mut arg0.idle_balance, 0x2::coin::into_balance<T0>(v1));
        let v2 = &mut arg0.tracked_position_ids;
        remove_position_key(v2, arg3);
        0xd8dde43392dc9fc320e4bc43c5e2ebbf0ebfc1ebb819b3e8356e1404da5528dc::trading_pair::destroy_position_if_settled<T0>(arg2, 0x2::object_table::remove<address, 0xd8dde43392dc9fc320e4bc43c5e2ebbf0ebfc1ebb819b3e8356e1404da5528dc::trading_pair::Position<T0>>(&mut arg0.positions, arg3));
        let v3 = StrategyPositionSettled{
            position_key : arg3,
            payout       : (0x2::coin::value<T0>(&v1) as u256),
        };
        0x2::event::emit<StrategyPositionSettled>(v3);
    }

    public fun create_strategy_fund<T0>(arg0: &0xd8dde43392dc9fc320e4bc43c5e2ebbf0ebfc1ebb819b3e8356e1404da5528dc::trading_pair::TradingPair<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = StrategyFund<T0>{
            id                   : 0x2::object::new(arg1),
            manager              : 0x2::tx_context::sender(arg1),
            pair_id              : 0x2::object::id_address<0xd8dde43392dc9fc320e4bc43c5e2ebbf0ebfc1ebb819b3e8356e1404da5528dc::trading_pair::TradingPair<T0>>(arg0),
            idle_balance         : 0x2::balance::zero<T0>(),
            total_shares         : 0,
            investor_shares      : 0x2::table::new<address, u256>(arg1),
            positions            : 0x2::object_table::new<address, 0xd8dde43392dc9fc320e4bc43c5e2ebbf0ebfc1ebb819b3e8356e1404da5528dc::trading_pair::Position<T0>>(arg1),
            tracked_position_ids : 0x1::vector::empty<address>(),
        };
        let v1 = StrategyFundManagerCap{
            id      : 0x2::object::new(arg1),
            fund_id : 0x2::object::id_address<StrategyFund<T0>>(&v0),
        };
        0x2::transfer::transfer<StrategyFundManagerCap>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<StrategyFund<T0>>(v0);
    }

    public fun deposit<T0>(arg0: &mut StrategyFund<T0>, arg1: &0xd8dde43392dc9fc320e4bc43c5e2ebbf0ebfc1ebb819b3e8356e1404da5528dc::trading_pair::TradingPair<T0>, arg2: &0xd8dde43392dc9fc320e4bc43c5e2ebbf0ebfc1ebb819b3e8356e1404da5528dc::p2_oracle::Oracle, arg3: &0x2::clock::Clock, arg4: 0x2::coin::Coin<T0>, arg5: &mut 0x2::tx_context::TxContext) : u256 {
        assert_pair_matches<T0>(arg0, arg1);
        let v0 = (0x2::coin::value<T0>(&arg4) as u256);
        let v1 = calculate_minted_shares(v0, total_assets<T0>(arg0, arg1, arg2, arg3), arg0.total_shares);
        0x2::balance::join<T0>(&mut arg0.idle_balance, 0x2::coin::into_balance<T0>(arg4));
        arg0.total_shares = arg0.total_shares + v1;
        let v2 = &mut arg0.investor_shares;
        add_investor_shares(v2, 0x2::tx_context::sender(arg5), v1);
        let v3 = SharesDeposited{
            user          : 0x2::tx_context::sender(arg5),
            amount        : v0,
            shares_minted : v1,
            share_price   : share_price<T0>(arg0, arg1, arg2, arg3),
        };
        0x2::event::emit<SharesDeposited>(v3);
        v1
    }

    public fun idle_balance<T0>(arg0: &StrategyFund<T0>) : u256 {
        (0x2::balance::value<T0>(&arg0.idle_balance) as u256)
    }

    public fun investor_shares<T0>(arg0: &StrategyFund<T0>, arg1: address) : u256 {
        if (!0x2::table::contains<address, u256>(&arg0.investor_shares, arg1)) {
            return 0
        };
        *0x2::table::borrow<address, u256>(&arg0.investor_shares, arg1)
    }

    public fun liquidate_position<T0>(arg0: &mut StrategyFund<T0>, arg1: &StrategyFundManagerCap, arg2: &mut 0xd8dde43392dc9fc320e4bc43c5e2ebbf0ebfc1ebb819b3e8356e1404da5528dc::trading_pair::TradingPair<T0>, arg3: u256, arg4: u64, arg5: &0xd8dde43392dc9fc320e4bc43c5e2ebbf0ebfc1ebb819b3e8356e1404da5528dc::p2_oracle::Oracle, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert_manager<T0>(arg0, arg1);
        assert_pair_matches<T0>(arg0, arg2);
        let v0 = 0xd8dde43392dc9fc320e4bc43c5e2ebbf0ebfc1ebb819b3e8356e1404da5528dc::trading_pair::liquidate_position_ptb<T0>(arg2, arg3, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.idle_balance, arg4), arg7), arg5, arg6, arg7);
        0x2::balance::join<T0>(&mut arg0.idle_balance, 0x2::coin::into_balance<T0>(v0));
        let v1 = StrategyLiquidationExecuted{
            target_position_id : arg3,
            returned_amount    : (0x2::coin::value<T0>(&v0) as u256),
        };
        0x2::event::emit<StrategyLiquidationExecuted>(v1);
    }

    public fun open_position<T0>(arg0: &mut StrategyFund<T0>, arg1: &StrategyFundManagerCap, arg2: &mut 0xd8dde43392dc9fc320e4bc43c5e2ebbf0ebfc1ebb819b3e8356e1404da5528dc::trading_pair::TradingPair<T0>, arg3: u64, arg4: u256, arg5: bool, arg6: &0xd8dde43392dc9fc320e4bc43c5e2ebbf0ebfc1ebb819b3e8356e1404da5528dc::p2_oracle::Oracle, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : address {
        assert_manager<T0>(arg0, arg1);
        assert_pair_matches<T0>(arg0, arg2);
        let v0 = 0xd8dde43392dc9fc320e4bc43c5e2ebbf0ebfc1ebb819b3e8356e1404da5528dc::trading_pair::open_position_ptb_on_behalf_of<T0>(arg2, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.idle_balance, arg3), arg8), arg4, arg5, 0x2::object::id_address<StrategyFund<T0>>(arg0), arg6, arg7, arg8);
        let v1 = 0x2::object::id_address<0xd8dde43392dc9fc320e4bc43c5e2ebbf0ebfc1ebb819b3e8356e1404da5528dc::trading_pair::Position<T0>>(&v0);
        0x2::object_table::add<address, 0xd8dde43392dc9fc320e4bc43c5e2ebbf0ebfc1ebb819b3e8356e1404da5528dc::trading_pair::Position<T0>>(&mut arg0.positions, v1, v0);
        0x1::vector::push_back<address>(&mut arg0.tracked_position_ids, v1);
        let v2 = StrategyPositionOpened{
            position_key : v1,
            collateral   : (arg3 as u256),
            leverage     : arg4,
            is_long      : arg5,
        };
        0x2::event::emit<StrategyPositionOpened>(v2);
        v1
    }

    fun remove_position_key(arg0: &mut vector<address>, arg1: address) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(arg0)) {
            if (*0x1::vector::borrow<address>(arg0, v0) == arg1) {
                0x1::vector::remove<address>(arg0, v0);
                return
            };
            v0 = v0 + 1;
        };
        abort 17005
    }

    public fun settle_position<T0>(arg0: &mut StrategyFund<T0>, arg1: &StrategyFundManagerCap, arg2: &mut 0xd8dde43392dc9fc320e4bc43c5e2ebbf0ebfc1ebb819b3e8356e1404da5528dc::trading_pair::TradingPair<T0>, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert_manager<T0>(arg0, arg1);
        assert_pair_matches<T0>(arg0, arg2);
        assert!(0x2::object_table::contains<address, 0xd8dde43392dc9fc320e4bc43c5e2ebbf0ebfc1ebb819b3e8356e1404da5528dc::trading_pair::Position<T0>>(&arg0.positions, arg3), 17005);
        let v0 = 0x2::object_table::borrow<address, 0xd8dde43392dc9fc320e4bc43c5e2ebbf0ebfc1ebb819b3e8356e1404da5528dc::trading_pair::Position<T0>>(&arg0.positions, arg3);
        assert!(!0xd8dde43392dc9fc320e4bc43c5e2ebbf0ebfc1ebb819b3e8356e1404da5528dc::trading_pair::position_is_active<T0>(arg2, v0), 17006);
        let v1 = 0xd8dde43392dc9fc320e4bc43c5e2ebbf0ebfc1ebb819b3e8356e1404da5528dc::trading_pair::claim_position_balance_ptb<T0>(arg2, v0, arg4);
        0x2::balance::join<T0>(&mut arg0.idle_balance, 0x2::coin::into_balance<T0>(v1));
        let v2 = &mut arg0.tracked_position_ids;
        remove_position_key(v2, arg3);
        0xd8dde43392dc9fc320e4bc43c5e2ebbf0ebfc1ebb819b3e8356e1404da5528dc::trading_pair::destroy_position_if_settled<T0>(arg2, 0x2::object_table::remove<address, 0xd8dde43392dc9fc320e4bc43c5e2ebbf0ebfc1ebb819b3e8356e1404da5528dc::trading_pair::Position<T0>>(&mut arg0.positions, arg3));
        let v3 = StrategyPositionSettled{
            position_key : arg3,
            payout       : (0x2::coin::value<T0>(&v1) as u256),
        };
        0x2::event::emit<StrategyPositionSettled>(v3);
    }

    public fun share_price<T0>(arg0: &StrategyFund<T0>, arg1: &0xd8dde43392dc9fc320e4bc43c5e2ebbf0ebfc1ebb819b3e8356e1404da5528dc::trading_pair::TradingPair<T0>, arg2: &0xd8dde43392dc9fc320e4bc43c5e2ebbf0ebfc1ebb819b3e8356e1404da5528dc::p2_oracle::Oracle, arg3: &0x2::clock::Clock) : u256 {
        if (arg0.total_shares == 0) {
            return 1000000000000000000
        };
        total_assets<T0>(arg0, arg1, arg2, arg3) * 1000000000000000000 / arg0.total_shares
    }

    fun sub_investor_shares(arg0: &mut 0x2::table::Table<address, u256>, arg1: address, arg2: u256) {
        let v0 = 0x2::table::borrow_mut<address, u256>(arg0, arg1);
        assert!(*v0 >= arg2, 17003);
        *v0 = *v0 - arg2;
    }

    fun to_u64(arg0: u256) : u64 {
        assert!(arg0 <= 18446744073709551615, 17008);
        (arg0 as u64)
    }

    public fun total_assets<T0>(arg0: &StrategyFund<T0>, arg1: &0xd8dde43392dc9fc320e4bc43c5e2ebbf0ebfc1ebb819b3e8356e1404da5528dc::trading_pair::TradingPair<T0>, arg2: &0xd8dde43392dc9fc320e4bc43c5e2ebbf0ebfc1ebb819b3e8356e1404da5528dc::p2_oracle::Oracle, arg3: &0x2::clock::Clock) : u256 {
        assert_pair_matches<T0>(arg0, arg1);
        let v0 = 0xd8dde43392dc9fc320e4bc43c5e2ebbf0ebfc1ebb819b3e8356e1404da5528dc::p2_oracle::get_current_price(arg2, 0xd8dde43392dc9fc320e4bc43c5e2ebbf0ebfc1ebb819b3e8356e1404da5528dc::trading_pair::pair_oracle_asset_id<T0>(arg1), arg3);
        let v1 = (0x2::balance::value<T0>(&arg0.idle_balance) as u256);
        let v2 = 0;
        while (v2 < 0x1::vector::length<address>(&arg0.tracked_position_ids)) {
            let v3 = *0x1::vector::borrow<address>(&arg0.tracked_position_ids, v2);
            if (0x2::object_table::contains<address, 0xd8dde43392dc9fc320e4bc43c5e2ebbf0ebfc1ebb819b3e8356e1404da5528dc::trading_pair::Position<T0>>(&arg0.positions, v3)) {
                let v4 = 0x2::object_table::borrow<address, 0xd8dde43392dc9fc320e4bc43c5e2ebbf0ebfc1ebb819b3e8356e1404da5528dc::trading_pair::Position<T0>>(&arg0.positions, v3);
                let v5 = if (0xd8dde43392dc9fc320e4bc43c5e2ebbf0ebfc1ebb819b3e8356e1404da5528dc::trading_pair::position_is_active<T0>(arg1, v4)) {
                    0xd8dde43392dc9fc320e4bc43c5e2ebbf0ebfc1ebb819b3e8356e1404da5528dc::trading_pair::calculate_position_value<T0>(arg1, v4, v0, 0xd8dde43392dc9fc320e4bc43c5e2ebbf0ebfc1ebb819b3e8356e1404da5528dc::trading_pair::compute_psi<T0>(arg1, v0))
                } else {
                    0xd8dde43392dc9fc320e4bc43c5e2ebbf0ebfc1ebb819b3e8356e1404da5528dc::trading_pair::position_claimable_balance<T0>(arg1, v4)
                };
                v1 = v1 + v5;
            };
            v2 = v2 + 1;
        };
        v1
    }

    public fun total_shares<T0>(arg0: &StrategyFund<T0>) : u256 {
        arg0.total_shares
    }

    public fun withdraw<T0>(arg0: &mut StrategyFund<T0>, arg1: u256, arg2: &0xd8dde43392dc9fc320e4bc43c5e2ebbf0ebfc1ebb819b3e8356e1404da5528dc::trading_pair::TradingPair<T0>, arg3: &0xd8dde43392dc9fc320e4bc43c5e2ebbf0ebfc1ebb819b3e8356e1404da5528dc::p2_oracle::Oracle, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_pair_matches<T0>(arg0, arg2);
        assert!(arg1 > 0, 17007);
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(investor_shares<T0>(arg0, v0) >= arg1, 17003);
        let v1 = calculate_withdraw_amount(arg1, total_assets<T0>(arg0, arg2, arg3, arg4), arg0.total_shares);
        assert!((0x2::balance::value<T0>(&arg0.idle_balance) as u256) >= v1, 17004);
        let v2 = &mut arg0.investor_shares;
        sub_investor_shares(v2, v0, arg1);
        arg0.total_shares = arg0.total_shares - arg1;
        let v3 = if (arg0.total_shares == 0) {
            1000000000000000000
        } else {
            share_price<T0>(arg0, arg2, arg3, arg4)
        };
        let v4 = SharesWithdrawn{
            user          : v0,
            shares_burned : arg1,
            amount_out    : v1,
            share_price   : v3,
        };
        0x2::event::emit<SharesWithdrawn>(v4);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.idle_balance, to_u64(v1)), arg5)
    }

    // decompiled from Move bytecode v6
}

