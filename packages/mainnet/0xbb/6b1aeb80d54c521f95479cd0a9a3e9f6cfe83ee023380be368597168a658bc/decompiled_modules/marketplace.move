module 0xd1371aef1c556cbd9b41c9e01c0cf03b2e09668b18f402585af049cde00049bb::marketplace {
    struct OrderbookConfig has store {
        commission_bps: u64,
        commission_beneficiary: address,
        royalty_bps: u64,
        shares: vector<Share>,
    }

    struct Orderbook<phantom T0: store + key, phantom T1> has store, key {
        id: 0x2::object::UID,
        config: OrderbookConfig,
        asks: 0xd1371aef1c556cbd9b41c9e01c0cf03b2e09668b18f402585af049cde00049bb::crit_bit::CritbitTree<vector<Ask<T0>>>,
        bids: 0xd1371aef1c556cbd9b41c9e01c0cf03b2e09668b18f402585af049cde00049bb::crit_bit::CritbitTree<vector<Bid<T1>>>,
        VERSION: u64,
    }

    struct Share has drop, store {
        creator: address,
        share: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Ask<phantom T0> has store {
        id: 0x2::object::UID,
        price: u64,
        nft_id: 0x2::object::ID,
        seller: address,
    }

    struct Bid<phantom T0> has store {
        offer: 0x2::balance::Balance<T0>,
        buyer: address,
    }

    struct OrderbookCreatedEvent has copy, drop {
        orderbook: 0x2::object::ID,
        nft_type: 0x1::ascii::String,
        ft_type: 0x1::ascii::String,
    }

    struct AskCreatedEvent has copy, drop {
        nft: 0x2::object::ID,
        orderbook: 0x2::object::ID,
        owner: address,
        price: u64,
        nft_type: 0x1::ascii::String,
        ft_type: 0x1::ascii::String,
    }

    struct AskClosedEvent has copy, drop {
        nft: 0x2::object::ID,
        orderbook: 0x2::object::ID,
        owner: address,
        price: u64,
        nft_type: 0x1::ascii::String,
        ft_type: 0x1::ascii::String,
    }

    struct BidCreatedEvent has copy, drop {
        orderbook: 0x2::object::ID,
        owner: address,
        price: u64,
        nft_type: 0x1::ascii::String,
        ft_type: 0x1::ascii::String,
    }

    struct BidClosedEvent has copy, drop {
        orderbook: 0x2::object::ID,
        owner: address,
        price: u64,
        nft_type: 0x1::ascii::String,
        ft_type: 0x1::ascii::String,
    }

    struct TradeFilledEvent has copy, drop {
        buyer: address,
        nft: 0x2::object::ID,
        orderbook: 0x2::object::ID,
        price: u64,
        seller: address,
        nft_type: 0x1::ascii::String,
        ft_type: 0x1::ascii::String,
    }

    struct MARKETPLACE has drop {
        dummy_field: bool,
    }

    public entry fun buy_nft<T0: store + key, T1>(arg0: &mut Orderbook<T0, T1>, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<T1>, arg3: &mut 0x2::tx_context::TxContext) {
        verifiy_orderbook_version<T0, T1>(arg0);
        let v0 = &mut arg0.asks;
        let v1 = remove_ask<T0>(v0, 0x2::coin::value<T1>(&arg2), arg1);
        let v2 = Bid<T1>{
            offer : 0x2::coin::into_balance<T1>(arg2),
            buyer : 0x2::tx_context::sender(arg3),
        };
        assert!(v1.seller != v2.buyer, 9);
        match_bid_ask<T0, T1>(v2, v1, 0x2::object::id<Orderbook<T0, T1>>(arg0), &arg0.config, arg3);
    }

    public entry fun cancel_ask<T0: store + key, T1>(arg0: &mut Orderbook<T0, T1>, arg1: 0x2::object::ID, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        verifiy_orderbook_version<T0, T1>(arg0);
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = &mut arg0.asks;
        let v2 = remove_ask<T0>(v1, arg2, arg1);
        let Ask {
            id     : v3,
            price  : _,
            nft_id : _,
            seller : v6,
        } = v2;
        0x2::object::delete(v3);
        assert!(v6 == v0, 6);
        let v7 = AskClosedEvent{
            nft       : arg1,
            orderbook : 0x2::object::id<Orderbook<T0, T1>>(arg0),
            owner     : 0x2::tx_context::sender(arg3),
            price     : arg2,
            nft_type  : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            ft_type   : 0x1::type_name::into_string(0x1::type_name::get<T1>()),
        };
        0x2::event::emit<AskClosedEvent>(v7);
        0x2::transfer::public_transfer<T0>(0x2::dynamic_object_field::remove<0x1::ascii::String, T0>(&mut v2.id, nft_key()), v0);
    }

    public entry fun cancel_bid<T0: store + key, T1>(arg0: &mut Orderbook<T0, T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        verifiy_orderbook_version<T0, T1>(arg0);
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = &mut arg0.bids;
        let Bid {
            offer : v2,
            buyer : v3,
        } = remove_bid<T1>(v1, arg1, v0);
        assert!(v3 == v0, 6);
        let v4 = BidClosedEvent{
            orderbook : 0x2::object::id<Orderbook<T0, T1>>(arg0),
            owner     : 0x2::tx_context::sender(arg2),
            price     : arg1,
            nft_type  : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            ft_type   : 0x1::type_name::into_string(0x1::type_name::get<T1>()),
        };
        0x2::event::emit<BidClosedEvent>(v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v2, arg2), v0);
    }

    fun convert_to_shares(arg0: vector<address>, arg1: vector<u64>) : vector<Share> {
        let v0 = 0x1::vector::empty<Share>();
        let v1 = 0;
        assert!(0x1::vector::length<address>(&arg0) == 0x1::vector::length<u64>(&arg1), 2);
        while (0x1::vector::length<u64>(&arg1) > 0) {
            let v2 = 0x1::vector::pop_back<u64>(&mut arg1);
            let v3 = Share{
                creator : 0x1::vector::pop_back<address>(&mut arg0),
                share   : v2,
            };
            0x1::vector::push_back<Share>(&mut v0, v3);
            v1 = v1 + v2;
        };
        assert!(v1 == 10000, 1);
        v0
    }

    public entry fun create_ask<T0: store + key, T1>(arg0: &mut Orderbook<T0, T1>, arg1: T0, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        verifiy_orderbook_version<T0, T1>(arg0);
        let v0 = 0x2::object::id<T0>(&arg1);
        let v1 = Ask<T0>{
            id     : 0x2::object::new(arg3),
            price  : arg2,
            nft_id : v0,
            seller : 0x2::tx_context::sender(arg3),
        };
        0x2::dynamic_object_field::add<0x1::ascii::String, T0>(&mut v1.id, nft_key(), arg1);
        let (v2, v3) = if (0xd1371aef1c556cbd9b41c9e01c0cf03b2e09668b18f402585af049cde00049bb::crit_bit::is_empty<vector<Bid<T1>>>(&arg0.bids)) {
            (false, 0)
        } else {
            let (v4, _) = 0xd1371aef1c556cbd9b41c9e01c0cf03b2e09668b18f402585af049cde00049bb::crit_bit::max_leaf<vector<Bid<T1>>>(&arg0.bids);
            (v4 >= arg2, v4)
        };
        if (v2) {
            let v6 = 0xd1371aef1c556cbd9b41c9e01c0cf03b2e09668b18f402585af049cde00049bb::crit_bit::borrow_mut_leaf_by_key<vector<Bid<T1>>>(&mut arg0.bids, v3);
            match_bid_ask<T0, T1>(0x1::vector::remove<Bid<T1>>(v6, 0), v1, 0x2::object::id<Orderbook<T0, T1>>(arg0), &arg0.config, arg3);
            if (0x1::vector::length<Bid<T1>>(v6) == 0) {
                0x1::vector::destroy_empty<Bid<T1>>(0xd1371aef1c556cbd9b41c9e01c0cf03b2e09668b18f402585af049cde00049bb::crit_bit::remove_leaf_by_key<vector<Bid<T1>>>(&mut arg0.bids, v3));
            };
        } else {
            let (v7, _) = 0xd1371aef1c556cbd9b41c9e01c0cf03b2e09668b18f402585af049cde00049bb::crit_bit::find_leaf<vector<Ask<T0>>>(&arg0.asks, arg2);
            if (v7) {
                0x1::vector::push_back<Ask<T0>>(0xd1371aef1c556cbd9b41c9e01c0cf03b2e09668b18f402585af049cde00049bb::crit_bit::borrow_mut_leaf_by_key<vector<Ask<T0>>>(&mut arg0.asks, arg2), v1);
            } else {
                0xd1371aef1c556cbd9b41c9e01c0cf03b2e09668b18f402585af049cde00049bb::crit_bit::insert_leaf<vector<Ask<T0>>>(&mut arg0.asks, arg2, 0x1::vector::singleton<Ask<T0>>(v1));
            };
            let v9 = AskCreatedEvent{
                nft       : v0,
                orderbook : 0x2::object::id<Orderbook<T0, T1>>(arg0),
                owner     : 0x2::tx_context::sender(arg3),
                price     : arg2,
                nft_type  : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
                ft_type   : 0x1::type_name::into_string(0x1::type_name::get<T1>()),
            };
            0x2::event::emit<AskCreatedEvent>(v9);
        };
    }

    public entry fun create_bid<T0: store + key, T1>(arg0: &mut Orderbook<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: &mut 0x2::tx_context::TxContext) {
        verifiy_orderbook_version<T0, T1>(arg0);
        let v0 = 0x2::coin::value<T1>(&arg1);
        let v1 = Bid<T1>{
            offer : 0x2::coin::into_balance<T1>(arg1),
            buyer : 0x2::tx_context::sender(arg2),
        };
        let (v2, v3) = if (0xd1371aef1c556cbd9b41c9e01c0cf03b2e09668b18f402585af049cde00049bb::crit_bit::is_empty<vector<Ask<T0>>>(&arg0.asks)) {
            (false, 0)
        } else {
            let (v4, _) = 0xd1371aef1c556cbd9b41c9e01c0cf03b2e09668b18f402585af049cde00049bb::crit_bit::min_leaf<vector<Ask<T0>>>(&arg0.asks);
            (v4 <= v0, v4)
        };
        if (v2) {
            let v6 = 0xd1371aef1c556cbd9b41c9e01c0cf03b2e09668b18f402585af049cde00049bb::crit_bit::borrow_mut_leaf_by_key<vector<Ask<T0>>>(&mut arg0.asks, v3);
            match_bid_ask<T0, T1>(v1, 0x1::vector::remove<Ask<T0>>(v6, 0), 0x2::object::id<Orderbook<T0, T1>>(arg0), &arg0.config, arg2);
            if (0x1::vector::length<Ask<T0>>(v6) == 0) {
                0x1::vector::destroy_empty<Ask<T0>>(0xd1371aef1c556cbd9b41c9e01c0cf03b2e09668b18f402585af049cde00049bb::crit_bit::remove_leaf_by_key<vector<Ask<T0>>>(&mut arg0.asks, v3));
            };
        } else {
            let (v7, _) = 0xd1371aef1c556cbd9b41c9e01c0cf03b2e09668b18f402585af049cde00049bb::crit_bit::find_leaf<vector<Bid<T1>>>(&arg0.bids, v0);
            if (v7) {
                0x1::vector::push_back<Bid<T1>>(0xd1371aef1c556cbd9b41c9e01c0cf03b2e09668b18f402585af049cde00049bb::crit_bit::borrow_mut_leaf_by_key<vector<Bid<T1>>>(&mut arg0.bids, v0), v1);
            } else {
                0xd1371aef1c556cbd9b41c9e01c0cf03b2e09668b18f402585af049cde00049bb::crit_bit::insert_leaf<vector<Bid<T1>>>(&mut arg0.bids, v0, 0x1::vector::singleton<Bid<T1>>(v1));
            };
            let v9 = BidCreatedEvent{
                orderbook : 0x2::object::id<Orderbook<T0, T1>>(arg0),
                owner     : 0x2::tx_context::sender(arg2),
                price     : v0,
                nft_type  : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
                ft_type   : 0x1::type_name::into_string(0x1::type_name::get<T1>()),
            };
            0x2::event::emit<BidCreatedEvent>(v9);
        };
    }

    public entry fun create_orderbook<T0: store + key, T1>(arg0: &mut AdminCap, arg1: u64, arg2: u64, arg3: vector<address>, arg4: vector<u64>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 + arg2 < 10000, 8);
        let v0 = OrderbookConfig{
            commission_bps         : arg1,
            commission_beneficiary : @0x5c370ee41d19373b7f2cc35b36c6dd569531f022f9c9c6a63e557e6c5b16b94d,
            royalty_bps            : arg2,
            shares                 : convert_to_shares(arg3, arg4),
        };
        let v1 = Orderbook<T0, T1>{
            id      : 0x2::object::new(arg5),
            config  : v0,
            asks    : 0xd1371aef1c556cbd9b41c9e01c0cf03b2e09668b18f402585af049cde00049bb::crit_bit::new<vector<Ask<T0>>>(arg5),
            bids    : 0xd1371aef1c556cbd9b41c9e01c0cf03b2e09668b18f402585af049cde00049bb::crit_bit::new<vector<Bid<T1>>>(arg5),
            VERSION : 1,
        };
        let v2 = OrderbookCreatedEvent{
            orderbook : 0x2::object::uid_to_inner(&v1.id),
            nft_type  : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            ft_type   : 0x1::type_name::into_string(0x1::type_name::get<T1>()),
        };
        0x2::event::emit<OrderbookCreatedEvent>(v2);
        0x2::transfer::share_object<Orderbook<T0, T1>>(v1);
    }

    fun distribute_royalty<T0>(arg0: 0x2::balance::Balance<T0>, arg1: &OrderbookConfig, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Share>(&arg1.shares)) {
            let v1 = 0x1::vector::borrow<Share>(&arg1.shares, v0);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0, 0x2::balance::value<T0>(&arg0) * v1.share / 10000), arg2), v1.creator);
            v0 = v0 + 1;
        };
        0x2::balance::destroy_zero<T0>(arg0);
    }

    public entry fun grant_admin(arg0: &mut AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg2)};
        0x2::transfer::transfer<AdminCap>(v0, arg1);
    }

    fun init(arg0: MARKETPLACE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<MARKETPLACE>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    fun match_bid_ask<T0: store + key, T1>(arg0: Bid<T1>, arg1: Ask<T0>, arg2: 0x2::object::ID, arg3: &OrderbookConfig, arg4: &mut 0x2::tx_context::TxContext) {
        let Bid {
            offer : v0,
            buyer : v1,
        } = arg0;
        let v2 = v0;
        let Ask {
            id     : v3,
            price  : v4,
            nft_id : v5,
            seller : v6,
        } = arg1;
        0x2::object::delete(v3);
        assert!(0x2::balance::value<T1>(&v2) >= v4, 3);
        let v7 = v4 * arg3.commission_bps / 10000;
        let v8 = v4 * arg3.royalty_bps / 10000;
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v2, v7), arg4), arg3.commission_beneficiary);
        distribute_royalty<T1>(0x2::balance::split<T1>(&mut v2, v8), arg3, arg4);
        0x2::transfer::public_transfer<T0>(0x2::dynamic_object_field::remove<0x1::ascii::String, T0>(&mut arg1.id, nft_key()), v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v2, v4 - v7 - v8), arg4), v6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v2, arg4), v1);
        let v9 = TradeFilledEvent{
            buyer     : v1,
            nft       : v5,
            orderbook : arg2,
            price     : v4,
            seller    : v6,
            nft_type  : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            ft_type   : 0x1::type_name::into_string(0x1::type_name::get<T1>()),
        };
        0x2::event::emit<TradeFilledEvent>(v9);
    }

    fun nft_key() : 0x1::ascii::String {
        0x1::ascii::string(b"nft")
    }

    fun remove_ask<T0: store + key>(arg0: &mut 0xd1371aef1c556cbd9b41c9e01c0cf03b2e09668b18f402585af049cde00049bb::crit_bit::CritbitTree<vector<Ask<T0>>>, arg1: u64, arg2: 0x2::object::ID) : Ask<T0> {
        let (v0, _) = 0xd1371aef1c556cbd9b41c9e01c0cf03b2e09668b18f402585af049cde00049bb::crit_bit::find_leaf<vector<Ask<T0>>>(arg0, arg1);
        assert!(v0, 4);
        let v2 = 0xd1371aef1c556cbd9b41c9e01c0cf03b2e09668b18f402585af049cde00049bb::crit_bit::borrow_mut_leaf_by_key<vector<Ask<T0>>>(arg0, arg1);
        let v3 = 0;
        let v4 = 0x1::vector::length<Ask<T0>>(v2);
        while (v4 > v3) {
            if (arg2 == 0x1::vector::borrow<Ask<T0>>(v2, v3).nft_id) {
                break
            };
            v3 = v3 + 1;
        };
        assert!(v3 < v4, 4);
        if (0x1::vector::length<Ask<T0>>(v2) == 0) {
            0x1::vector::destroy_empty<Ask<T0>>(0xd1371aef1c556cbd9b41c9e01c0cf03b2e09668b18f402585af049cde00049bb::crit_bit::remove_leaf_by_key<vector<Ask<T0>>>(arg0, arg1));
        };
        0x1::vector::remove<Ask<T0>>(v2, v3)
    }

    fun remove_bid<T0>(arg0: &mut 0xd1371aef1c556cbd9b41c9e01c0cf03b2e09668b18f402585af049cde00049bb::crit_bit::CritbitTree<vector<Bid<T0>>>, arg1: u64, arg2: address) : Bid<T0> {
        let (v0, _) = 0xd1371aef1c556cbd9b41c9e01c0cf03b2e09668b18f402585af049cde00049bb::crit_bit::find_leaf<vector<Bid<T0>>>(arg0, arg1);
        assert!(v0, 5);
        let v2 = 0xd1371aef1c556cbd9b41c9e01c0cf03b2e09668b18f402585af049cde00049bb::crit_bit::borrow_mut_leaf_by_key<vector<Bid<T0>>>(arg0, arg1);
        let v3 = 0;
        let v4 = 0x1::vector::length<Bid<T0>>(v2);
        while (v4 > v3) {
            if (arg2 == 0x1::vector::borrow<Bid<T0>>(v2, v3).buyer) {
                break
            };
            v3 = v3 + 1;
        };
        assert!(v3 < v4, 5);
        if (0x1::vector::length<Bid<T0>>(v2) == 0) {
            0x1::vector::destroy_empty<Bid<T0>>(0xd1371aef1c556cbd9b41c9e01c0cf03b2e09668b18f402585af049cde00049bb::crit_bit::remove_leaf_by_key<vector<Bid<T0>>>(arg0, arg1));
        };
        0x1::vector::remove<Bid<T0>>(v2, v3)
    }

    public entry fun update_orderbook<T0: store + key, T1>(arg0: &mut AdminCap, arg1: &mut Orderbook<T0, T1>, arg2: u64, arg3: address, arg4: u64, arg5: vector<address>, arg6: vector<u64>, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 + arg4 < 10000, 8);
        verifiy_orderbook_version<T0, T1>(arg1);
        arg1.config.commission_bps = arg2;
        arg1.config.royalty_bps = arg4;
        arg1.config.commission_beneficiary = arg3;
        arg1.config.shares = convert_to_shares(arg5, arg6);
    }

    fun verifiy_orderbook_version<T0: store + key, T1>(arg0: &Orderbook<T0, T1>) {
        assert!(arg0.VERSION == 1, 7);
    }

    // decompiled from Move bytecode v6
}

