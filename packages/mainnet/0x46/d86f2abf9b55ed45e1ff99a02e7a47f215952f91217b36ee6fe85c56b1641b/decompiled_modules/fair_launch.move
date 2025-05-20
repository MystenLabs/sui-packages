module 0x46d86f2abf9b55ed45e1ff99a02e7a47f215952f91217b36ee6fe85c56b1641b::fair_launch {
    struct FairLaunch<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        curator: address,
        start_time: u64,
        end_time: u64,
        soft_cap: u64,
        max_contribution: u64,
        liquidity_percent: u64,
        lp_lock_period: u64,
        total_tokens: u64,
        balance_x: 0x2::balance::Balance<T0>,
        balance_y: 0x2::balance::Balance<T1>,
        contributions: 0x2::table::Table<address, u64>,
        is_finalized: bool,
        contributed: u64,
        total_claimable_x: u64,
    }

    struct Proof<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        market_id: 0x2::object::ID,
        contributed_y: u64,
    }

    struct Locker<T0> has store, key {
        id: 0x2::object::UID,
        item: T0,
        unlock_at: u64,
    }

    struct FairLaunchCreated<phantom T0, phantom T1> has copy, drop {
        market_address: address,
        start_time: u64,
        end_time: u64,
        soft_cap: u64,
        max_contribution: u64,
        liquidity_percent: u64,
        lp_lock_period: u64,
        total_tokens: u64,
    }

    struct FairLaunchContributed<phantom T0, phantom T1> has copy, drop {
        market_address: address,
        timestamp: u64,
        amount: u64,
        coin_y_address: address,
        sender: address,
        proof_address: address,
    }

    struct FairLaunchFinalized<phantom T0, phantom T1> has copy, drop {
        market_address: address,
        finalize_time: u64,
        lp_unlock_time: u64,
        cetus_pool_address: address,
        initialize_price: u128,
    }

    struct FairLaunchClaimed<phantom T0, phantom T1> has copy, drop {
        market_address: address,
        proof_address: address,
        contributed_y: u64,
        claimable_x: u64,
        recipient: address,
    }

    struct FairLaunchRefunded<phantom T0, phantom T1> has copy, drop {
        market_address: address,
        proof_address: address,
        contributed_y: u64,
        recipient: address,
    }

    public fun claim<T0, T1>(arg0: &mut FairLaunch<T0, T1>, arg1: Proof<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg0.is_finalized, 8);
        assert!(0x2::object::uid_to_bytes(&arg0.id) == 0x2::object::id_to_bytes(&arg1.market_id), 7);
        let v0 = arg1.contributed_y * arg0.total_tokens / arg0.contributed;
        let Proof {
            id            : v1,
            market_id     : _,
            contributed_y : v3,
        } = arg1;
        let v4 = v1;
        0x2::object::delete(v4);
        let v5 = FairLaunchClaimed<T0, T1>{
            market_address : 0x2::object::uid_to_address(&arg0.id),
            proof_address  : 0x2::object::uid_to_address(&v4),
            contributed_y  : v3,
            claimable_x    : v0,
            recipient      : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<FairLaunchClaimed<T0, T1>>(v5);
        0x2::coin::take<T0>(&mut arg0.balance_x, v0, arg2)
    }

    public fun contribute<T0, T1>(arg0: &mut FairLaunch<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : (Proof<T0, T1>, 0x2::coin::Coin<T1>) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(!arg0.is_finalized, 2);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        assert!(v1 >= arg0.start_time && v1 <= arg0.end_time, 3);
        let v2 = 0x2::coin::value<T1>(&arg1);
        assert!(v2 > 0, 1);
        if (!0x2::table::contains<address, u64>(&arg0.contributions, v0)) {
            0x2::table::add<address, u64>(&mut arg0.contributions, v0, 0);
        };
        let v3 = 0x2::table::borrow_mut<address, u64>(&mut arg0.contributions, v0);
        assert!(*v3 + v2 <= arg0.max_contribution, 5);
        *v3 = *v3 + v2;
        arg0.contributed = arg0.contributed + v2;
        0x2::balance::join<T1>(&mut arg0.balance_y, 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg1, v2, arg3)));
        let v4 = Proof<T0, T1>{
            id            : 0x2::object::new(arg3),
            market_id     : 0x2::object::id_from_bytes(0x2::object::uid_to_bytes(&arg0.id)),
            contributed_y : v2,
        };
        let v5 = FairLaunchContributed<T0, T1>{
            market_address : 0x2::object::uid_to_address(&arg0.id),
            timestamp      : v1,
            amount         : v2,
            coin_y_address : 0x2::object::id_address<0x2::coin::Coin<T1>>(&arg1),
            sender         : v0,
            proof_address  : 0x2::object::uid_to_address(&v4.id),
        };
        0x2::event::emit<FairLaunchContributed<T0, T1>>(v5);
        (v4, arg1)
    }

    public fun create_fair_launch<T0, T1>(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: 0x2::coin::Coin<T0>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg0 < arg1, 1);
        assert!(arg0 > 0x2::clock::timestamp_ms(arg8), 1);
        validate_params(arg2, arg3, arg4, arg6, 0x2::coin::value<T0>(&arg7));
        let v0 = FairLaunch<T0, T1>{
            id                : 0x2::object::new(arg9),
            curator           : 0x2::tx_context::sender(arg9),
            start_time        : arg0,
            end_time          : arg1,
            soft_cap          : arg2,
            max_contribution  : arg3,
            liquidity_percent : arg4,
            lp_lock_period    : arg5,
            total_tokens      : arg6,
            balance_x         : 0x2::coin::into_balance<T0>(arg7),
            balance_y         : 0x2::balance::zero<T1>(),
            contributions     : 0x2::table::new<address, u64>(arg9),
            is_finalized      : false,
            contributed       : 0,
            total_claimable_x : 0,
        };
        0x2::transfer::share_object<FairLaunch<T0, T1>>(v0);
        let v1 = FairLaunchCreated<T0, T1>{
            market_address    : 0x2::object::uid_to_address(&v0.id),
            start_time        : arg0,
            end_time          : arg1,
            soft_cap          : arg2,
            max_contribution  : arg3,
            liquidity_percent : arg4,
            lp_lock_period    : arg5,
            total_tokens      : arg6,
        };
        0x2::event::emit<FairLaunchCreated<T0, T1>>(v1);
    }

    public fun finalize_fair_launch<T0, T1>(arg0: &mut FairLaunch<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::factory::Pools, arg3: &0x2::coin::CoinMetadata<T0>, arg4: &0x2::coin::CoinMetadata<T1>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (Locker<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>, 0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert!(arg0.curator == 0x2::tx_context::sender(arg6), 9);
        assert!(!arg0.is_finalized, 2);
        let v0 = 0x2::clock::timestamp_ms(arg5);
        let v1 = 0x2::balance::value<T1>(&arg0.balance_y);
        assert!(v1 > arg0.soft_cap && v0 > arg0.end_time, 8);
        arg0.is_finalized = true;
        let v2 = v1 * arg0.liquidity_percent / 10000;
        let v3 = v2 * arg0.total_tokens / v1;
        let v4 = 0x1::type_name::into_string(0x1::type_name::get<T1>());
        let v5 = 0x1::ascii::as_bytes(&v4);
        let v6 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        let v7 = 0x1::ascii::as_bytes(&v6);
        let v8 = 0;
        let v9 = false;
        while (v8 < 0x1::vector::length<u8>(v5)) {
            let v10 = *0x1::vector::borrow<u8>(v5, v8);
            let v11 = *0x1::vector::borrow<u8>(v7, v8);
            if (v11 < v10) {
                break
            };
            if (v11 > v10) {
                v9 = true;
                break
            };
            v8 = v8 + 1;
        };
        let (v12, v13, v14) = if (v9) {
            let v15 = sqrt(340282366920938463463374607431768211456 * (v2 as u256) / (v3 as u256));
            let (v16, v17, v18) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool_creator::create_pool_v2<T0, T1>(arg1, arg2, 60, v15, 0x1::string::utf8(b""), 4294523716, 443580, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance_x, v3), arg6), 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.balance_y, v2), arg6), arg3, arg4, true, arg5, arg6);
            let v19 = v16;
            let v20 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::pool_id(&v19);
            0x2::balance::join<T1>(&mut arg0.balance_y, 0x2::coin::into_balance<T1>(v18));
            0x2::balance::join<T0>(&mut arg0.balance_x, 0x2::coin::into_balance<T0>(v17));
            let v13 = lock<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(v19, v0 + arg0.lp_lock_period, arg6);
            (v15, v13, 0x2::object::id_to_address(&v20))
        } else {
            let v21 = sqrt(340282366920938463463374607431768211456 * (v3 as u256) / (v2 as u256));
            let (v22, v23, v24) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool_creator::create_pool_v2<T1, T0>(arg1, arg2, 60, v21, 0x1::string::utf8(b""), 4294523716, 443580, 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.balance_y, v2), arg6), 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance_x, v3), arg6), arg4, arg3, false, arg5, arg6);
            let v25 = v22;
            let v26 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::pool_id(&v25);
            0x2::balance::join<T1>(&mut arg0.balance_y, 0x2::coin::into_balance<T1>(v23));
            0x2::balance::join<T0>(&mut arg0.balance_x, 0x2::coin::into_balance<T0>(v24));
            let v13 = lock<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(v25, v0 + arg0.lp_lock_period, arg6);
            (v21, v13, 0x2::object::id_to_address(&v26))
        };
        let v27 = FairLaunchFinalized<T0, T1>{
            market_address     : 0x2::object::id_address<FairLaunch<T0, T1>>(arg0),
            finalize_time      : v0,
            lp_unlock_time     : v0 + arg0.lp_lock_period,
            cetus_pool_address : v14,
            initialize_price   : v12,
        };
        0x2::event::emit<FairLaunchFinalized<T0, T1>>(v27);
        (v13, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance_x, 0x2::balance::value<T0>(&arg0.balance_x) - arg0.total_claimable_x), arg6), 0x2::coin::from_balance<T1>(0x2::balance::withdraw_all<T1>(&mut arg0.balance_y), arg6))
    }

    fun lock<T0>(arg0: T0, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : Locker<T0> {
        Locker<T0>{
            id        : 0x2::object::new(arg2),
            item      : arg0,
            unlock_at : arg1,
        }
    }

    public fun refund<T0, T1>(arg0: &mut FairLaunch<T0, T1>, arg1: Proof<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(!arg0.is_finalized, 2);
        assert!(0x2::clock::timestamp_ms(arg2) > arg0.end_time, 4);
        assert!(arg0.contributed < arg0.soft_cap, 6);
        assert!(0x2::object::uid_to_bytes(&arg0.id) == 0x2::object::id_to_bytes(&arg1.market_id), 7);
        let Proof {
            id            : v0,
            market_id     : _,
            contributed_y : v2,
        } = arg1;
        let v3 = v0;
        0x2::object::delete(v3);
        let v4 = FairLaunchRefunded<T0, T1>{
            market_address : 0x2::object::uid_to_address(&arg0.id),
            proof_address  : 0x2::object::uid_to_address(&v3),
            contributed_y  : v2,
            recipient      : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<FairLaunchRefunded<T0, T1>>(v4);
        0x2::coin::take<T1>(&mut arg0.balance_y, arg1.contributed_y, arg3)
    }

    fun sqrt(arg0: u256) : u128 {
        assert!(arg0 > 0, 1);
        let v0 = (arg0 + 1) / 2;
        while (v0 < arg0) {
            let v1 = v0 + arg0 / v0;
            v0 = v1 / 2;
        };
        (arg0 as u128)
    }

    public fun unlock<T0>(arg0: Locker<T0>, arg1: &0x2::clock::Clock) : T0 {
        let Locker {
            id        : v0,
            item      : v1,
            unlock_at : v2,
        } = arg0;
        assert!(v2 <= 0x2::clock::timestamp_ms(arg1), 1);
        0x2::object::delete(v0);
        v1
    }

    public fun update_proof<T0, T1>(arg0: &mut FairLaunch<T0, T1>, arg1: &mut Proof<T0, T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.is_finalized, 2);
        assert!(0x2::object::uid_to_address(&arg1.id) == 0x2::tx_context::sender(arg3), 1);
        arg1.contributed_y = arg1.contributed_y + arg2;
        arg0.contributed = arg0.contributed + arg2;
    }

    fun validate_params(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64) {
        assert!(arg0 > 0, 1);
        assert!(arg1 > 0, 1);
        assert!(arg2 >= 5100, 10);
        assert!(arg2 <= 10000, 10);
        assert!(arg4 >= arg3, 1);
    }

    // decompiled from Move bytecode v6
}

