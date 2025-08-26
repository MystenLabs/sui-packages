module 0xff4982cd449809676699d1a52c5562fc15b9b92cb41bde5f8845a14647186704::auction {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Auction has store, key {
        id: 0x2::object::UID,
        admin_cap_id: 0x2::object::ID,
        paused: bool,
        size: u32,
        start_ms: u64,
        end_ms: u64,
        vault: 0x2::balance::Balance<0x2::sui::SUI>,
        bidders: 0x2::table::Table<address, u64>,
        winners: vector<address>,
        clearing_price: u64,
        finalized: bool,
        raffle_done: bool,
    }

    struct AuctionCreateEvent has copy, drop {
        auction_id: 0x2::object::ID,
        admin_cap_id: 0x2::object::ID,
    }

    struct BidEvent has copy, drop {
        auction_id: 0x2::object::ID,
        total_bid_amount: u64,
    }

    struct RaffleResultEvent has copy, drop {
        auction_id: 0x2::object::ID,
        winners: vector<address>,
    }

    struct FinalizedEvent has copy, drop {
        auction_id: 0x2::object::ID,
        funds: u64,
        clearing_price: u64,
    }

    struct EmergencyEvent has copy, drop {
        total_fund: u64,
        auction_id: 0x2::object::ID,
    }

    fun assert_is_active(arg0: &Auction, arg1: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        assert!(v0 >= arg0.start_ms, 1);
        assert!(v0 < arg0.end_ms, 2);
        assert!(!arg0.paused, 15);
    }

    public fun bid(arg0: &mut Auction, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : u64 {
        assert_is_active(arg0, arg2);
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v1 > 0, 12);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.vault, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        let v2 = if (0x2::table::contains<address, u64>(&arg0.bidders, v0)) {
            let v3 = 0x2::table::borrow_mut<address, u64>(&mut arg0.bidders, v0);
            *v3 = *v3 + v1;
            *v3
        } else {
            assert!(v1 >= 1000000000, 11);
            0x2::table::add<address, u64>(&mut arg0.bidders, v0, v1);
            v1
        };
        let v4 = BidEvent{
            auction_id       : 0x2::object::uid_to_inner(&arg0.id),
            total_bid_amount : v2,
        };
        0x2::event::emit<BidEvent>(v4);
        v2
    }

    public(friend) fun bisect_address(arg0: &vector<address>, arg1: address) : bool {
        let v0 = 0x1::vector::length<address>(arg0);
        if (v0 == 0) {
            return false
        };
        let v1 = 0x2::address::to_u256(arg1);
        let v2 = 0;
        while (v2 < v0) {
            let v3 = v2 + (v0 - v2) / 2;
            let v4 = 0x2::address::to_u256(*0x1::vector::borrow<address>(arg0, v3));
            if (v1 == v4) {
                return true
            };
            if (v1 < v4) {
                v0 = v3;
                continue
            };
            v2 = v3 + 1;
        };
        false
    }

    public fun clearing_price(arg0: &Auction) : 0x1::option::Option<u64> {
        if (arg0.finalized) {
            0x1::option::some<u64>(arg0.clearing_price)
        } else {
            0x1::option::none<u64>()
        }
    }

    public fun create(arg0: &AdminCap, arg1: u64, arg2: u64, arg3: u32, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = create_(arg0, arg1, arg2, arg3, arg4, arg5);
        let v1 = AuctionCreateEvent{
            auction_id   : 0x2::object::id<Auction>(&v0),
            admin_cap_id : 0x2::object::id<AdminCap>(arg0),
        };
        0x2::event::emit<AuctionCreateEvent>(v1);
        0x2::transfer::public_share_object<Auction>(v0);
    }

    public(friend) fun create_(arg0: &AdminCap, arg1: u64, arg2: u64, arg3: u32, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : Auction {
        assert!(arg1 >= 0x2::clock::timestamp_ms(arg4) + 3600000, 8);
        assert!(arg2 >= 3600000, 7);
        Auction{
            id             : 0x2::object::new(arg5),
            admin_cap_id   : 0x2::object::id<AdminCap>(arg0),
            paused         : false,
            size           : arg3,
            start_ms       : arg1,
            end_ms         : arg1 + arg2,
            vault          : 0x2::balance::zero<0x2::sui::SUI>(),
            bidders        : 0x2::table::new<address, u64>(arg5),
            winners        : 0x1::vector::empty<address>(),
            clearing_price : 0,
            finalized      : false,
            raffle_done    : false,
        }
    }

    public fun create_admin_cap(arg0: &mut 0x2::tx_context::TxContext) : AdminCap {
        AdminCap{id: 0x2::object::new(arg0)}
    }

    public fun emergency_withdraw(arg0: &AdminCap, arg1: &mut Auction, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.paused, 18);
        assert!(0x2::object::id<AdminCap>(arg0) == arg1.admin_cap_id, 13);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg1.vault);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.vault, v0), arg2), 0x2::tx_context::sender(arg2));
        let v1 = EmergencyEvent{
            total_fund : v0,
            auction_id : 0x2::object::id<Auction>(arg1),
        };
        0x2::event::emit<EmergencyEvent>(v1);
    }

    public fun end_ms(arg0: &Auction) : u64 {
        arg0.end_ms
    }

    public fun finalize_continue(arg0: &AdminCap, arg1: &mut Auction, arg2: vector<address>, arg3: &0x2::clock::Clock) {
        assert!(0x2::object::id<AdminCap>(arg0) == arg1.admin_cap_id, 13);
        assert!(is_sorted(&arg2), 9);
        assert!(!arg1.finalized, 5);
        assert!(arg1.end_ms <= 0x2::clock::timestamp_ms(arg3), 3);
        assert!(0x2::address::to_u256(*0x1::vector::borrow<address>(&arg1.winners, 0x1::vector::length<address>(&arg1.winners) - 1)) < 0x2::address::to_u256(*0x1::vector::borrow<address>(&arg2, 0)), 9);
        0x1::vector::append<address>(&mut arg1.winners, arg2);
    }

    public fun finalize_end(arg0: &AdminCap, arg1: &mut Auction, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::id<AdminCap>(arg0) == arg1.admin_cap_id, 13);
        assert!(!arg1.finalized, 5);
        arg1.finalized = true;
        arg1.clearing_price = arg2;
        let v0 = 0x1::vector::length<address>(&arg1.winners);
        assert!(0 < v0 && v0 <= (arg1.size as u64), 10);
        let v1 = arg1.clearing_price * v0 - 18000000000;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.vault, v1), arg3), 0x2::tx_context::sender(arg3));
        let v2 = FinalizedEvent{
            auction_id     : 0x2::object::uid_to_inner(&arg1.id),
            funds          : v1,
            clearing_price : arg1.clearing_price,
        };
        0x2::event::emit<FinalizedEvent>(v2);
    }

    public fun finalize_start(arg0: &AdminCap, arg1: &mut Auction, arg2: vector<address>, arg3: &0x2::clock::Clock) {
        assert!(0x2::object::id<AdminCap>(arg0) == arg1.admin_cap_id, 13);
        assert!(!arg1.finalized, 5);
        assert!(arg1.end_ms <= 0x2::clock::timestamp_ms(arg3), 3);
        assert!(is_sorted(&arg2), 9);
        arg1.winners = arg2;
    }

    public fun is_finalized(arg0: &Auction) : bool {
        arg0.finalized
    }

    public fun is_paused(arg0: &Auction) : bool {
        arg0.paused
    }

    fun is_sorted(arg0: &vector<address>) : bool {
        let v0 = 0x1::vector::length<address>(arg0);
        if (v0 < 2) {
            return true
        };
        let v1 = 1;
        let v2 = 0x2::address::to_u256(*0x1::vector::borrow<address>(arg0, 0));
        while (v1 < v0) {
            v2 = 0x2::address::to_u256(*0x1::vector::borrow<address>(arg0, v1));
            if (v2 >= v2) {
                return false
            };
            v1 = v1 + 1;
        };
        true
    }

    public fun is_winner(arg0: &Auction, arg1: address) : bool {
        bisect_address(&arg0.winners, arg1)
    }

    public fun query_total_bid(arg0: &Auction, arg1: address) : 0x1::option::Option<u64> {
        if (!0x2::table::contains<address, u64>(&arg0.bidders, arg1)) {
            return 0x1::option::none<u64>()
        };
        0x1::option::some<u64>(*0x2::table::borrow<address, u64>(&arg0.bidders, arg1))
    }

    public fun reset_status(arg0: &AdminCap, arg1: &mut Auction) {
        assert!(0x2::object::id<AdminCap>(arg0) == arg1.admin_cap_id, 13);
        assert!(!arg1.finalized, 5);
        arg1.winners = 0x1::vector::empty<address>();
    }

    public entry fun run_raffle(arg0: &mut Auction, arg1: &AdminCap, arg2: u32, arg3: &0x2::random::Random, arg4: &mut 0x2::tx_context::TxContext) : vector<address> {
        assert!(0x2::object::id<AdminCap>(arg1) == arg0.admin_cap_id, 13);
        assert!(!arg0.finalized, 5);
        assert!(!arg0.raffle_done, 17);
        arg0.raffle_done = true;
        let v0 = (0x1::vector::length<address>(&arg0.winners) as u32);
        assert!(arg2 <= v0 / 2, 16);
        let v1 = vector[];
        let v2 = 0x2::random::new_generator(arg3, arg4);
        let v3 = 1;
        while (v3 <= arg2) {
            let v4 = *0x1::vector::borrow<address>(&arg0.winners, (0x2::random::generate_u32_in_range(&mut v2, 0, v0 - 1) as u64));
            if (!0x1::vector::contains<address>(&v1, &v4)) {
                0x1::vector::push_back<address>(&mut v1, v4);
                v3 = v3 + 1;
            };
        };
        let v5 = RaffleResultEvent{
            auction_id : 0x2::object::uid_to_inner(&arg0.id),
            winners    : v1,
        };
        0x2::event::emit<RaffleResultEvent>(v5);
        v1
    }

    public fun set_paused(arg0: &AdminCap, arg1: &mut Auction, arg2: bool) {
        assert!(0x2::object::id<AdminCap>(arg0) == arg1.admin_cap_id, 13);
        arg1.paused = arg2;
    }

    public fun size(arg0: &Auction) : u32 {
        arg0.size
    }

    public fun start_ms(arg0: &Auction) : u64 {
        arg0.start_ms
    }

    public entry fun withdraw(arg0: &mut Auction, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.finalized, 4);
        assert!(!arg0.paused, 15);
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x2::table::contains<address, u64>(&arg0.bidders, v0), 6);
        let v1 = 0x2::table::remove<address, u64>(&mut arg0.bidders, v0);
        let v2 = if (bisect_address(&arg0.winners, v0)) {
            assert!(v1 >= arg0.clearing_price, 14);
            v1 - arg0.clearing_price
        } else {
            v1
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.vault, v2), arg1), v0);
    }

    // decompiled from Move bytecode v6
}

