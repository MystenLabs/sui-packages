module 0x465753839605ea682f147cfe5db736c7e8718798d64cd8f0fe7bd60869d64b03::events {
    struct ConfigQueued has copy, drop {
        config: 0x2::object::ID,
        ready_ms: u64,
        treasury: address,
        rates: vector<u64>,
    }

    struct ConfigApplied has copy, drop {
        config: 0x2::object::ID,
        treasury: address,
        rates: vector<u64>,
    }

    struct ConfigDiscarded has copy, drop {
        config: 0x2::object::ID,
    }

    struct ConfigPaused has copy, drop {
        config: 0x2::object::ID,
        paused: bool,
    }

    struct ConfigMigrated has copy, drop {
        config: 0x2::object::ID,
        version: u64,
    }

    struct EscrowPosted has copy, drop {
        order: 0x2::object::ID,
        item: 0x2::object::ID,
        kind: 0x1::type_name::TypeName,
        ask: u64,
        cut: u64,
        maker: address,
    }

    struct EscrowRepriced has copy, drop {
        order: 0x2::object::ID,
        item: 0x2::object::ID,
        kind: 0x1::type_name::TypeName,
        ask: u64,
        cut: u64,
        maker: address,
    }

    struct EscrowPulled has copy, drop {
        order: 0x2::object::ID,
        item: 0x2::object::ID,
        kind: 0x1::type_name::TypeName,
        ask: u64,
        maker: address,
    }

    struct EscrowTaken has copy, drop {
        order: 0x2::object::ID,
        item: 0x2::object::ID,
        kind: 0x1::type_name::TypeName,
        ask: u64,
        cut: u64,
        maker: address,
        taker: address,
    }

    struct KioskPosted has copy, drop {
        order: 0x2::object::ID,
        item: 0x2::object::ID,
        kind: 0x1::type_name::TypeName,
        ask: u64,
        cut: u64,
        maker: address,
        maker_kiosk: 0x2::object::ID,
    }

    struct KioskRepriced has copy, drop {
        old_order: 0x2::object::ID,
        new_order: 0x2::object::ID,
    }

    struct KioskPulled has copy, drop {
        order: 0x2::object::ID,
        item: 0x2::object::ID,
        kind: 0x1::type_name::TypeName,
        ask: u64,
        maker: address,
        maker_kiosk: 0x2::object::ID,
    }

    struct KioskTaken has copy, drop {
        order: 0x2::object::ID,
        item: 0x2::object::ID,
        kind: 0x1::type_name::TypeName,
        ask: u64,
        cut: u64,
        royalty: u64,
        maker: address,
        maker_kiosk: 0x2::object::ID,
        taker: address,
        taker_kiosk: 0x1::option::Option<0x2::object::ID>,
    }

    struct OfferPlaced has copy, drop {
        offer: 0x2::object::ID,
        pool: 0x1::option::Option<0x2::object::ID>,
        maker: address,
        kind: 0x1::type_name::TypeName,
        scope: u8,
        item: 0x1::option::Option<0x2::object::ID>,
        root: 0x1::option::Option<vector<u8>>,
        each: u64,
        fee: u64,
        reserve: u64,
        qty: u64,
        until_ms: 0x1::option::Option<u64>,
        dest_kiosk: 0x1::option::Option<0x2::object::ID>,
    }

    struct OfferFilled has copy, drop {
        offer: 0x2::object::ID,
        pool: 0x1::option::Option<0x2::object::ID>,
        maker: address,
        seller: address,
        kind: 0x1::type_name::TypeName,
        item: 0x2::object::ID,
        each: u64,
        fee: u64,
        royalty: u64,
        returned: u64,
        seller_kiosk: 0x1::option::Option<0x2::object::ID>,
        dest_kiosk: 0x1::option::Option<0x2::object::ID>,
        left: u64,
    }

    struct OfferClosed has copy, drop {
        offer: 0x2::object::ID,
        pool: 0x1::option::Option<0x2::object::ID>,
        maker: address,
        left: u64,
        refunded: u64,
        reason: u8,
    }

    struct PoolOpened has copy, drop {
        pool: 0x2::object::ID,
        maker: address,
        label: 0x1::option::Option<0x1::string::String>,
        funds: u64,
    }

    struct PoolFunded has copy, drop {
        pool: 0x2::object::ID,
        maker: address,
        label: 0x1::option::Option<0x1::string::String>,
        funds: u64,
        held: u64,
    }

    struct PoolClosed has copy, drop {
        pool: 0x2::object::ID,
        maker: address,
        refunded: u64,
    }

    struct DealProposed has copy, drop {
        deal: 0x2::object::ID,
        maker: address,
        maker_kiosk: 0x2::object::ID,
        taker: 0x1::option::Option<address>,
        give: vector<0x2::object::ID>,
        want: vector<0x2::object::ID>,
        ask_sui: u64,
        bid_sui: u64,
        expiry_epoch: u64,
    }

    struct DealSettled has copy, drop {
        deal: 0x2::object::ID,
        maker: address,
        taker: address,
        give: vector<0x2::object::ID>,
        want: vector<0x2::object::ID>,
        ask_sui: u64,
        fee: u64,
        bid_sui: u64,
    }

    struct DealUnwound has copy, drop {
        deal: 0x2::object::ID,
        maker: address,
        by: address,
        expired: bool,
        refunded: u64,
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

    struct CrateBought has copy, drop {
        buyer: address,
        tier: u8,
        qty: u64,
        unit: u64,
        total: u64,
    }

    struct CratePriced has copy, drop {
        tier: u8,
        price: u64,
    }

    struct CrateShopOpen has copy, drop {
        open: bool,
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

    public(friend) fun config_applied(arg0: 0x2::object::ID, arg1: address, arg2: vector<u64>) {
        let v0 = ConfigApplied{
            config   : arg0,
            treasury : arg1,
            rates    : arg2,
        };
        0x2::event::emit<ConfigApplied>(v0);
    }

    public(friend) fun config_discarded(arg0: 0x2::object::ID) {
        let v0 = ConfigDiscarded{config: arg0};
        0x2::event::emit<ConfigDiscarded>(v0);
    }

    public(friend) fun config_migrated(arg0: 0x2::object::ID, arg1: u64) {
        let v0 = ConfigMigrated{
            config  : arg0,
            version : arg1,
        };
        0x2::event::emit<ConfigMigrated>(v0);
    }

    public(friend) fun config_paused(arg0: 0x2::object::ID, arg1: bool) {
        let v0 = ConfigPaused{
            config : arg0,
            paused : arg1,
        };
        0x2::event::emit<ConfigPaused>(v0);
    }

    public(friend) fun config_queued(arg0: 0x2::object::ID, arg1: u64, arg2: address, arg3: vector<u64>) {
        let v0 = ConfigQueued{
            config   : arg0,
            ready_ms : arg1,
            treasury : arg2,
            rates    : arg3,
        };
        0x2::event::emit<ConfigQueued>(v0);
    }

    public(friend) fun crate_bought(arg0: address, arg1: u8, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = CrateBought{
            buyer : arg0,
            tier  : arg1,
            qty   : arg2,
            unit  : arg3,
            total : arg4,
        };
        0x2::event::emit<CrateBought>(v0);
    }

    public(friend) fun crate_priced(arg0: u8, arg1: u64) {
        let v0 = CratePriced{
            tier  : arg0,
            price : arg1,
        };
        0x2::event::emit<CratePriced>(v0);
    }

    public(friend) fun crate_shop_open(arg0: bool) {
        let v0 = CrateShopOpen{open: arg0};
        0x2::event::emit<CrateShopOpen>(v0);
    }

    public(friend) fun deal_proposed(arg0: 0x2::object::ID, arg1: address, arg2: 0x2::object::ID, arg3: 0x1::option::Option<address>, arg4: vector<0x2::object::ID>, arg5: vector<0x2::object::ID>, arg6: u64, arg7: u64, arg8: u64) {
        let v0 = DealProposed{
            deal         : arg0,
            maker        : arg1,
            maker_kiosk  : arg2,
            taker        : arg3,
            give         : arg4,
            want         : arg5,
            ask_sui      : arg6,
            bid_sui      : arg7,
            expiry_epoch : arg8,
        };
        0x2::event::emit<DealProposed>(v0);
    }

    public(friend) fun deal_settled(arg0: 0x2::object::ID, arg1: address, arg2: address, arg3: vector<0x2::object::ID>, arg4: vector<0x2::object::ID>, arg5: u64, arg6: u64, arg7: u64) {
        let v0 = DealSettled{
            deal    : arg0,
            maker   : arg1,
            taker   : arg2,
            give    : arg3,
            want    : arg4,
            ask_sui : arg5,
            fee     : arg6,
            bid_sui : arg7,
        };
        0x2::event::emit<DealSettled>(v0);
    }

    public(friend) fun deal_unwound(arg0: 0x2::object::ID, arg1: address, arg2: address, arg3: bool, arg4: u64) {
        let v0 = DealUnwound{
            deal     : arg0,
            maker    : arg1,
            by       : arg2,
            expired  : arg3,
            refunded : arg4,
        };
        0x2::event::emit<DealUnwound>(v0);
    }

    public(friend) fun escrow_posted(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x1::type_name::TypeName, arg3: u64, arg4: u64, arg5: address) {
        let v0 = EscrowPosted{
            order : arg0,
            item  : arg1,
            kind  : arg2,
            ask   : arg3,
            cut   : arg4,
            maker : arg5,
        };
        0x2::event::emit<EscrowPosted>(v0);
    }

    public(friend) fun escrow_pulled(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x1::type_name::TypeName, arg3: u64, arg4: address) {
        let v0 = EscrowPulled{
            order : arg0,
            item  : arg1,
            kind  : arg2,
            ask   : arg3,
            maker : arg4,
        };
        0x2::event::emit<EscrowPulled>(v0);
    }

    public(friend) fun escrow_repriced(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x1::type_name::TypeName, arg3: u64, arg4: u64, arg5: address) {
        let v0 = EscrowRepriced{
            order : arg0,
            item  : arg1,
            kind  : arg2,
            ask   : arg3,
            cut   : arg4,
            maker : arg5,
        };
        0x2::event::emit<EscrowRepriced>(v0);
    }

    public(friend) fun escrow_taken(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x1::type_name::TypeName, arg3: u64, arg4: u64, arg5: address, arg6: address) {
        let v0 = EscrowTaken{
            order : arg0,
            item  : arg1,
            kind  : arg2,
            ask   : arg3,
            cut   : arg4,
            maker : arg5,
            taker : arg6,
        };
        0x2::event::emit<EscrowTaken>(v0);
    }

    public(friend) fun kiosk_posted(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x1::type_name::TypeName, arg3: u64, arg4: u64, arg5: address, arg6: 0x2::object::ID) {
        let v0 = KioskPosted{
            order       : arg0,
            item        : arg1,
            kind        : arg2,
            ask         : arg3,
            cut         : arg4,
            maker       : arg5,
            maker_kiosk : arg6,
        };
        0x2::event::emit<KioskPosted>(v0);
    }

    public(friend) fun kiosk_pulled(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x1::type_name::TypeName, arg3: u64, arg4: address, arg5: 0x2::object::ID) {
        let v0 = KioskPulled{
            order       : arg0,
            item        : arg1,
            kind        : arg2,
            ask         : arg3,
            maker       : arg4,
            maker_kiosk : arg5,
        };
        0x2::event::emit<KioskPulled>(v0);
    }

    public(friend) fun kiosk_repriced(arg0: 0x2::object::ID, arg1: 0x2::object::ID) {
        let v0 = KioskRepriced{
            old_order : arg0,
            new_order : arg1,
        };
        0x2::event::emit<KioskRepriced>(v0);
    }

    public(friend) fun kiosk_taken(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x1::type_name::TypeName, arg3: u64, arg4: u64, arg5: u64, arg6: address, arg7: 0x2::object::ID, arg8: address, arg9: 0x1::option::Option<0x2::object::ID>) {
        let v0 = KioskTaken{
            order       : arg0,
            item        : arg1,
            kind        : arg2,
            ask         : arg3,
            cut         : arg4,
            royalty     : arg5,
            maker       : arg6,
            maker_kiosk : arg7,
            taker       : arg8,
            taker_kiosk : arg9,
        };
        0x2::event::emit<KioskTaken>(v0);
    }

    public(friend) fun offer_closed(arg0: 0x2::object::ID, arg1: 0x1::option::Option<0x2::object::ID>, arg2: address, arg3: u64, arg4: u64, arg5: u8) {
        let v0 = OfferClosed{
            offer    : arg0,
            pool     : arg1,
            maker    : arg2,
            left     : arg3,
            refunded : arg4,
            reason   : arg5,
        };
        0x2::event::emit<OfferClosed>(v0);
    }

    public(friend) fun offer_filled(arg0: 0x2::object::ID, arg1: 0x1::option::Option<0x2::object::ID>, arg2: address, arg3: address, arg4: 0x1::type_name::TypeName, arg5: 0x2::object::ID, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: 0x1::option::Option<0x2::object::ID>, arg11: 0x1::option::Option<0x2::object::ID>, arg12: u64) {
        let v0 = OfferFilled{
            offer        : arg0,
            pool         : arg1,
            maker        : arg2,
            seller       : arg3,
            kind         : arg4,
            item         : arg5,
            each         : arg6,
            fee          : arg7,
            royalty      : arg8,
            returned     : arg9,
            seller_kiosk : arg10,
            dest_kiosk   : arg11,
            left         : arg12,
        };
        0x2::event::emit<OfferFilled>(v0);
    }

    public(friend) fun offer_placed(arg0: 0x2::object::ID, arg1: 0x1::option::Option<0x2::object::ID>, arg2: address, arg3: 0x1::type_name::TypeName, arg4: u8, arg5: 0x1::option::Option<0x2::object::ID>, arg6: 0x1::option::Option<vector<u8>>, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: 0x1::option::Option<u64>, arg12: 0x1::option::Option<0x2::object::ID>) {
        let v0 = OfferPlaced{
            offer      : arg0,
            pool       : arg1,
            maker      : arg2,
            kind       : arg3,
            scope      : arg4,
            item       : arg5,
            root       : arg6,
            each       : arg7,
            fee        : arg8,
            reserve    : arg9,
            qty        : arg10,
            until_ms   : arg11,
            dest_kiosk : arg12,
        };
        0x2::event::emit<OfferPlaced>(v0);
    }

    public(friend) fun pool_closed(arg0: 0x2::object::ID, arg1: address, arg2: u64) {
        let v0 = PoolClosed{
            pool     : arg0,
            maker    : arg1,
            refunded : arg2,
        };
        0x2::event::emit<PoolClosed>(v0);
    }

    public(friend) fun pool_funded(arg0: 0x2::object::ID, arg1: address, arg2: 0x1::option::Option<0x1::string::String>, arg3: u64, arg4: u64) {
        let v0 = PoolFunded{
            pool  : arg0,
            maker : arg1,
            label : arg2,
            funds : arg3,
            held  : arg4,
        };
        0x2::event::emit<PoolFunded>(v0);
    }

    public(friend) fun pool_opened(arg0: 0x2::object::ID, arg1: address, arg2: 0x1::option::Option<0x1::string::String>, arg3: u64) {
        let v0 = PoolOpened{
            pool  : arg0,
            maker : arg1,
            label : arg2,
            funds : arg3,
        };
        0x2::event::emit<PoolOpened>(v0);
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

