module 0xc0f45e3f5ade9fb463ee92b7bceb13fd3f22ee37b00f29d9ac651b21080b937f::amm_v2 {
    struct Pool<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        reserve_a: 0x2::balance::Balance<T0>,
        reserve_b: 0x2::balance::Balance<T1>,
        fee_bps: u64,
    }

    struct PoolCreated has copy, drop {
        pool: 0x2::object::ID,
        fee_bps: u64,
        reserve_a: u64,
        reserve_b: u64,
    }

    struct Swapped has copy, drop {
        pool: 0x2::object::ID,
        amount_in: u64,
        amount_out: u64,
        a_to_b: bool,
    }

    public fun create_pool<T0, T1>(arg0: &0xc0f45e3f5ade9fb463ee92b7bceb13fd3f22ee37b00f29d9ac651b21080b937f::admin::AdminCap, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 < 0xc0f45e3f5ade9fb463ee92b7bceb13fd3f22ee37b00f29d9ac651b21080b937f::math::fee_denom(), 1);
        let v0 = Pool<T0, T1>{
            id        : 0x2::object::new(arg4),
            reserve_a : 0x2::coin::into_balance<T0>(arg1),
            reserve_b : 0x2::coin::into_balance<T1>(arg2),
            fee_bps   : arg3,
        };
        let v1 = PoolCreated{
            pool      : 0x2::object::id<Pool<T0, T1>>(&v0),
            fee_bps   : arg3,
            reserve_a : 0x2::balance::value<T0>(&v0.reserve_a),
            reserve_b : 0x2::balance::value<T1>(&v0.reserve_b),
        };
        0x2::event::emit<PoolCreated>(v1);
        0x2::transfer::share_object<Pool<T0, T1>>(v0);
    }

    public fun fee_bps<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        arg0.fee_bps
    }

    public fun fund<T0, T1>(arg0: &0xc0f45e3f5ade9fb463ee92b7bceb13fd3f22ee37b00f29d9ac651b21080b937f::admin::AdminCap, arg1: &mut Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>) {
        0x2::balance::join<T0>(&mut arg1.reserve_a, 0x2::coin::into_balance<T0>(arg2));
        0x2::balance::join<T1>(&mut arg1.reserve_b, 0x2::coin::into_balance<T1>(arg3));
    }

    public fun quote_a_to_b<T0, T1>(arg0: &Pool<T0, T1>, arg1: u64) : u64 {
        0xc0f45e3f5ade9fb463ee92b7bceb13fd3f22ee37b00f29d9ac651b21080b937f::math::get_amount_out(arg1, 0x2::balance::value<T0>(&arg0.reserve_a), 0x2::balance::value<T1>(&arg0.reserve_b), arg0.fee_bps)
    }

    public fun quote_b_to_a<T0, T1>(arg0: &Pool<T0, T1>, arg1: u64) : u64 {
        0xc0f45e3f5ade9fb463ee92b7bceb13fd3f22ee37b00f29d9ac651b21080b937f::math::get_amount_out(arg1, 0x2::balance::value<T1>(&arg0.reserve_b), 0x2::balance::value<T0>(&arg0.reserve_a), arg0.fee_bps)
    }

    public fun reserves<T0, T1>(arg0: &Pool<T0, T1>) : (u64, u64) {
        (0x2::balance::value<T0>(&arg0.reserve_a), 0x2::balance::value<T1>(&arg0.reserve_b))
    }

    public fun swap_a_to_b<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::coin::value<T0>(&arg1);
        let v1 = 0xc0f45e3f5ade9fb463ee92b7bceb13fd3f22ee37b00f29d9ac651b21080b937f::math::get_amount_out(v0, 0x2::balance::value<T0>(&arg0.reserve_a), 0x2::balance::value<T1>(&arg0.reserve_b), arg0.fee_bps);
        assert!(v1 >= arg2, 1);
        0x2::balance::join<T0>(&mut arg0.reserve_a, 0x2::coin::into_balance<T0>(arg1));
        let v2 = Swapped{
            pool       : 0x2::object::id<Pool<T0, T1>>(arg0),
            amount_in  : v0,
            amount_out : v1,
            a_to_b     : true,
        };
        0x2::event::emit<Swapped>(v2);
        0x2::coin::take<T1>(&mut arg0.reserve_b, v1, arg3)
    }

    public fun swap_b_to_a<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::coin::value<T1>(&arg1);
        let v1 = 0xc0f45e3f5ade9fb463ee92b7bceb13fd3f22ee37b00f29d9ac651b21080b937f::math::get_amount_out(v0, 0x2::balance::value<T1>(&arg0.reserve_b), 0x2::balance::value<T0>(&arg0.reserve_a), arg0.fee_bps);
        assert!(v1 >= arg2, 1);
        0x2::balance::join<T1>(&mut arg0.reserve_b, 0x2::coin::into_balance<T1>(arg1));
        let v2 = Swapped{
            pool       : 0x2::object::id<Pool<T0, T1>>(arg0),
            amount_in  : v0,
            amount_out : v1,
            a_to_b     : false,
        };
        0x2::event::emit<Swapped>(v2);
        0x2::coin::take<T0>(&mut arg0.reserve_a, v1, arg3)
    }

    // decompiled from Move bytecode v7
}

