module 0x6f47df55d86f383c31012cfe524940b3329b539a49971873675767893b3db557::shop {
    struct OwnerCap has key {
        id: 0x2::object::UID,
    }

    struct GorillaShop<phantom T0> has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        employees: 0x2::table::Table<address, bool>,
    }

    struct GorillaShopCreated has copy, drop {
        id: 0x2::object::ID,
    }

    public fun add_new_gorillas<T0>(arg0: &OwnerCap, arg1: &mut GorillaShop<T0>, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg2)) {
            let v1 = 0x1::vector::remove<address>(&mut arg2, v0);
            if (!0x2::table::contains<address, bool>(&arg1.employees, v1)) {
                0x2::table::add<address, bool>(&mut arg1.employees, v1, true);
            };
            v0 = v0 + 1;
        };
    }

    public fun bananas<T0>(arg0: &OwnerCap, arg1: &GorillaShop<T0>) : u64 {
        0x2::balance::value<T0>(&arg1.balance)
    }

    public fun blue_move_swap<T0, T1>(arg0: &mut GorillaShop<T0>, arg1: u64, arg2: u64, arg3: address, arg4: u64, arg5: &mut 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::Dex_Info, arg6: &mut 0x2::tx_context::TxContext) {
        check_shop_balance<T0>(arg0, arg1, arg6);
        if (0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::utils::sort_token_type<T0, T1>()) {
            let (_, v1) = 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::token_balances<T0, T1>(0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::get_pool<T0, T1>(arg5));
            assert!(v1 >= arg4, 4);
        } else {
            let (v2, _) = 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::token_balances<T1, T0>(0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::get_pool<T1, T0>(arg5));
            assert!(v2 >= arg4, 4);
        };
        0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::router::swap_exact_input<T0, T1>(arg1, 0x2::coin::take<T0>(&mut arg0.balance, arg1, arg6), arg2, arg5, arg6);
    }

    public fun check_shop_balance<T0>(arg0: &GorillaShop<T0>, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<address, bool>(&arg0.employees, 0x2::tx_context::sender(arg2)), 0);
        assert!(0x2::balance::value<T0>(&arg0.balance) >= arg1, 2);
    }

    public fun create_gorilla_shop<T0>(arg0: &OwnerCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = GorillaShop<T0>{
            id        : 0x2::object::new(arg1),
            balance   : 0x2::balance::zero<T0>(),
            employees : 0x2::table::new<address, bool>(arg1),
        };
        let v1 = GorillaShopCreated{id: 0x2::object::id<GorillaShop<T0>>(&v0)};
        0x2::event::emit<GorillaShopCreated>(v1);
        0x2::transfer::share_object<GorillaShop<T0>>(v0);
    }

    public fun deposit_bananas<T0>(arg0: &OwnerCap, arg1: &mut GorillaShop<T0>, arg2: &mut 0x2::coin::Coin<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<T0>(&mut arg1.balance, 0x2::balance::split<T0>(0x2::coin::balance_mut<T0>(arg2), arg3));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = OwnerCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<OwnerCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun withdraw_bananas<T0>(arg0: &OwnerCap, arg1: &mut GorillaShop<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg1.balance, 0x2::balance::value<T0>(&arg1.balance), arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

