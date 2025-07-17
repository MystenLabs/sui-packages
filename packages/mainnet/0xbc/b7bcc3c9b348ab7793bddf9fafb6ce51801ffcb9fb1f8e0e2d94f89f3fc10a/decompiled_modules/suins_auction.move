module 0xbcb7bcc3c9b348ab7793bddf9fafb6ce51801ffcb9fb1f8e0e2d94f89f3fc10a::suins_auction {
    struct NS has drop {
        dummy_field: bool,
    }

    struct TokenType has copy, drop, store {
        is_sui: bool,
    }

    struct AuctionData has store {
        domain: 0x1::option::Option<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration>,
        seller: address,
        highest_bidder: address,
        current_bid: u64,
        min_bid: u64,
        end_time: u64,
        coin_balance: 0x2::balance::Balance<NS>,
        auction_ended: bool,
        admin_address: address,
        token_type: TokenType,
        sui_balance: 0x2::balance::Balance<0x2::sui::SUI>,
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
        token_type: TokenType,
    }

    struct BidPlaced has copy, drop {
        auction_id: 0x2::object::ID,
        domain_name: 0x1::string::String,
        bidder: address,
        amount: u64,
        token_type: TokenType,
    }

    struct AuctionCancelled has copy, drop {
        auction_id: 0x2::object::ID,
        domain_name: 0x1::string::String,
        seller: address,
        token_type: TokenType,
    }

    struct AuctionEnded has copy, drop {
        auction_id: 0x2::object::ID,
        domain_name: 0x1::string::String,
        winner: address,
        final_price: u64,
        token_type: TokenType,
    }

    struct DomainClaimed has copy, drop {
        auction_id: 0x2::object::ID,
        domain_name: 0x1::string::String,
        winner: address,
        token_type: TokenType,
    }

    struct AuctionEndedNoBids has copy, drop {
        auction_id: 0x2::object::ID,
        domain_name: 0x1::string::String,
        seller: address,
        token_type: TokenType,
    }

    struct RegistryCreated has copy, drop {
        registry_id: 0x2::object::ID,
        admin_address: address,
    }

    public entry fun cancel_auction(arg0: &mut AuctionRegistry, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::dynamic_field::borrow_mut<0x2::object::ID, AuctionData>(&mut arg0.id, arg1);
        assert!(v0 == v1.seller, 8);
        assert!(v1.highest_bidder == v1.seller, 10);
        assert!(0x1::option::is_some<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration>(&v1.domain), 4);
        v1.auction_ended = true;
        let v2 = 0x1::option::extract<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration>(&mut v1.domain);
        0x2::transfer::public_transfer<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration>(v2, v0);
        let v3 = AuctionCancelled{
            auction_id  : arg1,
            domain_name : 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::domain_name(&v2),
            seller      : v1.seller,
            token_type  : v1.token_type,
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
            coin_balance   : v10,
            auction_ended  : _,
            admin_address  : _,
            token_type     : _,
            sui_balance    : v14,
        } = 0x2::dynamic_field::remove<0x2::object::ID, AuctionData>(&mut arg0.id, arg1);
        let v15 = v14;
        let v16 = v10;
        let v17 = v4;
        if (0x1::option::is_some<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration>(&v17)) {
            0x2::transfer::public_transfer<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration>(0x1::option::destroy_some<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration>(v17), v0);
        } else {
            0x1::option::destroy_none<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration>(v17);
        };
        assert!(0x2::balance::value<NS>(&v16) == 0, 2);
        assert!(0x2::balance::value<0x2::sui::SUI>(&v15) == 0, 2);
        0x2::balance::destroy_zero<NS>(v16);
        0x2::balance::destroy_zero<0x2::sui::SUI>(v15);
    }

    public entry fun claim_domain(arg0: &mut AuctionRegistry, arg1: 0x2::object::ID, arg2: &0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins::SuiNS, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::dynamic_field::borrow_mut<0x2::object::ID, AuctionData>(&mut arg0.id, arg1);
        assert!(0x2::clock::timestamp_ms(arg3) >= v0.end_time, 2);
        let v1 = 0x2::tx_context::sender(arg4);
        assert!(0x1::option::is_some<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration>(&v0.domain), 4);
        let v2 = v1 == v0.highest_bidder;
        let v3 = v1 == v0.seller && v0.highest_bidder == v0.seller;
        assert!(v2 || v3, 8);
        v0.auction_ended = true;
        let v4 = 0x1::option::extract<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration>(&mut v0.domain);
        let v5 = 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::domain_name(&v4);
        if (v2 && !v3) {
            let v6 = v0.current_bid;
            let v7 = v6 * 500 / 10000;
            if (is_sui_token(&v0.token_type)) {
                if (v7 > 0) {
                    0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut v0.sui_balance, v7, arg4), v0.admin_address);
                };
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut v0.sui_balance, v6 - v7, arg4), v0.seller);
            } else {
                if (v7 > 0) {
                    0x2::transfer::public_transfer<0x2::coin::Coin<NS>>(0x2::coin::take<NS>(&mut v0.coin_balance, v7, arg4), v0.admin_address);
                };
                0x2::transfer::public_transfer<0x2::coin::Coin<NS>>(0x2::coin::take<NS>(&mut v0.coin_balance, v6 - v7, arg4), v0.seller);
            };
            let v8 = AuctionEnded{
                auction_id  : arg1,
                domain_name : v5,
                winner      : v1,
                final_price : v6,
                token_type  : v0.token_type,
            };
            0x2::event::emit<AuctionEnded>(v8);
            let v9 = DomainClaimed{
                auction_id  : arg1,
                domain_name : v5,
                winner      : v1,
                token_type  : v0.token_type,
            };
            0x2::event::emit<DomainClaimed>(v9);
        } else {
            let v10 = AuctionEndedNoBids{
                auction_id  : arg1,
                domain_name : v5,
                seller      : v1,
                token_type  : v0.token_type,
            };
            0x2::event::emit<AuctionEndedNoBids>(v10);
        };
        0x2::transfer::public_transfer<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration>(v4, v1);
        arg0.active_auctions = arg0.active_auctions - 1;
        let AuctionData {
            domain         : v11,
            seller         : _,
            highest_bidder : _,
            current_bid    : _,
            min_bid        : _,
            end_time       : _,
            coin_balance   : v17,
            auction_ended  : _,
            admin_address  : _,
            token_type     : _,
            sui_balance    : v21,
        } = 0x2::dynamic_field::remove<0x2::object::ID, AuctionData>(&mut arg0.id, arg1);
        let v22 = v21;
        let v23 = v17;
        let v24 = v11;
        if (0x1::option::is_some<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration>(&v24)) {
            0x2::transfer::public_transfer<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration>(0x1::option::destroy_some<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration>(v24), arg0.admin_address);
        } else {
            0x1::option::destroy_none<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration>(v24);
        };
        assert!(0x2::balance::value<NS>(&v23) == 0, 2);
        assert!(0x2::balance::value<0x2::sui::SUI>(&v22) == 0, 2);
        0x2::balance::destroy_zero<NS>(v23);
        0x2::balance::destroy_zero<0x2::sui::SUI>(v22);
    }

    public entry fun create_auction(arg0: &mut AuctionRegistry, arg1: 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 6);
        assert!(arg3 > 0, 5);
        assert!(arg3 >= 3600000, 5);
        assert!(arg3 <= 604800000, 5);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        assert!(v0 < 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::expiration_timestamp_ms(&arg1), 7);
        let v1 = v0 + arg3;
        let v2 = 0x2::tx_context::sender(arg5);
        let v3 = AuctionData{
            domain         : 0x1::option::some<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration>(arg1),
            seller         : v2,
            highest_bidder : v2,
            current_bid    : arg2,
            min_bid        : arg2,
            end_time       : v1,
            coin_balance   : 0x2::balance::zero<NS>(),
            auction_ended  : false,
            admin_address  : arg0.admin_address,
            token_type     : token_type_ns(),
            sui_balance    : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        let v4 = 0x2::object::new(arg5);
        let v5 = 0x2::object::uid_to_inner(&v4);
        0x2::dynamic_field::add<0x2::object::ID, AuctionData>(&mut arg0.id, v5, v3);
        arg0.total_auctions = arg0.total_auctions + 1;
        arg0.active_auctions = arg0.active_auctions + 1;
        let v6 = AuctionCreated{
            auction_id      : v5,
            domain_id       : 0x2::object::id<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration>(&arg1),
            domain_name     : 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::domain_name(&arg1),
            seller          : v2,
            start_price     : arg2,
            end_time        : v1,
            expiration_time : 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::expiration_timestamp_ms(&arg1),
            token_type      : token_type_ns(),
        };
        0x2::event::emit<AuctionCreated>(v6);
        0x2::object::delete(v4);
    }

    public entry fun create_auction_sui(arg0: &mut AuctionRegistry, arg1: 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 6);
        assert!(arg3 > 0, 5);
        assert!(arg3 >= 3600000, 5);
        assert!(arg3 <= 604800000, 5);
        let v0 = 0x2::clock::timestamp_ms(arg4);
        assert!(v0 < 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::expiration_timestamp_ms(&arg1), 7);
        let v1 = v0 + arg3;
        let v2 = 0x2::tx_context::sender(arg5);
        let v3 = AuctionData{
            domain         : 0x1::option::some<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration>(arg1),
            seller         : v2,
            highest_bidder : v2,
            current_bid    : arg2,
            min_bid        : arg2,
            end_time       : v1,
            coin_balance   : 0x2::balance::zero<NS>(),
            auction_ended  : false,
            admin_address  : arg0.admin_address,
            token_type     : token_type_sui(),
            sui_balance    : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        let v4 = 0x2::object::new(arg5);
        let v5 = 0x2::object::uid_to_inner(&v4);
        0x2::dynamic_field::add<0x2::object::ID, AuctionData>(&mut arg0.id, v5, v3);
        arg0.total_auctions = arg0.total_auctions + 1;
        arg0.active_auctions = arg0.active_auctions + 1;
        let v6 = AuctionCreated{
            auction_id      : v5,
            domain_id       : 0x2::object::id<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration>(&arg1),
            domain_name     : 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::domain_name(&arg1),
            seller          : v2,
            start_price     : arg2,
            end_time        : v1,
            expiration_time : 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::expiration_timestamp_ms(&arg1),
            token_type      : token_type_sui(),
        };
        0x2::event::emit<AuctionCreated>(v6);
        0x2::object::delete(v4);
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

    public fun is_ns_token(arg0: &TokenType) : bool {
        !arg0.is_sui
    }

    public fun is_sui_token(arg0: &TokenType) : bool {
        arg0.is_sui
    }

    public entry fun place_bid(arg0: &mut AuctionRegistry, arg1: 0x2::object::ID, arg2: &mut 0x2::coin::Coin<NS>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<NS>(arg2);
        let v1 = 0x2::dynamic_field::borrow_mut<0x2::object::ID, AuctionData>(&mut arg0.id, arg1);
        assert!(is_ns_token(&v1.token_type), 11);
        assert!(v0 > 0, 6);
        assert!(v0 >= v1.current_bid + v1.current_bid * 500 / 10000, 9);
        assert!(0x2::clock::timestamp_ms(arg3) < v1.end_time, 0);
        let v2 = 0x2::tx_context::sender(arg4);
        if (v1.highest_bidder != v1.seller) {
            0x2::transfer::public_transfer<0x2::coin::Coin<NS>>(0x2::coin::take<NS>(&mut v1.coin_balance, v1.current_bid, arg4), v1.highest_bidder);
        };
        v1.current_bid = v0;
        v1.highest_bidder = v2;
        update_balance_with_coin(v1, v0, arg2, arg4);
        let v3 = 0x2::clock::timestamp_ms(arg3);
        if (v1.end_time - v3 < 300000) {
            v1.end_time = v3 + 300000;
        };
        let v4 = BidPlaced{
            auction_id  : arg1,
            domain_name : 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::domain_name(0x1::option::borrow<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration>(&v1.domain)),
            bidder      : v2,
            amount      : v0,
            token_type  : v1.token_type,
        };
        0x2::event::emit<BidPlaced>(v4);
    }

    public entry fun place_bid_sui(arg0: &mut AuctionRegistry, arg1: 0x2::object::ID, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(arg2);
        let v1 = 0x2::dynamic_field::borrow_mut<0x2::object::ID, AuctionData>(&mut arg0.id, arg1);
        assert!(is_sui_token(&v1.token_type), 11);
        assert!(v0 > 0, 6);
        assert!(v0 >= v1.current_bid + v1.current_bid * 500 / 10000, 9);
        assert!(0x2::clock::timestamp_ms(arg3) < v1.end_time, 0);
        let v2 = 0x2::tx_context::sender(arg4);
        if (v1.highest_bidder != v1.seller) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut v1.sui_balance, v1.current_bid, arg4), v1.highest_bidder);
        };
        v1.current_bid = v0;
        v1.highest_bidder = v2;
        update_balance_with_coin_sui(v1, v0, arg2, arg4);
        let v3 = 0x2::clock::timestamp_ms(arg3);
        if (v1.end_time - v3 < 300000) {
            v1.end_time = v3 + 300000;
        };
        let v4 = BidPlaced{
            auction_id  : arg1,
            domain_name : 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::domain_name(0x1::option::borrow<0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins_registration::SuinsRegistration>(&v1.domain)),
            bidder      : v2,
            amount      : v0,
            token_type  : v1.token_type,
        };
        0x2::event::emit<BidPlaced>(v4);
    }

    public fun token_type_ns() : TokenType {
        TokenType{is_sui: false}
    }

    public fun token_type_sui() : TokenType {
        TokenType{is_sui: true}
    }

    fun update_balance_with_coin(arg0: &mut AuctionData, arg1: u64, arg2: &mut 0x2::coin::Coin<NS>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = &mut arg0.coin_balance;
        0x2::balance::join<NS>(v0, 0x2::coin::into_balance<NS>(0x2::coin::split<NS>(arg2, arg1 - 0x2::balance::value<NS>(v0), arg3)));
    }

    fun update_balance_with_coin_sui(arg0: &mut AuctionData, arg1: u64, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = &mut arg0.sui_balance;
        0x2::balance::join<0x2::sui::SUI>(v0, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(arg2, arg1 - 0x2::balance::value<0x2::sui::SUI>(v0), arg3)));
    }

    // decompiled from Move bytecode v6
}

