module 0xd37ca38e54a3218bbdf7417b9817d0075ebd56ed65584a382af87854e2605066::execution {
    struct MockPool<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        base: 0x2::balance::Balance<T0>,
        quote: 0x2::balance::Balance<T1>,
        price_num: u64,
        price_den: u64,
    }

    public fun id<T0, T1>(arg0: &MockPool<T0, T1>) : 0x2::object::ID {
        0x2::object::id<MockPool<T0, T1>>(arg0)
    }

    public fun base_reserve<T0, T1>(arg0: &MockPool<T0, T1>) : u64 {
        0x2::balance::value<T0>(&arg0.base)
    }

    public(friend) fun execute_mock<T0, T1>(arg0: &mut MockPool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = (((0x2::coin::value<T1>(&arg1) as u128) * (arg0.price_num as u128) / (arg0.price_den as u128)) as u64);
        assert!(v0 >= arg2, 0xd37ca38e54a3218bbdf7417b9817d0075ebd56ed65584a382af87854e2605066::errors::slippage());
        assert!(0x2::balance::value<T0>(&arg0.base) >= v0, 0xd37ca38e54a3218bbdf7417b9817d0075ebd56ed65584a382af87854e2605066::errors::slippage());
        0x2::balance::join<T1>(&mut arg0.quote, 0x2::coin::into_balance<T1>(arg1));
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.base, v0), arg3)
    }

    public(friend) fun execute_real<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>) {
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_quote_for_base<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5)
    }

    public fun fund_base<T0, T1>(arg0: &mut MockPool<T0, T1>, arg1: 0x2::coin::Coin<T0>) {
        0x2::balance::join<T0>(&mut arg0.base, 0x2::coin::into_balance<T0>(arg1));
    }

    public fun fund_quote<T0, T1>(arg0: &mut MockPool<T0, T1>, arg1: 0x2::coin::Coin<T1>) {
        0x2::balance::join<T1>(&mut arg0.quote, 0x2::coin::into_balance<T1>(arg1));
    }

    public fun new_mock_pool<T0, T1>(arg0: u64, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(arg1 > 0, 0xd37ca38e54a3218bbdf7417b9817d0075ebd56ed65584a382af87854e2605066::errors::slippage());
        let v0 = MockPool<T0, T1>{
            id        : 0x2::object::new(arg2),
            base      : 0x2::balance::zero<T0>(),
            quote     : 0x2::balance::zero<T1>(),
            price_num : arg0,
            price_den : arg1,
        };
        0x2::transfer::share_object<MockPool<T0, T1>>(v0);
        0x2::object::id<MockPool<T0, T1>>(&v0)
    }

    public fun price<T0, T1>(arg0: &MockPool<T0, T1>) : (u64, u64) {
        (arg0.price_num, arg0.price_den)
    }

    public fun quote_reserve<T0, T1>(arg0: &MockPool<T0, T1>) : u64 {
        0x2::balance::value<T1>(&arg0.quote)
    }

    public fun real_pool_id<T0, T1>(arg0: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>) : 0x2::object::ID {
        0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg0)
    }

    // decompiled from Move bytecode v7
}

