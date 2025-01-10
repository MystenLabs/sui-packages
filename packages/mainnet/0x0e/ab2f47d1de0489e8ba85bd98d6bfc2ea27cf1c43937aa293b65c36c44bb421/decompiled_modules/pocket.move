module 0xeab2f47d1de0489e8ba85bd98d6bfc2ea27cf1c43937aa293b65c36c44bb421::pocket {
    struct Pocket has store {
        bag: 0x2::bag::Bag,
        balances: vector<CoinBalance>,
    }

    struct CoinBalance has copy, drop, store {
        coin_type: 0x1::type_name::TypeName,
        value: u64,
    }

    public fun destroy_empty(arg0: Pocket) {
        let Pocket {
            bag      : v0,
            balances : v1,
        } = arg0;
        0x2::bag::destroy_empty(v0);
        0x1::vector::destroy_empty<CoinBalance>(v1);
    }

    public fun contains<T0>(arg0: &Pocket) : bool {
        0x2::bag::contains<0x1::type_name::TypeName>(&arg0.bag, 0x1::type_name::get<T0>())
    }

    public fun is_empty(arg0: &Pocket) : bool {
        0x2::bag::is_empty(&arg0.bag)
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : Pocket {
        Pocket{
            bag      : 0x2::bag::new(arg0),
            balances : 0x1::vector::empty<CoinBalance>(),
        }
    }

    public(friend) fun claim<T0>(arg0: &mut Pocket, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        if (contains<T0>(arg0)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(withdraw_all<T0>(arg0), arg2), arg1);
        };
    }

    public(friend) fun deposit<T0>(arg0: &mut Pocket, arg1: 0x2::balance::Balance<T0>) {
        if (0x2::balance::value<T0>(&arg1) > 0) {
            let v0 = 0x1::type_name::get<T0>();
            let v1 = &mut arg0.bag;
            let v2 = &mut arg0.balances;
            if (0x2::bag::contains<0x1::type_name::TypeName>(v1, v0)) {
                let v3 = 0;
                let v4;
                while (v3 < 0x1::vector::length<CoinBalance>(v2)) {
                    if (0x1::vector::borrow<CoinBalance>(v2, v3).coin_type == v0) {
                        v4 = 0x1::option::some<u64>(v3);
                        /* label 7 */
                        0x1::vector::borrow_mut<CoinBalance>(v2, *0x1::option::borrow<u64>(&v4)).value = 0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(v1, v0), arg1);
                        return
                    };
                    v3 = v3 + 1;
                };
                v4 = 0x1::option::none<u64>();
                /* goto 7 */
            } else {
                let v5 = CoinBalance{
                    coin_type : v0,
                    value     : 0x2::balance::value<T0>(&arg1),
                };
                0x1::vector::push_back<CoinBalance>(v2, v5);
                0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(v1, v0, arg1);
                return
            };
        } else {
            0x2::balance::destroy_zero<T0>(arg1);
            return
        };
    }

    public fun get_all_balances(arg0: &Pocket) : vector<CoinBalance> {
        arg0.balances
    }

    public fun get_amount<T0>(arg0: &Pocket) : u64 {
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.bag, v0)) {
            0x2::balance::value<T0>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.bag, v0))
        } else {
            0
        }
    }

    public fun get_balance<T0>(arg0: &Pocket) : CoinBalance {
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.bag, v0)) {
            CoinBalance{coin_type: v0, value: 0x2::balance::value<T0>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.bag, v0))}
        } else {
            zero_balance<T0>()
        }
    }

    public fun get_pool_amounts<T0, T1>(arg0: &Pocket) : (u64, u64) {
        (get_amount<T0>(arg0), get_amount<T1>(arg0))
    }

    public fun get_pool_balance<T0, T1>(arg0: &Pocket) : (CoinBalance, CoinBalance) {
        (get_balance<T0>(arg0), get_balance<T1>(arg0))
    }

    public fun join_balances(arg0: vector<CoinBalance>, arg1: vector<CoinBalance>) : vector<CoinBalance> {
        let v0 = 0x1::vector::empty<CoinBalance>();
        let v1 = 0x1::vector::empty<CoinBalance>();
        0x1::vector::append<CoinBalance>(&mut v1, arg1);
        let v2 = 0;
        /* label 1 */
        while (v2 < 0x1::vector::length<CoinBalance>(&arg0)) {
            let v3 = 0x1::vector::borrow<CoinBalance>(&arg0, v2);
            let v4 = &arg1;
            let v5 = 0;
            let v6;
            while (v5 < 0x1::vector::length<CoinBalance>(v4)) {
                if (0x1::vector::borrow<CoinBalance>(v4, v5).coin_type == v3.coin_type) {
                    v6 = 0x1::option::some<u64>(v5);
                    /* label 8 */
                    if (0x1::option::is_some<u64>(&v6)) {
                        let v7 = *0x1::option::borrow<u64>(&v6);
                        let v8 = CoinBalance{
                            coin_type : v3.coin_type,
                            value     : v3.value + 0x1::vector::borrow<CoinBalance>(&arg1, v7).value,
                        };
                        0x1::vector::push_back<CoinBalance>(&mut v0, v8);
                        0x1::vector::remove<CoinBalance>(&mut v1, v7);
                    } else {
                        0x1::vector::push_back<CoinBalance>(&mut v0, *v3);
                    };
                    v2 = v2 + 1;
                    /* goto 1 */
                    continue
                };
                v5 = v5 + 1;
            };
            v6 = 0x1::option::none<u64>();
            /* goto 8 */
        };
        0x1::vector::append<CoinBalance>(&mut v0, v1);
        v0
    }

    public(friend) fun withdraw<T0>(arg0: &mut Pocket, arg1: 0x1::option::Option<u64>) : 0x2::balance::Balance<T0> {
        let v0 = if (0x1::option::is_some<u64>(&arg1)) {
            let v1 = 0;
            0x1::option::borrow<u64>(&arg1) == &v1
        } else {
            false
        };
        if (v0) {
            return 0x2::balance::zero<T0>()
        };
        let v2 = 0x1::type_name::get<T0>();
        let v3 = &mut arg0.bag;
        if (!0x2::bag::contains<0x1::type_name::TypeName>(v3, v2)) {
            return 0x2::balance::zero<T0>()
        };
        let v4 = &mut arg0.balances;
        let v5 = 0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(v3, v2);
        let v6 = if (0x1::option::is_none<u64>(&arg1)) {
            true
        } else {
            let v7 = 0x2::balance::value<T0>(v5);
            &v7 == 0x1::option::borrow<u64>(&arg1)
        };
        let v8 = if (v6) {
            let v9 = 0;
            /* label 15 */
            let v8;
            while (v9 < 0x1::vector::length<CoinBalance>(v4)) {
                if (0x1::vector::borrow<CoinBalance>(v4, v9).coin_type == v2) {
                    /* label 18 */
                    let v10 = 0x1::option::some<u64>(v9);
                    0x1::vector::remove<CoinBalance>(v4, *0x1::option::borrow<u64>(&v10));
                    v8 = 0x2::bag::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(v3, v2);
                    return v8
                } else {
                    /* goto 20 */
                };
            };
            v8
        } else {
            0x2::balance::split<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(v3, v2), *0x1::option::borrow<u64>(&arg1))
        };
        return v8
        /* label 20 */
        /* goto 15 */
        continue;
        /* goto 18 */
    }

    public(friend) fun withdraw_all<T0>(arg0: &mut Pocket) : 0x2::balance::Balance<T0> {
        withdraw<T0>(arg0, 0x1::option::none<u64>())
    }

    public fun zero_balance<T0>() : CoinBalance {
        CoinBalance{
            coin_type : 0x1::type_name::get<T0>(),
            value     : 0,
        }
    }

    // decompiled from Move bytecode v6
}

