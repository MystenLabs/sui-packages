module 0xf836c1c2c2b32e0994bb68584ac390d03793759b7c1df78303cdf1346a6e7664::events {
    struct MarketCreated has copy, drop {
        market_id: 0x2::object::ID,
        market_number: u64,
        token_symbol: 0x1::string::String,
        target_price: u64,
        duration: u8,
        deadline: u64,
        trading_cutoff: u64,
        virtual_amount: u64,
        fee_bps: u16,
    }

    struct SharesBought has copy, drop {
        market_id: 0x2::object::ID,
        buyer: address,
        side: u8,
        usdc_in: u64,
        shares_out: u64,
        avg_price: u64,
        fee: u64,
        new_yes_price: u64,
        new_no_price: u64,
        yes_pool: u64,
        no_pool: u64,
        real_balance: u64,
        yes_supply: u64,
        no_supply: u64,
    }

    struct SharesSold has copy, drop {
        market_id: 0x2::object::ID,
        seller: address,
        side: u8,
        shares_in: u64,
        usdc_out: u64,
        avg_price: u64,
        fee: u64,
        new_yes_price: u64,
        new_no_price: u64,
        yes_pool: u64,
        no_pool: u64,
        real_balance: u64,
        yes_supply: u64,
        no_supply: u64,
    }

    struct MarketResolved has copy, drop {
        market_id: 0x2::object::ID,
        outcome: u8,
        resolved_price: u64,
        resolver: address,
        yes_supply: u64,
        no_supply: u64,
        real_balance: u64,
        payout_per_share: u64,
    }

    struct MarketVoided has copy, drop {
        market_id: 0x2::object::ID,
        reason: 0x1::string::String,
    }

    struct SharesRedeemed has copy, drop {
        market_id: 0x2::object::ID,
        redeemer: address,
        shares: u64,
        usdc_out: u64,
    }

    struct SharesRefunded has copy, drop {
        market_id: 0x2::object::ID,
        holder: address,
        shares: u64,
        usdc_out: u64,
    }

    struct FeesCollected has copy, drop {
        market_id: 0x2::object::ID,
        amount: u64,
    }

    struct FeeUpdated has copy, drop {
        fee_bps: u16,
    }

    struct FeedAdded has copy, drop {
        token_symbol: 0x1::string::String,
        pyth_feed_id: vector<u8>,
    }

    struct FeedRemoved has copy, drop {
        token_symbol: 0x1::string::String,
    }

    struct Paused has copy, drop {
        dummy_field: bool,
    }

    struct Unpaused has copy, drop {
        dummy_field: bool,
    }

    struct UnclaimedSwept has copy, drop {
        market_id: 0x2::object::ID,
        amount: u64,
    }

    public(friend) fun emit_fee_updated(arg0: u16) {
        let v0 = FeeUpdated{fee_bps: arg0};
        0x2::event::emit<FeeUpdated>(v0);
    }

    public(friend) fun emit_feed_added(arg0: 0x1::string::String, arg1: vector<u8>) {
        let v0 = FeedAdded{
            token_symbol : arg0,
            pyth_feed_id : arg1,
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

    public(friend) fun emit_market_created(arg0: 0x2::object::ID, arg1: u64, arg2: 0x1::string::String, arg3: u64, arg4: u8, arg5: u64, arg6: u64, arg7: u64, arg8: u16) {
        let v0 = MarketCreated{
            market_id      : arg0,
            market_number  : arg1,
            token_symbol   : arg2,
            target_price   : arg3,
            duration       : arg4,
            deadline       : arg5,
            trading_cutoff : arg6,
            virtual_amount : arg7,
            fee_bps        : arg8,
        };
        0x2::event::emit<MarketCreated>(v0);
    }

    public(friend) fun emit_market_resolved(arg0: 0x2::object::ID, arg1: u8, arg2: u64, arg3: address, arg4: u64, arg5: u64, arg6: u64, arg7: u64) {
        let v0 = MarketResolved{
            market_id        : arg0,
            outcome          : arg1,
            resolved_price   : arg2,
            resolver         : arg3,
            yes_supply       : arg4,
            no_supply        : arg5,
            real_balance     : arg6,
            payout_per_share : arg7,
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
        let v0 = Paused{dummy_field: false};
        0x2::event::emit<Paused>(v0);
    }

    public(friend) fun emit_shares_bought(arg0: 0x2::object::ID, arg1: address, arg2: u8, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64) {
        let v0 = SharesBought{
            market_id     : arg0,
            buyer         : arg1,
            side          : arg2,
            usdc_in       : arg3,
            shares_out    : arg4,
            avg_price     : arg5,
            fee           : arg6,
            new_yes_price : arg7,
            new_no_price  : arg8,
            yes_pool      : arg9,
            no_pool       : arg10,
            real_balance  : arg11,
            yes_supply    : arg12,
            no_supply     : arg13,
        };
        0x2::event::emit<SharesBought>(v0);
    }

    public(friend) fun emit_shares_redeemed(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64) {
        let v0 = SharesRedeemed{
            market_id : arg0,
            redeemer  : arg1,
            shares    : arg2,
            usdc_out  : arg3,
        };
        0x2::event::emit<SharesRedeemed>(v0);
    }

    public(friend) fun emit_shares_refunded(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64) {
        let v0 = SharesRefunded{
            market_id : arg0,
            holder    : arg1,
            shares    : arg2,
            usdc_out  : arg3,
        };
        0x2::event::emit<SharesRefunded>(v0);
    }

    public(friend) fun emit_shares_sold(arg0: 0x2::object::ID, arg1: address, arg2: u8, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64) {
        let v0 = SharesSold{
            market_id     : arg0,
            seller        : arg1,
            side          : arg2,
            shares_in     : arg3,
            usdc_out      : arg4,
            avg_price     : arg5,
            fee           : arg6,
            new_yes_price : arg7,
            new_no_price  : arg8,
            yes_pool      : arg9,
            no_pool       : arg10,
            real_balance  : arg11,
            yes_supply    : arg12,
            no_supply     : arg13,
        };
        0x2::event::emit<SharesSold>(v0);
    }

    public(friend) fun emit_unclaimed_swept(arg0: 0x2::object::ID, arg1: u64) {
        let v0 = UnclaimedSwept{
            market_id : arg0,
            amount    : arg1,
        };
        0x2::event::emit<UnclaimedSwept>(v0);
    }

    public(friend) fun emit_unpaused() {
        let v0 = Unpaused{dummy_field: false};
        0x2::event::emit<Unpaused>(v0);
    }

    // decompiled from Move bytecode v6
}

