module 0x3979725dd7b8b580de43c3121661cb1fdff5a54ca74a4947e9a9c286aa831bc5::d {
    struct GlobalConfig has key {
        id: 0x2::object::UID,
        admin: address,
        operators: 0x2::vec_set::VecSet<address>,
        balance_deep: 0x2::balance::Balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>,
        max_deep: u64,
    }

    public fun add_operator(arg0: &mut GlobalConfig, arg1: address, arg2: &0x2::tx_context::TxContext) {
        check_admin(arg0, arg2);
        0x2::vec_set::insert<address>(&mut arg0.operators, arg1);
    }

    fun check_admin(arg0: &GlobalConfig, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 1);
    }

    public fun deposit(arg0: &mut GlobalConfig, arg1: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg2: &0x2::tx_context::TxContext) {
        check_admin(arg0, arg2);
        0x2::balance::join<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&mut arg0.balance_deep, 0x2::coin::into_balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg1));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = GlobalConfig{
            id           : 0x2::object::new(arg0),
            admin        : 0x2::tx_context::sender(arg0),
            operators    : 0x2::vec_set::singleton<address>(0x2::tx_context::sender(arg0)),
            balance_deep : 0x2::balance::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(),
            max_deep     : 100000000,
        };
        0x2::transfer::share_object<GlobalConfig>(v0);
    }

    public fun remove_operator(arg0: &mut GlobalConfig, arg1: address, arg2: &0x2::tx_context::TxContext) {
        check_admin(arg0, arg2);
        0x2::vec_set::remove<address>(&mut arg0.operators, &arg1);
    }

    fun seq<T0, T1>(arg0: &mut GlobalConfig, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: bool, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = 0x2::tx_context::sender(arg7);
        assert!(0x2::vec_set::contains<address>(&arg0.operators, &v0), 2);
        let v1 = if (arg4) {
            take_deep<T0, T1>(arg0, arg1, 0x2::coin::value<T0>(&arg2), 0x2::coin::value<T1>(&arg3), arg6, arg7)
        } else {
            0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg7)
        };
        let (v2, v3, v4) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_quantity<T0, T1>(arg1, arg2, arg3, v1, arg5, arg6, arg7);
        0x2::balance::join<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&mut arg0.balance_deep, 0x2::coin::into_balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v4));
        (v2, v3)
    }

    public fun set_max_deep(arg0: &mut GlobalConfig, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        check_admin(arg0, arg2);
        arg0.max_deep = arg1;
    }

    public fun sxy<T0, T1>(arg0: &mut GlobalConfig, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: bool, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::coin::zero<T1>(arg5);
        let (v1, v2) = seq<T0, T1>(arg0, arg1, arg2, v0, arg3, 0, arg4, arg5);
        0x3979725dd7b8b580de43c3121661cb1fdff5a54ca74a4947e9a9c286aa831bc5::u::tod<T0>(v1, 0x2::tx_context::sender(arg5));
        v2
    }

    public fun syx<T0, T1>(arg0: &mut GlobalConfig, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T1>, arg3: bool, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::coin::zero<T0>(arg5);
        let (v1, v2) = seq<T0, T1>(arg0, arg1, v0, arg2, arg3, 0, arg4, arg5);
        0x3979725dd7b8b580de43c3121661cb1fdff5a54ca74a4947e9a9c286aa831bc5::u::tod<T1>(v2, 0x2::tx_context::sender(arg5));
        v1
    }

    fun take_deep<T0, T1>(arg0: &mut GlobalConfig, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP> {
        let (_, _, v2) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_quantity_out<T0, T1>(arg1, arg2, arg3, arg4);
        let v3 = if (v2 == 0) {
            true
        } else if (v2 > arg0.max_deep) {
            true
        } else {
            v2 > 0x2::balance::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&arg0.balance_deep)
        };
        if (v3) {
            return 0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg5)
        };
        0x2::coin::take<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&mut arg0.balance_deep, v2, arg5)
    }

    public fun transfer_ownership(arg0: &mut GlobalConfig, arg1: address, arg2: &0x2::tx_context::TxContext) {
        check_admin(arg0, arg2);
        arg0.admin = arg1;
    }

    public fun withdraw(arg0: &mut GlobalConfig, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        check_admin(arg0, arg2);
        0x3979725dd7b8b580de43c3121661cb1fdff5a54ca74a4947e9a9c286aa831bc5::u::tod<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(0x2::coin::take<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&mut arg0.balance_deep, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v7
}

