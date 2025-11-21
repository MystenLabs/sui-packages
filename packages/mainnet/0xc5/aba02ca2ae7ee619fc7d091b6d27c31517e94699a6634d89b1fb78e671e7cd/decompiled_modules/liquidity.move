module 0xd9cac4a4d55c332f90a3f8eb3a5205f53ca7f9b74619592633cfc02a5ede939e::liquidity {
    struct FinanceLiquidity has store, key {
        id: 0x2::object::UID,
        stake_id: u64,
        hashrate_id: u64,
        stake_cycle: u64,
        stake_orders: 0x2::table::Table<u64, StakeOrder>,
        staked_sui: 0x2::balance::Balance<0x2::sui::SUI>,
        claim_hr_rate: u64,
        unstake_hr_rate: u64,
        release_rate: u64,
        release_rate_per_epoch: 0x2::table::Table<u64, u64>,
        schedule_period: u64,
        fee_schedule: vector<u64>,
        version: u64,
    }

    struct MMTPool<phantom T0> has store, key {
        id: 0x2::object::UID,
        position: 0x1::option::Option<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>,
        balance_usdc: 0x2::balance::Balance<T0>,
    }

    struct StakeOrder has store {
        id: u64,
        value: u64,
        sui_amount: u64,
        lock_time: u64,
        start_release_time: u64,
        period_duration: u64,
        received_period: u64,
        user: address,
        unstaked: bool,
    }

    struct NewStakeOrder has copy, drop {
        id: u64,
        value: u64,
        sui_amount: u64,
        start_release_time: u64,
        period_duration: u64,
        user: address,
    }

    struct ClaimReward has copy, drop {
        stake_id: u64,
        reward_value: u64,
        reward_value_fee: u64,
        hashrate_value: u64,
        claim_sui_amount: u64,
    }

    struct UnStake has copy, drop {
        stake_id: u64,
        stake_value: u64,
        stake_value_fee: u64,
        hashrate_value: u64,
        claim_sui_amount: u64,
    }

    struct NewHashrate has copy, drop {
        id: u64,
        amount: u64,
        user: address,
        typ: u8,
    }

    struct Release has copy, drop {
        id: u64,
        release_rate: u64,
    }

    public entry fun add_mmt_pool_liquidity<T0>(arg0: &0xd9cac4a4d55c332f90a3f8eb3a5205f53ca7f9b74619592633cfc02a5ede939e::finance::FinanceCap, arg1: &mut FinanceLiquidity, arg2: &mut MMTPool<T0>, arg3: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<0x2::sui::SUI, T0>, arg4: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg5: &0x2::clock::Clock, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::option::is_some<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(&arg2.position), 12);
        let v0 = 0x1::option::borrow_mut<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(&mut arg2.position);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg1.staked_sui) >= arg6, 13);
        let (v1, v2) = 0xd9cac4a4d55c332f90a3f8eb3a5205f53ca7f9b74619592633cfc02a5ede939e::mmt_lib::sell_and_add_liquidity<0x2::sui::SUI, T0>(v0, arg3, arg4, arg5, 0x2::balance::split<0x2::sui::SUI>(&mut arg1.staked_sui, arg6), arg6, arg7);
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.staked_sui, v1);
        0x2::balance::join<T0>(&mut arg2.balance_usdc, v2);
    }

    public entry fun add_mmt_pool_position<T0>(arg0: &0xd9cac4a4d55c332f90a3f8eb3a5205f53ca7f9b74619592633cfc02a5ede939e::finance::FinanceCap, arg1: &mut MMTPool<T0>, arg2: 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::option::is_none<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(&arg1.position), 11);
        0x1::option::fill<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(&mut arg1.position, arg2);
    }

    fun calculate_fee(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: &vector<u64>) : (u64, u64, u64) {
        let v0 = calculate_lock_period(arg0, arg1, arg2);
        let v1 = v0 / arg3;
        let v2 = 0x1::vector::length<u64>(arg4);
        let v3 = if (v2 == 0) {
            0
        } else if (v1 >= v2) {
            *0x1::vector::borrow<u64>(arg4, v2 - 1)
        } else {
            *0x1::vector::borrow<u64>(arg4, v1)
        };
        (v0, v1, v3)
    }

    fun calculate_lock_period(arg0: u64, arg1: u64, arg2: u64) : u64 {
        if (arg0 > arg2) {
            0
        } else {
            (arg2 - arg0) / arg1
        }
    }

    public fun calculate_release_time(arg0: u64, arg1: u64) : u64 {
        if (arg0 % 86400000 / 3600000 < 16) {
            arg0 / arg1 * arg1
        } else {
            arg0 / arg1 * arg1 + arg1
        }
    }

    fun check_version(arg0: &FinanceLiquidity) {
        assert!(arg0.version == 6, 1);
    }

    public entry fun claim<T0>(arg0: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<0x2::sui::SUI, T0>, arg1: &mut FinanceLiquidity, arg2: &mut 0xd9cac4a4d55c332f90a3f8eb3a5205f53ca7f9b74619592633cfc02a5ede939e::finance::EcoConfig, arg3: u8, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        check_version(arg1);
        0xd9cac4a4d55c332f90a3f8eb3a5205f53ca7f9b74619592633cfc02a5ede939e::finance::assert_user_is_not_black(arg2, 0x2::tx_context::sender(arg6), false);
        claim_internal<T0>(arg1, arg2, arg3, arg4, arg5, arg0, arg6, true);
    }

    fun claim_internal<T0>(arg0: &mut FinanceLiquidity, arg1: &mut 0xd9cac4a4d55c332f90a3f8eb3a5205f53ca7f9b74619592633cfc02a5ede939e::finance::EcoConfig, arg2: u8, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<0x2::sui::SUI, T0>, arg6: &mut 0x2::tx_context::TxContext, arg7: bool) : u64 {
        let v0 = 0x2::table::borrow_mut<u64, StakeOrder>(&mut arg0.stake_orders, arg3);
        assert!(!v0.unstaked, 4);
        let (v1, _, v3) = calculate_fee(v0.start_release_time, v0.period_duration, 0x2::clock::timestamp_ms(arg4), arg0.schedule_period, &arg0.fee_schedule);
        assert!(v1 >= v0.received_period, 5);
        let v4 = v1 - v0.received_period;
        if (arg7) {
            assert!(v4 > 0, 6);
        };
        if (v4 > 0) {
            let v5 = 0;
            let v6 = 1;
            while (v6 <= v4) {
                let v7 = v0.start_release_time + v0.period_duration * (v1 - v4 + v6);
                if (!0x2::table::contains<u64, u64>(&arg0.release_rate_per_epoch, v7)) {
                    break
                };
                v0.received_period = v0.received_period + 1;
                v5 = v5 + v0.value * *0x2::table::borrow<u64, u64>(&arg0.release_rate_per_epoch, v7) / 10000;
                v6 = v6 + 1;
            };
            assert!(v5 > 0, 10);
            let v8 = v5 * v3 / 10000;
            let v9 = (v5 - v8) * arg0.claim_hr_rate / 10000;
            let v10 = v5 - v8 - v9;
            let v11 = 0xd9cac4a4d55c332f90a3f8eb3a5205f53ca7f9b74619592633cfc02a5ede939e::suiprice::get_amount_out_v3<T0>(arg5, v10, false);
            if (arg2 == 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.staked_sui, v11), arg6), v0.user);
            } else {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.staked_sui, v11), arg6), 0xd9cac4a4d55c332f90a3f8eb3a5205f53ca7f9b74619592633cfc02a5ede939e::finance::eco_receipt(arg1));
                0xd9cac4a4d55c332f90a3f8eb3a5205f53ca7f9b74619592633cfc02a5ede939e::finance::new_eco_event(arg1, arg3, arg2, v11, v10, false);
            };
            let v12 = ClaimReward{
                stake_id         : v0.id,
                reward_value     : v5,
                reward_value_fee : v8,
                hashrate_value   : v9,
                claim_sui_amount : v11,
            };
            0x2::event::emit<ClaimReward>(v12);
            new_hashrate(arg0, v9, v0.user, 2);
        };
        v3
    }

    public entry fun close_mmt_pool_position<T0>(arg0: &0xd9cac4a4d55c332f90a3f8eb3a5205f53ca7f9b74619592633cfc02a5ede939e::finance::FinanceCap, arg1: &mut MMTPool<T0>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::option::is_some<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(&arg1.position), 12);
        0xd9cac4a4d55c332f90a3f8eb3a5205f53ca7f9b74619592633cfc02a5ede939e::mmt_lib::close_position(0x1::option::extract<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(&mut arg1.position), arg2, arg3);
    }

    public entry fun create_mmt_pool<T0>(arg0: &0xd9cac4a4d55c332f90a3f8eb3a5205f53ca7f9b74619592633cfc02a5ede939e::finance::FinanceCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = MMTPool<T0>{
            id           : 0x2::object::new(arg1),
            position     : 0x1::option::none<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(),
            balance_usdc : 0x2::balance::zero<T0>(),
        };
        0x2::transfer::public_share_object<MMTPool<T0>>(v0);
    }

    public entry fun create_mmt_pool_position<T0>(arg0: &0xd9cac4a4d55c332f90a3f8eb3a5205f53ca7f9b74619592633cfc02a5ede939e::finance::FinanceCap, arg1: &mut MMTPool<T0>, arg2: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<0x2::sui::SUI, T0>, arg3: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg4: u16, arg5: u16, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::option::is_none<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(&arg1.position), 11);
        0x1::option::fill<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(&mut arg1.position, 0xd9cac4a4d55c332f90a3f8eb3a5205f53ca7f9b74619592633cfc02a5ede939e::mmt_lib::open_position<0x2::sui::SUI, T0>(arg2, arg3, arg4, arg5, arg6));
    }

    public entry fun emergency_claim(arg0: &0xd9cac4a4d55c332f90a3f8eb3a5205f53ca7f9b74619592633cfc02a5ede939e::finance::FinanceCap, arg1: &mut FinanceLiquidity, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.staked_sui, 0x2::balance::value<0x2::sui::SUI>(&arg1.staked_sui)), arg3), arg2);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = FinanceLiquidity{
            id                     : 0x2::object::new(arg0),
            stake_id               : 0,
            hashrate_id            : 0,
            stake_cycle            : 86400000,
            stake_orders           : 0x2::table::new<u64, StakeOrder>(arg0),
            staked_sui             : 0x2::balance::zero<0x2::sui::SUI>(),
            claim_hr_rate          : 200,
            unstake_hr_rate        : 500,
            release_rate           : 100,
            release_rate_per_epoch : 0x2::table::new<u64, u64>(arg0),
            schedule_period        : 7,
            fee_schedule           : vector[500, 500, 500, 500, 400, 400, 400, 400, 300, 300, 300, 300, 200],
            version                : 6,
        };
        0x2::transfer::public_share_object<FinanceLiquidity>(v0);
    }

    public entry fun init_fee_schedule(arg0: &0xd9cac4a4d55c332f90a3f8eb3a5205f53ca7f9b74619592633cfc02a5ede939e::finance::FinanceCap, arg1: &mut FinanceLiquidity, arg2: vector<u64>) {
        check_version(arg1);
        let v0 = 0;
        while (v0 < 0x1::vector::length<u64>(&arg1.fee_schedule)) {
            0x1::vector::pop_back<u64>(&mut arg1.fee_schedule);
            v0 = v0 + 1;
        };
        v0 = 0;
        while (v0 < 0x1::vector::length<u64>(&arg2)) {
            0x1::vector::push_back<u64>(&mut arg1.fee_schedule, *0x1::vector::borrow<u64>(&arg2, v0));
            v0 = v0 + 1;
        };
    }

    public entry fun migrate(arg0: &0xd9cac4a4d55c332f90a3f8eb3a5205f53ca7f9b74619592633cfc02a5ede939e::finance::FinanceCap, arg1: &mut FinanceLiquidity) {
        assert!(arg1.version < 6, 2);
        arg1.version = 6;
    }

    public(friend) fun new_hashrate(arg0: &mut FinanceLiquidity, arg1: u64, arg2: address, arg3: u8) {
        if (arg1 == 0) {
            return
        };
        let v0 = arg0.hashrate_id + 1;
        arg0.hashrate_id = v0;
        let v1 = NewHashrate{
            id     : v0,
            amount : arg1,
            user   : arg2,
            typ    : arg3,
        };
        0x2::event::emit<NewHashrate>(v1);
    }

    public entry fun release(arg0: &0xd9cac4a4d55c332f90a3f8eb3a5205f53ca7f9b74619592633cfc02a5ede939e::finance::FinanceCap, arg1: &mut FinanceLiquidity, arg2: &0x2::clock::Clock) {
        check_version(arg1);
        let v0 = calculate_release_time(0x2::clock::timestamp_ms(arg2), arg1.stake_cycle);
        assert!(!0x2::table::contains<u64, u64>(&arg1.release_rate_per_epoch, v0), 8);
        0x2::table::add<u64, u64>(&mut arg1.release_rate_per_epoch, v0, arg1.release_rate);
        let v1 = Release{
            id           : v0,
            release_rate : arg1.release_rate,
        };
        0x2::event::emit<Release>(v1);
    }

    public entry fun release_special(arg0: &0xd9cac4a4d55c332f90a3f8eb3a5205f53ca7f9b74619592633cfc02a5ede939e::finance::FinanceCap, arg1: &mut FinanceLiquidity, arg2: u64, arg3: u64) {
        assert!(!0x2::table::contains<u64, u64>(&arg1.release_rate_per_epoch, arg2), 8);
        0x2::table::add<u64, u64>(&mut arg1.release_rate_per_epoch, arg2, arg3);
        let v0 = Release{
            id           : arg2,
            release_rate : arg3,
        };
        0x2::event::emit<Release>(v0);
    }

    public entry fun remove_mmt_pool_liquidity<T0>(arg0: &0xd9cac4a4d55c332f90a3f8eb3a5205f53ca7f9b74619592633cfc02a5ede939e::finance::FinanceCap, arg1: &mut FinanceLiquidity, arg2: &mut MMTPool<T0>, arg3: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<0x2::sui::SUI, T0>, arg4: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg5: &0x2::clock::Clock, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::option::is_some<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(&arg2.position), 12);
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.staked_sui, 0xd9cac4a4d55c332f90a3f8eb3a5205f53ca7f9b74619592633cfc02a5ede939e::mmt_lib::remove_liquidity_and_buy<0x2::sui::SUI, T0>(arg3, 0x1::option::borrow_mut<0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::Position>(&mut arg2.position), arg4, (arg6 as u128), 0x2::balance::split<T0>(&mut arg2.balance_usdc, 0x2::balance::value<T0>(&arg2.balance_usdc)), arg5, arg7));
    }

    public entry fun stake<T0>(arg0: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<0x2::sui::SUI, T0>, arg1: &0xd9cac4a4d55c332f90a3f8eb3a5205f53ca7f9b74619592633cfc02a5ede939e::finance::Finance, arg2: &mut FinanceLiquidity, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(0xd9cac4a4d55c332f90a3f8eb3a5205f53ca7f9b74619592633cfc02a5ede939e::finance::valid_user(arg1, v0), 3);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg3);
        let v2 = 0xd9cac4a4d55c332f90a3f8eb3a5205f53ca7f9b74619592633cfc02a5ede939e::suiprice::get_amount_out_v3<T0>(arg0, v1, true);
        let v3 = arg2.stake_id + 1;
        arg2.stake_id = v3;
        let v4 = 0x2::clock::timestamp_ms(arg4);
        let v5 = calculate_release_time(v4, arg2.stake_cycle);
        0x2::balance::join<0x2::sui::SUI>(&mut arg2.staked_sui, 0x2::coin::into_balance<0x2::sui::SUI>(arg3));
        let v6 = StakeOrder{
            id                 : v3,
            value              : v2,
            sui_amount         : v1,
            lock_time          : v4,
            start_release_time : v5,
            period_duration    : arg2.stake_cycle,
            received_period    : 0,
            user               : v0,
            unstaked           : false,
        };
        0x2::table::add<u64, StakeOrder>(&mut arg2.stake_orders, v3, v6);
        let v7 = NewStakeOrder{
            id                 : v3,
            value              : v2,
            sui_amount         : v1,
            start_release_time : v5,
            period_duration    : arg2.stake_cycle,
            user               : v0,
        };
        0x2::event::emit<NewStakeOrder>(v7);
    }

    public entry fun unstake<T0>(arg0: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<0x2::sui::SUI, T0>, arg1: &mut FinanceLiquidity, arg2: &mut 0xd9cac4a4d55c332f90a3f8eb3a5205f53ca7f9b74619592633cfc02a5ede939e::finance::EcoConfig, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        check_version(arg1);
        0xd9cac4a4d55c332f90a3f8eb3a5205f53ca7f9b74619592633cfc02a5ede939e::finance::assert_user_is_not_black(arg2, 0x2::tx_context::sender(arg5), false);
        assert!(unstakeable(arg1, arg3, 0x2::clock::timestamp_ms(arg4)), 7);
        let v0 = claim_internal<T0>(arg1, arg2, 0, arg3, arg4, arg0, arg5, false);
        let v1 = 0x2::table::borrow_mut<u64, StakeOrder>(&mut arg1.stake_orders, arg3);
        assert!(!v1.unstaked, 4);
        v1.unstaked = true;
        let v2 = v1.value;
        let v3 = v1.user;
        let v4 = v2 * v0 / 10000;
        let v5 = (v2 - v4) * arg1.unstake_hr_rate / 10000;
        let v6 = 0xd9cac4a4d55c332f90a3f8eb3a5205f53ca7f9b74619592633cfc02a5ede939e::suiprice::get_amount_out_v3<T0>(arg0, v2 - v4 - v5, false);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.staked_sui, v6), arg5), v3);
        let v7 = UnStake{
            stake_id         : arg3,
            stake_value      : v2,
            stake_value_fee  : v4,
            hashrate_value   : v5,
            claim_sui_amount : v6,
        };
        0x2::event::emit<UnStake>(v7);
        new_hashrate(arg1, v5, v3, 3);
    }

    public fun unstakeable(arg0: &FinanceLiquidity, arg1: u64, arg2: u64) : bool {
        let v0 = 0x2::table::borrow<u64, StakeOrder>(&arg0.stake_orders, arg1);
        if (v0.unstaked) {
            return false
        };
        let v1 = calculate_lock_period(v0.start_release_time, v0.period_duration, arg2);
        if (v1 / arg0.schedule_period == 0) {
            return false
        };
        if (v1 % arg0.schedule_period == 0 && arg2 < v0.start_release_time + v0.period_duration * v1 + v0.period_duration / 2) {
            return true
        };
        false
    }

    public entry fun update_claim_hr_rate(arg0: &0xd9cac4a4d55c332f90a3f8eb3a5205f53ca7f9b74619592633cfc02a5ede939e::finance::FinanceCap, arg1: &mut FinanceLiquidity, arg2: u64) {
        arg1.claim_hr_rate = arg2;
    }

    public entry fun update_release_rate(arg0: &0xd9cac4a4d55c332f90a3f8eb3a5205f53ca7f9b74619592633cfc02a5ede939e::finance::FinanceCap, arg1: &mut FinanceLiquidity, arg2: u64) {
        assert!(arg2 > 0, 9);
        arg1.release_rate = arg2;
    }

    public entry fun update_schedule_period(arg0: &0xd9cac4a4d55c332f90a3f8eb3a5205f53ca7f9b74619592633cfc02a5ede939e::finance::FinanceCap, arg1: &mut FinanceLiquidity, arg2: u64) {
        assert!(arg2 > 0, 14);
        arg1.schedule_period = arg2;
    }

    public entry fun update_unstake_hr_rate(arg0: &0xd9cac4a4d55c332f90a3f8eb3a5205f53ca7f9b74619592633cfc02a5ede939e::finance::FinanceCap, arg1: &mut FinanceLiquidity, arg2: u64) {
        arg1.unstake_hr_rate = arg2;
    }

    // decompiled from Move bytecode v6
}

