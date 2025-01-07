module 0xdd882763e8e4514bf8bca936cdb954efeb60ee49bd89ede74b1379512e8c1486::lihuazhang_swap {
    struct LP<phantom T0, phantom T1> has drop {
        dummy_field: bool,
    }

    struct Pool<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        coin_x: 0x2::balance::Balance<T0>,
        coin_y: 0x2::balance::Balance<T1>,
        lp_supply: 0x2::balance::Supply<LP<T0, T1>>,
    }

    struct Pocket has store, key {
        id: 0x2::object::UID,
        table: 0x2::table::Table<0x2::object::ID, vector<u64>>,
    }

    public fun add_liquidity<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<LP<T0, T1>>, vector<u64>) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        let v1 = 0x2::coin::value<T1>(&arg2);
        assert!(v0 > 0 && v1 > 0, 1);
        assert!(v1 + v1 == v0, 7);
        0x2::coin::put<T0>(&mut arg0.coin_x, arg1);
        0x2::coin::put<T1>(&mut arg0.coin_y, arg2);
        let v2 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v2, v0);
        0x1::vector::push_back<u64>(&mut v2, v1);
        (0x2::coin::from_balance<LP<T0, T1>>(0x2::balance::increase_supply<LP<T0, T1>>(&mut arg0.lp_supply, v0 + v1), arg3), v2)
    }

    public entry fun create_pocket(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Pocket{
            id    : 0x2::object::new(arg0),
            table : 0x2::table::new<0x2::object::ID, vector<u64>>(arg0),
        };
        0x2::transfer::public_transfer<Pocket>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun create_pool<T0, T1>(arg0: &mut 0x2::tx_context::TxContext) {
        new_pool<T0, T1>(arg0);
    }

    public entry fun deposit_partial<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: vector<0x2::coin::Coin<T0>>, arg2: u64, arg3: vector<0x2::coin::Coin<T1>>, arg4: u64, arg5: &mut Pocket, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::zero<T0>(arg6);
        0x2::pay::join_vec<T0>(&mut v0, arg1);
        let v1 = 0x2::coin::split<T0>(&mut v0, arg2, arg6);
        let v2 = 0x2::coin::zero<T1>(arg6);
        0x2::pay::join_vec<T1>(&mut v2, arg3);
        let v3 = 0x2::coin::split<T1>(&mut v2, arg4, arg6);
        let (v4, v5) = add_liquidity<T0, T1>(arg0, v1, v3, arg6);
        let v6 = v4;
        0x2::table::add<0x2::object::ID, vector<u64>>(&mut arg5.table, 0x2::object::id<0x2::coin::Coin<LP<T0, T1>>>(&v6), v5);
        let v7 = 0x2::tx_context::sender(arg6);
        0x2::transfer::public_transfer<0x2::coin::Coin<LP<T0, T1>>>(v6, v7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, v7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v2, v7);
    }

    public entry fun deposit_totally<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: &mut Pocket, arg4: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = add_liquidity<T0, T1>(arg0, arg1, arg2, arg4);
        let v2 = v0;
        0x2::table::add<0x2::object::ID, vector<u64>>(&mut arg3.table, 0x2::object::id<0x2::coin::Coin<LP<T0, T1>>>(&v2), v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<LP<T0, T1>>>(v2, 0x2::tx_context::sender(arg4));
    }

    public fun new_pool<T0, T1>(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = LP<T0, T1>{dummy_field: false};
        let v1 = Pool<T0, T1>{
            id        : 0x2::object::new(arg0),
            coin_x    : 0x2::balance::zero<T0>(),
            coin_y    : 0x2::balance::zero<T1>(),
            lp_supply : 0x2::balance::create_supply<LP<T0, T1>>(v0),
        };
        0x2::transfer::share_object<Pool<T0, T1>>(v1);
    }

    public entry fun remove_liquidity<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<LP<T0, T1>>, arg2: &mut Pocket, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<0x2::coin::Coin<LP<T0, T1>>>(&arg1);
        let v1 = *0x2::table::borrow<0x2::object::ID, vector<u64>>(&arg2.table, v0);
        assert!(0x1::vector::length<u64>(&v1) == 2, 2);
        let v2 = *0x1::vector::borrow<u64>(&v1, 0);
        let v3 = *0x1::vector::borrow<u64>(&v1, 1);
        assert!(0x2::coin::value<LP<T0, T1>>(&arg1) == v2 + v3, 5);
        assert!(0x2::balance::value<T0>(&arg0.coin_x) > v2, 3);
        assert!(0x2::balance::value<T1>(&arg0.coin_y) > v3, 4);
        0x2::balance::decrease_supply<LP<T0, T1>>(&mut arg0.lp_supply, 0x2::coin::into_balance<LP<T0, T1>>(arg1));
        let v4 = 0x2::coin::take<T0>(&mut arg0.coin_x, v3, arg3);
        let v5 = 0x2::coin::take<T1>(&mut arg0.coin_y, v3, arg3);
        assert!(0x2::coin::value<T0>(&v4) > 0 && 0x2::coin::value<T1>(&v5) > 0, 6);
        let v6 = 0x2::table::remove<0x2::object::ID, vector<u64>>(&mut arg2.table, v0);
        0x1::vector::remove<u64>(&mut v6, 0);
        0x1::vector::remove<u64>(&mut v6, 1);
        let v7 = 0x2::tx_context::sender(arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, v7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v5, v7);
    }

    public fun swap_x_out_to_y<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::coin::value<T0>(&arg1);
        0x2::coin::put<T0>(&mut arg0.coin_x, arg1);
        assert!(v0 + v0 < 0x2::balance::value<T1>(&arg0.coin_y), 4);
        0x2::coin::take<T1>(&mut arg0.coin_y, v0 + v0, arg2)
    }

    public entry fun swap_x_to_y<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: vector<0x2::coin::Coin<T0>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::zero<T0>(arg3);
        0x2::pay::join_vec<T0>(&mut v0, arg1);
        let v1 = 0x2::coin::split<T0>(&mut v0, arg2, arg3);
        let v2 = swap_x_out_to_y<T0, T1>(arg0, v1, arg3);
        let v3 = 0x2::tx_context::sender(arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v2, v3);
    }

    public fun swap_y_out_to_x<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::coin::value<T1>(&arg1);
        0x2::coin::put<T1>(&mut arg0.coin_y, arg1);
        assert!(v0 / 2 < 0x2::balance::value<T0>(&arg0.coin_x), 3);
        0x2::coin::take<T0>(&mut arg0.coin_x, v0 / 2, arg2)
    }

    public entry fun swap_y_to_x<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: vector<0x2::coin::Coin<T1>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::zero<T1>(arg3);
        0x2::pay::join_vec<T1>(&mut v0, arg1);
        let v1 = 0x2::coin::split<T1>(&mut v0, arg2, arg3);
        let v2 = swap_y_out_to_x<T0, T1>(arg0, v1, arg3);
        let v3 = 0x2::tx_context::sender(arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v0, v3);
    }

    // decompiled from Move bytecode v6
}

