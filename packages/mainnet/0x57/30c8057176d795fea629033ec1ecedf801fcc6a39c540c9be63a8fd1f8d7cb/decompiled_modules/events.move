module 0x5730c8057176d795fea629033ec1ecedf801fcc6a39c540c9be63a8fd1f8d7cb::events {
    struct ConfigCreated has copy, drop {
        schema_version: u16,
        config_id: 0x2::object::ID,
        quote_type: 0x1::type_name::TypeName,
        actor: address,
    }

    struct ConfigEnabled has copy, drop {
        schema_version: u16,
        config_id: 0x2::object::ID,
        enabled: bool,
    }

    struct ProtocolRecipientSet has copy, drop {
        schema_version: u16,
        config_id: 0x2::object::ID,
        recipient: address,
    }

    struct TokenCreated has copy, drop {
        schema_version: u16,
        token_type: 0x1::type_name::TypeName,
        ticket_id: 0x2::object::ID,
        treasury_cap_id: 0x2::object::ID,
        decimals: u8,
        creator: address,
    }

    struct PoolCreated has copy, drop {
        schema_version: u16,
        pool_id: 0x2::object::ID,
        config_id: 0x2::object::ID,
        token_type: 0x1::type_name::TypeName,
        quote_type: 0x1::type_name::TypeName,
        creator: address,
        creator_recipient: address,
        token_decimals: u8,
        total_supply: u64,
        phantom_quote: u64,
        graduation_quote: u64,
        reserved_tokens: u64,
        base_fee_bps: u64,
        creator_share_bps: u64,
        creator_tax_bps: u64,
        anti_snipe: bool,
        tick_spacing: u32,
        created_at_ms: u64,
        cetus_creation_cap_id: 0x1::option::Option<0x2::object::ID>,
    }

    struct MarketEvent has copy, drop {
        schema_version: u16,
        pool_id: 0x2::object::ID,
        sequence: u64,
        action: u8,
        amount_in: u64,
        amount_out: u64,
        fee: u64,
        state: u8,
        token_reserve: u64,
        quote_reserve: u64,
        creator_fees: u64,
        protocol_fees: u64,
        creator_recipient: address,
        actor: address,
        timestamp_ms: u64,
    }

    struct Graduated has copy, drop {
        schema_version: u16,
        pool_id: 0x2::object::ID,
        cetus_pool_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        lock_id: 0x2::object::ID,
        creation_cap_id: 0x2::object::ID,
        token_is_a: bool,
        sqrt_price_x64: u128,
        tick_spacing: u32,
        token_deposited: u64,
        quote_deposited: u64,
        token_locked_surplus: u64,
        quote_locked_surplus: u64,
        timestamp_ms: u64,
    }

    struct LpFeesCollected has copy, drop {
        schema_version: u16,
        pool_id: 0x2::object::ID,
        lock_id: 0x2::object::ID,
        cetus_pool_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        token_fee: u64,
        quote_fee: u64,
        creator_token: u64,
        creator_quote: u64,
        protocol_token: u64,
        protocol_quote: u64,
        creator_recipient: address,
        protocol_recipient: address,
        actor: address,
        timestamp_ms: u64,
    }

    public(friend) fun config_created<T0>(arg0: 0x2::object::ID, arg1: &0x2::tx_context::TxContext) {
        let v0 = ConfigCreated{
            schema_version : 1,
            config_id      : arg0,
            quote_type     : 0x1::type_name::with_original_ids<T0>(),
            actor          : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<ConfigCreated>(v0);
    }

    public(friend) fun config_enabled(arg0: 0x2::object::ID, arg1: bool) {
        let v0 = ConfigEnabled{
            schema_version : 1,
            config_id      : arg0,
            enabled        : arg1,
        };
        0x2::event::emit<ConfigEnabled>(v0);
    }

    public(friend) fun graduated(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: 0x2::object::ID, arg5: bool, arg6: u128, arg7: u32, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64) {
        let v0 = Graduated{
            schema_version       : 1,
            pool_id              : arg0,
            cetus_pool_id        : arg1,
            position_id          : arg2,
            lock_id              : arg3,
            creation_cap_id      : arg4,
            token_is_a           : arg5,
            sqrt_price_x64       : arg6,
            tick_spacing         : arg7,
            token_deposited      : arg8,
            quote_deposited      : arg9,
            token_locked_surplus : arg10,
            quote_locked_surplus : arg11,
            timestamp_ms         : arg12,
        };
        0x2::event::emit<Graduated>(v0);
    }

    public(friend) fun lp_fees_collected(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: address, arg11: address, arg12: address, arg13: u64) {
        let v0 = LpFeesCollected{
            schema_version     : 1,
            pool_id            : arg0,
            lock_id            : arg1,
            cetus_pool_id      : arg2,
            position_id        : arg3,
            token_fee          : arg4,
            quote_fee          : arg5,
            creator_token      : arg6,
            creator_quote      : arg7,
            protocol_token     : arg8,
            protocol_quote     : arg9,
            creator_recipient  : arg10,
            protocol_recipient : arg11,
            actor              : arg12,
            timestamp_ms       : arg13,
        };
        0x2::event::emit<LpFeesCollected>(v0);
    }

    public(friend) fun market(arg0: 0x2::object::ID, arg1: u64, arg2: u8, arg3: u64, arg4: u64, arg5: u64, arg6: u8, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: address, arg12: address, arg13: u64) {
        let v0 = MarketEvent{
            schema_version    : 2,
            pool_id           : arg0,
            sequence          : arg1,
            action            : arg2,
            amount_in         : arg3,
            amount_out        : arg4,
            fee               : arg5,
            state             : arg6,
            token_reserve     : arg7,
            quote_reserve     : arg8,
            creator_fees      : arg9,
            protocol_fees     : arg10,
            creator_recipient : arg11,
            actor             : arg12,
            timestamp_ms      : arg13,
        };
        0x2::event::emit<MarketEvent>(v0);
    }

    public(friend) fun pool_created(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x1::type_name::TypeName, arg3: 0x1::type_name::TypeName, arg4: address, arg5: address, arg6: u8, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: bool, arg15: u32, arg16: u64, arg17: 0x1::option::Option<0x2::object::ID>) {
        let v0 = PoolCreated{
            schema_version        : 1,
            pool_id               : arg0,
            config_id             : arg1,
            token_type            : arg2,
            quote_type            : arg3,
            creator               : arg4,
            creator_recipient     : arg5,
            token_decimals        : arg6,
            total_supply          : arg7,
            phantom_quote         : arg8,
            graduation_quote      : arg9,
            reserved_tokens       : arg10,
            base_fee_bps          : arg11,
            creator_share_bps     : arg12,
            creator_tax_bps       : arg13,
            anti_snipe            : arg14,
            tick_spacing          : arg15,
            created_at_ms         : arg16,
            cetus_creation_cap_id : arg17,
        };
        0x2::event::emit<PoolCreated>(v0);
    }

    public(friend) fun protocol_recipient_set(arg0: 0x2::object::ID, arg1: address) {
        let v0 = ProtocolRecipientSet{
            schema_version : 1,
            config_id      : arg0,
            recipient      : arg1,
        };
        0x2::event::emit<ProtocolRecipientSet>(v0);
    }

    public(friend) fun token_created<T0>(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u8, arg3: &0x2::tx_context::TxContext) {
        let v0 = TokenCreated{
            schema_version  : 1,
            token_type      : 0x1::type_name::with_original_ids<T0>(),
            ticket_id       : arg0,
            treasury_cap_id : arg1,
            decimals        : arg2,
            creator         : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<TokenCreated>(v0);
    }

    // decompiled from Move bytecode v7
}

