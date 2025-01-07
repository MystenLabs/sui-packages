module 0xc37dfc2d205c0d967932f0e1c9e3410507e413a3d80147d8d3e57503872cfb60::antigone4224 {
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
        assert!(v0 > 0 && v1 > 0, 1001);
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

    public entry fun deposit_partly<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: vector<0x2::coin::Coin<T0>>, arg2: vector<0x2::coin::Coin<T1>>, arg3: u64, arg4: u64, arg5: &mut Pocket, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::zero<T0>(arg6);
        let v1 = 0x2::coin::zero<T1>(arg6);
        0x2::pay::join_vec<T0>(&mut v0, arg1);
        0x2::pay::join_vec<T1>(&mut v1, arg2);
        let v2 = 0x2::coin::split<T0>(&mut v0, arg3, arg6);
        let v3 = 0x2::coin::split<T1>(&mut v1, arg4, arg6);
        let (v4, v5) = add_liquidity<T0, T1>(arg0, v2, v3, arg6);
        let v6 = v4;
        0x2::table::add<0x2::object::ID, vector<u64>>(&mut arg5.table, 0x2::object::id<0x2::coin::Coin<LP<T0, T1>>>(&v6), v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<LP<T0, T1>>>(v6, 0x2::tx_context::sender(arg6));
        let v7 = 0x2::tx_context::sender(arg6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, v7);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v1, v7);
    }

    public entry fun deposit_totally<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: &mut Pocket, arg4: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = add_liquidity<T0, T1>(arg0, arg1, arg2, arg4);
        let v2 = v0;
        0x2::table::add<0x2::object::ID, vector<u64>>(&mut arg3.table, 0x2::object::id<0x2::coin::Coin<LP<T0, T1>>>(&v2), v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<LP<T0, T1>>>(v2, 0x2::tx_context::sender(arg4));
    }

    public entry fun generate_pool<T0, T1>(arg0: &mut 0x2::tx_context::TxContext) {
        new_pool<T0, T1>(arg0);
    }

    public fun join_lp_vec<T0, T1>(arg0: vector<0x2::coin::Coin<LP<T0, T1>>>, arg1: &mut Pocket, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<LP<T0, T1>>, vector<u64>) {
        let v0 = 0;
        let v1 = 0x1::vector::length<0x2::coin::Coin<LP<T0, T1>>>(&arg0);
        assert!(v1 > 0, 1012);
        let v2 = 0;
        let v3 = 0;
        let v4 = 0x1::vector::empty<u64>();
        let v5 = 0x2::coin::zero<LP<T0, T1>>(arg2);
        while (v0 < v1) {
            let v6 = 0x1::vector::pop_back<0x2::coin::Coin<LP<T0, T1>>>(&mut arg0);
            let v7 = 0x2::table::remove<0x2::object::ID, vector<u64>>(&mut arg1.table, 0x2::object::id<0x2::coin::Coin<LP<T0, T1>>>(&v6));
            v2 = v2 + 0x1::vector::pop_back<u64>(&mut v7);
            v3 = v3 + 0x1::vector::pop_back<u64>(&mut v7);
            0x1::vector::destroy_empty<u64>(v7);
            0x2::pay::join<LP<T0, T1>>(&mut v5, v6);
            v0 = v0 + 1;
        };
        0x1::vector::destroy_empty<0x2::coin::Coin<LP<T0, T1>>>(arg0);
        0x1::vector::push_back<u64>(&mut v4, v3);
        0x1::vector::push_back<u64>(&mut v4, v2);
        (v5, v4)
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

    public fun remove_liquidity<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<LP<T0, T1>>, arg2: vector<u64>, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert!(0x1::vector::length<u64>(&arg2) == 2, 1004);
        let v0 = *0x1::vector::borrow<u64>(&mut arg2, 0);
        let v1 = *0x1::vector::borrow<u64>(&mut arg2, 1);
        assert!(0x2::coin::value<LP<T0, T1>>(&arg1) == v0 + v1, 1005);
        assert!(0x2::balance::value<T0>(&mut arg0.coin_x) > v0, 1002);
        assert!(0x2::balance::value<T1>(&mut arg0.coin_y) > v1, 1003);
        0x2::balance::decrease_supply<LP<T0, T1>>(&mut arg0.lp_supply, 0x2::coin::into_balance<LP<T0, T1>>(arg1));
        (0x2::coin::take<T0>(&mut arg0.coin_x, v0, arg3), 0x2::coin::take<T1>(&mut arg0.coin_y, v1, arg3))
    }

    public entry fun remove_liquidity_totally<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<LP<T0, T1>>, arg2: &mut Pocket, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<0x2::coin::Coin<LP<T0, T1>>>(&arg1);
        let (v1, v2) = remove_liquidity<T0, T1>(arg0, arg1, *0x2::table::borrow<0x2::object::ID, vector<u64>>(&mut arg2.table, v0), arg3);
        let v3 = v2;
        let v4 = v1;
        assert!(0x2::coin::value<T0>(&v4) > 0 && 0x2::coin::value<T1>(&v3) > 0, 1011);
        let v5 = 0x2::table::remove<0x2::object::ID, vector<u64>>(&mut arg2.table, v0);
        0x1::vector::remove<u64>(&mut v5, 0);
        0x1::vector::remove<u64>(&mut v5, 0);
        let v6 = 0x2::tx_context::sender(arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, v6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v3, v6);
    }

    public fun swap_x_outto_y<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::coin::value<T0>(&arg1);
        0x2::coin::put<T0>(&mut arg0.coin_x, arg1);
        assert!(v0 < 0x2::balance::value<T1>(&mut arg0.coin_y), 1003);
        0x2::coin::take<T1>(&mut arg0.coin_y, v0, arg2)
    }

    public entry fun swap_x_to_y<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: vector<0x2::coin::Coin<T0>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::zero<T0>(arg3);
        0x2::pay::join_vec<T0>(&mut v0, arg1);
        let v1 = 0x2::coin::split<T0>(&mut v0, arg2, arg3);
        let v2 = swap_x_outto_y<T0, T1>(arg0, v1, arg3);
        let v3 = 0x2::tx_context::sender(arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v2, v3);
    }

    public fun swap_y_into_x<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::coin::value<T1>(&arg1);
        0x2::coin::put<T1>(&mut arg0.coin_y, arg1);
        assert!(v0 < 0x2::balance::value<T0>(&mut arg0.coin_x), 1002);
        0x2::coin::take<T0>(&mut arg0.coin_x, v0, arg2)
    }

    public entry fun swap_y_to_x<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: vector<0x2::coin::Coin<T1>>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::zero<T1>(arg3);
        0x2::pay::join_vec<T1>(&mut v0, arg1);
        let v1 = 0x2::coin::split<T1>(&mut v0, arg2, arg3);
        let v2 = swap_y_into_x<T0, T1>(arg0, v1, arg3);
        let v3 = 0x2::tx_context::sender(arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v0, v3);
    }

    public fun withdraw<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x2::coin::Coin<LP<T0, T1>>, arg2: &mut vector<u64>, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert!(0x2::balance::value<T0>(&mut arg0.coin_x) > arg3, 1002);
        assert!(0x2::balance::value<T1>(&mut arg0.coin_y) > arg4, 1003);
        assert!(0x2::coin::value<LP<T0, T1>>(arg1) >= arg3 + arg4, 1006);
        let v0 = 0x1::vector::borrow_mut<u64>(arg2, 0);
        *v0 = *v0 - arg3;
        let v1 = 0x1::vector::borrow_mut<u64>(arg2, 1);
        *v1 = *v1 - arg4;
        0x2::balance::decrease_supply<LP<T0, T1>>(&mut arg0.lp_supply, 0x2::coin::into_balance<LP<T0, T1>>(0x2::coin::split<LP<T0, T1>>(arg1, arg3 + arg4, arg5)));
        (0x2::coin::take<T0>(&mut arg0.coin_x, arg3, arg5), 0x2::coin::take<T1>(&mut arg0.coin_y, arg4, arg5))
    }

    public entry fun withdraw_out<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: vector<0x2::coin::Coin<LP<T0, T1>>>, arg2: u64, arg3: u64, arg4: &mut Pocket, arg5: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = join_lp_vec<T0, T1>(arg1, arg4, arg5);
        let v2 = v1;
        let v3 = v0;
        let v4 = &mut v3;
        let v5 = &mut v2;
        let (v6, v7) = withdraw<T0, T1>(arg0, v4, v5, arg2, arg3, arg5);
        0x2::table::add<0x2::object::ID, vector<u64>>(&mut arg4.table, 0x2::object::id<0x2::coin::Coin<LP<T0, T1>>>(&v3), v2);
        let v8 = 0x2::tx_context::sender(arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v6, v8);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v7, v8);
        0x2::transfer::public_transfer<0x2::coin::Coin<LP<T0, T1>>>(v3, v8);
    }

    // decompiled from Move bytecode v6
}

