module 0xd269c3b7ce2938849940542386940886e5a755f70cc45a6193fcc508cc52f9fa::marketplace {
    struct Marketplace has key {
        id: 0x2::object::UID,
        fee_pbs: u64,
        collateral_fee: u64,
        volume: u64,
        listed: u64,
        owner: address,
    }

    struct Listing<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        ask: u64,
        owner: address,
        offers: u64,
    }

    struct AuctionListing<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        owner: address,
        item_id: 0x2::object::ID,
        bid: 0x2::balance::Balance<T0>,
        bid_amount: u64,
        min_bid: u64,
        min_bid_increment: u64,
        starts: u64,
        expires: u64,
        bidder: address,
    }

    struct Offer<phantom T0> has store, key {
        id: 0x2::object::UID,
        paid: 0x2::coin::Coin<T0>,
        offerer: address,
    }

    struct RoyaltyCollection has store, key {
        id: 0x2::object::UID,
        total: u64,
        owner: address,
    }

    struct RoyaltyCollectionItem<phantom T0> has store, key {
        id: 0x2::object::UID,
        collection_type: 0x1::string::String,
        creator: address,
        bps: u64,
        balance: 0x2::balance::Balance<T0>,
    }

    struct ListingEvent<phantom T0, phantom T1> has copy, drop {
        item_id: 0x2::object::ID,
        amount: u64,
        seller: address,
        expires: u64,
    }

    struct DeListEvent has copy, drop {
        item_id: 0x2::object::ID,
        seller: address,
    }

    struct BuyEvent<phantom T0> has copy, drop {
        item_id: 0x2::object::ID,
        amount: u64,
        buyer: address,
        seller: address,
    }

    struct ChangePriceEvent<phantom T0> has copy, drop {
        item_id: 0x2::object::ID,
        seller: address,
        amount: u64,
    }

    public entry fun accept_offer<T0, T1: store + key>(arg0: &mut Marketplace, arg1: &mut RoyaltyCollection, arg2: 0x2::object::ID, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let Listing {
            id     : v0,
            ask    : _,
            owner  : v2,
            offers : v3,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, Listing<T0, T1>>(&mut arg0.id, arg2);
        let v4 = v0;
        assert!(0x2::tx_context::sender(arg4) == v2, 1);
        arg0.listed = arg0.listed - 1;
        let Offer {
            id      : v5,
            paid    : v6,
            offerer : v7,
        } = 0x2::dynamic_object_field::remove<u64, Offer<T0>>(&mut v4, arg3);
        let v8 = v6;
        let v9 = BuyEvent<T0>{
            item_id : arg2,
            amount  : 0x2::coin::value<T0>(&v8),
            buyer   : v7,
            seller  : v2,
        };
        0x2::event::emit<BuyEvent<T0>>(v9);
        let v10 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        let v11 = 0x1::type_name::into_string(0x1::type_name::get<0x2::sui::SUI>());
        let v12 = 0x2::coin::value<T0>(&v8);
        if (arg0.fee_pbs > 0 && v10 == v11) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v8, calculate_fees(v12, arg0.fee_pbs, arg0.collateral_fee), arg4), arg0.owner);
        };
        if (check_exists_royalty_collection<T1, T0>(arg1) && v10 == v11) {
            let v13 = &mut v8;
            take_royalty_collection<T1, T0>(arg1, v13, v12, arg4);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v8, 0x2::tx_context::sender(arg4));
        0x2::transfer::public_transfer<T1>(0x2::dynamic_object_field::remove<bool, T1>(&mut v4, true), v7);
        0x2::object::delete(v5);
        let v14 = 0;
        while (v14 < v3) {
            if (0x2::dynamic_object_field::exists_<u64>(&v4, v14)) {
                let Offer {
                    id      : v15,
                    paid    : v16,
                    offerer : v17,
                } = 0x2::dynamic_object_field::remove<u64, Offer<T0>>(&mut v4, v14);
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v16, v17);
                0x2::object::delete(v15);
            };
            v14 = v14 + 1;
        };
        0x2::object::delete(v4);
    }

    public entry fun add_royalty_collection<T0, T1>(arg0: &mut RoyaltyCollection, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg3), 1);
        let v0 = 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>()));
        let v1 = RoyaltyCollectionItem<T1>{
            id              : 0x2::object::new(arg3),
            collection_type : v0,
            creator         : arg1,
            bps             : arg2,
            balance         : 0x2::balance::zero<T1>(),
        };
        0x2::dynamic_object_field::add<0x1::string::String, RoyaltyCollectionItem<T1>>(&mut arg0.id, v0, v1);
    }

    public entry fun bid<T0, T1: store + key>(arg0: &mut Marketplace, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, AuctionListing<T0, T1>>(&mut arg0.id, arg1);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        assert!(0x2::coin::value<T0>(&arg2) >= v0.bid_amount + v0.min_bid_increment, 2024);
        assert!(v1 > v0.starts && v1 < v0.expires, 2025);
        let v2 = ChangePriceEvent<T0>{
            item_id : arg1,
            seller  : v0.owner,
            amount  : 0x2::coin::value<T0>(&arg2),
        };
        0x2::event::emit<ChangePriceEvent<T0>>(v2);
        if (0x2::balance::value<T0>(&v0.bid) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut v0.bid, v0.bid_amount, arg4), v0.bidder);
        };
        0x2::coin::put<T0>(&mut v0.bid, arg2);
        v0.bid_amount = 0x2::balance::value<T0>(&v0.bid);
        v0.bidder = 0x2::tx_context::sender(arg4);
    }

    public fun buy<T0, T1: store + key>(arg0: &mut Marketplace, arg1: &mut RoyaltyCollection, arg2: 0x2::object::ID, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) : T1 {
        let Listing {
            id     : v0,
            ask    : v1,
            owner  : v2,
            offers : v3,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, Listing<T0, T1>>(&mut arg0.id, arg2);
        let v4 = v0;
        assert!(v1 == 0x2::coin::value<T0>(&arg3), 0);
        arg0.volume = arg0.volume + 0x2::coin::value<T0>(&arg3);
        let v5 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        let v6 = 0x1::type_name::into_string(0x1::type_name::get<0x2::sui::SUI>());
        let v7 = 0x2::coin::value<T0>(&arg3);
        if (arg0.fee_pbs > 0 && v5 == v6) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg3, calculate_fees(v7, arg0.fee_pbs, arg0.collateral_fee), arg4), arg0.owner);
        };
        if (check_exists_royalty_collection<T1, T0>(arg1) && v5 == v6) {
            let v8 = &mut arg3;
            take_royalty_collection<T1, T0>(arg1, v8, v7, arg4);
        };
        arg0.listed = arg0.listed - 1;
        let v9 = BuyEvent<T0>{
            item_id : arg2,
            amount  : v7,
            buyer   : 0x2::tx_context::sender(arg4),
            seller  : v2,
        };
        0x2::event::emit<BuyEvent<T0>>(v9);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg3, v2);
        let v10 = 0;
        while (v10 < v3) {
            if (0x2::dynamic_object_field::exists_<u64>(&v4, v10)) {
                let Offer {
                    id      : v11,
                    paid    : v12,
                    offerer : v13,
                } = 0x2::dynamic_object_field::remove<u64, Offer<T0>>(&mut v4, v10);
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v12, v13);
                0x2::object::delete(v11);
            };
            v10 = v10 + 1;
        };
        0x2::object::delete(v4);
        0x2::dynamic_object_field::remove<bool, T1>(&mut v4, true)
    }

    public entry fun buy_and_take<T0, T1: store + key>(arg0: &mut Marketplace, arg1: &mut RoyaltyCollection, arg2: 0x2::object::ID, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = buy<T0, T1>(arg0, arg1, arg2, arg3, arg4);
        0x2::transfer::public_transfer<T1>(v0, 0x2::tx_context::sender(arg4));
    }

    public fun calculate_fees(arg0: u64, arg1: u64, arg2: u64) : u64 {
        0x1::fixed_point32::multiply_u64(arg0, 0x1::fixed_point32::create_from_rational(arg1, arg2))
    }

    public entry fun change_price<T0, T1: store + key>(arg0: &mut Marketplace, arg1: 0x2::object::ID, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 1);
        let v0 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, Listing<T0, T1>>(&mut arg0.id, arg1);
        let v1 = &mut v0.ask;
        assert!(0x2::tx_context::sender(arg3) == v0.owner, 1);
        *v1 = arg2;
        let v2 = ChangePriceEvent<T0>{
            item_id : arg1,
            seller  : 0x2::tx_context::sender(arg3),
            amount  : arg2,
        };
        0x2::event::emit<ChangePriceEvent<T0>>(v2);
    }

    public fun check_exists_royalty_collection<T0, T1>(arg0: &mut RoyaltyCollection) : bool {
        0x2::dynamic_object_field::exists_with_type<0x1::string::String, RoyaltyCollectionItem<T1>>(&mut arg0.id, 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>())))
    }

    public fun delist<T0, T1: store + key>(arg0: &mut Marketplace, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) : T1 {
        let Listing {
            id     : v0,
            ask    : _,
            owner  : v2,
            offers : v3,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, Listing<T0, T1>>(&mut arg0.id, arg1);
        let v4 = v0;
        assert!(0x2::tx_context::sender(arg2) == v2, 1);
        arg0.listed = arg0.listed - 1;
        let v5 = 0;
        while (v5 < v3) {
            if (0x2::dynamic_object_field::exists_<u64>(&v4, v5)) {
                let Offer {
                    id      : v6,
                    paid    : v7,
                    offerer : v8,
                } = 0x2::dynamic_object_field::remove<u64, Offer<T0>>(&mut v4, v5);
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v7, v8);
                0x2::object::delete(v6);
            };
            v5 = v5 + 1;
        };
        0x2::object::delete(v4);
        0x2::dynamic_object_field::remove<bool, T1>(&mut v4, true)
    }

    public entry fun delist_and_take<T0, T1: store + key>(arg0: &mut Marketplace, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = delist<T0, T1>(arg0, arg1, arg2);
        0x2::transfer::public_transfer<T1>(v0, 0x2::tx_context::sender(arg2));
        let v1 = DeListEvent{
            item_id : arg1,
            seller  : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<DeListEvent>(v1);
    }

    public entry fun end_auction<T0, T1: store + key>(arg0: &mut Marketplace, arg1: &mut RoyaltyCollection, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        let AuctionListing {
            id                : v0,
            owner             : v1,
            item_id           : _,
            bid               : v3,
            bid_amount        : _,
            min_bid           : _,
            min_bid_increment : _,
            starts            : _,
            expires           : _,
            bidder            : v9,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, AuctionListing<T0, T1>>(&mut arg0.id, arg2);
        let v10 = v3;
        let v11 = v0;
        arg0.listed = arg0.listed - 1;
        assert!(0x2::tx_context::sender(arg3) == v1, 1);
        let v12 = BuyEvent<T0>{
            item_id : arg2,
            amount  : 0x2::balance::value<T0>(&v10),
            buyer   : v9,
            seller  : v1,
        };
        0x2::event::emit<BuyEvent<T0>>(v12);
        let v13 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        let v14 = 0x1::type_name::into_string(0x1::type_name::get<0x2::sui::SUI>());
        let v15 = 0x2::balance::value<T0>(&v10);
        let v16 = 0x2::coin::from_balance<T0>(v10, arg3);
        if (arg0.fee_pbs > 0 && v13 == v14 && v15 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v16, calculate_fees(v15, arg0.fee_pbs, arg0.collateral_fee), arg3), arg0.owner);
        };
        if (check_exists_royalty_collection<T1, T0>(arg1) && v13 == v14 && v15 > 0) {
            let v17 = &mut v16;
            take_royalty_collection<T1, T0>(arg1, v17, v15, arg3);
        };
        if (v15 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v16, v1);
        } else {
            0x2::coin::destroy_zero<T0>(v16);
        };
        0x2::transfer::public_transfer<T1>(0x2::dynamic_object_field::remove<bool, T1>(&mut v11, true), v9);
        0x2::object::delete(v11);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Marketplace{
            id             : 0x2::object::new(arg0),
            fee_pbs        : 150,
            collateral_fee : 10000,
            volume         : 0,
            listed         : 0,
            owner          : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::share_object<Marketplace>(v0);
        let v1 = RoyaltyCollection{
            id    : 0x2::object::new(arg0),
            total : 0,
            owner : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::share_object<RoyaltyCollection>(v1);
    }

    public entry fun list<T0, T1: store + key>(arg0: &mut Marketplace, arg1: T1, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 1);
        let v0 = 0x2::object::id<T1>(&arg1);
        let v1 = Listing<T0, T1>{
            id     : 0x2::object::new(arg3),
            ask    : arg2,
            owner  : 0x2::tx_context::sender(arg3),
            offers : 0,
        };
        0x2::dynamic_object_field::add<bool, T1>(&mut v1.id, true, arg1);
        0x2::dynamic_object_field::add<0x2::object::ID, Listing<T0, T1>>(&mut arg0.id, v0, v1);
        arg0.listed = arg0.listed + 1;
        let v2 = ListingEvent<T0, T1>{
            item_id : v0,
            amount  : arg2,
            seller  : 0x2::tx_context::sender(arg3),
            expires : 0,
        };
        0x2::event::emit<ListingEvent<T0, T1>>(v2);
    }

    public entry fun listAuction<T0, T1: store + key>(arg0: &mut Marketplace, arg1: T1, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<T1>(&arg1);
        let v1 = AuctionListing<T0, T1>{
            id                : 0x2::object::new(arg6),
            owner             : 0x2::tx_context::sender(arg6),
            item_id           : v0,
            bid               : 0x2::balance::zero<T0>(),
            bid_amount        : arg2,
            min_bid           : arg2,
            min_bid_increment : arg3,
            starts            : arg4,
            expires           : arg5,
            bidder            : 0x2::tx_context::sender(arg6),
        };
        0x2::dynamic_object_field::add<bool, T1>(&mut v1.id, true, arg1);
        0x2::dynamic_object_field::add<0x2::object::ID, AuctionListing<T0, T1>>(&mut arg0.id, v0, v1);
        arg0.listed = arg0.listed + 1;
        let v2 = ListingEvent<T0, T1>{
            item_id : v0,
            amount  : arg2,
            seller  : 0x2::tx_context::sender(arg6),
            expires : arg5,
        };
        0x2::event::emit<ListingEvent<T0, T1>>(v2);
    }

    public entry fun make_offer<T0, T1: store + key>(arg0: &mut Marketplace, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = Offer<T0>{
            id      : 0x2::object::new(arg3),
            paid    : arg2,
            offerer : 0x2::tx_context::sender(arg3),
        };
        let v1 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, Listing<T0, T1>>(&mut arg0.id, arg1);
        0x2::dynamic_object_field::add<u64, Offer<T0>>(&mut v1.id, v1.offers, v0);
        v1.offers = v1.offers + 1;
    }

    public entry fun mutate_collateral_fee(arg0: &mut Marketplace, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 1);
        arg0.collateral_fee = arg1;
    }

    public entry fun mutate_fee_pbs(arg0: &mut Marketplace, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 1);
        if (arg1 < arg0.collateral_fee) {
            arg0.fee_pbs = arg1;
        };
    }

    public entry fun mutate_owner(arg0: &mut Marketplace, arg1: &mut RoyaltyCollection, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 1);
        arg0.owner = arg2;
        arg1.owner = arg2;
    }

    public entry fun remove_offer<T0, T1: store + key>(arg0: &mut Marketplace, arg1: 0x2::object::ID, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let Offer {
            id      : v0,
            paid    : v1,
            offerer : v2,
        } = 0x2::dynamic_object_field::remove<u64, Offer<T0>>(&mut 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, Listing<T0, T1>>(&mut arg0.id, arg1).id, arg2);
        assert!(0x2::tx_context::sender(arg3) == v2, 126);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, v2);
        0x2::object::delete(v0);
    }

    public fun take_royalty_collection<T0, T1>(arg0: &mut RoyaltyCollection, arg1: &mut 0x2::coin::Coin<T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::dynamic_object_field::borrow_mut<0x1::string::String, RoyaltyCollectionItem<T1>>(&mut arg0.id, 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>())));
        0x2::coin::put<T1>(&mut v0.balance, 0x2::coin::split<T1>(arg1, calculate_fees(arg2, v0.bps, 10000), arg3));
    }

    public entry fun update_royalty_collection<T0, T1>(arg0: &mut RoyaltyCollection, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::dynamic_object_field::borrow_mut<0x1::string::String, RoyaltyCollectionItem<T1>>(&mut arg0.id, 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>())));
        assert!(v0.creator == 0x2::tx_context::sender(arg3) || arg0.owner == 0x2::tx_context::sender(arg3), 1);
        assert!(arg1 <= 1000, 107);
        v0.bps = arg1;
        v0.creator = arg2;
    }

    public entry fun whithdraw_royalty_collection<T0, T1>(arg0: &mut RoyaltyCollection, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::dynamic_object_field::borrow_mut<0x1::string::String, RoyaltyCollectionItem<T1>>(&mut arg0.id, 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>())));
        assert!(v0.creator == 0x2::tx_context::sender(arg1) || arg0.owner == 0x2::tx_context::sender(arg1), 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::take<T1>(&mut v0.balance, 0x2::balance::value<T1>(&v0.balance), arg1), v0.creator);
    }

    // decompiled from Move bytecode v6
}

