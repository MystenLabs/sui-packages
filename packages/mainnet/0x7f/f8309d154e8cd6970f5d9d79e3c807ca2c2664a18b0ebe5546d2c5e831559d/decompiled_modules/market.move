module 0x7ff8309d154e8cd6970f5d9d79e3c807ca2c2664a18b0ebe5546d2c5e831559d::market {
    struct MarketOwnerCap has store, key {
        id: 0x2::object::UID,
    }

    struct CollectionMarket<T0: store + key, phantom T1> has key {
        id: 0x2::object::UID,
        next_index: u64,
        fee: 0x2::balance::Balance<T1>,
        royalty: u32,
        royalty_receiver: address,
        royalty_vault: 0x2::balance::Balance<T1>,
        items: 0x2::object_table::ObjectTable<u64, Listing<T0, T1>>,
    }

    struct Listing<T0: store + key, phantom T1> has store, key {
        id: 0x2::object::UID,
        item: T0,
        price: u64,
        owner: address,
    }

    struct MarketCreated<phantom T0, phantom T1> has copy, drop {
        market_id: 0x2::object::ID,
        object: 0x1::ascii::String,
        coin: 0x1::ascii::String,
        royalty: u32,
        royalty_receiver: address,
    }

    struct ItemListed has copy, drop {
        index: u64,
        item_id: 0x2::object::ID,
        internal_id: 0x2::object::ID,
        market_id: 0x2::object::ID,
        price: u64,
        owner: address,
    }

    struct ItemDelisted<phantom T0> has copy, drop {
        index: u64,
        item_id: 0x2::object::ID,
        coin: 0x1::ascii::String,
    }

    struct ItemPurchased<phantom T0> has copy, drop {
        index: u64,
        item_id: 0x2::object::ID,
        new_owner: address,
        royalty_amount: u64,
        coin: 0x1::ascii::String,
    }

    public entry fun create_market<T0: store + key, T1>(arg0: &MarketOwnerCap, arg1: address, arg2: u32, arg3: &mut 0x2::tx_context::TxContext) {
        publish_market<T0, T1>(arg1, arg2, arg3);
    }

    public fun delist<T0: store + key, T1>(arg0: &mut CollectionMarket<T0, T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : T0 {
        let Listing {
            id    : v0,
            item  : v1,
            price : _,
            owner : v3,
        } = 0x2::object_table::remove<u64, Listing<T0, T1>>(&mut arg0.items, arg1);
        let v4 = v1;
        assert!(0x2::tx_context::sender(arg2) == v3, 1);
        let v5 = ItemDelisted<T1>{
            index   : arg1,
            item_id : 0x2::object::id<T0>(&v4),
            coin    : 0x1::type_name::into_string(0x1::type_name::get<T1>()),
        };
        0x2::event::emit<ItemDelisted<T1>>(v5);
        0x2::object::delete(v0);
        v4
    }

    public entry fun delist_and_take<T0: store + key, T1>(arg0: &mut CollectionMarket<T0, T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = delist<T0, T1>(arg0, arg1, arg2);
        0x2::transfer::public_transfer<T0>(v0, 0x2::tx_context::sender(arg2));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MarketOwnerCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<MarketOwnerCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun list<T0: store + key, T1>(arg0: &mut CollectionMarket<T0, T1>, arg1: T0, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg3);
        let v1 = 0x2::tx_context::sender(arg3);
        let v2 = ItemListed{
            index       : arg0.next_index,
            item_id     : 0x2::object::id<T0>(&arg1),
            internal_id : 0x2::object::uid_to_inner(&v0),
            market_id   : 0x2::object::id<CollectionMarket<T0, T1>>(arg0),
            price       : arg2,
            owner       : v1,
        };
        0x2::event::emit<ItemListed>(v2);
        let v3 = Listing<T0, T1>{
            id    : v0,
            item  : arg1,
            price : arg2,
            owner : v1,
        };
        0x2::object_table::add<u64, Listing<T0, T1>>(&mut arg0.items, arg0.next_index, v3);
        arg0.next_index = arg0.next_index + 1;
    }

    fun publish_market<T0: store + key, T1>(arg0: address, arg1: u32, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg2);
        let v1 = MarketCreated<T0, T1>{
            market_id        : 0x2::object::uid_to_inner(&v0),
            object           : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            coin             : 0x1::type_name::into_string(0x1::type_name::get<T1>()),
            royalty          : arg1,
            royalty_receiver : arg0,
        };
        0x2::event::emit<MarketCreated<T0, T1>>(v1);
        let v2 = CollectionMarket<T0, T1>{
            id               : v0,
            next_index       : 0,
            fee              : 0x2::balance::zero<T1>(),
            royalty          : arg1,
            royalty_receiver : arg0,
            royalty_vault    : 0x2::balance::zero<T1>(),
            items            : 0x2::object_table::new<u64, Listing<T0, T1>>(arg2),
        };
        0x2::transfer::share_object<CollectionMarket<T0, T1>>(v2);
    }

    public fun purchase<T0: store + key, T1>(arg0: &mut CollectionMarket<T0, T1>, arg1: u64, arg2: 0x2::coin::Coin<T1>, arg3: &mut 0x2::tx_context::TxContext) : T0 {
        let Listing {
            id    : v0,
            item  : v1,
            price : v2,
            owner : v3,
        } = 0x2::object_table::remove<u64, Listing<T0, T1>>(&mut arg0.items, arg1);
        let v4 = v1;
        assert!(0x2::coin::value<T1>(&arg2) == v2, 2);
        let v5 = 0x2::coin::value<T1>(&arg2) / 10000 * (99 as u64);
        if (v5 > 0) {
            0x2::balance::join<T1>(&mut arg0.fee, 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg2, v5, arg3)));
        };
        let v6 = 0x2::coin::value<T1>(&arg2) / 10000 * (arg0.royalty as u64);
        if (v6 > 0) {
            0x2::balance::join<T1>(&mut arg0.royalty_vault, 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg2, v6, arg3)));
        };
        let v7 = ItemPurchased<T1>{
            index          : arg1,
            item_id        : 0x2::object::id<T0>(&v4),
            new_owner      : 0x2::tx_context::sender(arg3),
            royalty_amount : v6,
            coin           : 0x1::type_name::into_string(0x1::type_name::get<T1>()),
        };
        0x2::event::emit<ItemPurchased<T1>>(v7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg2, v3);
        0x2::object::delete(v0);
        v4
    }

    public entry fun purchase_and_take<T0: store + key, T1>(arg0: &mut CollectionMarket<T0, T1>, arg1: u64, arg2: 0x2::coin::Coin<T1>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = purchase<T0, T1>(arg0, arg1, arg2, arg3);
        0x2::transfer::public_transfer<T0>(v0, 0x2::tx_context::sender(arg3));
    }

    public entry fun purchase_and_take_mut<T0: store + key, T1>(arg0: &mut CollectionMarket<T0, T1>, arg1: u64, arg2: &mut 0x2::coin::Coin<T1>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::split<T1>(arg2, 0x2::object_table::borrow<u64, Listing<T0, T1>>(&arg0.items, arg1).price, arg3);
        purchase_and_take<T0, T1>(arg0, arg1, v0, arg3);
    }

    public entry fun withdraw_fees<T0: store + key, T1>(arg0: &MarketOwnerCap, arg1: &mut CollectionMarket<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg1.fee, 0x2::balance::value<T1>(&arg1.fee)), arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun withdraw_royalties<T0: store + key, T1>(arg0: &mut CollectionMarket<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(v0 == arg0.royalty_receiver, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.royalty_vault, 0x2::balance::value<T1>(&arg0.royalty_vault)), arg1), v0);
    }

    // decompiled from Move bytecode v6
}

