module 0x4b5ae634ae736c65603c2f6f0e0a776e1d14c811df9a8a0afd60939b5bd84456::common {
    public(friend) fun max_sqrt_price_limit() : u128 {
        79226673515401279992447579054
    }

    public(friend) fun min_sqrt_price_limit() : u128 {
        4295048017
    }

    public(friend) fun mul_bps_u128(arg0: u128, arg1: u64) : u128 {
        (((arg0 as u256) * (arg1 as u256) / 10000) as u128)
    }

    public(friend) fun optimal_params(arg0: bool, arg1: u64) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = &mut v0;
        push_u64_le(v1, 0);
        let v2 = &mut v0;
        push_u64_le(v2, 0);
        let v3 = &mut v0;
        push_u64_le(v3, 0);
        let v4 = &mut v0;
        push_bool(v4, arg0);
        let v5 = &mut v0;
        push_u64_le(v5, arg1);
        let v6 = &mut v0;
        push_u64_le(v6, 10000);
        v0
    }

    fun push_bool(arg0: &mut vector<u8>, arg1: bool) {
        let v0 = if (arg1) {
            1
        } else {
            0
        };
        0x1::vector::push_back<u8>(arg0, v0);
    }

    public(friend) fun push_bps() : u64 {
        1490
    }

    fun push_u64_le(arg0: &mut vector<u8>, arg1: u64) {
        0x1::vector::push_back<u8>(arg0, ((arg1 >> 0 & 255) as u8));
        0x1::vector::push_back<u8>(arg0, ((arg1 >> 8 & 255) as u8));
        0x1::vector::push_back<u8>(arg0, ((arg1 >> 16 & 255) as u8));
        0x1::vector::push_back<u8>(arg0, ((arg1 >> 24 & 255) as u8));
        0x1::vector::push_back<u8>(arg0, ((arg1 >> 32 & 255) as u8));
        0x1::vector::push_back<u8>(arg0, ((arg1 >> 40 & 255) as u8));
        0x1::vector::push_back<u8>(arg0, ((arg1 >> 48 & 255) as u8));
        0x1::vector::push_back<u8>(arg0, ((arg1 >> 56 & 255) as u8));
    }

    public(friend) fun reserve_keep_amount(arg0: u64, arg1: u64) : u64 {
        if (arg0 > arg1) {
            arg0 - arg1
        } else {
            0
        }
    }

    public(friend) fun send_or_destroy<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address) {
        if (0x2::coin::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg1);
        } else {
            0x2::coin::destroy_zero<T0>(arg0);
        };
    }

    public(friend) fun settle_params() : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = &mut v0;
        push_u64_le(v1, 0);
        v0
    }

    public(friend) fun settle_tolerance() : u64 {
        200
    }

    public(friend) fun special_params(arg0: u64) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = &mut v0;
        push_u64_le(v1, 0);
        let v2 = &mut v0;
        push_u64_le(v2, 0);
        let v3 = &mut v0;
        push_u64_le(v3, arg0);
        let v4 = &mut v0;
        push_u64_le(v4, 10000);
        v0
    }

    public(friend) fun split_surplus<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::coin::value<T0>(arg0);
        if (v0 > arg1) {
            0x2::coin::split<T0>(arg0, v0 - arg1, arg2)
        } else {
            0x2::coin::zero<T0>(arg2)
        }
    }

    public(friend) fun split_surplus_share<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::coin::value<T0>(arg0);
        if (v0 <= arg1) {
            return 0x2::coin::zero<T0>(arg3)
        };
        let v1 = if (arg2 > 1) {
            (v0 - arg1) / arg2
        } else {
            v0 - arg1
        };
        if (v1 > 0) {
            0x2::coin::split<T0>(arg0, v1, arg3)
        } else {
            0x2::coin::zero<T0>(arg3)
        }
    }

    public(friend) fun strategy_add_base() : u8 {
        1
    }

    public(friend) fun strategy_add_two_sides() : u8 {
        2
    }

    public(friend) fun strategy_withdraw() : u8 {
        4
    }

    public(friend) fun tolerance_test_value() : u64 {
        10000
    }

    public(friend) fun vec1<T0>(arg0: T0) : vector<T0> {
        let v0 = 0x1::vector::empty<T0>();
        0x1::vector::push_back<T0>(&mut v0, arg0);
        v0
    }

    public(friend) fun work_factor_max() : u64 {
        9000
    }

    public(friend) fun work_id_new() : u64 {
        0
    }

    // decompiled from Move bytecode v7
}

