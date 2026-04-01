module 0xfac74e1ba49638e4ed4c0a8826277e16775aa61f368329e289ec6bb4bbb0f141::auction_house {
    struct Auction has store, key {
        id: 0x2::object::UID,
        seller: address,
        kiosk_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        collection_id: 0x2::object::ID,
        starting_price: u64,
        reserve_price: u64,
        current_bid: u64,
        current_bidder: address,
        bid_count: u64,
        start_time: u64,
        end_time: u64,
        original_end_time: u64,
        extension_count: u64,
        ended: bool,
    }

    struct BidReceipt has store, key {
        id: 0x2::object::UID,
        auction_id: 0x2::object::ID,
        bidder: address,
        amount: 0x2::coin::Coin<0x2::sui::SUI>,
    }

    struct AuctionHouse has store {
        auctions: 0x2::table::Table<0x2::object::ID, Auction>,
        active_auctions: vector<0x2::object::ID>,
        bid_escrow: 0x2::object_bag::ObjectBag,
        outbid_receipts: 0x2::object_bag::ObjectBag,
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : AuctionHouse {
        AuctionHouse{
            auctions        : 0x2::table::new<0x2::object::ID, Auction>(arg0),
            active_auctions : 0x1::vector::empty<0x2::object::ID>(),
            bid_escrow      : 0x2::object_bag::new(arg0),
            outbid_receipts : 0x2::object_bag::new(arg0),
        }
    }

    public fun auction_bid_count(arg0: &Auction) : u64 {
        arg0.bid_count
    }

    public fun auction_collection_id(arg0: &Auction) : 0x2::object::ID {
        arg0.collection_id
    }

    public fun auction_current_bid(arg0: &Auction) : u64 {
        arg0.current_bid
    }

    public fun auction_current_bidder(arg0: &Auction) : address {
        arg0.current_bidder
    }

    public fun auction_end_time(arg0: &Auction) : u64 {
        arg0.end_time
    }

    public fun auction_ended(arg0: &Auction) : bool {
        arg0.ended
    }

    public fun auction_extension_count(arg0: &Auction) : u64 {
        arg0.extension_count
    }

    public fun auction_nft_id(arg0: &Auction) : 0x2::object::ID {
        arg0.nft_id
    }

    public fun auction_original_end_time(arg0: &Auction) : u64 {
        arg0.original_end_time
    }

    public fun auction_reserve_price(arg0: &Auction) : u64 {
        arg0.reserve_price
    }

    public fun auction_seller(arg0: &Auction) : address {
        arg0.seller
    }

    public fun auction_start_time(arg0: &Auction) : u64 {
        arg0.start_time
    }

    public fun auction_starting_price(arg0: &Auction) : u64 {
        arg0.starting_price
    }

    public fun bid_receipt_amount(arg0: &BidReceipt) : u64 {
        0x2::coin::value<0x2::sui::SUI>(&arg0.amount)
    }

    public fun bid_receipt_auction_id(arg0: &BidReceipt) : 0x2::object::ID {
        arg0.auction_id
    }

    public fun bid_receipt_bidder(arg0: &BidReceipt) : address {
        arg0.bidder
    }

    public(friend) fun cancel_auction(arg0: &mut AuctionHouse, arg1: 0x2::object::ID, arg2: address, arg3: &0x2::clock::Clock) {
        assert!(0x2::table::contains<0x2::object::ID, Auction>(&arg0.auctions, arg1), 0);
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, Auction>(&mut arg0.auctions, arg1);
        assert!(arg2 == v0.seller, 4);
        assert!(v0.bid_count == 0, 3);
        assert!(!v0.ended, 2);
        v0.ended = true;
        let (v1, v2) = 0x1::vector::index_of<0x2::object::ID>(&arg0.active_auctions, &arg1);
        if (v1) {
            0x1::vector::remove<0x2::object::ID>(&mut arg0.active_auctions, v2);
        };
        0xfac74e1ba49638e4ed4c0a8826277e16775aa61f368329e289ec6bb4bbb0f141::marketplace_events::emit_auction_cancelled(arg1, arg2, v0.nft_id, 0x2::clock::timestamp_ms(arg3));
    }

    public fun claim_refund(arg0: BidReceipt, arg1: &mut 0x2::tx_context::TxContext) {
        let BidReceipt {
            id         : v0,
            auction_id : _,
            bidder     : v2,
            amount     : v3,
        } = arg0;
        assert!(0x2::tx_context::sender(arg1) == v2, 4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v3, v2);
        0x2::object::delete(v0);
    }

    public(friend) fun end_auction<T0: store + key>(arg0: &mut AuctionHouse, arg1: &mut 0xfac74e1ba49638e4ed4c0a8826277e16775aa61f368329e289ec6bb4bbb0f141::collection_registry::CollectionRegistry, arg2: &mut 0x2::balance::Balance<0x2::sui::SUI>, arg3: &mut 0x2::kiosk::Kiosk, arg4: &mut 0x2::kiosk::Kiosk, arg5: &0x2::kiosk::KioskOwnerCap, arg6: 0x2::object::ID, arg7: &0x2::transfer_policy::TransferPolicy<T0>, arg8: u16, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x2::object::ID, Auction>(&arg0.auctions, arg6), 0);
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, Auction>(&mut arg0.auctions, arg6);
        let v1 = 0x2::clock::timestamp_ms(arg9);
        assert!(v1 >= v0.end_time, 6);
        assert!(!v0.ended, 2);
        assert!(v0.current_bid > 0, 7);
        assert!(v0.current_bid >= v0.reserve_price, 9);
        let v2 = 0x2::object_bag::remove<0x2::object::ID, 0x2::coin::Coin<0x2::sui::SUI>>(&mut arg0.bid_escrow, arg6);
        assert!(0x2::coin::value<0x2::sui::SUI>(&v2) == v0.current_bid, 3);
        let v3 = 0xfac74e1ba49638e4ed4c0a8826277e16775aa61f368329e289ec6bb4bbb0f141::collection_registry::get_collection_royalty_bps(arg1, v0.collection_id);
        let (v4, v5, v6) = 0xfac74e1ba49638e4ed4c0a8826277e16775aa61f368329e289ec6bb4bbb0f141::fee_manager::split_payment(v2, arg8, v3, arg10);
        let v7 = v5;
        0xfac74e1ba49638e4ed4c0a8826277e16775aa61f368329e289ec6bb4bbb0f141::fee_manager::deposit_to_treasury(arg2, v4);
        if (0x2::coin::value<0x2::sui::SUI>(&v7) > 0) {
            if (0xfac74e1ba49638e4ed4c0a8826277e16775aa61f368329e289ec6bb4bbb0f141::collection_registry::is_collection_registered(arg1, v0.collection_id)) {
                let v8 = 0xfac74e1ba49638e4ed4c0a8826277e16775aa61f368329e289ec6bb4bbb0f141::collection_registry::get_collection_info(arg1, v0.collection_id);
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v7, 0xfac74e1ba49638e4ed4c0a8826277e16775aa61f368329e289ec6bb4bbb0f141::collection_registry::creator(&v8));
            } else {
                0xfac74e1ba49638e4ed4c0a8826277e16775aa61f368329e289ec6bb4bbb0f141::fee_manager::deposit_to_treasury(arg2, v7);
            };
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(v7);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v6, v0.seller);
        let (v9, v10) = 0x2::kiosk::purchase<T0>(arg3, v0.nft_id, 0x2::coin::zero<0x2::sui::SUI>(arg10));
        0x2::kiosk::lock<T0>(arg4, arg5, arg7, v9);
        let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(arg7, v10);
        0xfac74e1ba49638e4ed4c0a8826277e16775aa61f368329e289ec6bb4bbb0f141::collection_registry::update_collection_stats(arg1, v0.collection_id, v0.current_bid, 0);
        v0.ended = true;
        let (v14, v15) = 0x1::vector::index_of<0x2::object::ID>(&arg0.active_auctions, &arg6);
        if (v14) {
            0x1::vector::remove<0x2::object::ID>(&mut arg0.active_auctions, v15);
        };
        0xfac74e1ba49638e4ed4c0a8826277e16775aa61f368329e289ec6bb4bbb0f141::marketplace_events::emit_auction_ended(arg6, v0.nft_id, v0.seller, v0.current_bidder, v0.current_bid, 0xfac74e1ba49638e4ed4c0a8826277e16775aa61f368329e289ec6bb4bbb0f141::fee_manager::calculate_platform_fee(v0.current_bid, arg8), 0xfac74e1ba49638e4ed4c0a8826277e16775aa61f368329e289ec6bb4bbb0f141::fee_manager::calculate_royalty_fee(v0.current_bid, v3), v1);
    }

    public fun get_auction(arg0: &AuctionHouse, arg1: 0x2::object::ID) : &Auction {
        assert!(0x2::table::contains<0x2::object::ID, Auction>(&arg0.auctions, arg1), 0);
        0x2::table::borrow<0x2::object::ID, Auction>(&arg0.auctions, arg1)
    }

    public fun is_auction_active(arg0: &AuctionHouse, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock) : bool {
        if (!0x2::table::contains<0x2::object::ID, Auction>(&arg0.auctions, arg1)) {
            return false
        };
        let v0 = 0x2::table::borrow<0x2::object::ID, Auction>(&arg0.auctions, arg1);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        if (!v0.ended) {
            if (v1 >= v0.start_time) {
                v1 < v0.end_time
            } else {
                false
            }
        } else {
            false
        }
    }

    public fun place_bid(arg0: &mut AuctionHouse, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x2::object::ID, Auction>(&arg0.auctions, arg1), 0);
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, Auction>(&mut arg0.auctions, arg1);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        assert!(v1 >= v0.start_time, 1);
        assert!(v1 < v0.end_time, 2);
        assert!(!v0.ended, 2);
        let v2 = 0x2::tx_context::sender(arg4);
        assert!(v2 != v0.seller, 5);
        let v3 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        let v4 = if (v0.current_bid == 0) {
            v0.starting_price
        } else {
            v0.current_bid + v0.current_bid * 500 / 10000
        };
        assert!(v3 >= v4, 3);
        let v5 = v0.current_bidder;
        let v6 = v0.current_bid;
        if (v6 > 0 && v5 != @0x0) {
            let v7 = BidReceipt{
                id         : 0x2::object::new(arg4),
                auction_id : arg1,
                bidder     : v5,
                amount     : 0x2::object_bag::remove<0x2::object::ID, 0x2::coin::Coin<0x2::sui::SUI>>(&mut arg0.bid_escrow, arg1),
            };
            0x2::transfer::public_transfer<BidReceipt>(v7, v5);
        };
        0x2::object_bag::add<0x2::object::ID, 0x2::coin::Coin<0x2::sui::SUI>>(&mut arg0.bid_escrow, arg1, arg2);
        v0.current_bid = v3;
        v0.current_bidder = v2;
        v0.bid_count = v0.bid_count + 1;
        0xfac74e1ba49638e4ed4c0a8826277e16775aa61f368329e289ec6bb4bbb0f141::marketplace_events::emit_bid_placed(arg1, v2, v3, v6, v1);
        if (v0.end_time - v1 < 300000 && v0.extension_count < 3) {
            let v8 = v1 + 300000;
            if (v8 - v0.start_time <= 2592000000) {
                v0.end_time = v8;
                v0.extension_count = v0.extension_count + 1;
            };
        };
    }

    public(friend) fun start_auction(arg0: &mut AuctionHouse, arg1: address, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: 0x2::object::ID, arg5: u64, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(arg6 >= arg5, 8);
        let v0 = 0x2::clock::timestamp_ms(arg8);
        let v1 = v0 + arg7;
        let v2 = Auction{
            id                : 0x2::object::new(arg9),
            seller            : arg1,
            kiosk_id          : arg2,
            nft_id            : arg3,
            collection_id     : arg4,
            starting_price    : arg5,
            reserve_price     : arg6,
            current_bid       : 0,
            current_bidder    : @0x0,
            bid_count         : 0,
            start_time        : v0,
            end_time          : v1,
            original_end_time : v1,
            extension_count   : 0,
            ended             : false,
        };
        let v3 = 0x2::object::uid_to_inner(&v2.id);
        0xfac74e1ba49638e4ed4c0a8826277e16775aa61f368329e289ec6bb4bbb0f141::marketplace_events::emit_auction_started(v3, arg1, arg3, arg4, arg5, arg6, v0, v1);
        0x2::table::add<0x2::object::ID, Auction>(&mut arg0.auctions, v3, v2);
        0x1::vector::push_back<0x2::object::ID>(&mut arg0.active_auctions, v3);
        v3
    }

    // decompiled from Move bytecode v6
}

