module 0x37aa54940e053da47e2086b3df91f3a0b0c8760f877b7aa55fdf3ca6820dad90::marketplace {
    struct NFT has store, key {
        id: 0x2::object::UID,
        collection_id: vector<u8>,
        token_id: vector<u8>,
    }

    struct Auction has store, key {
        id: 0x2::object::UID,
        nft_id: 0x2::object::ID,
        starting_bid: u64,
        current_bid: u64,
        highest_bidder: address,
        seller: address,
        end_time: u64,
        status: u8,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct AuctionCreated has copy, drop {
        auction_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        starting_bid: u64,
        seller: address,
        end_time: u64,
    }

    struct BidPlaced has copy, drop {
        auction_id: 0x2::object::ID,
        bidder: address,
        amount: u64,
    }

    struct AuctionEnded has copy, drop {
        auction_id: 0x2::object::ID,
        winner: address,
        final_bid: u64,
    }

    public entry fun buy_listings(arg0: &mut Auction, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 0, 1);
        assert!(0x2::clock::timestamp_ms(arg2) < arg0.end_time, 2);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v0 >= arg0.current_bid, 5);
        let v1 = 0x2::tx_context::sender(arg3);
        if (arg0.highest_bidder != @0x0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.balance, arg0.current_bid, arg3), arg0.highest_bidder);
        };
        0x2::transfer::public_transfer<NFT>(0x2::dynamic_object_field::remove<vector<u8>, NFT>(&mut arg0.id, b"NFT"), v1);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.balance, v0, arg3), arg0.seller);
        arg0.status = 1;
        let v2 = AuctionEnded{
            auction_id : 0x2::object::uid_to_inner(&arg0.id),
            winner     : v1,
            final_bid  : v0,
        };
        0x2::event::emit<AuctionEnded>(v2);
        0x2::balance::destroy_zero<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, 0));
    }

    public entry fun end_auction(arg0: &mut Auction, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 0, 1);
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.end_time, 4);
        arg0.status = 1;
        if (arg0.highest_bidder != @0x0) {
            0x2::transfer::public_transfer<NFT>(0x2::dynamic_object_field::remove<vector<u8>, NFT>(&mut arg0.id, b"NFT"), arg0.highest_bidder);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.balance, arg0.current_bid, arg2), arg0.seller);
            let v0 = AuctionEnded{
                auction_id : 0x2::object::uid_to_inner(&arg0.id),
                winner     : arg0.highest_bidder,
                final_bid  : arg0.current_bid,
            };
            0x2::event::emit<AuctionEnded>(v0);
        } else {
            0x2::transfer::public_transfer<NFT>(0x2::dynamic_object_field::remove<vector<u8>, NFT>(&mut arg0.id, b"NFT"), arg0.seller);
        };
        0x2::balance::destroy_zero<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, 0));
    }

    public entry fun list_nft(arg0: NFT, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::object::id<NFT>(&arg0);
        let v2 = Auction{
            id             : 0x2::object::new(arg4),
            nft_id         : v1,
            starting_bid   : arg1,
            current_bid    : arg1,
            highest_bidder : @0x0,
            seller         : v0,
            end_time       : 0x2::clock::timestamp_ms(arg3) + arg2,
            status         : 0,
            balance        : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::dynamic_object_field::add<vector<u8>, NFT>(&mut v2.id, b"NFT", arg0);
        let v3 = AuctionCreated{
            auction_id   : 0x2::object::uid_to_inner(&v2.id),
            nft_id       : v1,
            starting_bid : arg1,
            seller       : v0,
            end_time     : v2.end_time,
        };
        0x2::event::emit<AuctionCreated>(v3);
        0x2::transfer::share_object<Auction>(v2);
    }

    public entry fun place_bid(arg0: &mut Auction, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 0, 1);
        assert!(0x2::clock::timestamp_ms(arg2) < arg0.end_time, 2);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v0 > arg0.current_bid, 3);
        let v1 = 0x2::tx_context::sender(arg3);
        if (arg0.highest_bidder != @0x0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.balance, arg0.current_bid, arg3), arg0.highest_bidder);
        };
        arg0.current_bid = v0;
        arg0.highest_bidder = v1;
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        let v2 = BidPlaced{
            auction_id : 0x2::object::uid_to_inner(&arg0.id),
            bidder     : v1,
            amount     : v0,
        };
        0x2::event::emit<BidPlaced>(v2);
    }

    // decompiled from Move bytecode v6
}

