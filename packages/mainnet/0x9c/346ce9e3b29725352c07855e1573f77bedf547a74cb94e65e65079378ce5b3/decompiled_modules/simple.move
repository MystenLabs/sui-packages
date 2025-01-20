module 0x9c346ce9e3b29725352c07855e1573f77bedf547a74cb94e65e65079378ce5b3::simple {
    struct ListItem<T0> has key {
        id: 0x2::object::UID,
        owner: address,
        price: u64,
        item: T0,
        marketplace_fee: u64,
    }

    public fun get_fee<T0: store + key>(arg0: &ListItem<T0>) : u64 {
        arg0.marketplace_fee
    }

    public fun buy<T0: store + key>(arg0: &mut 0x9c346ce9e3b29725352c07855e1573f77bedf547a74cb94e65e65079378ce5b3::marketplace::MarketPlace, arg1: ListItem<T0>, arg2: 0x2::object::ID, arg3: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
        let ListItem {
            id              : v0,
            owner           : v1,
            price           : v2,
            item            : v3,
            marketplace_fee : v4,
        } = arg1;
        let v5 = v3;
        let v6 = v0;
        assert!(0x2::object::id<T0>(&v5) == arg2, 402);
        let v7 = 0x2::coin::value<0x2::sui::SUI>(arg3);
        assert!(v7 >= v2 + v4, 403);
        0x9c346ce9e3b29725352c07855e1573f77bedf547a74cb94e65e65079378ce5b3::marketplace::add_balance(arg0, 0x2::coin::split<0x2::sui::SUI>(arg3, v4, arg4));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg3, v2, arg4), v1);
        0x2::transfer::public_transfer<T0>(v5, 0x2::tx_context::sender(arg4));
        0x9c346ce9e3b29725352c07855e1573f77bedf547a74cb94e65e65079378ce5b3::marketplace::emit_buy_event(0x2::object::id<0x9c346ce9e3b29725352c07855e1573f77bedf547a74cb94e65e65079378ce5b3::marketplace::MarketPlace>(arg0), 0x2::object::id<T0>(&v5), v7, 0x2::object::uid_to_inner(&v6), 0x2::tx_context::sender(arg4));
        0x2::object::delete(v6);
    }

    public fun delist<T0: store + key>(arg0: ListItem<T0>, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        let ListItem {
            id              : v0,
            owner           : v1,
            price           : _,
            item            : v3,
            marketplace_fee : _,
        } = arg0;
        let v5 = v3;
        assert!(0x2::tx_context::sender(arg2) == v1, 400);
        assert!(0x2::object::id<T0>(&v5) == arg1, 402);
        0x2::transfer::public_transfer<T0>(v5, 0x2::tx_context::sender(arg2));
        0x2::object::delete(v0);
    }

    public fun get_item_id<T0: store + key>(arg0: &ListItem<T0>) : 0x2::object::ID {
        0x2::object::id<T0>(&arg0.item)
    }

    public fun get_owner<T0: store + key>(arg0: &ListItem<T0>) : address {
        arg0.owner
    }

    public fun get_price<T0: store + key>(arg0: &ListItem<T0>) : u64 {
        arg0.price
    }

    public fun list<T0: store + key>(arg0: &0x9c346ce9e3b29725352c07855e1573f77bedf547a74cb94e65e65079378ce5b3::marketplace::MarketPlace, arg1: T0, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = (0x9c346ce9e3b29725352c07855e1573f77bedf547a74cb94e65e65079378ce5b3::marketplace::get_fee(arg0, 0x2::tx_context::sender(arg3)) as u64) * arg2 / 10000;
        let v1 = 0x2::object::new(arg3);
        let v2 = ListItem<T0>{
            id              : v1,
            owner           : 0x2::tx_context::sender(arg3),
            price           : arg2,
            item            : arg1,
            marketplace_fee : v0,
        };
        0x2::transfer::share_object<ListItem<T0>>(v2);
        0x9c346ce9e3b29725352c07855e1573f77bedf547a74cb94e65e65079378ce5b3::marketplace::emit_listing_event(0x2::object::id<0x9c346ce9e3b29725352c07855e1573f77bedf547a74cb94e65e65079378ce5b3::marketplace::MarketPlace>(arg0), 0x2::object::uid_to_inner(&v1), 0x2::object::id<T0>(&arg1), arg2, v0, 0x2::tx_context::sender(arg3));
    }

    public fun update_listing<T0: store + key>(arg0: &0x9c346ce9e3b29725352c07855e1573f77bedf547a74cb94e65e65079378ce5b3::marketplace::MarketPlace, arg1: &mut ListItem<T0>, arg2: 0x2::object::ID, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = arg1.owner;
        assert!(0x2::tx_context::sender(arg4) == v0, 400);
        let v1 = 0x2::object::id<T0>(&arg1.item);
        assert!(v1 == arg2, 402);
        arg1.marketplace_fee = (((0x9c346ce9e3b29725352c07855e1573f77bedf547a74cb94e65e65079378ce5b3::marketplace::get_fee(arg0, 0x2::tx_context::sender(arg4)) as u128) * (arg3 as u128) / 10000) as u64);
        arg1.price = arg3;
        0x9c346ce9e3b29725352c07855e1573f77bedf547a74cb94e65e65079378ce5b3::marketplace::emit_update_event(0x2::object::id<0x9c346ce9e3b29725352c07855e1573f77bedf547a74cb94e65e65079378ce5b3::marketplace::MarketPlace>(arg0), v1, 0x2::object::uid_to_inner(&arg1.id), arg1.price, arg1.marketplace_fee, v0);
    }

    // decompiled from Move bytecode v6
}

