module 0x72c5b76b7523c4ea07c326db096acd7a5f5587abf5f4e91b232b1b03a104c340::shop {
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

    public fun cetus_cake_for_donut<T0, T1>(arg0: &mut DonutShop<T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: u64, arg4: u64, arg5: u128, arg6: address, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        check_shop_balance<T1>(arg0, arg3, arg9);
        let (_, v1) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::balances<T0, T1>(arg2);
        assert!(0x2::balance::value<T1>(v1) >= arg7, 4);
        let v2 = 0x2::coin::take<T1>(&mut arg0.balance, arg3, arg9);
        let v3 = 0x2::coin::zero<T0>(arg9);
        let (v4, v5) = cetus_swap<T0, T1>(arg1, arg2, v3, v2, false, arg3, arg5, arg8, arg9);
        let v6 = v4;
        assert!(0x2::balance::value<T0>(0x2::coin::balance<T0>(&v6)) >= arg4, 3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v6, arg6);
        0x2::balance::join<T1>(&mut arg0.balance, 0x2::coin::into_balance<T1>(v5));
    }

    public fun cetus_donut_for_cake<T0, T1>(arg0: &mut DonutShop<T0>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: u64, arg4: u64, arg5: u128, arg6: address, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        check_shop_balance<T0>(arg0, arg3, arg9);
        let (v0, _) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::balances<T0, T1>(arg2);
        assert!(0x2::balance::value<T0>(v0) >= arg7, 4);
        let v2 = 0x2::coin::take<T0>(&mut arg0.balance, arg3, arg9);
        let v3 = 0x2::coin::zero<T1>(arg9);
        let (v4, v5) = cetus_swap<T0, T1>(arg1, arg2, v2, v3, true, arg3, arg5, arg8, arg9);
        let v6 = v5;
        assert!(0x2::balance::value<T1>(0x2::coin::balance<T1>(&v6)) >= arg4, 3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v6, arg6);
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(v4));
    }

    fun cetus_swap<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: bool, arg5: u64, arg6: u128, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, arg4, true, arg5, arg6, arg7);
        let v3 = v2;
        let v4 = v1;
        let v5 = v0;
        if (arg4) {
        };
        let (v6, v7) = if (arg4) {
            (0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg2, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v3), arg8)), 0x2::balance::zero<T1>())
        } else {
            (0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg3, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v3), arg8)))
        };
        0x2::coin::join<T1>(&mut arg3, 0x2::coin::from_balance<T1>(v4, arg8));
        0x2::coin::join<T0>(&mut arg2, 0x2::coin::from_balance<T0>(v5, arg8));
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, v6, v7, v3);
        (arg2, arg3)
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

    public fun withdraw_donuts<T0>(arg0: &OwnerCap, arg1: &mut DonutShop<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg1.balance, 0x2::balance::value<T0>(&arg1.balance), arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

