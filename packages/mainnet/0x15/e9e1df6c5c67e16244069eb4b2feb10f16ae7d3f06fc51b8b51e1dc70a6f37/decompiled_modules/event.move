module 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::event {
    struct ScoreAdded has copy, drop {
        scoreboard_id: 0x2::object::ID,
        owner: address,
        amount: u64,
        score_before: u64,
        score_after: u64,
    }

    struct ScoreDebtUpdated has copy, drop {
        scoreboard_id: 0x2::object::ID,
        owner: address,
        amount: u64,
        score_debt_before: u64,
        score_debt_after: u64,
        reason: u8,
    }

    struct ScoreInfoSnapshot has copy, drop {
        score: u64,
        score_per_duration: u64,
        duration: u64,
        updated_at: u64,
    }

    struct LinearTimeScoreSet has copy, drop {
        scoreboard_id: 0x2::object::ID,
        owner: address,
        before: ScoreInfoSnapshot,
        after: ScoreInfoSnapshot,
    }

    struct LinearTimeScoreUpdated has copy, drop {
        scoreboard_id: 0x2::object::ID,
        owner: address,
        before: ScoreInfoSnapshot,
        after: ScoreInfoSnapshot,
    }

    struct OrderPlaced has copy, drop {
        orderbook_id: 0x2::object::ID,
        side: u8,
        order_id: u64,
        maker: address,
        base: 0x1::type_name::TypeName,
        quote: 0x1::type_name::TypeName,
        price: u128,
        timestamp: u64,
        original_amount: u64,
        remaining_amount: u64,
    }

    struct OrderFilled has copy, drop {
        orderbook_id: 0x2::object::ID,
        side: u8,
        order_id: u64,
        maker: address,
        taker: address,
        base: 0x1::type_name::TypeName,
        quote: 0x1::type_name::TypeName,
        price: u128,
        timestamp: u64,
        fill_amount: u64,
        paid_amount: u64,
        remaining_amount: u64,
    }

    struct OrderCancelled has copy, drop {
        orderbook_id: 0x2::object::ID,
        side: u8,
        order_id: u64,
        maker: address,
        base: 0x1::type_name::TypeName,
        quote: 0x1::type_name::TypeName,
        price: u128,
        timestamp: u64,
        remaining_amount: u64,
    }

    struct OrderCancelledByAdmin has copy, drop {
        orderbook_id: 0x2::object::ID,
        side: u8,
        order_id: u64,
        maker: address,
        operator: address,
        base: 0x1::type_name::TypeName,
        quote: 0x1::type_name::TypeName,
        price: u128,
        timestamp: u64,
        remaining_amount: u64,
    }

    struct OrderDustRefunded has copy, drop {
        orderbook_id: 0x2::object::ID,
        side: u8,
        order_id: u64,
        maker: address,
        base: 0x1::type_name::TypeName,
        quote: 0x1::type_name::TypeName,
        price: u128,
        timestamp: u64,
        remaining_amount: u64,
        remaining_quote_notional: u64,
    }

    struct OrderbookCoinQuoteFeeConfigUpdated has copy, drop {
        orderbook_id: 0x2::object::ID,
        maker_fee_bps: u64,
        taker_fee_bps: u64,
    }

    struct OrderbookMinimumQuoteNotionalUpdated has copy, drop {
        orderbook_id: 0x2::object::ID,
        minimum_quote_notional: u64,
    }

    struct OrderbookCoinQuoteFeeAccrued has copy, drop {
        orderbook_id: 0x2::object::ID,
        side: u8,
        order_id: u64,
        fee_role: u8,
        payer: address,
        quote: 0x1::type_name::TypeName,
        gross_quote_amount: u64,
        fee_amount: u64,
    }

    struct OrderbookCoinQuoteFeesCollected has copy, drop {
        orderbook_id: 0x2::object::ID,
        recipient: address,
        quote: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct PointTokenMarketCreated has copy, drop {
        point_token_market_id: 0x2::object::ID,
        project_id: 0x2::object::ID,
        scoreboard_id: 0x2::object::ID,
        scale: u64,
    }

    struct ScoreboardPauseUpdated has copy, drop {
        scoreboard_id: 0x2::object::ID,
        project_id: 0x2::object::ID,
        paused: bool,
        effective_at_ms: u64,
    }

    struct TokenHoldingUpdated has copy, drop {
        point_token_market_id: 0x2::object::ID,
        project_id: 0x2::object::ID,
        owner: address,
        increase: bool,
        token_amount: u64,
        point_amount: u64,
        holding_before: u64,
        holding_after: u64,
    }

    struct TokenizedPointsRestored has copy, drop {
        point_token_market_id: 0x2::object::ID,
        scoreboard_id: 0x2::object::ID,
        project_id: 0x2::object::ID,
        owner: address,
        token_amount: u64,
        point_amount: u64,
    }

    public(friend) fun emit_linear_time_score_set(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64) {
        let v0 = ScoreInfoSnapshot{
            score              : arg2,
            score_per_duration : arg4,
            duration           : arg6,
            updated_at         : arg8,
        };
        let v1 = ScoreInfoSnapshot{
            score              : arg3,
            score_per_duration : arg5,
            duration           : arg7,
            updated_at         : arg9,
        };
        let v2 = LinearTimeScoreSet{
            scoreboard_id : arg0,
            owner         : arg1,
            before        : v0,
            after         : v1,
        };
        0x2::event::emit<LinearTimeScoreSet>(v2);
    }

    public(friend) fun emit_linear_time_score_updated(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64) {
        let v0 = ScoreInfoSnapshot{
            score              : arg2,
            score_per_duration : arg4,
            duration           : arg6,
            updated_at         : arg8,
        };
        let v1 = ScoreInfoSnapshot{
            score              : arg3,
            score_per_duration : arg5,
            duration           : arg7,
            updated_at         : arg9,
        };
        let v2 = LinearTimeScoreUpdated{
            scoreboard_id : arg0,
            owner         : arg1,
            before        : v0,
            after         : v1,
        };
        0x2::event::emit<LinearTimeScoreUpdated>(v2);
    }

    public(friend) fun emit_order_cancelled(arg0: 0x2::object::ID, arg1: u8, arg2: u64, arg3: address, arg4: 0x1::type_name::TypeName, arg5: 0x1::type_name::TypeName, arg6: u128, arg7: u64, arg8: u64) {
        let v0 = OrderCancelled{
            orderbook_id     : arg0,
            side             : arg1,
            order_id         : arg2,
            maker            : arg3,
            base             : arg4,
            quote            : arg5,
            price            : arg6,
            timestamp        : arg7,
            remaining_amount : arg8,
        };
        0x2::event::emit<OrderCancelled>(v0);
    }

    public(friend) fun emit_order_cancelled_by_admin(arg0: 0x2::object::ID, arg1: u8, arg2: u64, arg3: address, arg4: address, arg5: 0x1::type_name::TypeName, arg6: 0x1::type_name::TypeName, arg7: u128, arg8: u64, arg9: u64) {
        let v0 = OrderCancelledByAdmin{
            orderbook_id     : arg0,
            side             : arg1,
            order_id         : arg2,
            maker            : arg3,
            operator         : arg4,
            base             : arg5,
            quote            : arg6,
            price            : arg7,
            timestamp        : arg8,
            remaining_amount : arg9,
        };
        0x2::event::emit<OrderCancelledByAdmin>(v0);
    }

    public(friend) fun emit_order_dust_refunded(arg0: 0x2::object::ID, arg1: u8, arg2: u64, arg3: address, arg4: 0x1::type_name::TypeName, arg5: 0x1::type_name::TypeName, arg6: u128, arg7: u64, arg8: u64, arg9: u64) {
        let v0 = OrderDustRefunded{
            orderbook_id             : arg0,
            side                     : arg1,
            order_id                 : arg2,
            maker                    : arg3,
            base                     : arg4,
            quote                    : arg5,
            price                    : arg6,
            timestamp                : arg7,
            remaining_amount         : arg8,
            remaining_quote_notional : arg9,
        };
        0x2::event::emit<OrderDustRefunded>(v0);
    }

    public(friend) fun emit_order_filled(arg0: 0x2::object::ID, arg1: u8, arg2: u64, arg3: address, arg4: address, arg5: 0x1::type_name::TypeName, arg6: 0x1::type_name::TypeName, arg7: u128, arg8: u64, arg9: u64, arg10: u64, arg11: u64) {
        let v0 = OrderFilled{
            orderbook_id     : arg0,
            side             : arg1,
            order_id         : arg2,
            maker            : arg3,
            taker            : arg4,
            base             : arg5,
            quote            : arg6,
            price            : arg7,
            timestamp        : arg8,
            fill_amount      : arg9,
            paid_amount      : arg10,
            remaining_amount : arg11,
        };
        0x2::event::emit<OrderFilled>(v0);
    }

    public(friend) fun emit_order_placed(arg0: 0x2::object::ID, arg1: u8, arg2: u64, arg3: address, arg4: 0x1::type_name::TypeName, arg5: 0x1::type_name::TypeName, arg6: u128, arg7: u64, arg8: u64) {
        let v0 = OrderPlaced{
            orderbook_id     : arg0,
            side             : arg1,
            order_id         : arg2,
            maker            : arg3,
            base             : arg4,
            quote            : arg5,
            price            : arg6,
            timestamp        : arg7,
            original_amount  : arg8,
            remaining_amount : arg8,
        };
        0x2::event::emit<OrderPlaced>(v0);
    }

    public(friend) fun emit_orderbook_coin_quote_fee_accrued(arg0: 0x2::object::ID, arg1: u8, arg2: u64, arg3: u8, arg4: address, arg5: 0x1::type_name::TypeName, arg6: u64, arg7: u64) {
        let v0 = OrderbookCoinQuoteFeeAccrued{
            orderbook_id       : arg0,
            side               : arg1,
            order_id           : arg2,
            fee_role           : arg3,
            payer              : arg4,
            quote              : arg5,
            gross_quote_amount : arg6,
            fee_amount         : arg7,
        };
        0x2::event::emit<OrderbookCoinQuoteFeeAccrued>(v0);
    }

    public(friend) fun emit_orderbook_coin_quote_fee_config_updated(arg0: 0x2::object::ID, arg1: u64, arg2: u64) {
        let v0 = OrderbookCoinQuoteFeeConfigUpdated{
            orderbook_id  : arg0,
            maker_fee_bps : arg1,
            taker_fee_bps : arg2,
        };
        0x2::event::emit<OrderbookCoinQuoteFeeConfigUpdated>(v0);
    }

    public(friend) fun emit_orderbook_coin_quote_fees_collected(arg0: 0x2::object::ID, arg1: address, arg2: 0x1::type_name::TypeName, arg3: u64) {
        let v0 = OrderbookCoinQuoteFeesCollected{
            orderbook_id : arg0,
            recipient    : arg1,
            quote        : arg2,
            amount       : arg3,
        };
        0x2::event::emit<OrderbookCoinQuoteFeesCollected>(v0);
    }

    public(friend) fun emit_orderbook_minimum_quote_notional_updated(arg0: 0x2::object::ID, arg1: u64) {
        let v0 = OrderbookMinimumQuoteNotionalUpdated{
            orderbook_id           : arg0,
            minimum_quote_notional : arg1,
        };
        0x2::event::emit<OrderbookMinimumQuoteNotionalUpdated>(v0);
    }

    public(friend) fun emit_point_token_market_created(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: u64) {
        let v0 = PointTokenMarketCreated{
            point_token_market_id : arg0,
            project_id            : arg1,
            scoreboard_id         : arg2,
            scale                 : arg3,
        };
        0x2::event::emit<PointTokenMarketCreated>(v0);
    }

    public(friend) fun emit_score_added(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = ScoreAdded{
            scoreboard_id : arg0,
            owner         : arg1,
            amount        : arg2,
            score_before  : arg3,
            score_after   : arg4,
        };
        0x2::event::emit<ScoreAdded>(v0);
    }

    public(friend) fun emit_score_debt_updated(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64, arg4: u64, arg5: u8) {
        let v0 = ScoreDebtUpdated{
            scoreboard_id     : arg0,
            owner             : arg1,
            amount            : arg2,
            score_debt_before : arg3,
            score_debt_after  : arg4,
            reason            : arg5,
        };
        0x2::event::emit<ScoreDebtUpdated>(v0);
    }

    public(friend) fun emit_scoreboard_pause_updated(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: bool, arg3: u64) {
        let v0 = ScoreboardPauseUpdated{
            scoreboard_id   : arg0,
            project_id      : arg1,
            paused          : arg2,
            effective_at_ms : arg3,
        };
        0x2::event::emit<ScoreboardPauseUpdated>(v0);
    }

    public(friend) fun emit_token_holding_updated(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: address, arg3: bool, arg4: u64, arg5: u64, arg6: u64, arg7: u64) {
        let v0 = TokenHoldingUpdated{
            point_token_market_id : arg0,
            project_id            : arg1,
            owner                 : arg2,
            increase              : arg3,
            token_amount          : arg4,
            point_amount          : arg5,
            holding_before        : arg6,
            holding_after         : arg7,
        };
        0x2::event::emit<TokenHoldingUpdated>(v0);
    }

    public(friend) fun emit_tokenized_points_restored(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: address, arg4: u64, arg5: u64) {
        let v0 = TokenizedPointsRestored{
            point_token_market_id : arg0,
            scoreboard_id         : arg1,
            project_id            : arg2,
            owner                 : arg3,
            token_amount          : arg4,
            point_amount          : arg5,
        };
        0x2::event::emit<TokenizedPointsRestored>(v0);
    }

    // decompiled from Move bytecode v7
}

