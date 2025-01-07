module 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::auction {
    struct App has drop {
        dummy_field: bool,
    }

    struct AuctionHouse has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        auctions: 0x2::linked_table::LinkedTable<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::domain::Domain, Auction>,
    }

    struct Auction has store {
        domain: 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::domain::Domain,
        start_timestamp_ms: u64,
        end_timestamp_ms: u64,
        winner: address,
        current_bid: 0x2::coin::Coin<0x2::sui::SUI>,
        nft: 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration,
    }

    struct AuctionStartedEvent has copy, drop {
        domain: 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::domain::Domain,
        start_timestamp_ms: u64,
        end_timestamp_ms: u64,
        starting_bid: u64,
        bidder: address,
    }

    struct AuctionFinalizedEvent has copy, drop {
        domain: 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::domain::Domain,
        start_timestamp_ms: u64,
        end_timestamp_ms: u64,
        winning_bid: u64,
        winner: address,
    }

    struct BidEvent has copy, drop {
        domain: 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::domain::Domain,
        bid: u64,
        bidder: address,
    }

    struct AuctionExtendedEvent has copy, drop {
        domain: 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::domain::Domain,
        end_timestamp_ms: u64,
    }

    public fun admin_finalize_auction(arg0: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::AdminCap, arg1: &mut AuctionHouse, arg2: 0x1::string::String, arg3: &0x2::clock::Clock) {
        admin_finalize_auction_internal(arg0, arg1, 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::domain::new(arg2), arg3);
    }

    fun admin_finalize_auction_internal(arg0: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::AdminCap, arg1: &mut AuctionHouse, arg2: 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::domain::Domain, arg3: &0x2::clock::Clock) {
        let Auction {
            domain             : _,
            start_timestamp_ms : v1,
            end_timestamp_ms   : v2,
            winner             : v3,
            current_bid        : v4,
            nft                : v5,
        } = 0x2::linked_table::remove<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::domain::Domain, Auction>(&mut arg1.auctions, arg2);
        let v6 = v4;
        assert!(0x2::clock::timestamp_ms(arg3) > v2, 8);
        let v7 = AuctionFinalizedEvent{
            domain             : arg2,
            start_timestamp_ms : v1,
            end_timestamp_ms   : v2,
            winning_bid        : 0x2::coin::value<0x2::sui::SUI>(&v6),
            winner             : v3,
        };
        0x2::event::emit<AuctionFinalizedEvent>(v7);
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.balance, 0x2::coin::into_balance<0x2::sui::SUI>(v6));
        0x2::transfer::public_transfer<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration>(v5, v3);
    }

    public fun admin_try_finalize_auctions(arg0: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::AdminCap, arg1: &mut AuctionHouse, arg2: u64, arg3: &0x2::clock::Clock) {
        let v0 = *0x2::linked_table::back<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::domain::Domain, Auction>(&arg1.auctions);
        while (0x1::option::is_some<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::domain::Domain>(&v0)) {
            if (arg2 == 0) {
                return
            };
            arg2 = arg2 - 1;
            let v1 = 0x1::option::extract<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::domain::Domain>(&mut v0);
            v0 = *0x2::linked_table::prev<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::domain::Domain, Auction>(&arg1.auctions, v1);
            if (0x2::clock::timestamp_ms(arg3) > 0x2::linked_table::borrow<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::domain::Domain, Auction>(&arg1.auctions, v1).end_timestamp_ms) {
                admin_finalize_auction_internal(arg0, arg1, v1, arg3);
            };
        };
    }

    public fun admin_withdraw_funds(arg0: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::AdminCap, arg1: &mut AuctionHouse, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg1.balance);
        assert!(v0 > 0, 13);
        0x2::coin::take<0x2::sui::SUI>(&mut arg1.balance, v0, arg2)
    }

    public fun claim(arg0: &mut AuctionHouse, arg1: 0x1::string::String, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration {
        let v0 = 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::domain::new(arg1);
        let Auction {
            domain             : _,
            start_timestamp_ms : v2,
            end_timestamp_ms   : v3,
            winner             : v4,
            current_bid        : v5,
            nft                : v6,
        } = 0x2::linked_table::remove<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::domain::Domain, Auction>(&mut arg0.auctions, v0);
        let v7 = v5;
        assert!(0x2::clock::timestamp_ms(arg2) > v3, 8);
        assert!(0x2::tx_context::sender(arg3) == v4, 10);
        let v8 = AuctionFinalizedEvent{
            domain             : v0,
            start_timestamp_ms : v2,
            end_timestamp_ms   : v3,
            winning_bid        : 0x2::coin::value<0x2::sui::SUI>(&v7),
            winner             : v4,
        };
        0x2::event::emit<AuctionFinalizedEvent>(v8);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(v7));
        v6
    }

    public fun collect_winning_auction_fund(arg0: &mut AuctionHouse, arg1: 0x1::string::String, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::linked_table::borrow_mut<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::domain::Domain, Auction>(&mut arg0.auctions, 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::domain::new(arg1));
        assert!(0x2::clock::timestamp_ms(arg2) > v0.end_timestamp_ms, 8);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut v0.current_bid, 0x2::coin::value<0x2::sui::SUI>(&mut v0.current_bid), arg3)));
    }

    public fun get_auction_metadata(arg0: &AuctionHouse, arg1: 0x1::string::String) : (0x1::option::Option<u64>, 0x1::option::Option<u64>, 0x1::option::Option<address>, 0x1::option::Option<u64>) {
        let v0 = 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::domain::new(arg1);
        if (0x2::linked_table::contains<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::domain::Domain, Auction>(&arg0.auctions, v0)) {
            let v1 = 0x2::linked_table::borrow<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::domain::Domain, Auction>(&arg0.auctions, v0);
            return (0x1::option::some<u64>(v1.start_timestamp_ms), 0x1::option::some<u64>(v1.end_timestamp_ms), 0x1::option::some<address>(v1.winner), 0x1::option::some<u64>(0x2::coin::value<0x2::sui::SUI>(&v1.current_bid)))
        };
        (0x1::option::none<u64>(), 0x1::option::none<u64>(), 0x1::option::none<address>(), 0x1::option::none<u64>())
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AuctionHouse{
            id       : 0x2::object::new(arg0),
            balance  : 0x2::balance::zero<0x2::sui::SUI>(),
            auctions : 0x2::linked_table::new<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::domain::Domain, Auction>(arg0),
        };
        0x2::transfer::share_object<AuctionHouse>(v0);
    }

    public fun place_bid(arg0: &mut AuctionHouse, arg1: 0x1::string::String, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::domain::new(arg1);
        let v1 = 0x2::tx_context::sender(arg4);
        assert!(0x2::linked_table::contains<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::domain::Domain, Auction>(&arg0.auctions, v0), 7);
        let Auction {
            domain             : v2,
            start_timestamp_ms : v3,
            end_timestamp_ms   : v4,
            winner             : v5,
            current_bid        : v6,
            nft                : v7,
        } = 0x2::linked_table::remove<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::domain::Domain, Auction>(&mut arg0.auctions, v0);
        let v8 = v7;
        let v9 = v6;
        let v10 = v4;
        assert!(0x2::clock::timestamp_ms(arg3) <= v4, 9);
        assert!(v1 != v5, 11);
        let v11 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        assert!(v11 > 0x2::coin::value<0x2::sui::SUI>(&v9), 12);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v9, v5);
        let v12 = BidEvent{
            domain : v2,
            bid    : v11,
            bidder : v1,
        };
        0x2::event::emit<BidEvent>(v12);
        if (v4 - 0x2::clock::timestamp_ms(arg3) < 600000) {
            let v13 = 0x2::clock::timestamp_ms(arg3) + 600000;
            if (v13 < 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::expiration_timestamp_ms(&v8)) {
                v10 = v13;
                let v14 = AuctionExtendedEvent{
                    domain           : v2,
                    end_timestamp_ms : v13,
                };
                0x2::event::emit<AuctionExtendedEvent>(v14);
            };
        };
        let v15 = Auction{
            domain             : v2,
            start_timestamp_ms : v3,
            end_timestamp_ms   : v10,
            winner             : 0x2::tx_context::sender(arg4),
            current_bid        : arg2,
            nft                : v8,
        };
        0x2::linked_table::push_front<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::domain::Domain, Auction>(&mut arg0.auctions, v2, v15);
    }

    public fun start_auction_and_place_bid(arg0: &mut AuctionHouse, arg1: &mut 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS, arg2: 0x1::string::String, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::assert_app_is_authorized<App>(arg1);
        let v0 = 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::domain::new(arg2);
        0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::config::assert_valid_user_registerable_domain(&v0);
        assert!(!0x2::linked_table::contains<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::domain::Domain, Auction>(&arg0.auctions, v0), 1);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) >= 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::config::calculate_price(0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::get_config<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::config::Config>(arg1), (0x1::string::length(0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::domain::sld(&v0)) as u8), 1), 0);
        let v1 = App{dummy_field: false};
        let v2 = Auction{
            domain             : v0,
            start_timestamp_ms : 0x2::clock::timestamp_ms(arg4),
            end_timestamp_ms   : 0x2::clock::timestamp_ms(arg4) + 172800000,
            winner             : 0x2::tx_context::sender(arg5),
            current_bid        : arg3,
            nft                : 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::registry::add_record(0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::app_registry_mut<App, 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::registry::Registry>(v1, arg1), v0, 1, arg4, arg5),
        };
        let v3 = AuctionStartedEvent{
            domain             : v0,
            start_timestamp_ms : v2.start_timestamp_ms,
            end_timestamp_ms   : v2.end_timestamp_ms,
            starting_bid       : 0x2::coin::value<0x2::sui::SUI>(&arg3),
            bidder             : v2.winner,
        };
        0x2::event::emit<AuctionStartedEvent>(v3);
        0x2::linked_table::push_front<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::domain::Domain, Auction>(&mut arg0.auctions, v0, v2);
    }

    // decompiled from Move bytecode v6
}

