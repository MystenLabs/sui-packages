module 0x45d628bb00e09b9dab5bc5fac68978ffd2b676e49805b1a3e190f4847eb9b89::swap {
    struct PoolRegistry has key {
        id: 0x2::object::UID,
        admin: address,
    }

    struct Pool<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        reserve_x: 0x2::balance::Balance<T0>,
        reserve_y: 0x2::balance::Balance<T1>,
        total_shares: u128,
        buytime: u64,
        selltime: u64,
        addtime: u64,
        removetime: u64,
    }

    struct LP<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        pool: 0x2::object::ID,
        shares: u128,
    }

    struct PoolRegistryCreated has copy, drop {
        registry_id: 0x2::object::ID,
        admin: address,
    }

    struct PoolAdminChanged has copy, drop {
        registry_id: 0x2::object::ID,
        old_admin: address,
        new_admin: address,
    }

    struct PoolCreated<phantom T0, phantom T1> has copy, drop {
        registry_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        initial_lp_id: 0x2::object::ID,
        creator: address,
        amount_x: u64,
        amount_y: u64,
        total_shares: u128,
    }

    struct LiquidityAdded<phantom T0, phantom T1> has copy, drop {
        pool_id: 0x2::object::ID,
        lp_id: 0x2::object::ID,
        provider: address,
        used_x: u64,
        used_y: u64,
        returned_x: u64,
        returned_y: u64,
        shares_minted: u128,
        total_shares_after: u128,
        reserve_x_after: u64,
        reserve_y_after: u64,
        timestamp_ms: u64,
    }

    struct LiquidityRemoved<phantom T0, phantom T1> has copy, drop {
        pool_id: 0x2::object::ID,
        lp_id: 0x2::object::ID,
        caller: address,
        shares_burned: u128,
        amount_x: u64,
        gross_y: u64,
        net_y: u64,
        admin_fee_y: u64,
        fee_recipient: address,
        min_x: u64,
        min_y: u64,
        total_shares_after: u128,
        reserve_x_after: u64,
        reserve_y_after: u64,
        timestamp_ms: u64,
    }

    struct SwapExecuted<phantom T0, phantom T1> has copy, drop {
        pool_id: 0x2::object::ID,
        caller: address,
        direction: u8,
        package_route: bool,
        amount_in: u64,
        gross_out: u64,
        amount_out: u64,
        admin_fee: u64,
        lp_fee: u64,
        fee_recipient: 0x1::option::Option<address>,
        min_out: u64,
        reserve_x_after: u64,
        reserve_y_after: u64,
        timestamp_ms: u64,
    }

    public fun add_liquidity<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: u128, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (LP<T0, T1>, 0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert!(protectTransaction(arg0.buytime, arg0.selltime, arg0.addtime, arg0.removetime, 0x2::clock::timestamp_ms(arg4)), 6);
        arg0.addtime = 0x2::clock::timestamp_ms(arg4);
        let v0 = 0x2::coin::value<T0>(&arg1);
        let v1 = 0x2::coin::value<T1>(&arg2);
        assert!(v0 > 0 && v1 > 0, 0);
        let v2 = 0x2::balance::value<T0>(&arg0.reserve_x);
        let v3 = 0x2::balance::value<T1>(&arg0.reserve_y);
        let v4 = arg0.total_shares;
        let (v5, v6, v7) = if (v4 == 0) {
            assert!(v2 == 0 && v3 == 0, 1);
            (v0, v1, (min_u256((v0 as u256), (v1 as u256)) as u128))
        } else {
            assert!(v2 > 0 && v3 > 0, 1);
            let v8 = (min_u256((v0 as u256) * (v4 as u256) / (v2 as u256), (v1 as u256) * (v4 as u256) / (v3 as u256)) as u128);
            assert!(v8 > 0, 0);
            ((ceil_div((v8 as u256) * (v2 as u256), (v4 as u256)) as u64), (ceil_div((v8 as u256) * (v3 as u256), (v4 as u256)) as u64), v8)
        };
        assert!(v7 > 0 && v7 >= arg3, 2);
        assert!(v5 <= v0 && v6 <= v1, 1);
        0x2::balance::join<T0>(&mut arg0.reserve_x, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg1, v5, arg5)));
        0x2::balance::join<T1>(&mut arg0.reserve_y, 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg2, v6, arg5)));
        arg0.total_shares = arg0.total_shares + v7;
        let v9 = LP<T0, T1>{
            id     : 0x2::object::new(arg5),
            pool   : 0x2::object::id<Pool<T0, T1>>(arg0),
            shares : v7,
        };
        let v10 = LiquidityAdded<T0, T1>{
            pool_id            : 0x2::object::id<Pool<T0, T1>>(arg0),
            lp_id              : 0x2::object::id<LP<T0, T1>>(&v9),
            provider           : 0x2::tx_context::sender(arg5),
            used_x             : v5,
            used_y             : v6,
            returned_x         : 0x2::coin::value<T0>(&arg1),
            returned_y         : 0x2::coin::value<T1>(&arg2),
            shares_minted      : v7,
            total_shares_after : arg0.total_shares,
            reserve_x_after    : 0x2::balance::value<T0>(&arg0.reserve_x),
            reserve_y_after    : 0x2::balance::value<T1>(&arg0.reserve_y),
            timestamp_ms       : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<LiquidityAdded<T0, T1>>(v10);
        (v9, arg1, arg2)
    }

    public(friend) fun can_swap_now<T0, T1>(arg0: &Pool<T0, T1>, arg1: &0x2::clock::Clock) : bool {
        protectTransaction(arg0.buytime, arg0.selltime, arg0.addtime, arg0.removetime, 0x2::clock::timestamp_ms(arg1))
    }

    fun ceil_div(arg0: u256, arg1: u256) : u256 {
        if (arg0 % arg1 == 0) {
            arg0 / arg1
        } else {
            arg0 / arg1 + 1
        }
    }

    public(friend) fun change_admin(arg0: &mut PoolRegistry, arg1: address) {
        arg0.admin = arg1;
        let v0 = PoolAdminChanged{
            registry_id : 0x2::object::id<PoolRegistry>(arg0),
            old_admin   : arg0.admin,
            new_admin   : arg0.admin,
        };
        0x2::event::emit<PoolAdminChanged>(v0);
    }

    public(friend) fun create_pool<T0>(arg0: 0x2::coin::Coin<T0>, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut PoolRegistry, arg3: &mut 0x2::tx_context::TxContext) : LP<T0, 0x2::sui::SUI> {
        assert!(0x1::type_name::with_defining_ids<T0>() != 0x1::type_name::with_defining_ids<0x2::sui::SUI>(), 4);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(!0x2::dynamic_field::exists<0x1::type_name::TypeName>(&arg2.id, v0), 5);
        0x2::dynamic_field::add<0x1::type_name::TypeName, u8>(&mut arg2.id, v0, 0);
        let v1 = 0x2::coin::value<T0>(&arg0);
        let v2 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v1 > 0 && v2 > 0, 0);
        let v3 = (min_u256((v1 as u256), (v2 as u256)) as u128);
        let v4 = Pool<T0, 0x2::sui::SUI>{
            id           : 0x2::object::new(arg3),
            reserve_x    : 0x2::coin::into_balance<T0>(arg0),
            reserve_y    : 0x2::coin::into_balance<0x2::sui::SUI>(arg1),
            total_shares : v3,
            buytime      : 0,
            selltime     : 0,
            addtime      : 0,
            removetime   : 0,
        };
        let v5 = LP<T0, 0x2::sui::SUI>{
            id     : 0x2::object::new(arg3),
            pool   : 0x2::object::id<Pool<T0, 0x2::sui::SUI>>(&v4),
            shares : v3,
        };
        let v6 = PoolCreated<T0, 0x2::sui::SUI>{
            registry_id   : 0x2::object::id<PoolRegistry>(arg2),
            pool_id       : 0x2::object::id<Pool<T0, 0x2::sui::SUI>>(&v4),
            initial_lp_id : 0x2::object::id<LP<T0, 0x2::sui::SUI>>(&v5),
            creator       : 0x2::tx_context::sender(arg3),
            amount_x      : v1,
            amount_y      : v2,
            total_shares  : v4.total_shares,
        };
        0x2::event::emit<PoolCreated<T0, 0x2::sui::SUI>>(v6);
        0x2::transfer::share_object<Pool<T0, 0x2::sui::SUI>>(v4);
        v5
    }

    public fun get_amount_out(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg0 > 0, 0);
        assert!(arg1 > 0 && arg2 > 0, 1);
        let v0 = (arg0 as u256) * (arg2 as u256) / ((arg1 as u256) + (arg0 as u256));
        assert!(v0 > 0 && v0 < (arg2 as u256), 1);
        (v0 as u64)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PoolRegistry{
            id    : 0x2::object::new(arg0),
            admin : 0x2::tx_context::sender(arg0),
        };
        let v1 = PoolRegistryCreated{
            registry_id : 0x2::object::id<PoolRegistry>(&v0),
            admin       : v0.admin,
        };
        0x2::event::emit<PoolRegistryCreated>(v1);
        0x2::transfer::share_object<PoolRegistry>(v0);
    }

    fun min_u256(arg0: u256, arg1: u256) : u256 {
        if (arg0 < arg1) {
            arg0
        } else {
            arg1
        }
    }

    public fun protectTransaction(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : bool {
        if (arg0 != arg4) {
            if (arg1 != arg4) {
                if (arg2 != arg4) {
                    arg3 != arg4
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        }
    }

    public(friend) fun quote_or_zero(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = if (arg0 == 0) {
            true
        } else if (arg1 == 0) {
            true
        } else {
            arg2 == 0
        };
        if (v0) {
            return 0
        };
        (((arg0 as u256) * (arg2 as u256) / ((arg1 as u256) + (arg0 as u256))) as u64)
    }

    public fun remove_liquidity<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: LP<T0, T1>, arg2: u64, arg3: u64, arg4: &PoolRegistry, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert!(protectTransaction(arg0.buytime, arg0.selltime, arg0.addtime, arg0.removetime, 0x2::clock::timestamp_ms(arg5)), 6);
        arg0.removetime = 0x2::clock::timestamp_ms(arg5);
        assert!(arg1.pool == 0x2::object::id<Pool<T0, T1>>(arg0), 3);
        let v0 = arg1.shares;
        assert!(v0 > 0 && v0 <= arg0.total_shares, 1);
        let v1 = (((0x2::balance::value<T0>(&arg0.reserve_x) as u256) * (v0 as u256) / (arg0.total_shares as u256)) as u64);
        let v2 = (((0x2::balance::value<T1>(&arg0.reserve_y) as u256) * (v0 as u256) / (arg0.total_shares as u256)) as u64);
        assert!(v1 > 0 && v2 > 0, 1);
        assert!(v1 >= arg2 && v2 >= arg3, 2);
        arg0.total_shares = arg0.total_shares - v0;
        let v3 = (((v2 as u128) / 100) as u64);
        let v4 = 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.reserve_x, v1), arg6);
        let v5 = 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.reserve_y, v2 - v3), arg6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.reserve_y, v3), arg6), arg4.admin);
        let LP {
            id     : v6,
            pool   : _,
            shares : _,
        } = arg1;
        0x2::object::delete(v6);
        let v9 = LiquidityRemoved<T0, T1>{
            pool_id            : 0x2::object::id<Pool<T0, T1>>(arg0),
            lp_id              : 0x2::object::id<LP<T0, T1>>(&arg1),
            caller             : 0x2::tx_context::sender(arg6),
            shares_burned      : v0,
            amount_x           : 0x2::coin::value<T0>(&v4),
            gross_y            : v2,
            net_y              : 0x2::coin::value<T1>(&v5),
            admin_fee_y        : v3,
            fee_recipient      : arg4.admin,
            min_x              : arg2,
            min_y              : arg3,
            total_shares_after : arg0.total_shares,
            reserve_x_after    : 0x2::balance::value<T0>(&arg0.reserve_x),
            reserve_y_after    : 0x2::balance::value<T1>(&arg0.reserve_y),
            timestamp_ms       : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<LiquidityRemoved<T0, T1>>(v9);
        (v4, v5)
    }

    public fun reserves<T0, T1>(arg0: &Pool<T0, T1>) : (u64, u64, u128) {
        (0x2::balance::value<T0>(&arg0.reserve_x), 0x2::balance::value<T1>(&arg0.reserve_y), arg0.total_shares)
    }

    public fun swap_x_to_y<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &PoolRegistry, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(protectTransaction(arg0.buytime, arg0.selltime, arg0.addtime, arg0.removetime, 0x2::clock::timestamp_ms(arg4)), 6);
        arg0.selltime = 0x2::clock::timestamp_ms(arg4);
        let v0 = 0x2::coin::value<T0>(&arg1);
        let v1 = get_amount_out(v0, 0x2::balance::value<T0>(&arg0.reserve_x), 0x2::balance::value<T1>(&arg0.reserve_y));
        let v2 = (((v1 as u128) * 15 / 1000) as u64);
        let v3 = v1 - v2 * 2;
        assert!(v3 >= arg2, 2);
        0x2::balance::join<T0>(&mut arg0.reserve_x, 0x2::coin::into_balance<T0>(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.reserve_y, v2), arg5), arg3.admin);
        let v4 = 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.reserve_y, v3), arg5);
        let v5 = SwapExecuted<T0, T1>{
            pool_id         : 0x2::object::id<Pool<T0, T1>>(arg0),
            caller          : 0x2::tx_context::sender(arg5),
            direction       : 0,
            package_route   : false,
            amount_in       : v0,
            gross_out       : v1,
            amount_out      : 0x2::coin::value<T1>(&v4),
            admin_fee       : v2,
            lp_fee          : v2,
            fee_recipient   : 0x1::option::some<address>(arg3.admin),
            min_out         : arg2,
            reserve_x_after : 0x2::balance::value<T0>(&arg0.reserve_x),
            reserve_y_after : 0x2::balance::value<T1>(&arg0.reserve_y),
            timestamp_ms    : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<SwapExecuted<T0, T1>>(v5);
        v4
    }

    public fun swap_y_to_x<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(protectTransaction(arg0.buytime, arg0.selltime, arg0.addtime, arg0.removetime, 0x2::clock::timestamp_ms(arg3)), 6);
        arg0.buytime = 0x2::clock::timestamp_ms(arg3);
        let v0 = 0x2::coin::value<T1>(&arg1);
        let v1 = get_amount_out(v0, 0x2::balance::value<T1>(&arg0.reserve_y), 0x2::balance::value<T0>(&arg0.reserve_x));
        assert!(v1 >= arg2, 2);
        0x2::balance::join<T1>(&mut arg0.reserve_y, 0x2::coin::into_balance<T1>(arg1));
        let v2 = 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.reserve_x, v1), arg4);
        let v3 = SwapExecuted<T0, T1>{
            pool_id         : 0x2::object::id<Pool<T0, T1>>(arg0),
            caller          : 0x2::tx_context::sender(arg4),
            direction       : 1,
            package_route   : false,
            amount_in       : v0,
            gross_out       : v1,
            amount_out      : 0x2::coin::value<T0>(&v2),
            admin_fee       : 0,
            lp_fee          : 0,
            fee_recipient   : 0x1::option::none<address>(),
            min_out         : arg2,
            reserve_x_after : 0x2::balance::value<T0>(&arg0.reserve_x),
            reserve_y_after : 0x2::balance::value<T1>(&arg0.reserve_y),
            timestamp_ms    : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<SwapExecuted<T0, T1>>(v3);
        v2
    }

    public(friend) fun swap_y_to_x_package<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        arg0.buytime = 0x2::clock::timestamp_ms(arg3);
        let v0 = 0x2::coin::value<T1>(&arg1);
        let v1 = get_amount_out(v0, 0x2::balance::value<T1>(&arg0.reserve_y), 0x2::balance::value<T0>(&arg0.reserve_x));
        assert!(v1 >= arg2, 2);
        0x2::balance::join<T1>(&mut arg0.reserve_y, 0x2::coin::into_balance<T1>(arg1));
        let v2 = 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.reserve_x, v1), arg4);
        let v3 = SwapExecuted<T0, T1>{
            pool_id         : 0x2::object::id<Pool<T0, T1>>(arg0),
            caller          : 0x2::tx_context::sender(arg4),
            direction       : 1,
            package_route   : true,
            amount_in       : v0,
            gross_out       : v1,
            amount_out      : 0x2::coin::value<T0>(&v2),
            admin_fee       : 0,
            lp_fee          : 0,
            fee_recipient   : 0x1::option::none<address>(),
            min_out         : arg2,
            reserve_x_after : 0x2::balance::value<T0>(&arg0.reserve_x),
            reserve_y_after : 0x2::balance::value<T1>(&arg0.reserve_y),
            timestamp_ms    : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<SwapExecuted<T0, T1>>(v3);
        v2
    }

    // decompiled from Move bytecode v7
}

