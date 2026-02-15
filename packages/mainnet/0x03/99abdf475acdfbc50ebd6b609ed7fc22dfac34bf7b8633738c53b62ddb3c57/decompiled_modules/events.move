module 0x399abdf475acdfbc50ebd6b609ed7fc22dfac34bf7b8633738c53b62ddb3c57::events {
    struct MarketCreated has copy, drop {
        market_id: 0x2::object::ID,
        market_number: u64,
        token_symbol: 0x1::string::String,
        target_price: u64,
        duration: u8,
        deadline: u64,
        trading_cutoff: u64,
    }

    struct Deposited has copy, drop {
        market_id: 0x2::object::ID,
        depositor: address,
        side: u8,
        amount: u64,
        new_yes_total: u64,
        new_no_total: u64,
    }

    struct MarketResolved has copy, drop {
        market_id: 0x2::object::ID,
        outcome: u8,
        resolved_price: u64,
        resolver: address,
        yes_total: u64,
        no_total: u64,
        rake: u64,
    }

    struct Claimed has copy, drop {
        market_id: 0x2::object::ID,
        claimer: address,
        winning_amount: u64,
        payout: u64,
    }

    struct Refunded has copy, drop {
        market_id: 0x2::object::ID,
        holder: address,
        refund_amount: u64,
    }

    struct MarketVoided has copy, drop {
        market_id: 0x2::object::ID,
        reason: 0x1::string::String,
    }

    struct ProtocolPaused has copy, drop {
        dummy_field: bool,
    }

    struct ProtocolUnpaused has copy, drop {
        dummy_field: bool,
    }

    struct FeeUpdated has copy, drop {
        fee_bps: u16,
    }

    struct LimitsUpdated has copy, drop {
        min_bet: u64,
        max_bet: u64,
        min_pool: u64,
    }

    struct FeedAdded has copy, drop {
        token_symbol: 0x1::string::String,
        feed_id: vector<u8>,
    }

    struct FeedRemoved has copy, drop {
        token_symbol: 0x1::string::String,
    }

    struct FeesCollected has copy, drop {
        market_id: 0x2::object::ID,
        amount: u64,
    }

    struct UnclaimedSwept has copy, drop {
        market_id: 0x2::object::ID,
        amount: u64,
    }

    struct TreasuryWithdrawn has copy, drop {
        amount: u64,
        recipient: address,
    }

    struct Migrated has copy, drop {
        from_version: u64,
        to_version: u64,
    }

    public(friend) fun emit_claimed(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64) {
        let v0 = Claimed{
            market_id      : arg0,
            claimer        : arg1,
            winning_amount : arg2,
            payout         : arg3,
        };
        0x2::event::emit<Claimed>(v0);
    }

    public(friend) fun emit_deposited(arg0: 0x2::object::ID, arg1: address, arg2: u8, arg3: u64, arg4: u64, arg5: u64) {
        let v0 = Deposited{
            market_id     : arg0,
            depositor     : arg1,
            side          : arg2,
            amount        : arg3,
            new_yes_total : arg4,
            new_no_total  : arg5,
        };
        0x2::event::emit<Deposited>(v0);
    }

    public(friend) fun emit_fee_updated(arg0: u16) {
        let v0 = FeeUpdated{fee_bps: arg0};
        0x2::event::emit<FeeUpdated>(v0);
    }

    public(friend) fun emit_feed_added(arg0: 0x1::string::String, arg1: vector<u8>) {
        let v0 = FeedAdded{
            token_symbol : arg0,
            feed_id      : arg1,
        };
        0x2::event::emit<FeedAdded>(v0);
    }

    public(friend) fun emit_feed_removed(arg0: 0x1::string::String) {
        let v0 = FeedRemoved{token_symbol: arg0};
        0x2::event::emit<FeedRemoved>(v0);
    }

    public(friend) fun emit_fees_collected(arg0: 0x2::object::ID, arg1: u64) {
        let v0 = FeesCollected{
            market_id : arg0,
            amount    : arg1,
        };
        0x2::event::emit<FeesCollected>(v0);
    }

    public(friend) fun emit_limits_updated(arg0: u64, arg1: u64, arg2: u64) {
        let v0 = LimitsUpdated{
            min_bet  : arg0,
            max_bet  : arg1,
            min_pool : arg2,
        };
        0x2::event::emit<LimitsUpdated>(v0);
    }

    public(friend) fun emit_market_created(arg0: 0x2::object::ID, arg1: u64, arg2: 0x1::string::String, arg3: u64, arg4: u8, arg5: u64, arg6: u64) {
        let v0 = MarketCreated{
            market_id      : arg0,
            market_number  : arg1,
            token_symbol   : arg2,
            target_price   : arg3,
            duration       : arg4,
            deadline       : arg5,
            trading_cutoff : arg6,
        };
        0x2::event::emit<MarketCreated>(v0);
    }

    public(friend) fun emit_market_resolved(arg0: 0x2::object::ID, arg1: u8, arg2: u64, arg3: address, arg4: u64, arg5: u64, arg6: u64) {
        let v0 = MarketResolved{
            market_id      : arg0,
            outcome        : arg1,
            resolved_price : arg2,
            resolver       : arg3,
            yes_total      : arg4,
            no_total       : arg5,
            rake           : arg6,
        };
        0x2::event::emit<MarketResolved>(v0);
    }

    public(friend) fun emit_market_voided(arg0: 0x2::object::ID, arg1: 0x1::string::String) {
        let v0 = MarketVoided{
            market_id : arg0,
            reason    : arg1,
        };
        0x2::event::emit<MarketVoided>(v0);
    }

    public(friend) fun emit_migrated(arg0: u64, arg1: u64) {
        let v0 = Migrated{
            from_version : arg0,
            to_version   : arg1,
        };
        0x2::event::emit<Migrated>(v0);
    }

    public(friend) fun emit_paused() {
        let v0 = ProtocolPaused{dummy_field: false};
        0x2::event::emit<ProtocolPaused>(v0);
    }

    public(friend) fun emit_refunded(arg0: 0x2::object::ID, arg1: address, arg2: u64) {
        let v0 = Refunded{
            market_id     : arg0,
            holder        : arg1,
            refund_amount : arg2,
        };
        0x2::event::emit<Refunded>(v0);
    }

    public(friend) fun emit_treasury_withdrawn(arg0: u64, arg1: address) {
        let v0 = TreasuryWithdrawn{
            amount    : arg0,
            recipient : arg1,
        };
        0x2::event::emit<TreasuryWithdrawn>(v0);
    }

    public(friend) fun emit_unclaimed_swept(arg0: 0x2::object::ID, arg1: u64) {
        let v0 = UnclaimedSwept{
            market_id : arg0,
            amount    : arg1,
        };
        0x2::event::emit<UnclaimedSwept>(v0);
    }

    public(friend) fun emit_unpaused() {
        let v0 = ProtocolUnpaused{dummy_field: false};
        0x2::event::emit<ProtocolUnpaused>(v0);
    }

    // decompiled from Move bytecode v6
}

