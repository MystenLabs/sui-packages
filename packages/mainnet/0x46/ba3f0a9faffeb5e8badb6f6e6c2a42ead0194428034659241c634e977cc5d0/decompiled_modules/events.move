module 0x46ba3f0a9faffeb5e8badb6f6e6c2a42ead0194428034659241c634e977cc5d0::events {
    struct MarketCreated has copy, drop {
        market_id: 0x2::object::ID,
        market_number: u64,
        token_symbol: 0x1::string::String,
        target_price: u64,
        duration: u8,
        deadline: u64,
        trading_cutoff: u64,
        initial_liquidity: u64,
    }

    struct SharesBought has copy, drop {
        market_id: 0x2::object::ID,
        buyer: address,
        side: u8,
        usdc_in: u64,
        shares_out: u64,
        avg_price: u64,
        new_yes_price: u64,
        new_no_price: u64,
        new_yes_balance: u64,
        new_no_balance: u64,
    }

    struct SharesSold has copy, drop {
        market_id: 0x2::object::ID,
        seller: address,
        side: u8,
        shares_in: u64,
        usdc_out: u64,
        avg_price: u64,
        new_yes_price: u64,
        new_no_price: u64,
        new_yes_balance: u64,
        new_no_balance: u64,
    }

    struct MarketResolved has copy, drop {
        market_id: 0x2::object::ID,
        outcome: u8,
        resolved_price: u64,
        resolver: address,
    }

    struct SharesRedeemed has copy, drop {
        market_id: 0x2::object::ID,
        redeemer: address,
        winning_shares: u64,
        usdc_out: u64,
    }

    struct SharesRefunded has copy, drop {
        market_id: 0x2::object::ID,
        holder: address,
        total_shares: u64,
        usdc_out: u64,
    }

    struct SharesMerged has copy, drop {
        market_id: 0x2::object::ID,
        caller: address,
        pairs_merged: u64,
        usdc_out: u64,
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

    struct FeedAdded has copy, drop {
        token_symbol: 0x1::string::String,
        feed_id: vector<u8>,
    }

    struct TreasuryWithdrawn has copy, drop {
        amount: u64,
        recipient: address,
    }

    struct FeesCollected has copy, drop {
        market_id: 0x2::object::ID,
        amount: u64,
    }

    struct SharesMinted has copy, drop {
        market_id: 0x2::object::ID,
        minter: address,
        amount: u64,
    }

    struct PoolWithdrawn has copy, drop {
        market_id: 0x2::object::ID,
        admin: address,
        usdc_out: u64,
    }

    struct UnclaimedSwept has copy, drop {
        market_id: 0x2::object::ID,
        amount: u64,
    }

    struct FeedRemoved has copy, drop {
        token_symbol: 0x1::string::String,
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

    public(friend) fun emit_market_created(arg0: 0x2::object::ID, arg1: u64, arg2: 0x1::string::String, arg3: u64, arg4: u8, arg5: u64, arg6: u64, arg7: u64) {
        let v0 = MarketCreated{
            market_id         : arg0,
            market_number     : arg1,
            token_symbol      : arg2,
            target_price      : arg3,
            duration          : arg4,
            deadline          : arg5,
            trading_cutoff    : arg6,
            initial_liquidity : arg7,
        };
        0x2::event::emit<MarketCreated>(v0);
    }

    public(friend) fun emit_market_resolved(arg0: 0x2::object::ID, arg1: u8, arg2: u64, arg3: address) {
        let v0 = MarketResolved{
            market_id      : arg0,
            outcome        : arg1,
            resolved_price : arg2,
            resolver       : arg3,
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

    public(friend) fun emit_paused() {
        let v0 = ProtocolPaused{dummy_field: false};
        0x2::event::emit<ProtocolPaused>(v0);
    }

    public(friend) fun emit_pool_withdrawn(arg0: 0x2::object::ID, arg1: address, arg2: u64) {
        let v0 = PoolWithdrawn{
            market_id : arg0,
            admin     : arg1,
            usdc_out  : arg2,
        };
        0x2::event::emit<PoolWithdrawn>(v0);
    }

    public(friend) fun emit_shares_bought(arg0: 0x2::object::ID, arg1: address, arg2: u8, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64) {
        let v0 = SharesBought{
            market_id       : arg0,
            buyer           : arg1,
            side            : arg2,
            usdc_in         : arg3,
            shares_out      : arg4,
            avg_price       : arg5,
            new_yes_price   : arg6,
            new_no_price    : arg7,
            new_yes_balance : arg8,
            new_no_balance  : arg9,
        };
        0x2::event::emit<SharesBought>(v0);
    }

    public(friend) fun emit_shares_merged(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64) {
        let v0 = SharesMerged{
            market_id    : arg0,
            caller       : arg1,
            pairs_merged : arg2,
            usdc_out     : arg3,
        };
        0x2::event::emit<SharesMerged>(v0);
    }

    public(friend) fun emit_shares_minted(arg0: 0x2::object::ID, arg1: address, arg2: u64) {
        let v0 = SharesMinted{
            market_id : arg0,
            minter    : arg1,
            amount    : arg2,
        };
        0x2::event::emit<SharesMinted>(v0);
    }

    public(friend) fun emit_shares_redeemed(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64) {
        let v0 = SharesRedeemed{
            market_id      : arg0,
            redeemer       : arg1,
            winning_shares : arg2,
            usdc_out       : arg3,
        };
        0x2::event::emit<SharesRedeemed>(v0);
    }

    public(friend) fun emit_shares_refunded(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64) {
        let v0 = SharesRefunded{
            market_id    : arg0,
            holder       : arg1,
            total_shares : arg2,
            usdc_out     : arg3,
        };
        0x2::event::emit<SharesRefunded>(v0);
    }

    public(friend) fun emit_shares_sold(arg0: 0x2::object::ID, arg1: address, arg2: u8, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64) {
        let v0 = SharesSold{
            market_id       : arg0,
            seller          : arg1,
            side            : arg2,
            shares_in       : arg3,
            usdc_out        : arg4,
            avg_price       : arg5,
            new_yes_price   : arg6,
            new_no_price    : arg7,
            new_yes_balance : arg8,
            new_no_balance  : arg9,
        };
        0x2::event::emit<SharesSold>(v0);
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

