module 0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::conditional_token {
    struct Supply has store, key {
        id: 0x2::object::UID,
        market_id: 0x2::object::ID,
        asset_type: u8,
        outcome: u8,
        total_supply: u64,
    }

    struct ConditionalToken has store, key {
        id: 0x2::object::UID,
        market_id: 0x2::object::ID,
        asset_type: u8,
        outcome: u8,
        balance: u64,
    }

    struct TokenMinted has copy, drop {
        id: 0x2::object::ID,
        market_id: 0x2::object::ID,
        asset_type: u8,
        outcome: u8,
        amount: u64,
        recipient: address,
        timestamp: u64,
    }

    struct TokenBurned has copy, drop {
        id: 0x2::object::ID,
        market_id: 0x2::object::ID,
        asset_type: u8,
        outcome: u8,
        amount: u64,
        sender: address,
        timestamp: u64,
    }

    struct TokenSplit has copy, drop {
        original_token_id: 0x2::object::ID,
        new_token_id: 0x2::object::ID,
        market_id: 0x2::object::ID,
        asset_type: u8,
        outcome: u8,
        original_amount: u64,
        split_amount: u64,
        owner: address,
        timestamp: u64,
    }

    struct TokenMergeMany has copy, drop {
        base_token_id: 0x2::object::ID,
        merged_token_ids: vector<0x2::object::ID>,
        market_id: 0x2::object::ID,
        asset_type: u8,
        outcome: u8,
        base_amount: u64,
        merged_amount: u64,
        owner: address,
        timestamp: u64,
    }

    public(friend) fun extract(arg0: &mut 0x1::option::Option<ConditionalToken>) : ConditionalToken {
        assert!(0x1::option::is_some<ConditionalToken>(arg0), 7);
        0x1::option::extract<ConditionalToken>(arg0)
    }

    public fun asset_type(arg0: &ConditionalToken) : u8 {
        arg0.asset_type
    }

    public(friend) fun burn(arg0: &mut Supply, arg1: ConditionalToken, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(arg1.market_id == arg0.market_id, 1);
        assert!(arg1.asset_type == arg0.asset_type, 2);
        assert!(arg1.outcome == arg0.outcome, 3);
        let ConditionalToken {
            id         : v0,
            market_id  : v1,
            asset_type : v2,
            outcome    : v3,
            balance    : v4,
        } = arg1;
        let v5 = v0;
        update_supply(arg0, v4, false);
        let v6 = TokenBurned{
            id         : 0x2::object::uid_to_inner(&v5),
            market_id  : v1,
            asset_type : v2,
            outcome    : v3,
            amount     : v4,
            sender     : 0x2::tx_context::sender(arg3),
            timestamp  : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<TokenBurned>(v6);
        0x2::object::delete(v5);
    }

    public(friend) fun destroy(arg0: ConditionalToken) {
        let ConditionalToken {
            id         : v0,
            market_id  : _,
            asset_type : _,
            outcome    : _,
            balance    : v4,
        } = arg0;
        assert!(v4 == 0, 8);
        0x2::object::delete(v0);
    }

    public fun market_id(arg0: &ConditionalToken) : 0x2::object::ID {
        arg0.market_id
    }

    public(friend) fun merge_many(arg0: &mut ConditionalToken, arg1: vector<ConditionalToken>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(!0x1::vector::is_empty<ConditionalToken>(&arg1), 6);
        let v0 = 0;
        let v1 = 0x1::vector::empty<0x2::object::ID>();
        while (!0x1::vector::is_empty<ConditionalToken>(&arg1)) {
            let v2 = 0x1::vector::pop_back<ConditionalToken>(&mut arg1);
            assert!(v2.market_id == arg0.market_id, 1);
            assert!(v2.asset_type == arg0.asset_type, 2);
            assert!(v2.outcome == arg0.outcome, 3);
            let ConditionalToken {
                id         : v3,
                market_id  : _,
                asset_type : _,
                outcome    : _,
                balance    : v7,
            } = v2;
            0x1::vector::push_back<0x2::object::ID>(&mut v1, 0x2::object::id<ConditionalToken>(&v2));
            v0 = v0 + v7;
            arg0.balance = arg0.balance + v7;
            0x2::object::delete(v3);
        };
        let v8 = TokenMergeMany{
            base_token_id    : 0x2::object::uid_to_inner(&arg0.id),
            merged_token_ids : v1,
            market_id        : arg0.market_id,
            asset_type       : arg0.asset_type,
            outcome          : arg0.outcome,
            base_amount      : arg0.balance - v0,
            merged_amount    : v0,
            owner            : 0x2::tx_context::sender(arg3),
            timestamp        : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<TokenMergeMany>(v8);
        0x1::vector::destroy_empty<ConditionalToken>(arg1);
    }

    public entry fun merge_many_entry(arg0: &mut ConditionalToken, arg1: vector<ConditionalToken>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        merge_many(arg0, arg1, arg2, arg3);
    }

    public(friend) fun mint(arg0: &0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::market_state::MarketState, arg1: &mut Supply, arg2: u64, arg3: address, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : ConditionalToken {
        0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::market_state::assert_in_trading_or_pre_trading(arg0);
        assert!(arg2 > 0, 4);
        assert!(0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::market_state::market_id(arg0) == arg1.market_id, 1);
        update_supply(arg1, arg2, true);
        let v0 = ConditionalToken{
            id         : 0x2::object::new(arg5),
            market_id  : arg1.market_id,
            asset_type : arg1.asset_type,
            outcome    : arg1.outcome,
            balance    : arg2,
        };
        let v1 = TokenMinted{
            id         : 0x2::object::id<ConditionalToken>(&v0),
            market_id  : arg1.market_id,
            asset_type : arg1.asset_type,
            outcome    : arg1.outcome,
            amount     : arg2,
            recipient  : arg3,
            timestamp  : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<TokenMinted>(v1);
        v0
    }

    public(friend) fun new_supply(arg0: &0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::market_state::MarketState, arg1: u8, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) : Supply {
        0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::market_state::validate_outcome(arg0, (arg2 as u64));
        assert!(arg1 <= 1, 0);
        Supply{
            id           : 0x2::object::new(arg3),
            market_id    : 0xce491339cde9b0520278e27f5b141e5cbe34caa069f44793d2630bc78d386051::market_state::market_id(arg0),
            asset_type   : arg1,
            outcome      : arg2,
            total_supply : 0,
        }
    }

    public fun outcome(arg0: &ConditionalToken) : u8 {
        arg0.outcome
    }

    public(friend) fun split(arg0: &mut ConditionalToken, arg1: u64, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 > 0, 4);
        assert!(arg0.balance > arg1, 5);
        arg0.balance = arg0.balance - arg1;
        let v0 = ConditionalToken{
            id         : 0x2::object::new(arg4),
            market_id  : arg0.market_id,
            asset_type : arg0.asset_type,
            outcome    : arg0.outcome,
            balance    : arg1,
        };
        let v1 = TokenSplit{
            original_token_id : 0x2::object::uid_to_inner(&arg0.id),
            new_token_id      : 0x2::object::id<ConditionalToken>(&v0),
            market_id         : arg0.market_id,
            asset_type        : arg0.asset_type,
            outcome           : arg0.outcome,
            original_amount   : arg0.balance,
            split_amount      : arg1,
            owner             : arg2,
            timestamp         : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<TokenSplit>(v1);
        0x2::transfer::transfer<ConditionalToken>(v0, arg2);
    }

    public entry fun split_entry(arg0: &mut ConditionalToken, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        split(arg0, arg1, v0, arg2, arg3);
    }

    public fun total_supply(arg0: &Supply) : u64 {
        arg0.total_supply
    }

    public(friend) fun update_supply(arg0: &mut Supply, arg1: u64, arg2: bool) {
        assert!(arg1 > 0, 4);
        if (arg2) {
            arg0.total_supply = arg0.total_supply + arg1;
        } else {
            assert!(arg0.total_supply >= arg1, 5);
            arg0.total_supply = arg0.total_supply - arg1;
        };
    }

    public fun value(arg0: &ConditionalToken) : u64 {
        arg0.balance
    }

    // decompiled from Move bytecode v6
}

