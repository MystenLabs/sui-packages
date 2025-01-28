module 0x87c75d1a2631a0c429ce7946fe379bb0d82ef0967e901325bea7f367774ee81e::bonding_curve {
    struct PoolCreated has copy, drop {
        pool_id: 0x2::object::ID,
        initial_token_amount: u64,
        virtual_reserve: u64,
        virtual_token_supply: u64,
        fee_percentage: u64,
    }

    struct SwapEvent has copy, drop {
        pool_id: 0x2::object::ID,
        reserve_amount: u64,
        token_amount: u64,
        price: u128,
        taker: address,
        is_buy: bool,
        pool_reserve: u64,
        pool_token: u64,
        virtual_reserve: u128,
        virtual_token: u128,
        token_address: 0x1::type_name::TypeName,
    }

    struct BondingCurveFinished has copy, drop {
        pool_id: 0x2::object::ID,
    }

    struct FeesClaimed has copy, drop {
        pool_id: 0x2::object::ID,
        amount: u64,
    }

    struct BondingCurvePool<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        virtual_reserve: u64,
        virtual_token_supply: u64,
        real_reserve_balance: 0x2::balance::Balance<T1>,
        real_token_balance: 0x2::balance::Balance<T0>,
        lp_creation_started: bool,
        lp_created: bool,
        fee_percentage: u64,
        fee_balance: 0x2::balance::Balance<T1>,
        current_price: u128,
    }

    public entry fun buy_and_take<T0, T1>(arg0: &mut BondingCurvePool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = buy_tokens<T0, T1>(arg0, arg1, arg2, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg3));
    }

    public fun buy_tokens<T0, T1>(arg0: &mut BondingCurvePool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::coin::value<T1>(&arg1);
        assert!(v0 > 0, 0);
        assert!(!arg0.lp_creation_started, 6);
        let v1 = v0 * arg0.fee_percentage / 10000;
        let v2 = v0;
        let v3 = v0 - v1;
        let v4 = calculate_output_tokens<T0, T1>(arg0, v3);
        assert!(v4 >= arg2, 1);
        let v5 = if (0x2::balance::value<T0>(&arg0.real_token_balance) - v4 < 200000000000000000) {
            let v6 = 0x2::balance::value<T0>(&arg0.real_token_balance) - 200000000000000000;
            assert!(v6 >= arg2, 1);
            let v7 = (((212118000000000 as u128) * (1100000000000000000 as u128) / ((arg0.virtual_token_supply as u128) - (v6 as u128)) - (arg0.virtual_reserve as u128)) as u64);
            let v8 = v7 * arg0.fee_percentage / 10000;
            0x2::balance::join<T1>(&mut arg0.fee_balance, 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg1, v8, arg3)));
            let v9 = v7 + v8;
            v2 = v9;
            let v10 = v0 - v9;
            if (v10 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::split<T1>(&mut arg1, v10, arg3), 0x2::tx_context::sender(arg3));
            };
            arg0.virtual_reserve = arg0.virtual_reserve + v7;
            arg0.virtual_token_supply = arg0.virtual_token_supply - v6;
            arg0.lp_creation_started = true;
            let v11 = BondingCurveFinished{pool_id: 0x2::object::id<BondingCurvePool<T0, T1>>(arg0)};
            0x2::event::emit<BondingCurveFinished>(v11);
            v6
        } else {
            arg0.virtual_reserve = arg0.virtual_reserve + v3;
            arg0.virtual_token_supply = arg0.virtual_token_supply - v4;
            0x2::balance::join<T1>(&mut arg0.fee_balance, 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg1, v1, arg3)));
            v4
        };
        arg0.current_price = get_token_price<T0, T1>(arg0);
        0x2::balance::join<T1>(&mut arg0.real_reserve_balance, 0x2::coin::into_balance<T1>(arg1));
        let v12 = SwapEvent{
            pool_id         : 0x2::object::id<BondingCurvePool<T0, T1>>(arg0),
            reserve_amount  : v2,
            token_amount    : v5,
            price           : arg0.current_price,
            taker           : 0x2::tx_context::sender(arg3),
            is_buy          : true,
            pool_reserve    : 0x2::balance::value<T1>(&arg0.real_reserve_balance),
            pool_token      : 0x2::balance::value<T0>(&arg0.real_token_balance),
            virtual_reserve : (arg0.virtual_reserve as u128),
            virtual_token   : (arg0.virtual_token_supply as u128),
            token_address   : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<SwapEvent>(v12);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.real_token_balance, v5), arg3)
    }

    fun calculate_output_reserve<T0, T1>(arg0: &BondingCurvePool<T0, T1>, arg1: u64) : u64 {
        (((arg0.virtual_reserve as u128) - (212118000000000 as u128) * (1100000000000000000 as u128) / ((arg0.virtual_token_supply as u128) + (arg1 as u128))) as u64)
    }

    fun calculate_output_tokens<T0, T1>(arg0: &BondingCurvePool<T0, T1>, arg1: u64) : u64 {
        (((arg0.virtual_token_supply as u128) - (212118000000000 as u128) * (1100000000000000000 as u128) / ((arg0.virtual_reserve as u128) + (arg1 as u128))) as u64)
    }

    public(friend) fun claim_pool_fees<T0, T1>(arg0: &mut BondingCurvePool<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::balance::value<T1>(&arg0.fee_balance);
        let v1 = FeesClaimed{
            pool_id : 0x2::object::id<BondingCurvePool<T0, T1>>(arg0),
            amount  : v0,
        };
        0x2::event::emit<FeesClaimed>(v1);
        0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.fee_balance, v0), arg1)
    }

    public(friend) fun create_bonding_curve<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: 0x2::coin::Coin<T1>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::coin::value<T0>(&arg0);
        assert!(v0 > 0, 0);
        let v1 = BondingCurvePool<T0, T1>{
            id                   : 0x2::object::new(arg3),
            virtual_reserve      : 212118000000000,
            virtual_token_supply : 1100000000000000000,
            real_reserve_balance : 0x2::balance::zero<T1>(),
            real_token_balance   : 0x2::coin::into_balance<T0>(arg0),
            lp_creation_started  : false,
            lp_created           : false,
            fee_percentage       : arg1,
            fee_balance          : 0x2::balance::zero<T1>(),
            current_price        : (212118000000000 as u128) * (10000 as u128) / (1100000000000000000 as u128),
        };
        let v2 = 0x2::object::id<BondingCurvePool<T0, T1>>(&v1);
        let v3 = PoolCreated{
            pool_id              : v2,
            initial_token_amount : v0,
            virtual_reserve      : 212118000000000,
            virtual_token_supply : 1100000000000000000,
            fee_percentage       : arg1,
        };
        0x2::event::emit<PoolCreated>(v3);
        if (0x2::coin::value<T1>(&arg2) > 0) {
            let v4 = &mut v1;
            buy_and_take<T0, T1>(v4, arg2, 0, arg3);
        } else {
            0x2::coin::destroy_zero<T1>(arg2);
        };
        0x2::transfer::public_share_object<BondingCurvePool<T0, T1>>(v1);
        v2
    }

    public fun current_price<T0, T1>(arg0: &BondingCurvePool<T0, T1>) : u128 {
        arg0.current_price
    }

    public fun get_fee_percentage<T0, T1>(arg0: &BondingCurvePool<T0, T1>) : u64 {
        arg0.fee_percentage
    }

    public fun get_pool_id<T0, T1>(arg0: &BondingCurvePool<T0, T1>) : 0x2::object::ID {
        0x2::object::id<BondingCurvePool<T0, T1>>(arg0)
    }

    public fun get_token_price<T0, T1>(arg0: &BondingCurvePool<T0, T1>) : u128 {
        let v0 = (arg0.virtual_reserve as u128);
        v0 * 1000000000 / (212118000000000 as u128) * v0 / (1100000000000000000 as u128)
    }

    public(friend) fun migrate_pool<T0, T1>(arg0: &mut BondingCurvePool<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert!(!arg0.lp_created, 3);
        assert!(arg0.lp_creation_started, 5);
        arg0.lp_created = true;
        (0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.real_token_balance, 0x2::balance::value<T0>(&arg0.real_token_balance)), arg1), 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.real_reserve_balance, 0x2::balance::value<T1>(&arg0.real_reserve_balance)), arg1))
    }

    public entry fun sell_and_take<T0, T1>(arg0: &mut BondingCurvePool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = sell_tokens<T0, T1>(arg0, arg1, arg2, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v0, 0x2::tx_context::sender(arg3));
    }

    public fun sell_tokens<T0, T1>(arg0: &mut BondingCurvePool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 0);
        assert!(!arg0.lp_creation_started, 6);
        let v1 = calculate_output_reserve<T0, T1>(arg0, v0);
        let v2 = v1 * arg0.fee_percentage / 10000;
        assert!(v1 - v2 >= arg2, 1);
        arg0.virtual_reserve = arg0.virtual_reserve - v1;
        arg0.virtual_token_supply = arg0.virtual_token_supply + v0;
        arg0.current_price = get_token_price<T0, T1>(arg0);
        0x2::balance::join<T0>(&mut arg0.real_token_balance, 0x2::coin::into_balance<T0>(arg1));
        let v3 = 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.real_reserve_balance, v1), arg3);
        0x2::balance::join<T1>(&mut arg0.fee_balance, 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut v3, v2, arg3)));
        let v4 = SwapEvent{
            pool_id         : 0x2::object::id<BondingCurvePool<T0, T1>>(arg0),
            reserve_amount  : v1,
            token_amount    : v0,
            price           : arg0.current_price,
            taker           : 0x2::tx_context::sender(arg3),
            is_buy          : false,
            pool_reserve    : 0x2::balance::value<T1>(&arg0.real_reserve_balance),
            pool_token      : 0x2::balance::value<T0>(&arg0.real_token_balance),
            virtual_reserve : (arg0.virtual_reserve as u128),
            virtual_token   : (arg0.virtual_token_supply as u128),
            token_address   : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<SwapEvent>(v4);
        v3
    }

    // decompiled from Move bytecode v6
}

