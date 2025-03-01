module 0x653f557f93c8307d15cc614465e4449594e73b3d70d9691368e5e289c7e5b374::yield_object {
    struct YieldObject<phantom T0> has store, key {
        id: 0x2::object::UID,
        amount: u64,
        exchange_rate: 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::FixedPoint64,
        sy_unclaimed_amount: u64,
    }

    public fun delete<T0>(arg0: YieldObject<T0>) {
        let YieldObject {
            id                  : v0,
            amount              : _,
            exchange_rate       : _,
            sy_unclaimed_amount : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun claim<T0>(arg0: &mut YieldObject<T0>) : u64 {
        arg0.sy_unclaimed_amount = 0;
        arg0.sy_unclaimed_amount
    }

    public fun earn<T0>(arg0: &mut YieldObject<T0>, arg1: 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::FixedPoint64) {
        if (0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::equal(arg0.exchange_rate, arg1)) {
            abort 0
        };
        arg0.sy_unclaimed_amount = arg0.sy_unclaimed_amount + ((0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::get_raw_value(0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::math_fixed64::mul_div(0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::create_from_u128((arg0.amount as u128)), 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::sub(arg1, arg0.exchange_rate), 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::create_from_u128(0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::multiply_u128(0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::get_raw_value(arg1), arg0.exchange_rate)))) >> 64) as u64);
    }

    public fun get_amount<T0>(arg0: &YieldObject<T0>) : u64 {
        arg0.amount
    }

    public fun get_exchange_rate<T0>(arg0: &YieldObject<T0>) : 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::FixedPoint64 {
        arg0.exchange_rate
    }

    public fun merge<T0>(arg0: &mut YieldObject<T0>, arg1: YieldObject<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.exchange_rate == arg1.exchange_rate, 0);
        arg0.amount = arg0.amount + arg1.amount;
        arg0.sy_unclaimed_amount = arg0.sy_unclaimed_amount + arg1.sy_unclaimed_amount;
        delete<T0>(arg1);
    }

    public fun mint<T0>(arg0: u64, arg1: 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::FixedPoint64, arg2: &mut 0x2::tx_context::TxContext) : YieldObject<T0> {
        YieldObject<T0>{
            id                  : 0x2::object::new(arg2),
            amount              : arg0,
            exchange_rate       : arg1,
            sy_unclaimed_amount : 0,
        }
    }

    public fun split<T0>(arg0: &mut YieldObject<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : YieldObject<T0> {
        let v0 = ((0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::get_raw_value(0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::math_fixed64::mul_div(0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::create_from_u128((arg0.sy_unclaimed_amount as u128)), 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::create_from_rational((arg1 as u128), (arg0.amount as u128)), 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::create_from_u128(1))) >> 64) as u64);
        let v1 = YieldObject<T0>{
            id                  : 0x2::object::new(arg2),
            amount              : arg1,
            exchange_rate       : arg0.exchange_rate,
            sy_unclaimed_amount : v0,
        };
        arg0.amount = arg0.amount - arg1;
        arg0.sy_unclaimed_amount = arg0.sy_unclaimed_amount - v0;
        v1
    }

    public fun sy_unclaimed_amount<T0>(arg0: &YieldObject<T0>) : u64 {
        arg0.sy_unclaimed_amount
    }

    // decompiled from Move bytecode v6
}

