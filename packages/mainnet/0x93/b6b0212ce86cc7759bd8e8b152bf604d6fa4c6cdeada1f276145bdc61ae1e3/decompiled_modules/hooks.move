module 0x93b6b0212ce86cc7759bd8e8b152bf604d6fa4c6cdeada1f276145bdc61ae1e3::hooks {
    public fun finish<T0>(arg0: &0x93b6b0212ce86cc7759bd8e8b152bf604d6fa4c6cdeada1f276145bdc61ae1e3::interest_pool::InterestPool<T0>, arg1: 0x93b6b0212ce86cc7759bd8e8b152bf604d6fa4c6cdeada1f276145bdc61ae1e3::interest_pool::Request) {
        let v0 = 0x93b6b0212ce86cc7759bd8e8b152bf604d6fa4c6cdeada1f276145bdc61ae1e3::interest_pool::name(&arg1);
        let v1 = 0x1::string::utf8(b"F");
        assert!(0x1::string::index_of(&v0, &v1) == 0, 0x93b6b0212ce86cc7759bd8e8b152bf604d6fa4c6cdeada1f276145bdc61ae1e3::errors::must_be_finish_request());
        0x93b6b0212ce86cc7759bd8e8b152bf604d6fa4c6cdeada1f276145bdc61ae1e3::interest_pool::confirm<T0>(arg0, arg1);
    }

    public(friend) fun finish_add_liquidity<T0>(arg0: &0x93b6b0212ce86cc7759bd8e8b152bf604d6fa4c6cdeada1f276145bdc61ae1e3::interest_pool::InterestPool<T0>, arg1: 0x93b6b0212ce86cc7759bd8e8b152bf604d6fa4c6cdeada1f276145bdc61ae1e3::interest_pool::Request) : 0x93b6b0212ce86cc7759bd8e8b152bf604d6fa4c6cdeada1f276145bdc61ae1e3::interest_pool::Request {
        assert!(0x93b6b0212ce86cc7759bd8e8b152bf604d6fa4c6cdeada1f276145bdc61ae1e3::interest_pool::has_add_liquidity_hook<T0>(arg0), 0x93b6b0212ce86cc7759bd8e8b152bf604d6fa4c6cdeada1f276145bdc61ae1e3::errors::this_pool_has_no_hooks());
        let v0 = 0x93b6b0212ce86cc7759bd8e8b152bf604d6fa4c6cdeada1f276145bdc61ae1e3::interest_pool::name(&arg1);
        let v1 = 0x93b6b0212ce86cc7759bd8e8b152bf604d6fa4c6cdeada1f276145bdc61ae1e3::interest_pool::start_add_liquidity();
        assert!(0x1::string::bytes(&v0) == &v1, 0x93b6b0212ce86cc7759bd8e8b152bf604d6fa4c6cdeada1f276145bdc61ae1e3::errors::must_be_start_add_liquidity_request());
        0x93b6b0212ce86cc7759bd8e8b152bf604d6fa4c6cdeada1f276145bdc61ae1e3::interest_pool::confirm<T0>(arg0, arg1);
        0x93b6b0212ce86cc7759bd8e8b152bf604d6fa4c6cdeada1f276145bdc61ae1e3::interest_pool::new_request<T0>(arg0, 0x1::string::utf8(0x93b6b0212ce86cc7759bd8e8b152bf604d6fa4c6cdeada1f276145bdc61ae1e3::interest_pool::finish_add_liquidity()))
    }

    public(friend) fun finish_remove_liquidity<T0>(arg0: &0x93b6b0212ce86cc7759bd8e8b152bf604d6fa4c6cdeada1f276145bdc61ae1e3::interest_pool::InterestPool<T0>, arg1: 0x93b6b0212ce86cc7759bd8e8b152bf604d6fa4c6cdeada1f276145bdc61ae1e3::interest_pool::Request) : 0x93b6b0212ce86cc7759bd8e8b152bf604d6fa4c6cdeada1f276145bdc61ae1e3::interest_pool::Request {
        assert!(0x93b6b0212ce86cc7759bd8e8b152bf604d6fa4c6cdeada1f276145bdc61ae1e3::interest_pool::has_remove_liquidity_hook<T0>(arg0), 0x93b6b0212ce86cc7759bd8e8b152bf604d6fa4c6cdeada1f276145bdc61ae1e3::errors::this_pool_has_no_hooks());
        let v0 = 0x93b6b0212ce86cc7759bd8e8b152bf604d6fa4c6cdeada1f276145bdc61ae1e3::interest_pool::name(&arg1);
        let v1 = 0x93b6b0212ce86cc7759bd8e8b152bf604d6fa4c6cdeada1f276145bdc61ae1e3::interest_pool::start_remove_liquidity();
        assert!(0x1::string::bytes(&v0) == &v1, 0x93b6b0212ce86cc7759bd8e8b152bf604d6fa4c6cdeada1f276145bdc61ae1e3::errors::must_be_start_remove_liquidity_request());
        0x93b6b0212ce86cc7759bd8e8b152bf604d6fa4c6cdeada1f276145bdc61ae1e3::interest_pool::confirm<T0>(arg0, arg1);
        0x93b6b0212ce86cc7759bd8e8b152bf604d6fa4c6cdeada1f276145bdc61ae1e3::interest_pool::new_request<T0>(arg0, 0x1::string::utf8(0x93b6b0212ce86cc7759bd8e8b152bf604d6fa4c6cdeada1f276145bdc61ae1e3::interest_pool::finish_remove_liquidity()))
    }

    public(friend) fun finish_swap<T0>(arg0: &0x93b6b0212ce86cc7759bd8e8b152bf604d6fa4c6cdeada1f276145bdc61ae1e3::interest_pool::InterestPool<T0>, arg1: 0x93b6b0212ce86cc7759bd8e8b152bf604d6fa4c6cdeada1f276145bdc61ae1e3::interest_pool::Request) : 0x93b6b0212ce86cc7759bd8e8b152bf604d6fa4c6cdeada1f276145bdc61ae1e3::interest_pool::Request {
        assert!(0x93b6b0212ce86cc7759bd8e8b152bf604d6fa4c6cdeada1f276145bdc61ae1e3::interest_pool::has_swap_hook<T0>(arg0), 0x93b6b0212ce86cc7759bd8e8b152bf604d6fa4c6cdeada1f276145bdc61ae1e3::errors::this_pool_has_no_hooks());
        let v0 = 0x93b6b0212ce86cc7759bd8e8b152bf604d6fa4c6cdeada1f276145bdc61ae1e3::interest_pool::name(&arg1);
        let v1 = 0x93b6b0212ce86cc7759bd8e8b152bf604d6fa4c6cdeada1f276145bdc61ae1e3::interest_pool::start_swap();
        assert!(0x1::string::bytes(&v0) == &v1, 0x93b6b0212ce86cc7759bd8e8b152bf604d6fa4c6cdeada1f276145bdc61ae1e3::errors::must_be_start_swap_request());
        0x93b6b0212ce86cc7759bd8e8b152bf604d6fa4c6cdeada1f276145bdc61ae1e3::interest_pool::confirm<T0>(arg0, arg1);
        0x93b6b0212ce86cc7759bd8e8b152bf604d6fa4c6cdeada1f276145bdc61ae1e3::interest_pool::new_request<T0>(arg0, 0x1::string::utf8(0x93b6b0212ce86cc7759bd8e8b152bf604d6fa4c6cdeada1f276145bdc61ae1e3::interest_pool::finish_swap()))
    }

    public fun start_add_liquidity<T0>(arg0: &0x93b6b0212ce86cc7759bd8e8b152bf604d6fa4c6cdeada1f276145bdc61ae1e3::interest_pool::InterestPool<T0>) : 0x93b6b0212ce86cc7759bd8e8b152bf604d6fa4c6cdeada1f276145bdc61ae1e3::interest_pool::Request {
        assert!(0x93b6b0212ce86cc7759bd8e8b152bf604d6fa4c6cdeada1f276145bdc61ae1e3::interest_pool::has_add_liquidity_hook<T0>(arg0), 0x93b6b0212ce86cc7759bd8e8b152bf604d6fa4c6cdeada1f276145bdc61ae1e3::errors::this_pool_has_no_hooks());
        0x93b6b0212ce86cc7759bd8e8b152bf604d6fa4c6cdeada1f276145bdc61ae1e3::interest_pool::new_request<T0>(arg0, 0x1::string::utf8(0x93b6b0212ce86cc7759bd8e8b152bf604d6fa4c6cdeada1f276145bdc61ae1e3::interest_pool::start_add_liquidity()))
    }

    public fun start_remove_liquidity<T0>(arg0: &0x93b6b0212ce86cc7759bd8e8b152bf604d6fa4c6cdeada1f276145bdc61ae1e3::interest_pool::InterestPool<T0>) : 0x93b6b0212ce86cc7759bd8e8b152bf604d6fa4c6cdeada1f276145bdc61ae1e3::interest_pool::Request {
        assert!(0x93b6b0212ce86cc7759bd8e8b152bf604d6fa4c6cdeada1f276145bdc61ae1e3::interest_pool::has_remove_liquidity_hook<T0>(arg0), 0x93b6b0212ce86cc7759bd8e8b152bf604d6fa4c6cdeada1f276145bdc61ae1e3::errors::this_pool_has_no_hooks());
        0x93b6b0212ce86cc7759bd8e8b152bf604d6fa4c6cdeada1f276145bdc61ae1e3::interest_pool::new_request<T0>(arg0, 0x1::string::utf8(0x93b6b0212ce86cc7759bd8e8b152bf604d6fa4c6cdeada1f276145bdc61ae1e3::interest_pool::start_remove_liquidity()))
    }

    public fun start_swap<T0>(arg0: &0x93b6b0212ce86cc7759bd8e8b152bf604d6fa4c6cdeada1f276145bdc61ae1e3::interest_pool::InterestPool<T0>) : 0x93b6b0212ce86cc7759bd8e8b152bf604d6fa4c6cdeada1f276145bdc61ae1e3::interest_pool::Request {
        assert!(0x93b6b0212ce86cc7759bd8e8b152bf604d6fa4c6cdeada1f276145bdc61ae1e3::interest_pool::has_swap_hook<T0>(arg0), 0x93b6b0212ce86cc7759bd8e8b152bf604d6fa4c6cdeada1f276145bdc61ae1e3::errors::this_pool_has_no_hooks());
        0x93b6b0212ce86cc7759bd8e8b152bf604d6fa4c6cdeada1f276145bdc61ae1e3::interest_pool::new_request<T0>(arg0, 0x1::string::utf8(0x93b6b0212ce86cc7759bd8e8b152bf604d6fa4c6cdeada1f276145bdc61ae1e3::interest_pool::start_swap()))
    }

    // decompiled from Move bytecode v6
}

