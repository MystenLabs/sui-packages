module 0x4492bf3f0cec29230243b4516567bff28295d50e187a0034ea7da8bb76e34ff0::dashboard {
    struct DASHBOARD has drop {
        dummy_field: bool,
    }

    struct Dashboard has key {
        id: 0x2::object::UID,
        active_auctions: vector<0x2::object::ID>,
        closed_auctions: vector<0x2::object::ID>,
        total_auctions_created: u64,
        total_sui_processed: u64,
    }

    struct AuctionAdded has copy, drop {
        auction_id: 0x2::object::ID,
        creator: address,
        timestamp: u64,
    }

    struct AuctionRemoved has copy, drop {
        auction_id: 0x2::object::ID,
        timestamp: u64,
    }

    struct AuctionClosed has copy, drop {
        auction_id: 0x2::object::ID,
        final_bid: u64,
        winner: address,
        timestamp: u64,
    }

    public fun active_auction_count(arg0: &Dashboard) : u64 {
        0x1::vector::length<0x2::object::ID>(&arg0.active_auctions)
    }

    public fun add_auction(arg0: &mut Dashboard, arg1: 0x2::object::ID, arg2: &0x2::tx_context::TxContext) {
        assert!(!0x1::vector::contains<0x2::object::ID>(&arg0.active_auctions, &arg1), 0);
        0x1::vector::push_back<0x2::object::ID>(&mut arg0.active_auctions, arg1);
        arg0.total_auctions_created = arg0.total_auctions_created + 1;
        let v0 = AuctionAdded{
            auction_id : arg1,
            creator    : 0x2::tx_context::sender(arg2),
            timestamp  : 0x2::tx_context::epoch(arg2),
        };
        0x2::event::emit<AuctionAdded>(v0);
    }

    public fun closed_auction_count(arg0: &Dashboard) : u64 {
        0x1::vector::length<0x2::object::ID>(&arg0.closed_auctions)
    }

    public fun get_active_auctions(arg0: &Dashboard) : &vector<0x2::object::ID> {
        &arg0.active_auctions
    }

    public fun get_closed_auctions(arg0: &Dashboard) : &vector<0x2::object::ID> {
        &arg0.closed_auctions
    }

    public fun get_stats(arg0: &Dashboard) : (u64, u64, u64, u64) {
        (arg0.total_auctions_created, 0x1::vector::length<0x2::object::ID>(&arg0.active_auctions), 0x1::vector::length<0x2::object::ID>(&arg0.closed_auctions), arg0.total_sui_processed)
    }

    public fun has_auction(arg0: &Dashboard, arg1: &0x2::object::ID) : bool {
        0x1::vector::contains<0x2::object::ID>(&arg0.active_auctions, arg1)
    }

    fun init(arg0: DASHBOARD, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<DASHBOARD>(arg0, arg1);
        let v0 = Dashboard{
            id                     : 0x2::object::new(arg1),
            active_auctions        : 0x1::vector::empty<0x2::object::ID>(),
            closed_auctions        : 0x1::vector::empty<0x2::object::ID>(),
            total_auctions_created : 0,
            total_sui_processed    : 0,
        };
        0x2::transfer::share_object<Dashboard>(v0);
    }

    public fun is_closed_auction(arg0: &Dashboard, arg1: &0x2::object::ID) : bool {
        0x1::vector::contains<0x2::object::ID>(&arg0.closed_auctions, arg1)
    }

    public fun remove_auction(arg0: &mut Dashboard, arg1: 0x2::object::ID, arg2: u64, arg3: address, arg4: &0x2::tx_context::TxContext) {
        let (v0, v1) = 0x1::vector::index_of<0x2::object::ID>(&arg0.active_auctions, &arg1);
        assert!(v0, 1);
        0x1::vector::remove<0x2::object::ID>(&mut arg0.active_auctions, v1);
        0x1::vector::push_back<0x2::object::ID>(&mut arg0.closed_auctions, arg1);
        if (arg2 > 0) {
            arg0.total_sui_processed = arg0.total_sui_processed + arg2;
        };
        let v2 = AuctionClosed{
            auction_id : arg1,
            final_bid  : arg2,
            winner     : arg3,
            timestamp  : 0x2::tx_context::epoch(arg4),
        };
        0x2::event::emit<AuctionClosed>(v2);
        let v3 = AuctionRemoved{
            auction_id : arg1,
            timestamp  : 0x2::tx_context::epoch(arg4),
        };
        0x2::event::emit<AuctionRemoved>(v3);
    }

    public fun total_auctions_created(arg0: &Dashboard) : u64 {
        arg0.total_auctions_created
    }

    public fun total_sui_processed(arg0: &Dashboard) : u64 {
        arg0.total_sui_processed
    }

    // decompiled from Move bytecode v6
}

