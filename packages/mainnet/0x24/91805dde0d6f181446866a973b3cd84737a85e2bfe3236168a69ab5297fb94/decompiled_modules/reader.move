module 0x2491805dde0d6f181446866a973b3cd84737a85e2bfe3236168a69ab5297fb94::reader {
    public fun current<T0, T1>(arg0: &0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::Pool<T0, T1>) : (u128, u64, u64) {
        (0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::current_sqrt_price<T0, T1>(arg0), 0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::fee_rate<T0, T1>(arg0), 1000000)
    }

    public fun economic_window_if<T0, T1>(arg0: &0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::Pool<T0, T1>, arg1: bool, arg2: u64, arg3: bool, arg4: u256) : (u128, vector<u128>, vector<u128>, vector<bool>) {
        window_impl<T0, T1>(arg0, arg1, arg2, arg3, arg4)
    }

    public fun window_if<T0, T1>(arg0: &0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::Pool<T0, T1>, arg1: bool, arg2: u64, arg3: bool) : (u128, vector<u128>, vector<u128>, vector<bool>) {
        window_impl<T0, T1>(arg0, arg1, arg2, arg3, 0)
    }

    fun window_impl<T0, T1>(arg0: &0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::Pool<T0, T1>, arg1: bool, arg2: u64, arg3: bool, arg4: u256) : (u128, vector<u128>, vector<u128>, vector<bool>) {
        if (!arg3) {
            return (0, vector[], vector[], vector[])
        };
        assert!(arg2 > 0, 1);
        let v0 = 0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::tick_manager<T0, T1>(arg0);
        let v1 = 0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::tick::first_score_for_swap(v0, 0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::current_tick_index<T0, T1>(arg0), arg1);
        let v2 = vector[];
        let v3 = vector[];
        let v4 = vector[];
        let v5 = 0;
        let v6 = 0;
        while (v5 < arg2 && 0xec79d3636f0dc48e0aa8977322f62370cf39d0894642f4c1ceceab372ffb11c7::option_u64::is_some(&v1)) {
            let (v7, v8) = 0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::tick::borrow_tick_for_swap(v0, 0xec79d3636f0dc48e0aa8977322f62370cf39d0894642f4c1ceceab372ffb11c7::option_u64::borrow(&v1), arg1);
            let v9 = 0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::tick::liquidity_net(v7);
            let v10 = 0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::tick::sqrt_price(v7);
            v6 = v10;
            0x1::vector::push_back<u128>(&mut v2, v10);
            0x1::vector::push_back<u128>(&mut v3, 0x7817e0a3dfcbf204d0bebe98b8853771bcff308982c2af4e3ff4f5730ae926a7::i128::abs_u128(v9));
            0x1::vector::push_back<bool>(&mut v4, 0x7817e0a3dfcbf204d0bebe98b8853771bcff308982c2af4e3ff4f5730ae926a7::i128::is_neg(v9));
            v1 = v8;
            v5 = v5 + 1;
            if (arg4 > 0) {
                let v11 = (v10 as u256) * (v10 as u256);
                if (arg1 && v11 <= arg4 || !arg1 && v11 >= arg4) {
                    break
                };
            };
        };
        let v12 = if (arg1) {
            0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::tick_math::min_sqrt_price()
        } else {
            0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::tick_math::max_sqrt_price()
        };
        if (!0xec79d3636f0dc48e0aa8977322f62370cf39d0894642f4c1ceceab372ffb11c7::option_u64::is_some(&v1) && (v5 == 0 || v6 != v12)) {
            0x1::vector::push_back<u128>(&mut v2, v12);
            0x1::vector::push_back<u128>(&mut v3, 0);
            0x1::vector::push_back<bool>(&mut v4, false);
        };
        (0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::liquidity<T0, T1>(arg0), v2, v3, v4)
    }

    // decompiled from Move bytecode v7
}

