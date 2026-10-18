module 0xddf2070ae1e9679962e2cee81fb6f28198e1cbaa40729a6d551d6127db8e4589::deepbook {
    struct Loan {
        inner: 0x1::option::Option<0x780c4607e650c9facacf3594a83cc73751bdd4e4035e887c27f1bde17421f11b::deepbook::Loan>,
    }

    public fun bm_swap_a2b<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: 0x2::balance::Balance<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, 0x2::balance::Balance<T0>) {
        if (0x2::balance::value<T0>(&arg2) == 0) {
            0x2::balance::destroy_zero<T0>(arg2);
            return (0x2::balance::zero<T1>(), 0x2::balance::zero<T0>())
        };
        0x780c4607e650c9facacf3594a83cc73751bdd4e4035e887c27f1bde17421f11b::deepbook::bm_swap_a2b<T0, T1>(arg0, arg1, arg2, 0, arg3, arg4)
    }

    public fun bm_swap_b2a<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: 0x2::balance::Balance<T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        if (0x2::balance::value<T1>(&arg2) == 0) {
            0x2::balance::destroy_zero<T1>(arg2);
            return (0x2::balance::zero<T0>(), 0x2::balance::zero<T1>())
        };
        0x780c4607e650c9facacf3594a83cc73751bdd4e4035e887c27f1bde17421f11b::deepbook::bm_swap_b2a<T0, T1>(arg0, arg1, arg2, 0, arg3, arg4)
    }

    public fun borrow_base<T0, T1>(arg0: &0xa3f107c479ad6754fb5218aa703d0539bc16245a74368e73a84832f45167cb7b::search::Decision, arg1: u64, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, Loan) {
        let v0 = 0xa3f107c479ad6754fb5218aa703d0539bc16245a74368e73a84832f45167cb7b::search::amount(arg0, arg1);
        if (v0 == 0) {
            let v1 = Loan{inner: 0x1::option::none<0x780c4607e650c9facacf3594a83cc73751bdd4e4035e887c27f1bde17421f11b::deepbook::Loan>()};
            return (0x2::balance::zero<T0>(), v1)
        };
        let (v2, v3) = 0x780c4607e650c9facacf3594a83cc73751bdd4e4035e887c27f1bde17421f11b::deepbook::borrow_base<T0, T1>(arg2, v0, arg3);
        let v4 = Loan{inner: 0x1::option::some<0x780c4607e650c9facacf3594a83cc73751bdd4e4035e887c27f1bde17421f11b::deepbook::Loan>(v3)};
        (v2, v4)
    }

    public fun borrow_quote<T0, T1>(arg0: &0xa3f107c479ad6754fb5218aa703d0539bc16245a74368e73a84832f45167cb7b::search::Decision, arg1: u64, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, Loan) {
        let v0 = 0xa3f107c479ad6754fb5218aa703d0539bc16245a74368e73a84832f45167cb7b::search::amount(arg0, arg1);
        if (v0 == 0) {
            let v1 = Loan{inner: 0x1::option::none<0x780c4607e650c9facacf3594a83cc73751bdd4e4035e887c27f1bde17421f11b::deepbook::Loan>()};
            return (0x2::balance::zero<T1>(), v1)
        };
        let (v2, v3) = 0x780c4607e650c9facacf3594a83cc73751bdd4e4035e887c27f1bde17421f11b::deepbook::borrow_quote<T0, T1>(arg2, v0, arg3);
        let v4 = Loan{inner: 0x1::option::some<0x780c4607e650c9facacf3594a83cc73751bdd4e4035e887c27f1bde17421f11b::deepbook::Loan>(v3)};
        (v2, v4)
    }

    public fun return_base<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: Loan, arg2: 0x2::balance::Balance<T0>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let Loan { inner: v0 } = arg1;
        if (0x1::option::is_none<0x780c4607e650c9facacf3594a83cc73751bdd4e4035e887c27f1bde17421f11b::deepbook::Loan>(&v0)) {
            0x1::option::destroy_none<0x780c4607e650c9facacf3594a83cc73751bdd4e4035e887c27f1bde17421f11b::deepbook::Loan>(v0);
            return arg2
        };
        0x780c4607e650c9facacf3594a83cc73751bdd4e4035e887c27f1bde17421f11b::deepbook::return_base<T0, T1>(arg0, 0x1::option::destroy_some<0x780c4607e650c9facacf3594a83cc73751bdd4e4035e887c27f1bde17421f11b::deepbook::Loan>(v0), arg2, arg3)
    }

    public fun return_quote<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: Loan, arg2: 0x2::balance::Balance<T1>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        let Loan { inner: v0 } = arg1;
        if (0x1::option::is_none<0x780c4607e650c9facacf3594a83cc73751bdd4e4035e887c27f1bde17421f11b::deepbook::Loan>(&v0)) {
            0x1::option::destroy_none<0x780c4607e650c9facacf3594a83cc73751bdd4e4035e887c27f1bde17421f11b::deepbook::Loan>(v0);
            return arg2
        };
        0x780c4607e650c9facacf3594a83cc73751bdd4e4035e887c27f1bde17421f11b::deepbook::return_quote<T0, T1>(arg0, 0x1::option::destroy_some<0x780c4607e650c9facacf3594a83cc73751bdd4e4035e887c27f1bde17421f11b::deepbook::Loan>(v0), arg2, arg3)
    }

    public fun swap_a2b<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        if (0x2::balance::value<T0>(&arg1) == 0) {
            0x2::balance::destroy_zero<T0>(arg1);
            return 0x2::balance::zero<T1>()
        };
        0x780c4607e650c9facacf3594a83cc73751bdd4e4035e887c27f1bde17421f11b::deepbook::swap_a2b<T0, T1>(arg0, arg1, arg2, arg3)
    }

    public fun swap_b2a<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: 0x2::balance::Balance<T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        if (0x2::balance::value<T1>(&arg1) == 0) {
            0x2::balance::destroy_zero<T1>(arg1);
            return 0x2::balance::zero<T0>()
        };
        0x780c4607e650c9facacf3594a83cc73751bdd4e4035e887c27f1bde17421f11b::deepbook::swap_b2a<T0, T1>(arg0, arg1, arg2, arg3)
    }

    public fun bm_quote_a2b<T0, T1>(arg0: &mut 0xa3f107c479ad6754fb5218aa703d0539bc16245a74368e73a84832f45167cb7b::search::Search, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: &0x2::clock::Clock) {
        quote<T0, T1>(arg0, arg1, true, true, arg2);
    }

    public fun bm_quote_b2a<T0, T1>(arg0: &mut 0xa3f107c479ad6754fb5218aa703d0539bc16245a74368e73a84832f45167cb7b::search::Search, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: &0x2::clock::Clock) {
        quote<T0, T1>(arg0, arg1, false, true, arg2);
    }

    public fun out<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: bool, arg2: bool, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock) : u64 {
        if (arg3 == 0) {
            return 0
        };
        if (arg1) {
            if (arg2) {
                let v1 = arg3 - arg3 % arg4;
                if (v1 < arg5) {
                    return 0
                };
                let (_, v3, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_quote_quantity_out<T0, T1>(arg0, v1, arg6);
                v3
            } else {
                let (_, v6, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_quote_quantity_out_input_fee<T0, T1>(arg0, arg3, arg6);
                v6
            }
        } else {
            let v8 = if (arg2) {
                let (v9, _, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_base_quantity_out<T0, T1>(arg0, arg3, arg6);
                v9
            } else {
                let (v12, _, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_base_quantity_out_input_fee<T0, T1>(arg0, arg3, arg6);
                v12
            };
            if (v8 < arg5) {
                0
            } else {
                v8
            }
        }
    }

    fun quote<T0, T1>(arg0: &mut 0xa3f107c479ad6754fb5218aa703d0539bc16245a74368e73a84832f45167cb7b::search::Search, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: bool, arg3: bool, arg4: &0x2::clock::Clock) {
        let v0 = 0xa3f107c479ad6754fb5218aa703d0539bc16245a74368e73a84832f45167cb7b::search::begin(arg0, 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg1));
        let v1 = 0x1::vector::length<u64>(&v0);
        let v2 = vector[];
        if (v1 > 0) {
            let (_, v4, v5) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_book_params<T0, T1>(arg1);
            let v6 = 0;
            while (v6 < v1) {
                0x1::vector::push_back<u64>(&mut v2, out<T0, T1>(arg1, arg2, arg3, *0x1::vector::borrow<u64>(&v0, v6), v4, v5, arg4));
                v6 = v6 + 1;
            };
        };
        0xa3f107c479ad6754fb5218aa703d0539bc16245a74368e73a84832f45167cb7b::search::end(arg0, v2);
    }

    public fun quote_a2b<T0, T1>(arg0: &mut 0xa3f107c479ad6754fb5218aa703d0539bc16245a74368e73a84832f45167cb7b::search::Search, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: &0x2::clock::Clock) {
        quote<T0, T1>(arg0, arg1, true, false, arg2);
    }

    public fun quote_b2a<T0, T1>(arg0: &mut 0xa3f107c479ad6754fb5218aa703d0539bc16245a74368e73a84832f45167cb7b::search::Search, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: &0x2::clock::Clock) {
        quote<T0, T1>(arg0, arg1, false, false, arg2);
    }

    // decompiled from Move bytecode v7
}

