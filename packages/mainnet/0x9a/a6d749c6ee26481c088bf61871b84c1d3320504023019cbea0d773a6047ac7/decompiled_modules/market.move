module 0x9aa6d749c6ee26481c088bf61871b84c1d3320504023019cbea0d773a6047ac7::market {
    struct MARKET has drop {
        dummy_field: bool,
    }

    struct Listing has store, key {
        id: 0x2::object::UID,
        price: u64,
        seller: address,
    }

    struct Collection<phantom T0: store + key, phantom T1> has store, key {
        id: 0x2::object::UID,
    }

    struct RoyaltyCollection has key {
        id: 0x2::object::UID,
    }

    struct CollectionRoyaltyStrategy<phantom T0: store + key, phantom T1> has store, key {
        id: 0x2::object::UID,
        beneficiary: address,
        balance: 0x2::coin::Coin<T1>,
        bps: u64,
    }

    struct Marketplace<phantom T0> has key {
        id: 0x2::object::UID,
        version: u64,
        balance: 0x2::coin::Coin<T0>,
        fee: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public entry fun add_collection_royalty<T0: store + key, T1>(arg0: &mut RoyaltyCollection, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 < 10000, 2);
        let v0 = CollectionRoyaltyStrategy<T0, T1>{
            id          : 0x2::object::new(arg3),
            beneficiary : arg1,
            balance     : 0x2::coin::zero<T1>(arg3),
            bps         : arg2,
        };
        0x2::dynamic_object_field::add<0x1::ascii::String, CollectionRoyaltyStrategy<T0, T1>>(&mut arg0.id, 0x1::type_name::into_string(0x1::type_name::get<T0>()), v0);
    }

    public entry fun adjust_price<T0: store + key, T1>(arg0: &mut Marketplace<T1>, arg1: 0x2::object::ID, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        let v1 = 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, Collection<T0, T1>>(&mut arg0.id, v0);
        let v2 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, Listing>(&mut v1.id, arg1);
        assert!(v2.seller == 0x2::tx_context::sender(arg3), 0x9aa6d749c6ee26481c088bf61871b84c1d3320504023019cbea0d773a6047ac7::err_code::not_auth_operator());
        v2.price = arg2;
        0x9aa6d749c6ee26481c088bf61871b84c1d3320504023019cbea0d773a6047ac7::market_event::item_adjust_price_event(0x2::object::id<Collection<T0, T1>>(v1), arg1, 0x2::tx_context::sender(arg3), v0, 0x1::type_name::into_string(0x1::type_name::get<T1>()), arg2);
    }

    public fun batch_list<T0: store + key, T1>(arg0: &mut Marketplace<T1>, arg1: vector<T0>, arg2: vector<u64>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<T0>(&arg1)) {
            list<T0, T1>(arg0, 0x1::vector::pop_back<T0>(&mut arg1), 0x1::vector::pop_back<u64>(&mut arg2), arg3);
            v0 = v0 + 1;
        };
        0x1::vector::destroy_empty<T0>(arg1);
    }

    public entry fun buy_and_take_script<T0: store + key, T1>(arg0: &mut Marketplace<T1>, arg1: &mut RoyaltyCollection, arg2: 0x2::object::ID, arg3: &mut 0x2::coin::Coin<T1>, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<T0>(buy_script<T0, T1>(arg0, arg1, arg2, arg3, arg5), arg4);
    }

    public entry fun buy_multi_item_script<T0: store + key, T1>(arg0: &mut Marketplace<T1>, arg1: &mut RoyaltyCollection, arg2: vector<0x2::object::ID>, arg3: 0x2::coin::Coin<T1>, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        while (0x1::vector::length<0x2::object::ID>(&arg2) != 0) {
            let v0 = &mut arg3;
            buy_and_take_script<T0, T1>(arg0, arg1, 0x1::vector::pop_back<0x2::object::ID>(&mut arg2), v0, arg4, arg5);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg3, 0x2::tx_context::sender(arg5));
    }

    public fun buy_script<T0: store + key, T1>(arg0: &mut Marketplace<T1>, arg1: &mut RoyaltyCollection, arg2: 0x2::object::ID, arg3: &mut 0x2::coin::Coin<T1>, arg4: &mut 0x2::tx_context::TxContext) : T0 {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        let v1 = 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, Collection<T0, T1>>(&mut arg0.id, v0);
        assert!(arg0.version == 1, 1);
        let Listing {
            id     : v2,
            price  : v3,
            seller : v4,
        } = 0x2::dynamic_object_field::remove<0x2::object::ID, Listing>(&mut v1.id, arg2);
        let v5 = v2;
        assert!(0x2::coin::value<T1>(arg3) >= v3, 0x9aa6d749c6ee26481c088bf61871b84c1d3320504023019cbea0d773a6047ac7::err_code::err_input_amount());
        let v6 = v3 * arg0.fee / 10000;
        let v7 = 0;
        if (0x2::dynamic_object_field::exists_<0x1::ascii::String>(&arg1.id, v0)) {
            let v8 = 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, CollectionRoyaltyStrategy<T0, T1>>(&mut arg1.id, v0);
            let v9 = v3 * v8.bps / 10000;
            v7 = v9;
            0x2::coin::join<T1>(&mut v8.balance, 0x2::coin::split<T1>(arg3, v9, arg4));
        };
        let v10 = v3 - v6 - v7;
        assert!(v10 > 0, 0x9aa6d749c6ee26481c088bf61871b84c1d3320504023019cbea0d773a6047ac7::err_code::err_amount_is_zero());
        0x2::pay::split_and_transfer<T1>(arg3, v10, v4, arg4);
        0x2::coin::join<T1>(&mut arg0.balance, 0x2::coin::split<T1>(arg3, v6, arg4));
        0x9aa6d749c6ee26481c088bf61871b84c1d3320504023019cbea0d773a6047ac7::market_event::item_buy_event(0x2::object::id<Collection<T0, T1>>(v1), arg2, v4, 0x2::tx_context::sender(arg4), v0, 0x1::type_name::into_string(0x1::type_name::get<T1>()), v3);
        0x2::object::delete(v5);
        0x2::dynamic_object_field::remove<0x2::object::ID, T0>(&mut v5, arg2)
    }

    public entry fun change_admin(arg0: AdminCap, arg1: address) {
        0x2::transfer::public_transfer<AdminCap>(arg0, arg1);
    }

    public entry fun collect_profit_collection<T0: store + key, T1>(arg0: &mut RoyaltyCollection, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        let v1 = 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, CollectionRoyaltyStrategy<T0, T1>>(&mut arg0.id, v0);
        assert!(0x2::tx_context::sender(arg2) == v1.beneficiary, 0x9aa6d749c6ee26481c088bf61871b84c1d3320504023019cbea0d773a6047ac7::err_code::not_auth_operator());
        let v2 = 0x2::coin::value<T1>(&mut v1.balance);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::split<T1>(&mut v1.balance, v2, arg2), arg1);
        0x9aa6d749c6ee26481c088bf61871b84c1d3320504023019cbea0d773a6047ac7::market_event::collection_withdrawal(0x2::object::id<RoyaltyCollection>(arg0), 0x2::tx_context::sender(arg2), arg1, v0, 0x1::type_name::into_string(0x1::type_name::get<T1>()), v2);
    }

    public entry fun collect_profits<T0>(arg0: &AdminCap, arg1: &mut Marketplace<T0>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 1, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg1.balance, 0x2::coin::value<T0>(&mut arg1.balance), arg3), arg2);
    }

    public entry fun createMarket<T0>(arg0: &0x2::package::Publisher, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Marketplace<0x2::sui::SUI>{
            id      : 0x2::object::new(arg2),
            version : 1,
            balance : 0x2::coin::zero<0x2::sui::SUI>(arg2),
            fee     : arg1,
        };
        let v1 = RoyaltyCollection{id: 0x2::object::new(arg2)};
        0x9aa6d749c6ee26481c088bf61871b84c1d3320504023019cbea0d773a6047ac7::market_event::market_created_event(0x2::object::id<Marketplace<0x2::sui::SUI>>(&v0), 0x2::object::id<RoyaltyCollection>(&v1), 0x2::tx_context::sender(arg2));
        0x2::transfer::share_object<Marketplace<0x2::sui::SUI>>(v0);
        0x2::transfer::share_object<RoyaltyCollection>(v1);
    }

    public fun delist<T0: store + key, T1>(arg0: &mut Marketplace<T1>, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) : T0 {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        let v1 = 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, Collection<T0, T1>>(&mut arg0.id, v0);
        let v2 = 0x2::dynamic_object_field::remove<0x2::object::ID, Listing>(&mut v1.id, arg1);
        let Listing {
            id     : v3,
            price  : v4,
            seller : v5,
        } = v2;
        let v6 = v3;
        assert!(0x2::tx_context::sender(arg2) == v5, 0x9aa6d749c6ee26481c088bf61871b84c1d3320504023019cbea0d773a6047ac7::err_code::not_auth_operator());
        0x9aa6d749c6ee26481c088bf61871b84c1d3320504023019cbea0d773a6047ac7::market_event::item_delisted_event(0x2::object::id<Collection<T0, T1>>(v1), arg1, 0x2::object::id<Listing>(&v2), 0x2::tx_context::sender(arg2), v0, 0x1::type_name::into_string(0x1::type_name::get<T1>()), v4);
        0x2::object::delete(v6);
        0x2::dynamic_object_field::remove<0x2::object::ID, T0>(&mut v6, arg1)
    }

    public entry fun delist_take<T0: store + key, T1>(arg0: &mut Marketplace<T1>, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = delist<T0, T1>(arg0, arg1, arg2);
        0x2::transfer::public_transfer<T0>(v0, 0x2::tx_context::sender(arg2));
    }

    public entry fun delist_take_receiver<T0: store + key, T1>(arg0: &mut Marketplace<T1>, arg1: 0x2::object::ID, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<T0>(delist<T0, T1>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: MARKET, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Marketplace<0x2::sui::SUI>{
            id      : 0x2::object::new(arg1),
            version : 1,
            balance : 0x2::coin::zero<0x2::sui::SUI>(arg1),
            fee     : 150,
        };
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<MARKET>(arg0, arg1), 0x2::tx_context::sender(arg1));
        let v1 = RoyaltyCollection{id: 0x2::object::new(arg1)};
        0x9aa6d749c6ee26481c088bf61871b84c1d3320504023019cbea0d773a6047ac7::market_event::market_created_event(0x2::object::id<Marketplace<0x2::sui::SUI>>(&v0), 0x2::object::id<RoyaltyCollection>(&v1), 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<Marketplace<0x2::sui::SUI>>(v0);
        0x2::transfer::share_object<RoyaltyCollection>(v1);
        let v2 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v2, 0x2::tx_context::sender(arg1));
    }

    public entry fun list<T0: store + key, T1>(arg0: &mut Marketplace<T1>, arg1: T0, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<T0>(&arg1);
        let v1 = Listing{
            id     : 0x2::object::new(arg3),
            price  : arg2,
            seller : 0x2::tx_context::sender(arg3),
        };
        let v2 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        let v3 = false;
        if (!0x2::dynamic_object_field::exists_<0x1::ascii::String>(&arg0.id, v2)) {
            let v4 = Collection<T0, T1>{id: 0x2::object::new(arg3)};
            0x2::dynamic_object_field::add<0x1::ascii::String, Collection<T0, T1>>(&mut arg0.id, v2, v4);
            v3 = true;
        };
        let v5 = 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, Collection<T0, T1>>(&mut arg0.id, v2);
        0x2::dynamic_object_field::add<0x2::object::ID, T0>(&mut v1.id, v0, arg1);
        0x2::dynamic_object_field::add<0x2::object::ID, Listing>(&mut v5.id, v0, v1);
        0x9aa6d749c6ee26481c088bf61871b84c1d3320504023019cbea0d773a6047ac7::market_event::item_list_event(0x2::object::id<Collection<T0, T1>>(v5), v0, 0x2::object::id<Listing>(&v1), 0x2::tx_context::sender(arg3), arg2, v2, 0x1::type_name::into_string(0x1::type_name::get<T1>()), v3);
    }

    public entry fun update_collection_royalty<T0: store + key, T1>(arg0: &mut RoyaltyCollection, arg1: address, arg2: u64) {
        assert!(arg2 < 10000, 2);
        let v0 = 0x2::dynamic_object_field::borrow_mut<0x1::ascii::String, CollectionRoyaltyStrategy<T0, T1>>(&mut arg0.id, 0x1::type_name::into_string(0x1::type_name::get<T0>()));
        v0.bps = arg2;
        v0.beneficiary = arg1;
    }

    public entry fun update_market_fee<T0>(arg0: &AdminCap, arg1: &mut Marketplace<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 1, 1);
        arg1.fee = arg2;
    }

    // decompiled from Move bytecode v6
}

