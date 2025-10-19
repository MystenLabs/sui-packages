module 0xd9b54599ea82608de2f6db3e21dee6630c2c6ce320b9847241db97bfb0834aa3::user_stats {
    struct UserStats has store {
        total_bids_placed: u64,
        total_auctions_won: u64,
        total_outbid_count: u64,
        total_auctions_created: u64,
        total_volume_bid: u64,
        total_volume_won: u64,
        active_bids: vector<0x2::object::ID>,
        won_auctions: vector<0x2::object::ID>,
        created_auctions: vector<0x2::object::ID>,
    }

    struct UserStatsRegistry has key {
        id: 0x2::object::UID,
        users: 0x2::table::Table<address, UserStats>,
    }

    struct BidPlaced has copy, drop {
        user: address,
        auction_id: 0x2::object::ID,
        bid_amount: u64,
        timestamp: u64,
    }

    struct UserOutbid has copy, drop {
        user: address,
        auction_id: 0x2::object::ID,
        previous_bid: u64,
        new_bid: u64,
        timestamp: u64,
    }

    struct AuctionWon has copy, drop {
        user: address,
        auction_id: 0x2::object::ID,
        winning_bid: u64,
        timestamp: u64,
    }

    struct AuctionCreatedByUser has copy, drop {
        user: address,
        auction_id: 0x2::object::ID,
        timestamp: u64,
    }

    public fun get_active_bids(arg0: &UserStatsRegistry, arg1: address) : vector<0x2::object::ID> {
        if (!0x2::table::contains<address, UserStats>(&arg0.users, arg1)) {
            return 0x1::vector::empty<0x2::object::ID>()
        };
        0x2::table::borrow<address, UserStats>(&arg0.users, arg1).active_bids
    }

    public fun get_created_auctions(arg0: &UserStatsRegistry, arg1: address) : vector<0x2::object::ID> {
        if (!0x2::table::contains<address, UserStats>(&arg0.users, arg1)) {
            return 0x1::vector::empty<0x2::object::ID>()
        };
        0x2::table::borrow<address, UserStats>(&arg0.users, arg1).created_auctions
    }

    fun get_or_create_user_stats(arg0: &mut UserStatsRegistry, arg1: address) : &mut UserStats {
        if (!0x2::table::contains<address, UserStats>(&arg0.users, arg1)) {
            let v0 = UserStats{
                total_bids_placed      : 0,
                total_auctions_won     : 0,
                total_outbid_count     : 0,
                total_auctions_created : 0,
                total_volume_bid       : 0,
                total_volume_won       : 0,
                active_bids            : 0x1::vector::empty<0x2::object::ID>(),
                won_auctions           : 0x1::vector::empty<0x2::object::ID>(),
                created_auctions       : 0x1::vector::empty<0x2::object::ID>(),
            };
            0x2::table::add<address, UserStats>(&mut arg0.users, arg1, v0);
        };
        0x2::table::borrow_mut<address, UserStats>(&mut arg0.users, arg1)
    }

    public fun get_total_auctions_created(arg0: &UserStatsRegistry, arg1: address) : u64 {
        if (!0x2::table::contains<address, UserStats>(&arg0.users, arg1)) {
            return 0
        };
        0x2::table::borrow<address, UserStats>(&arg0.users, arg1).total_auctions_created
    }

    public fun get_total_auctions_won(arg0: &UserStatsRegistry, arg1: address) : u64 {
        if (!0x2::table::contains<address, UserStats>(&arg0.users, arg1)) {
            return 0
        };
        0x2::table::borrow<address, UserStats>(&arg0.users, arg1).total_auctions_won
    }

    public fun get_total_bids_placed(arg0: &UserStatsRegistry, arg1: address) : u64 {
        if (!0x2::table::contains<address, UserStats>(&arg0.users, arg1)) {
            return 0
        };
        0x2::table::borrow<address, UserStats>(&arg0.users, arg1).total_bids_placed
    }

    public fun get_total_outbid_count(arg0: &UserStatsRegistry, arg1: address) : u64 {
        if (!0x2::table::contains<address, UserStats>(&arg0.users, arg1)) {
            return 0
        };
        0x2::table::borrow<address, UserStats>(&arg0.users, arg1).total_outbid_count
    }

    public fun get_total_volume_bid(arg0: &UserStatsRegistry, arg1: address) : u64 {
        if (!0x2::table::contains<address, UserStats>(&arg0.users, arg1)) {
            return 0
        };
        0x2::table::borrow<address, UserStats>(&arg0.users, arg1).total_volume_bid
    }

    public fun get_total_volume_won(arg0: &UserStatsRegistry, arg1: address) : u64 {
        if (!0x2::table::contains<address, UserStats>(&arg0.users, arg1)) {
            return 0
        };
        0x2::table::borrow<address, UserStats>(&arg0.users, arg1).total_volume_won
    }

    public fun get_user_stats(arg0: &UserStatsRegistry, arg1: address) : (u64, u64, u64, u64, u64, u64) {
        if (!0x2::table::contains<address, UserStats>(&arg0.users, arg1)) {
            return (0, 0, 0, 0, 0, 0)
        };
        let v0 = 0x2::table::borrow<address, UserStats>(&arg0.users, arg1);
        (v0.total_bids_placed, v0.total_auctions_won, v0.total_outbid_count, v0.total_auctions_created, v0.total_volume_bid, v0.total_volume_won)
    }

    public fun get_won_auctions(arg0: &UserStatsRegistry, arg1: address) : vector<0x2::object::ID> {
        if (!0x2::table::contains<address, UserStats>(&arg0.users, arg1)) {
            return 0x1::vector::empty<0x2::object::ID>()
        };
        0x2::table::borrow<address, UserStats>(&arg0.users, arg1).won_auctions
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = UserStatsRegistry{
            id    : 0x2::object::new(arg0),
            users : 0x2::table::new<address, UserStats>(arg0),
        };
        0x2::transfer::share_object<UserStatsRegistry>(v0);
    }

    public(friend) fun record_auction_created(arg0: &mut UserStatsRegistry, arg1: address, arg2: 0x2::object::ID, arg3: &0x2::tx_context::TxContext) {
        let v0 = get_or_create_user_stats(arg0, arg1);
        v0.total_auctions_created = v0.total_auctions_created + 1;
        0x1::vector::push_back<0x2::object::ID>(&mut v0.created_auctions, arg2);
        let v1 = AuctionCreatedByUser{
            user       : arg1,
            auction_id : arg2,
            timestamp  : 0x2::tx_context::epoch(arg3),
        };
        0x2::event::emit<AuctionCreatedByUser>(v1);
    }

    public(friend) fun record_auction_won(arg0: &mut UserStatsRegistry, arg1: address, arg2: 0x2::object::ID, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        let v0 = get_or_create_user_stats(arg0, arg1);
        v0.total_auctions_won = v0.total_auctions_won + 1;
        v0.total_volume_won = v0.total_volume_won + arg3;
        0x1::vector::push_back<0x2::object::ID>(&mut v0.won_auctions, arg2);
        let (v1, v2) = 0x1::vector::index_of<0x2::object::ID>(&v0.active_bids, &arg2);
        if (v1) {
            0x1::vector::remove<0x2::object::ID>(&mut v0.active_bids, v2);
        };
        let v3 = AuctionWon{
            user        : arg1,
            auction_id  : arg2,
            winning_bid : arg3,
            timestamp   : 0x2::tx_context::epoch(arg4),
        };
        0x2::event::emit<AuctionWon>(v3);
    }

    public(friend) fun record_bid(arg0: &mut UserStatsRegistry, arg1: address, arg2: 0x2::object::ID, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        let v0 = get_or_create_user_stats(arg0, arg1);
        v0.total_bids_placed = v0.total_bids_placed + 1;
        v0.total_volume_bid = v0.total_volume_bid + arg3;
        if (!0x1::vector::contains<0x2::object::ID>(&v0.active_bids, &arg2)) {
            0x1::vector::push_back<0x2::object::ID>(&mut v0.active_bids, arg2);
        };
        let v1 = BidPlaced{
            user       : arg1,
            auction_id : arg2,
            bid_amount : arg3,
            timestamp  : 0x2::tx_context::epoch(arg4),
        };
        0x2::event::emit<BidPlaced>(v1);
    }

    public(friend) fun record_outbid(arg0: &mut UserStatsRegistry, arg1: address, arg2: 0x2::object::ID, arg3: u64, arg4: u64, arg5: &0x2::tx_context::TxContext) {
        let v0 = get_or_create_user_stats(arg0, arg1);
        v0.total_outbid_count = v0.total_outbid_count + 1;
        let (v1, v2) = 0x1::vector::index_of<0x2::object::ID>(&v0.active_bids, &arg2);
        if (v1) {
            0x1::vector::remove<0x2::object::ID>(&mut v0.active_bids, v2);
        };
        let v3 = UserOutbid{
            user         : arg1,
            auction_id   : arg2,
            previous_bid : arg3,
            new_bid      : arg4,
            timestamp    : 0x2::tx_context::epoch(arg5),
        };
        0x2::event::emit<UserOutbid>(v3);
    }

    public(friend) fun remove_active_bid(arg0: &mut UserStatsRegistry, arg1: address, arg2: 0x2::object::ID) {
        if (0x2::table::contains<address, UserStats>(&arg0.users, arg1)) {
            let v0 = 0x2::table::borrow_mut<address, UserStats>(&mut arg0.users, arg1);
            let (v1, v2) = 0x1::vector::index_of<0x2::object::ID>(&v0.active_bids, &arg2);
            if (v1) {
                0x1::vector::remove<0x2::object::ID>(&mut v0.active_bids, v2);
            };
        };
    }

    public fun user_exists(arg0: &UserStatsRegistry, arg1: address) : bool {
        0x2::table::contains<address, UserStats>(&arg0.users, arg1)
    }

    // decompiled from Move bytecode v6
}

