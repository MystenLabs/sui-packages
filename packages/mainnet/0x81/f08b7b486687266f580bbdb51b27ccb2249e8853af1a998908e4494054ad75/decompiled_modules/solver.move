module 0x81f08b7b486687266f580bbdb51b27ccb2249e8853af1a998908e4494054ad75::solver {
    struct Pool<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        owner: address,
        treasury: address,
        reserve_a: 0x2::balance::Balance<T0>,
        reserve_b: 0x2::balance::Balance<T1>,
        fee_bps: u64,
    }

    struct PoolCreated has copy, drop {
        pool_id: 0x2::object::ID,
        owner: address,
    }

    struct PoolSeeded has copy, drop {
        pool_id: 0x2::object::ID,
        amt_a: u64,
        amt_b: u64,
    }

    struct MediciSwap has copy, drop {
        pool_id: 0x2::object::ID,
        user: address,
        a_to_b: bool,
        amount_in: u64,
        amount_out: u64,
        fee: u64,
    }

    public entry fun create_pool<T0, T1>(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Pool<T0, T1>{
            id        : 0x2::object::new(arg1),
            owner     : 0x2::tx_context::sender(arg1),
            treasury  : arg0,
            reserve_a : 0x2::balance::zero<T0>(),
            reserve_b : 0x2::balance::zero<T1>(),
            fee_bps   : 5,
        };
        let v1 = PoolCreated{
            pool_id : 0x2::object::id<Pool<T0, T1>>(&v0),
            owner   : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<PoolCreated>(v1);
        0x2::transfer::share_object<Pool<T0, T1>>(v0);
    }

    public fun quote<T0, T1>(arg0: &Pool<T0, T1>, arg1: u64, arg2: bool) : u64 {
        let (v0, v1) = if (arg2) {
            (0x2::balance::value<T0>(&arg0.reserve_a), 0x2::balance::value<T1>(&arg0.reserve_b))
        } else {
            (0x2::balance::value<T1>(&arg0.reserve_b), 0x2::balance::value<T0>(&arg0.reserve_a))
        };
        assert!(v0 > 0 && v1 > 0, 3);
        let v2 = arg1 - arg1 * arg0.fee_bps / 10000;
        v2 * v1 / (v0 + v2)
    }

    public fun reserves<T0, T1>(arg0: &Pool<T0, T1>) : (u64, u64) {
        (0x2::balance::value<T0>(&arg0.reserve_a), 0x2::balance::value<T1>(&arg0.reserve_b))
    }

    public entry fun seed_pool<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 1);
        0x2::balance::join<T0>(&mut arg0.reserve_a, 0x2::coin::into_balance<T0>(arg1));
        0x2::balance::join<T1>(&mut arg0.reserve_b, 0x2::coin::into_balance<T1>(arg2));
        let v0 = PoolSeeded{
            pool_id : 0x2::object::id<Pool<T0, T1>>(arg0),
            amt_a   : 0x2::coin::value<T0>(&arg1),
            amt_b   : 0x2::coin::value<T1>(&arg2),
        };
        0x2::event::emit<PoolSeeded>(v0);
    }

    public entry fun swap_a_to_b<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        let v1 = quote<T0, T1>(arg0, v0, true);
        assert!(v1 >= arg2, 2);
        let v2 = v0 * arg0.fee_bps / 10000;
        let v3 = 0x2::coin::into_balance<T0>(arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v3, v2), arg3), arg0.treasury);
        0x2::balance::join<T0>(&mut arg0.reserve_a, v3);
        let v4 = 0x2::tx_context::sender(arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.reserve_b, v1), arg3), v4);
        let v5 = MediciSwap{
            pool_id    : 0x2::object::id<Pool<T0, T1>>(arg0),
            user       : v4,
            a_to_b     : true,
            amount_in  : v0,
            amount_out : v1,
            fee        : v2,
        };
        0x2::event::emit<MediciSwap>(v5);
    }

    public entry fun swap_b_to_a<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T1>(&arg1);
        let v1 = quote<T0, T1>(arg0, v0, false);
        assert!(v1 >= arg2, 2);
        let v2 = v0 * arg0.fee_bps / 10000;
        let v3 = 0x2::coin::into_balance<T1>(arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v3, v2), arg3), arg0.treasury);
        0x2::balance::join<T1>(&mut arg0.reserve_b, v3);
        let v4 = 0x2::tx_context::sender(arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.reserve_a, v1), arg3), v4);
        let v5 = MediciSwap{
            pool_id    : 0x2::object::id<Pool<T0, T1>>(arg0),
            user       : v4,
            a_to_b     : false,
            amount_in  : v0,
            amount_out : v1,
            fee        : v2,
        };
        0x2::event::emit<MediciSwap>(v5);
    }

    // decompiled from Move bytecode v6
}

