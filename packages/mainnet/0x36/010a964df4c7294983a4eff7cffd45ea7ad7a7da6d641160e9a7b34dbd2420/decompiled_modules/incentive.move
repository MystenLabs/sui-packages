module 0x934507d7be26c3999d3a8ce84c41c0b15eab07233ab3e8920c51c769ace94e17::incentive {
    struct OwnerCap has store, key {
        id: 0x2::object::UID,
    }

    struct Incentive has store, key {
        id: 0x2::object::UID,
        pool_objs: vector<address>,
        inactive_objs: vector<address>,
        pools: 0x2::table::Table<address, IncentivePool>,
    }

    struct IncentivePool has store, key {
        id: 0x2::object::UID,
        phase: u64,
        funds: address,
        start_at: u64,
        end_at: u64,
        closed_at: u64,
        total_supply: u64,
        option: u8,
        asset_id: u8,
        factor: u256,
        last_update_at: u64,
        distributed: u64,
        index_reward: u256,
        rewards_paid: 0x2::table::Table<address, u256>,
        total_rewards_of_users: 0x2::table::Table<address, u256>,
        total_claimed_of_users: 0x2::table::Table<address, u256>,
    }

    struct IncentiveFundsPool<phantom T0> has store, key {
        id: 0x2::object::UID,
        oracle_id: u8,
        balance: 0x2::balance::Balance<T0>,
        coin_type: 0x1::type_name::TypeName,
    }

    struct CreateFundsPool has copy, drop {
        sender: address,
        coin_type: 0x1::type_name::TypeName,
        oracle_id: u8,
        force: bool,
    }

    struct IncreasedFunds has copy, drop {
        sender: address,
        balance_before: u64,
        balance_after: u64,
    }

    struct WithdrawFunds has copy, drop {
        sender: address,
        value: u64,
    }

    struct CreateIncentive has copy, drop {
        sender: address,
        incentive_pool_pro: address,
    }

    struct CreateIncentivePool has copy, drop {
        sender: address,
        pool: address,
    }

    struct RewardsClaimed has copy, drop {
        sender: address,
        pool: address,
        amount: u64,
    }

    public fun borrow<T0>(arg0: &0x2::clock::Clock, arg1: &0x859de5e155d57462d3fe0aeb980b9a3f9cdccf76522d9499f372789183440aca::oracle::PriceOracle, arg2: &mut 0x65d3b958fe52dad6ef61fbce9368877312a319957eab3d6946796079af862030::storage::Storage, arg3: &mut 0x65d3b958fe52dad6ef61fbce9368877312a319957eab3d6946796079af862030::pool::Pool<T0>, arg4: u8, arg5: u64, arg6: &mut Incentive, arg7: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        update_reward(arg0, arg6, arg2, arg4, 3, 0x2::tx_context::sender(arg7));
        0x65d3b958fe52dad6ef61fbce9368877312a319957eab3d6946796079af862030::lending::borrow_coin<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg7)
    }

    public fun add_funds<T0>(arg0: &OwnerCap, arg1: &mut IncentiveFundsPool<T0>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = IncreasedFunds{
            sender         : 0x2::tx_context::sender(arg4),
            balance_before : 0x2::balance::value<T0>(&arg1.balance),
            balance_after  : 0x2::balance::join<T0>(&mut arg1.balance, 0x934507d7be26c3999d3a8ce84c41c0b15eab07233ab3e8920c51c769ace94e17::utils::split_coin_to_balance<T0>(arg2, arg3, arg4)),
        };
        0x2::event::emit<IncreasedFunds>(v0);
    }

    public fun calculate_release_rate(arg0: &IncentivePool) : u64 {
        arg0.total_supply / (arg0.end_at - arg0.start_at)
    }

    public fun calculate_user_effective_amount(arg0: u8, arg1: u256, arg2: u256, arg3: u256) : u256 {
        if (arg0 == 3) {
            let v0 = arg1 ^ arg2;
            let v1 = v0 ^ arg2;
            arg2 = v1;
            arg1 = v0 ^ v1;
        };
        let v2 = 0x934507d7be26c3999d3a8ce84c41c0b15eab07233ab3e8920c51c769ace94e17::ray_math::ray_mul(arg3, arg2);
        if (arg1 > v2) {
            return arg1 - v2
        };
        0
    }

    public entry fun claim_reward<T0>(arg0: &0x2::clock::Clock, arg1: &mut Incentive, arg2: &mut IncentiveFundsPool<T0>, arg3: &mut 0x65d3b958fe52dad6ef61fbce9368877312a319957eab3d6946796079af862030::storage::Storage, arg4: u8, arg5: u8, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        update_reward(arg0, arg1, arg3, arg4, arg5, v0);
        let v1 = get_pool_obj_from_funds_pool<T0>(arg1, arg2, arg4, arg5);
        let v2 = 0x1::vector::length<address>(&v1);
        let v3 = 0;
        while (v2 > 0) {
            v2 = v2 - 1;
            let v4 = *0x1::vector::borrow<address>(&v1, v2 - 1);
            let v5 = 0x2::table::borrow_mut<address, IncentivePool>(&mut arg1.pools, v4);
            if (v5.closed_at > 0 && 0x2::clock::timestamp_ms(arg0) > v5.closed_at) {
                continue
            };
            let v6 = 0;
            if (0x2::table::contains<address, u256>(&v5.total_rewards_of_users, v0)) {
                v6 = *0x2::table::borrow<address, u256>(&v5.total_rewards_of_users, v0);
            };
            let v7 = 0;
            if (0x2::table::contains<address, u256>(&v5.total_claimed_of_users, v0)) {
                v7 = 0x2::table::remove<address, u256>(&mut v5.total_claimed_of_users, v0);
            };
            0x2::table::add<address, u256>(&mut v5.total_claimed_of_users, v0, v6);
            let v8 = (((v6 - v7) / 0x934507d7be26c3999d3a8ce84c41c0b15eab07233ab3e8920c51c769ace94e17::ray_math::ray()) as u64);
            let v9 = v8;
            if (v5.distributed + v8 > v5.total_supply) {
                v9 = v5.total_supply - v5.distributed;
            };
            if (v9 > 0) {
                v3 = v3 + v9;
                v5.distributed = v5.distributed + v9;
                let v10 = RewardsClaimed{
                    sender : v0,
                    pool   : v4,
                    amount : v9,
                };
                0x2::event::emit<RewardsClaimed>(v10);
                continue
            };
        };
        if (v3 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(decrease_balance<T0>(arg2, v3), arg6), v0);
        };
    }

    public fun create_funds_pool<T0>(arg0: &OwnerCap, arg1: u8, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = IncentiveFundsPool<T0>{
            id        : 0x2::object::new(arg3),
            oracle_id : arg1,
            balance   : 0x2::balance::zero<T0>(),
            coin_type : 0x1::type_name::get<T0>(),
        };
        0x2::transfer::share_object<IncentiveFundsPool<T0>>(v0);
        let v1 = CreateFundsPool{
            sender    : 0x2::tx_context::sender(arg3),
            coin_type : 0x1::type_name::get<T0>(),
            oracle_id : arg1,
            force     : arg2,
        };
        0x2::event::emit<CreateFundsPool>(v1);
    }

    public fun create_incentive(arg0: &OwnerCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg1);
        let v1 = Incentive{
            id            : v0,
            pool_objs     : 0x1::vector::empty<address>(),
            inactive_objs : 0x1::vector::empty<address>(),
            pools         : 0x2::table::new<address, IncentivePool>(arg1),
        };
        0x2::transfer::share_object<Incentive>(v1);
        let v2 = CreateIncentive{
            sender             : 0x2::tx_context::sender(arg1),
            incentive_pool_pro : 0x2::object::uid_to_address(&v0),
        };
        0x2::event::emit<CreateIncentive>(v2);
    }

    public fun create_incentive_pool<T0>(arg0: &OwnerCap, arg1: &0x2::clock::Clock, arg2: &mut Incentive, arg3: &IncentiveFundsPool<T0>, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u8, arg10: u8, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(arg5 < arg6, 8001);
        assert!(arg7 == 0 || arg7 > arg6, 8001);
        let v0 = 0x2::object::new(arg11);
        let v1 = 0x2::object::uid_to_address(&v0);
        let v2 = IncentivePool{
            id                     : v0,
            phase                  : arg4,
            funds                  : 0x2::object::uid_to_address(&arg3.id),
            start_at               : arg5,
            end_at                 : arg6,
            closed_at              : arg7,
            total_supply           : arg8,
            option                 : arg9,
            asset_id               : arg10,
            factor                 : 0,
            last_update_at         : 0x2::clock::timestamp_ms(arg1),
            distributed            : 0,
            index_reward           : 0,
            rewards_paid           : 0x2::table::new<address, u256>(arg11),
            total_rewards_of_users : 0x2::table::new<address, u256>(arg11),
            total_claimed_of_users : 0x2::table::new<address, u256>(arg11),
        };
        0x2::table::add<address, IncentivePool>(&mut arg2.pools, v1, v2);
        0x1::vector::push_back<address>(&mut arg2.pool_objs, v1);
        let v3 = CreateIncentivePool{
            sender : 0x2::tx_context::sender(arg11),
            pool   : v1,
        };
        0x2::event::emit<CreateIncentivePool>(v3);
    }

    fun decrease_balance<T0>(arg0: &mut IncentiveFundsPool<T0>, arg1: u64) : 0x2::balance::Balance<T0> {
        0x2::balance::split<T0>(&mut arg0.balance, arg1)
    }

    public entry fun entry_borrow<T0>(arg0: &0x2::clock::Clock, arg1: &0x859de5e155d57462d3fe0aeb980b9a3f9cdccf76522d9499f372789183440aca::oracle::PriceOracle, arg2: &mut 0x65d3b958fe52dad6ef61fbce9368877312a319957eab3d6946796079af862030::storage::Storage, arg3: &mut 0x65d3b958fe52dad6ef61fbce9368877312a319957eab3d6946796079af862030::pool::Pool<T0>, arg4: u8, arg5: u64, arg6: &mut Incentive, arg7: &mut 0x2::tx_context::TxContext) {
        update_reward(arg0, arg6, arg2, arg4, 3, 0x2::tx_context::sender(arg7));
        0x65d3b958fe52dad6ef61fbce9368877312a319957eab3d6946796079af862030::lending::entry_borrow_coin<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg7);
    }

    public entry fun entry_deposit<T0>(arg0: &0x2::clock::Clock, arg1: &mut 0x65d3b958fe52dad6ef61fbce9368877312a319957eab3d6946796079af862030::storage::Storage, arg2: &mut 0x65d3b958fe52dad6ef61fbce9368877312a319957eab3d6946796079af862030::pool::Pool<T0>, arg3: u8, arg4: 0x2::coin::Coin<T0>, arg5: u64, arg6: &mut Incentive, arg7: &mut 0x2::tx_context::TxContext) {
        update_reward(arg0, arg6, arg1, arg3, 1, 0x2::tx_context::sender(arg7));
        0x65d3b958fe52dad6ef61fbce9368877312a319957eab3d6946796079af862030::lending::entry_deposit_coin<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg7);
    }

    public entry fun entry_repay<T0>(arg0: &0x2::clock::Clock, arg1: &0x859de5e155d57462d3fe0aeb980b9a3f9cdccf76522d9499f372789183440aca::oracle::PriceOracle, arg2: &mut 0x65d3b958fe52dad6ef61fbce9368877312a319957eab3d6946796079af862030::storage::Storage, arg3: &mut 0x65d3b958fe52dad6ef61fbce9368877312a319957eab3d6946796079af862030::pool::Pool<T0>, arg4: u8, arg5: 0x2::coin::Coin<T0>, arg6: u64, arg7: &mut Incentive, arg8: &mut 0x2::tx_context::TxContext) {
        update_reward(arg0, arg7, arg2, arg4, 4, 0x2::tx_context::sender(arg8));
        0x65d3b958fe52dad6ef61fbce9368877312a319957eab3d6946796079af862030::lending::entry_repay_coin<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg8);
    }

    public entry fun entry_withdraw<T0>(arg0: &0x2::clock::Clock, arg1: &0x859de5e155d57462d3fe0aeb980b9a3f9cdccf76522d9499f372789183440aca::oracle::PriceOracle, arg2: &mut 0x65d3b958fe52dad6ef61fbce9368877312a319957eab3d6946796079af862030::storage::Storage, arg3: &mut 0x65d3b958fe52dad6ef61fbce9368877312a319957eab3d6946796079af862030::pool::Pool<T0>, arg4: u8, arg5: u64, arg6: &mut Incentive, arg7: &mut 0x2::tx_context::TxContext) {
        update_reward(arg0, arg6, arg2, arg4, 2, 0x2::tx_context::sender(arg7));
        0x65d3b958fe52dad6ef61fbce9368877312a319957eab3d6946796079af862030::lending::entry_withdraw_coin<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg7);
    }

    public fun get_pool_from_asset_and_option(arg0: &Incentive, arg1: u8, arg2: u8) : (vector<address>, vector<address>, vector<address>) {
        let v0 = arg0.pool_objs;
        let v1 = 0x1::vector::length<address>(&v0);
        let v2 = 0x1::vector::empty<address>();
        let v3 = 0x1::vector::empty<address>();
        let v4 = 0x1::vector::empty<address>();
        while (v1 > 0) {
            let v5 = *0x1::vector::borrow<address>(&v0, v1 - 1);
            let v6 = 0x2::table::borrow<address, IncentivePool>(&arg0.pools, v5);
            if (v6.asset_id == arg1 && v6.option == arg2) {
                0x1::vector::push_back<address>(&mut v2, v5);
                0x1::vector::push_back<address>(&mut v3, v5);
                0x1::vector::push_back<address>(&mut v4, v5);
                v1 = v1 - 1;
                continue
            };
            if (v6.asset_id == arg1) {
                0x1::vector::push_back<address>(&mut v2, v5);
            };
            if (v6.option == arg2) {
                0x1::vector::push_back<address>(&mut v3, v5);
            };
            v1 = v1 - 1;
        };
        (v2, v3, v4)
    }

    fun get_pool_obj_from_funds_pool<T0>(arg0: &mut Incentive, arg1: &IncentiveFundsPool<T0>, arg2: u8, arg3: u8) : vector<address> {
        let v0 = 0x1::vector::empty<address>();
        let v1 = arg0.pool_objs;
        let v2 = 0x1::vector::length<address>(&v1);
        while (v2 > 0) {
            let v3 = *0x1::vector::borrow<address>(&v1, v2 - 1);
            let v4 = 0x2::table::borrow<address, IncentivePool>(&arg0.pools, v3);
            if (v4.asset_id == arg2 && v4.option == arg3 && v4.funds == 0x2::object::uid_to_address(&arg1.id)) {
                0x1::vector::push_back<address>(&mut v0, v3);
            };
            v2 = v2 - 1;
        };
        v0
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = OwnerCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<OwnerCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun repay<T0>(arg0: &0x2::clock::Clock, arg1: &0x859de5e155d57462d3fe0aeb980b9a3f9cdccf76522d9499f372789183440aca::oracle::PriceOracle, arg2: &mut 0x65d3b958fe52dad6ef61fbce9368877312a319957eab3d6946796079af862030::storage::Storage, arg3: &mut 0x65d3b958fe52dad6ef61fbce9368877312a319957eab3d6946796079af862030::pool::Pool<T0>, arg4: u8, arg5: 0x2::coin::Coin<T0>, arg6: u64, arg7: &mut Incentive, arg8: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        update_reward(arg0, arg7, arg2, arg4, 4, 0x2::tx_context::sender(arg8));
        0x65d3b958fe52dad6ef61fbce9368877312a319957eab3d6946796079af862030::lending::repay_coin<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg8)
    }

    fun update_pool_state(arg0: &mut IncentivePool, arg1: u64, arg2: u256) {
        arg0.last_update_at = arg1;
        arg0.index_reward = arg2;
    }

    fun update_reward(arg0: &0x2::clock::Clock, arg1: &mut Incentive, arg2: &mut 0x65d3b958fe52dad6ef61fbce9368877312a319957eab3d6946796079af862030::storage::Storage, arg3: u8, arg4: u8, arg5: address) {
        let (_, _, v2) = get_pool_from_asset_and_option(arg1, arg3, arg4);
        let v3 = v2;
        let v4 = 0x1::vector::length<address>(&v3);
        let (v5, v6) = 0x65d3b958fe52dad6ef61fbce9368877312a319957eab3d6946796079af862030::storage::get_user_balance(arg2, arg3, arg5);
        let (v7, v8) = 0x65d3b958fe52dad6ef61fbce9368877312a319957eab3d6946796079af862030::storage::get_total_supply(arg2, arg3);
        let v9 = v7;
        if (arg4 == 3) {
            v9 = v8;
        };
        while (v4 > 0) {
            let v10 = 0x2::table::borrow_mut<address, IncentivePool>(&mut arg1.pools, *0x1::vector::borrow<address>(&v3, v4 - 1));
            let v11 = calculate_user_effective_amount(arg4, v5, v6, v10.factor);
            update_reward_one(arg0, v10, v9, arg5, v11);
            v4 = v4 - 1;
        };
    }

    fun update_reward_one(arg0: &0x2::clock::Clock, arg1: &mut IncentivePool, arg2: u256, arg3: address, arg4: u256) {
        if (arg2 == 0) {
            return
        };
        let v0 = 0x2::clock::timestamp_ms(arg0);
        let v1 = v0;
        if (v0 < arg1.start_at || arg1.end_at == arg1.last_update_at) {
            return
        };
        if (v0 > arg1.end_at) {
            v1 = arg1.end_at;
        };
        let v2 = arg1.index_reward + 0x934507d7be26c3999d3a8ce84c41c0b15eab07233ab3e8920c51c769ace94e17::safe_math::div(0x934507d7be26c3999d3a8ce84c41c0b15eab07233ab3e8920c51c769ace94e17::safe_math::mul((calculate_release_rate(arg1) as u256), ((v1 - arg1.last_update_at) as u256)), arg2);
        update_pool_state(arg1, v1, v2);
        let v3 = 0;
        if (0x2::table::contains<address, u256>(&arg1.total_rewards_of_users, arg3)) {
            v3 = *0x2::table::borrow<address, u256>(&arg1.total_rewards_of_users, arg3);
        };
        let v4 = 0;
        if (0x2::table::contains<address, u256>(&arg1.rewards_paid, arg3)) {
            v4 = *0x2::table::borrow<address, u256>(&arg1.rewards_paid, arg3);
        };
        update_user_state(arg1, arg3, v2, v3 + (v2 - v4) * arg4);
    }

    fun update_user_state(arg0: &mut IncentivePool, arg1: address, arg2: u256, arg3: u256) {
        if (!0x2::table::contains<address, u256>(&arg0.rewards_paid, arg1)) {
            0x2::table::add<address, u256>(&mut arg0.rewards_paid, arg1, arg2);
        } else {
            let v0 = 0x2::table::borrow_mut<address, u256>(&mut arg0.rewards_paid, arg1);
            *v0 = *v0 + arg2;
        };
        if (!0x2::table::contains<address, u256>(&arg0.total_rewards_of_users, arg1)) {
            0x2::table::add<address, u256>(&mut arg0.total_rewards_of_users, arg1, arg3);
        } else {
            let v1 = 0x2::table::borrow_mut<address, u256>(&mut arg0.total_rewards_of_users, arg1);
            *v1 = *v1 + arg3;
        };
    }

    public fun withdraw<T0>(arg0: &0x2::clock::Clock, arg1: &0x859de5e155d57462d3fe0aeb980b9a3f9cdccf76522d9499f372789183440aca::oracle::PriceOracle, arg2: &mut 0x65d3b958fe52dad6ef61fbce9368877312a319957eab3d6946796079af862030::storage::Storage, arg3: &mut 0x65d3b958fe52dad6ef61fbce9368877312a319957eab3d6946796079af862030::pool::Pool<T0>, arg4: u8, arg5: u64, arg6: &mut Incentive, arg7: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        update_reward(arg0, arg6, arg2, arg4, 2, 0x2::tx_context::sender(arg7));
        0x65d3b958fe52dad6ef61fbce9368877312a319957eab3d6946796079af862030::lending::withdraw_coin<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg7)
    }

    public fun withdraw_funds<T0>(arg0: &OwnerCap, arg1: &mut IncentiveFundsPool<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<T0>(&arg1.balance) >= arg2, 8000);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.balance, arg2), arg3), 0x2::tx_context::sender(arg3));
        let v0 = WithdrawFunds{
            sender : 0x2::tx_context::sender(arg3),
            value  : arg2,
        };
        0x2::event::emit<WithdrawFunds>(v0);
    }

    // decompiled from Move bytecode v6
}

