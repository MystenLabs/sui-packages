module 0x2d0b9edf45da7b998a802d4b54337b6c05a8c230d431dde78ad14f449a2483::yield_object {
    struct YieldObject<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        amount: u64,
        exchange_rate: 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::FixedPoint64,
        sy_unclaimed_amount: u64,
    }

    public(friend) fun delete<T0, T1>(arg0: YieldObject<T0, T1>) {
        let YieldObject {
            id                  : v0,
            amount              : _,
            exchange_rate       : _,
            sy_unclaimed_amount : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public(friend) fun claim<T0, T1>(arg0: &mut YieldObject<T0, T1>) : u64 {
        arg0.sy_unclaimed_amount = 0;
        arg0.sy_unclaimed_amount
    }

    public(friend) fun earn<T0, T1>(arg0: &mut YieldObject<T0, T1>, arg1: 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::FixedPoint64) {
        if (0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::equal(arg0.exchange_rate, arg1)) {
            abort 0
        };
        arg0.sy_unclaimed_amount = arg0.sy_unclaimed_amount + ((0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::get_raw_value(0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::math_fixed64::mul_div(0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::create_from_u128((arg0.amount as u128)), 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::sub(arg1, arg0.exchange_rate), 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::create_from_u128(0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::multiply_u128(0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::get_raw_value(arg1), arg0.exchange_rate)))) >> 64) as u64);
    }

    public fun get_amount<T0, T1>(arg0: &YieldObject<T0, T1>) : u64 {
        arg0.amount
    }

    public fun get_exchange_rate<T0, T1>(arg0: &YieldObject<T0, T1>) : 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::FixedPoint64 {
        arg0.exchange_rate
    }

    public(friend) fun merge<T0, T1>(arg0: &mut YieldObject<T0, T1>, arg1: YieldObject<T0, T1>, arg2: 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::FixedPoint64) {
        let v0 = &mut arg1;
        earn<T0, T1>(v0, arg2);
        earn<T0, T1>(arg0, arg2);
        arg0.amount = arg0.amount + arg1.amount;
        arg0.sy_unclaimed_amount = arg0.sy_unclaimed_amount + arg1.sy_unclaimed_amount;
        delete<T0, T1>(arg1);
    }

    public(friend) fun mint<T0, T1>(arg0: u64, arg1: 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::FixedPoint64, arg2: &mut 0x2::tx_context::TxContext) : YieldObject<T0, T1> {
        YieldObject<T0, T1>{
            id                  : 0x2::object::new(arg2),
            amount              : arg0,
            exchange_rate       : arg1,
            sy_unclaimed_amount : 0,
        }
    }

    public(friend) fun split<T0, T1>(arg0: &mut YieldObject<T0, T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : YieldObject<T0, T1> {
        let v0 = ((0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::get_raw_value(0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::math_fixed64::mul_div(0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::create_from_u128((arg0.sy_unclaimed_amount as u128)), 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::create_from_rational((arg1 as u128), (arg0.amount as u128)), 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::create_from_u128(1))) >> 64) as u64);
        let v1 = YieldObject<T0, T1>{
            id                  : 0x2::object::new(arg2),
            amount              : arg1,
            exchange_rate       : arg0.exchange_rate,
            sy_unclaimed_amount : v0,
        };
        arg0.amount = arg0.amount - arg1;
        arg0.sy_unclaimed_amount = arg0.sy_unclaimed_amount - v0;
        v1
    }

    public fun sy_unclaimed_amount<T0, T1>(arg0: &YieldObject<T0, T1>) : u64 {
        arg0.sy_unclaimed_amount
    }

    // decompiled from Move bytecode v6
}

