module 0x4dfbd4cac77408992f45fd35de3b2496483e8c94cd24189c87c1029b6352daaf::events {
    struct MarketCreated has copy, drop {
        market_id: 0x2::object::ID,
        market_type: u8,
        proof_id: 0x1::string::String,
        creator: address,
        proof_creator: address,
        question: 0x1::string::String,
        token_symbol: 0x1::string::String,
        target_price: u64,
        direction: u8,
        deadline_ms: u64,
        betting_closes_ms: u64,
        designated_resolver: 0x1::option::Option<address>,
        initial_side: bool,
        initial_amount: u64,
    }

    struct BetPlaced has copy, drop {
        market_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        bettor: address,
        side: bool,
        amount: u64,
        yes_total: u64,
        no_total: u64,
    }

    struct MarketResolved has copy, drop {
        market_id: 0x2::object::ID,
        market_type: u8,
        outcome: bool,
        resolved_price: u64,
        resolver: address,
        total_pool: u64,
        platform_fee: u64,
        creator_fee: u64,
        resolver_fee: u64,
    }

    struct MarketVoided has copy, drop {
        market_id: 0x2::object::ID,
        reason: 0x1::string::String,
    }

    struct WinningsClaimed has copy, drop {
        market_id: 0x2::object::ID,
        bettor: address,
        position_amount: u64,
        payout: u64,
    }

    struct VoidRefunded has copy, drop {
        market_id: 0x2::object::ID,
        bettor: address,
        amount: u64,
    }

    struct UnclaimedSwept has copy, drop {
        market_id: 0x2::object::ID,
        amount: u64,
    }

    struct ProtocolPaused has copy, drop {
        dummy_field: bool,
    }

    struct ProtocolUnpaused has copy, drop {
        dummy_field: bool,
    }

    struct FeesUpdated has copy, drop {
        platform_fee_bps: u64,
        creator_fee_bps: u64,
        resolver_fee_bps: u64,
    }

    struct FeedAdded has copy, drop {
        token_symbol: 0x1::string::String,
        feed_id: vector<u8>,
    }

    struct FeedRemoved has copy, drop {
        token_symbol: 0x1::string::String,
    }

    struct TreasuryWithdrawn has copy, drop {
        amount: u64,
        recipient: address,
    }

    struct Migrated has copy, drop {
        old_version: u64,
        new_version: u64,
    }

    public(friend) fun emit_bet_placed(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: address, arg3: bool, arg4: u64, arg5: u64, arg6: u64) {
        let v0 = BetPlaced{
            market_id   : arg0,
            position_id : arg1,
            bettor      : arg2,
            side        : arg3,
            amount      : arg4,
            yes_total   : arg5,
            no_total    : arg6,
        };
        0x2::event::emit<BetPlaced>(v0);
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

    public(friend) fun emit_fees_updated(arg0: u64, arg1: u64, arg2: u64) {
        let v0 = FeesUpdated{
            platform_fee_bps : arg0,
            creator_fee_bps  : arg1,
            resolver_fee_bps : arg2,
        };
        0x2::event::emit<FeesUpdated>(v0);
    }

    public(friend) fun emit_market_created(arg0: 0x2::object::ID, arg1: u8, arg2: 0x1::string::String, arg3: address, arg4: address, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: u64, arg8: u8, arg9: u64, arg10: u64, arg11: 0x1::option::Option<address>, arg12: bool, arg13: u64) {
        let v0 = MarketCreated{
            market_id           : arg0,
            market_type         : arg1,
            proof_id            : arg2,
            creator             : arg3,
            proof_creator       : arg4,
            question            : arg5,
            token_symbol        : arg6,
            target_price        : arg7,
            direction           : arg8,
            deadline_ms         : arg9,
            betting_closes_ms   : arg10,
            designated_resolver : arg11,
            initial_side        : arg12,
            initial_amount      : arg13,
        };
        0x2::event::emit<MarketCreated>(v0);
    }

    public(friend) fun emit_market_resolved(arg0: 0x2::object::ID, arg1: u8, arg2: bool, arg3: u64, arg4: address, arg5: u64, arg6: u64, arg7: u64, arg8: u64) {
        let v0 = MarketResolved{
            market_id      : arg0,
            market_type    : arg1,
            outcome        : arg2,
            resolved_price : arg3,
            resolver       : arg4,
            total_pool     : arg5,
            platform_fee   : arg6,
            creator_fee    : arg7,
            resolver_fee   : arg8,
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
            old_version : arg0,
            new_version : arg1,
        };
        0x2::event::emit<Migrated>(v0);
    }

    public(friend) fun emit_paused() {
        let v0 = ProtocolPaused{dummy_field: false};
        0x2::event::emit<ProtocolPaused>(v0);
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

    public(friend) fun emit_void_refunded(arg0: 0x2::object::ID, arg1: address, arg2: u64) {
        let v0 = VoidRefunded{
            market_id : arg0,
            bettor    : arg1,
            amount    : arg2,
        };
        0x2::event::emit<VoidRefunded>(v0);
    }

    public(friend) fun emit_winnings_claimed(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64) {
        let v0 = WinningsClaimed{
            market_id       : arg0,
            bettor          : arg1,
            position_amount : arg2,
            payout          : arg3,
        };
        0x2::event::emit<WinningsClaimed>(v0);
    }

    // decompiled from Move bytecode v6
}

