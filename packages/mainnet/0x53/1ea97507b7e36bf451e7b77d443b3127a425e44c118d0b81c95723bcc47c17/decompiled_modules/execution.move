module 0xb1505f4a324b59b0467827ef061ca6760729de028022a3ea4ac3fa19428871a8::execution {
    struct RouteExecution<phantom T0> has copy, drop {
        candidate_index: u64,
        principal: u64,
        amount_out: u64,
        realized_profit: u64,
        realized_loss: u64,
    }

    struct BatchExecution<phantom T0> has copy, drop {
        starting_balance: u64,
        ending_balance: u64,
        realized_profit: u64,
    }

    public fun assert_batch_profit<T0>(arg0: &0x2::coin::Coin<T0>, arg1: u64, arg2: u64) : u64 {
        let v0 = 0x2::coin::value<T0>(arg0);
        assert!((v0 as u128) >= (arg1 as u128) + (arg2 as u128), 403);
        let v1 = v0 - arg1;
        let v2 = BatchExecution<T0>{
            starting_balance : arg1,
            ending_balance   : v0,
            realized_profit  : v1,
        };
        0x2::event::emit<BatchExecution<T0>>(v2);
        v1
    }

    public fun assert_maximum_asset_loss<T0>(arg0: &0x2::coin::Coin<T0>, arg1: u64, arg2: u64) : u64 {
        let v0 = 0x2::coin::value<T0>(arg0);
        assert!(v0 <= arg1, 405);
        let v1 = arg1 - v0;
        assert!(v1 <= arg2, 405);
        v1
    }

    public fun capital_balance<T0>(arg0: &0x2::coin::Coin<T0>) : u64 {
        0x2::coin::value<T0>(arg0)
    }

    fun checked_amount(arg0: &0xb1505f4a324b59b0467827ef061ca6760729de028022a3ea4ac3fa19428871a8::optimizer::OptimizeResult) : u64 {
        let v0 = 0xb1505f4a324b59b0467827ef061ca6760729de028022a3ea4ac3fa19428871a8::optimizer::amount_in(arg0);
        assert!(v0 > 0 && v0 <= 18446744073709551615, 401);
        (v0 as u64)
    }

    public fun executable_profit(arg0: &0xb1505f4a324b59b0467827ef061ca6760729de028022a3ea4ac3fa19428871a8::optimizer::OptimizeResult, arg1: u128) : u128 {
        if (is_executable(arg0, arg1)) {
            0xb1505f4a324b59b0467827ef061ca6760729de028022a3ea4ac3fa19428871a8::optimizer::gross_profit(arg0)
        } else {
            0
        }
    }

    public fun is_complete_executable(arg0: &0xb1505f4a324b59b0467827ef061ca6760729de028022a3ea4ac3fa19428871a8::optimizer::OptimizeResult, arg1: u128) : bool {
        0xb1505f4a324b59b0467827ef061ca6760729de028022a3ea4ac3fa19428871a8::optimizer::complete(arg0) && is_executable(arg0, arg1)
    }

    public fun is_executable(arg0: &0xb1505f4a324b59b0467827ef061ca6760729de028022a3ea4ac3fa19428871a8::optimizer::OptimizeResult, arg1: u128) : bool {
        if (0xb1505f4a324b59b0467827ef061ca6760729de028022a3ea4ac3fa19428871a8::optimizer::found(arg0)) {
            if (0xb1505f4a324b59b0467827ef061ca6760729de028022a3ea4ac3fa19428871a8::optimizer::amount_in(arg0) > 0) {
                if (0xb1505f4a324b59b0467827ef061ca6760729de028022a3ea4ac3fa19428871a8::optimizer::amount_in(arg0) <= 18446744073709551615) {
                    0xb1505f4a324b59b0467827ef061ca6760729de028022a3ea4ac3fa19428871a8::optimizer::gross_profit(arg0) >= arg1
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        }
    }

    public fun optional_is_some<T0>(arg0: &0x1::option::Option<0x2::coin::Coin<T0>>) : bool {
        0x1::option::is_some<0x2::coin::Coin<T0>>(arg0)
    }

    public fun prepare_optional<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: &0xb1505f4a324b59b0467827ef061ca6760729de028022a3ea4ac3fa19428871a8::optimizer::OptimizeResult, arg2: u128, arg3: &mut 0x2::tx_context::TxContext) : (0x1::option::Option<0x2::coin::Coin<T0>>, u64) {
        if (!is_executable(arg1, arg2)) {
            return (0x1::option::none<0x2::coin::Coin<T0>>(), 0)
        };
        let v0 = checked_amount(arg1);
        (0x1::option::some<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(arg0, v0, arg3)), v0)
    }

    public fun prepare_selected_optional<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: &0xb1505f4a324b59b0467827ef061ca6760729de028022a3ea4ac3fa19428871a8::optimizer::OptimizeResult, arg2: bool, arg3: u128, arg4: &mut 0x2::tx_context::TxContext) : (0x1::option::Option<0x2::coin::Coin<T0>>, u64) {
        if (!arg2) {
            return (0x1::option::none<0x2::coin::Coin<T0>>(), 0)
        };
        prepare_optional<T0>(arg0, arg1, arg3, arg4)
    }

    public fun require_amount(arg0: &0xb1505f4a324b59b0467827ef061ca6760729de028022a3ea4ac3fa19428871a8::optimizer::OptimizeResult, arg1: u128) : u64 {
        assert!(is_executable(arg0, arg1), 400);
        checked_amount(arg0)
    }

    public fun require_total_amount(arg0: vector<u64>) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(&arg0)) {
            let v2 = v0 + (*0x1::vector::borrow<u64>(&arg0, v1) as u128);
            v0 = v2;
            assert!(v2 <= 18446744073709551615, 401);
            v1 = v1 + 1;
        };
        assert!(v0 > 0, 400);
        (v0 as u64)
    }

    public fun select_non_overlapping(arg0: vector<u128>, arg1: vector<vector<u64>>) : vector<bool> {
        let v0 = 0x1::vector::length<u128>(&arg0);
        assert!(v0 == 0x1::vector::length<vector<u64>>(&arg1), 404);
        let v1 = vector[];
        let v2 = vector[];
        let v3 = 0;
        while (v3 < v0) {
            0x1::vector::push_back<bool>(&mut v1, false);
            0x1::vector::push_back<bool>(&mut v2, false);
            let v4 = 0x1::vector::borrow<vector<u64>>(&arg1, v3);
            let v5 = 0;
            while (v5 < 0x1::vector::length<u64>(v4)) {
                let v6 = *0x1::vector::borrow<u64>(v4, v5);
                assert!(v6 < v0 && v6 != v3, 404);
                v5 = v5 + 1;
            };
            v3 = v3 + 1;
        };
        let v7 = 0;
        while (v7 < v0) {
            v3 = 0;
            while (v3 < v0) {
                if (!*0x1::vector::borrow<bool>(&v2, v3)) {
                };
                v3 = v3 + 1;
            };
            if (v0 == v0) {
                break
            };
            *0x1::vector::borrow_mut<bool>(&mut v1, v0) = true;
            *0x1::vector::borrow_mut<bool>(&mut v2, v0) = true;
            let v8 = 0x1::vector::borrow<vector<u64>>(&arg1, v0);
            let v9 = 0;
            while (v9 < 0x1::vector::length<u64>(v8)) {
                *0x1::vector::borrow_mut<bool>(&mut v2, *0x1::vector::borrow<u64>(v8, v9)) = true;
                v9 = v9 + 1;
            };
            v7 = v7 + 1;
        };
        v1
    }

    public fun selected_amount(arg0: &0xb1505f4a324b59b0467827ef061ca6760729de028022a3ea4ac3fa19428871a8::optimizer::OptimizeResult, arg1: bool, arg2: u128) : u64 {
        if (!arg1 || !is_executable(arg0, arg2)) {
            return 0
        };
        checked_amount(arg0)
    }

    public fun selected_at(arg0: &vector<bool>, arg1: u64) : bool {
        *0x1::vector::borrow<bool>(arg0, arg1)
    }

    public fun settle_nettable_indexed<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: 0x1::option::Option<0x2::coin::Coin<T0>>, arg2: u64, arg3: u64) : bool {
        let (v0, v1) = settle_nettable_inner<T0>(arg0, arg1, arg2);
        if (v0) {
            let v2 = v1 >= arg2;
            let v3 = if (v2) {
                v1 - arg2
            } else {
                0
            };
            let v4 = if (v2) {
                0
            } else {
                arg2 - v1
            };
            let v5 = RouteExecution<T0>{
                candidate_index : arg3,
                principal       : arg2,
                amount_out      : v1,
                realized_profit : v3,
                realized_loss   : v4,
            };
            0x2::event::emit<RouteExecution<T0>>(v5);
        };
        v0
    }

    fun settle_nettable_inner<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: 0x1::option::Option<0x2::coin::Coin<T0>>, arg2: u64) : (bool, u64) {
        if (0x1::option::is_none<0x2::coin::Coin<T0>>(&arg1)) {
            assert!(arg2 == 0, 402);
            0x1::option::destroy_none<0x2::coin::Coin<T0>>(arg1);
            return (false, 0)
        };
        assert!(arg2 > 0, 402);
        let v0 = 0x1::option::destroy_some<0x2::coin::Coin<T0>>(arg1);
        0x2::coin::join<T0>(arg0, v0);
        (true, 0x2::coin::value<T0>(&v0))
    }

    // decompiled from Move bytecode v7
}

