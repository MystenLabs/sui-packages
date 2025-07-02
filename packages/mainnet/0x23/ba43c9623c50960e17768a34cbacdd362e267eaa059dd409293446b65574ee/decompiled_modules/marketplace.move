module 0x23ba43c9623c50960e17768a34cbacdd362e267eaa059dd409293446b65574ee::marketplace {
    struct NFT has store, key {
        id: 0x2::object::UID,
        collection_id: vector<u8>,
        token_id: vector<u8>,
    }

    struct Auction has store, key {
        id: 0x2::object::UID,
        nft_id: 0x2::object::ID,
        kiosk_id: 0x2::object::ID,
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
        kiosk_id: 0x2::object::ID,
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

    public entry fun end_auction<T0: store + key>(arg0: &mut Auction, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: &0x2::transfer_policy::TransferPolicy<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 0, 1);
        assert!(0x2::clock::timestamp_ms(arg4) >= arg0.end_time, 4);
        arg0.status = 1;
        if (arg0.highest_bidder != @0x0) {
            let v0 = arg0.current_bid / 100;
            let (v1, v2) = 0x2::kiosk::purchase<T0>(arg1, arg0.nft_id, 0x2::coin::take<0x2::sui::SUI>(&mut arg0.balance, arg0.current_bid, arg5));
            let (_, _, _) = 0x2::transfer_policy::confirm_request<T0>(arg3, v2);
            0x2::transfer::public_transfer<T0>(v1, arg0.highest_bidder);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.balance, arg0.current_bid - v0, arg5), arg0.seller);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.balance, v0, arg5), @0x8cfed3962605beacf459a4bab2830a7c8e95bab8e60c228e65b2837565bd5fb8);
            let v6 = AuctionEnded{
                auction_id : 0x2::object::uid_to_inner(&arg0.id),
                winner     : arg0.highest_bidder,
                final_bid  : arg0.current_bid,
            };
            0x2::event::emit<AuctionEnded>(v6);
        } else {
            0x2::kiosk::delist<T0>(arg1, arg2, arg0.nft_id);
            0x2::transfer::public_transfer<T0>(0x2::kiosk::take<T0>(arg1, arg2, arg0.nft_id), arg0.seller);
        };
        0x2::balance::destroy_zero<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, 0));
    }

    public entry fun end_auction_no_transfer(arg0: &mut Auction, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 0, 1);
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.end_time, 4);
        arg0.status = 1;
        if (arg0.highest_bidder != @0x0) {
            let v0 = arg0.current_bid / 100;
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.balance, arg0.current_bid - v0, arg2), arg0.seller);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.balance, v0, arg2), @0x8cfed3962605beacf459a4bab2830a7c8e95bab8e60c228e65b2837565bd5fb8);
            let v1 = AuctionEnded{
                auction_id : 0x2::object::uid_to_inner(&arg0.id),
                winner     : arg0.highest_bidder,
                final_bid  : arg0.current_bid,
            };
            0x2::event::emit<AuctionEnded>(v1);
        };
        0x2::balance::destroy_zero<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, 0));
    }

    public entry fun list_nft<T0: store + key>(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x2::object::id<0x2::kiosk::Kiosk>(arg0);
        0x2::kiosk::list<T0>(arg0, arg1, arg2, arg3);
        let v2 = Auction{
            id             : 0x2::object::new(arg6),
            nft_id         : arg2,
            kiosk_id       : v1,
            starting_bid   : arg3,
            current_bid    : arg3,
            highest_bidder : @0x0,
            seller         : v0,
            end_time       : 0x2::clock::timestamp_ms(arg5) + arg4,
            status         : 0,
            balance        : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        let v3 = AuctionCreated{
            auction_id   : 0x2::object::uid_to_inner(&v2.id),
            nft_id       : arg2,
            kiosk_id     : v1,
            starting_bid : arg3,
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

