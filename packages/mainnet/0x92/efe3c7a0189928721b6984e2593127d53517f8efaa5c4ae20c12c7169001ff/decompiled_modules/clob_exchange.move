module 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_exchange {
    struct Order has copy, drop, store {
        trader: address,
        market_id: u64,
        market_object_id: 0x2::object::ID,
        account_object_id: 0x2::object::ID,
        side: u8,
        outcome: u8,
        price: u64,
        size: u64,
        expiration_ms: u64,
        nonce: u64,
        max_fee_bps: u64,
    }

    struct Signature has copy, drop, store {
        scheme: u8,
        public_key: vector<u8>,
        signature: vector<u8>,
    }

    struct OrderEnvelope has copy, drop, store {
        domain: vector<u8>,
        exchange_id: 0x2::object::ID,
        order: Order,
    }

    struct SignedFill has copy, drop, store {
        fill_id: vector<u8>,
        maker_order: Order,
        taker_order: Order,
        maker_signature: Signature,
        taker_signature: Signature,
        fill_amount: u64,
    }

    struct CLOBExchange has key {
        id: 0x2::object::UID,
        version: u64,
        admin: address,
        operator: address,
        fee_recipient: address,
        fee_bps: u64,
        paused: bool,
        fee_vault: 0x2::balance::Balance<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>,
        filled_amount: 0x2::table::Table<vector<u8>, u64>,
        cancelled: 0x2::table::Table<vector<u8>, bool>,
        min_nonce: 0x2::table::Table<address, u64>,
        settled_fills: 0x2::table::Table<vector<u8>, bool>,
        fee_remainder: 0x2::table::Table<vector<u8>, u64>,
    }

    struct CLOBExchangeCreated has copy, drop {
        exchange_id: 0x2::object::ID,
        admin: address,
        operator: address,
        fee_recipient: address,
        fee_bps: u64,
    }

    struct OrderFilled has copy, drop {
        fill_id: vector<u8>,
        maker_order_hash: vector<u8>,
        taker_order_hash: vector<u8>,
        maker: address,
        taker: address,
        market_id: u64,
        outcome: u8,
        maker_side: u8,
        fill_amount: u64,
        collateral_amount: u64,
        fee: u64,
    }

    struct SettlementBatchExecuted has copy, drop {
        batch_size: u64,
        market_id: u64,
    }

    struct OrderCancelled has copy, drop {
        order_hash: vector<u8>,
        trader: address,
    }

    struct MinNonceUpdated has copy, drop {
        trader: address,
        old_min_nonce: u64,
        new_min_nonce: u64,
    }

    struct FeeUpdated has copy, drop {
        old_fee_bps: u64,
        new_fee_bps: u64,
    }

    struct FeeRecipientUpdated has copy, drop {
        old_fee_recipient: address,
        new_fee_recipient: address,
    }

    struct FeesWithdrawn has copy, drop {
        recipient: address,
        amount: u64,
    }

    struct OperatorUpdated has copy, drop {
        old_operator: address,
        new_operator: address,
    }

    struct ExchangePaused has copy, drop {
        paused: bool,
    }

    fun add_filled(arg0: &mut CLOBExchange, arg1: vector<u8>, arg2: u64) {
        if (0x2::table::contains<vector<u8>, u64>(&arg0.filled_amount, arg1)) {
            *0x2::table::borrow_mut<vector<u8>, u64>(&mut arg0.filled_amount, arg1) = filled_amount(arg0, arg1) + arg2;
        } else {
            0x2::table::add<vector<u8>, u64>(&mut arg0.filled_amount, arg1, arg2);
        };
    }

    public fun admin(arg0: &CLOBExchange) : address {
        assert_version(arg0);
        arg0.admin
    }

    fun append_hex_lower(arg0: &mut vector<u8>, arg1: vector<u8>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u8>(&arg1)) {
            let v1 = *0x1::vector::borrow<u8>(&arg1, v0);
            0x1::vector::push_back<u8>(arg0, hex_char(v1 / 16));
            0x1::vector::push_back<u8>(arg0, hex_char(v1 % 16));
            v0 = v0 + 1;
        };
    }

    fun append_uleb128(arg0: &mut vector<u8>, arg1: u64) {
        while (arg1 >= 128) {
            0x1::vector::push_back<u8>(arg0, ((arg1 % 128) as u8) + 128);
            arg1 = arg1 / 128;
        };
        0x1::vector::push_back<u8>(arg0, (arg1 as u8));
    }

    fun apply_fill(arg0: &mut CLOBExchange, arg1: &mut 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::trading_account::TradingAccount, arg2: &mut 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::trading_account::TradingAccount, arg3: Order, arg4: Order, arg5: u64, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        if (arg3.side == 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::side_sell()) {
            0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::trading_account::debit_outcome(arg1, arg3.market_id, arg3.market_object_id, arg3.outcome, arg5);
            0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::trading_account::credit_outcome(arg2, arg3.market_id, arg3.market_object_id, arg3.outcome, arg5);
            let v0 = 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::trading_account::debit_yoso(arg2, arg6 + arg7, arg8);
            let v1 = if (arg7 == 0) {
                0x2::coin::zero<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>(arg8)
            } else {
                0x2::coin::split<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>(&mut v0, arg7, arg8)
            };
            0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::trading_account::credit_yoso(arg1, v0);
            credit_fee(arg0, v1);
        } else {
            let v2 = 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::trading_account::debit_yoso(arg1, arg6, arg8);
            let v3 = if (arg7 == 0) {
                0x2::coin::zero<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>(arg8)
            } else {
                0x2::coin::split<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>(&mut v2, arg7, arg8)
            };
            0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::trading_account::credit_outcome(arg1, arg3.market_id, arg3.market_object_id, arg3.outcome, arg5);
            0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::trading_account::debit_outcome(arg2, arg3.market_id, arg3.market_object_id, arg3.outcome, arg5);
            0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::trading_account::credit_yoso(arg2, v2);
            credit_fee(arg0, v3);
        };
    }

    fun assert_admin(arg0: &CLOBExchange, arg1: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::e_not_authorized());
    }

    fun assert_crossed(arg0: Order, arg1: Order) {
        if (arg0.side == 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::side_sell()) {
            assert!(arg1.side == 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::side_buy(), 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::e_invalid_side());
            assert!(arg1.price >= arg0.price, 102);
        } else {
            assert!(arg0.side == 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::side_buy(), 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::e_invalid_side());
            assert!(arg1.side == 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::side_sell(), 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::e_invalid_side());
            assert!(arg0.price >= arg1.price, 102);
        };
    }

    fun assert_operator(arg0: &CLOBExchange, arg1: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert!(0x2::tx_context::sender(arg1) == arg0.operator, 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::e_not_authorized());
    }

    fun assert_version(arg0: &CLOBExchange) {
        assert!(arg0.version == 1, 105);
    }

    public fun cancel_order(arg0: &mut CLOBExchange, arg1: Order, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg1.trader, 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::e_not_authorized());
        let v0 = order_hash(arg0, arg1);
        set_cancelled(arg0, v0, true);
        let v1 = OrderCancelled{
            order_hash : v0,
            trader     : arg1.trader,
        };
        0x2::event::emit<OrderCancelled>(v1);
    }

    public(friend) fun cancel_order_hash(arg0: &mut CLOBExchange, arg1: vector<u8>, arg2: &0x2::tx_context::TxContext) {
        set_cancelled(arg0, arg1, true);
        let v0 = OrderCancelled{
            order_hash : arg1,
            trader     : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<OrderCancelled>(v0);
    }

    fun credit_fee(arg0: &mut CLOBExchange, arg1: 0x2::coin::Coin<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>) {
        if (0x2::coin::value<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>(&arg1) == 0) {
            0x2::coin::destroy_zero<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>(arg1);
        } else {
            0x2::balance::join<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>(&mut arg0.fee_vault, 0x2::coin::into_balance<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>(arg1));
        };
    }

    public(friend) fun execute_marketing_sell_to_buy_order(arg0: &mut CLOBExchange, arg1: &mut 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::trading_account::TradingAccount, arg2: &mut 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::trading_account::TradingAccount, arg3: &0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_market::CLOBMarket, arg4: address, arg5: vector<u8>, arg6: Order, arg7: Signature, arg8: u64, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD> {
        assert_operator(arg0, arg11);
        assert!(!arg0.paused, 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::e_invalid_state());
        assert!(0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_market::state(arg3) == 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::state_trading(), 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::e_invalid_state());
        assert!(arg8 > 0, 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::e_zero_amount());
        assert!(!is_fill_settled(arg0, arg5), 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::e_fill_already_settled());
        assert!(arg6.side == 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::side_buy(), 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::e_invalid_side());
        assert!(arg6.market_id == 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_market::market_id(arg3), 100);
        assert!(arg6.market_object_id == 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_market::id(arg3), 100);
        assert!(arg6.account_object_id == 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::trading_account::id(arg1), 100);
        0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::trading_account::assert_owner_address(arg1, arg6.trader);
        0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::trading_account::assert_owner_address(arg2, arg4);
        let v0 = order_hash(arg0, arg6);
        verify_order_signature(arg0, arg6, arg7);
        validate_order_at(arg0, v0, arg6, arg8, arg10);
        let (v1, v2, v3) = 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::settlement_amounts_with_remainder(arg8, arg6.price, arg0.fee_bps, fee_remainder(arg0, v0));
        assert!(arg0.fee_bps <= arg6.max_fee_bps, 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::e_invalid_fee());
        assert!(v1 >= v2, 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::e_invalid_fee());
        assert!(v1 - v2 >= arg9, 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::e_invalid_price());
        let v4 = 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::trading_account::debit_yoso(arg1, v1, arg11);
        let v5 = if (v2 == 0) {
            0x2::coin::zero<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>(arg11)
        } else {
            0x2::coin::split<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>(&mut v4, v2, arg11)
        };
        0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::trading_account::debit_outcome(arg2, arg6.market_id, arg6.market_object_id, arg6.outcome, arg8);
        0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::trading_account::credit_outcome(arg1, arg6.market_id, arg6.market_object_id, arg6.outcome, arg8);
        credit_fee(arg0, v5);
        set_fee_remainder(arg0, v0, v3);
        add_filled(arg0, v0, arg8);
        set_fill_settled(arg0, arg5, true);
        let v6 = OrderFilled{
            fill_id           : arg5,
            maker_order_hash  : v0,
            taker_order_hash  : 0x2::hash::blake2b256(&arg5),
            maker             : arg6.trader,
            taker             : arg4,
            market_id         : arg6.market_id,
            outcome           : arg6.outcome,
            maker_side        : arg6.side,
            fill_amount       : arg8,
            collateral_amount : v1,
            fee               : v2,
        };
        0x2::event::emit<OrderFilled>(v6);
        v4
    }

    public(friend) fun execute_marketing_taker_buy_from_sell_order(arg0: &mut CLOBExchange, arg1: &mut 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::trading_account::TradingAccount, arg2: &mut 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::trading_account::TradingAccount, arg3: &0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_market::CLOBMarket, arg4: address, arg5: vector<u8>, arg6: Order, arg7: Signature, arg8: u64, arg9: 0x2::coin::Coin<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) : (u64, u64, 0x2::coin::Coin<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>) {
        assert_operator(arg0, arg11);
        assert!(!arg0.paused, 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::e_invalid_state());
        assert!(0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_market::state(arg3) == 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::state_trading(), 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::e_invalid_state());
        assert!(arg8 > 0, 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::e_zero_amount());
        assert!(!is_fill_settled(arg0, arg5), 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::e_fill_already_settled());
        assert!(arg6.side == 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::side_sell(), 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::e_invalid_side());
        assert!(arg6.market_id == 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_market::market_id(arg3), 100);
        assert!(arg6.market_object_id == 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_market::id(arg3), 100);
        assert!(arg6.account_object_id == 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::trading_account::id(arg1), 100);
        0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::trading_account::assert_owner_address(arg1, arg6.trader);
        0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::trading_account::assert_owner_address(arg2, arg4);
        let v0 = order_hash(arg0, arg6);
        verify_order_signature(arg0, arg6, arg7);
        validate_order_at(arg0, v0, arg6, arg8, arg10);
        let (v1, v2, v3) = 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::settlement_amounts_with_remainder(arg8, arg6.price, arg0.fee_bps, fee_remainder(arg0, v0));
        assert!(arg0.fee_bps <= arg6.max_fee_bps, 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::e_invalid_fee());
        let v4 = v1 + v2;
        assert!(0x2::coin::value<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>(&arg9) >= v4, 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::e_insufficient_balance());
        let v5 = if (0x2::coin::value<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>(&arg9) == v4) {
            0x2::coin::zero<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>(arg11)
        } else {
            0x2::coin::split<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>(&mut arg9, 0x2::coin::value<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>(&arg9) - v4, arg11)
        };
        let v6 = if (v2 == 0) {
            0x2::coin::zero<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>(arg11)
        } else {
            0x2::coin::split<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>(&mut arg9, v2, arg11)
        };
        0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::trading_account::credit_yoso(arg1, arg9);
        0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::trading_account::debit_outcome(arg1, arg6.market_id, arg6.market_object_id, arg6.outcome, arg8);
        0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::trading_account::credit_outcome(arg2, arg6.market_id, arg6.market_object_id, arg6.outcome, arg8);
        credit_fee(arg0, v6);
        set_fee_remainder(arg0, v0, v3);
        add_filled(arg0, v0, arg8);
        set_fill_settled(arg0, arg5, true);
        let v7 = OrderFilled{
            fill_id           : arg5,
            maker_order_hash  : v0,
            taker_order_hash  : 0x2::hash::blake2b256(&arg5),
            maker             : arg6.trader,
            taker             : arg4,
            market_id         : arg6.market_id,
            outcome           : arg6.outcome,
            maker_side        : arg6.side,
            fill_amount       : arg8,
            collateral_amount : v1,
            fee               : v2,
        };
        0x2::event::emit<OrderFilled>(v7);
        (v1, v2, v5)
    }

    public fun fee_bps(arg0: &CLOBExchange) : u64 {
        assert_version(arg0);
        arg0.fee_bps
    }

    public fun fee_recipient(arg0: &CLOBExchange) : address {
        assert_version(arg0);
        arg0.fee_recipient
    }

    fun fee_remainder(arg0: &CLOBExchange, arg1: vector<u8>) : u64 {
        assert_version(arg0);
        if (0x2::table::contains<vector<u8>, u64>(&arg0.fee_remainder, arg1)) {
            *0x2::table::borrow<vector<u8>, u64>(&arg0.fee_remainder, arg1)
        } else {
            0
        }
    }

    public fun fee_vault_balance(arg0: &CLOBExchange) : u64 {
        assert_version(arg0);
        0x2::balance::value<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>(&arg0.fee_vault)
    }

    public fun filled_amount(arg0: &CLOBExchange, arg1: vector<u8>) : u64 {
        assert_version(arg0);
        if (0x2::table::contains<vector<u8>, u64>(&arg0.filled_amount, arg1)) {
            *0x2::table::borrow<vector<u8>, u64>(&arg0.filled_amount, arg1)
        } else {
            0
        }
    }

    fun hex_char(arg0: u8) : u8 {
        if (arg0 < 10) {
            48 + arg0
        } else {
            87 + arg0
        }
    }

    public fun increment_nonce(arg0: &mut CLOBExchange, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = min_nonce(arg0, v0);
        assert!(arg1 > v1, 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::e_nonce_too_low());
        assert!(arg1 <= v1 + 1000000, 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::e_invalid_state());
        set_min_nonce(arg0, v0, arg1);
        let v2 = MinNonceUpdated{
            trader        : v0,
            old_min_nonce : v1,
            new_min_nonce : arg1,
        };
        0x2::event::emit<MinNonceUpdated>(v2);
    }

    public fun init_exchange(arg0: address, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = new_exchange(v0, arg0, arg1, arg2, arg3);
        let v2 = CLOBExchangeCreated{
            exchange_id   : 0x2::object::id<CLOBExchange>(&v1),
            admin         : v0,
            operator      : arg0,
            fee_recipient : arg1,
            fee_bps       : arg2,
        };
        0x2::event::emit<CLOBExchangeCreated>(v2);
        0x2::transfer::share_object<CLOBExchange>(v1);
    }

    public fun is_cancelled(arg0: &CLOBExchange, arg1: vector<u8>) : bool {
        assert_version(arg0);
        0x2::table::contains<vector<u8>, bool>(&arg0.cancelled, arg1) && *0x2::table::borrow<vector<u8>, bool>(&arg0.cancelled, arg1)
    }

    public fun is_fill_settled(arg0: &CLOBExchange, arg1: vector<u8>) : bool {
        assert_version(arg0);
        0x2::table::contains<vector<u8>, bool>(&arg0.settled_fills, arg1) && *0x2::table::borrow<vector<u8>, bool>(&arg0.settled_fills, arg1)
    }

    public fun max_settlement_batch_size() : u64 {
        10
    }

    public fun min_nonce(arg0: &CLOBExchange, arg1: address) : u64 {
        assert_version(arg0);
        if (0x2::table::contains<address, u64>(&arg0.min_nonce, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.min_nonce, arg1)
        } else {
            0
        }
    }

    fun new_exchange(arg0: address, arg1: address, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : CLOBExchange {
        assert!(arg1 != @0x0, 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::e_not_authorized());
        assert!(arg2 != @0x0, 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::e_not_authorized());
        assert!(arg3 <= 1000, 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::e_invalid_fee());
        CLOBExchange{
            id            : 0x2::object::new(arg4),
            version       : 1,
            admin         : arg0,
            operator      : arg1,
            fee_recipient : arg2,
            fee_bps       : arg3,
            paused        : false,
            fee_vault     : 0x2::balance::zero<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>(),
            filled_amount : 0x2::table::new<vector<u8>, u64>(arg4),
            cancelled     : 0x2::table::new<vector<u8>, bool>(arg4),
            min_nonce     : 0x2::table::new<address, u64>(arg4),
            settled_fills : 0x2::table::new<vector<u8>, bool>(arg4),
            fee_remainder : 0x2::table::new<vector<u8>, u64>(arg4),
        }
    }

    public fun new_order(arg0: address, arg1: u64, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: u8, arg5: u8, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64) : Order {
        0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::assert_order_side(arg4);
        0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::assert_binary_outcome(arg5);
        0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::assert_limit_price(arg6);
        assert!(arg7 > 0, 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::e_zero_amount());
        0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::assert_fee_bps(arg10);
        Order{
            trader            : arg0,
            market_id         : arg1,
            market_object_id  : arg2,
            account_object_id : arg3,
            side              : arg4,
            outcome           : arg5,
            price             : arg6,
            size              : arg7,
            expiration_ms     : arg8,
            nonce             : arg9,
            max_fee_bps       : arg10,
        }
    }

    public fun new_signature(arg0: u8, arg1: vector<u8>, arg2: vector<u8>) : Signature {
        assert!(arg0 == 0 || arg0 == 1, 104);
        Signature{
            scheme     : arg0,
            public_key : arg1,
            signature  : arg2,
        }
    }

    public fun new_signed_fill(arg0: vector<u8>, arg1: Order, arg2: Order, arg3: Signature, arg4: Signature, arg5: u64) : SignedFill {
        SignedFill{
            fill_id         : arg0,
            maker_order     : arg1,
            taker_order     : arg2,
            maker_signature : arg3,
            taker_signature : arg4,
            fill_amount     : arg5,
        }
    }

    public fun operator(arg0: &CLOBExchange) : address {
        assert_version(arg0);
        arg0.operator
    }

    public fun order_hash(arg0: &CLOBExchange, arg1: Order) : vector<u8> {
        let v0 = order_message(arg0, arg1);
        0x2::hash::blake2b256(&v0)
    }

    public fun order_message(arg0: &CLOBExchange, arg1: Order) : vector<u8> {
        assert_version(arg0);
        let v0 = OrderEnvelope{
            domain      : b"YOSO_CLOB_ORDER_V1",
            exchange_id : 0x2::object::id<CLOBExchange>(arg0),
            order       : arg1,
        };
        0x2::bcs::to_bytes<OrderEnvelope>(&v0)
    }

    public fun order_outcome(arg0: Order) : u8 {
        arg0.outcome
    }

    public fun order_personal_signing_digest(arg0: &CLOBExchange, arg1: Order) : vector<u8> {
        sui_personal_message_digest(order_personal_signing_message(arg0, arg1))
    }

    public fun order_personal_signing_message(arg0: &CLOBExchange, arg1: Order) : vector<u8> {
        order_personal_signing_message_from_hash(order_hash(arg0, arg1))
    }

    public fun order_personal_signing_message_from_hash(arg0: vector<u8>) : vector<u8> {
        let v0 = b"YOSO_CLOB_ORDER_V1:";
        let v1 = &mut v0;
        append_hex_lower(v1, arg0);
        v0
    }

    public fun order_side(arg0: Order) : u8 {
        arg0.side
    }

    public fun pause(arg0: &mut CLOBExchange, arg1: &0x2::tx_context::TxContext) {
        assert_admin(arg0, arg1);
        arg0.paused = true;
        let v0 = ExchangePaused{paused: true};
        0x2::event::emit<ExchangePaused>(v0);
    }

    public fun paused(arg0: &CLOBExchange) : bool {
        assert_version(arg0);
        arg0.paused
    }

    public fun remaining(arg0: &CLOBExchange, arg1: vector<u8>, arg2: Order) : u64 {
        assert_version(arg0);
        if (is_cancelled(arg0, arg1) || arg2.nonce < min_nonce(arg0, arg2.trader)) {
            0
        } else {
            let v1 = filled_amount(arg0, arg1);
            if (v1 >= arg2.size) {
                0
            } else {
                arg2.size - v1
            }
        }
    }

    fun set_cancelled(arg0: &mut CLOBExchange, arg1: vector<u8>, arg2: bool) {
        if (0x2::table::contains<vector<u8>, bool>(&arg0.cancelled, arg1)) {
            *0x2::table::borrow_mut<vector<u8>, bool>(&mut arg0.cancelled, arg1) = arg2;
        } else {
            0x2::table::add<vector<u8>, bool>(&mut arg0.cancelled, arg1, arg2);
        };
    }

    public fun set_fee_bps(arg0: &mut CLOBExchange, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert_admin(arg0, arg2);
        assert!(arg1 <= 1000, 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::e_invalid_fee());
        arg0.fee_bps = arg1;
        let v0 = FeeUpdated{
            old_fee_bps : arg0.fee_bps,
            new_fee_bps : arg1,
        };
        0x2::event::emit<FeeUpdated>(v0);
    }

    public fun set_fee_recipient(arg0: &mut CLOBExchange, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert_admin(arg0, arg2);
        assert!(arg1 != @0x0, 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::e_not_authorized());
        arg0.fee_recipient = arg1;
        let v0 = FeeRecipientUpdated{
            old_fee_recipient : arg0.fee_recipient,
            new_fee_recipient : arg1,
        };
        0x2::event::emit<FeeRecipientUpdated>(v0);
    }

    fun set_fee_remainder(arg0: &mut CLOBExchange, arg1: vector<u8>, arg2: u64) {
        if (0x2::table::contains<vector<u8>, u64>(&arg0.fee_remainder, arg1)) {
            *0x2::table::borrow_mut<vector<u8>, u64>(&mut arg0.fee_remainder, arg1) = arg2;
        } else {
            0x2::table::add<vector<u8>, u64>(&mut arg0.fee_remainder, arg1, arg2);
        };
    }

    fun set_fill_settled(arg0: &mut CLOBExchange, arg1: vector<u8>, arg2: bool) {
        if (0x2::table::contains<vector<u8>, bool>(&arg0.settled_fills, arg1)) {
            *0x2::table::borrow_mut<vector<u8>, bool>(&mut arg0.settled_fills, arg1) = arg2;
        } else {
            0x2::table::add<vector<u8>, bool>(&mut arg0.settled_fills, arg1, arg2);
        };
    }

    fun set_min_nonce(arg0: &mut CLOBExchange, arg1: address, arg2: u64) {
        if (0x2::table::contains<address, u64>(&arg0.min_nonce, arg1)) {
            *0x2::table::borrow_mut<address, u64>(&mut arg0.min_nonce, arg1) = arg2;
        } else {
            0x2::table::add<address, u64>(&mut arg0.min_nonce, arg1, arg2);
        };
    }

    public fun set_operator(arg0: &mut CLOBExchange, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert_admin(arg0, arg2);
        arg0.operator = arg1;
        let v0 = OperatorUpdated{
            old_operator : arg0.operator,
            new_operator : arg1,
        };
        0x2::event::emit<OperatorUpdated>(v0);
    }

    public(friend) fun settle_fill_without_signatures(arg0: &mut CLOBExchange, arg1: &mut 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::trading_account::TradingAccount, arg2: &mut 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::trading_account::TradingAccount, arg3: &0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_market::CLOBMarket, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: Order, arg8: Order, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        settle_fill_without_signatures_at(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, 0x2::clock::timestamp_ms(arg10), arg11)
    }

    fun settle_fill_without_signatures_at(arg0: &mut CLOBExchange, arg1: &mut 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::trading_account::TradingAccount, arg2: &mut 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::trading_account::TradingAccount, arg3: &0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_market::CLOBMarket, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: Order, arg8: Order, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        assert_operator(arg0, arg11);
        assert!(!arg0.paused, 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::e_invalid_state());
        assert!(0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_market::state(arg3) == 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::state_trading(), 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::e_invalid_state());
        assert!(arg9 > 0, 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::e_zero_amount());
        assert!(!is_fill_settled(arg0, arg4), 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::e_fill_already_settled());
        assert!(arg7.trader != arg8.trader, 103);
        assert!(arg7.market_id == 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_market::market_id(arg3), 100);
        assert!(arg7.market_object_id == 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_market::id(arg3), 100);
        assert!(arg7.account_object_id == 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::trading_account::id(arg1), 100);
        assert!(arg8.market_id == arg7.market_id, 100);
        assert!(arg8.market_object_id == arg7.market_object_id, 100);
        assert!(arg8.account_object_id == 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::trading_account::id(arg2), 100);
        0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::trading_account::assert_owner_address(arg1, arg7.trader);
        0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::trading_account::assert_owner_address(arg2, arg8.trader);
        assert!(arg5 == order_hash(arg0, arg7), 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::e_invalid_signature());
        assert!(arg6 == order_hash(arg0, arg8), 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::e_invalid_signature());
        assert!(arg8.outcome == arg7.outcome, 101);
        assert!(arg7.side != arg8.side, 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::e_invalid_side());
        validate_order_at(arg0, arg5, arg7, arg9, arg10);
        validate_order_at(arg0, arg6, arg8, arg9, arg10);
        assert_crossed(arg7, arg8);
        let (v0, v1, v2) = 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::settlement_amounts_with_remainder(arg9, arg7.price, arg0.fee_bps, fee_remainder(arg0, arg5));
        assert!(arg0.fee_bps <= arg7.max_fee_bps, 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::e_invalid_fee());
        assert!(arg0.fee_bps <= arg8.max_fee_bps, 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::e_invalid_fee());
        apply_fill(arg0, arg1, arg2, arg7, arg8, arg9, v0, v1, arg11);
        set_fee_remainder(arg0, arg5, v2);
        add_filled(arg0, arg5, arg9);
        add_filled(arg0, arg6, arg9);
        set_fill_settled(arg0, arg4, true);
        let v3 = OrderFilled{
            fill_id           : arg4,
            maker_order_hash  : arg5,
            taker_order_hash  : arg6,
            maker             : arg7.trader,
            taker             : arg8.trader,
            market_id         : arg7.market_id,
            outcome           : arg7.outcome,
            maker_side        : arg7.side,
            fill_amount       : arg9,
            collateral_amount : v0,
            fee               : v1,
        };
        0x2::event::emit<OrderFilled>(v3);
        (v0, v1)
    }

    public fun settle_signed_fill(arg0: &mut CLOBExchange, arg1: &mut 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::trading_account::TradingAccount, arg2: &mut 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::trading_account::TradingAccount, arg3: &0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_market::CLOBMarket, arg4: vector<u8>, arg5: Order, arg6: Order, arg7: Signature, arg8: Signature, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        let v0 = SignedFill{
            fill_id         : arg4,
            maker_order     : arg5,
            taker_order     : arg6,
            maker_signature : arg7,
            taker_signature : arg8,
            fill_amount     : arg9,
        };
        settle_signed_fill_internal(arg0, arg1, arg2, arg3, v0, 0x2::clock::timestamp_ms(arg10), arg11)
    }

    fun settle_signed_fill_internal(arg0: &mut CLOBExchange, arg1: &mut 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::trading_account::TradingAccount, arg2: &mut 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::trading_account::TradingAccount, arg3: &0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_market::CLOBMarket, arg4: SignedFill, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        let SignedFill {
            fill_id         : v0,
            maker_order     : v1,
            taker_order     : v2,
            maker_signature : v3,
            taker_signature : v4,
            fill_amount     : v5,
        } = arg4;
        let v6 = order_hash(arg0, v1);
        let v7 = order_hash(arg0, v2);
        verify_order_signature(arg0, v1, v3);
        verify_order_signature(arg0, v2, v4);
        settle_fill_without_signatures_at(arg0, arg1, arg2, arg3, v0, v6, v7, v1, v2, v5, arg5, arg6)
    }

    public fun settle_signed_fills(arg0: &mut CLOBExchange, arg1: &mut 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::trading_account::TradingAccount, arg2: &mut 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::trading_account::TradingAccount, arg3: &0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_market::CLOBMarket, arg4: vector<SignedFill>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<SignedFill>(&arg4);
        assert!(v0 > 0, 106);
        assert!(v0 <= 10, 107);
        let v1 = 0;
        while (v1 < v0) {
            let (_, _) = settle_signed_fill_internal(arg0, arg1, arg2, arg3, *0x1::vector::borrow<SignedFill>(&arg4, v1), 0x2::clock::timestamp_ms(arg5), arg6);
            v1 = v1 + 1;
        };
        let v4 = SettlementBatchExecuted{
            batch_size : v0,
            market_id  : 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_market::market_id(arg3),
        };
        0x2::event::emit<SettlementBatchExecuted>(v4);
    }

    public fun signature_scheme_ed25519() : u8 {
        0
    }

    public fun signature_scheme_secp256k1() : u8 {
        1
    }

    public fun signer_address(arg0: &Signature) : address {
        let v0 = arg0.scheme;
        assert!(v0 == 0 || v0 == 1, 104);
        let v1 = 0x1::vector::empty<u8>();
        0x1::vector::push_back<u8>(&mut v1, v0);
        0x1::vector::append<u8>(&mut v1, arg0.public_key);
        0x2::address::from_bytes(0x2::hash::blake2b256(&v1))
    }

    public fun sui_personal_message_digest(arg0: vector<u8>) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = &mut v0;
        0x1::vector::push_back<u8>(v1, 3);
        0x1::vector::push_back<u8>(v1, 0);
        0x1::vector::push_back<u8>(v1, 0);
        let v2 = &mut v0;
        append_uleb128(v2, 0x1::vector::length<u8>(&arg0));
        0x1::vector::append<u8>(&mut v0, arg0);
        0x2::hash::blake2b256(&v0)
    }

    public fun unpause(arg0: &mut CLOBExchange, arg1: &0x2::tx_context::TxContext) {
        assert_admin(arg0, arg1);
        arg0.paused = false;
        let v0 = ExchangePaused{paused: false};
        0x2::event::emit<ExchangePaused>(v0);
    }

    fun validate_order_at(arg0: &CLOBExchange, arg1: vector<u8>, arg2: Order, arg3: u64, arg4: u64) {
        0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::assert_order_side(arg2.side);
        0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::assert_binary_outcome(arg2.outcome);
        0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::assert_limit_price(arg2.price);
        assert!(arg4 < arg2.expiration_ms, 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::e_order_expired());
        assert!(arg2.nonce >= min_nonce(arg0, arg2.trader), 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::e_nonce_too_low());
        assert!(!is_cancelled(arg0, arg1), 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::e_order_cancelled());
        assert!(filled_amount(arg0, arg1) + arg3 <= arg2.size, 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::e_overfill());
    }

    fun verify_order_signature(arg0: &CLOBExchange, arg1: Order, arg2: Signature) {
        assert!(signer_address(&arg2) == arg1.trader, 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::e_invalid_signature());
        let Signature {
            scheme     : v0,
            public_key : v1,
            signature  : v2,
        } = arg2;
        let v3 = v2;
        let v4 = v1;
        let v5 = if (v0 == 0) {
            let v6 = order_personal_signing_digest(arg0, arg1);
            0x2::ed25519::ed25519_verify(&v3, &v4, &v6)
        } else {
            assert!(v0 == 1, 104);
            let v7 = order_message(arg0, arg1);
            0x2::ecdsa_k1::secp256k1_verify(&v3, &v4, &v7, 1)
        };
        assert!(v5, 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::e_invalid_signature());
    }

    public(friend) fun verify_signature_message(arg0: Signature, arg1: address, arg2: vector<u8>) {
        assert!(signer_address(&arg0) == arg1, 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::e_invalid_signature());
        let Signature {
            scheme     : v0,
            public_key : v1,
            signature  : v2,
        } = arg0;
        let v3 = v2;
        let v4 = v1;
        let v5 = if (v0 == 0) {
            0x2::ed25519::ed25519_verify(&v3, &v4, &arg2)
        } else {
            assert!(v0 == 1, 104);
            0x2::ecdsa_k1::secp256k1_verify(&v3, &v4, &arg2, 1)
        };
        assert!(v5, 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::e_invalid_signature());
    }

    public fun version(arg0: &CLOBExchange) : u64 {
        assert_version(arg0);
        arg0.version
    }

    public fun withdraw_fees(arg0: &mut CLOBExchange, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD> {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg0.admin || v0 == arg0.fee_recipient, 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::e_not_authorized());
        assert!(arg1 > 0, 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::e_zero_amount());
        assert!(0x2::balance::value<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>(&arg0.fee_vault) >= arg1, 0x2ba57e9bd6f4a86ef3861f8317cae4c54c40a45027b5f161dda79f4e5c1e023a::clob_types::e_insufficient_balance());
        let v1 = FeesWithdrawn{
            recipient : v0,
            amount    : arg1,
        };
        0x2::event::emit<FeesWithdrawn>(v1);
        0x2::coin::from_balance<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>(0x2::balance::split<0x501f9137023532a285b9ddc971467f26b8d1f72faf2a6016999a88b78a6905f7::yosousd::YOSOUSD>(&mut arg0.fee_vault, arg1), arg2)
    }

    // decompiled from Move bytecode v7
}

