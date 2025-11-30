module 0x271f7facd86c4d18a5f52ca16b0b6b9654006191bbab2e14bc1a784ea35069b7::utils {
    struct Auction has store, key {
        id: 0x2::object::UID,
        nft_id: 0x2::object::ID,
        collection_id: 0x2::object::ID,
        seller: address,
        starting_price: u64,
        reserve_price: u64,
        current_bid: u64,
        current_bidder: address,
        bid_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        start_time: u64,
        end_time: u64,
        min_bid_increment_bps: u64,
        is_finalized: bool,
        created_at: u64,
    }

    struct DutchAuction has store, key {
        id: 0x2::object::UID,
        nft_id: 0x2::object::ID,
        collection_id: 0x2::object::ID,
        seller: address,
        starting_price: u64,
        ending_price: u64,
        start_time: u64,
        end_time: u64,
        is_sold: bool,
        created_at: u64,
    }

    struct Offer has store, key {
        id: 0x2::object::UID,
        nft_id: 0x2::object::ID,
        offerer: address,
        amount: u64,
        funds: 0x2::balance::Balance<0x2::sui::SUI>,
        expires_at: u64,
        created_at: u64,
    }

    struct CollectionOffer has store, key {
        id: 0x2::object::UID,
        collection_id: 0x2::object::ID,
        offerer: address,
        amount: u64,
        quantity: u64,
        remaining: u64,
        funds: 0x2::balance::Balance<0x2::sui::SUI>,
        expires_at: u64,
        created_at: u64,
    }

    struct AuctionCreated has copy, drop {
        auction_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        seller: address,
        starting_price: u64,
        reserve_price: u64,
        end_time: u64,
    }

    struct BidPlaced has copy, drop {
        auction_id: 0x2::object::ID,
        bidder: address,
        amount: u64,
        previous_bidder: address,
        previous_amount: u64,
    }

    struct AuctionFinalized has copy, drop {
        auction_id: 0x2::object::ID,
        winner: address,
        winning_bid: u64,
        reserve_met: bool,
    }

    struct AuctionCancelled has copy, drop {
        auction_id: 0x2::object::ID,
        seller: address,
    }

    struct DutchAuctionCreated has copy, drop {
        auction_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        seller: address,
        starting_price: u64,
        ending_price: u64,
        end_time: u64,
    }

    struct DutchAuctionPurchased has copy, drop {
        auction_id: 0x2::object::ID,
        buyer: address,
        price: u64,
    }

    struct OfferCreated has copy, drop {
        offer_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        offerer: address,
        amount: u64,
        expires_at: u64,
    }

    struct OfferAccepted has copy, drop {
        offer_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        seller: address,
        buyer: address,
        amount: u64,
    }

    struct OfferCancelled has copy, drop {
        offer_id: 0x2::object::ID,
        offerer: address,
    }

    struct CollectionOfferCreated has copy, drop {
        offer_id: 0x2::object::ID,
        collection_id: 0x2::object::ID,
        offerer: address,
        amount: u64,
        quantity: u64,
    }

    public fun accept_collection_offer(arg0: &mut CollectionOffer, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : (address, u64) {
        assert!(0x2::clock::timestamp_ms(arg1) < arg0.expires_at, 6);
        assert!(arg0.remaining > 0, 7);
        arg0.remaining = arg0.remaining - 1;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.funds, arg0.amount), arg2), 0x2::tx_context::sender(arg2));
        (arg0.offerer, arg0.amount)
    }

    public fun accept_offer(arg0: Offer, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : (address, u64) {
        assert!(0x2::clock::timestamp_ms(arg1) < arg0.expires_at, 6);
        let Offer {
            id         : v0,
            nft_id     : v1,
            offerer    : v2,
            amount     : v3,
            funds      : v4,
            expires_at : _,
            created_at : _,
        } = arg0;
        let v7 = v0;
        let v8 = 0x2::tx_context::sender(arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v4, arg2), v8);
        let v9 = OfferAccepted{
            offer_id : 0x2::object::uid_to_inner(&v7),
            nft_id   : v1,
            seller   : v8,
            buyer    : v2,
            amount   : v3,
        };
        0x2::event::emit<OfferAccepted>(v9);
        0x2::object::delete(v7);
        (v2, v3)
    }

    public fun buy_dutch_auction(arg0: &mut DutchAuction, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(v0 >= arg0.start_time, 0);
        assert!(v0 <= arg0.end_time, 1);
        assert!(!arg0.is_sold, 1);
        let v1 = get_dutch_price(arg0, arg2);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= v1, 9);
        arg0.is_sold = true;
        let v2 = 0x2::tx_context::sender(arg3);
        let v3 = 0x2::coin::into_balance<0x2::sui::SUI>(arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v3, v1), arg3), arg0.seller);
        if (0x2::balance::value<0x2::sui::SUI>(&v3) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v3, arg3), v2);
        } else {
            0x2::balance::destroy_zero<0x2::sui::SUI>(v3);
        };
        let v4 = DutchAuctionPurchased{
            auction_id : 0x2::object::id<DutchAuction>(arg0),
            buyer      : v2,
            price      : v1,
        };
        0x2::event::emit<DutchAuctionPurchased>(v4);
        v1
    }

    public fun cancel_auction(arg0: &mut Auction, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.seller, 4);
        assert!(arg0.current_bid == 0, 5);
        assert!(!arg0.is_finalized, 1);
        arg0.is_finalized = true;
        let v0 = AuctionCancelled{
            auction_id : 0x2::object::id<Auction>(arg0),
            seller     : arg0.seller,
        };
        0x2::event::emit<AuctionCancelled>(v0);
    }

    public fun cancel_offer(arg0: Offer, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.offerer, 8);
        let Offer {
            id         : v0,
            nft_id     : _,
            offerer    : v2,
            amount     : _,
            funds      : v4,
            expires_at : _,
            created_at : _,
        } = arg0;
        let v7 = v0;
        let v8 = OfferCancelled{
            offer_id : 0x2::object::uid_to_inner(&v7),
            offerer  : v2,
        };
        0x2::event::emit<OfferCancelled>(v8);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v4, arg1), v2);
        0x2::object::delete(v7);
    }

    public fun create_auction(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : Auction {
        assert!(arg4 >= 3600000, 10);
        assert!(arg4 <= 2592000000, 10);
        assert!(arg3 >= arg2, 11);
        let v0 = 0x2::clock::timestamp_ms(arg5);
        let v1 = 0x2::tx_context::sender(arg6);
        let v2 = Auction{
            id                    : 0x2::object::new(arg6),
            nft_id                : arg0,
            collection_id         : arg1,
            seller                : v1,
            starting_price        : arg2,
            reserve_price         : arg3,
            current_bid           : 0,
            current_bidder        : @0x0,
            bid_balance           : 0x2::balance::zero<0x2::sui::SUI>(),
            start_time            : v0,
            end_time              : v0 + arg4,
            min_bid_increment_bps : 500,
            is_finalized          : false,
            created_at            : v0,
        };
        let v3 = AuctionCreated{
            auction_id     : 0x2::object::id<Auction>(&v2),
            nft_id         : arg0,
            seller         : v1,
            starting_price : arg2,
            reserve_price  : arg3,
            end_time       : v0 + arg4,
        };
        0x2::event::emit<AuctionCreated>(v3);
        v2
    }

    public fun create_collection_offer(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : CollectionOffer {
        let v0 = 0x2::clock::timestamp_ms(arg5);
        let v1 = 0x2::tx_context::sender(arg6);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) >= arg1 * arg2, 9);
        let v2 = CollectionOffer{
            id            : 0x2::object::new(arg6),
            collection_id : arg0,
            offerer       : v1,
            amount        : arg1,
            quantity      : arg2,
            remaining     : arg2,
            funds         : 0x2::coin::into_balance<0x2::sui::SUI>(arg3),
            expires_at    : v0 + arg4,
            created_at    : v0,
        };
        let v3 = CollectionOfferCreated{
            offer_id      : 0x2::object::id<CollectionOffer>(&v2),
            collection_id : arg0,
            offerer       : v1,
            amount        : arg1,
            quantity      : arg2,
        };
        0x2::event::emit<CollectionOfferCreated>(v3);
        v2
    }

    public fun create_dutch_auction(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : DutchAuction {
        assert!(arg4 >= 3600000, 10);
        assert!(arg4 <= 2592000000, 10);
        assert!(arg2 > arg3, 11);
        let v0 = 0x2::clock::timestamp_ms(arg5);
        let v1 = 0x2::tx_context::sender(arg6);
        let v2 = DutchAuction{
            id             : 0x2::object::new(arg6),
            nft_id         : arg0,
            collection_id  : arg1,
            seller         : v1,
            starting_price : arg2,
            ending_price   : arg3,
            start_time     : v0,
            end_time       : v0 + arg4,
            is_sold        : false,
            created_at     : v0,
        };
        let v3 = DutchAuctionCreated{
            auction_id     : 0x2::object::id<DutchAuction>(&v2),
            nft_id         : arg0,
            seller         : v1,
            starting_price : arg2,
            ending_price   : arg3,
            end_time       : v0 + arg4,
        };
        0x2::event::emit<DutchAuctionCreated>(v3);
        v2
    }

    public fun create_offer(arg0: 0x2::object::ID, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : Offer {
        let v0 = 0x2::clock::timestamp_ms(arg3);
        let v1 = 0x2::tx_context::sender(arg4);
        let v2 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        let v3 = Offer{
            id         : 0x2::object::new(arg4),
            nft_id     : arg0,
            offerer    : v1,
            amount     : v2,
            funds      : 0x2::coin::into_balance<0x2::sui::SUI>(arg1),
            expires_at : v0 + arg2,
            created_at : v0,
        };
        let v4 = OfferCreated{
            offer_id   : 0x2::object::id<Offer>(&v3),
            nft_id     : arg0,
            offerer    : v1,
            amount     : v2,
            expires_at : v0 + arg2,
        };
        0x2::event::emit<OfferCreated>(v4);
        v3
    }

    public fun finalize_auction(arg0: &mut Auction, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : (bool, address, u64) {
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.end_time, 3);
        assert!(!arg0.is_finalized, 1);
        arg0.is_finalized = true;
        let v0 = arg0.current_bid >= arg0.reserve_price;
        let v1 = arg0.current_bidder;
        let v2 = arg0.current_bid;
        let v3 = AuctionFinalized{
            auction_id  : 0x2::object::id<Auction>(arg0),
            winner      : v1,
            winning_bid : v2,
            reserve_met : v0,
        };
        0x2::event::emit<AuctionFinalized>(v3);
        let v4 = if (!v0) {
            if (v2 > 0) {
                v1 != @0x0
            } else {
                false
            }
        } else {
            false
        };
        if (v4) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.bid_balance), arg2), v1);
            (false, @0x0, 0)
        } else if (v0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.bid_balance), arg2), arg0.seller);
            (true, v1, v2)
        } else {
            (false, @0x0, 0)
        }
    }

    public fun get_auction_info(arg0: &Auction) : (0x2::object::ID, address, u64, u64, u64, address, u64, bool) {
        (arg0.nft_id, arg0.seller, arg0.starting_price, arg0.reserve_price, arg0.current_bid, arg0.current_bidder, arg0.end_time, arg0.is_finalized)
    }

    public fun get_dutch_auction_info(arg0: &DutchAuction) : (0x2::object::ID, address, u64, u64, u64, bool) {
        (arg0.nft_id, arg0.seller, arg0.starting_price, arg0.ending_price, arg0.end_time, arg0.is_sold)
    }

    public fun get_dutch_price(arg0: &DutchAuction, arg1: &0x2::clock::Clock) : u64 {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        if (v0 <= arg0.start_time) {
            return arg0.starting_price
        };
        if (v0 >= arg0.end_time) {
            return arg0.ending_price
        };
        arg0.starting_price - ((((arg0.starting_price - arg0.ending_price) as u128) * ((v0 - arg0.start_time) as u128) / ((arg0.end_time - arg0.start_time) as u128)) as u64)
    }

    public fun get_offer_info(arg0: &Offer) : (0x2::object::ID, address, u64, u64) {
        (arg0.nft_id, arg0.offerer, arg0.amount, arg0.expires_at)
    }

    public fun is_auction_active(arg0: &Auction, arg1: &0x2::clock::Clock) : bool {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        if (v0 >= arg0.start_time) {
            if (v0 < arg0.end_time) {
                !arg0.is_finalized
            } else {
                false
            }
        } else {
            false
        }
    }

    public fun is_offer_valid(arg0: &Offer, arg1: &0x2::clock::Clock) : bool {
        0x2::clock::timestamp_ms(arg1) < arg0.expires_at
    }

    public fun place_bid(arg0: &mut Auction, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = 0x2::tx_context::sender(arg3);
        assert!(v0 >= arg0.start_time, 0);
        assert!(v0 < arg0.end_time, 1);
        assert!(!arg0.is_finalized, 1);
        assert!(v1 != arg0.seller, 12);
        let v2 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        let v3 = if (arg0.current_bid == 0) {
            arg0.starting_price
        } else {
            arg0.current_bid + (((arg0.current_bid as u128) * (arg0.min_bid_increment_bps as u128) / (10000 as u128)) as u64)
        };
        assert!(v2 >= v3, 2);
        let v4 = arg0.current_bidder;
        let v5 = arg0.current_bid;
        if (v5 > 0 && v4 != @0x0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.bid_balance), arg3), v4);
        };
        arg0.current_bid = v2;
        arg0.current_bidder = v1;
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.bid_balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        let v6 = BidPlaced{
            auction_id      : 0x2::object::id<Auction>(arg0),
            bidder          : v1,
            amount          : v2,
            previous_bidder : v4,
            previous_amount : v5,
        };
        0x2::event::emit<BidPlaced>(v6);
    }

    // decompiled from Move bytecode v6
}

