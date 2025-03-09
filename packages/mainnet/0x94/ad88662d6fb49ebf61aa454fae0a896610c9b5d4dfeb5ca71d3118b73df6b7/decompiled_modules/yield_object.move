module 0x94ad88662d6fb49ebf61aa454fae0a896610c9b5d4dfeb5ca71d3118b73df6b7::yield_object {
    struct YieldObject<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        amount: u64,
        exchange_rate: 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::FixedPoint64,
        sy_unclaimed_amount: u64,
    }

    struct EarnInterestEvent<phantom T0, phantom T1> has copy, drop {
        yield_object_id: 0x2::object::ID,
        amount: u64,
    }

    struct ClaimInterestEvent<phantom T0, phantom T1> has copy, drop {
        yield_object_id: 0x2::object::ID,
        amount: u64,
    }

    struct DeleteYieldObjectEvent<phantom T0, phantom T1> has copy, drop {
        yield_object_id: 0x2::object::ID,
    }

    struct MergeYieldObjectEvent<phantom T0, phantom T1> has copy, drop {
        yield_object_id: 0x2::object::ID,
        merged_yield_object_id: 0x2::object::ID,
    }

    struct SplitYieldObjectEvent<phantom T0, phantom T1> has copy, drop {
        yield_object_id: 0x2::object::ID,
        splitted_yield_object_id: 0x2::object::ID,
    }

    public(friend) fun delete<T0, T1>(arg0: YieldObject<T0, T1>) {
        let v0 = DeleteYieldObjectEvent<T0, T1>{yield_object_id: 0x2::object::id<YieldObject<T0, T1>>(&arg0)};
        0x2::event::emit<DeleteYieldObjectEvent<T0, T1>>(v0);
        let YieldObject {
            id                  : v1,
            amount              : _,
            exchange_rate       : _,
            sy_unclaimed_amount : _,
        } = arg0;
        0x2::object::delete(v1);
    }

    public(friend) fun claim<T0, T1>(arg0: &mut YieldObject<T0, T1>) : u64 {
        let v0 = arg0.sy_unclaimed_amount;
        arg0.sy_unclaimed_amount = 0;
        let v1 = ClaimInterestEvent<T0, T1>{
            yield_object_id : 0x2::object::id<YieldObject<T0, T1>>(arg0),
            amount          : v0,
        };
        0x2::event::emit<ClaimInterestEvent<T0, T1>>(v1);
        v0
    }

    public(friend) fun earn<T0, T1>(arg0: &mut YieldObject<T0, T1>, arg1: 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::FixedPoint64) {
        if (0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::equal(arg0.exchange_rate, arg1)) {
            abort 0
        };
        let v0 = ((0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::get_raw_value(0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::math_fixed64::mul_div(0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::create_from_u128((arg0.amount as u128)), 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::sub(arg1, arg0.exchange_rate), 0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::create_from_raw_value(0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::multiply_u128(0x2dc2de613e946a2a56434189b8875cfcc457ab2c6735e014bdb56209a1bedb6::fixed_point64::get_raw_value(arg1), arg0.exchange_rate)))) >> 64) as u64);
        arg0.sy_unclaimed_amount = arg0.sy_unclaimed_amount + v0;
        let v1 = EarnInterestEvent<T0, T1>{
            yield_object_id : 0x2::object::id<YieldObject<T0, T1>>(arg0),
            amount          : v0,
        };
        0x2::event::emit<EarnInterestEvent<T0, T1>>(v1);
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
        let v1 = MergeYieldObjectEvent<T0, T1>{
            yield_object_id        : 0x2::object::id<YieldObject<T0, T1>>(arg0),
            merged_yield_object_id : 0x2::object::id<YieldObject<T0, T1>>(&arg1),
        };
        0x2::event::emit<MergeYieldObjectEvent<T0, T1>>(v1);
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
        let v2 = SplitYieldObjectEvent<T0, T1>{
            yield_object_id          : 0x2::object::id<YieldObject<T0, T1>>(arg0),
            splitted_yield_object_id : 0x2::object::id<YieldObject<T0, T1>>(&v1),
        };
        0x2::event::emit<SplitYieldObjectEvent<T0, T1>>(v2);
        v1
    }

    public fun sy_unclaimed_amount<T0, T1>(arg0: &YieldObject<T0, T1>) : u64 {
        arg0.sy_unclaimed_amount
    }

    // decompiled from Move bytecode v6
}

