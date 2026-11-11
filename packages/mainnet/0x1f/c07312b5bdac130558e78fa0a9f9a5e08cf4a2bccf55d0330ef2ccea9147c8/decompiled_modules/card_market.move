module 0x2dafd0ae920ffa0644d640317bd9c56afb42bdf0f2f92807ce12a995a00f192e::card_market {
    struct CardsMarket<phantom T0> has key {
        id: 0x2::object::UID,
        exchange_id: 0x2::object::ID,
        config_id: 0x2::object::ID,
        auctions_enabled: bool,
        shop_enabled: bool,
        packs_enabled: bool,
        next_lot: u64,
        lot: 0x1::option::Option<Lot<T0>>,
        next_offer: u64,
        offers: 0x2::table::Table<u64, Offer>,
        bought: 0x2::table::Table<BoughtKey, u64>,
        packs: 0x2::table::Table<u64, PackType>,
        unopened: 0x2::table::Table<PackKey, u64>,
        drawn: 0x2::table::Table<address, vector<Roll>>,
    }

    struct MarketVersionKey has copy, drop, store {
        dummy_field: bool,
    }

    struct RotationKey has copy, drop, store {
        dummy_field: bool,
    }

    struct RotationLot has copy, drop, store {
        card: u16,
        quantity: u64,
        reserve: u64,
    }

    struct AuctionRotation has copy, drop, store {
        lots: vector<RotationLot>,
        min_increment_bps: u64,
        duration_ms: u64,
        snipe_ms: u64,
        start_offset_ms: u64,
        enabled: bool,
    }

    struct OfferPeriodKey has copy, drop, store {
        offer_id: u64,
    }

    struct OfferPeriod has copy, drop, store {
        anchor_ms: u64,
        period_ms: u64,
        limit: u64,
    }

    struct BoughtPeriodKey has copy, drop, store {
        offer_id: u64,
        who: address,
    }

    struct PeriodCount has copy, drop, store {
        start: u64,
        count: u64,
    }

    struct Lot<phantom T0> has store {
        lot_id: u64,
        card: u16,
        quantity: u64,
        start_ms: u64,
        end_ms: u64,
        reserve: u64,
        min_increment_bps: u64,
        snipe_ms: u64,
        bidder: 0x1::option::Option<address>,
        escrow: 0x2::balance::Balance<T0>,
        bids: u64,
    }

    struct Offer has copy, drop, store {
        card: u16,
        price: u64,
        start_ms: u64,
        end_ms: u64,
        stock: 0x1::option::Option<u64>,
        per_owner_limit: 0x1::option::Option<u64>,
        sold: u64,
    }

    struct Roll has copy, drop, store {
        pack: u64,
        roll: u256,
    }

    struct BoughtKey has copy, drop, store {
        offer_id: u64,
        who: address,
    }

    struct PackKey has copy, drop, store {
        who: address,
        pack: u64,
    }

    struct Tier has copy, drop, store {
        weight: u64,
        cards: vector<u16>,
    }

    struct PackType has copy, drop, store {
        slug: 0x1::string::String,
        price: u64,
        cards_per_pack: u64,
        tiers: vector<Tier>,
        total_weight: u64,
        enabled: bool,
        service_only: bool,
    }

    struct Event<T0: copy + drop> has copy, drop {
        pos0: T0,
    }

    struct MarketCreatedEventV1 has copy, drop {
        market_id: 0x2::object::ID,
        exchange_id: 0x2::object::ID,
    }

    struct AuctionRotationSetEventV1 has copy, drop {
        market_id: 0x2::object::ID,
        exchange_id: 0x2::object::ID,
        cards: vector<u16>,
        quantities: vector<u64>,
        reserves: vector<u64>,
        min_increment_bps: u64,
        duration_ms: u64,
        snipe_ms: u64,
        start_offset_ms: u64,
        enabled: bool,
    }

    struct AuctionRotationSwitchEventV1 has copy, drop {
        market_id: 0x2::object::ID,
        exchange_id: 0x2::object::ID,
        enabled: bool,
    }

    struct OfferPeriodSetEventV1 has copy, drop {
        market_id: 0x2::object::ID,
        exchange_id: 0x2::object::ID,
        offer_id: u64,
        anchor_ms: u64,
        period_ms: u64,
        per_owner_limit: u64,
    }

    struct MarketMigratedEventV1 has copy, drop {
        market_id: 0x2::object::ID,
        exchange_id: 0x2::object::ID,
        from: u64,
        to: u64,
    }

    struct MarketSwitchesEventV1 has copy, drop {
        market_id: 0x2::object::ID,
        exchange_id: 0x2::object::ID,
        auctions_enabled: bool,
        shop_enabled: bool,
        packs_enabled: bool,
    }

    struct AuctionScheduledEventV1 has copy, drop {
        market_id: 0x2::object::ID,
        exchange_id: 0x2::object::ID,
        lot_id: u64,
        card: u16,
        quantity: u64,
        start_ms: u64,
        end_ms: u64,
        reserve: u64,
        min_increment_bps: u64,
        snipe_ms: u64,
    }

    struct AuctionBidEventV1 has copy, drop {
        market_id: 0x2::object::ID,
        exchange_id: 0x2::object::ID,
        lot_id: u64,
        bidder: address,
        amount: u64,
        end_ms: u64,
        refunded: 0x1::option::Option<address>,
        refund: u64,
    }

    struct AuctionSettledEventV1 has copy, drop {
        market_id: 0x2::object::ID,
        exchange_id: 0x2::object::ID,
        lot_id: u64,
        card: u16,
        quantity: u64,
        winner: 0x1::option::Option<address>,
        price: u64,
        recipient: 0x1::option::Option<address>,
    }

    struct AuctionCancelledEventV1 has copy, drop {
        market_id: 0x2::object::ID,
        exchange_id: 0x2::object::ID,
        lot_id: u64,
        refunded: 0x1::option::Option<address>,
        refund: u64,
    }

    struct ShopOfferSetEventV1 has copy, drop {
        market_id: 0x2::object::ID,
        exchange_id: 0x2::object::ID,
        offer_id: u64,
        card: u16,
        price: u64,
        start_ms: u64,
        end_ms: u64,
        stock: 0x1::option::Option<u64>,
        per_owner_limit: 0x1::option::Option<u64>,
    }

    struct ShopOfferRemovedEventV1 has copy, drop {
        market_id: 0x2::object::ID,
        exchange_id: 0x2::object::ID,
        offer_id: u64,
    }

    struct ShopPurchasedEventV1 has copy, drop {
        market_id: 0x2::object::ID,
        exchange_id: 0x2::object::ID,
        offer_id: u64,
        who: address,
        card: u16,
        quantity: u64,
        unit_price: u64,
        paid: u64,
        account_id: 0x1::option::Option<0x2::object::ID>,
        stock_left: 0x1::option::Option<u64>,
        owner_bought: u64,
        recipient: 0x1::option::Option<address>,
    }

    struct PackTypeSetEventV1 has copy, drop {
        market_id: 0x2::object::ID,
        exchange_id: 0x2::object::ID,
        pack: u64,
        slug: 0x1::string::String,
        price: u64,
        cards_per_pack: u64,
        tiers: vector<Tier>,
        enabled: bool,
        service_only: bool,
        created: bool,
    }

    struct PacksPurchasedEventV1 has copy, drop {
        market_id: 0x2::object::ID,
        exchange_id: 0x2::object::ID,
        who: address,
        pack: u64,
        count: u64,
        unit_price: u64,
        paid: u64,
        account_id: 0x1::option::Option<0x2::object::ID>,
        unopened: u64,
        recipient: 0x1::option::Option<address>,
    }

    struct PacksOpenedEventV1 has copy, drop {
        market_id: 0x2::object::ID,
        exchange_id: 0x2::object::ID,
        who: address,
        pack: u64,
        count: u64,
        cards: u64,
        unopened: u64,
    }

    struct RewardPacksGrantedEventV1 has copy, drop {
        market_id: 0x2::object::ID,
        exchange_id: 0x2::object::ID,
        who: address,
        pack: u64,
        count: u64,
        reason: u8,
        unopened: u64,
        by_admin: bool,
    }

    struct PackCardsClaimedEventV1 has copy, drop {
        market_id: 0x2::object::ID,
        exchange_id: 0x2::object::ID,
        who: address,
        cards: vector<u16>,
        quantities: vector<u64>,
    }

    fun emit<T0: copy + drop>(arg0: T0) {
        let v0 = Event<T0>{pos0: arg0};
        0x2::event::emit<Event<T0>>(v0);
    }

    fun add_lot<T0>(arg0: &mut CardsMarket<T0>, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::Exchange<T0>, arg4: u16, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64) {
        assert!(0x1::option::is_none<Lot<T0>>(&arg0.lot), 13835906392927895559);
        assert_card<T0>(arg3, arg4);
        assert!(arg5 >= 1 && arg5 <= 0x2dafd0ae920ffa0644d640317bd9c56afb42bdf0f2f92807ce12a995a00f192e::cards::max_quantity(), 13835624926540988421);
        let v0 = if (arg6 < arg7) {
            if (arg7 - arg6 <= 2592000000) {
                arg10 <= 3600000
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 13835624930835955717);
        assert!(arg8 >= 1 && arg9 <= 10000, 13835624935130923013);
        let v1 = arg0.next_lot;
        arg0.next_lot = v1 + 1;
        let v2 = Lot<T0>{
            lot_id            : v1,
            card              : arg4,
            quantity          : arg5,
            start_ms          : arg6,
            end_ms            : arg7,
            reserve           : arg8,
            min_increment_bps : arg9,
            snipe_ms          : arg10,
            bidder            : 0x1::option::none<address>(),
            escrow            : 0x2::balance::zero<T0>(),
            bids              : 0,
        };
        0x1::option::fill<Lot<T0>>(&mut arg0.lot, v2);
        let v3 = AuctionScheduledEventV1{
            market_id         : arg1,
            exchange_id       : arg2,
            lot_id            : v1,
            card              : arg4,
            quantity          : arg5,
            start_ms          : arg6,
            end_ms            : arg7,
            reserve           : arg8,
            min_increment_bps : arg9,
            snipe_ms          : arg10,
        };
        emit<AuctionScheduledEventV1>(v3);
    }

    public fun add_offer<T0>(arg0: &mut CardsMarket<T0>, arg1: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::Exchange<T0>, arg2: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config, arg3: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::AuthorityCap<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::PACKAGE, 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::ADMIN>, arg4: u16, arg5: u64, arg6: u64, arg7: u64, arg8: 0x1::option::Option<u64>, arg9: 0x1::option::Option<u64>) {
        admin<T0>(arg0, arg2, arg3);
        assert_exchange<T0>(arg0, arg1);
        assert_card<T0>(arg1, arg4);
        assert!(arg5 >= 1 && arg6 < arg7, 13835623625165897733);
        let v0 = &arg8;
        let v1 = if (0x1::option::is_none<u64>(v0) || *0x1::option::borrow<u64>(v0) >= 1) {
            let v2 = &arg9;
            0x1::option::is_none<u64>(v2) || *0x1::option::borrow<u64>(v2) >= 1
        } else {
            false
        };
        assert!(v1, 13835623629460865029);
        let v3 = arg0.next_offer;
        arg0.next_offer = v3 + 1;
        let v4 = Offer{
            card            : arg4,
            price           : arg5,
            start_ms        : arg6,
            end_ms          : arg7,
            stock           : arg8,
            per_owner_limit : arg9,
            sold            : 0,
        };
        0x2::table::add<u64, Offer>(&mut arg0.offers, v3, v4);
        let v5 = ShopOfferSetEventV1{
            market_id       : 0x2::object::uid_to_inner(&arg0.id),
            exchange_id     : arg0.exchange_id,
            offer_id        : v3,
            card            : arg4,
            price           : arg5,
            start_ms        : arg6,
            end_ms          : arg7,
            stock           : arg8,
            per_owner_limit : arg9,
        };
        emit<ShopOfferSetEventV1>(v5);
    }

    fun add_pack<T0>(arg0: &mut CardsMarket<T0>, arg1: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::Exchange<T0>, arg2: vector<u8>, arg3: u64, arg4: u64, arg5: vector<Tier>) {
        let v0 = &arg5;
        let v1 = 0;
        let v2;
        while (v1 < 0x1::vector::length<Tier>(v0)) {
            let v3 = &0x1::vector::borrow<Tier>(v0, v1).cards;
            let v4 = 0;
            let v5;
            while (v4 < 0x1::vector::length<u16>(v3)) {
                if (!0x2dafd0ae920ffa0644d640317bd9c56afb42bdf0f2f92807ce12a995a00f192e::cards::is_service_card<T0>(arg1, *0x1::vector::borrow<u16>(v3, v4))) {
                    v5 = false;
                    /* label 9 */
                    if (!v5) {
                        v2 = false;
                        /* label 13 */
                        let v6 = if (0x1::vector::length<u8>(&arg2) >= 1) {
                            if (0x1::vector::length<u8>(&arg2) <= 32) {
                                arg3 >= 1
                            } else {
                                false
                            }
                        } else {
                            false
                        };
                        assert!(v6, 13835625441937063941);
                        assert!(arg4 >= 1 && arg4 <= 20, 13835625446232031237);
                        assert!(0x1::vector::length<Tier>(&arg5) >= 1 && 0x1::vector::length<Tier>(&arg5) <= 128, 13835625450526998533);
                        let v7 = 0;
                        let v8 = &arg5;
                        let v9 = 0;
                        while (v9 < 0x1::vector::length<Tier>(v8)) {
                            v7 = v7 + (0x1::vector::borrow<Tier>(v8, v9).weight as u128);
                            v9 = v9 + 1;
                        };
                        assert!(v7 <= 18446744073709551615, 13835625463411900421);
                        let v10 = 0x1::string::utf8(arg2);
                        let v11 = 0x2::table::length<u64, PackType>(&arg0.packs);
                        let v12 = PackType{
                            slug           : v10,
                            price          : arg3,
                            cards_per_pack : arg4,
                            tiers          : arg5,
                            total_weight   : (v7 as u64),
                            enabled        : true,
                            service_only   : v2,
                        };
                        0x2::table::add<u64, PackType>(&mut arg0.packs, v11, v12);
                        let v13 = PackTypeSetEventV1{
                            market_id      : 0x2::object::uid_to_inner(&arg0.id),
                            exchange_id    : arg0.exchange_id,
                            pack           : v11,
                            slug           : v10,
                            price          : arg3,
                            cards_per_pack : arg4,
                            tiers          : arg5,
                            enabled        : true,
                            service_only   : v2,
                            created        : true,
                        };
                        emit<PackTypeSetEventV1>(v13);
                        return
                    };
                    v1 = v1 + 1;
                    /* goto 1 */
                    continue
                };
                v4 = v4 + 1;
            };
            v5 = true;
            /* goto 9 */
        };
        v2 = true;
        /* goto 13 */
    }

    public fun add_pack_with_card_weights<T0>(arg0: &mut CardsMarket<T0>, arg1: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::Exchange<T0>, arg2: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config, arg3: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::AuthorityCap<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::PACKAGE, 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::ADMIN>, arg4: vector<u8>, arg5: u64, arg6: u64, arg7: vector<u16>, arg8: vector<u64>) {
        admin<T0>(arg0, arg2, arg3);
        assert_exchange<T0>(arg0, arg1);
        assert!(0x1::vector::length<u16>(&arg7) == 0x1::vector::length<u64>(&arg8), 13835623758309883909);
        let v0 = 0x1::vector::empty<Tier>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<u16>(&arg7)) {
            assert_card<T0>(arg1, *0x1::vector::borrow<u16>(&arg7, v1));
            if (*0x1::vector::borrow<u64>(&arg8, v1) > 0) {
                let v2 = 0x1::vector::empty<u16>();
                0x1::vector::push_back<u16>(&mut v2, *0x1::vector::borrow<u16>(&arg7, v1));
                let v3 = Tier{
                    weight : *0x1::vector::borrow<u64>(&arg8, v1),
                    cards  : v2,
                };
                0x1::vector::push_back<Tier>(&mut v0, v3);
            };
            v1 = v1 + 1;
        };
        add_pack<T0>(arg0, arg1, arg4, arg5, arg6, v0);
    }

    public fun add_pack_with_rarity_weights<T0>(arg0: &mut CardsMarket<T0>, arg1: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::Exchange<T0>, arg2: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config, arg3: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::AuthorityCap<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::PACKAGE, 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::ADMIN>, arg4: vector<u8>, arg5: u64, arg6: u64, arg7: vector<u64>) {
        admin<T0>(arg0, arg2, arg3);
        assert_exchange<T0>(arg0, arg1);
        assert!(0x1::vector::length<u64>(&arg7) <= 5, 13835623844209229829);
        let v0 = 0x1::vector::empty<Tier>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(&arg7)) {
            let v2 = vector[];
            let v3 = 0;
            while (v3 < 0x2dafd0ae920ffa0644d640317bd9c56afb42bdf0f2f92807ce12a995a00f192e::cards::card_count<T0>(arg1)) {
                let (_, v5, v6, _, _) = 0x2dafd0ae920ffa0644d640317bd9c56afb42bdf0f2f92807ce12a995a00f192e::cards::card<T0>(arg1, (v3 as u16));
                if (v6 && (v5 as u64) == v1) {
                    0x1::vector::push_back<u16>(&mut v2, (v3 as u16));
                };
                v3 = v3 + 1;
            };
            if (*0x1::vector::borrow<u64>(&arg7, v1) > 0 && !0x1::vector::is_empty<u16>(&v2)) {
                let v9 = Tier{
                    weight : *0x1::vector::borrow<u64>(&arg7, v1),
                    cards  : v2,
                };
                0x1::vector::push_back<Tier>(&mut v0, v9);
            };
            v1 = v1 + 1;
        };
        add_pack<T0>(arg0, arg1, arg4, arg5, arg6, v0);
    }

    fun add_unopened<T0>(arg0: &mut CardsMarket<T0>, arg1: address, arg2: u64, arg3: u64) : u64 {
        let v0 = PackKey{
            who  : arg1,
            pack : arg2,
        };
        let v1 = if (0x2::table::contains<PackKey, u64>(&arg0.unopened, v0)) {
            0x2::table::remove<PackKey, u64>(&mut arg0.unopened, v0)
        } else {
            0
        };
        let v2 = v1 + arg3;
        0x2::table::add<PackKey, u64>(&mut arg0.unopened, v0, v2);
        v2
    }

    fun admin<T0>(arg0: &CardsMarket<T0>, arg1: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config, arg2: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::AuthorityCap<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::PACKAGE, 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::ADMIN>) {
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::assert_admin(0x2::object::id<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config>(arg1), arg2);
        assert_config<T0>(arg0, arg1);
    }

    fun assert_card<T0>(arg0: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::Exchange<T0>, arg1: u16) {
        assert!((arg1 as u64) < 0x2dafd0ae920ffa0644d640317bd9c56afb42bdf0f2f92807ce12a995a00f192e::cards::card_count<T0>(arg0), 13839565473137557537);
        let (_, _, v2, _, _) = 0x2dafd0ae920ffa0644d640317bd9c56afb42bdf0f2f92807ce12a995a00f192e::cards::card<T0>(arg0, arg1);
        assert!(v2, 13839565481727492129);
    }

    fun assert_config<T0>(arg0: &CardsMarket<T0>, arg1: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config) {
        assert!(arg0.config_id == 0x2::object::id<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config>(arg1), 13835061809083580417);
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::assert_version(arg1);
        assert_version<T0>(arg0);
    }

    fun assert_exchange<T0>(arg0: &CardsMarket<T0>, arg1: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::Exchange<T0>) {
        assert!(arg0.exchange_id == 0x2::object::id<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::Exchange<T0>>(arg1), 13835061856328220673);
    }

    fun assert_version<T0>(arg0: &CardsMarket<T0>) {
        assert!(market_version<T0>(arg0) == 1, 13840128388731502629);
    }

    public fun auction_rotation<T0>(arg0: &CardsMarket<T0>) : (vector<u16>, vector<u64>, vector<u64>, u64, u64, u64, u64, bool) {
        let v0 = RotationKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<RotationKey>(&arg0.id, v0)) {
            return (vector[], vector[], vector[], 0, 0, 0, 0, false)
        };
        let v1 = RotationKey{dummy_field: false};
        let v2 = 0x2::dynamic_field::borrow<RotationKey, AuctionRotation>(&arg0.id, v1);
        let v3 = &v2.lots;
        let v4 = vector[];
        let v5 = 0;
        while (v5 < 0x1::vector::length<RotationLot>(v3)) {
            0x1::vector::push_back<u16>(&mut v4, 0x1::vector::borrow<RotationLot>(v3, v5).card);
            v5 = v5 + 1;
        };
        let v6 = &v2.lots;
        let v7 = vector[];
        let v8 = 0;
        while (v8 < 0x1::vector::length<RotationLot>(v6)) {
            0x1::vector::push_back<u64>(&mut v7, 0x1::vector::borrow<RotationLot>(v6, v8).quantity);
            v8 = v8 + 1;
        };
        let v9 = &v2.lots;
        let v10 = vector[];
        let v11 = 0;
        while (v11 < 0x1::vector::length<RotationLot>(v9)) {
            0x1::vector::push_back<u64>(&mut v10, 0x1::vector::borrow<RotationLot>(v9, v11).reserve);
            v11 = v11 + 1;
        };
        (v4, v7, v10, v2.min_increment_bps, v2.duration_ms, v2.snipe_ms, v2.start_offset_ms, v2.enabled)
    }

    public fun bid<T0>(arg0: &mut CardsMarket<T0>, arg1: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config, arg2: u64, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert_config<T0>(arg0, arg1);
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::assert_unpaused(arg1, 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::pause_deposits());
        assert!(arg0.auctions_enabled, 13835342656995196931);
        let v0 = 0x1::option::borrow_mut<Lot<T0>>(&mut arg0.lot);
        assert!(v0.lot_id == arg2, 13836187094810624009);
        let v1 = 0x2::clock::timestamp_ms(arg4);
        assert!(v1 >= v0.start_ms && v1 < v0.end_ms, 13836468578377400331);
        let v2 = 0x2::coin::value<T0>(&arg3);
        assert!(v2 >= min_bid<T0>(arg0), 13836750061944176653);
        let v3 = v0.bidder;
        refund_escrow<T0>(0x2::balance::withdraw_all<T0>(&mut v0.escrow), v3, arg5);
        0x2::balance::join<T0>(&mut v0.escrow, 0x2::coin::into_balance<T0>(arg3));
        v0.bidder = 0x1::option::some<address>(0x2::tx_context::sender(arg5));
        v0.bids = v0.bids + 1;
        if (v0.end_ms - v1 < v0.snipe_ms) {
            v0.end_ms = v1 + v0.snipe_ms;
        };
        let v4 = AuctionBidEventV1{
            market_id   : 0x2::object::uid_to_inner(&arg0.id),
            exchange_id : arg0.exchange_id,
            lot_id      : v0.lot_id,
            bidder      : 0x2::tx_context::sender(arg5),
            amount      : v2,
            end_ms      : v0.end_ms,
            refunded    : v3,
            refund      : 0x2::balance::value<T0>(&v0.escrow),
        };
        emit<AuctionBidEventV1>(v4);
    }

    public fun bought<T0>(arg0: &CardsMarket<T0>, arg1: u64, arg2: address) : u64 {
        let v0 = BoughtKey{
            offer_id : arg1,
            who      : arg2,
        };
        if (0x2::table::contains<BoughtKey, u64>(&arg0.bought, v0)) {
            *0x2::table::borrow<BoughtKey, u64>(&arg0.bought, v0)
        } else {
            0
        }
    }

    public fun bought_in_period<T0>(arg0: &CardsMarket<T0>, arg1: u64, arg2: address, arg3: u64) : u64 {
        let v0 = OfferPeriodKey{offer_id: arg1};
        if (!0x2::dynamic_field::exists<OfferPeriodKey>(&arg0.id, v0)) {
            return bought<T0>(arg0, arg1, arg2)
        };
        let v1 = BoughtPeriodKey{
            offer_id : arg1,
            who      : arg2,
        };
        if (!0x2::dynamic_field::exists<BoughtPeriodKey>(&arg0.id, v1)) {
            return 0
        };
        let v2 = 0x2::dynamic_field::borrow<BoughtPeriodKey, PeriodCount>(&arg0.id, v1);
        if (v2.start == period_start(0x2::dynamic_field::borrow<OfferPeriodKey, OfferPeriod>(&arg0.id, v0), arg3)) {
            v2.count
        } else {
            0
        }
    }

    public fun buy_offer_from_account<T0>(arg0: &mut CardsMarket<T0>, arg1: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::Exchange<T0>, arg2: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config, arg3: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::account::Account<T0>, arg4: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::account::AccountCap, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock) : 0x2dafd0ae920ffa0644d640317bd9c56afb42bdf0f2f92807ce12a995a00f192e::cards::CardsAction<T0> {
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::account::assert_exchange<T0>(arg3, 0x2::object::id<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::Exchange<T0>>(arg1));
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::account::assert_cap<T0>(arg3, arg4);
        let v0 = 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::account::owner<T0>(arg3);
        let v1 = 0x2::object::id<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::account::Account<T0>>(arg3);
        let (v2, v3) = shop_take<T0>(arg0, arg1, arg2, arg5, v0, arg6, 0x1::option::some<0x2::object::ID>(v1), arg7);
        let v4 = 0x1::vector::empty<u16>();
        0x1::vector::push_back<u16>(&mut v4, v2);
        let v5 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v5, arg6);
        0x2dafd0ae920ffa0644d640317bd9c56afb42bdf0f2f92807ce12a995a00f192e::cards::settle_action<T0>(arg1, arg2, v0, 0x1::option::some<0x2::object::ID>(v1), 0x1::option::none<0x2::coin::Coin<T0>>(), v3, true, v4, v5, 0x2dafd0ae920ffa0644d640317bd9c56afb42bdf0f2f92807ce12a995a00f192e::cards::source_shop())
    }

    public fun buy_offer_with_coin<T0>(arg0: &mut CardsMarket<T0>, arg1: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::Exchange<T0>, arg2: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config, arg3: u64, arg4: u64, arg5: 0x2::coin::Coin<T0>, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) : 0x2dafd0ae920ffa0644d640317bd9c56afb42bdf0f2f92807ce12a995a00f192e::cards::CardsAction<T0> {
        let v0 = 0x2::tx_context::sender(arg7);
        let (v1, v2) = shop_take<T0>(arg0, arg1, arg2, arg3, v0, arg4, 0x1::option::none<0x2::object::ID>(), arg6);
        let v3 = 0x1::vector::empty<u16>();
        0x1::vector::push_back<u16>(&mut v3, v1);
        let v4 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v4, arg4);
        0x2dafd0ae920ffa0644d640317bd9c56afb42bdf0f2f92807ce12a995a00f192e::cards::settle_action<T0>(arg1, arg2, v0, 0x1::option::none<0x2::object::ID>(), 0x1::option::some<0x2::coin::Coin<T0>>(arg5), v2, true, v3, v4, 0x2dafd0ae920ffa0644d640317bd9c56afb42bdf0f2f92807ce12a995a00f192e::cards::source_shop())
    }

    public fun buy_pack_from_account<T0>(arg0: &mut CardsMarket<T0>, arg1: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::Exchange<T0>, arg2: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config, arg3: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::account::Account<T0>, arg4: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::account::AccountCap, arg5: u64, arg6: u64) : 0x2dafd0ae920ffa0644d640317bd9c56afb42bdf0f2f92807ce12a995a00f192e::cards::CardsAction<T0> {
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::account::assert_exchange<T0>(arg3, 0x2::object::id<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::Exchange<T0>>(arg1));
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::account::assert_cap<T0>(arg3, arg4);
        let v0 = 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::account::owner<T0>(arg3);
        let v1 = 0x2::object::id<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::account::Account<T0>>(arg3);
        0x2dafd0ae920ffa0644d640317bd9c56afb42bdf0f2f92807ce12a995a00f192e::cards::settle_action<T0>(arg1, arg2, v0, 0x1::option::some<0x2::object::ID>(v1), 0x1::option::none<0x2::coin::Coin<T0>>(), pack_take<T0>(arg0, arg1, arg2, arg5, v0, arg6, 0x1::option::some<0x2::object::ID>(v1)), true, vector[], vector[], 0x2dafd0ae920ffa0644d640317bd9c56afb42bdf0f2f92807ce12a995a00f192e::cards::source_pack())
    }

    public fun buy_pack_with_coin<T0>(arg0: &mut CardsMarket<T0>, arg1: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::Exchange<T0>, arg2: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config, arg3: u64, arg4: u64, arg5: 0x2::coin::Coin<T0>, arg6: &0x2::tx_context::TxContext) : 0x2dafd0ae920ffa0644d640317bd9c56afb42bdf0f2f92807ce12a995a00f192e::cards::CardsAction<T0> {
        let v0 = 0x2::tx_context::sender(arg6);
        0x2dafd0ae920ffa0644d640317bd9c56afb42bdf0f2f92807ce12a995a00f192e::cards::settle_action<T0>(arg1, arg2, v0, 0x1::option::none<0x2::object::ID>(), 0x1::option::some<0x2::coin::Coin<T0>>(arg5), pack_take<T0>(arg0, arg1, arg2, arg3, v0, arg4, 0x1::option::none<0x2::object::ID>()), true, vector[], vector[], 0x2dafd0ae920ffa0644d640317bd9c56afb42bdf0f2f92807ce12a995a00f192e::cards::source_pack())
    }

    public fun cancel_auction<T0>(arg0: &mut CardsMarket<T0>, arg1: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config, arg2: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::AuthorityCap<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::PACKAGE, 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::ADMIN>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        admin<T0>(arg0, arg1, arg2);
        assert!(0x1::option::is_some<Lot<T0>>(&arg0.lot), 13836186493515202569);
        let Lot {
            lot_id            : v0,
            card              : _,
            quantity          : _,
            start_ms          : _,
            end_ms            : _,
            reserve           : _,
            min_increment_bps : _,
            snipe_ms          : _,
            bidder            : v8,
            escrow            : v9,
            bids              : _,
        } = 0x1::option::extract<Lot<T0>>(&mut arg0.lot);
        let v11 = v9;
        refund_escrow<T0>(v11, v8, arg4);
        let v12 = AuctionCancelledEventV1{
            market_id   : 0x2::object::uid_to_inner(&arg0.id),
            exchange_id : arg0.exchange_id,
            lot_id      : v0,
            refunded    : v8,
            refund      : 0x2::balance::value<T0>(&v11),
        };
        emit<AuctionCancelledEventV1>(v12);
    }

    public fun claim_pack_cards<T0>(arg0: &mut CardsMarket<T0>, arg1: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::Exchange<T0>, arg2: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config, arg3: address) : 0x2dafd0ae920ffa0644d640317bd9c56afb42bdf0f2f92807ce12a995a00f192e::cards::CardsAction<T0> {
        assert_config<T0>(arg0, arg2);
        assert_exchange<T0>(arg0, arg1);
        assert!(0x2::table::contains<address, vector<Roll>>(&arg0.drawn, arg3), 13839002351385182237);
        let v0 = vector[];
        let v1 = vector[];
        let v2 = 0x2::table::remove<address, vector<Roll>>(&mut arg0.drawn, arg3);
        0x1::vector::reverse<Roll>(&mut v2);
        let v3 = 0;
        while (v3 < 0x1::vector::length<Roll>(&v2)) {
            let v4 = 0x1::vector::pop_back<Roll>(&mut v2);
            let v5 = resolve<T0>(arg0, &v4);
            let v6 = &v0;
            let v7 = 0;
            let v8;
            while (v7 < 0x1::vector::length<u16>(v6)) {
                if (*0x1::vector::borrow<u16>(v6, v7) == v5) {
                    v8 = 0x1::option::some<u64>(v7);
                    /* label 12 */
                    if (0x1::option::is_some<u64>(&v8)) {
                        let v9 = 0x1::option::destroy_some<u64>(v8);
                        *0x1::vector::borrow_mut<u64>(&mut v1, v9) = *0x1::vector::borrow<u64>(&v1, v9) + 1;
                    } else {
                        0x1::vector::push_back<u16>(&mut v0, v5);
                        0x1::vector::push_back<u64>(&mut v1, 1);
                    };
                    v3 = v3 + 1;
                    /* goto 4 */
                    continue
                };
                v7 = v7 + 1;
            };
            v8 = 0x1::option::none<u64>();
            /* goto 12 */
        };
        0x1::vector::destroy_empty<Roll>(v2);
        let v10 = PackCardsClaimedEventV1{
            market_id   : 0x2::object::uid_to_inner(&arg0.id),
            exchange_id : arg0.exchange_id,
            who         : arg3,
            cards       : v0,
            quantities  : v1,
        };
        emit<PackCardsClaimedEventV1>(v10);
        0x2dafd0ae920ffa0644d640317bd9c56afb42bdf0f2f92807ce12a995a00f192e::cards::settle_action<T0>(arg1, arg2, arg3, 0x1::option::none<0x2::object::ID>(), 0x1::option::none<0x2::coin::Coin<T0>>(), 0, false, v0, v1, 0x2dafd0ae920ffa0644d640317bd9c56afb42bdf0f2f92807ce12a995a00f192e::cards::source_pack())
    }

    public fun create<T0>(arg0: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::Exchange<T0>, arg1: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config, arg2: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::AuthorityCap<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::PACKAGE, 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::ADMIN>, arg3: &mut 0x2::tx_context::TxContext) : 0x2dafd0ae920ffa0644d640317bd9c56afb42bdf0f2f92807ce12a995a00f192e::cards::CardsAction<T0> {
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::assert_admin(0x2::object::id<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config>(arg1), arg2);
        let (v0, v1) = new_market<T0>(arg0, arg1, arg3);
        0x2::transfer::share_object<CardsMarket<T0>>(v0);
        v1
    }

    public fun current_market_version() : u64 {
        1
    }

    public fun drawn<T0>(arg0: &CardsMarket<T0>, arg1: address) : vector<u16> {
        if (!0x2::table::contains<address, vector<Roll>>(&arg0.drawn, arg1)) {
            return vector[]
        };
        let v0 = 0x2::table::borrow<address, vector<Roll>>(&arg0.drawn, arg1);
        let v1 = vector[];
        let v2 = 0;
        while (v2 < 0x1::vector::length<Roll>(v0)) {
            0x1::vector::push_back<u16>(&mut v1, resolve<T0>(arg0, 0x1::vector::borrow<Roll>(v0, v2)));
            v2 = v2 + 1;
        };
        v1
    }

    public fun exchange_id<T0>(arg0: &CardsMarket<T0>) : 0x2::object::ID {
        arg0.exchange_id
    }

    public fun grant_packs<T0>(arg0: &mut CardsMarket<T0>, arg1: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config, arg2: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::AuthorityCap<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::PACKAGE, 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::GAME_KEEPER>, arg3: address, arg4: u64, arg5: u64, arg6: u8) {
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::assert_role<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::GAME_KEEPER>(0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::uid(arg1), 0x2::object::id<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config>(arg1), arg2);
        assert!(arg5 <= 100, 13835624020302888965);
        reward_packs<T0>(arg0, arg1, arg3, arg4, arg5, arg6, false);
    }

    public fun grant_packs_as_admin<T0>(arg0: &mut CardsMarket<T0>, arg1: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config, arg2: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::AuthorityCap<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::PACKAGE, 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::ADMIN>, arg3: address, arg4: u64, arg5: u64, arg6: u8) {
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::assert_admin(0x2::object::id<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config>(arg1), arg2);
        reward_packs<T0>(arg0, arg1, arg3, arg4, arg5, arg6, true);
    }

    public fun has_lot<T0>(arg0: &CardsMarket<T0>) : bool {
        0x1::option::is_some<Lot<T0>>(&arg0.lot)
    }

    public fun has_pack<T0>(arg0: &CardsMarket<T0>, arg1: u64) : bool {
        0x2::table::contains<u64, PackType>(&arg0.packs, arg1)
    }

    public fun lot<T0>(arg0: &CardsMarket<T0>) : (u64, u16, u64, u64, u64, u64, u64, u64, 0x1::option::Option<address>, u64, u64) {
        assert!(0x1::option::is_some<Lot<T0>>(&arg0.lot), 13836185385413640201);
        let v0 = 0x1::option::borrow<Lot<T0>>(&arg0.lot);
        (v0.lot_id, v0.card, v0.quantity, v0.start_ms, v0.end_ms, v0.reserve, v0.min_increment_bps, v0.snipe_ms, v0.bidder, 0x2::balance::value<T0>(&v0.escrow), v0.bids)
    }

    public fun market_version<T0>(arg0: &CardsMarket<T0>) : u64 {
        let v0 = MarketVersionKey{dummy_field: false};
        if (0x2::dynamic_field::exists<MarketVersionKey>(&arg0.id, v0)) {
            let v2 = MarketVersionKey{dummy_field: false};
            *0x2::dynamic_field::borrow<MarketVersionKey, u64>(&arg0.id, v2)
        } else {
            0
        }
    }

    public fun migrate_market<T0>(arg0: &mut CardsMarket<T0>, arg1: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config, arg2: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::AuthorityCap<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::PACKAGE, 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::ADMIN>) {
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::assert_admin(0x2::object::id<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config>(arg1), arg2);
        assert!(arg0.config_id == 0x2::object::id<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config>(arg1), 13835059906413068289);
        0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::assert_version(arg1);
        let v0 = market_version<T0>(arg0);
        assert!(v0 < 1, 13840126468881121317);
        if (v0 == 0) {
            let v1 = MarketVersionKey{dummy_field: false};
            0x2::dynamic_field::add<MarketVersionKey, u64>(&mut arg0.id, v1, 1);
        } else {
            let v2 = MarketVersionKey{dummy_field: false};
            *0x2::dynamic_field::borrow_mut<MarketVersionKey, u64>(&mut arg0.id, v2) = 1;
        };
        let v3 = MarketMigratedEventV1{
            market_id   : 0x2::object::uid_to_inner(&arg0.id),
            exchange_id : arg0.exchange_id,
            from        : v0,
            to          : 1,
        };
        emit<MarketMigratedEventV1>(v3);
    }

    public fun min_bid<T0>(arg0: &CardsMarket<T0>) : u64 {
        assert!(0x1::option::is_some<Lot<T0>>(&arg0.lot), 13836185415478411273);
        let v0 = 0x1::option::borrow<Lot<T0>>(&arg0.lot);
        let v1 = 0x2::balance::value<T0>(&v0.escrow);
        if (0x1::option::is_none<address>(&v0.bidder)) {
            return v0.reserve
        };
        let v2 = ((v1 as u128) * (v0.min_increment_bps as u128) + (10000 as u128) - 1) / (10000 as u128);
        let v3 = if (v2 == 0) {
            1
        } else {
            v2
        };
        let v4 = (v1 as u128) + v3;
        assert!(v4 <= 18446744073709551615, 13836748395496865805);
        (v4 as u64)
    }

    fun mul(arg0: u64, arg1: u64) : u64 {
        let v0 = (arg0 as u128) * (arg1 as u128);
        assert!(v0 <= 18446744073709551615, 13835624986670530565);
        (v0 as u64)
    }

    fun new_market<T0>(arg0: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::Exchange<T0>, arg1: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config, arg2: &mut 0x2::tx_context::TxContext) : (CardsMarket<T0>, 0x2dafd0ae920ffa0644d640317bd9c56afb42bdf0f2f92807ce12a995a00f192e::cards::CardsAction<T0>) {
        let v0 = CardsMarket<T0>{
            id               : 0x2::object::new(arg2),
            exchange_id      : 0x2::object::id<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::Exchange<T0>>(arg0),
            config_id        : 0x2::object::id<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config>(arg1),
            auctions_enabled : false,
            shop_enabled     : false,
            packs_enabled    : false,
            next_lot         : 0,
            lot              : 0x1::option::none<Lot<T0>>(),
            next_offer       : 0,
            offers           : 0x2::table::new<u64, Offer>(arg2),
            bought           : 0x2::table::new<BoughtKey, u64>(arg2),
            packs            : 0x2::table::new<u64, PackType>(arg2),
            unopened         : 0x2::table::new<PackKey, u64>(arg2),
            drawn            : 0x2::table::new<address, vector<Roll>>(arg2),
        };
        let v1 = MarketVersionKey{dummy_field: false};
        0x2::dynamic_field::add<MarketVersionKey, u64>(&mut v0.id, v1, 1);
        let v2 = 0x2::object::id<CardsMarket<T0>>(&v0);
        let v3 = MarketCreatedEventV1{
            market_id   : v2,
            exchange_id : 0x2::object::id<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::Exchange<T0>>(arg0),
        };
        emit<MarketCreatedEventV1>(v3);
        (v0, 0x2dafd0ae920ffa0644d640317bd9c56afb42bdf0f2f92807ce12a995a00f192e::cards::set_market_action<T0>(arg0, arg1, v2))
    }

    public fun next_slot(arg0: u64, arg1: u64) : u64 {
        let v0 = arg0 / 86400000 * 86400000 + arg1;
        if (v0 >= arg0) {
            v0
        } else {
            v0 + 86400000
        }
    }

    public fun offer<T0>(arg0: &CardsMarket<T0>, arg1: u64) : (u16, u64, u64, u64, 0x1::option::Option<u64>, 0x1::option::Option<u64>, u64) {
        assert!(0x2::table::contains<u64, Offer>(&arg0.offers, arg1), 13837592841902227475);
        let v0 = *0x2::table::borrow<u64, Offer>(&arg0.offers, arg1);
        let v1 = OfferPeriodKey{offer_id: arg1};
        let v2 = if (0x2::dynamic_field::exists<OfferPeriodKey>(&arg0.id, v1)) {
            0x1::option::some<u64>(0x2::dynamic_field::borrow<OfferPeriodKey, OfferPeriod>(&arg0.id, v1).limit)
        } else {
            v0.per_owner_limit
        };
        (v0.card, v0.price, v0.start_ms, v0.end_ms, v0.stock, v2, v0.sold)
    }

    public fun offer_period<T0>(arg0: &CardsMarket<T0>, arg1: u64) : (u64, u64) {
        let v0 = OfferPeriodKey{offer_id: arg1};
        if (!0x2::dynamic_field::exists<OfferPeriodKey>(&arg0.id, v0)) {
            return (0, 0)
        };
        let v1 = 0x2::dynamic_field::borrow<OfferPeriodKey, OfferPeriod>(&arg0.id, v0);
        (v1.anchor_ms, v1.period_ms)
    }

    fun open<T0>(arg0: &mut CardsMarket<T0>, arg1: u64, arg2: u64, arg3: &mut 0x2::random::RandomGenerator, arg4: address) {
        assert_version<T0>(arg0);
        assert!(0x2::table::contains<u64, PackType>(&arg0.packs, arg1), 13838440264719925273);
        assert!(arg2 >= 1 && arg2 <= 10, 13835625519246475269);
        let v0 = PackKey{
            who  : arg4,
            pack : arg1,
        };
        let v1 = if (0x2::table::contains<PackKey, u64>(&arg0.unopened, v0)) {
            *0x2::table::borrow<PackKey, u64>(&arg0.unopened, v0)
        } else {
            0
        };
        assert!(v1 >= arg2, 13838721756876636187);
        let v2 = arg2 * 0x2::table::borrow<u64, PackType>(&arg0.packs, arg1).cards_per_pack;
        if (!0x2::table::contains<address, vector<Roll>>(&arg0.drawn, arg4)) {
            0x2::table::add<address, vector<Roll>>(&mut arg0.drawn, arg4, 0x1::vector::empty<Roll>());
        };
        assert!(0x1::vector::length<Roll>(0x2::table::borrow<address, vector<Roll>>(&arg0.drawn, arg4)) + v2 <= 1000, 13839284724010188831);
        if (v1 == arg2) {
            0x2::table::remove<PackKey, u64>(&mut arg0.unopened, v0);
        } else {
            *0x2::table::borrow_mut<PackKey, u64>(&mut arg0.unopened, v0) = v1 - arg2;
        };
        let v3 = 0x2::table::borrow_mut<address, vector<Roll>>(&mut arg0.drawn, arg4);
        let v4 = 0;
        while (v4 < v2) {
            let v5 = Roll{
                pack : arg1,
                roll : 0x2::random::generate_u256(arg3),
            };
            0x1::vector::push_back<Roll>(v3, v5);
            v4 = v4 + 1;
        };
        let v6 = PacksOpenedEventV1{
            market_id   : 0x2::object::uid_to_inner(&arg0.id),
            exchange_id : arg0.exchange_id,
            who         : arg4,
            pack        : arg1,
            count       : arg2,
            cards       : v2,
            unopened    : v1 - arg2,
        };
        emit<PacksOpenedEventV1>(v6);
    }

    entry fun open_pack<T0>(arg0: &mut CardsMarket<T0>, arg1: u64, arg2: u64, arg3: &0x2::random::Random, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::random::new_generator(arg3, arg4);
        let v1 = &mut v0;
        open<T0>(arg0, arg1, arg2, v1, 0x2::tx_context::sender(arg4));
    }

    public fun pack<T0>(arg0: &CardsMarket<T0>, arg1: u64) : (0x1::string::String, u64, u64, vector<Tier>, u64, bool) {
        assert!(0x2::table::contains<u64, PackType>(&arg0.packs, arg1), 13838437352732098585);
        let v0 = 0x2::table::borrow<u64, PackType>(&arg0.packs, arg1);
        (v0.slug, v0.price, v0.cards_per_pack, v0.tiers, v0.total_weight, v0.enabled)
    }

    public fun pack_count<T0>(arg0: &CardsMarket<T0>) : u64 {
        0x2::table::length<u64, PackType>(&arg0.packs)
    }

    public fun pack_service_only<T0>(arg0: &CardsMarket<T0>, arg1: u64) : bool {
        assert!(0x2::table::contains<u64, PackType>(&arg0.packs, arg1), 13838437331257262105);
        0x2::table::borrow<u64, PackType>(&arg0.packs, arg1).service_only
    }

    fun pack_take<T0>(arg0: &mut CardsMarket<T0>, arg1: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::Exchange<T0>, arg2: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config, arg3: u64, arg4: address, arg5: u64, arg6: 0x1::option::Option<0x2::object::ID>) : u64 {
        let v0 = 0x2::object::uid_to_inner(&arg0.id);
        let v1 = arg0.exchange_id;
        assert_config<T0>(arg0, arg2);
        assert_exchange<T0>(arg0, arg1);
        assert!(arg0.packs_enabled, 13835343803751464963);
        assert!(0x2::table::contains<u64, PackType>(&arg0.packs, arg3), 13838440032791691289);
        let (_, v3, v4) = 0x2dafd0ae920ffa0644d640317bd9c56afb42bdf0f2f92807ce12a995a00f192e::cards::params<T0>(arg1);
        let v5 = 0x2::table::borrow<u64, PackType>(&arg0.packs, arg3);
        assert!(v5.enabled, 13835343820931334147);
        assert!(arg5 >= 1 && arg5 <= v4, 13835625300203143173);
        let v6 = v5.price;
        let v7 = mul(v6, arg5);
        let v8 = PacksPurchasedEventV1{
            market_id   : v0,
            exchange_id : v1,
            who         : arg4,
            pack        : arg3,
            count       : arg5,
            unit_price  : v6,
            paid        : v7,
            account_id  : arg6,
            unopened    : add_unopened<T0>(arg0, arg4, arg3, arg5),
            recipient   : v3,
        };
        emit<PacksPurchasedEventV1>(v8);
        v7
    }

    fun period_start(arg0: &OfferPeriod, arg1: u64) : u64 {
        if (arg1 <= arg0.anchor_ms) {
            return arg0.anchor_ms
        };
        arg1 - (arg1 - arg0.anchor_ms) % arg0.period_ms
    }

    fun refund_escrow<T0>(arg0: 0x2::balance::Balance<T0>, arg1: 0x1::option::Option<address>, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x1::option::is_some<address>(&arg1)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg0, arg2), 0x1::option::destroy_some<address>(arg1));
        } else {
            0x2::balance::destroy_zero<T0>(arg0);
        };
    }

    public fun remove_offer<T0>(arg0: &mut CardsMarket<T0>, arg1: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config, arg2: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::AuthorityCap<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::PACKAGE, 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::ADMIN>, arg3: u64) {
        admin<T0>(arg0, arg1, arg2);
        assert!(0x2::table::contains<u64, Offer>(&arg0.offers, arg3), 13837594005838364691);
        0x2::table::remove<u64, Offer>(&mut arg0.offers, arg3);
        let v0 = OfferPeriodKey{offer_id: arg3};
        if (0x2::dynamic_field::exists<OfferPeriodKey>(&arg0.id, v0)) {
            0x2::dynamic_field::remove<OfferPeriodKey, OfferPeriod>(&mut arg0.id, v0);
        };
        let v1 = ShopOfferRemovedEventV1{
            market_id   : 0x2::object::uid_to_inner(&arg0.id),
            exchange_id : arg0.exchange_id,
            offer_id    : arg3,
        };
        emit<ShopOfferRemovedEventV1>(v1);
    }

    fun resolve<T0>(arg0: &CardsMarket<T0>, arg1: &Roll) : u16 {
        let v0 = 0x2::table::borrow<u64, PackType>(&arg0.packs, arg1.pack);
        let v1 = (((arg1.roll & 340282366920938463463374607431768211455) % (v0.total_weight as u256)) as u64);
        let v2 = &v0.tiers;
        let v3 = 0;
        let v4;
        while (v3 < 0x1::vector::length<Tier>(v2)) {
            let v5 = 0x1::vector::borrow<Tier>(v2, v3);
            let v6 = v1 < v5.weight;
            if (!v6) {
                v1 = v1 - v5.weight;
            };
            if (v6) {
                v4 = 0x1::option::some<u64>(v3);
                /* label 9 */
                let v7 = &0x1::vector::borrow<Tier>(&v0.tiers, 0x1::option::destroy_some<u64>(v4)).cards;
                return *0x1::vector::borrow<u16>(v7, (((arg1.roll >> 128) % (0x1::vector::length<u16>(v7) as u256)) as u64))
            };
            v3 = v3 + 1;
        };
        v4 = 0x1::option::none<u64>();
        /* goto 9 */
    }

    fun reward_packs<T0>(arg0: &mut CardsMarket<T0>, arg1: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config, arg2: address, arg3: u64, arg4: u64, arg5: u8, arg6: bool) {
        let v0 = 0x2::object::uid_to_inner(&arg0.id);
        let v1 = arg0.exchange_id;
        assert_config<T0>(arg0, arg1);
        assert!(0x2::table::contains<u64, PackType>(&arg0.packs, arg3), 13838440140165873689);
        assert!(0x2::table::borrow<u64, PackType>(&arg0.packs, arg3).service_only, 13839847519345049635);
        assert!(arg4 >= 1, 13835625398987390981);
        let v2 = RewardPacksGrantedEventV1{
            market_id   : v0,
            exchange_id : v1,
            who         : arg2,
            pack        : arg3,
            count       : arg4,
            reason      : arg5,
            unopened    : add_unopened<T0>(arg0, arg2, arg3, arg4),
            by_admin    : arg6,
        };
        emit<RewardPacksGrantedEventV1>(v2);
    }

    public fun schedule_auction<T0>(arg0: &mut CardsMarket<T0>, arg1: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::Exchange<T0>, arg2: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config, arg3: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::AuthorityCap<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::PACKAGE, 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::ADMIN>, arg4: u16, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: &0x2::clock::Clock) {
        let v0 = 0x2::object::uid_to_inner(&arg0.id);
        let v1 = arg0.exchange_id;
        admin<T0>(arg0, arg2, arg3);
        assert_exchange<T0>(arg0, arg1);
        assert!(0x1::option::is_none<Lot<T0>>(&arg0.lot), 13835904490257383431);
        assert!(arg6 < arg7 && arg7 > 0x2::clock::timestamp_ms(arg11), 13835623019575508997);
        add_lot<T0>(arg0, v0, v1, arg1, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
    }

    public fun schedule_next_lot<T0>(arg0: &mut CardsMarket<T0>, arg1: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::Exchange<T0>, arg2: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config, arg3: &0x2::clock::Clock) {
        let v0 = 0x2::object::uid_to_inner(&arg0.id);
        let v1 = arg0.exchange_id;
        assert_config<T0>(arg0, arg2);
        assert_exchange<T0>(arg0, arg1);
        let v2 = RotationKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists<RotationKey>(&arg0.id, v2), 13840689844036567081);
        let v3 = RotationKey{dummy_field: false};
        let v4 = *0x2::dynamic_field::borrow<RotationKey, AuctionRotation>(&arg0.id, v3);
        assert!(v4.enabled, 13840689852626501673);
        assert!(0x1::option::is_none<Lot<T0>>(&arg0.lot), 13840408381944627239);
        let v5 = *0x1::vector::borrow<RotationLot>(&v4.lots, arg0.next_lot % 0x1::vector::length<RotationLot>(&v4.lots));
        let v6 = next_slot(0x2::clock::timestamp_ms(arg3) + 600000, v4.start_offset_ms);
        add_lot<T0>(arg0, v0, v1, arg1, v5.card, v5.quantity, v6, v6 + v4.duration_ms, v5.reserve, v4.min_increment_bps, v4.snipe_ms);
    }

    public fun set_auction_rotation<T0>(arg0: &mut CardsMarket<T0>, arg1: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::Exchange<T0>, arg2: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config, arg3: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::AuthorityCap<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::PACKAGE, 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::ADMIN>, arg4: vector<u16>, arg5: vector<u64>, arg6: vector<u64>, arg7: u64, arg8: u64, arg9: u64, arg10: u64) {
        admin<T0>(arg0, arg2, arg3);
        assert_exchange<T0>(arg0, arg1);
        let v0 = 0x1::vector::length<u16>(&arg4);
        let v1 = if (v0 >= 1) {
            if (v0 <= 64) {
                if (0x1::vector::length<u64>(&arg5) == v0) {
                    0x1::vector::length<u64>(&arg6) == v0
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 13835623105474854917);
        let v2 = if (arg7 <= 10000) {
            if (arg8 >= 1) {
                arg8 <= 2592000000
            } else {
                false
            }
        } else {
            false
        };
        assert!(v2, 13835623109769822213);
        assert!(arg9 <= 3600000 && arg10 < 86400000, 13835623114064789509);
        let v3 = 0x1::vector::empty<RotationLot>();
        let v4 = 0;
        while (v4 < v0) {
            assert_card<T0>(arg1, *0x1::vector::borrow<u16>(&arg4, v4));
            let v5 = if (*0x1::vector::borrow<u64>(&arg5, v4) >= 1) {
                if (*0x1::vector::borrow<u64>(&arg5, v4) <= 0x2dafd0ae920ffa0644d640317bd9c56afb42bdf0f2f92807ce12a995a00f192e::cards::max_quantity()) {
                    *0x1::vector::borrow<u64>(&arg6, v4) >= 1
                } else {
                    false
                }
            } else {
                false
            };
            assert!(v5, 13835623131244658693);
            let v6 = RotationLot{
                card     : *0x1::vector::borrow<u16>(&arg4, v4),
                quantity : *0x1::vector::borrow<u64>(&arg5, v4),
                reserve  : *0x1::vector::borrow<u64>(&arg6, v4),
            };
            0x1::vector::push_back<RotationLot>(&mut v3, v6);
            v4 = v4 + 1;
        };
        let v7 = RotationKey{dummy_field: false};
        let v8 = if (0x2::dynamic_field::exists<RotationKey>(&arg0.id, v7)) {
            let v9 = RotationKey{dummy_field: false};
            let v10 = 0x2::dynamic_field::remove<RotationKey, AuctionRotation>(&mut arg0.id, v9);
            v10.enabled
        } else {
            false
        };
        let v11 = RotationKey{dummy_field: false};
        let v12 = AuctionRotation{
            lots              : v3,
            min_increment_bps : arg7,
            duration_ms       : arg8,
            snipe_ms          : arg9,
            start_offset_ms   : arg10,
            enabled           : v8,
        };
        0x2::dynamic_field::add<RotationKey, AuctionRotation>(&mut arg0.id, v11, v12);
        let v13 = AuctionRotationSetEventV1{
            market_id         : 0x2::object::uid_to_inner(&arg0.id),
            exchange_id       : arg0.exchange_id,
            cards             : arg4,
            quantities        : arg5,
            reserves          : arg6,
            min_increment_bps : arg7,
            duration_ms       : arg8,
            snipe_ms          : arg9,
            start_offset_ms   : arg10,
            enabled           : v8,
        };
        emit<AuctionRotationSetEventV1>(v13);
    }

    public fun set_auction_rotation_enabled<T0>(arg0: &mut CardsMarket<T0>, arg1: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config, arg2: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::AuthorityCap<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::PACKAGE, 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::ADMIN>, arg3: bool) {
        admin<T0>(arg0, arg1, arg2);
        let v0 = RotationKey{dummy_field: false};
        assert!(0x2::dynamic_field::exists<RotationKey>(&arg0.id, v0), 13840689771022123049);
        let v1 = RotationKey{dummy_field: false};
        0x2::dynamic_field::borrow_mut<RotationKey, AuctionRotation>(&mut arg0.id, v1).enabled = arg3;
        let v2 = AuctionRotationSwitchEventV1{
            market_id   : 0x2::object::uid_to_inner(&arg0.id),
            exchange_id : arg0.exchange_id,
            enabled     : arg3,
        };
        emit<AuctionRotationSwitchEventV1>(v2);
    }

    public fun set_offer_period<T0>(arg0: &mut CardsMarket<T0>, arg1: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config, arg2: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::AuthorityCap<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::PACKAGE, 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::ADMIN>, arg3: u64, arg4: u64, arg5: u64) {
        admin<T0>(arg0, arg1, arg2);
        assert!(0x2::table::contains<u64, Offer>(&arg0.offers, arg3), 13837593739550392339);
        assert!(arg5 == 0 || arg5 >= 60000 && arg5 <= 31536000000, 13835623419007467525);
        let v0 = OfferPeriodKey{offer_id: arg3};
        let v1 = if (0x2::dynamic_field::exists<OfferPeriodKey>(&arg0.id, v0)) {
            let v2 = 0x2::dynamic_field::remove<OfferPeriodKey, OfferPeriod>(&mut arg0.id, v0);
            v2.limit
        } else {
            let v3 = 0x2::table::borrow<u64, Offer>(&arg0.offers, arg3).per_owner_limit;
            assert!(0x1::option::is_some<u64>(&v3) || arg5 == 0, 13835623449072238597);
            if (0x1::option::is_some<u64>(&v3)) {
                *0x1::option::borrow<u64>(&v3)
            } else {
                0
            }
        };
        let v4 = if (arg5 == 0) {
            0
        } else {
            arg4
        };
        if (arg5 > 0) {
            let v5 = OfferPeriod{
                anchor_ms : v4,
                period_ms : arg5,
                limit     : v1,
            };
            0x2::dynamic_field::add<OfferPeriodKey, OfferPeriod>(&mut arg0.id, v0, v5);
            0x2::table::borrow_mut<u64, Offer>(&mut arg0.offers, arg3).per_owner_limit = 0x1::option::some<u64>(0);
        } else if (v1 > 0) {
            0x2::table::borrow_mut<u64, Offer>(&mut arg0.offers, arg3).per_owner_limit = 0x1::option::some<u64>(v1);
        };
        let v6 = OfferPeriodSetEventV1{
            market_id       : 0x2::object::uid_to_inner(&arg0.id),
            exchange_id     : arg0.exchange_id,
            offer_id        : arg3,
            anchor_ms       : v4,
            period_ms       : arg5,
            per_owner_limit : v1,
        };
        emit<OfferPeriodSetEventV1>(v6);
    }

    public fun set_pack<T0>(arg0: &mut CardsMarket<T0>, arg1: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config, arg2: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::AuthorityCap<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::PACKAGE, 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::ADMIN>, arg3: u64, arg4: u64, arg5: bool) {
        admin<T0>(arg0, arg1, arg2);
        assert!(0x2::table::contains<u64, PackType>(&arg0.packs, arg3), 13838438679876993049);
        assert!(arg4 >= 1, 13835623934403543045);
        let v0 = 0x2::table::borrow_mut<u64, PackType>(&mut arg0.packs, arg3);
        v0.price = arg4;
        v0.enabled = arg5;
        let v1 = PackTypeSetEventV1{
            market_id      : 0x2::object::uid_to_inner(&arg0.id),
            exchange_id    : arg0.exchange_id,
            pack           : arg3,
            slug           : v0.slug,
            price          : arg4,
            cards_per_pack : v0.cards_per_pack,
            tiers          : v0.tiers,
            enabled        : arg5,
            service_only   : v0.service_only,
            created        : false,
        };
        emit<PackTypeSetEventV1>(v1);
    }

    public fun set_switches<T0>(arg0: &mut CardsMarket<T0>, arg1: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config, arg2: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::AuthorityCap<0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::PACKAGE, 0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::authority::ADMIN>, arg3: bool, arg4: bool, arg5: bool) {
        admin<T0>(arg0, arg1, arg2);
        arg0.auctions_enabled = arg3;
        arg0.shop_enabled = arg4;
        arg0.packs_enabled = arg5;
        let v0 = MarketSwitchesEventV1{
            market_id        : 0x2::object::uid_to_inner(&arg0.id),
            exchange_id      : arg0.exchange_id,
            auctions_enabled : arg3,
            shop_enabled     : arg4,
            packs_enabled    : arg5,
        };
        emit<MarketSwitchesEventV1>(v0);
    }

    public fun settle_auction<T0>(arg0: &mut CardsMarket<T0>, arg1: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::Exchange<T0>, arg2: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2dafd0ae920ffa0644d640317bd9c56afb42bdf0f2f92807ce12a995a00f192e::cards::CardsAction<T0> {
        assert_config<T0>(arg0, arg2);
        assert_exchange<T0>(arg0, arg1);
        assert!(0x1::option::is_some<Lot<T0>>(&arg0.lot), 13836187202184806409);
        assert!(0x2::clock::timestamp_ms(arg3) >= 0x1::option::borrow<Lot<T0>>(&arg0.lot).end_ms, 13837031631410298895);
        let Lot {
            lot_id            : v0,
            card              : v1,
            quantity          : v2,
            start_ms          : _,
            end_ms            : _,
            reserve           : _,
            min_increment_bps : _,
            snipe_ms          : _,
            bidder            : v8,
            escrow            : v9,
            bids              : _,
        } = 0x1::option::extract<Lot<T0>>(&mut arg0.lot);
        let v11 = v9;
        let v12 = v8;
        let v13 = 0x2::balance::value<T0>(&v11);
        let (_, v15, _) = 0x2dafd0ae920ffa0644d640317bd9c56afb42bdf0f2f92807ce12a995a00f192e::cards::params<T0>(arg1);
        let v17 = AuctionSettledEventV1{
            market_id   : 0x2::object::uid_to_inner(&arg0.id),
            exchange_id : arg0.exchange_id,
            lot_id      : v0,
            card        : v1,
            quantity    : v2,
            winner      : v12,
            price       : v13,
            recipient   : v15,
        };
        emit<AuctionSettledEventV1>(v17);
        if (0x1::option::is_none<address>(&v12)) {
            0x2::balance::destroy_zero<T0>(v11);
            return 0x2dafd0ae920ffa0644d640317bd9c56afb42bdf0f2f92807ce12a995a00f192e::cards::settle_action<T0>(arg1, arg2, @0x0, 0x1::option::none<0x2::object::ID>(), 0x1::option::none<0x2::coin::Coin<T0>>(), 0, false, vector[], vector[], 0x2dafd0ae920ffa0644d640317bd9c56afb42bdf0f2f92807ce12a995a00f192e::cards::source_auction())
        };
        let v18 = 0x1::vector::empty<u16>();
        0x1::vector::push_back<u16>(&mut v18, v1);
        let v19 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v19, v2);
        0x2dafd0ae920ffa0644d640317bd9c56afb42bdf0f2f92807ce12a995a00f192e::cards::settle_action<T0>(arg1, arg2, 0x1::option::destroy_some<address>(v12), 0x1::option::none<0x2::object::ID>(), 0x1::option::some<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v11, arg4)), v13, false, v18, v19, 0x2dafd0ae920ffa0644d640317bd9c56afb42bdf0f2f92807ce12a995a00f192e::cards::source_auction())
    }

    fun shop_take<T0>(arg0: &mut CardsMarket<T0>, arg1: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::exchange::Exchange<T0>, arg2: &0x906b2a117c2178d9269db60d782bec6c9199c2ba73d209bb63307d77083011f8::config::Config, arg3: u64, arg4: address, arg5: u64, arg6: 0x1::option::Option<0x2::object::ID>, arg7: &0x2::clock::Clock) : (u16, u64) {
        assert_config<T0>(arg0, arg2);
        assert_exchange<T0>(arg0, arg1);
        assert!(arg0.shop_enabled, 13835343571823230979);
        assert!(0x2::table::contains<u64, Offer>(&arg0.offers, arg3), 13837595375932932115);
        let v0 = 0x2::clock::timestamp_ms(arg7);
        let (_, v2, v3) = 0x2dafd0ae920ffa0644d640317bd9c56afb42bdf0f2f92807ce12a995a00f192e::cards::params<T0>(arg1);
        let v4 = 0x2::table::borrow_mut<u64, Offer>(&mut arg0.offers, arg3);
        assert!(v0 >= v4.start_ms && v0 < v4.end_ms, 13836469493205434379);
        assert_card<T0>(arg1, v4.card);
        assert!(arg5 >= 1 && arg5 <= v3, 13835625076864843781);
        if (0x1::option::is_some<u64>(&v4.stock)) {
            let v5 = 0x1::option::borrow_mut<u64>(&mut v4.stock);
            assert!(*v5 >= arg5, 13837876889564479509);
            *v5 = *v5 - arg5;
        };
        v4.sold = v4.sold + arg5;
        let v6 = v4.card;
        let v7 = v4.price;
        let v8 = v4.per_owner_limit;
        let v9 = BoughtKey{
            offer_id : arg3,
            who      : arg4,
        };
        let v10 = if (0x2::table::contains<BoughtKey, u64>(&arg0.bought, v9)) {
            *0x2::table::borrow<BoughtKey, u64>(&arg0.bought, v9)
        } else {
            0
        };
        let v11 = v10 + arg5;
        if (0x2::table::contains<BoughtKey, u64>(&arg0.bought, v9)) {
            *0x2::table::borrow_mut<BoughtKey, u64>(&mut arg0.bought, v9) = v11;
        } else {
            0x2::table::add<BoughtKey, u64>(&mut arg0.bought, v9, v11);
        };
        let v12 = OfferPeriodKey{offer_id: arg3};
        let v13 = if (0x2::dynamic_field::exists<OfferPeriodKey>(&arg0.id, v12)) {
            let v14 = *0x2::dynamic_field::borrow<OfferPeriodKey, OfferPeriod>(&arg0.id, v12);
            let v15 = period_start(&v14, v0);
            let v16 = BoughtPeriodKey{
                offer_id : arg3,
                who      : arg4,
            };
            let v17 = if (0x2::dynamic_field::exists<BoughtPeriodKey>(&arg0.id, v16)) {
                let v18 = 0x2::dynamic_field::borrow<BoughtPeriodKey, PeriodCount>(&arg0.id, v16);
                if (v18.start == v15) {
                    v18.count
                } else {
                    0
                }
            } else {
                0
            };
            let v19 = v17 + arg5;
            assert!(v19 <= v14.limit, 13838158446145699863);
            if (0x2::dynamic_field::exists<BoughtPeriodKey>(&arg0.id, v16)) {
                let v20 = PeriodCount{
                    start : v15,
                    count : v19,
                };
                *0x2::dynamic_field::borrow_mut<BoughtPeriodKey, PeriodCount>(&mut arg0.id, v16) = v20;
            } else {
                let v21 = PeriodCount{
                    start : v15,
                    count : v19,
                };
                0x2::dynamic_field::add<BoughtPeriodKey, PeriodCount>(&mut arg0.id, v16, v21);
            };
            v19
        } else {
            let v22 = &v8;
            assert!(0x1::option::is_none<u64>(v22) || v11 <= *0x1::option::borrow<u64>(v22), 13838158467620536343);
            v11
        };
        let v23 = mul(v7, arg5);
        let v24 = ShopPurchasedEventV1{
            market_id    : 0x2::object::uid_to_inner(&arg0.id),
            exchange_id  : arg0.exchange_id,
            offer_id     : arg3,
            who          : arg4,
            card         : v6,
            quantity     : arg5,
            unit_price   : v7,
            paid         : v23,
            account_id   : arg6,
            stock_left   : v4.stock,
            owner_bought : v13,
            recipient    : v2,
        };
        emit<ShopPurchasedEventV1>(v24);
        (v6, v23)
    }

    public fun switches<T0>(arg0: &CardsMarket<T0>) : (bool, bool, bool) {
        (arg0.auctions_enabled, arg0.shop_enabled, arg0.packs_enabled)
    }

    public fun tier_parts(arg0: &Tier) : (u64, vector<u16>) {
        (arg0.weight, arg0.cards)
    }

    public fun unopened<T0>(arg0: &CardsMarket<T0>, arg1: address, arg2: u64) : u64 {
        let v0 = PackKey{
            who  : arg1,
            pack : arg2,
        };
        if (0x2::table::contains<PackKey, u64>(&arg0.unopened, v0)) {
            *0x2::table::borrow<PackKey, u64>(&arg0.unopened, v0)
        } else {
            0
        }
    }

    // decompiled from Move bytecode v7
}

