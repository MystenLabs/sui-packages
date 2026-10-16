module 0x76399a58d2015436ab081cda41d9d2dffed0e2bd87d6a0b238743cde59d941ff::swap {
    struct Pool<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        token: 0x2::balance::Balance<T0>,
        dollars: 0x2::balance::Balance<T1>,
        shares: 0x2::table::Table<address, u64>,
        total_shares: u64,
        created_ms: u64,
    }

    struct Registry has key {
        id: 0x2::object::UID,
        pools: 0x2::table::Table<0x1::type_name::TypeName, 0x2::object::ID>,
    }

    struct FeeCap has key {
        id: 0x2::object::UID,
    }

    struct Fees<phantom T0> has key {
        id: 0x2::object::UID,
        platform: address,
        fthm: 0x1::type_name::TypeName,
        fthm_sink: address,
        bucket: 0x2::balance::Balance<T0>,
    }

    struct Witness has drop {
        dummy_field: bool,
    }

    struct PoolOpened has copy, drop {
        pool: 0x2::object::ID,
        token: 0x1::type_name::TypeName,
    }

    struct Swapped has copy, drop {
        pool: 0x2::object::ID,
        dollars_to_token: bool,
        amount_in: u64,
        amount_out: u64,
    }

    struct FthmBought has copy, drop {
        dollars_in: u64,
        fthm_out: u64,
        sink: address,
    }

    public fun add_liquidity<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: &0x2::tx_context::TxContext) {
        let v0 = (0x2::coin::value<T0>(&arg1) as u128) * (arg0.total_shares as u128) / (0x2::balance::value<T0>(&arg0.token) as u128);
        let v1 = (0x2::coin::value<T1>(&arg2) as u128) * (arg0.total_shares as u128) / (0x2::balance::value<T1>(&arg0.dollars) as u128);
        let v2 = if (v0 < v1) {
            v0
        } else {
            v1
        };
        let v3 = (v2 as u64);
        assert!(v3 > 0, 2);
        0x2::balance::join<T0>(&mut arg0.token, 0x2::coin::into_balance<T0>(arg1));
        0x2::balance::join<T1>(&mut arg0.dollars, 0x2::coin::into_balance<T1>(arg2));
        let v4 = 0x2::tx_context::sender(arg3);
        let v5 = if (0x2::table::contains<address, u64>(&arg0.shares, v4)) {
            0x2::table::remove<address, u64>(&mut arg0.shares, v4)
        } else {
            0
        };
        0x2::table::add<address, u64>(&mut arg0.shares, v4, v5 + v3);
        arg0.total_shares = arg0.total_shares + v3;
    }

    public fun buy<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut Fees<T1>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::coin::into_balance<T1>(arg2);
        let v1 = 0x2::balance::value<T1>(&v0);
        assert!(v1 > 0, 2);
        let v2 = &mut v0;
        take_fee<T1>(arg1, v2, arg4);
        let v3 = quote(0x2::balance::value<T1>(&arg0.dollars), 0x2::balance::value<T0>(&arg0.token), 0x2::balance::value<T1>(&v0));
        assert!(v3 >= arg3 && v3 > 0, 3);
        0x2::balance::join<T1>(&mut arg0.dollars, v0);
        let v4 = Swapped{
            pool             : 0x2::object::id<Pool<T0, T1>>(arg0),
            dollars_to_token : true,
            amount_in        : v1,
            amount_out       : v3,
        };
        0x2::event::emit<Swapped>(v4);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.token, v3), arg4)
    }

    public fun buy_fthm<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut Fees<T1>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::type_name::with_defining_ids<T0>() == arg1.fthm, 9);
        let v0 = 0x2::balance::value<T1>(&arg1.bucket);
        assert!(v0 > 0, 2);
        let v1 = 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg1.bucket, v0), arg2);
        let v2 = arg1.fthm_sink;
        let v3 = buy<T0, T1>(arg0, arg1, v1, 1, arg2);
        let v4 = FthmBought{
            dollars_in : v0,
            fthm_out   : 0x2::coin::value<T0>(&v3),
            sink       : v2,
        };
        0x2::event::emit<FthmBought>(v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v3, v2);
    }

    public fun convert<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut Fees<T1>, arg2: &0x76399a58d2015436ab081cda41d9d2dffed0e2bd87d6a0b238743cde59d941ff::launchpad::Config, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x76399a58d2015436ab081cda41d9d2dffed0e2bd87d6a0b238743cde59d941ff::launchpad::Converted<T1, T0> {
        let v0 = 0x2::coin::value<T1>(&arg3);
        assert!(0x2::clock::timestamp_ms(arg5) >= arg0.created_ms + 86400000, 5);
        assert!(0x2::balance::value<T1>(&arg0.dollars) >= v0 * 10, 6);
        let v1 = Witness{dummy_field: false};
        0x76399a58d2015436ab081cda41d9d2dffed0e2bd87d6a0b238743cde59d941ff::launchpad::converted<T1, T0, Witness>(arg2, v1, buy<T0, T1>(arg0, arg1, arg3, arg4, arg6), v0)
    }

    public fun fthm_bucket<T0>(arg0: &Fees<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.bucket)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Registry{
            id    : 0x2::object::new(arg0),
            pools : 0x2::table::new<0x1::type_name::TypeName, 0x2::object::ID>(arg0),
        };
        0x2::transfer::share_object<Registry>(v0);
        let v1 = FeeCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<FeeCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun initialize<T0, T1>(arg0: FeeCap, arg1: address, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let FeeCap { id: v0 } = arg0;
        0x2::object::delete(v0);
        let v1 = Fees<T0>{
            id        : 0x2::object::new(arg3),
            platform  : arg1,
            fthm      : 0x1::type_name::with_defining_ids<T1>(),
            fthm_sink : arg2,
            bucket    : 0x2::balance::zero<T0>(),
        };
        0x2::transfer::share_object<Fees<T0>>(v1);
    }

    fun isqrt(arg0: u128) : u128 {
        if (arg0 == 0) {
            return 0
        };
        let v0 = (arg0 + 1) / 2;
        while (v0 < arg0) {
            let v1 = arg0 / v0 + v0;
            v0 = v1 / 2;
        };
        arg0
    }

    public fun open_pool<T0, T1>(arg0: &mut Registry, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::type_name::with_defining_ids<T0>() != 0x1::type_name::with_defining_ids<T1>(), 1);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(!0x2::table::contains<0x1::type_name::TypeName, 0x2::object::ID>(&arg0.pools, v0), 8);
        let v1 = 0x2::coin::value<T0>(&arg1);
        let v2 = 0x2::coin::value<T1>(&arg2);
        assert!(v1 > 0 && v2 > 0, 2);
        let v3 = (isqrt((v1 as u128) * (v2 as u128)) as u64);
        assert!(v3 > 1000, 2);
        let v4 = 0x2::table::new<address, u64>(arg4);
        0x2::table::add<address, u64>(&mut v4, 0x2::tx_context::sender(arg4), v3 - 1000);
        let v5 = Pool<T0, T1>{
            id           : 0x2::object::new(arg4),
            token        : 0x2::coin::into_balance<T0>(arg1),
            dollars      : 0x2::coin::into_balance<T1>(arg2),
            shares       : v4,
            total_shares : v3,
            created_ms   : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::table::add<0x1::type_name::TypeName, 0x2::object::ID>(&mut arg0.pools, v0, 0x2::object::id<Pool<T0, T1>>(&v5));
        let v6 = PoolOpened{
            pool  : 0x2::object::id<Pool<T0, T1>>(&v5),
            token : v0,
        };
        0x2::event::emit<PoolOpened>(v6);
        0x2::transfer::share_object<Pool<T0, T1>>(v5);
    }

    public fun quote(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = (arg2 as u128) * (1000000 - 3000) / 1000000;
        (((arg1 as u128) * v0 / ((arg0 as u128) + v0)) as u64)
    }

    public fun remove_liquidity<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = if (arg1 > 0) {
            if (0x2::table::contains<address, u64>(&arg0.shares, v0)) {
                *0x2::table::borrow<address, u64>(&arg0.shares, v0) >= arg1
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 7);
        let v2 = 0x2::table::remove<address, u64>(&mut arg0.shares, v0);
        if (v2 > arg1) {
            0x2::table::add<address, u64>(&mut arg0.shares, v0, v2 - arg1);
        };
        arg0.total_shares = arg0.total_shares - arg1;
        (0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.token, (((0x2::balance::value<T0>(&arg0.token) as u128) * (arg1 as u128) / (arg0.total_shares as u128)) as u64)), arg2), 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.dollars, (((0x2::balance::value<T1>(&arg0.dollars) as u128) * (arg1 as u128) / (arg0.total_shares as u128)) as u64)), arg2))
    }

    public fun reserves<T0, T1>(arg0: &Pool<T0, T1>) : (u64, u64, u64) {
        (0x2::balance::value<T0>(&arg0.token), 0x2::balance::value<T1>(&arg0.dollars), arg0.created_ms)
    }

    public fun sell<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut Fees<T1>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(v0 > 0, 2);
        0x2::balance::join<T0>(&mut arg0.token, 0x2::coin::into_balance<T0>(arg2));
        let v1 = 0x2::balance::split<T1>(&mut arg0.dollars, quote(0x2::balance::value<T0>(&arg0.token), 0x2::balance::value<T1>(&arg0.dollars), v0));
        let v2 = &mut v1;
        take_fee<T1>(arg1, v2, arg4);
        assert!(0x2::balance::value<T1>(&v1) >= arg3 && 0x2::balance::value<T1>(&v1) > 0, 3);
        let v3 = Swapped{
            pool             : 0x2::object::id<Pool<T0, T1>>(arg0),
            dollars_to_token : false,
            amount_in        : v0,
            amount_out       : 0x2::balance::value<T1>(&v1),
        };
        0x2::event::emit<Swapped>(v3);
        0x2::coin::from_balance<T1>(v1, arg4)
    }

    public fun shares_of<T0, T1>(arg0: &Pool<T0, T1>, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.shares, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.shares, arg1)
        } else {
            0
        }
    }

    fun take_fee<T0>(arg0: &mut Fees<T0>, arg1: &mut 0x2::balance::Balance<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = (((0x2::balance::value<T0>(arg1) as u128) * 1000 / 1000000) as u64);
        if (v0 == 0) {
            return
        };
        let v1 = (((v0 as u128) * 50000 / 1000000) as u64);
        0x2::balance::join<T0>(&mut arg0.bucket, 0x2::balance::split<T0>(arg1, v1));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(arg1, v0 - v1), arg2), arg0.platform);
    }

    // decompiled from Move bytecode v7
}

