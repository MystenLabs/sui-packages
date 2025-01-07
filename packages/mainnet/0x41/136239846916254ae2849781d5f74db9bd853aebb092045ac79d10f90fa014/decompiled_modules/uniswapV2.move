module 0x41136239846916254ae2849781d5f74db9bd853aebb092045ac79d10f90fa014::uniswapV2 {
    struct PoolCreated has copy, drop {
        pool_id: 0x2::object::ID,
        a: 0x1::type_name::TypeName,
        b: 0x1::type_name::TypeName,
        init_a: u64,
        init_b: u64,
        lp_minted: u64,
    }

    struct LiquidityAdded has copy, drop {
        pool_id: 0x2::object::ID,
        a: 0x1::type_name::TypeName,
        b: 0x1::type_name::TypeName,
        amountin_a: u64,
        amountin_b: u64,
        lp_minted: u64,
    }

    struct LiquidityRemoved has copy, drop {
        pool_id: 0x2::object::ID,
        a: 0x1::type_name::TypeName,
        b: 0x1::type_name::TypeName,
        amountout_a: u64,
        amountout_b: u64,
        lp_burnt: u64,
    }

    struct Swapped has copy, drop {
        pool_id: 0x2::object::ID,
        tokenin: 0x1::type_name::TypeName,
        amountin: u64,
        tokenout: 0x1::type_name::TypeName,
        amountout: u64,
    }

    struct LP<phantom T0, phantom T1> has drop {
        dummy_field: bool,
    }

    struct Pool<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        balance_a: 0x2::balance::Balance<T0>,
        balance_b: 0x2::balance::Balance<T1>,
        lp_supply: 0x2::balance::Supply<LP<T0, T1>>,
        fee_points: u64,
    }

    struct Factory has key {
        id: 0x2::object::UID,
        table: 0x2::table::Table<PoolItem, bool>,
    }

    struct PoolItem has copy, drop, store {
        a: 0x1::type_name::TypeName,
        b: 0x1::type_name::TypeName,
    }

    public fun add_liquidity<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: 0x2::balance::Balance<T1>, arg3: u64) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, 0x2::balance::Balance<LP<T0, T1>>) {
        assert!(0x2::balance::value<T0>(&arg1) > 0 && 0x2::balance::value<T1>(&arg2) > 0, 0);
        let v0 = (0x2::balance::value<T0>(&arg1) as u128) * (0x2::balance::value<T1>(&arg0.balance_b) as u128);
        let v1 = (0x2::balance::value<T1>(&arg2) as u128) * (0x2::balance::value<T0>(&arg0.balance_a) as u128);
        let (v2, v3, v4) = if (v0 > v1) {
            let v5 = 0x2::balance::value<T1>(&arg2);
            ((ceil_div_u128(v1, (0x2::balance::value<T1>(&arg0.balance_b) as u128)) as u64), v5, muldiv(v5, 0x2::balance::supply_value<LP<T0, T1>>(&arg0.lp_supply), 0x2::balance::value<T1>(&arg0.balance_b)))
        } else if (v0 < v1) {
            let v6 = 0x2::balance::value<T0>(&arg1);
            (v6, (ceil_div_u128(v0, (0x2::balance::value<T0>(&arg0.balance_a) as u128)) as u64), muldiv(v6, 0x2::balance::supply_value<LP<T0, T1>>(&arg0.lp_supply), 0x2::balance::value<T0>(&arg0.balance_a)))
        } else {
            let v7 = 0x2::balance::value<T0>(&arg1);
            let v8 = 0x2::balance::value<T1>(&arg2);
            let v4 = if (0x2::balance::supply_value<LP<T0, T1>>(&arg0.lp_supply) == 0) {
                mulsqrt(v7, v8)
            } else {
                muldiv(v7, 0x2::balance::supply_value<LP<T0, T1>>(&arg0.lp_supply), 0x2::balance::value<T0>(&arg0.balance_a))
            };
            (v7, v8, v4)
        };
        0x2::balance::join<T0>(&mut arg0.balance_a, 0x2::balance::split<T0>(&mut arg1, v2));
        0x2::balance::join<T1>(&mut arg0.balance_b, 0x2::balance::split<T1>(&mut arg2, v3));
        assert!(v4 >= arg3, 3);
        let v9 = LiquidityAdded{
            pool_id    : 0x2::object::id<Pool<T0, T1>>(arg0),
            a          : 0x1::type_name::get<T0>(),
            b          : 0x1::type_name::get<T1>(),
            amountin_a : v2,
            amountin_b : v3,
            lp_minted  : v4,
        };
        0x2::event::emit<LiquidityAdded>(v9);
        (arg1, arg2, 0x2::balance::increase_supply<LP<T0, T1>>(&mut arg0.lp_supply, v4))
    }

    public fun add_liquidity_with_coins<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, 0x2::coin::Coin<LP<T0, T1>>) {
        let (v0, v1, v2) = add_liquidity<T0, T1>(arg0, 0x2::coin::into_balance<T0>(arg1), 0x2::coin::into_balance<T1>(arg2), arg3);
        (0x2::coin::from_balance<T0>(v0, arg4), 0x2::coin::from_balance<T1>(v1, arg4), 0x2::coin::from_balance<LP<T0, T1>>(v2, arg4))
    }

    public entry fun add_liquidity_with_coins_and_transfer_to_sender<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = add_liquidity<T0, T1>(arg0, 0x2::coin::into_balance<T0>(arg1), 0x2::coin::into_balance<T1>(arg2), arg3);
        let v3 = 0x2::tx_context::sender(arg4);
        destroy_zero_or_transfer_balance<T0>(v0, v3, arg4);
        destroy_zero_or_transfer_balance<T1>(v1, v3, arg4);
        destroy_zero_or_transfer_balance<LP<T0, T1>>(v2, v3, arg4);
    }

    fun add_pool<T0, T1>(arg0: &mut Factory) {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x1::type_name::get<T1>();
        assert!(cmp_type_names(&v0, &v1) == 0, 1);
        let v2 = PoolItem{
            a : v0,
            b : v1,
        };
        assert!(0x2::table::contains<PoolItem, bool>(&arg0.table, v2) == false, 2);
        0x2::table::add<PoolItem, bool>(&mut arg0.table, v2, true);
    }

    fun calc_swap_out(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        let v0 = arg0 - ceil_muldiv(arg0, arg3, 10000);
        muldiv(v0, arg2, arg1 + v0)
    }

    fun ceil_div_u128(arg0: u128, arg1: u128) : u128 {
        if (arg0 == 0) {
            0
        } else {
            (arg0 - 1) / arg1 + 1
        }
    }

    fun ceil_muldiv(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (ceil_div_u128((arg0 as u128) * (arg1 as u128), (arg2 as u128)) as u64)
    }

    public fun cmp_type_names(arg0: &0x1::type_name::TypeName, arg1: &0x1::type_name::TypeName) : u8 {
        let v0 = 0x1::ascii::as_bytes(0x1::type_name::borrow_string(arg0));
        let v1 = 0x1::ascii::as_bytes(0x1::type_name::borrow_string(arg1));
        let v2 = 0x1::vector::length<u8>(v0);
        let v3 = 0x1::vector::length<u8>(v1);
        let v4 = 0;
        while (v4 < 0x2::math::min(v2, v3)) {
            let v5 = *0x1::vector::borrow<u8>(v0, v4);
            let v6 = *0x1::vector::borrow<u8>(v1, v4);
            if (v5 < v6) {
                return 0
            };
            if (v5 > v6) {
                return 2
            };
            v4 = v4 + 1;
        };
        if (v2 == v3) {
            return 1
        };
        if (v2 < v3) {
            0
        } else {
            2
        }
    }

    public fun create_pool<T0, T1>(arg0: &mut Factory, arg1: 0x2::balance::Balance<T0>, arg2: 0x2::balance::Balance<T1>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<LP<T0, T1>> {
        assert!(0x2::balance::value<T0>(&arg1) > 0 && 0x2::balance::value<T1>(&arg2) > 0, 0);
        add_pool<T0, T1>(arg0);
        let v0 = LP<T0, T1>{dummy_field: false};
        let v1 = Pool<T0, T1>{
            id         : 0x2::object::new(arg3),
            balance_a  : arg1,
            balance_b  : arg2,
            lp_supply  : 0x2::balance::create_supply<LP<T0, T1>>(v0),
            fee_points : 30,
        };
        let v2 = mulsqrt(0x2::balance::value<T0>(&v1.balance_a), 0x2::balance::value<T1>(&v1.balance_b));
        let v3 = PoolCreated{
            pool_id   : 0x2::object::id<Pool<T0, T1>>(&v1),
            a         : 0x1::type_name::get<T0>(),
            b         : 0x1::type_name::get<T1>(),
            init_a    : 0x2::balance::value<T0>(&v1.balance_a),
            init_b    : 0x2::balance::value<T1>(&v1.balance_b),
            lp_minted : v2,
        };
        0x2::event::emit<PoolCreated>(v3);
        0x2::transfer::share_object<Pool<T0, T1>>(v1);
        0x2::balance::increase_supply<LP<T0, T1>>(&mut v1.lp_supply, v2)
    }

    public fun create_pool_with_coins<T0, T1>(arg0: &mut Factory, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<LP<T0, T1>> {
        let v0 = create_pool<T0, T1>(arg0, 0x2::coin::into_balance<T0>(arg1), 0x2::coin::into_balance<T1>(arg2), arg3);
        0x2::coin::from_balance<LP<T0, T1>>(v0, arg3)
    }

    public entry fun create_pool_with_coins_and_transfer_lp_to_sender<T0, T1>(arg0: &mut Factory, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = create_pool<T0, T1>(arg0, 0x2::coin::into_balance<T0>(arg1), 0x2::coin::into_balance<T1>(arg2), arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<LP<T0, T1>>>(0x2::coin::from_balance<LP<T0, T1>>(v0, arg3), 0x2::tx_context::sender(arg3));
    }

    fun destroy_zero_or_transfer_balance<T0>(arg0: 0x2::balance::Balance<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&arg0) == 0) {
            0x2::balance::destroy_zero<T0>(arg0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg0, arg2), arg1);
        };
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Factory{
            id    : 0x2::object::new(arg0),
            table : 0x2::table::new<PoolItem, bool>(arg0),
        };
        0x2::transfer::share_object<Factory>(v0);
    }

    fun muldiv(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    fun mulsqrt(arg0: u64, arg1: u64) : u64 {
        (0x2::math::sqrt_u128((arg0 as u128) * (arg1 as u128)) as u64)
    }

    public fun pool_balances<T0, T1>(arg0: &Pool<T0, T1>) : (u64, u64, u64) {
        (0x2::balance::value<T0>(&arg0.balance_a), 0x2::balance::value<T1>(&arg0.balance_b), 0x2::balance::supply_value<LP<T0, T1>>(&arg0.lp_supply))
    }

    public fun pool_fees<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        arg0.fee_points
    }

    public fun remove_liquidity<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::balance::Balance<LP<T0, T1>>, arg2: u64, arg3: u64) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        assert!(0x2::balance::value<LP<T0, T1>>(&arg1) > 0, 0);
        let v0 = 0x2::balance::value<LP<T0, T1>>(&arg1);
        let v1 = 0x2::balance::supply_value<LP<T0, T1>>(&arg0.lp_supply);
        let v2 = muldiv(v0, 0x2::balance::value<T0>(&arg0.balance_a), v1);
        let v3 = muldiv(v0, 0x2::balance::value<T1>(&arg0.balance_b), v1);
        assert!(v2 >= arg2, 3);
        assert!(v3 >= arg3, 3);
        0x2::balance::decrease_supply<LP<T0, T1>>(&mut arg0.lp_supply, arg1);
        let v4 = LiquidityRemoved{
            pool_id     : 0x2::object::id<Pool<T0, T1>>(arg0),
            a           : 0x1::type_name::get<T0>(),
            b           : 0x1::type_name::get<T1>(),
            amountout_a : v2,
            amountout_b : v3,
            lp_burnt    : v0,
        };
        0x2::event::emit<LiquidityRemoved>(v4);
        (0x2::balance::split<T0>(&mut arg0.balance_a, v2), 0x2::balance::split<T1>(&mut arg0.balance_b, v3))
    }

    public fun remove_liquidity_with_coins<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<LP<T0, T1>>, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let (v0, v1) = remove_liquidity<T0, T1>(arg0, 0x2::coin::into_balance<LP<T0, T1>>(arg1), arg2, arg3);
        (0x2::coin::from_balance<T0>(v0, arg4), 0x2::coin::from_balance<T1>(v1, arg4))
    }

    public entry fun remove_liquidity_with_coins_and_transfer_to_sender<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<LP<T0, T1>>, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = remove_liquidity<T0, T1>(arg0, 0x2::coin::into_balance<LP<T0, T1>>(arg1), arg2, arg3);
        let v2 = 0x2::tx_context::sender(arg4);
        destroy_zero_or_transfer_balance<T0>(v0, v2, arg4);
        destroy_zero_or_transfer_balance<T1>(v1, v2, arg4);
    }

    public fun swap_a_for_b<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: u64) : 0x2::balance::Balance<T1> {
        assert!(0x2::balance::value<T0>(&arg1) > 0, 0);
        assert!(0x2::balance::value<T0>(&arg0.balance_a) > 0 && 0x2::balance::value<T1>(&arg0.balance_b) > 0, 4);
        let v0 = 0x2::balance::value<T0>(&arg1);
        let v1 = calc_swap_out(v0, 0x2::balance::value<T0>(&arg0.balance_a), 0x2::balance::value<T1>(&arg0.balance_b), arg0.fee_points);
        assert!(v1 >= arg2, 3);
        0x2::balance::join<T0>(&mut arg0.balance_a, arg1);
        let v2 = Swapped{
            pool_id   : 0x2::object::id<Pool<T0, T1>>(arg0),
            tokenin   : 0x1::type_name::get<T0>(),
            amountin  : v0,
            tokenout  : 0x1::type_name::get<T1>(),
            amountout : v1,
        };
        0x2::event::emit<Swapped>(v2);
        0x2::balance::split<T1>(&mut arg0.balance_b, v1)
    }

    public fun swap_a_for_b_with_coin<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x2::coin::from_balance<T1>(swap_a_for_b<T0, T1>(arg0, 0x2::coin::into_balance<T0>(arg1), arg2), arg3)
    }

    public entry fun swap_a_for_b_with_coin_and_transfer_to_sender<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(swap_a_for_b<T0, T1>(arg0, 0x2::coin::into_balance<T0>(arg1), arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    public fun swap_b_for_a<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::balance::Balance<T1>, arg2: u64) : 0x2::balance::Balance<T0> {
        assert!(0x2::balance::value<T1>(&arg1) > 0, 0);
        assert!(0x2::balance::value<T0>(&arg0.balance_a) > 0 && 0x2::balance::value<T1>(&arg0.balance_b) > 0, 4);
        let v0 = 0x2::balance::value<T1>(&arg1);
        let v1 = calc_swap_out(v0, 0x2::balance::value<T1>(&arg0.balance_b), 0x2::balance::value<T0>(&arg0.balance_a), arg0.fee_points);
        assert!(v1 >= arg2, 3);
        0x2::balance::join<T1>(&mut arg0.balance_b, arg1);
        let v2 = Swapped{
            pool_id   : 0x2::object::id<Pool<T0, T1>>(arg0),
            tokenin   : 0x1::type_name::get<T1>(),
            amountin  : v0,
            tokenout  : 0x1::type_name::get<T0>(),
            amountout : v1,
        };
        0x2::event::emit<Swapped>(v2);
        0x2::balance::split<T0>(&mut arg0.balance_a, v1)
    }

    public fun swap_b_for_a_with_coin<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::from_balance<T0>(swap_b_for_a<T0, T1>(arg0, 0x2::coin::into_balance<T1>(arg1), arg2), arg3)
    }

    public entry fun swap_b_for_a_with_coin_and_transfer_to_sender<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(swap_b_for_a<T0, T1>(arg0, 0x2::coin::into_balance<T1>(arg1), arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

