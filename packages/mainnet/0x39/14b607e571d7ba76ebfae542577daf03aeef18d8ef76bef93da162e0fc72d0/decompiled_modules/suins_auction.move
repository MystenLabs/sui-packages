module 0x3914b607e571d7ba76ebfae542577daf03aeef18d8ef76bef93da162e0fc72d0::suins_auction {
    struct NS has drop {
        dummy_field: bool,
    }

    struct AuctionData has store {
        domain: 0x1::option::Option<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration>,
        seller: address,
        highest_bidder: address,
        current_bid: u64,
        min_bid: u64,
        end_time: u64,
        currency_type: u8,
        ns_balance: 0x1::option::Option<0x2::balance::Balance<NS>>,
        sui_balance: 0x1::option::Option<0x2::balance::Balance<0x2::sui::SUI>>,
        auction_ended: bool,
    }

    struct AuctionRegistry has key {
        id: 0x2::object::UID,
        total_auctions: u64,
        active_auctions: u64,
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
        currency_type: u8,
    }

    struct BidPlaced has copy, drop {
        auction_id: 0x2::object::ID,
        domain_name: 0x1::string::String,
        bidder: address,
        amount: u64,
        currency_type: u8,
    }

    struct AuctionCancelled has copy, drop {
        auction_id: 0x2::object::ID,
        domain_name: 0x1::string::String,
        seller: address,
        currency_type: u8,
    }

    struct AuctionEnded has copy, drop {
        auction_id: 0x2::object::ID,
        domain_name: 0x1::string::String,
        winner: address,
        final_price: u64,
        currency_type: u8,
    }

    struct DomainClaimed has copy, drop {
        auction_id: 0x2::object::ID,
        domain_name: 0x1::string::String,
        winner: address,
        currency_type: u8,
    }

    struct AuctionEndedNoBids has copy, drop {
        auction_id: 0x2::object::ID,
        domain_name: 0x1::string::String,
        seller: address,
        currency_type: u8,
    }

    struct RegistryCreated has copy, drop {
        registry_id: 0x2::object::ID,
        admin_address: address,
    }

    public entry fun cancel_auction(arg0: &mut AuctionRegistry, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::dynamic_field::borrow_mut<0x2::object::ID, AuctionData>(&mut arg0.id, arg1);
        assert!(v0 == v1.seller, 8);
        assert!(!v1.auction_ended, 11);
        assert!(v1.highest_bidder == v1.seller, 10);
        assert!(0x1::option::is_some<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration>(&v1.domain), 4);
        v1.auction_ended = true;
        let v2 = 0x1::option::extract<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration>(&mut v1.domain);
        let v3 = AuctionCancelled{
            auction_id    : arg1,
            domain_name   : 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::domain_name(&v2),
            seller        : v1.seller,
            currency_type : v1.currency_type,
        };
        0x2::event::emit<AuctionCancelled>(v3);
        arg0.active_auctions = arg0.active_auctions - 1;
        let AuctionData {
            domain         : v4,
            seller         : _,
            highest_bidder : _,
            current_bid    : _,
            min_bid        : _,
            end_time       : _,
            currency_type  : _,
            ns_balance     : v11,
            sui_balance    : v12,
            auction_ended  : _,
        } = 0x2::dynamic_field::remove<0x2::object::ID, AuctionData>(&mut arg0.id, arg1);
        let v14 = v12;
        let v15 = v11;
        0x2::transfer::public_transfer<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration>(v2, v0);
        0x1::option::destroy_none<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration>(v4);
        if (0x1::option::is_some<0x2::balance::Balance<NS>>(&v15)) {
            let v16 = 0x1::option::destroy_some<0x2::balance::Balance<NS>>(v15);
            assert!(0x2::balance::value<NS>(&v16) == 0, 13);
            0x2::balance::destroy_zero<NS>(v16);
        } else {
            0x1::option::destroy_none<0x2::balance::Balance<NS>>(v15);
        };
        if (0x1::option::is_some<0x2::balance::Balance<0x2::sui::SUI>>(&v14)) {
            let v17 = 0x1::option::destroy_some<0x2::balance::Balance<0x2::sui::SUI>>(v14);
            assert!(0x2::balance::value<0x2::sui::SUI>(&v17) == 0, 13);
            0x2::balance::destroy_zero<0x2::sui::SUI>(v17);
        } else {
            0x1::option::destroy_none<0x2::balance::Balance<0x2::sui::SUI>>(v14);
        };
    }

    public entry fun claim_domain(arg0: &mut AuctionRegistry, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::dynamic_field::borrow_mut<0x2::object::ID, AuctionData>(&mut arg0.id, arg1);
        assert!(0x2::clock::timestamp_ms(arg2) >= v0.end_time, 2);
        assert!(!v0.auction_ended, 11);
        if (0x1::option::is_some<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration>(&v0.domain)) {
            assert!(0x2::clock::timestamp_ms(arg2) < 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::expiration_timestamp_ms(0x1::option::borrow<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration>(&v0.domain)), 7);
        };
        let v1 = 0x2::tx_context::sender(arg3);
        assert!(0x1::option::is_some<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration>(&v0.domain), 4);
        let v2 = v1 == v0.highest_bidder;
        let v3 = v1 == v0.seller && v0.highest_bidder == v0.seller;
        assert!(v2 || v3, 8);
        v0.auction_ended = true;
        let v4 = 0x1::option::extract<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration>(&mut v0.domain);
        let v5 = 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::domain_name(&v4);
        if (v2 && v0.highest_bidder != v0.seller) {
            let v6 = v0.current_bid;
            let v7 = v6 / 20;
            assert!(v7 <= v6, 8);
            if (v0.currency_type == 1) {
                let v8 = 0x1::option::borrow_mut<0x2::balance::Balance<NS>>(&mut v0.ns_balance);
                if (v7 > 0) {
                    0x2::transfer::public_transfer<0x2::coin::Coin<NS>>(0x2::coin::take<NS>(v8, v7, arg3), arg0.admin_address);
                };
                0x2::transfer::public_transfer<0x2::coin::Coin<NS>>(0x2::coin::take<NS>(v8, v6 - v7, arg3), v0.seller);
            } else {
                let v9 = 0x1::option::borrow_mut<0x2::balance::Balance<0x2::sui::SUI>>(&mut v0.sui_balance);
                if (v7 > 0) {
                    0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(v9, v7, arg3), arg0.admin_address);
                };
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(v9, v6 - v7, arg3), v0.seller);
            };
            let v10 = AuctionEnded{
                auction_id    : arg1,
                domain_name   : v5,
                winner        : v1,
                final_price   : v6,
                currency_type : v0.currency_type,
            };
            0x2::event::emit<AuctionEnded>(v10);
            let v11 = DomainClaimed{
                auction_id    : arg1,
                domain_name   : v5,
                winner        : v1,
                currency_type : v0.currency_type,
            };
            0x2::event::emit<DomainClaimed>(v11);
        } else {
            let v12 = AuctionEndedNoBids{
                auction_id    : arg1,
                domain_name   : v5,
                seller        : v1,
                currency_type : v0.currency_type,
            };
            0x2::event::emit<AuctionEndedNoBids>(v12);
        };
        0x2::transfer::public_transfer<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration>(v4, v1);
        arg0.active_auctions = arg0.active_auctions - 1;
        let AuctionData {
            domain         : v13,
            seller         : _,
            highest_bidder : _,
            current_bid    : _,
            min_bid        : _,
            end_time       : _,
            currency_type  : _,
            ns_balance     : v20,
            sui_balance    : v21,
            auction_ended  : _,
        } = 0x2::dynamic_field::remove<0x2::object::ID, AuctionData>(&mut arg0.id, arg1);
        let v23 = v21;
        let v24 = v20;
        let v25 = v13;
        if (0x1::option::is_some<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration>(&v25)) {
            0x2::transfer::public_transfer<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration>(0x1::option::destroy_some<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration>(v25), arg0.admin_address);
        } else {
            0x1::option::destroy_none<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration>(v25);
        };
        if (0x1::option::is_some<0x2::balance::Balance<NS>>(&v24)) {
            let v26 = 0x1::option::destroy_some<0x2::balance::Balance<NS>>(v24);
            assert!(0x2::balance::value<NS>(&v26) == 0, 13);
            0x2::balance::destroy_zero<NS>(v26);
        } else {
            0x1::option::destroy_none<0x2::balance::Balance<NS>>(v24);
        };
        if (0x1::option::is_some<0x2::balance::Balance<0x2::sui::SUI>>(&v23)) {
            let v27 = 0x1::option::destroy_some<0x2::balance::Balance<0x2::sui::SUI>>(v23);
            assert!(0x2::balance::value<0x2::sui::SUI>(&v27) == 0, 13);
            0x2::balance::destroy_zero<0x2::sui::SUI>(v27);
        } else {
            0x1::option::destroy_none<0x2::balance::Balance<0x2::sui::SUI>>(v23);
        };
    }

    public entry fun create_auction(arg0: &mut AuctionRegistry, arg1: 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration, arg2: u64, arg3: u64, arg4: u8, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 6);
        assert!(arg3 > 0, 5);
        assert!(arg3 >= 3600000, 5);
        assert!(arg3 <= 604800000, 5);
        assert!(arg4 == 0 || arg4 == 1, 8);
        let v0 = 0x2::clock::timestamp_ms(arg5);
        let v1 = 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::expiration_timestamp_ms(&arg1);
        assert!(v0 < v1, 7);
        let v2 = v0 + arg3;
        assert!(v0 + 2592000000 < v1, 12);
        let v3 = 0x2::tx_context::sender(arg6);
        let v4 = if (arg4 == 1) {
            0x1::option::some<0x2::balance::Balance<NS>>(0x2::balance::zero<NS>())
        } else {
            0x1::option::none<0x2::balance::Balance<NS>>()
        };
        let v5 = if (arg4 == 0) {
            0x1::option::some<0x2::balance::Balance<0x2::sui::SUI>>(0x2::balance::zero<0x2::sui::SUI>())
        } else {
            0x1::option::none<0x2::balance::Balance<0x2::sui::SUI>>()
        };
        let v6 = AuctionData{
            domain         : 0x1::option::some<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration>(arg1),
            seller         : v3,
            highest_bidder : v3,
            current_bid    : arg2,
            min_bid        : arg2,
            end_time       : v2,
            currency_type  : arg4,
            ns_balance     : v4,
            sui_balance    : v5,
            auction_ended  : false,
        };
        let v7 = 0x2::object::new(arg6);
        let v8 = 0x2::object::uid_to_inner(&v7);
        0x2::dynamic_field::add<0x2::object::ID, AuctionData>(&mut arg0.id, v8, v6);
        arg0.total_auctions = arg0.total_auctions + 1;
        arg0.active_auctions = arg0.active_auctions + 1;
        let v9 = AuctionCreated{
            auction_id      : v8,
            domain_id       : 0x2::object::id<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration>(&arg1),
            domain_name     : 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::domain_name(&arg1),
            seller          : v3,
            start_price     : arg2,
            end_time        : v2,
            expiration_time : 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::expiration_timestamp_ms(&arg1),
            currency_type   : arg4,
        };
        0x2::event::emit<AuctionCreated>(v9);
        0x2::object::delete(v7);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = @0x322e3d3e1b9a4a7488dd3a225b225b725cbd0c68caf1547aaf72087b795b6fe6;
        let v1 = AuctionRegistry{
            id              : 0x2::object::new(arg0),
            total_auctions  : 0,
            active_auctions : 0,
            admin_address   : v0,
        };
        let v2 = RegistryCreated{
            registry_id   : 0x2::object::id<AuctionRegistry>(&v1),
            admin_address : v0,
        };
        0x2::event::emit<RegistryCreated>(v2);
        0x2::transfer::share_object<AuctionRegistry>(v1);
    }

    fun place_bid_internal(arg0: &mut AuctionData, arg1: 0x2::object::ID, arg2: u64, arg3: address, arg4: &0x2::clock::Clock) : (address, u64) {
        let v0 = if (arg0.highest_bidder == arg0.seller) {
            arg0.min_bid
        } else {
            let v1 = arg0.current_bid / 20;
            if (v1 == 0) {
                arg0.current_bid + 1
            } else {
                arg0.current_bid + v1
            }
        };
        assert!(arg2 > 0, 6);
        assert!(arg2 >= v0, 9);
        assert!(0x2::clock::timestamp_ms(arg4) < arg0.end_time, 0);
        assert!(!arg0.auction_ended, 11);
        assert!(arg3 != arg0.seller, 8);
        let v2 = 0x2::clock::timestamp_ms(arg4);
        if (arg0.end_time - v2 < 300000) {
            arg0.end_time = v2 + 300000;
        };
        let v3 = BidPlaced{
            auction_id    : arg1,
            domain_name   : 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::domain_name(0x1::option::borrow<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration>(&arg0.domain)),
            bidder        : arg3,
            amount        : arg2,
            currency_type : arg0.currency_type,
        };
        0x2::event::emit<BidPlaced>(v3);
        (arg0.highest_bidder, arg0.current_bid)
    }

    public entry fun place_bid_ns(arg0: &mut AuctionRegistry, arg1: 0x2::object::ID, arg2: &mut 0x2::coin::Coin<NS>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<NS>(arg2);
        let v1 = 0x2::tx_context::sender(arg4);
        let v2 = 0x2::dynamic_field::borrow_mut<0x2::object::ID, AuctionData>(&mut arg0.id, arg1);
        assert!(v2.currency_type == 1, 8);
        let (v3, v4) = place_bid_internal(v2, arg1, v0, v1, arg3);
        let v5 = 0x1::option::borrow_mut<0x2::balance::Balance<NS>>(&mut v2.ns_balance);
        0x2::balance::join<NS>(v5, 0x2::coin::into_balance<NS>(0x2::coin::split<NS>(arg2, v0, arg4)));
        if (v3 != v2.seller) {
            0x2::transfer::public_transfer<0x2::coin::Coin<NS>>(0x2::coin::take<NS>(v5, v4, arg4), v3);
        };
        v2.current_bid = v0;
        v2.highest_bidder = v1;
    }

    public entry fun place_bid_sui(arg0: &mut AuctionRegistry, arg1: 0x2::object::ID, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(arg2);
        let v1 = 0x2::tx_context::sender(arg4);
        let v2 = 0x2::dynamic_field::borrow_mut<0x2::object::ID, AuctionData>(&mut arg0.id, arg1);
        assert!(v2.currency_type == 0, 8);
        let (v3, v4) = place_bid_internal(v2, arg1, v0, v1, arg3);
        let v5 = 0x1::option::borrow_mut<0x2::balance::Balance<0x2::sui::SUI>>(&mut v2.sui_balance);
        0x2::balance::join<0x2::sui::SUI>(v5, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(arg2, v0, arg4)));
        if (v3 != v2.seller) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(v5, v4, arg4), v3);
        };
        v2.current_bid = v0;
        v2.highest_bidder = v1;
    }

    // decompiled from Move bytecode v6
}

