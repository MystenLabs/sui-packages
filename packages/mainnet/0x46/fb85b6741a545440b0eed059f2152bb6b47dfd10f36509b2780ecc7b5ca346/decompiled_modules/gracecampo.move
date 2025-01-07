module 0x46fb85b6741a545440b0eed059f2152bb6b47dfd10f36509b2780ecc7b5ca346::gracecampo {
    struct LP<phantom T0, phantom T1> has drop {
        dummy_field: bool,
    }

    struct Pool<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        coin_x: 0x2::balance::Balance<T0>,
        coin_y: 0x2::balance::Balance<T1>,
        lp_supply: 0x2::balance::Supply<LP<T0, T1>>,
    }

    public fun add_liquidity<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<LP<T0, T1>> {
        let v0 = 0x2::coin::value<T0>(&arg1);
        let v1 = 0x2::coin::value<T1>(&arg2);
        assert!(v0 > 0 && v1 > 0, 1001);
        0x2::coin::put<T0>(&mut arg0.coin_x, arg1);
        0x2::coin::put<T1>(&mut arg0.coin_y, arg2);
        0x2::coin::from_balance<LP<T0, T1>>(0x2::balance::increase_supply<LP<T0, T1>>(&mut arg0.lp_supply, v0 + v1), arg3)
    }

    public entry fun deposit_liquidity<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x2::coin::Coin<T0>, arg2: &mut 0x2::coin::Coin<T1>, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<T0>(0x2::coin::balance<T0>(arg1)) >= arg3 && 0x2::balance::value<T1>(0x2::coin::balance<T1>(arg2)) >= arg4, 1006);
        let v0 = 0x2::coin::split<T0>(arg1, arg3, arg5);
        let v1 = 0x2::coin::split<T1>(arg2, arg4, arg5);
        let v2 = add_liquidity<T0, T1>(arg0, v0, v1, arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<LP<T0, T1>>>(v2, 0x2::tx_context::sender(arg5));
    }

    public entry fun new_pool<T0, T1>(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = LP<T0, T1>{dummy_field: false};
        let v1 = Pool<T0, T1>{
            id        : 0x2::object::new(arg0),
            coin_x    : 0x2::balance::zero<T0>(),
            coin_y    : 0x2::balance::zero<T1>(),
            lp_supply : 0x2::balance::create_supply<LP<T0, T1>>(v0),
        };
        0x2::transfer::share_object<Pool<T0, T1>>(v1);
    }

    public fun remove_liquidity<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x2::coin::Coin<LP<T0, T1>>, arg2: vector<u64>, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert!(0x1::vector::length<u64>(&arg2) == 2, 1002);
        let v0 = *0x1::vector::borrow<u64>(&arg2, 0);
        let v1 = *0x1::vector::borrow<u64>(&arg2, 1);
        assert!(0x2::coin::value<LP<T0, T1>>(arg1) == v0 + v1, 1003);
        assert!(0x2::balance::value<T0>(&arg0.coin_x) >= v0, 1004);
        assert!(0x2::balance::value<T1>(&arg0.coin_y) >= v1, 1005);
        0x2::balance::decrease_supply<LP<T0, T1>>(&mut arg0.lp_supply, 0x2::coin::into_balance<LP<T0, T1>>(0x2::coin::split<LP<T0, T1>>(arg1, v0 + v1, arg3)));
        (0x2::coin::take<T0>(&mut arg0.coin_x, v0, arg3), 0x2::coin::take<T1>(&mut arg0.coin_y, v1, arg3))
    }

    public entry fun swap_x_to_y<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 < 0x2::balance::value<T1>(&arg0.coin_y), 1005);
        0x2::coin::put<T0>(&mut arg0.coin_x, 0x2::coin::split<T0>(arg1, arg2, arg3));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::take<T1>(&mut arg0.coin_y, arg2, arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun swap_y_to_x<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x2::coin::Coin<T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 < 0x2::balance::value<T0>(&arg0.coin_x), 1005);
        0x2::coin::put<T1>(&mut arg0.coin_y, 0x2::coin::split<T1>(arg1, arg2, arg3));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.coin_x, arg2, arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun withdraw_liquidity<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x2::coin::Coin<LP<T0, T1>>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<LP<T0, T1>>(arg1) * 10000000 / 0x2::balance::supply_value<LP<T0, T1>>(&arg0.lp_supply);
        let v1 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v1, 0x2::balance::value<T0>(&arg0.coin_x) * v0 / 10000000);
        0x1::vector::push_back<u64>(&mut v1, 0x2::balance::value<T1>(&arg0.coin_y) * v0 / 10000000);
        let (v2, v3) = remove_liquidity<T0, T1>(arg0, arg1, v1, arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, 0x2::tx_context::sender(arg2));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v3, 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

