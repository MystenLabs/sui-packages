module 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::marketing_adapter {
    struct MarketingPositionOpened has copy, drop {
        position_id: u64,
        user: address,
        market_id: u64,
        market_object_id: 0x2::object::ID,
        account_object_id: 0x2::object::ID,
        outcome: u8,
        total_yoso_in: u64,
        cash_principal: u64,
        credit_principal: u64,
        shares: u64,
        tier_bps: u64,
    }

    struct MarketingPositionClaimed has copy, drop {
        position_id: u64,
        user: address,
        payout: u64,
        cash_payout: u64,
        credit_payout: u64,
        credit_profit: u64,
        credit_principal: u64,
        new_profit_to_claim: u64,
    }

    struct MarketingPositionSold has copy, drop {
        position_id: u64,
        user: address,
        shares_in: u64,
        total_yoso_out: u64,
        cash_out: u64,
        credit_out: u64,
        credit_principal: u64,
        remaining_shares: u64,
        new_profit_to_claim: u64,
    }

    struct MarketingBuyRequestCreated has copy, drop {
        request_id: u64,
        user: address,
        market_id: u64,
        market_object_id: 0x2::object::ID,
        account_object_id: 0x2::object::ID,
        outcome: u8,
        maker_order_hash: vector<u8>,
        fill_amount: u64,
        cash_amount: u64,
        credit_amount: u64,
        max_total_yoso_in: u64,
        tier_bps: u64,
        expiry_ms: u64,
    }

    struct MarketingSellRequestCreated has copy, drop {
        request_id: u64,
        user: address,
        position_id: u64,
        market_id: u64,
        market_object_id: 0x2::object::ID,
        account_object_id: 0x2::object::ID,
        outcome: u8,
        maker_order_hash: vector<u8>,
        shares_in: u64,
        min_total_yoso_out: u64,
        expiry_ms: u64,
    }

    public fun assert_custody_account(arg0: &0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::marketing_ledger::MarketingLedger, arg1: &0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::trading_account::TradingAccount) {
        0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::trading_account::assert_owner_address(arg1, 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::marketing_ledger::custody(arg0));
    }

    fun assert_executor_and_guard(arg0: &0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::marketing_ledger::MarketingLedger, arg1: &0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::marketing_guard::MarketingGuard, arg2: &0x2::tx_context::TxContext) {
        0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::marketing_ledger::assert_executor(arg0, arg2);
        assert!(0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::marketing_guard::vault_id(arg1) == 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::marketing_ledger::id(arg0), 402);
    }

    public fun cancel_marketing_sell_request(arg0: &mut 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::marketing_ledger::MarketingLedger, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::marketing_ledger::cancel_sell_request(arg0, arg1, 0x2::tx_context::sender(arg2));
    }

    public fun cancel_taker_buy_credit_request(arg0: &mut 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::marketing_ledger::MarketingLedger, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD> {
        0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::marketing_ledger::cancel_buy_request(arg0, arg1, 0x2::tx_context::sender(arg2), arg2)
    }

    public fun claim_marketing_position(arg0: &mut 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::marketing_ledger::MarketingLedger, arg1: &mut 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::marketing_guard::MarketingGuard, arg2: &mut 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::trading_account::TradingAccount, arg3: &mut 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_market::CLOBMarket, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD> {
        assert!(0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::marketing_guard::vault_id(arg1) == 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::marketing_ledger::id(arg0), 402);
        let (v0, v1, v2, v3, v4, v5, v6, v7, _, _, v10) = 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::marketing_ledger::position_data(0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::marketing_ledger::prepare_claim(arg0, arg4, 0x2::tx_context::sender(arg5)));
        assert!(v1 == 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_market::market_id(arg3), 400);
        assert!(v2 == 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_market::id(arg3), 400);
        assert!(v3 == 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::trading_account::id(arg2), 400);
        assert!(0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_market::state(arg3) == 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::state_resolved(), 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::e_invalid_state());
        0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::trading_account::debit_outcome(arg2, v1, v2, v4, v5);
        let v11 = if (0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_market::winning_outcome(arg3) == 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::outcome_invalid()) {
            0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_market::claim_invalid_amount(arg3, v4, v5, arg5)
        } else if (0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_market::winning_outcome(arg3) == v4) {
            0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_market::redeem_amount(arg3, v4, v5, arg5)
        } else {
            0x2::coin::zero<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>(arg5)
        };
        let v12 = v11;
        let v13 = 0x2::coin::value<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>(&v12);
        let v14 = v6 + v7;
        let v15 = if (v14 == 0) {
            0
        } else {
            (((v13 as u128) * (v6 as u128) / (v14 as u128)) as u64)
        };
        let v16 = v13 - v15;
        let v17 = if (v16 > v7) {
            v16 - v7
        } else {
            0
        };
        let (_, v19, _, _, _, _, _, _, _) = 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::marketing_ledger::user_state_data(arg0, v0);
        0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::marketing_guard::record_settlement(arg1, v10, v0, v2, v7);
        let v27 = MarketingPositionClaimed{
            position_id         : arg4,
            user                : v0,
            payout              : v13,
            cash_payout         : v15,
            credit_payout       : v16,
            credit_profit       : v17,
            credit_principal    : v7,
            new_profit_to_claim : v19,
        };
        0x2::event::emit<MarketingPositionClaimed>(v27);
        0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::marketing_ledger::close_claimed_position(arg0, arg4, v12, v13, arg5)
    }

    public fun create_marketing_sell_request(arg0: &mut 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::marketing_ledger::MarketingLedger, arg1: &0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::trading_account::TradingAccount, arg2: &0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_market::CLOBMarket, arg3: u64, arg4: vector<u8>, arg5: u64, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) : u64 {
        assert_custody_account(arg0, arg1);
        assert!(0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_market::state(arg2) == 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::state_trading(), 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::e_invalid_state());
        let (v0, v1, v2, v3, v4, _, _, _, _, _, _) = 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::marketing_ledger::position_data(0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::marketing_ledger::position(arg0, arg3));
        assert!(v1 == 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_market::market_id(arg2), 400);
        assert!(v2 == 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_market::id(arg2), 400);
        assert!(v3 == 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::trading_account::id(arg1), 400);
        let v11 = 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::marketing_ledger::create_sell_request(arg0, 0x2::tx_context::sender(arg8), arg3, arg4, arg5, arg6, arg7);
        let v12 = MarketingSellRequestCreated{
            request_id         : v11,
            user               : v0,
            position_id        : arg3,
            market_id          : v1,
            market_object_id   : v2,
            account_object_id  : v3,
            outcome            : v4,
            maker_order_hash   : arg4,
            shares_in          : arg5,
            min_total_yoso_out : arg6,
            expiry_ms          : arg7,
        };
        0x2::event::emit<MarketingSellRequestCreated>(v12);
        v11
    }

    public fun create_taker_buy_credit_request(arg0: &mut 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::marketing_ledger::MarketingLedger, arg1: &0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::trading_account::TradingAccount, arg2: &0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_market::CLOBMarket, arg3: 0x2::coin::Coin<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>, arg4: vector<u8>, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_exchange::Signature, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : u64 {
        assert_custody_account(arg0, arg1);
        assert!(0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_market::state(arg2) == 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::state_trading(), 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::e_invalid_state());
        assert!(0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::marketing_ledger::is_authorized_creator(arg0, 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_market::creator(arg2)), 403);
        let v0 = 0x2::tx_context::sender(arg12);
        let v1 = 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_market::market_id(arg2);
        let v2 = 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_market::id(arg2);
        let v3 = 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::trading_account::id(arg1);
        let v4 = 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::outcome_yes();
        let v5 = 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::marketing_ledger::create_buy_request(arg0, v0, v1, v2, v3, v4, arg5, arg3, arg6, arg7, arg8, arg4, arg9, arg10, arg11);
        let v6 = MarketingBuyRequestCreated{
            request_id        : v5,
            user              : v0,
            market_id         : v1,
            market_object_id  : v2,
            account_object_id : v3,
            outcome           : v4,
            maker_order_hash  : arg4,
            fill_amount       : arg5,
            cash_amount       : arg7 - arg6,
            credit_amount     : arg6,
            max_total_yoso_in : arg7,
            tier_bps          : arg8,
            expiry_ms         : arg9,
        };
        0x2::event::emit<MarketingBuyRequestCreated>(v6);
        v5
    }

    public fun create_taker_buy_credit_request_for_outcome(arg0: &mut 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::marketing_ledger::MarketingLedger, arg1: &0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::trading_account::TradingAccount, arg2: &0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_market::CLOBMarket, arg3: u8, arg4: 0x2::coin::Coin<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>, arg5: vector<u8>, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_exchange::Signature, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) : u64 {
        0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::assert_binary_outcome(arg3);
        assert_custody_account(arg0, arg1);
        assert!(0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_market::state(arg2) == 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::state_trading(), 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::e_invalid_state());
        assert!(0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::marketing_ledger::is_authorized_creator(arg0, 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_market::creator(arg2)), 403);
        let v0 = 0x2::tx_context::sender(arg13);
        let v1 = 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_market::market_id(arg2);
        let v2 = 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_market::id(arg2);
        let v3 = 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::trading_account::id(arg1);
        let v4 = 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::marketing_ledger::create_buy_request(arg0, v0, v1, v2, v3, arg3, arg6, arg4, arg7, arg8, arg9, arg5, arg10, arg11, arg12);
        let v5 = MarketingBuyRequestCreated{
            request_id        : v4,
            user              : v0,
            market_id         : v1,
            market_object_id  : v2,
            account_object_id : v3,
            outcome           : arg3,
            maker_order_hash  : arg5,
            fill_amount       : arg6,
            cash_amount       : arg8 - arg7,
            credit_amount     : arg7,
            max_total_yoso_in : arg8,
            tier_bps          : arg9,
            expiry_ms         : arg10,
        };
        0x2::event::emit<MarketingBuyRequestCreated>(v5);
        v4
    }

    public fun execute_marketing_sell_request(arg0: &mut 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::marketing_ledger::MarketingLedger, arg1: &mut 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::marketing_guard::MarketingGuard, arg2: &mut 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_exchange::CLOBExchange, arg3: &mut 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::trading_account::TradingAccount, arg4: &mut 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::trading_account::TradingAccount, arg5: &0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_market::CLOBMarket, arg6: u64, arg7: vector<u8>, arg8: 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_exchange::Order, arg9: 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_exchange::Signature, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD> {
        assert_executor_and_guard(arg0, arg1, arg11);
        assert_custody_account(arg0, arg4);
        let v0 = 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::marketing_ledger::prepare_sell_execution(arg0, arg6, arg10);
        let (v1, v2, v3, v4, v5, v6, v7, v8, v9, _, _, _) = 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::marketing_ledger::sell_request_data(v0);
        assert!(v3 == 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_market::market_id(arg5), 400);
        assert!(v4 == 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_market::id(arg5), 400);
        assert!(v5 == 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::trading_account::id(arg4), 400);
        assert!(v9 == 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_exchange::order_hash(arg2, arg8), 401);
        assert!(0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_exchange::order_outcome(arg8) == v6, 401);
        assert!(0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_exchange::order_side(arg8) == 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::side_buy(), 401);
        let (v13, _, v15, _, _, v18, _, v20, _, _, v23) = 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::marketing_ledger::position_data(0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::marketing_ledger::position(arg0, v2));
        let v24 = principal_for_shares(v20, v7, v18);
        let v25 = 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_exchange::execute_marketing_sell_to_buy_order(arg2, arg3, arg4, arg5, 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::marketing_ledger::custody(arg0), arg7, arg8, arg9, v7, v8, 0x2::clock::timestamp_ms(arg10), arg11);
        let v26 = 0x2::coin::value<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>(&v25);
        let v27 = 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::marketing_ledger::apply_position_sale(arg0, v0, v26, v25, arg11);
        let v28 = 0x2::coin::value<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>(&v27);
        let (_, _, _, _, _, v34, _, _, _, _, _) = 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::marketing_ledger::position_data(0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::marketing_ledger::position(arg0, v2));
        let (_, v41, _, _, _, _, _, _, _) = 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::marketing_ledger::user_state_data(arg0, v13);
        0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::marketing_guard::record_settlement(arg1, v23, v1, v15, v24);
        let v49 = MarketingPositionSold{
            position_id         : v2,
            user                : v13,
            shares_in           : v7,
            total_yoso_out      : v26,
            cash_out            : v28,
            credit_out          : v26 - v28,
            credit_principal    : v24,
            remaining_shares    : v34,
            new_profit_to_claim : v41,
        };
        0x2::event::emit<MarketingPositionSold>(v49);
        v27
    }

    public fun execute_taker_buy_credit_request(arg0: &mut 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::marketing_ledger::MarketingLedger, arg1: &mut 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::marketing_guard::MarketingGuard, arg2: &mut 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_exchange::CLOBExchange, arg3: &mut 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::trading_account::TradingAccount, arg4: &mut 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::trading_account::TradingAccount, arg5: &0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_market::CLOBMarket, arg6: u64, arg7: vector<u8>, arg8: 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_exchange::Order, arg9: 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_exchange::Signature, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : u64 {
        assert_executor_and_guard(arg0, arg1, arg11);
        assert_custody_account(arg0, arg4);
        let (v0, v1, v2) = 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::marketing_ledger::prepare_buy_execution(arg0, arg6, arg10, arg11);
        let v3 = v2;
        let v4 = v1;
        let (v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, _, _, _) = 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::marketing_ledger::buy_request_data(v0);
        assert!(v6 == 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_market::market_id(arg5), 400);
        assert!(v7 == 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_market::id(arg5), 400);
        assert!(v8 == 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::trading_account::id(arg4), 400);
        assert!(0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::marketing_ledger::is_authorized_creator(arg0, 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_market::creator(arg5)), 403);
        assert!(v15 == 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_exchange::order_hash(arg2, arg8), 401);
        assert!(0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_exchange::order_outcome(arg8) == v9, 401);
        assert!(0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_exchange::order_side(arg8) == 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::side_sell(), 401);
        assert!(0x2::coin::value<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>(&v4) + 0x2::coin::value<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>(&v3) == v13, 404);
        0x2::coin::join<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>(&mut v4, v3);
        0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::marketing_guard::record_borrow(arg1, 0x2::tx_context::sender(arg11), v5, v7, v12, arg10);
        let (v19, v20, v21) = 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_exchange::execute_marketing_taker_buy_from_sell_order(arg2, arg3, arg4, arg5, 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::marketing_ledger::custody(arg0), arg7, arg8, arg9, v10, v4, 0x2::clock::timestamp_ms(arg10), arg11);
        let v22 = v21;
        let v23 = v19 + v20;
        assert!(v23 <= v13, 404);
        assert!(v23 >= v12, 404);
        let v24 = v23 - v12;
        assert!(v24 <= v11, 404);
        if (0x2::coin::value<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>(&v22) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>>(v22, v5);
        } else {
            0x2::coin::destroy_zero<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>(v22);
        };
        let v25 = 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::marketing_ledger::open_position(arg0, v5, v6, v7, v8, v9, v10, v24, v12, 0x2::tx_context::sender(arg11));
        let v26 = MarketingPositionOpened{
            position_id       : v25,
            user              : v5,
            market_id         : v6,
            market_object_id  : v7,
            account_object_id : v8,
            outcome           : v9,
            total_yoso_in     : v23,
            cash_principal    : v24,
            credit_principal  : v12,
            shares            : v10,
            tier_bps          : v14,
        };
        0x2::event::emit<MarketingPositionOpened>(v26);
        v25
    }

    fun principal_for_shares(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg1 > 0 && arg1 <= arg2, 404);
        if (arg1 == arg2) {
            arg0
        } else {
            (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
        }
    }

    // decompiled from Move bytecode v7
}

