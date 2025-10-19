module 0x9f92672b2d6075d745ab6e4b8ad0de9b46850b735d43e531f3f729a7b8e9c0b4::auctions {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Auction has key {
        id: 0x2::object::UID,
        creator: address,
        minimum_bid: u64,
        highest_bid: u64,
        highest_bidder: address,
        highest_bidder_deposit: 0x2::balance::Balance<0x2::sui::SUI>,
        participants: vector<address>,
        active: bool,
        has_nft: bool,
        nft_type: 0x1::ascii::String,
        end_time: u64,
    }

    public fun bid(arg0: &mut Auction, arg1: &mut 0x9f92672b2d6075d745ab6e4b8ad0de9b46850b735d43e531f3f729a7b8e9c0b4::user_stats::UserStatsRegistry, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        let v2 = 0x2::object::id<Auction>(arg0);
        assert!(arg0.active, 2);
        assert!(0x2::clock::timestamp_ms(arg3) < arg0.end_time, 2);
        assert!(v0 != arg0.creator, 4);
        assert!(v1 >= arg0.minimum_bid, 1);
        assert!(v1 > arg0.highest_bid, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg2, v1 * 300 / 10000, arg4), @0xe430edc5ebde04571d3a20c5bbe3f0c42543cfab1e7e249e0d89b7630ada0cf6);
        if (arg0.highest_bidder != arg0.creator && 0x2::balance::value<0x2::sui::SUI>(&arg0.highest_bidder_deposit) > 0) {
            0x9f92672b2d6075d745ab6e4b8ad0de9b46850b735d43e531f3f729a7b8e9c0b4::user_stats::record_outbid(arg1, arg0.highest_bidder, v2, arg0.highest_bid, v1, arg4);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.highest_bidder_deposit), arg4), arg0.highest_bidder);
        };
        0x9f92672b2d6075d745ab6e4b8ad0de9b46850b735d43e531f3f729a7b8e9c0b4::user_stats::record_bid(arg1, v0, v2, v1, arg4);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.highest_bidder_deposit, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
        arg0.highest_bid = v1;
        arg0.highest_bidder = v0;
        if (!0x1::vector::contains<address>(&arg0.participants, &v0)) {
            0x1::vector::push_back<address>(&mut arg0.participants, v0);
        };
    }

    public fun close_auction<T0: store + key>(arg0: &AdminCap, arg1: &mut Auction, arg2: &mut 0x9f92672b2d6075d745ab6e4b8ad0de9b46850b735d43e531f3f729a7b8e9c0b4::dashboard::Dashboard, arg3: &mut 0x9f92672b2d6075d745ab6e4b8ad0de9b46850b735d43e531f3f729a7b8e9c0b4::user_stats::UserStatsRegistry, arg4: &mut 0x9f92672b2d6075d745ab6e4b8ad0de9b46850b735d43e531f3f729a7b8e9c0b4::leaderboard::Leaderboard, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<Auction>(arg1);
        assert!(0x2::clock::timestamp_ms(arg5) >= arg1.end_time, 5);
        let v1 = arg1.highest_bid;
        let v2 = arg1.highest_bidder;
        if (arg1.has_nft) {
            if (arg1.highest_bid > 0) {
                0x2::transfer::public_transfer<T0>(0x2::dynamic_object_field::remove<vector<u8>, T0>(&mut arg1.id, b"nft"), arg1.highest_bidder);
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg1.highest_bidder_deposit), arg6), arg1.creator);
                0x9f92672b2d6075d745ab6e4b8ad0de9b46850b735d43e531f3f729a7b8e9c0b4::user_stats::record_auction_won(arg3, arg1.highest_bidder, v0, v1, arg6);
                0x9f92672b2d6075d745ab6e4b8ad0de9b46850b735d43e531f3f729a7b8e9c0b4::leaderboard::update_leaderboard(arg4, arg3, arg1.highest_bidder, arg6);
            } else {
                0x2::transfer::public_transfer<T0>(0x2::dynamic_object_field::remove<vector<u8>, T0>(&mut arg1.id, b"nft"), arg1.creator);
            };
            arg1.has_nft = false;
        };
        let v3 = 0;
        while (v3 < 0x1::vector::length<address>(&arg1.participants)) {
            let v4 = *0x1::vector::borrow<address>(&arg1.participants, v3);
            if (v4 != v2) {
                0x9f92672b2d6075d745ab6e4b8ad0de9b46850b735d43e531f3f729a7b8e9c0b4::user_stats::remove_active_bid(arg3, v4, v0);
            };
            v3 = v3 + 1;
        };
        arg1.active = false;
        0x9f92672b2d6075d745ab6e4b8ad0de9b46850b735d43e531f3f729a7b8e9c0b4::dashboard::remove_auction(arg2, v0, v1, v2, arg6);
    }

    public fun create<T0: store + key>(arg0: &mut 0x9f92672b2d6075d745ab6e4b8ad0de9b46850b735d43e531f3f729a7b8e9c0b4::dashboard::Dashboard, arg1: &mut 0x9f92672b2d6075d745ab6e4b8ad0de9b46850b735d43e531f3f729a7b8e9c0b4::user_stats::UserStatsRegistry, arg2: T0, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = Auction{
            id                     : 0x2::object::new(arg5),
            creator                : v0,
            minimum_bid            : arg3,
            highest_bid            : 0,
            highest_bidder         : v0,
            highest_bidder_deposit : 0x2::balance::zero<0x2::sui::SUI>(),
            participants           : 0x1::vector::empty<address>(),
            active                 : true,
            has_nft                : true,
            nft_type               : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            end_time               : arg4,
        };
        0x2::dynamic_object_field::add<vector<u8>, T0>(&mut v1.id, b"nft", arg2);
        let v2 = 0x2::object::id<Auction>(&v1);
        0x9f92672b2d6075d745ab6e4b8ad0de9b46850b735d43e531f3f729a7b8e9c0b4::dashboard::add_auction(arg0, v2, arg5);
        0x9f92672b2d6075d745ab6e4b8ad0de9b46850b735d43e531f3f729a7b8e9c0b4::user_stats::record_auction_created(arg1, v0, v2, arg5);
        0x2::transfer::share_object<Auction>(v1);
        v2
    }

    public fun creator(arg0: &Auction) : address {
        arg0.creator
    }

    public fun end_time(arg0: &Auction) : u64 {
        arg0.end_time
    }

    public fun get_id(arg0: &Auction) : 0x2::object::ID {
        0x2::object::id<Auction>(arg0)
    }

    public fun get_participants(arg0: &Auction) : &vector<address> {
        &arg0.participants
    }

    public fun has_ended(arg0: &Auction, arg1: &0x2::clock::Clock) : bool {
        0x2::clock::timestamp_ms(arg1) >= arg0.end_time
    }

    public fun highest_bid(arg0: &Auction) : u64 {
        arg0.highest_bid
    }

    public fun highest_bidder(arg0: &Auction) : address {
        arg0.highest_bidder
    }

    public fun info(arg0: &Auction) : (address, u64, u64, address, bool, u64, 0x1::ascii::String) {
        (arg0.creator, arg0.minimum_bid, arg0.highest_bid, arg0.highest_bidder, arg0.active, arg0.end_time, arg0.nft_type)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun is_participant(arg0: &Auction, arg1: address) : bool {
        0x1::vector::contains<address>(&arg0.participants, &arg1)
    }

    public fun nft_type(arg0: &Auction) : 0x1::ascii::String {
        arg0.nft_type
    }

    public fun transfer_admin_cap(arg0: AdminCap, arg1: address) {
        0x2::transfer::transfer<AdminCap>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

