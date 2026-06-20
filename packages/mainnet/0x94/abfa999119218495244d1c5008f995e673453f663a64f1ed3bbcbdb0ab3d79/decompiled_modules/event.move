module 0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::event {
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
        price: u64,
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
        price: u64,
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
        price: u64,
        timestamp: u64,
        remaining_amount: u64,
    }

    struct TokenHoldingRegistryCreated has copy, drop {
        registry_id: 0x2::object::ID,
        project_id: 0x2::object::ID,
        profile_id: 0x2::object::ID,
        scale: u64,
    }

    struct ProjectProfileCreated has copy, drop {
        profile_id: 0x2::object::ID,
        project_id: 0x2::object::ID,
        tokenized_point_enabled: bool,
        token_point_scale: u64,
        airdrop_enabled: bool,
        coin_point_ratio: u64,
    }

    struct TokenHoldingUpdated has copy, drop {
        registry_id: 0x2::object::ID,
        project_id: 0x2::object::ID,
        owner: address,
        increase: bool,
        token_amount: u64,
        point_amount: u64,
        holding_before: u64,
        holding_after: u64,
    }

    struct TokenizedPointsRestored has copy, drop {
        registry_id: 0x2::object::ID,
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

    public(friend) fun emit_order_cancelled(arg0: 0x2::object::ID, arg1: u8, arg2: u64, arg3: address, arg4: 0x1::type_name::TypeName, arg5: 0x1::type_name::TypeName, arg6: u64, arg7: u64, arg8: u64) {
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

    public(friend) fun emit_order_filled(arg0: 0x2::object::ID, arg1: u8, arg2: u64, arg3: address, arg4: address, arg5: 0x1::type_name::TypeName, arg6: 0x1::type_name::TypeName, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64) {
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

    public(friend) fun emit_order_placed(arg0: 0x2::object::ID, arg1: u8, arg2: u64, arg3: address, arg4: 0x1::type_name::TypeName, arg5: 0x1::type_name::TypeName, arg6: u64, arg7: u64, arg8: u64) {
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

    public(friend) fun emit_project_profile_created(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: bool, arg3: u64, arg4: bool, arg5: u64) {
        let v0 = ProjectProfileCreated{
            profile_id              : arg0,
            project_id              : arg1,
            tokenized_point_enabled : arg2,
            token_point_scale       : arg3,
            airdrop_enabled         : arg4,
            coin_point_ratio        : arg5,
        };
        0x2::event::emit<ProjectProfileCreated>(v0);
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

    public(friend) fun emit_token_holding_registry_created(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: u64) {
        let v0 = TokenHoldingRegistryCreated{
            registry_id : arg0,
            project_id  : arg1,
            profile_id  : arg2,
            scale       : arg3,
        };
        0x2::event::emit<TokenHoldingRegistryCreated>(v0);
    }

    public(friend) fun emit_token_holding_updated(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: address, arg3: bool, arg4: u64, arg5: u64, arg6: u64, arg7: u64) {
        let v0 = TokenHoldingUpdated{
            registry_id    : arg0,
            project_id     : arg1,
            owner          : arg2,
            increase       : arg3,
            token_amount   : arg4,
            point_amount   : arg5,
            holding_before : arg6,
            holding_after  : arg7,
        };
        0x2::event::emit<TokenHoldingUpdated>(v0);
    }

    public(friend) fun emit_tokenized_points_restored(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: address, arg4: u64, arg5: u64) {
        let v0 = TokenizedPointsRestored{
            registry_id   : arg0,
            scoreboard_id : arg1,
            project_id    : arg2,
            owner         : arg3,
            token_amount  : arg4,
            point_amount  : arg5,
        };
        0x2::event::emit<TokenizedPointsRestored>(v0);
    }

    // decompiled from Move bytecode v7
}

