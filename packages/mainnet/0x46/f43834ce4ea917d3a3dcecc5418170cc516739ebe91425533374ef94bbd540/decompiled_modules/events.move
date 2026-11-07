module 0x46f43834ce4ea917d3a3dcecc5418170cc516739ebe91425533374ef94bbd540::events {
    struct QuoteAllowed<phantom T0> has copy, drop {
        allowed: bool,
    }

    struct PresaleOpened<phantom T0, phantom T1> has copy, drop {
        presale_id: 0x2::object::ID,
        start_ms: u64,
        end_ms: u64,
        liquidity_deadline_ms: u64,
        uncapped_from_ms: u64,
        hard_cap_from_ms: 0x1::option::Option<u64>,
        partner_id: 0x1::option::Option<0x2::object::ID>,
    }

    struct ProtocolFeesChanged<phantom T0, phantom T1> has copy, drop {
        presale_id: 0x2::object::ID,
        protocol_raise_bps: u64,
        protocol_token_bps: u64,
        protocol_lp_fee_meme_bps: u64,
        protocol_lp_fee_quote_bps: u64,
        protocol_quote: u64,
        protocol_tokens: u64,
        token_allocation: u64,
    }

    struct Committed<phantom T0, phantom T1> has copy, drop {
        presale_id: 0x2::object::ID,
        quote: u64,
        wallet_commitment: u64,
        total_commitments: u64,
        participants: u64,
    }

    struct PresaleFunded<phantom T0, phantom T1> has copy, drop {
        presale_id: 0x2::object::ID,
        total_commitments: u64,
        accepted_quote: u64,
        refundable_quote: u64,
        token_allocation: u64,
        end_ms: u64,
        liquidity_deadline_ms: u64,
    }

    struct PresaleCancelled<phantom T0, phantom T1> has copy, drop {
        presale_id: 0x2::object::ID,
        total_commitments: u64,
        refundable_quote: u64,
    }

    struct PresaleMigrated<phantom T0, phantom T1> has copy, drop {
        presale_id: 0x2::object::ID,
        venue: 0x1::type_name::TypeName,
        liquidity_quote: u64,
        liquidity_tokens: u64,
        recipient_tokens: u64,
    }

    struct RaiseAllocated<phantom T0, phantom T1> has copy, drop {
        presale_id: 0x2::object::ID,
        recipient: address,
        quote: u64,
        vesting_id: 0x1::option::Option<0x2::object::ID>,
    }

    struct RecipientAllocated<phantom T0, phantom T1> has copy, drop {
        presale_id: 0x2::object::ID,
        recipient: address,
        tokens: u64,
        vesting_id: 0x1::option::Option<0x2::object::ID>,
    }

    struct Claimed<phantom T0, phantom T1> has copy, drop {
        presale_id: 0x2::object::ID,
        participant: address,
        wallet_commitment: u64,
        tokens: u64,
        quote_refund: u64,
        remaining_participants: u64,
        vesting_id: 0x1::option::Option<0x2::object::ID>,
    }

    public(friend) fun claimed<T0, T1>(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: 0x1::option::Option<0x2::object::ID>) {
        let v0 = Claimed<T0, T1>{
            presale_id             : arg0,
            participant            : arg1,
            wallet_commitment      : arg2,
            tokens                 : arg3,
            quote_refund           : arg4,
            remaining_participants : arg5,
            vesting_id             : arg6,
        };
        0x2::event::emit<Claimed<T0, T1>>(v0);
    }

    public(friend) fun committed<T0, T1>(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = Committed<T0, T1>{
            presale_id        : arg0,
            quote             : arg1,
            wallet_commitment : arg2,
            total_commitments : arg3,
            participants      : arg4,
        };
        0x2::event::emit<Committed<T0, T1>>(v0);
    }

    public(friend) fun presale_cancelled<T0, T1>(arg0: 0x2::object::ID, arg1: u64, arg2: u64) {
        let v0 = PresaleCancelled<T0, T1>{
            presale_id        : arg0,
            total_commitments : arg1,
            refundable_quote  : arg2,
        };
        0x2::event::emit<PresaleCancelled<T0, T1>>(v0);
    }

    public(friend) fun presale_funded<T0, T1>(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64) {
        let v0 = PresaleFunded<T0, T1>{
            presale_id            : arg0,
            total_commitments     : arg1,
            accepted_quote        : arg2,
            refundable_quote      : arg3,
            token_allocation      : arg4,
            end_ms                : arg5,
            liquidity_deadline_ms : arg6,
        };
        0x2::event::emit<PresaleFunded<T0, T1>>(v0);
    }

    public(friend) fun presale_migrated<T0, T1>(arg0: 0x2::object::ID, arg1: 0x1::type_name::TypeName, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = PresaleMigrated<T0, T1>{
            presale_id       : arg0,
            venue            : arg1,
            liquidity_quote  : arg2,
            liquidity_tokens : arg3,
            recipient_tokens : arg4,
        };
        0x2::event::emit<PresaleMigrated<T0, T1>>(v0);
    }

    public(friend) fun presale_opened<T0, T1>(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: 0x1::option::Option<u64>, arg6: 0x1::option::Option<0x2::object::ID>) {
        let v0 = PresaleOpened<T0, T1>{
            presale_id            : arg0,
            start_ms              : arg1,
            end_ms                : arg2,
            liquidity_deadline_ms : arg3,
            uncapped_from_ms      : arg4,
            hard_cap_from_ms      : arg5,
            partner_id            : arg6,
        };
        0x2::event::emit<PresaleOpened<T0, T1>>(v0);
    }

    public(friend) fun protocol_fees_changed<T0, T1>(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64) {
        let v0 = ProtocolFeesChanged<T0, T1>{
            presale_id                : arg0,
            protocol_raise_bps        : arg1,
            protocol_token_bps        : arg2,
            protocol_lp_fee_meme_bps  : arg3,
            protocol_lp_fee_quote_bps : arg4,
            protocol_quote            : arg5,
            protocol_tokens           : arg6,
            token_allocation          : arg7,
        };
        0x2::event::emit<ProtocolFeesChanged<T0, T1>>(v0);
    }

    public(friend) fun quote_allowed<T0>(arg0: bool) {
        let v0 = QuoteAllowed<T0>{allowed: arg0};
        0x2::event::emit<QuoteAllowed<T0>>(v0);
    }

    public(friend) fun raise_allocated<T0, T1>(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: 0x1::option::Option<0x2::object::ID>) {
        let v0 = RaiseAllocated<T0, T1>{
            presale_id : arg0,
            recipient  : arg1,
            quote      : arg2,
            vesting_id : arg3,
        };
        0x2::event::emit<RaiseAllocated<T0, T1>>(v0);
    }

    public(friend) fun recipient_allocated<T0, T1>(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: 0x1::option::Option<0x2::object::ID>) {
        let v0 = RecipientAllocated<T0, T1>{
            presale_id : arg0,
            recipient  : arg1,
            tokens     : arg2,
            vesting_id : arg3,
        };
        0x2::event::emit<RecipientAllocated<T0, T1>>(v0);
    }

    // decompiled from Move bytecode v7
}

