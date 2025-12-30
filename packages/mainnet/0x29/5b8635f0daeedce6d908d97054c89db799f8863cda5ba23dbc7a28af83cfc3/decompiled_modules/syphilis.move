module 0x295b8635f0daeedce6d908d97054c89db799f8863cda5ba23dbc7a28af83cfc3::syphilis {
    struct SYPHILIS has drop {
        dummy_field: bool,
    }

    struct LiquidityProviderCap has store, key {
        id: 0x2::object::UID,
        pool: 0x2::object::ID,
    }

    struct PoolRegistry has store, key {
        id: 0x2::object::UID,
        pools: vector<address>,
    }

    struct Pool<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        price_feeder: 0x2::vec_set::VecSet<address>,
        concentration: u64,
        reserve_x: 0x2::balance::Balance<T0>,
        reserve_y: 0x2::balance::Balance<T1>,
        norm_multiplier_x: u64,
        x_retain_decimals: u8,
        norm_multiplier_y: u64,
        y_retain_decimals: u8,
        virtual_liquidity_x: u64,
        virtual_liquidity_y_reference: u64,
        locked: bool,
        fee_millionth: u64,
        fee_x: 0x2::balance::Balance<T0>,
        fee_y: 0x2::balance::Balance<T1>,
        last_update_at: u64,
        price_feed_life: u64,
    }

    public fun add_price_feeders<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0x2::package::Publisher, arg2: vector<address>) {
        assert!(0x2::package::from_module<SYPHILIS>(arg1), 13906835445653700607);
        0x1::vector::reverse<address>(&mut arg2);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg2)) {
            0x2::vec_set::insert<address>(&mut arg0.price_feeder, 0x1::vector::pop_back<address>(&mut arg2));
            v0 = v0 + 1;
        };
        0x1::vector::destroy_empty<address>(arg2);
    }

    fun address_is_price_feeder<T0, T1>(arg0: &Pool<T0, T1>, arg1: address) : bool {
        0x2::vec_set::contains<address>(&arg0.price_feeder, &arg1)
    }

    public fun create_pool<T0, T1>(arg0: &0x2::package::Publisher, arg1: &mut PoolRegistry, arg2: u8, arg3: u8, arg4: u8, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : Pool<T0, T1> {
        0x2::package::from_module<SYPHILIS>(arg0);
        assert!(arg2 >= arg3 && arg2 >= arg4, 13906834474991091711);
        assert!(arg5 < 1000000, 13906834479286059007);
        let v0 = 0x2::object::new(arg7);
        0x1::vector::push_back<address>(&mut arg1.pools, 0x2::object::uid_to_address(&v0));
        Pool<T0, T1>{
            id                            : v0,
            price_feeder                  : 0x2::vec_set::empty<address>(),
            concentration                 : 0,
            reserve_x                     : 0x2::balance::zero<T0>(),
            reserve_y                     : 0x2::balance::zero<T1>(),
            norm_multiplier_x             : 0,
            x_retain_decimals             : arg2 - arg3,
            norm_multiplier_y             : 0,
            y_retain_decimals             : arg2 - arg4,
            virtual_liquidity_x           : 0,
            virtual_liquidity_y_reference : 0,
            locked                        : false,
            fee_millionth                 : arg5,
            fee_x                         : 0x2::balance::zero<T0>(),
            fee_y                         : 0x2::balance::zero<T1>(),
            last_update_at                : 0x2::clock::timestamp_ms(arg6),
            price_feed_life               : 30000,
        }
    }

    public fun create_pool_shared<T0, T1>(arg0: &0x2::package::Publisher, arg1: &mut PoolRegistry, arg2: u8, arg3: u8, arg4: u8, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_share_object<Pool<T0, T1>>(create_pool<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7));
    }

    public fun deposit<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &LiquidityProviderCap, arg2: 0x2::balance::Balance<T0>, arg3: 0x2::balance::Balance<T1>) {
        assert!(0x2::object::id<Pool<T0, T1>>(arg0) == arg1.pool, 13906835273855008767);
        if (0x2::balance::value<T0>(&arg2) == 0) {
            0x2::balance::destroy_zero<T0>(arg2);
        } else {
            arg0.virtual_liquidity_x = arg0.virtual_liquidity_x + 0x2::balance::value<T0>(&arg2);
            0x2::balance::join<T0>(&mut arg0.reserve_x, arg2);
        };
        if (0x2::balance::value<T1>(&arg3) == 0) {
            0x2::balance::destroy_zero<T1>(arg3);
        } else {
            0x2::balance::join<T1>(&mut arg0.reserve_y, arg3);
        };
    }

    fun get_virtual_liquidity_y<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        (0x2::balance::value<T0>(&arg0.reserve_x) * arg0.norm_multiplier_x + 0x2::balance::value<T1>(&arg0.reserve_y) * arg0.norm_multiplier_y - arg0.virtual_liquidity_x * arg0.norm_multiplier_x) / arg0.norm_multiplier_y
    }

    public fun grant_lp_cap<T0, T1>(arg0: &0x2::package::Publisher, arg1: &Pool<T0, T1>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::package::from_module<SYPHILIS>(arg0), 13906834672559587327);
        let v0 = LiquidityProviderCap{
            id   : 0x2::object::new(arg3),
            pool : 0x2::object::id<Pool<T0, T1>>(arg1),
        };
        0x2::transfer::transfer<LiquidityProviderCap>(v0, arg2);
    }

    fun init(arg0: SYPHILIS, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<SYPHILIS>(arg0, arg1);
        let v0 = PoolRegistry{
            id    : 0x2::object::new(arg1),
            pools : 0x1::vector::empty<address>(),
        };
        0x2::transfer::share_object<PoolRegistry>(v0);
    }

    fun is_locked<T0, T1>(arg0: &mut Pool<T0, T1>) : bool {
        let v0 = get_virtual_liquidity_y<T0, T1>(arg0);
        arg0.virtual_liquidity_y_reference = 0x1::u64::max(arg0.virtual_liquidity_y_reference, v0);
        if ((arg0.virtual_liquidity_y_reference - v0) * 10000 / arg0.virtual_liquidity_y_reference > 500) {
            arg0.locked = true;
        };
        arg0.locked
    }

    public fun quote_x_2_y<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64) : (u64, u64) {
        if (is_locked<T0, T1>(arg0)) {
            (0, 0)
        } else {
            quote_x_2_y_((arg1 as u128), (arg0.virtual_liquidity_x as u128), (arg0.concentration as u128), (0x2::balance::value<T0>(&arg0.reserve_x) as u128), (0x2::balance::value<T1>(&arg0.reserve_y) as u128), arg0.fee_millionth, (arg0.norm_multiplier_x as u128), (arg0.norm_multiplier_y as u128))
        }
    }

    fun quote_x_2_y_(arg0: u128, arg1: u128, arg2: u128, arg3: u128, arg4: u128, arg5: u64, arg6: u128, arg7: u128) : (u64, u64) {
        let v0 = arg1 * arg2;
        let v1 = v0 * v0 * arg6 / arg7;
        let v2 = v0 + arg3 - arg1;
        let v3 = ((v1 / v2 - v1 / (v2 + arg0)) as u64);
        assert!((v3 as u128) < arg4, 3);
        let v4 = v3 * arg5 / 1000000;
        (v3 - v4, v4)
    }

    public fun quote_y_2_x<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64) : (u64, u64) {
        if (is_locked<T0, T1>(arg0)) {
            (0, 0)
        } else {
            quote_y_to_x_((arg1 as u128), (arg0.virtual_liquidity_x as u128), (arg0.concentration as u128), (0x2::balance::value<T0>(&arg0.reserve_x) as u128), (0x2::balance::value<T1>(&arg0.reserve_y) as u128), arg0.fee_millionth, (arg0.norm_multiplier_x as u128), (arg0.norm_multiplier_y as u128))
        }
    }

    fun quote_y_to_x_(arg0: u128, arg1: u128, arg2: u128, arg3: u128, arg4: u128, arg5: u64, arg6: u128, arg7: u128) : (u64, u64) {
        let v0 = arg1 * arg2;
        let v1 = v0 * v0 * arg6 / arg7;
        let v2 = v0 + arg3 - arg1;
        let v3 = ((v2 - v1 / (v1 / v2 + arg0)) as u64);
        assert!((v3 as u128) < arg3, 2);
        let v4 = v3 * arg5 / 1000000;
        (v3 - v4, v4)
    }

    public fun remove_price_feeders<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0x2::package::Publisher, arg2: vector<address>) {
        assert!(0x2::package::from_module<SYPHILIS>(arg1), 13906835484308406271);
        0x1::vector::reverse<address>(&mut arg2);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg2)) {
            let v1 = 0x1::vector::pop_back<address>(&mut arg2);
            0x2::vec_set::remove<address>(&mut arg0.price_feeder, &v1);
            v0 = v0 + 1;
        };
        0x1::vector::destroy_empty<address>(arg2);
    }

    public fun swap_x_2_y<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64, arg2: 0x2::balance::Balance<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        assert!(0x2::clock::timestamp_ms(arg3) - arg0.last_update_at < arg0.price_feed_life, 13906834934552592383);
        assert!(!arg0.locked, 13906834938847559679);
        let v0 = if (arg1 == 0) {
            0x2::balance::value<T0>(&arg2)
        } else {
            arg1
        };
        let (v1, v2) = quote_x_2_y<T0, T1>(arg0, v0);
        assert!(v1 > 0, 13906834968912330751);
        0x2::balance::join<T0>(&mut arg0.reserve_x, 0x2::balance::split<T0>(&mut arg2, v0));
        0x2::balance::join<T1>(&mut arg0.fee_y, 0x2::balance::split<T1>(&mut arg0.reserve_y, v2));
        (arg2, 0x2::balance::split<T1>(&mut arg0.reserve_y, v1))
    }

    public fun swap_y_2_x<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64, arg2: 0x2::balance::Balance<T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        assert!(0x2::clock::timestamp_ms(arg3) - arg0.last_update_at < arg0.price_feed_life, 13906835029041872895);
        assert!(!arg0.locked, 13906835033336840191);
        let v0 = if (arg1 == 0) {
            0x2::balance::value<T1>(&arg2)
        } else {
            arg1
        };
        let (v1, v2) = quote_y_2_x<T0, T1>(arg0, v0);
        assert!(v1 > 0, 13906835063401611263);
        0x2::balance::join<T1>(&mut arg0.reserve_y, 0x2::balance::split<T1>(&mut arg2, v0));
        0x2::balance::join<T0>(&mut arg0.fee_x, 0x2::balance::split<T0>(&mut arg0.reserve_x, v2));
        (0x2::balance::split<T0>(&mut arg0.reserve_x, v1), arg2)
    }

    public fun unlock<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0x2::package::Publisher) {
        assert!(0x2::package::from_module<SYPHILIS>(arg1), 13906835694761803775);
        unlock_internal<T0, T1>(arg0);
    }

    public fun unlock_by_lp<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &LiquidityProviderCap) {
        assert!(arg1.pool == 0x2::object::id<Pool<T0, T1>>(arg0), 13906835716236640255);
        unlock_internal<T0, T1>(arg0);
    }

    fun unlock_internal<T0, T1>(arg0: &mut Pool<T0, T1>) {
        arg0.locked = false;
        arg0.virtual_liquidity_y_reference = 0;
    }

    public fun update_concentration<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0x2::package::Publisher, arg2: u64) {
        assert!(0x2::package::from_module<SYPHILIS>(arg1), 13906834698329391103);
        assert!(arg2 < 20000, 0);
        assert!(arg2 >= 1, 0);
        arg0.concentration = arg2;
    }

    public fun update_fee_millionth<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0x2::package::Publisher, arg2: u64) {
        assert!(0x2::package::from_module<SYPHILIS>(arg1), 13906834728394162175);
        assert!(arg2 < 1000000, 13906834732689129471);
        arg0.fee_millionth = arg2;
    }

    public fun update_prices<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(address_is_price_feeder<T0, T1>(arg0, 0x2::tx_context::sender(arg5)), 2);
        assert!(arg0.last_update_at < arg3, 13906835540142981119);
        if (0x2::clock::timestamp_ms(arg4) <= arg3 || 0x2::clock::timestamp_ms(arg4) > arg3 + arg0.price_feed_life) {
            abort 0x2::clock::timestamp_ms(arg4)
        };
        arg0.norm_multiplier_x = arg1;
        arg0.norm_multiplier_y = arg2;
    }

    public fun withdraw<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &LiquidityProviderCap, arg2: u64, arg3: u64) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        assert!(0x2::object::id<Pool<T0, T1>>(arg0) == arg1.pool, 13906835359754354687);
        let v0 = if (arg2 == 0) {
            0x2::balance::zero<T0>()
        } else {
            arg0.virtual_liquidity_x = arg0.virtual_liquidity_x - arg2;
            0x2::balance::split<T0>(&mut arg0.reserve_x, arg2)
        };
        let v1 = if (arg3 == 0) {
            0x2::balance::zero<T1>()
        } else {
            0x2::balance::split<T1>(&mut arg0.reserve_y, arg3)
        };
        (v0, v1)
    }

    // decompiled from Move bytecode v6
}

