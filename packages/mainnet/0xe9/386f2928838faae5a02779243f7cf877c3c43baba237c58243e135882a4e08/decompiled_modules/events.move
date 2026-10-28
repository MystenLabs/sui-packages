module 0xe9386f2928838faae5a02779243f7cf877c3c43baba237c58243e135882a4e08::events {
    struct FeesQueued has copy, drop {
        config: 0x2::object::ID,
        treasury: address,
        keys: vector<u8>,
        bps: vector<u16>,
        at_ms: u64,
    }

    struct FeesApplied has copy, drop {
        config: 0x2::object::ID,
        treasury: address,
        keys: vector<u8>,
        bps: vector<u16>,
    }

    struct FeesDiscarded has copy, drop {
        config: 0x2::object::ID,
    }

    struct MarketHalted has copy, drop {
        config: 0x2::object::ID,
        halted: bool,
    }

    struct MarketMigrated has copy, drop {
        config: 0x2::object::ID,
        rev: u64,
    }

    struct AskPosted has copy, drop {
        ask: 0x2::object::ID,
        seller: address,
        item: 0x2::object::ID,
        kind: 0x1::type_name::TypeName,
        kiosk: 0x1::option::Option<0x2::object::ID>,
        price: u64,
        fee: u64,
        repost: bool,
    }

    struct AskWithdrawn has copy, drop {
        ask: 0x2::object::ID,
        seller: address,
        item: 0x2::object::ID,
        kind: 0x1::type_name::TypeName,
        kiosk: 0x1::option::Option<0x2::object::ID>,
        price: u64,
    }

    struct AskFilled has copy, drop {
        ask: 0x2::object::ID,
        seller: address,
        buyer: address,
        item: 0x2::object::ID,
        kind: 0x1::type_name::TypeName,
        kiosk: 0x1::option::Option<0x2::object::ID>,
        buyer_kiosk: 0x1::option::Option<0x2::object::ID>,
        price: u64,
        fee: u64,
        royalty: u64,
    }

    struct BidPosted has copy, drop {
        bid: 0x2::object::ID,
        pool: 0x1::option::Option<0x2::object::ID>,
        bidder: address,
        kind: 0x1::type_name::TypeName,
        item: 0x1::option::Option<0x2::object::ID>,
        root: 0x1::option::Option<vector<u8>>,
        price: u64,
        fee: u64,
        reserve: u64,
        units: u64,
        ends_ms: 0x1::option::Option<u64>,
        dest: 0x1::option::Option<0x2::object::ID>,
    }

    struct BidFilled has copy, drop {
        bid: 0x2::object::ID,
        pool: 0x1::option::Option<0x2::object::ID>,
        bidder: address,
        seller: address,
        item: 0x2::object::ID,
        kind: 0x1::type_name::TypeName,
        price: u64,
        fee: u64,
        royalty: u64,
        refund: u64,
        units_left: u64,
        seller_kiosk: 0x1::option::Option<0x2::object::ID>,
        dest: 0x1::option::Option<0x2::object::ID>,
    }

    struct BidClosed has copy, drop {
        bid: 0x2::object::ID,
        pool: 0x1::option::Option<0x2::object::ID>,
        bidder: address,
        units_left: u64,
        refund: u64,
        cause: u8,
    }

    struct PoolOpened has copy, drop {
        pool: 0x2::object::ID,
        owner: address,
        label: 0x1::option::Option<0x1::string::String>,
    }

    struct PoolState has copy, drop {
        pool: 0x2::object::ID,
        owner: address,
        funds: u64,
        reserved: u64,
        members: u64,
        label: 0x1::option::Option<0x1::string::String>,
    }

    struct PoolClosed has copy, drop {
        pool: 0x2::object::ID,
        owner: address,
        refund: u64,
    }

    struct SwapOffered has copy, drop {
        deal: 0x2::object::ID,
        maker: address,
        taker: 0x1::option::Option<address>,
        maker_kiosk: 0x2::object::ID,
        give: vector<0x2::object::ID>,
        want: vector<0x2::object::ID>,
        ask: u64,
        bid: u64,
        ends_ms: 0x1::option::Option<u64>,
    }

    struct SwapDone has copy, drop {
        deal: 0x2::object::ID,
        maker: address,
        taker: address,
        give: vector<0x2::object::ID>,
        want: vector<0x2::object::ID>,
        ask: u64,
        bid: u64,
        fee: u64,
    }

    struct SwapCancelled has copy, drop {
        deal: 0x2::object::ID,
        maker: address,
        by: address,
        refund: u64,
        lapsed: bool,
    }

    struct RaffleOpened has copy, drop {
        raffle: 0x2::object::ID,
        host: address,
        item: 0x2::object::ID,
        kind: 0x1::type_name::TypeName,
        host_kiosk: 0x1::option::Option<0x2::object::ID>,
        price: u64,
        min_tickets: u64,
        max_tickets: u64,
        ends_ms: u64,
        fee_bps: u16,
    }

    struct TicketsBought has copy, drop {
        raffle: 0x2::object::ID,
        buyer: address,
        first: u64,
        qty: u64,
        paid: u64,
        sold: u64,
    }

    struct RaffleDrawn has copy, drop {
        raffle: 0x2::object::ID,
        winner: address,
        ticket: u64,
        sold: u64,
    }

    struct RaffleSettled has copy, drop {
        raffle: 0x2::object::ID,
        winner: address,
        host: address,
        gross: u64,
        fee: u64,
        royalty: u64,
        to_host: u64,
        winner_kiosk: 0x1::option::Option<0x2::object::ID>,
    }

    struct RaffleVoided has copy, drop {
        raffle: 0x2::object::ID,
        host: address,
        by: address,
        sold: u64,
        pot: u64,
    }

    struct RaffleRefunded has copy, drop {
        raffle: 0x2::object::ID,
        holder: address,
        qty: u64,
        amount: u64,
    }

    struct BundleListed has copy, drop {
        bundle: 0x2::object::ID,
        maker: address,
        items: vector<0x2::object::ID>,
        kinds: vector<0x1::type_name::TypeName>,
        ask: u64,
        sealed_reserve: bool,
    }

    struct BundleResealed has copy, drop {
        bundle: 0x2::object::ID,
        sealed_reserve: bool,
    }

    struct BundleClosed has copy, drop {
        bundle: 0x2::object::ID,
        maker: address,
        reason: u8,
    }

    struct BundleSold has copy, drop {
        bundle: 0x2::object::ID,
        maker: address,
        buyer: address,
        price: u64,
        fee: u64,
        royalty: u64,
        bid: 0x1::option::Option<0x2::object::ID>,
    }

    struct BundleBidPlaced has copy, drop {
        bid: 0x2::object::ID,
        bundle: 0x2::object::ID,
        bidder: address,
        amount: u64,
        fee: u64,
        reserve: u64,
        until_ms: u64,
        dest_kiosk: 0x2::object::ID,
    }

    struct BundleBidClosed has copy, drop {
        bid: 0x2::object::ID,
        bidder: address,
        refunded: u64,
        reason: u8,
    }

    public(friend) fun ask_filled(arg0: 0x2::object::ID, arg1: address, arg2: address, arg3: 0x2::object::ID, arg4: 0x1::type_name::TypeName, arg5: 0x1::option::Option<0x2::object::ID>, arg6: 0x1::option::Option<0x2::object::ID>, arg7: u64, arg8: u64, arg9: u64) {
        let v0 = AskFilled{
            ask         : arg0,
            seller      : arg1,
            buyer       : arg2,
            item        : arg3,
            kind        : arg4,
            kiosk       : arg5,
            buyer_kiosk : arg6,
            price       : arg7,
            fee         : arg8,
            royalty     : arg9,
        };
        0x2::event::emit<AskFilled>(v0);
    }

    public(friend) fun ask_posted(arg0: 0x2::object::ID, arg1: address, arg2: 0x2::object::ID, arg3: 0x1::type_name::TypeName, arg4: 0x1::option::Option<0x2::object::ID>, arg5: u64, arg6: u64, arg7: bool) {
        let v0 = AskPosted{
            ask    : arg0,
            seller : arg1,
            item   : arg2,
            kind   : arg3,
            kiosk  : arg4,
            price  : arg5,
            fee    : arg6,
            repost : arg7,
        };
        0x2::event::emit<AskPosted>(v0);
    }

    public(friend) fun ask_withdrawn(arg0: 0x2::object::ID, arg1: address, arg2: 0x2::object::ID, arg3: 0x1::type_name::TypeName, arg4: 0x1::option::Option<0x2::object::ID>, arg5: u64) {
        let v0 = AskWithdrawn{
            ask    : arg0,
            seller : arg1,
            item   : arg2,
            kind   : arg3,
            kiosk  : arg4,
            price  : arg5,
        };
        0x2::event::emit<AskWithdrawn>(v0);
    }

    public(friend) fun bid_closed(arg0: 0x2::object::ID, arg1: 0x1::option::Option<0x2::object::ID>, arg2: address, arg3: u64, arg4: u64, arg5: u8) {
        let v0 = BidClosed{
            bid        : arg0,
            pool       : arg1,
            bidder     : arg2,
            units_left : arg3,
            refund     : arg4,
            cause      : arg5,
        };
        0x2::event::emit<BidClosed>(v0);
    }

    public(friend) fun bid_filled(arg0: 0x2::object::ID, arg1: 0x1::option::Option<0x2::object::ID>, arg2: address, arg3: address, arg4: 0x2::object::ID, arg5: 0x1::type_name::TypeName, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: 0x1::option::Option<0x2::object::ID>, arg12: 0x1::option::Option<0x2::object::ID>) {
        let v0 = BidFilled{
            bid          : arg0,
            pool         : arg1,
            bidder       : arg2,
            seller       : arg3,
            item         : arg4,
            kind         : arg5,
            price        : arg6,
            fee          : arg7,
            royalty      : arg8,
            refund       : arg9,
            units_left   : arg10,
            seller_kiosk : arg11,
            dest         : arg12,
        };
        0x2::event::emit<BidFilled>(v0);
    }

    public(friend) fun bid_posted(arg0: 0x2::object::ID, arg1: 0x1::option::Option<0x2::object::ID>, arg2: address, arg3: 0x1::type_name::TypeName, arg4: 0x1::option::Option<0x2::object::ID>, arg5: 0x1::option::Option<vector<u8>>, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: 0x1::option::Option<u64>, arg11: 0x1::option::Option<0x2::object::ID>) {
        let v0 = BidPosted{
            bid     : arg0,
            pool    : arg1,
            bidder  : arg2,
            kind    : arg3,
            item    : arg4,
            root    : arg5,
            price   : arg6,
            fee     : arg7,
            reserve : arg8,
            units   : arg9,
            ends_ms : arg10,
            dest    : arg11,
        };
        0x2::event::emit<BidPosted>(v0);
    }

    public(friend) fun bundle_bid_closed(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u8) {
        let v0 = BundleBidClosed{
            bid      : arg0,
            bidder   : arg1,
            refunded : arg2,
            reason   : arg3,
        };
        0x2::event::emit<BundleBidClosed>(v0);
    }

    public(friend) fun bundle_bid_placed(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: address, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: 0x2::object::ID) {
        let v0 = BundleBidPlaced{
            bid        : arg0,
            bundle     : arg1,
            bidder     : arg2,
            amount     : arg3,
            fee        : arg4,
            reserve    : arg5,
            until_ms   : arg6,
            dest_kiosk : arg7,
        };
        0x2::event::emit<BundleBidPlaced>(v0);
    }

    public(friend) fun bundle_closed(arg0: 0x2::object::ID, arg1: address, arg2: u8) {
        let v0 = BundleClosed{
            bundle : arg0,
            maker  : arg1,
            reason : arg2,
        };
        0x2::event::emit<BundleClosed>(v0);
    }

    public(friend) fun bundle_listed(arg0: 0x2::object::ID, arg1: address, arg2: vector<0x2::object::ID>, arg3: vector<0x1::type_name::TypeName>, arg4: u64, arg5: bool) {
        let v0 = BundleListed{
            bundle         : arg0,
            maker          : arg1,
            items          : arg2,
            kinds          : arg3,
            ask            : arg4,
            sealed_reserve : arg5,
        };
        0x2::event::emit<BundleListed>(v0);
    }

    public(friend) fun bundle_resealed(arg0: 0x2::object::ID, arg1: bool) {
        let v0 = BundleResealed{
            bundle         : arg0,
            sealed_reserve : arg1,
        };
        0x2::event::emit<BundleResealed>(v0);
    }

    public(friend) fun bundle_sold(arg0: 0x2::object::ID, arg1: address, arg2: address, arg3: u64, arg4: u64, arg5: u64, arg6: 0x1::option::Option<0x2::object::ID>) {
        let v0 = BundleSold{
            bundle  : arg0,
            maker   : arg1,
            buyer   : arg2,
            price   : arg3,
            fee     : arg4,
            royalty : arg5,
            bid     : arg6,
        };
        0x2::event::emit<BundleSold>(v0);
    }

    public(friend) fun fees_applied(arg0: 0x2::object::ID, arg1: address, arg2: vector<u8>, arg3: vector<u16>) {
        let v0 = FeesApplied{
            config   : arg0,
            treasury : arg1,
            keys     : arg2,
            bps      : arg3,
        };
        0x2::event::emit<FeesApplied>(v0);
    }

    public(friend) fun fees_discarded(arg0: 0x2::object::ID) {
        let v0 = FeesDiscarded{config: arg0};
        0x2::event::emit<FeesDiscarded>(v0);
    }

    public(friend) fun fees_queued(arg0: 0x2::object::ID, arg1: address, arg2: vector<u8>, arg3: vector<u16>, arg4: u64) {
        let v0 = FeesQueued{
            config   : arg0,
            treasury : arg1,
            keys     : arg2,
            bps      : arg3,
            at_ms    : arg4,
        };
        0x2::event::emit<FeesQueued>(v0);
    }

    public(friend) fun market_halted(arg0: 0x2::object::ID, arg1: bool) {
        let v0 = MarketHalted{
            config : arg0,
            halted : arg1,
        };
        0x2::event::emit<MarketHalted>(v0);
    }

    public(friend) fun market_migrated(arg0: 0x2::object::ID, arg1: u64) {
        let v0 = MarketMigrated{
            config : arg0,
            rev    : arg1,
        };
        0x2::event::emit<MarketMigrated>(v0);
    }

    public(friend) fun pool_closed(arg0: 0x2::object::ID, arg1: address, arg2: u64) {
        let v0 = PoolClosed{
            pool   : arg0,
            owner  : arg1,
            refund : arg2,
        };
        0x2::event::emit<PoolClosed>(v0);
    }

    public(friend) fun pool_opened(arg0: 0x2::object::ID, arg1: address, arg2: 0x1::option::Option<0x1::string::String>) {
        let v0 = PoolOpened{
            pool  : arg0,
            owner : arg1,
            label : arg2,
        };
        0x2::event::emit<PoolOpened>(v0);
    }

    public(friend) fun pool_state(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64, arg4: u64, arg5: 0x1::option::Option<0x1::string::String>) {
        let v0 = PoolState{
            pool     : arg0,
            owner    : arg1,
            funds    : arg2,
            reserved : arg3,
            members  : arg4,
            label    : arg5,
        };
        0x2::event::emit<PoolState>(v0);
    }

    public(friend) fun raffle_drawn(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64) {
        let v0 = RaffleDrawn{
            raffle : arg0,
            winner : arg1,
            ticket : arg2,
            sold   : arg3,
        };
        0x2::event::emit<RaffleDrawn>(v0);
    }

    public(friend) fun raffle_opened(arg0: 0x2::object::ID, arg1: address, arg2: 0x2::object::ID, arg3: 0x1::type_name::TypeName, arg4: 0x1::option::Option<0x2::object::ID>, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u16) {
        let v0 = RaffleOpened{
            raffle      : arg0,
            host        : arg1,
            item        : arg2,
            kind        : arg3,
            host_kiosk  : arg4,
            price       : arg5,
            min_tickets : arg6,
            max_tickets : arg7,
            ends_ms     : arg8,
            fee_bps     : arg9,
        };
        0x2::event::emit<RaffleOpened>(v0);
    }

    public(friend) fun raffle_refunded(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64) {
        let v0 = RaffleRefunded{
            raffle : arg0,
            holder : arg1,
            qty    : arg2,
            amount : arg3,
        };
        0x2::event::emit<RaffleRefunded>(v0);
    }

    public(friend) fun raffle_settled(arg0: 0x2::object::ID, arg1: address, arg2: address, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: 0x1::option::Option<0x2::object::ID>) {
        let v0 = RaffleSettled{
            raffle       : arg0,
            winner       : arg1,
            host         : arg2,
            gross        : arg3,
            fee          : arg4,
            royalty      : arg5,
            to_host      : arg6,
            winner_kiosk : arg7,
        };
        0x2::event::emit<RaffleSettled>(v0);
    }

    public(friend) fun raffle_voided(arg0: 0x2::object::ID, arg1: address, arg2: address, arg3: u64, arg4: u64) {
        let v0 = RaffleVoided{
            raffle : arg0,
            host   : arg1,
            by     : arg2,
            sold   : arg3,
            pot    : arg4,
        };
        0x2::event::emit<RaffleVoided>(v0);
    }

    public(friend) fun swap_cancelled(arg0: 0x2::object::ID, arg1: address, arg2: address, arg3: u64, arg4: bool) {
        let v0 = SwapCancelled{
            deal   : arg0,
            maker  : arg1,
            by     : arg2,
            refund : arg3,
            lapsed : arg4,
        };
        0x2::event::emit<SwapCancelled>(v0);
    }

    public(friend) fun swap_done(arg0: 0x2::object::ID, arg1: address, arg2: address, arg3: vector<0x2::object::ID>, arg4: vector<0x2::object::ID>, arg5: u64, arg6: u64, arg7: u64) {
        let v0 = SwapDone{
            deal  : arg0,
            maker : arg1,
            taker : arg2,
            give  : arg3,
            want  : arg4,
            ask   : arg5,
            bid   : arg6,
            fee   : arg7,
        };
        0x2::event::emit<SwapDone>(v0);
    }

    public(friend) fun swap_offered(arg0: 0x2::object::ID, arg1: address, arg2: 0x1::option::Option<address>, arg3: 0x2::object::ID, arg4: vector<0x2::object::ID>, arg5: vector<0x2::object::ID>, arg6: u64, arg7: u64, arg8: 0x1::option::Option<u64>) {
        let v0 = SwapOffered{
            deal        : arg0,
            maker       : arg1,
            taker       : arg2,
            maker_kiosk : arg3,
            give        : arg4,
            want        : arg5,
            ask         : arg6,
            bid         : arg7,
            ends_ms     : arg8,
        };
        0x2::event::emit<SwapOffered>(v0);
    }

    public(friend) fun tickets_bought(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64, arg4: u64, arg5: u64) {
        let v0 = TicketsBought{
            raffle : arg0,
            buyer  : arg1,
            first  : arg2,
            qty    : arg3,
            paid   : arg4,
            sold   : arg5,
        };
        0x2::event::emit<TicketsBought>(v0);
    }

    // decompiled from Move bytecode v7
}

