module 0x3c069698eabc11240ac20fedc8bdb0e1371a9974b99f208e457ac1833a409f0b::suins_auction {
    struct Auction has key {
        id: 0x2::object::UID,
        domain: 0x1::option::Option<0x3c069698eabc11240ac20fedc8bdb0e1371a9974b99f208e457ac1833a409f0b::suins_domain::DomainItem>,
        seller: address,
        highest_bidder: address,
        current_bid: u64,
        min_bid: u64,
        end_time: u64,
        coin_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        auction_ended: bool,
        admin_address: address,
    }

    struct AuctionCreated has copy, drop {
        auction_id: 0x2::object::ID,
        domain_id: 0x2::object::ID,
        domain_name: 0x1::string::String,
        seller: address,
        start_price: u64,
        end_time: u64,
        expiration_time: u64,
    }

    struct BidPlaced has copy, drop {
        auction_id: 0x2::object::ID,
        domain_name: 0x1::string::String,
        bidder: address,
        amount: u64,
    }

    struct AuctionCancelled has copy, drop {
        auction_id: 0x2::object::ID,
        domain_name: 0x1::string::String,
        seller: address,
    }

    struct AuctionEnded has copy, drop {
        auction_id: 0x2::object::ID,
        domain_name: 0x1::string::String,
        winner: address,
        final_price: u64,
    }

    struct DomainClaimed has copy, drop {
        auction_id: 0x2::object::ID,
        domain_name: 0x1::string::String,
        winner: address,
    }

    struct AuctionEndedNoBids has copy, drop {
        auction_id: 0x2::object::ID,
        domain_name: 0x1::string::String,
        seller: address,
    }

    public entry fun cancel_auction(arg0: &mut Auction, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.seller, 8);
        assert!(arg0.highest_bidder == arg0.seller, 10);
        assert!(0x1::option::is_some<0x3c069698eabc11240ac20fedc8bdb0e1371a9974b99f208e457ac1833a409f0b::suins_domain::DomainItem>(&arg0.domain), 4);
        arg0.auction_ended = true;
        let v0 = 0x1::option::extract<0x3c069698eabc11240ac20fedc8bdb0e1371a9974b99f208e457ac1833a409f0b::suins_domain::DomainItem>(&mut arg0.domain);
        0x2::transfer::public_transfer<0x3c069698eabc11240ac20fedc8bdb0e1371a9974b99f208e457ac1833a409f0b::suins_domain::DomainItem>(v0, arg0.seller);
        let v1 = AuctionCancelled{
            auction_id  : 0x2::object::id<Auction>(arg0),
            domain_name : *0x3c069698eabc11240ac20fedc8bdb0e1371a9974b99f208e457ac1833a409f0b::suins_domain::name(&v0),
            seller      : arg0.seller,
        };
        0x2::event::emit<AuctionCancelled>(v1);
    }

    public entry fun claim_domain(arg0: &mut Auction, arg1: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg2) >= arg0.end_time, 2);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x1::option::is_some<0x3c069698eabc11240ac20fedc8bdb0e1371a9974b99f208e457ac1833a409f0b::suins_domain::DomainItem>(&arg0.domain), 4);
        let v1 = v0 == arg0.highest_bidder;
        let v2 = v0 == arg0.seller && arg0.highest_bidder == arg0.seller;
        assert!(v1 || v2, 8);
        arg0.auction_ended = true;
        let v3 = 0x1::option::extract<0x3c069698eabc11240ac20fedc8bdb0e1371a9974b99f208e457ac1833a409f0b::suins_domain::DomainItem>(&mut arg0.domain);
        let v4 = *0x3c069698eabc11240ac20fedc8bdb0e1371a9974b99f208e457ac1833a409f0b::suins_domain::name(&v3);
        if (v1 && !v2) {
            let v5 = arg0.current_bid;
            let v6 = v5 * 500 / 10000;
            if (v6 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.coin_balance, v6, arg3), arg0.admin_address);
            };
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.coin_balance, v5 - v6, arg3), arg0.seller);
            let v7 = AuctionEnded{
                auction_id  : 0x2::object::id<Auction>(arg0),
                domain_name : v4,
                winner      : v0,
                final_price : v5,
            };
            0x2::event::emit<AuctionEnded>(v7);
            let v8 = DomainClaimed{
                auction_id  : 0x2::object::id<Auction>(arg0),
                domain_name : v4,
                winner      : v0,
            };
            0x2::event::emit<DomainClaimed>(v8);
        } else {
            let v9 = AuctionEndedNoBids{
                auction_id  : 0x2::object::id<Auction>(arg0),
                domain_name : v4,
                seller      : v0,
            };
            0x2::event::emit<AuctionEndedNoBids>(v9);
        };
        0x2::transfer::public_transfer<0x3c069698eabc11240ac20fedc8bdb0e1371a9974b99f208e457ac1833a409f0b::suins_domain::DomainItem>(v3, v0);
    }

    public entry fun create_auction(arg0: 0x3c069698eabc11240ac20fedc8bdb0e1371a9974b99f208e457ac1833a409f0b::suins_domain::DomainItem, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 > 0, 6);
        assert!(arg2 > 0, 5);
        assert!(arg2 >= 3600000, 5);
        assert!(arg2 <= 604800000, 5);
        assert!(0x3c069698eabc11240ac20fedc8bdb0e1371a9974b99f208e457ac1833a409f0b::suins_domain::is_valid(&arg0, arg3), 7);
        let v0 = 0x2::clock::timestamp_ms(arg3) + arg2;
        let v1 = 0x2::tx_context::sender(arg4);
        let v2 = Auction{
            id             : 0x2::object::new(arg4),
            domain         : 0x1::option::some<0x3c069698eabc11240ac20fedc8bdb0e1371a9974b99f208e457ac1833a409f0b::suins_domain::DomainItem>(arg0),
            seller         : v1,
            highest_bidder : v1,
            current_bid    : arg1,
            min_bid        : arg1,
            end_time       : v0,
            coin_balance   : 0x2::balance::zero<0x2::sui::SUI>(),
            auction_ended  : false,
            admin_address  : @0x322e3d3e1b9a4a7488dd3a225b225b725cbd0c68caf1547aaf72087b795b6fe6,
        };
        let v3 = AuctionCreated{
            auction_id      : 0x2::object::id<Auction>(&v2),
            domain_id       : 0x2::object::id<0x3c069698eabc11240ac20fedc8bdb0e1371a9974b99f208e457ac1833a409f0b::suins_domain::DomainItem>(&arg0),
            domain_name     : *0x3c069698eabc11240ac20fedc8bdb0e1371a9974b99f208e457ac1833a409f0b::suins_domain::name(&arg0),
            seller          : v1,
            start_price     : arg1,
            end_time        : v0,
            expiration_time : 0x3c069698eabc11240ac20fedc8bdb0e1371a9974b99f208e457ac1833a409f0b::suins_domain::expiration_time(&arg0),
        };
        0x2::event::emit<AuctionCreated>(v3);
        0x2::transfer::share_object<Auction>(v2);
    }

    public entry fun place_bid(arg0: &mut Auction, arg1: &0x2::clock::Clock, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(arg2);
        assert!(v0 > 0, 6);
        assert!(v0 >= arg0.current_bid + arg0.current_bid * 500 / 10000, 9);
        assert!(0x2::clock::timestamp_ms(arg1) < arg0.end_time, 0);
        let v1 = 0x2::tx_context::sender(arg3);
        if (arg0.highest_bidder != arg0.seller) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.coin_balance, arg0.current_bid, arg3), arg0.highest_bidder);
        };
        arg0.current_bid = v0;
        arg0.highest_bidder = v1;
        update_balance_with_coin(arg0, v0, arg2, arg3);
        let v2 = 0x2::clock::timestamp_ms(arg1);
        if (arg0.end_time - v2 < 300000) {
            arg0.end_time = v2 + 300000;
        };
        let v3 = BidPlaced{
            auction_id  : 0x2::object::id<Auction>(arg0),
            domain_name : *0x3c069698eabc11240ac20fedc8bdb0e1371a9974b99f208e457ac1833a409f0b::suins_domain::name(0x1::option::borrow<0x3c069698eabc11240ac20fedc8bdb0e1371a9974b99f208e457ac1833a409f0b::suins_domain::DomainItem>(&arg0.domain)),
            bidder      : v1,
            amount      : v0,
        };
        0x2::event::emit<BidPlaced>(v3);
    }

    fun update_balance_with_coin(arg0: &mut Auction, arg1: u64, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = &mut arg0.coin_balance;
        0x2::balance::join<0x2::sui::SUI>(v0, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(arg2, arg1 - 0x2::balance::value<0x2::sui::SUI>(v0), arg3)));
    }

    // decompiled from Move bytecode v6
}

