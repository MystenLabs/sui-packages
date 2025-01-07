module 0xa9109ccb7a8af92417eacfc44491216e6aa647d2a4dd2c15a168be9705be30d1::shop {
    struct OwnerCap has key {
        id: 0x2::object::UID,
    }

    struct DonutShop<phantom T0> has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        employees: 0x2::table::Table<address, bool>,
    }

    struct DonutShopCreated has copy, drop {
        id: 0x2::object::ID,
    }

    public fun add_employees<T0>(arg0: &OwnerCap, arg1: &mut DonutShop<T0>, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg2)) {
            let v1 = 0x1::vector::remove<address>(&mut arg2, v0);
            if (!0x2::table::contains<address, bool>(&arg1.employees, v1)) {
                0x2::table::add<address, bool>(&mut arg1.employees, v1, true);
            };
            v0 = v0 + 1;
        };
    }

    fun check_shop_balance<T0>(arg0: &DonutShop<T0>, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<address, bool>(&arg0.employees, 0x2::tx_context::sender(arg2)), 0);
        assert!(0x2::balance::value<T0>(&arg0.balance) >= arg1, 2);
    }

    public fun create_donut_shop<T0>(arg0: &OwnerCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = DonutShop<T0>{
            id        : 0x2::object::new(arg1),
            balance   : 0x2::balance::zero<T0>(),
            employees : 0x2::table::new<address, bool>(arg1),
        };
        let v1 = DonutShopCreated{id: 0x2::object::id<DonutShop<T0>>(&v0)};
        0x2::event::emit<DonutShopCreated>(v1);
        0x2::transfer::share_object<DonutShop<T0>>(v0);
    }

    public fun deposit_donuts<T0>(arg0: &OwnerCap, arg1: &mut DonutShop<T0>, arg2: &mut 0x2::coin::Coin<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<T0>(&mut arg1.balance, 0x2::balance::split<T0>(0x2::coin::balance_mut<T0>(arg2), arg3));
    }

    public fun donut_balance<T0>(arg0: &OwnerCap, arg1: &DonutShop<T0>) : u64 {
        0x2::balance::value<T0>(&arg1.balance)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = OwnerCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<OwnerCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun turbo_donut_for_cake<T0, T1, T2>(arg0: &mut DonutShop<T1>, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg2: u64, arg3: u64, arg4: u128, arg5: address, arg6: u64, arg7: &0x2::clock::Clock, arg8: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg9: &mut 0x2::tx_context::TxContext) {
        check_shop_balance<T1>(arg0, arg2, arg9);
        let (_, v1) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_balance<T0, T1, T2>(arg1);
        assert!(v1 >= arg6, 4);
        let v2 = 0x1::vector::empty<0x2::coin::Coin<T1>>();
        0x1::vector::push_back<0x2::coin::Coin<T1>>(&mut v2, 0x2::coin::take<T1>(&mut arg0.balance, arg2, arg9));
        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::swap_router::swap_b_a<T0, T1, T2>(arg1, v2, arg2, arg3, arg4, true, arg5, 0x2::clock::timestamp_ms(arg7) + 1000, arg7, arg8, arg9);
    }

    public fun withdraw_donuts<T0>(arg0: &OwnerCap, arg1: &mut DonutShop<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg1.balance, 0x2::balance::value<T0>(&arg1.balance), arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

