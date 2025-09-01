module 0x5f6f9d3eab6a00d877fe6f982cad0d4071d9ba1c29a05e1fc9e556805af89320::core {
    struct AuctionRegistry has key {
        id: 0x2::object::UID,
        admin: address,
        platform_fee: u64,
        auction_treasury: address,
        active_auctions: vector<0x2::object::ID>,
        inactive_auctions: vector<0x2::object::ID>,
        previous_auctions: 0x2::table::Table<0x2::object::ID, AuctionResult>,
    }

    struct InvoiceRegistry has key {
        id: 0x2::object::UID,
        penalty_slash: u64,
        invoice_duration: u64,
        active_invoices: 0x2::vec_map::VecMap<address, 0x2::object::ID>,
    }

    struct WinnerBidInfo has copy, drop, store {
        pos: u8,
        winner: address,
        dvd_id: 0x2::object::ID,
        amount: u64,
    }

    struct Auction has key {
        id: 0x2::object::UID,
        duration: u64,
        start_time: u64,
        min_bid: u64,
        bid_type: 0x1::type_name::TypeName,
        bond_amount: u64,
        bids: 0x2::vec_map::VecMap<0x2::object::ID, 0x2::object::ID>,
        winners: 0x2::vec_map::VecMap<0x2::object::ID, WinnerBidInfo>,
        reward: 0x2::bag::Bag,
        creator: address,
        admin: address,
        is_invalidated: bool,
        is_paused: bool,
        image_url: 0x1::string::String,
        name: 0x1::string::String,
        description: 0x1::string::String,
    }

    struct AuctionResult has store, key {
        id: 0x2::object::UID,
        winner: address,
        started_at: u64,
        ended_at: u64,
        min_bid: u64,
        bid_amt: u64,
        valid_auction: bool,
    }

    struct SealBid has key {
        id: 0x2::object::UID,
        owner: 0x2::object::ID,
        auction_id: 0x2::object::ID,
        bond_amt: 0x2::balance::Balance<0x2::sui::SUI>,
        seal_data: vector<u8>,
        created_at: u64,
    }

    struct Invoice has key {
        id: 0x2::object::UID,
        owner: 0x2::object::ID,
        auction_id: 0x2::object::ID,
        expires_at: u64,
        starts_at: u64,
        payable_amt: u64,
    }

    struct AuctionCreatedEvent has copy, drop {
        auction_id: 0x2::object::ID,
        auction_name: 0x1::string::String,
        auction_description: 0x1::string::String,
        auction_image_url: 0x1::string::String,
        auction_start_time: u64,
        auction_duration: u64,
        bid_type: 0x1::type_name::TypeName,
    }

    struct WinnerInfo has copy, drop, store {
        pos: u8,
        winner: address,
        dvd_id: 0x2::object::ID,
        amount: u64,
        auction_title: 0x1::string::String,
        bid_type: 0x1::type_name::TypeName,
    }

    struct AuctionWinnerEvent has copy, drop {
        auction_id: 0x2::object::ID,
        winners: vector<WinnerInfo>,
    }

    public(friend) fun bid(arg0: 0x2::object::ID, arg1: &AuctionRegistry, arg2: &mut Auction, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        validate_auction_status(arg2);
        assert!(!0x2::vec_map::contains<0x2::object::ID, 0x2::object::ID>(&arg2.bids, &arg0), 0);
        assert!(0x2::clock::timestamp_ms(arg5) >= arg2.start_time, 6);
        assert!(0x2::clock::timestamp_ms(arg5) <= arg2.start_time + arg2.duration, 7);
        let v0 = 0x2::object::id<Auction>(arg2);
        assert!(0x1::vector::contains<0x2::object::ID>(&arg1.active_auctions, &v0), 9);
        let v1 = SealBid{
            id         : 0x2::object::new(arg6),
            owner      : arg0,
            auction_id : 0x2::object::id<Auction>(arg2),
            bond_amt   : 0x2::coin::into_balance<0x2::sui::SUI>(arg3),
            seal_data  : arg4,
            created_at : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::vec_map::insert<0x2::object::ID, 0x2::object::ID>(&mut arg2.bids, arg0, 0x2::object::id<SealBid>(&v1));
        0x2::transfer::transfer<SealBid>(v1, 0x2::tx_context::sender(arg6));
    }

    public(friend) fun claim_auction_reward<T0: store + key, T1: drop>(arg0: 0x2::object::ID, arg1: &mut AuctionRegistry, arg2: SealBid, arg3: Invoice, arg4: 0x2::coin::Coin<T1>, arg5: &mut Auction, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        validate_auction_status(arg5);
        assert!(0x2::clock::timestamp_ms(arg6) >= arg5.start_time + arg5.duration, 8);
        assert!(0x2::vec_map::size<0x2::object::ID, WinnerBidInfo>(&arg5.winners) >= 1, 16);
        let v0 = 0x2::vec_map::get<0x2::object::ID, WinnerBidInfo>(&arg5.winners, &arg0);
        assert!(v0.dvd_id == arg0, 3);
        assert!(0x2::tx_context::sender(arg7) == v0.winner, 4);
        assert!(0x2::clock::timestamp_ms(arg6) <= arg3.expires_at, 5);
        assert!(0x2::object::id<Auction>(arg5) == arg3.auction_id, 1);
        0x2::transfer::public_transfer<T0>(0x2::bag::remove<u64, T0>(&mut arg5.reward, 0), 0x2::tx_context::sender(arg7));
        let v1 = 0x2::object::id<Auction>(arg5);
        let (v2, v3) = 0x1::vector::index_of<0x2::object::ID>(&arg1.active_auctions, &v1);
        assert!(v2, 1);
        0x1::vector::remove<0x2::object::ID>(&mut arg1.active_auctions, v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg4, arg1.auction_treasury);
        let v4 = AuctionResult{
            id            : 0x2::object::new(arg7),
            winner        : 0x2::tx_context::sender(arg7),
            started_at    : arg5.start_time,
            ended_at      : arg5.duration + arg5.start_time,
            min_bid       : arg5.min_bid,
            bid_amt       : 0x2::coin::value<T1>(&arg4),
            valid_auction : true,
        };
        0x2::table::add<0x2::object::ID, AuctionResult>(&mut arg1.previous_auctions, 0x2::object::id<AuctionResult>(&v4), v4);
        let Invoice {
            id          : v5,
            owner       : _,
            auction_id  : _,
            expires_at  : _,
            starts_at   : _,
            payable_amt : _,
        } = arg3;
        0x2::object::delete(v5);
        let SealBid {
            id         : v11,
            owner      : v12,
            auction_id : _,
            bond_amt   : v14,
            seal_data  : _,
            created_at : _,
        } = arg2;
        assert!(v12 == arg0, 10);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v14, arg7), 0x2::tx_context::sender(arg7));
        0x2::object::delete(v11);
    }

    public(friend) fun create_auction<T0: store + key>(arg0: &0x5f6f9d3eab6a00d877fe6f982cad0d4071d9ba1c29a05e1fc9e556805af89320::auction_authority::AuctionOperatorCap, arg1: &mut AuctionRegistry, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: 0x1::type_name::TypeName, arg7: T0, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: 0x1::string::String, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = Auction{
            id             : 0x2::object::new(arg11),
            duration       : arg2,
            start_time     : arg3,
            min_bid        : arg4,
            bid_type       : arg6,
            bond_amount    : arg5,
            bids           : 0x2::vec_map::empty<0x2::object::ID, 0x2::object::ID>(),
            winners        : 0x2::vec_map::empty<0x2::object::ID, WinnerBidInfo>(),
            reward         : 0x2::bag::new(arg11),
            creator        : 0x2::tx_context::sender(arg11),
            admin          : arg1.admin,
            is_invalidated : false,
            is_paused      : false,
            image_url      : arg8,
            name           : arg9,
            description    : arg10,
        };
        0x2::bag::add<u64, T0>(&mut v0.reward, 0, arg7);
        0x1::vector::push_back<0x2::object::ID>(&mut arg1.active_auctions, 0x2::object::id<Auction>(&v0));
        let v1 = AuctionCreatedEvent{
            auction_id          : 0x2::object::id<Auction>(&v0),
            auction_name        : arg9,
            auction_description : arg10,
            auction_image_url   : arg8,
            auction_start_time  : arg3,
            auction_duration    : arg2,
            bid_type            : arg6,
        };
        0x2::event::emit<AuctionCreatedEvent>(v1);
        0x2::transfer::share_object<Auction>(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AuctionRegistry{
            id                : 0x2::object::new(arg0),
            admin             : 0x2::tx_context::sender(arg0),
            platform_fee      : 0,
            auction_treasury  : 0x2::tx_context::sender(arg0),
            active_auctions   : 0x1::vector::empty<0x2::object::ID>(),
            inactive_auctions : 0x1::vector::empty<0x2::object::ID>(),
            previous_auctions : 0x2::table::new<0x2::object::ID, AuctionResult>(arg0),
        };
        0x2::transfer::share_object<AuctionRegistry>(v0);
        let v1 = InvoiceRegistry{
            id               : 0x2::object::new(arg0),
            penalty_slash    : 70,
            invoice_duration : 86400000,
            active_invoices  : 0x2::vec_map::empty<address, 0x2::object::ID>(),
        };
        0x2::transfer::share_object<InvoiceRegistry>(v1);
    }

    public(friend) fun invalidate_auction<T0: store + key>(arg0: &mut AuctionRegistry, arg1: &mut Auction, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<Auction>(arg1);
        let (v1, v2) = 0x1::vector::index_of<0x2::object::ID>(&arg0.active_auctions, &v0);
        assert!(v1, 1);
        0x1::vector::remove<0x2::object::ID>(&mut arg0.active_auctions, v2);
        0x1::vector::push_back<0x2::object::ID>(&mut arg0.inactive_auctions, 0x2::object::id<Auction>(arg1));
        0x2::transfer::public_transfer<T0>(0x2::bag::remove<u64, T0>(&mut arg1.reward, 0), 0x2::tx_context::sender(arg2));
        let v3 = AuctionResult{
            id            : 0x2::object::new(arg2),
            winner        : 0x2::tx_context::sender(arg2),
            started_at    : arg1.start_time,
            ended_at      : arg1.start_time + arg1.duration,
            min_bid       : arg1.min_bid,
            bid_amt       : 0,
            valid_auction : false,
        };
        0x2::table::add<0x2::object::ID, AuctionResult>(&mut arg0.previous_auctions, 0x2::object::id<Auction>(arg1), v3);
    }

    fun penalty_slash<T0>(arg0: &AuctionRegistry, arg1: &InvoiceRegistry, arg2: 0x2::balance::Balance<T0>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg2, 0x2::balance::value<T0>(&arg2) * arg1.penalty_slash / 100), arg3), arg0.auction_treasury);
        arg2
    }

    entry fun seal_approve_auction(arg0: vector<u8>, arg1: &Auction, arg2: &0x2::tx_context::TxContext) {
        assert!(arg1.creator == 0x2::tx_context::sender(arg2), 17);
    }

    public(friend) fun set_winner(arg0: &mut Auction, arg1: &InvoiceRegistry, arg2: vector<address>, arg3: vector<0x2::object::ID>, arg4: vector<u8>, arg5: vector<u64>, arg6: vector<u64>, arg7: vector<u64>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        validate_auction_status(arg0);
        assert!(0x2::vec_map::size<0x2::object::ID, WinnerBidInfo>(&arg0.winners) <= 3, 2);
        assert!(0x2::clock::timestamp_ms(arg8) >= arg0.start_time, 6);
        assert!(0x2::clock::timestamp_ms(arg8) >= arg0.start_time + arg0.duration, 8);
        let v0 = 0x1::vector::length<address>(&arg2);
        let v1 = 0x1::vector::empty<WinnerInfo>();
        while (v0 > 0) {
            v0 = v0 - 1;
            assert!(*0x1::vector::borrow<u64>(&arg6, v0) < *0x1::vector::borrow<u64>(&arg5, v0), 14);
            assert!(arg1.invoice_duration == *0x1::vector::borrow<u64>(&arg5, v0) - *0x1::vector::borrow<u64>(&arg6, v0), 18);
            let v2 = WinnerBidInfo{
                pos    : *0x1::vector::borrow<u8>(&arg4, v0),
                winner : *0x1::vector::borrow<address>(&arg2, v0),
                dvd_id : *0x1::vector::borrow<0x2::object::ID>(&arg3, v0),
                amount : *0x1::vector::borrow<u64>(&arg7, v0),
            };
            0x2::vec_map::insert<0x2::object::ID, WinnerBidInfo>(&mut arg0.winners, *0x1::vector::borrow<0x2::object::ID>(&arg3, v0), v2);
            let v3 = Invoice{
                id          : 0x2::object::new(arg9),
                owner       : *0x1::vector::borrow<0x2::object::ID>(&arg3, v0),
                auction_id  : 0x2::object::id<Auction>(arg0),
                expires_at  : *0x1::vector::borrow<u64>(&arg5, v0),
                starts_at   : *0x1::vector::borrow<u64>(&arg6, v0),
                payable_amt : *0x1::vector::borrow<u64>(&arg7, v0),
            };
            0x2::transfer::transfer<Invoice>(v3, *0x1::vector::borrow<address>(&arg2, v0));
            let v4 = WinnerInfo{
                pos           : *0x1::vector::borrow<u8>(&arg4, v0),
                winner        : *0x1::vector::borrow<address>(&arg2, v0),
                dvd_id        : *0x1::vector::borrow<0x2::object::ID>(&arg3, v0),
                amount        : *0x1::vector::borrow<u64>(&arg7, v0),
                auction_title : arg0.name,
                bid_type      : arg0.bid_type,
            };
            0x1::vector::push_back<WinnerInfo>(&mut v1, v4);
        };
        let v5 = AuctionWinnerEvent{
            auction_id : 0x2::object::id<Auction>(arg0),
            winners    : v1,
        };
        0x2::event::emit<AuctionWinnerEvent>(v5);
    }

    public(friend) fun settle_bond(arg0: 0x2::object::ID, arg1: SealBid, arg2: &AuctionRegistry, arg3: &Auction, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        validate_auction_status(arg3);
        assert!(0x2::clock::timestamp_ms(arg4) >= arg3.start_time + arg3.duration, 8);
        assert!(!0x2::vec_map::contains<0x2::object::ID, WinnerBidInfo>(&arg3.winners, &arg0), 11);
        assert!(0x2::vec_map::size<0x2::object::ID, WinnerBidInfo>(&arg3.winners) >= 1, 16);
        let SealBid {
            id         : v0,
            owner      : v1,
            auction_id : _,
            bond_amt   : v3,
            seal_data  : _,
            created_at : _,
        } = arg1;
        assert!(v1 == arg0, 10);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v3, arg5), 0x2::tx_context::sender(arg5));
        0x2::object::delete(v0);
    }

    public(friend) fun settle_bond_winner(arg0: 0x2::object::ID, arg1: SealBid, arg2: Invoice, arg3: &InvoiceRegistry, arg4: &AuctionRegistry, arg5: &Auction, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        validate_auction_status(arg5);
        assert!(0x2::clock::timestamp_ms(arg6) >= arg5.start_time + arg5.duration, 8);
        assert!(0x2::vec_map::contains<0x2::object::ID, WinnerBidInfo>(&arg5.winners, &arg0), 11);
        assert!(0x2::vec_map::size<0x2::object::ID, WinnerBidInfo>(&arg5.winners) >= 1, 16);
        let SealBid {
            id         : v0,
            owner      : _,
            auction_id : _,
            bond_amt   : v3,
            seal_data  : _,
            created_at : _,
        } = arg1;
        0x2::object::delete(v0);
        let Invoice {
            id          : v6,
            owner       : v7,
            auction_id  : _,
            expires_at  : v9,
            starts_at   : v10,
            payable_amt : _,
        } = arg2;
        assert!(0x2::clock::timestamp_ms(arg6) < v10, 12);
        assert!(v7 == arg0, 10);
        if (0x2::clock::timestamp_ms(arg6) >= v10 || 0x2::clock::timestamp_ms(arg6) <= v9) {
            let v12 = penalty_slash<0x2::sui::SUI>(arg4, arg3, v3, arg7);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v12, arg7), 0x2::tx_context::sender(arg7));
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v3, arg7), 0x2::tx_context::sender(arg7));
        };
        0x2::object::delete(v6);
    }

    public(friend) fun update_auction_status(arg0: &AuctionRegistry, arg1: &mut Auction, arg2: bool, arg3: &0x2::clock::Clock) {
        validate_auction_status(arg1);
        assert!(0x2::clock::timestamp_ms(arg3) >= arg1.start_time, 6);
        assert!(0x2::clock::timestamp_ms(arg3) <= arg1.start_time + arg1.duration, 7);
        let v0 = 0x2::object::id<Auction>(arg1);
        assert!(0x1::vector::contains<0x2::object::ID>(&arg0.active_auctions, &v0), 9);
        arg1.is_paused = arg2;
    }

    public(friend) fun update_registry(arg0: &mut AuctionRegistry, arg1: address, arg2: u64, arg3: address) {
        arg0.admin = arg1;
        arg0.platform_fee = arg2;
        arg0.auction_treasury = arg3;
    }

    public(friend) fun validate_auction_status(arg0: &Auction) {
        assert!(!arg0.is_invalidated, 1);
        assert!(!arg0.is_paused, 13);
    }

    // decompiled from Move bytecode v6
}

