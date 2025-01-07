module 0xfe038ab8e564341ce0601926550d5cfd76573e1d94c4256324c6f5b6a7297b06::farming {
    struct FarmingData has store, key {
        id: 0x2::object::UID,
        admin: address,
        lp_to_pid: 0x2::table::Table<0x1::string::String, u64>,
        lps: vector<0x1::string::String>,
        pool_info: vector<PoolInfo>,
    }

    struct PoolUsers has store, key {
        id: 0x2::object::UID,
        total_users: u64,
    }

    struct PoolUserInfo has store, key {
        id: 0x2::object::UID,
        pids: vector<u64>,
    }

    struct UserInfo has store, key {
        id: 0x2::object::UID,
        amount: u128,
        reward_x_debt: u128,
        reward_y_debt: u128,
    }

    struct PoolInfo has store {
        total_amount: u128,
        acc_x_per_share: u128,
        acc_y_per_share: u128,
        x_per_second: u64,
        y_per_second: u64,
        last_reward_timestamp: u64,
        last_upkeep_timestamp: u64,
        end_timestamp: u64,
        x_type: 0x1::string::String,
        y_type: 0x1::string::String,
    }

    struct LPLocked has store, key {
        id: 0x2::object::UID,
    }

    struct LPLockedItem<phantom T0> has store, key {
        id: 0x2::object::UID,
        coin_lp: 0x2::balance::Balance<T0>,
    }

    struct Reward has store, key {
        id: 0x2::object::UID,
    }

    struct RewardItem<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        coin_x: 0x2::coin::Coin<T0>,
        coin_y: 0x2::coin::Coin<T1>,
    }

    struct DepositEvent has copy, drop, store {
        user: address,
        pid: u64,
        amount: u64,
    }

    struct WithdrawEvent has copy, drop, store {
        user: address,
        pid: u64,
        amount: u64,
    }

    struct EmergencyWithdrawEvent has copy, drop, store {
        user: address,
        pid: u64,
        amount: u128,
    }

    struct AddPoolEvent has copy, drop, store {
        pid: u64,
        lp: 0x1::string::String,
    }

    struct SetPoolEvent has copy, drop, store {
        pid: u64,
        prev_x_per_second: u64,
        prev_y_per_second: u64,
        x_per_second: u64,
        y_per_second: u64,
    }

    struct UpdatePoolEvent has copy, drop, store {
        pid: u64,
        last_reward_timestamp: u64,
        lp_supply: u128,
        acc_x_per_share: u128,
        acc_y_per_share: u128,
    }

    struct UpkeepEvent has copy, drop, store {
        amount: u64,
        elapsed: u64,
        prev_x_per_second: u64,
        prev_y_per_second: u64,
        x_per_second: u64,
        y_per_second: u64,
    }

    public fun is_null<T0>() : bool {
        0x1::type_name::into_string(0x1::type_name::get<T0>()) == 0x1::type_name::into_string(0x1::type_name::get<0xec0a13a9e571bff84c309976202c837a1f4ac8c78862ebe600562a5516988817::is_null::Null>())
    }

    public entry fun add_one_reward_for_pool<T0>(arg0: &mut FarmingData, arg1: &mut Reward, arg2: u64, arg3: u64, arg4: 0x2::coin::Coin<T0>, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg8) == arg0.admin, 0);
        assert!(arg3 == 0x2::coin::value<T0>(&arg4), 13);
        let v0 = 0x2::clock::timestamp_ms(arg7) / 1000;
        let v1 = 0x1::vector::borrow_mut<PoolInfo>(&mut arg0.pool_info, arg2);
        let v2 = if (v0 <= v1.end_timestamp) {
            v1.end_timestamp + arg6
        } else {
            v0 + arg6
        };
        if (0xfe038ab8e564341ce0601926550d5cfd76573e1d94c4256324c6f5b6a7297b06::utils::sort_token_type<T0, 0xec0a13a9e571bff84c309976202c837a1f4ac8c78862ebe600562a5516988817::is_null::Null>()) {
            if (!0x2::dynamic_object_field::exists_with_type<u64, RewardItem<T0, 0xec0a13a9e571bff84c309976202c837a1f4ac8c78862ebe600562a5516988817::is_null::Null>>(&mut arg1.id, arg2)) {
                let v3 = RewardItem<T0, 0xec0a13a9e571bff84c309976202c837a1f4ac8c78862ebe600562a5516988817::is_null::Null>{
                    id     : 0x2::object::new(arg8),
                    coin_x : 0x2::coin::zero<T0>(arg8),
                    coin_y : 0x2::coin::zero<0xec0a13a9e571bff84c309976202c837a1f4ac8c78862ebe600562a5516988817::is_null::Null>(arg8),
                };
                0x2::dynamic_object_field::add<u64, RewardItem<T0, 0xec0a13a9e571bff84c309976202c837a1f4ac8c78862ebe600562a5516988817::is_null::Null>>(&mut arg1.id, arg2, v3);
            };
            0x2::coin::join<T0>(&mut 0x2::dynamic_object_field::borrow_mut<u64, RewardItem<T0, 0xec0a13a9e571bff84c309976202c837a1f4ac8c78862ebe600562a5516988817::is_null::Null>>(&mut arg1.id, arg2).coin_x, arg4);
            v1.x_per_second = arg5;
            v1.y_per_second = 0;
            v1.x_type = 0xfe038ab8e564341ce0601926550d5cfd76573e1d94c4256324c6f5b6a7297b06::utils::get_token_name<T0>();
            v1.y_type = 0xfe038ab8e564341ce0601926550d5cfd76573e1d94c4256324c6f5b6a7297b06::utils::get_token_name<0xec0a13a9e571bff84c309976202c837a1f4ac8c78862ebe600562a5516988817::is_null::Null>();
        } else {
            if (!0x2::dynamic_object_field::exists_with_type<u64, RewardItem<0xec0a13a9e571bff84c309976202c837a1f4ac8c78862ebe600562a5516988817::is_null::Null, T0>>(&mut arg1.id, arg2)) {
                let v4 = RewardItem<0xec0a13a9e571bff84c309976202c837a1f4ac8c78862ebe600562a5516988817::is_null::Null, T0>{
                    id     : 0x2::object::new(arg8),
                    coin_x : 0x2::coin::zero<0xec0a13a9e571bff84c309976202c837a1f4ac8c78862ebe600562a5516988817::is_null::Null>(arg8),
                    coin_y : 0x2::coin::zero<T0>(arg8),
                };
                0x2::dynamic_object_field::add<u64, RewardItem<0xec0a13a9e571bff84c309976202c837a1f4ac8c78862ebe600562a5516988817::is_null::Null, T0>>(&mut arg1.id, arg2, v4);
            };
            0x2::coin::join<T0>(&mut 0x2::dynamic_object_field::borrow_mut<u64, RewardItem<0xec0a13a9e571bff84c309976202c837a1f4ac8c78862ebe600562a5516988817::is_null::Null, T0>>(&mut arg1.id, arg2).coin_y, arg4);
            v1.x_per_second = 0;
            v1.y_per_second = arg5;
            v1.x_type = 0xfe038ab8e564341ce0601926550d5cfd76573e1d94c4256324c6f5b6a7297b06::utils::get_token_name<0xec0a13a9e571bff84c309976202c837a1f4ac8c78862ebe600562a5516988817::is_null::Null>();
            v1.y_type = 0xfe038ab8e564341ce0601926550d5cfd76573e1d94c4256324c6f5b6a7297b06::utils::get_token_name<T0>();
        };
        v1.last_upkeep_timestamp = v0;
        v1.end_timestamp = v2;
    }

    public entry fun add_pool<T0>(arg0: &mut FarmingData, arg1: &mut LPLocked, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xfe038ab8e564341ce0601926550d5cfd76573e1d94c4256324c6f5b6a7297b06::utils::get_token_name<T0>();
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 0);
        assert!(!0x2::table::contains<0x1::string::String, u64>(&arg0.lp_to_pid, v0), 3);
        let v1 = 0x2::clock::timestamp_ms(arg2) / 1000;
        let v2 = 0x2::table::length<0x1::string::String, u64>(&arg0.lp_to_pid);
        0x2::table::add<0x1::string::String, u64>(&mut arg0.lp_to_pid, v0, v2);
        0x1::vector::push_back<0x1::string::String>(&mut arg0.lps, v0);
        let v3 = PoolInfo{
            total_amount          : 0,
            acc_x_per_share       : 0,
            acc_y_per_share       : 0,
            x_per_second          : 0,
            y_per_second          : 0,
            last_reward_timestamp : 0x2::clock::timestamp_ms(arg2) / 1000,
            last_upkeep_timestamp : v1,
            end_timestamp         : v1,
            x_type                : 0x1::string::utf8(b""),
            y_type                : 0x1::string::utf8(b""),
        };
        0x1::vector::push_back<PoolInfo>(&mut arg0.pool_info, v3);
        let v4 = LPLockedItem<T0>{
            id      : 0x2::object::new(arg3),
            coin_lp : 0x2::balance::zero<T0>(),
        };
        0x2::dynamic_object_field::add<0x1::string::String, LPLockedItem<T0>>(&mut arg1.id, v0, v4);
        let v5 = AddPoolEvent{
            pid : v2,
            lp  : v0,
        };
        0x2::event::emit<AddPoolEvent>(v5);
    }

    public entry fun add_two_reward_for_pool<T0, T1>(arg0: &mut FarmingData, arg1: &mut Reward, arg2: u64, arg3: u64, arg4: 0x2::coin::Coin<T0>, arg5: u64, arg6: u64, arg7: 0x2::coin::Coin<T1>, arg8: u64, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg11) == arg0.admin, 0);
        assert!(arg3 == 0x2::coin::value<T0>(&arg4), 13);
        assert!(arg6 == 0x2::coin::value<T1>(&arg7), 13);
        let v0 = 0x2::clock::timestamp_ms(arg10) / 1000;
        let v1 = 0x1::vector::borrow_mut<PoolInfo>(&mut arg0.pool_info, arg2);
        let v2 = if (v0 <= v1.end_timestamp) {
            v1.end_timestamp + arg9
        } else {
            v0 + arg9
        };
        if (0xfe038ab8e564341ce0601926550d5cfd76573e1d94c4256324c6f5b6a7297b06::utils::sort_token_type<T0, T1>()) {
            if (!0x2::dynamic_object_field::exists_with_type<u64, RewardItem<T0, T1>>(&mut arg1.id, arg2)) {
                let v3 = RewardItem<T0, T1>{
                    id     : 0x2::object::new(arg11),
                    coin_x : 0x2::coin::zero<T0>(arg11),
                    coin_y : 0x2::coin::zero<T1>(arg11),
                };
                0x2::dynamic_object_field::add<u64, RewardItem<T0, T1>>(&mut arg1.id, arg2, v3);
            };
            let v4 = 0x2::dynamic_object_field::borrow_mut<u64, RewardItem<T0, T1>>(&mut arg1.id, arg2);
            0x2::coin::join<T0>(&mut v4.coin_x, arg4);
            0x2::coin::join<T1>(&mut v4.coin_y, arg7);
            v1.x_per_second = arg5;
            v1.y_per_second = arg8;
            v1.x_type = 0xfe038ab8e564341ce0601926550d5cfd76573e1d94c4256324c6f5b6a7297b06::utils::get_token_name<T0>();
            v1.y_type = 0xfe038ab8e564341ce0601926550d5cfd76573e1d94c4256324c6f5b6a7297b06::utils::get_token_name<T1>();
        } else {
            if (!0x2::dynamic_object_field::exists_with_type<u64, RewardItem<T1, T0>>(&mut arg1.id, arg2)) {
                let v5 = RewardItem<T1, T0>{
                    id     : 0x2::object::new(arg11),
                    coin_x : 0x2::coin::zero<T1>(arg11),
                    coin_y : 0x2::coin::zero<T0>(arg11),
                };
                0x2::dynamic_object_field::add<u64, RewardItem<T1, T0>>(&mut arg1.id, arg2, v5);
            };
            let v6 = 0x2::dynamic_object_field::borrow_mut<u64, RewardItem<T1, T0>>(&mut arg1.id, arg2);
            0x2::coin::join<T1>(&mut v6.coin_x, arg7);
            0x2::coin::join<T0>(&mut v6.coin_y, arg4);
            v1.x_per_second = arg8;
            v1.y_per_second = arg5;
            v1.x_type = 0xfe038ab8e564341ce0601926550d5cfd76573e1d94c4256324c6f5b6a7297b06::utils::get_token_name<T1>();
            v1.y_type = 0xfe038ab8e564341ce0601926550d5cfd76573e1d94c4256324c6f5b6a7297b06::utils::get_token_name<T0>();
        };
        v1.last_upkeep_timestamp = v0;
        v1.end_timestamp = v2;
    }

    fun calc_reward(arg0: &mut FarmingData, arg1: &0x2::clock::Clock, arg2: u64) : (u64, u64, u128, u128) {
        let v0 = 0x1::vector::borrow_mut<PoolInfo>(&mut arg0.pool_info, arg2);
        let v1 = 0;
        let v2 = 0;
        let v3 = v0.acc_x_per_share;
        let v4 = v0.acc_y_per_share;
        let v5 = 0x2::clock::timestamp_ms(arg1) / 1000;
        if (v5 > v0.last_reward_timestamp) {
            let v6 = v0.total_amount;
            let v7 = if (v0.end_timestamp <= v0.last_reward_timestamp) {
                0
            } else if (v5 <= v0.end_timestamp) {
                v5 - 0x2::math::max(v0.last_reward_timestamp, v0.last_upkeep_timestamp)
            } else {
                v0.end_timestamp - 0x2::math::max(v0.last_reward_timestamp, v0.last_upkeep_timestamp)
            };
            if (v6 > 0) {
                let v8 = (v7 as u128) * (v0.x_per_second as u128);
                v1 = v8;
                let v9 = (v7 as u128) * (v0.y_per_second as u128);
                v2 = v9;
                let v10 = v0.acc_x_per_share + v8 * 1000000000000 / v6;
                v3 = v10;
                v4 = v0.acc_y_per_share + v9 * 1000000000000 / v6;
                assert!(v8 <= 18446744073709551615 && v10 <= 340282366920938463463374607431768211455, 8);
            };
        };
        ((v1 as u64), (v2 as u64), v3, v4)
    }

    public entry fun deposit<T0, T1, T2>(arg0: &mut FarmingData, arg1: &mut PoolUsers, arg2: &mut LPLocked, arg3: &mut Reward, arg4: u64, arg5: 0x2::coin::Coin<T0>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg7);
        let v1 = 0xfe038ab8e564341ce0601926550d5cfd76573e1d94c4256324c6f5b6a7297b06::utils::get_token_name<T0>();
        assert!(arg4 == 0x2::coin::value<T0>(&arg5), 13);
        assert!(0x2::table::contains<0x1::string::String, u64>(&arg0.lp_to_pid, v1), 2);
        let v2 = *0x2::table::borrow<0x1::string::String, u64>(&arg0.lp_to_pid, v1);
        update_pool(arg0, v2, arg6, arg7);
        if (!0x2::dynamic_object_field::exists_with_type<address, PoolUserInfo>(&mut arg1.id, v0)) {
            let v3 = PoolUserInfo{
                id   : 0x2::object::new(arg7),
                pids : 0x1::vector::empty<u64>(),
            };
            0x2::dynamic_object_field::add<address, PoolUserInfo>(&mut arg1.id, v0, v3);
            arg1.total_users = arg1.total_users + 1;
        };
        let v4 = 0x2::dynamic_object_field::borrow_mut<address, PoolUserInfo>(&mut arg1.id, v0);
        if (!0x2::dynamic_object_field::exists_with_type<u64, UserInfo>(&v4.id, v2)) {
            let v5 = UserInfo{
                id            : 0x2::object::new(arg7),
                amount        : 0,
                reward_x_debt : 0,
                reward_y_debt : 0,
            };
            0x2::dynamic_object_field::add<u64, UserInfo>(&mut v4.id, v2, v5);
            0x1::vector::push_back<u64>(&mut v4.pids, v2);
        };
        let v6 = 0x2::dynamic_object_field::borrow_mut<u64, UserInfo>(&mut v4.id, v2);
        let v7 = 0x1::vector::borrow_mut<PoolInfo>(&mut arg0.pool_info, v2);
        if (v6.amount > 0) {
            if (0xfe038ab8e564341ce0601926550d5cfd76573e1d94c4256324c6f5b6a7297b06::utils::sort_token_type<T1, T2>()) {
                distributed_reward<T1, T2>(arg3, v2, ((v6.amount * v7.acc_x_per_share / 1000000000000 - v6.reward_x_debt) as u64), ((v6.amount * v7.acc_y_per_share / 1000000000000 - v6.reward_y_debt) as u64), v0, arg7);
            } else {
                distributed_reward<T2, T1>(arg3, v2, ((v6.amount * v7.acc_x_per_share / 1000000000000 - v6.reward_x_debt) as u64), ((v6.amount * v7.acc_y_per_share / 1000000000000 - v6.reward_y_debt) as u64), v0, arg7);
            };
        };
        if (arg4 == 0) {
            0x2::coin::destroy_zero<T0>(arg5);
        } else {
            0x2::balance::join<T0>(&mut 0x2::dynamic_object_field::borrow_mut<0x1::string::String, LPLockedItem<T0>>(&mut arg2.id, v1).coin_lp, 0x2::coin::into_balance<T0>(arg5));
            v6.amount = v6.amount + (arg4 as u128);
            v7.total_amount = v7.total_amount + (arg4 as u128);
        };
        v6.reward_x_debt = v6.amount * v7.acc_x_per_share / 1000000000000;
        v6.reward_y_debt = v6.amount * v7.acc_y_per_share / 1000000000000;
        let v8 = DepositEvent{
            user   : v0,
            pid    : v2,
            amount : arg4,
        };
        0x2::event::emit<DepositEvent>(v8);
    }

    fun distributed_reward<T0, T1>(arg0: &mut Reward, arg1: u64, arg2: u64, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::dynamic_object_field::borrow_mut<u64, RewardItem<T0, T1>>(&mut arg0.id, arg1);
        if (is_null<T0>() && !is_null<T1>()) {
            if (arg3 > 0) {
                let v1 = 0x2::coin::value<T1>(&v0.coin_y);
                if (v1 < arg3) {
                    arg3 = v1;
                };
                0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::split<T1>(&mut v0.coin_y, arg3, arg5), arg4);
            };
        } else if (is_null<T1>() && !is_null<T0>()) {
            if (arg2 > 0) {
                let v2 = 0x2::coin::value<T0>(&v0.coin_x);
                if (v2 < arg2) {
                    arg2 = v2;
                };
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v0.coin_x, arg2, arg5), arg4);
            };
        } else {
            let v3 = 0x2::coin::value<T0>(&v0.coin_x);
            if (v3 < arg2) {
                arg2 = v3;
            };
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v0.coin_x, arg2, arg5), arg4);
            let v4 = 0x2::coin::value<T1>(&v0.coin_y);
            if (v4 < arg3) {
                arg3 = v4;
            };
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::split<T1>(&mut v0.coin_y, arg3, arg5), arg4);
        };
    }

    public entry fun emergency_withdraw<T0>(arg0: &mut FarmingData, arg1: &mut PoolUsers, arg2: &mut LPLocked, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xfe038ab8e564341ce0601926550d5cfd76573e1d94c4256324c6f5b6a7297b06::utils::get_token_name<T0>();
        assert!(0x2::table::contains<0x1::string::String, u64>(&arg0.lp_to_pid, v0), 2);
        let v1 = 0x2::tx_context::sender(arg3);
        let v2 = *0x2::table::borrow<0x1::string::String, u64>(&arg0.lp_to_pid, v0);
        let v3 = 0x2::dynamic_object_field::borrow_mut<u64, UserInfo>(&mut 0x2::dynamic_object_field::borrow_mut<address, PoolUserInfo>(&mut arg1.id, v1).id, v2);
        assert!(v3.amount > 0, 4);
        let v4 = v3.amount;
        let v5 = 0x1::vector::borrow_mut<PoolInfo>(&mut arg0.pool_info, v2);
        v3.amount = 0;
        v3.reward_x_debt = 0;
        v3.reward_y_debt = 0;
        v5.total_amount = v5.total_amount - v4;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut 0x2::dynamic_object_field::borrow_mut<0x1::string::String, LPLockedItem<T0>>(&mut arg2.id, v0).coin_lp, (v4 as u64)), arg3), v1);
        let v6 = EmergencyWithdrawEvent{
            user   : v1,
            pid    : v2,
            amount : v4,
        };
        0x2::event::emit<EmergencyWithdrawEvent>(v6);
    }

    public entry fun emergency_withdraw_reward<T0, T1>(arg0: &mut Reward, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == @0x49cc391ab4d3503e03dbb24c4f9e28f3cdd2ddf8a459e0d43012c3868ffefa1, 0);
        if (0xfe038ab8e564341ce0601926550d5cfd76573e1d94c4256324c6f5b6a7297b06::utils::sort_token_type<T0, T1>()) {
            let v0 = 0x2::dynamic_object_field::borrow_mut<u64, RewardItem<T0, T1>>(&mut arg0.id, arg1);
            let v1 = 0x2::coin::value<T0>(&v0.coin_x);
            if (v1 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v0.coin_x, v1, arg2), @0x49cc391ab4d3503e03dbb24c4f9e28f3cdd2ddf8a459e0d43012c3868ffefa1);
            };
            let v2 = 0x2::coin::value<T1>(&v0.coin_y);
            if (v2 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::split<T1>(&mut v0.coin_y, v2, arg2), @0x49cc391ab4d3503e03dbb24c4f9e28f3cdd2ddf8a459e0d43012c3868ffefa1);
            };
        } else {
            let v3 = 0x2::dynamic_object_field::borrow_mut<u64, RewardItem<T1, T0>>(&mut arg0.id, arg1);
            let v4 = 0x2::coin::value<T0>(&v3.coin_y);
            if (v4 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v3.coin_y, v4, arg2), @0x49cc391ab4d3503e03dbb24c4f9e28f3cdd2ddf8a459e0d43012c3868ffefa1);
            };
            let v5 = 0x2::coin::value<T1>(&v3.coin_x);
            if (v5 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::split<T1>(&mut v3.coin_x, v5, arg2), @0x49cc391ab4d3503e03dbb24c4f9e28f3cdd2ddf8a459e0d43012c3868ffefa1);
            };
        };
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = FarmingData{
            id        : 0x2::object::new(arg0),
            admin     : @0x49cc391ab4d3503e03dbb24c4f9e28f3cdd2ddf8a459e0d43012c3868ffefa1,
            lp_to_pid : 0x2::table::new<0x1::string::String, u64>(arg0),
            lps       : 0x1::vector::empty<0x1::string::String>(),
            pool_info : 0x1::vector::empty<PoolInfo>(),
        };
        0x2::transfer::public_share_object<FarmingData>(v0);
        let v1 = PoolUsers{
            id          : 0x2::object::new(arg0),
            total_users : 0,
        };
        0x2::transfer::public_share_object<PoolUsers>(v1);
        let v2 = LPLocked{id: 0x2::object::new(arg0)};
        0x2::transfer::public_share_object<LPLocked>(v2);
        let v3 = Reward{id: 0x2::object::new(arg0)};
        0x2::transfer::public_share_object<Reward>(v3);
    }

    public fun pending_move(arg0: &mut FarmingData, arg1: &mut PoolUsers, arg2: &0x2::clock::Clock, arg3: u64, arg4: address) : (u64, u64) {
        let (_, _, v2, v3) = calc_reward(arg0, arg2, arg3);
        assert!(0x2::dynamic_object_field::exists_with_type<address, PoolUserInfo>(&mut arg1.id, arg4), 10);
        let v4 = 0x2::dynamic_object_field::borrow_mut<u64, UserInfo>(&mut 0x2::dynamic_object_field::borrow_mut<address, PoolUserInfo>(&mut arg1.id, arg4).id, arg3);
        (((v4.amount * v2 / 1000000000000 - v4.reward_x_debt) as u64), ((v4.amount * v3 / 1000000000000 - v4.reward_y_debt) as u64))
    }

    public fun pool_length(arg0: &mut FarmingData) : u64 {
        0x2::table::length<0x1::string::String, u64>(&arg0.lp_to_pid)
    }

    public entry fun set_admin(arg0: &mut FarmingData, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 != @0x0, 11);
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 0);
        arg0.admin = arg1;
    }

    public entry fun set_pool(arg0: &mut FarmingData, arg1: u64, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = pool_length(arg0);
        assert!(v0 > arg1, 6);
        assert!(0x2::tx_context::sender(arg5) == arg0.admin, 0);
        update_pool(arg0, arg1, arg4, arg5);
        let v1 = 0x1::vector::borrow_mut<PoolInfo>(&mut arg0.pool_info, arg1);
        v1.x_per_second = arg2;
        v1.y_per_second = arg3;
        let v2 = SetPoolEvent{
            pid               : arg1,
            prev_x_per_second : v1.x_per_second,
            prev_y_per_second : v1.y_per_second,
            x_per_second      : arg2,
            y_per_second      : arg3,
        };
        0x2::event::emit<SetPoolEvent>(v2);
    }

    public entry fun update_pool(arg0: &mut FarmingData, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3) = calc_reward(arg0, arg2, arg1);
        let v4 = 0x1::vector::borrow_mut<PoolInfo>(&mut arg0.pool_info, arg1);
        let v5 = 0x2::clock::timestamp_ms(arg2) / 1000;
        if (v0 > 0) {
            v4.acc_x_per_share = v2;
        };
        if (v1 > 0) {
            v4.acc_y_per_share = v3;
        };
        if (v5 > v4.last_reward_timestamp) {
            v4.last_reward_timestamp = v5;
            let v6 = UpdatePoolEvent{
                pid                   : arg1,
                last_reward_timestamp : v5,
                lp_supply             : v4.total_amount,
                acc_x_per_share       : v4.acc_x_per_share,
                acc_y_per_share       : v4.acc_y_per_share,
            };
            0x2::event::emit<UpdatePoolEvent>(v6);
        };
    }

    public entry fun withdraw<T0, T1, T2>(arg0: &mut FarmingData, arg1: &mut PoolUsers, arg2: &mut LPLocked, arg3: &mut Reward, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xfe038ab8e564341ce0601926550d5cfd76573e1d94c4256324c6f5b6a7297b06::utils::get_token_name<T0>();
        assert!(0x2::table::contains<0x1::string::String, u64>(&arg0.lp_to_pid, v0), 2);
        let v1 = 0x2::tx_context::sender(arg6);
        let v2 = *0x2::table::borrow<0x1::string::String, u64>(&arg0.lp_to_pid, v0);
        let v3 = 0x2::dynamic_object_field::borrow_mut<u64, UserInfo>(&mut 0x2::dynamic_object_field::borrow_mut<address, PoolUserInfo>(&mut arg1.id, v1).id, v2);
        assert!(v3.amount >= (arg4 as u128), 4);
        update_pool(arg0, v2, arg5, arg6);
        let v4 = 0x1::vector::borrow_mut<PoolInfo>(&mut arg0.pool_info, v2);
        let v5 = ((v3.amount * v4.acc_x_per_share / 1000000000000 - v3.reward_x_debt) as u64);
        let v6 = ((v3.amount * v4.acc_y_per_share / 1000000000000 - v3.reward_y_debt) as u64);
        assert!(v5 <= 18446744073709551615, 8);
        assert!(v6 <= 18446744073709551615, 8);
        if (0xfe038ab8e564341ce0601926550d5cfd76573e1d94c4256324c6f5b6a7297b06::utils::sort_token_type<T1, T2>()) {
            distributed_reward<T1, T2>(arg3, v2, v5, v6, v1, arg6);
        } else {
            distributed_reward<T2, T1>(arg3, v2, v5, v6, v1, arg6);
        };
        if (arg4 > 0) {
            v3.amount = v3.amount - (arg4 as u128);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut 0x2::dynamic_object_field::borrow_mut<0x1::string::String, LPLockedItem<T0>>(&mut arg2.id, v0).coin_lp, arg4), arg6), v1);
        };
        v3.reward_x_debt = v3.amount * v4.acc_x_per_share / 1000000000000;
        v3.reward_y_debt = v3.amount * v4.acc_y_per_share / 1000000000000;
        v4.total_amount = v4.total_amount - (arg4 as u128);
        let v7 = WithdrawEvent{
            user   : v1,
            pid    : v2,
            amount : arg4,
        };
        0x2::event::emit<WithdrawEvent>(v7);
    }

    // decompiled from Move bytecode v6
}

