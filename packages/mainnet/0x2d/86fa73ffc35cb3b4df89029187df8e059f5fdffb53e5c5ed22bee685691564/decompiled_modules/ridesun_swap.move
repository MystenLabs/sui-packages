module 0x2d86fa73ffc35cb3b4df89029187df8e059f5fdffb53e5c5ed22bee685691564::ridesun_swap {
    struct LP<phantom T0, phantom T1> has drop {
        dummy_field: bool,
    }

    struct Pool<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        balance_a: 0x2::balance::Balance<T0>,
        balance_b: 0x2::balance::Balance<T1>,
        lp_supply: 0x2::balance::Supply<LP<T0, T1>>,
    }

    struct Pocket has key {
        id: 0x2::object::UID,
        id_to_vec: 0x2::table::Table<0x2::object::ID, vector<u64>>,
    }

    entry fun a_swap_b<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 <= 0x2::balance::value<T1>(&arg0.balance_b), 0);
        0x2::balance::join<T0>(&mut arg0.balance_a, 0x2::coin::into_balance<T0>(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::take<T1>(&mut arg0.balance_b, v0, arg2), 0x2::tx_context::sender(arg2));
    }

    entry fun add_liquidity<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: &mut Pocket, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        let v1 = 0x2::coin::value<T1>(&arg2);
        0x2::balance::join<T0>(&mut arg0.balance_a, 0x2::coin::into_balance<T0>(arg1));
        0x2::balance::join<T1>(&mut arg0.balance_b, 0x2::coin::into_balance<T1>(arg2));
        let v2 = 0x2::coin::from_balance<LP<T0, T1>>(0x2::balance::increase_supply<LP<T0, T1>>(&mut arg0.lp_supply, v0 + v1), arg4);
        let v3 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v3, v0);
        0x1::vector::push_back<u64>(&mut v3, v1);
        0x2::table::add<0x2::object::ID, vector<u64>>(&mut arg3.id_to_vec, 0x2::object::id<0x2::coin::Coin<LP<T0, T1>>>(&v2), v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<LP<T0, T1>>>(v2, 0x2::tx_context::sender(arg4));
    }

    entry fun b_swap_a<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T1>(&arg1);
        assert!(v0 <= 0x2::balance::value<T0>(&arg0.balance_a), 0);
        0x2::balance::join<T1>(&mut arg0.balance_b, 0x2::coin::into_balance<T1>(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.balance_a, v0, arg2), 0x2::tx_context::sender(arg2));
    }

    entry fun create_pool<T0, T1>(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = LP<T0, T1>{dummy_field: false};
        let v1 = Pool<T0, T1>{
            id        : 0x2::object::new(arg0),
            balance_a : 0x2::balance::zero<T0>(),
            balance_b : 0x2::balance::zero<T1>(),
            lp_supply : 0x2::balance::create_supply<LP<T0, T1>>(v0),
        };
        let v2 = Pocket{
            id        : 0x2::object::new(arg0),
            id_to_vec : 0x2::table::new<0x2::object::ID, vector<u64>>(arg0),
        };
        0x2::transfer::share_object<Pool<T0, T1>>(v1);
        0x2::transfer::share_object<Pocket>(v2);
    }

    // decompiled from Move bytecode v6
}

