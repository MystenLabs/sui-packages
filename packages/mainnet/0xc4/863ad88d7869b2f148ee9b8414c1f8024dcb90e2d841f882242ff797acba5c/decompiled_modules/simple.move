module 0xc4863ad88d7869b2f148ee9b8414c1f8024dcb90e2d841f882242ff797acba5c::simple {
    struct SharedListInfo<phantom T0> has store, key {
        id: 0x2::object::UID,
        owner: address,
        price: u64,
        item_id: 0x2::object::ID,
        marketplace_fee: u64,
    }

    struct ListItemKey<phantom T0> has copy, drop, store {
        list: 0x2::object::ID,
        item: 0x2::object::ID,
    }

    struct ListItemCap<phantom T0> has key {
        id: 0x2::object::UID,
        list: 0x2::object::ID,
        item: 0x2::object::ID,
    }

    public fun get_fee<T0: store + key>(arg0: &SharedListInfo<T0>) : u64 {
        arg0.marketplace_fee
    }

    public fun buy<T0: store + key>(arg0: &mut 0xc4863ad88d7869b2f148ee9b8414c1f8024dcb90e2d841f882242ff797acba5c::marketplace::MarketPlace, arg1: SharedListInfo<T0>, arg2: 0x2::object::ID, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
        let SharedListInfo {
            id              : v0,
            owner           : v1,
            price           : v2,
            item_id         : v3,
            marketplace_fee : v4,
        } = arg1;
        let v5 = v0;
        assert!(v1 != 0x2::tx_context::sender(arg4), 400);
        assert!(v3 == arg2, 402);
        let v6 = 0x2::coin::into_balance<0x2::sui::SUI>(arg3);
        assert!(0x2::balance::value<0x2::sui::SUI>(&v6) >= v2 + v4, 403);
        0xc4863ad88d7869b2f148ee9b8414c1f8024dcb90e2d841f882242ff797acba5c::marketplace::add_balance(arg0, 0x2::coin::take<0x2::sui::SUI>(&mut v6, v4, arg4));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut v6, v2, arg4), v1);
        let v7 = ListItemKey<T0>{
            list : 0x2::object::uid_to_inner(&v5),
            item : arg2,
        };
        let v8 = 0xc4863ad88d7869b2f148ee9b8414c1f8024dcb90e2d841f882242ff797acba5c::marketplace::remove_from_marketplace<ListItemKey<T0>, T0>(arg0, v7);
        0xc4863ad88d7869b2f148ee9b8414c1f8024dcb90e2d841f882242ff797acba5c::marketplace::emit_buy_event(0x2::object::id<0xc4863ad88d7869b2f148ee9b8414c1f8024dcb90e2d841f882242ff797acba5c::marketplace::MarketPlace>(arg0), 0x2::object::id<T0>(&v8), v2, 0x2::object::uid_to_inner(&v5), 0x2::tx_context::sender(arg4));
        0x2::transfer::public_transfer<T0>(v8, 0x2::tx_context::sender(arg4));
        let v9 = 0x2::coin::zero<0x2::sui::SUI>(arg4);
        0x2::balance::join<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(&mut v9), v6);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v9, 0x2::tx_context::sender(arg4));
        0x2::object::delete(v5);
    }

    public fun delist<T0: store + key>(arg0: &mut 0xc4863ad88d7869b2f148ee9b8414c1f8024dcb90e2d841f882242ff797acba5c::marketplace::MarketPlace, arg1: SharedListInfo<T0>, arg2: ListItemCap<T0>, arg3: 0x2::object::ID, arg4: &mut 0x2::tx_context::TxContext) {
        let ListItemCap {
            id   : v0,
            list : v1,
            item : v2,
        } = arg2;
        let v3 = v1;
        let SharedListInfo {
            id              : v4,
            owner           : v5,
            price           : _,
            item_id         : v7,
            marketplace_fee : _,
        } = arg1;
        let v9 = v4;
        assert!(0x2::object::uid_as_inner(&v9) == &v3, 402);
        assert!(v5 == 0x2::tx_context::sender(arg4), 400);
        assert!(v7 == arg3, 402);
        assert!(v7 == v2, 402);
        let v10 = ListItemKey<T0>{
            list : 0x2::object::uid_to_inner(&v9),
            item : v7,
        };
        0x2::transfer::public_transfer<T0>(0xc4863ad88d7869b2f148ee9b8414c1f8024dcb90e2d841f882242ff797acba5c::marketplace::remove_from_marketplace<ListItemKey<T0>, T0>(arg0, v10), 0x2::tx_context::sender(arg4));
        0xc4863ad88d7869b2f148ee9b8414c1f8024dcb90e2d841f882242ff797acba5c::marketplace::emit_delist_event(0x2::object::id<0xc4863ad88d7869b2f148ee9b8414c1f8024dcb90e2d841f882242ff797acba5c::marketplace::MarketPlace>(arg0), v7, 0x2::object::uid_to_inner(&v9), 0x2::tx_context::sender(arg4));
        0x2::object::delete(v9);
        0x2::object::delete(v0);
    }

    public fun get_item_id<T0: store + key>(arg0: &SharedListInfo<T0>) : 0x2::object::ID {
        arg0.item_id
    }

    public fun get_owner<T0: store + key>(arg0: &SharedListInfo<T0>) : address {
        arg0.owner
    }

    public fun get_price<T0: store + key>(arg0: &SharedListInfo<T0>) : u64 {
        arg0.price
    }

    public fun list<T0: store + key>(arg0: &mut 0xc4863ad88d7869b2f148ee9b8414c1f8024dcb90e2d841f882242ff797acba5c::marketplace::MarketPlace, arg1: T0, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = (((0xc4863ad88d7869b2f148ee9b8414c1f8024dcb90e2d841f882242ff797acba5c::marketplace::get_fee(arg0, 0x2::tx_context::sender(arg3)) as u128) * (arg2 as u128) / 10000) as u64);
        let v1 = 0x2::object::id<T0>(&arg1);
        let v2 = SharedListInfo<T0>{
            id              : 0x2::object::new(arg3),
            owner           : 0x2::tx_context::sender(arg3),
            price           : arg2,
            item_id         : v1,
            marketplace_fee : v0,
        };
        let v3 = ListItemCap<T0>{
            id   : 0x2::object::new(arg3),
            list : 0x2::object::id<SharedListInfo<T0>>(&v2),
            item : v1,
        };
        0xc4863ad88d7869b2f148ee9b8414c1f8024dcb90e2d841f882242ff797acba5c::marketplace::emit_listing_event(0x2::object::id<0xc4863ad88d7869b2f148ee9b8414c1f8024dcb90e2d841f882242ff797acba5c::marketplace::MarketPlace>(arg0), 0x2::object::id<ListItemCap<T0>>(&v3), 0x2::object::id<SharedListInfo<T0>>(&v2), v1, arg2, v0, 0x2::tx_context::sender(arg3));
        0x2::transfer::share_object<SharedListInfo<T0>>(v2);
        let v4 = ListItemKey<T0>{
            list : 0x2::object::id<SharedListInfo<T0>>(&v2),
            item : v1,
        };
        0xc4863ad88d7869b2f148ee9b8414c1f8024dcb90e2d841f882242ff797acba5c::marketplace::add_to_marketplace<ListItemKey<T0>, T0>(arg0, v4, arg1);
        0x2::transfer::transfer<ListItemCap<T0>>(v3, 0x2::tx_context::sender(arg3));
    }

    public fun update_listing<T0: store + key>(arg0: &0xc4863ad88d7869b2f148ee9b8414c1f8024dcb90e2d841f882242ff797acba5c::marketplace::MarketPlace, arg1: &mut SharedListInfo<T0>, arg2: &ListItemCap<T0>, arg3: 0x2::object::ID, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.owner == 0x2::tx_context::sender(arg5), 400);
        assert!(arg1.item_id == arg3, 402);
        assert!(arg2.item == arg1.item_id, 402);
        let v0 = (((0xc4863ad88d7869b2f148ee9b8414c1f8024dcb90e2d841f882242ff797acba5c::marketplace::get_fee(arg0, 0x2::tx_context::sender(arg5)) as u128) * (arg4 as u128) / 10000) as u64);
        arg1.price = arg4;
        arg1.marketplace_fee = v0;
        0xc4863ad88d7869b2f148ee9b8414c1f8024dcb90e2d841f882242ff797acba5c::marketplace::emit_update_event(0x2::object::id<0xc4863ad88d7869b2f148ee9b8414c1f8024dcb90e2d841f882242ff797acba5c::marketplace::MarketPlace>(arg0), 0x2::object::id<ListItemCap<T0>>(arg2), arg3, 0x2::object::id<SharedListInfo<T0>>(arg1), arg4, v0, 0x2::tx_context::sender(arg5));
    }

    // decompiled from Move bytecode v6
}

