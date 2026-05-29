module 0x7c529ea0a4d0c4fab1441b283aa9f61212da172b653f931a8ab273a241f56937::auction {
    struct AuctionCreated has copy, drop {
        auction_id: 0x2::object::ID,
        creator: address,
        title: 0x1::string::String,
        prize_amount: u64,
        commit_end_ms: u64,
        reveal_end_ms: u64,
    }

    struct BidCommitted has copy, drop {
        auction_id: 0x2::object::ID,
        bidder: address,
        commitment_id: 0x2::object::ID,
        blob_id: 0x1::string::String,
    }

    struct BidRevealed has copy, drop {
        auction_id: 0x2::object::ID,
        bidder: address,
        amount: u64,
    }

    struct AuctionSettled has copy, drop {
        auction_id: 0x2::object::ID,
        winner: 0x1::option::Option<address>,
        winning_bid: u64,
        prize_amount: u64,
    }

    struct Auction has key {
        id: 0x2::object::UID,
        creator: address,
        title: 0x1::string::String,
        description: 0x1::string::String,
        prize: 0x2::balance::Balance<0x2::sui::SUI>,
        commit_end_ms: u64,
        reveal_end_ms: u64,
        settled: bool,
        winner: 0x1::option::Option<address>,
        winning_bid: u64,
        highest_bid_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        total_commitments: u64,
        total_reveals: u64,
    }

    struct Commitment has store, key {
        id: 0x2::object::UID,
        auction_id: 0x2::object::ID,
        bidder: address,
        hash: vector<u8>,
        blob_id: 0x1::string::String,
        revealed: bool,
        revealed_amount: u64,
    }

    struct AuctionAdminCap has store, key {
        id: 0x2::object::UID,
        auction_id: 0x2::object::ID,
    }

    public entry fun commit_bid(arg0: &mut Auction, arg1: vector<u8>, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg3) < arg0.commit_end_ms, 0);
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = Commitment{
            id              : 0x2::object::new(arg4),
            auction_id      : 0x2::object::id<Auction>(arg0),
            bidder          : v0,
            hash            : arg1,
            blob_id         : 0x1::string::utf8(arg2),
            revealed        : false,
            revealed_amount : 0,
        };
        arg0.total_commitments = arg0.total_commitments + 1;
        let v2 = BidCommitted{
            auction_id    : 0x2::object::id<Auction>(arg0),
            bidder        : v0,
            commitment_id : 0x2::object::id<Commitment>(&v1),
            blob_id       : v1.blob_id,
        };
        0x2::event::emit<BidCommitted>(v2);
        0x2::transfer::transfer<Commitment>(v1, v0);
    }

    public entry fun create_auction(arg0: vector<u8>, arg1: vector<u8>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        assert!(v0 > 0, 7);
        let v1 = 0x2::clock::timestamp_ms(arg5) + arg3;
        let v2 = v1 + arg4;
        let v3 = 0x2::tx_context::sender(arg6);
        let v4 = Auction{
            id                  : 0x2::object::new(arg6),
            creator             : v3,
            title               : 0x1::string::utf8(arg0),
            description         : 0x1::string::utf8(arg1),
            prize               : 0x2::coin::into_balance<0x2::sui::SUI>(arg2),
            commit_end_ms       : v1,
            reveal_end_ms       : v2,
            settled             : false,
            winner              : 0x1::option::none<address>(),
            winning_bid         : 0,
            highest_bid_balance : 0x2::balance::zero<0x2::sui::SUI>(),
            total_commitments   : 0,
            total_reveals       : 0,
        };
        let v5 = AuctionAdminCap{
            id         : 0x2::object::new(arg6),
            auction_id : 0x2::object::id<Auction>(&v4),
        };
        let v6 = AuctionCreated{
            auction_id    : 0x2::object::id<Auction>(&v4),
            creator       : v3,
            title         : v4.title,
            prize_amount  : v0,
            commit_end_ms : v1,
            reveal_end_ms : v2,
        };
        0x2::event::emit<AuctionCreated>(v6);
        0x2::transfer::share_object<Auction>(v4);
        0x2::transfer::transfer<AuctionAdminCap>(v5, v3);
    }

    public fun get_phase(arg0: &Auction, arg1: &0x2::clock::Clock) : u8 {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        if (v0 < arg0.commit_end_ms) {
            0
        } else if (v0 < arg0.reveal_end_ms) {
            1
        } else {
            2
        }
    }

    public fun is_settled(arg0: &Auction) : bool {
        arg0.settled
    }

    public fun prize_amount(arg0: &Auction) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.prize)
    }

    public entry fun reclaim_prize(arg0: &mut Auction, arg1: &AuctionAdminCap, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.auction_id == 0x2::object::id<Auction>(arg0), 6);
        assert!(0x2::clock::timestamp_ms(arg2) >= arg0.reveal_end_ms, 4);
        assert!(!arg0.settled, 5);
        assert!(0x1::option::is_none<address>(&arg0.winner), 5);
        arg0.settled = true;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.prize), arg3), arg0.creator);
    }

    public entry fun reveal_bid(arg0: &mut Auction, arg1: &mut Commitment, arg2: u64, arg3: vector<u8>, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg5);
        assert!(v0 >= arg0.commit_end_ms, 1);
        assert!(v0 < arg0.reveal_end_ms, 8);
        assert!(!arg1.revealed, 2);
        assert!(arg1.auction_id == 0x2::object::id<Auction>(arg0), 9);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg4) == arg2, 10);
        let v1 = 0x2::bcs::to_bytes<u64>(&arg2);
        0x1::vector::append<u8>(&mut v1, arg3);
        assert!(0x2::hash::keccak256(&v1) == arg1.hash, 3);
        arg1.revealed = true;
        arg1.revealed_amount = arg2;
        arg0.total_reveals = arg0.total_reveals + 1;
        if (arg2 > arg0.winning_bid) {
            if (0x1::option::is_some<address>(&arg0.winner)) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.highest_bid_balance), arg6), *0x1::option::borrow<address>(&arg0.winner));
            };
            0x2::balance::join<0x2::sui::SUI>(&mut arg0.highest_bid_balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg4));
            arg0.winning_bid = arg2;
            arg0.winner = 0x1::option::some<address>(arg1.bidder);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg4, arg1.bidder);
        };
        let v2 = BidRevealed{
            auction_id : 0x2::object::id<Auction>(arg0),
            bidder     : arg1.bidder,
            amount     : arg2,
        };
        0x2::event::emit<BidRevealed>(v2);
    }

    public entry fun settle(arg0: &mut Auction, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.reveal_end_ms, 4);
        assert!(!arg0.settled, 5);
        arg0.settled = true;
        let v0 = 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.prize), arg2);
        let v1 = arg0.winner;
        if (0x1::option::is_some<address>(&v1)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v0, *0x1::option::borrow<address>(&v1));
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.highest_bid_balance), arg2), arg0.creator);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v0, arg0.creator);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.highest_bid_balance), arg2), arg0.creator);
        };
        let v2 = AuctionSettled{
            auction_id   : 0x2::object::id<Auction>(arg0),
            winner       : v1,
            winning_bid  : arg0.winning_bid,
            prize_amount : 0x2::coin::value<0x2::sui::SUI>(&v0),
        };
        0x2::event::emit<AuctionSettled>(v2);
    }

    public fun winner(arg0: &Auction) : 0x1::option::Option<address> {
        arg0.winner
    }

    public fun winning_bid(arg0: &Auction) : u64 {
        arg0.winning_bid
    }

    // decompiled from Move bytecode v7
}

