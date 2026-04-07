module 0x10060284412fe122d500bcead4c5cd0f07af65d443d456913dd5b1203aeef961::auction {
    struct Auction has key {
        id: 0x2::object::UID,
        nft: 0x1::option::Option<0x10060284412fe122d500bcead4c5cd0f07af65d443d456913dd5b1203aeef961::todaynft::TodayNFT>,
        seller: address,
        highest_bidder: 0x1::option::Option<address>,
        highest_bid: u64,
        vault: 0x2::balance::Balance<0x2::sui::SUI>,
        end_time: u64,
        ended: bool,
    }

    struct GlobalState has key {
        id: 0x2::object::UID,
        last_auction_time: u64,
    }

    struct AuctionCap has store, key {
        id: 0x2::object::UID,
    }

    struct AuctionCreated has copy, drop {
        auction_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        start_time: u64,
        end_time: u64,
    }

    struct BidPlaced has copy, drop {
        auction_id: 0x2::object::ID,
        bidder: address,
        bid_amount: u64,
        timestamp_ms: u64,
    }

    struct AuctionSettled has copy, drop {
        auction_id: 0x2::object::ID,
        winner: address,
        winning_bid: u64,
    }

    struct AuctionSettledNoBids has copy, drop {
        auction_id: 0x2::object::ID,
        seller: address,
    }

    public fun bid(arg0: &mut Auction, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(!arg0.ended && v0 < arg0.end_time, 1);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v1 >= arg0.highest_bid + 0x10060284412fe122d500bcead4c5cd0f07af65d443d456913dd5b1203aeef961::config::min_bid_increment(), 3);
        if (arg0.highest_bid > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.vault, arg0.highest_bid), arg3), *0x1::option::borrow<address>(&arg0.highest_bidder));
        };
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.vault, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        arg0.highest_bid = v1;
        arg0.highest_bidder = 0x1::option::some<address>(0x2::tx_context::sender(arg3));
        let v2 = BidPlaced{
            auction_id   : 0x2::object::id<Auction>(arg0),
            bidder       : 0x2::tx_context::sender(arg3),
            bid_amount   : v1,
            timestamp_ms : v0,
        };
        0x2::event::emit<BidPlaced>(v2);
    }

    public fun create_auction(arg0: &AuctionCap, arg1: &mut GlobalState, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg5);
        assert!(arg1.last_auction_time == 0 || v0 >= arg1.last_auction_time + 0x10060284412fe122d500bcead4c5cd0f07af65d443d456913dd5b1203aeef961::config::auction_duration_ms(), 4);
        let v1 = 0x10060284412fe122d500bcead4c5cd0f07af65d443d456913dd5b1203aeef961::todaynft::mint(v0, arg2, arg3, arg4, arg6);
        let v2 = v0 + 0x10060284412fe122d500bcead4c5cd0f07af65d443d456913dd5b1203aeef961::config::auction_duration_ms();
        let v3 = Auction{
            id             : 0x2::object::new(arg6),
            nft            : 0x1::option::some<0x10060284412fe122d500bcead4c5cd0f07af65d443d456913dd5b1203aeef961::todaynft::TodayNFT>(v1),
            seller         : 0x2::tx_context::sender(arg6),
            highest_bidder : 0x1::option::none<address>(),
            highest_bid    : 0,
            vault          : 0x2::balance::zero<0x2::sui::SUI>(),
            end_time       : v2,
            ended          : false,
        };
        arg1.last_auction_time = v0;
        let v4 = AuctionCreated{
            auction_id : 0x2::object::id<Auction>(&v3),
            nft_id     : 0x2::object::id<0x10060284412fe122d500bcead4c5cd0f07af65d443d456913dd5b1203aeef961::todaynft::TodayNFT>(&v1),
            start_time : v0,
            end_time   : v2,
        };
        0x2::event::emit<AuctionCreated>(v4);
        0x2::transfer::share_object<Auction>(v3);
    }

    public fun end_auction(arg0: &mut Auction, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.ended, 1);
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.end_time, 2);
        arg0.ended = true;
        if (arg0.highest_bid > 0) {
            let v0 = *0x1::option::borrow<address>(&arg0.highest_bidder);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.vault, arg0.highest_bid), arg2), arg0.seller);
            0x2::transfer::public_transfer<0x10060284412fe122d500bcead4c5cd0f07af65d443d456913dd5b1203aeef961::todaynft::TodayNFT>(0x1::option::extract<0x10060284412fe122d500bcead4c5cd0f07af65d443d456913dd5b1203aeef961::todaynft::TodayNFT>(&mut arg0.nft), v0);
            let v1 = AuctionSettled{
                auction_id  : 0x2::object::id<Auction>(arg0),
                winner      : v0,
                winning_bid : arg0.highest_bid,
            };
            0x2::event::emit<AuctionSettled>(v1);
        } else {
            0x2::transfer::public_transfer<0x10060284412fe122d500bcead4c5cd0f07af65d443d456913dd5b1203aeef961::todaynft::TodayNFT>(0x1::option::extract<0x10060284412fe122d500bcead4c5cd0f07af65d443d456913dd5b1203aeef961::todaynft::TodayNFT>(&mut arg0.nft), arg0.seller);
            let v2 = AuctionSettledNoBids{
                auction_id : 0x2::object::id<Auction>(arg0),
                seller     : arg0.seller,
            };
            0x2::event::emit<AuctionSettledNoBids>(v2);
        };
    }

    public fun end_time(arg0: &Auction) : u64 {
        arg0.end_time
    }

    public fun ended(arg0: &Auction) : bool {
        arg0.ended
    }

    public fun highest_bid(arg0: &Auction) : u64 {
        arg0.highest_bid
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AuctionCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AuctionCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = GlobalState{
            id                : 0x2::object::new(arg0),
            last_auction_time : 0,
        };
        0x2::transfer::share_object<GlobalState>(v1);
    }

    public fun seller(arg0: &Auction) : address {
        arg0.seller
    }

    public fun update_nft_image_blob_id(arg0: &mut 0x10060284412fe122d500bcead4c5cd0f07af65d443d456913dd5b1203aeef961::todaynft::TodayNFT, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        0x10060284412fe122d500bcead4c5cd0f07af65d443d456913dd5b1203aeef961::todaynft::set_image_blob_id(arg0, arg1, arg2);
    }

    public fun update_nft_news_blob_id(arg0: &mut 0x10060284412fe122d500bcead4c5cd0f07af65d443d456913dd5b1203aeef961::todaynft::TodayNFT, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        0x10060284412fe122d500bcead4c5cd0f07af65d443d456913dd5b1203aeef961::todaynft::set_news_blob_id(arg0, arg1, arg2);
    }

    // decompiled from Move bytecode v7
}

