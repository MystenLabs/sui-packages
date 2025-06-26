module 0x1f2be48f541d1d362ec17ce5dc96871f8e8ece7b4652419fd55e6f234bf4dfe9::suins_auction {
    struct Auction has key {
        id: 0x2::object::UID,
        domain: 0x1::option::Option<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration>,
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
        assert!(0x1::option::is_some<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration>(&arg0.domain), 4);
        arg0.auction_ended = true;
        let v0 = 0x1::option::extract<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration>(&mut arg0.domain);
        0x2::transfer::public_transfer<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration>(v0, arg0.seller);
        let v1 = AuctionCancelled{
            auction_id  : 0x2::object::id<Auction>(arg0),
            domain_name : 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::domain_name(&v0),
            seller      : arg0.seller,
        };
        0x2::event::emit<AuctionCancelled>(v1);
    }

    public entry fun claim_domain(arg0: Auction, arg1: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg2) >= arg0.end_time, 2);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x1::option::is_some<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration>(&arg0.domain), 4);
        let v1 = v0 == arg0.highest_bidder;
        let v2 = v0 == arg0.seller && arg0.highest_bidder == arg0.seller;
        assert!(v1 || v2, 8);
        let Auction {
            id             : v3,
            domain         : v4,
            seller         : v5,
            highest_bidder : _,
            current_bid    : v7,
            min_bid        : _,
            end_time       : _,
            coin_balance   : v10,
            auction_ended  : _,
            admin_address  : v12,
        } = arg0;
        let v13 = v10;
        let v14 = v4;
        let v15 = v3;
        let v16 = 0x1::option::extract<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration>(&mut v14);
        let v17 = 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::domain_name(&v16);
        if (v1 && !v2) {
            let v18 = v7 * 500 / 10000;
            if (v18 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut v13, v18, arg3), v12);
            };
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut v13, v7 - v18, arg3), v5);
            let v19 = AuctionEnded{
                auction_id  : 0x2::object::uid_to_inner(&v15),
                domain_name : v17,
                winner      : v0,
                final_price : v7,
            };
            0x2::event::emit<AuctionEnded>(v19);
            let v20 = DomainClaimed{
                auction_id  : 0x2::object::uid_to_inner(&v15),
                domain_name : v17,
                winner      : v0,
            };
            0x2::event::emit<DomainClaimed>(v20);
        } else {
            let v21 = AuctionEndedNoBids{
                auction_id  : 0x2::object::uid_to_inner(&v15),
                domain_name : v17,
                seller      : v0,
            };
            0x2::event::emit<AuctionEndedNoBids>(v21);
        };
        0x2::transfer::public_transfer<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration>(v16, v0);
        0x1::option::destroy_none<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration>(v14);
        0x2::balance::destroy_zero<0x2::sui::SUI>(v13);
        0x2::object::delete(v15);
    }

    public entry fun create_auction(arg0: 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 > 0, 6);
        assert!(arg2 > 0, 5);
        assert!(arg2 >= 3600000, 5);
        assert!(arg2 <= 604800000, 5);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        assert!(v0 < 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::expiration_timestamp_ms(&arg0), 7);
        let v1 = v0 + arg2;
        let v2 = 0x2::tx_context::sender(arg4);
        let v3 = Auction{
            id             : 0x2::object::new(arg4),
            domain         : 0x1::option::some<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration>(arg0),
            seller         : v2,
            highest_bidder : v2,
            current_bid    : arg1,
            min_bid        : arg1,
            end_time       : v1,
            coin_balance   : 0x2::balance::zero<0x2::sui::SUI>(),
            auction_ended  : false,
            admin_address  : @0x322e3d3e1b9a4a7488dd3a225b225b725cbd0c68caf1547aaf72087b795b6fe6,
        };
        let v4 = AuctionCreated{
            auction_id      : 0x2::object::id<Auction>(&v3),
            domain_id       : 0x2::object::id<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration>(&arg0),
            domain_name     : 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::domain_name(&arg0),
            seller          : v2,
            start_price     : arg1,
            end_time        : v1,
            expiration_time : 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::expiration_timestamp_ms(&arg0),
        };
        0x2::event::emit<AuctionCreated>(v4);
        0x2::transfer::share_object<Auction>(v3);
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
            domain_name : 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::domain_name(0x1::option::borrow<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration>(&arg0.domain)),
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

