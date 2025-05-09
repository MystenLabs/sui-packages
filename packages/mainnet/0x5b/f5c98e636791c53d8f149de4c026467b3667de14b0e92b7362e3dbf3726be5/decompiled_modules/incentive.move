module 0x5bf5c98e636791c53d8f149de4c026467b3667de14b0e92b7362e3dbf3726be5::incentive {
    struct OwnerCap has store, key {
        id: 0x2::object::UID,
    }

    struct Incentive has store, key {
        id: 0x2::object::UID,
        version: u64,
        pool_objs: vector<address>,
        inactive_objs: vector<address>,
        pools: 0x2::table::Table<address, IncentivePool>,
        funds: 0x2::table::Table<address, IncentiveFundsPoolInfo>,
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
        index_rewards_paids: 0x2::table::Table<address, u256>,
        total_rewards_of_users: 0x2::table::Table<address, u256>,
        total_claimed_of_users: 0x2::table::Table<address, u256>,
    }

    struct IncentiveFundsPool<phantom T0> has store, key {
        id: 0x2::object::UID,
        oracle_id: u8,
        balance: 0x2::balance::Balance<T0>,
        coin_type: 0x1::type_name::TypeName,
    }

    struct IncentiveFundsPoolInfo has store, key {
        id: 0x2::object::UID,
        oracle_id: u8,
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

    struct IncentivePoolInfo has copy, drop {
        pool_id: address,
        funds: address,
        phase: u64,
        start_at: u64,
        end_at: u64,
        closed_at: u64,
        total_supply: u64,
        asset_id: u8,
        option: u8,
        factor: u256,
        available: u256,
        total: u256,
    }

    struct IncentiveAPYInfo has copy, drop {
        asset_id: u8,
        apy: u256,
        coin_types: vector<0x1::ascii::String>,
    }

    public fun borrow<T0>(arg0: &0x2::clock::Clock, arg1: &0x859de5e155d57462d3fe0aeb980b9a3f9cdccf76522d9499f372789183440aca::oracle::PriceOracle, arg2: &mut 0x57085c1f4a2d163d23aae1906e8055f80cf856464ac4fc55d6f05f4c863b9588::storage::Storage, arg3: &mut 0x57085c1f4a2d163d23aae1906e8055f80cf856464ac4fc55d6f05f4c863b9588::pool::Pool<T0>, arg4: u8, arg5: u64, arg6: &mut Incentive, arg7: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        update_reward(arg0, arg6, arg2, arg4, 3, 0x2::tx_context::sender(arg7));
        0x57085c1f4a2d163d23aae1906e8055f80cf856464ac4fc55d6f05f4c863b9588::lending::borrow_coin<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg7)
    }

    public fun add_funds<T0>(arg0: &OwnerCap, arg1: &mut IncentiveFundsPool<T0>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = IncreasedFunds{
            sender         : 0x2::tx_context::sender(arg4),
            balance_before : 0x2::balance::value<T0>(&arg1.balance),
            balance_after  : 0x2::balance::join<T0>(&mut arg1.balance, 0x57085c1f4a2d163d23aae1906e8055f80cf856464ac4fc55d6f05f4c863b9588::utils::split_coin_to_balance<T0>(arg2, arg3, arg4)),
        };
        0x2::event::emit<IncreasedFunds>(v0);
    }

    fun calculate_one(arg0: &IncentivePool, arg1: u64, arg2: u256, arg3: address, arg4: u256) : (u256, u256) {
        let v0 = arg0.start_at;
        let v1 = v0;
        if (v0 < arg0.last_update_at) {
            v1 = arg0.last_update_at;
        };
        let v2 = arg0.end_at;
        let v3 = v2;
        if (arg1 < v2) {
            v3 = arg1;
        };
        let v4 = arg0.index_reward;
        let v5 = v4;
        if (v1 < v3) {
            let v6 = 0;
            if (arg2 > 0) {
                v6 = 0x57085c1f4a2d163d23aae1906e8055f80cf856464ac4fc55d6f05f4c863b9588::safe_math::mul(calculate_release_rate(arg0), ((v3 - v1) as u256)) / arg2;
            };
            v5 = v4 + v6;
        };
        let v7 = 0;
        if (0x2::table::contains<address, u256>(&arg0.total_rewards_of_users, arg3)) {
            v7 = *0x2::table::borrow<address, u256>(&arg0.total_rewards_of_users, arg3);
        };
        let v8 = 0;
        if (0x2::table::contains<address, u256>(&arg0.index_rewards_paids, arg3)) {
            v8 = *0x2::table::borrow<address, u256>(&arg0.index_rewards_paids, arg3);
        };
        (v5, v7 + (v5 - v8) * arg4)
    }

    public fun calculate_release_rate(arg0: &IncentivePool) : u256 {
        0x57085c1f4a2d163d23aae1906e8055f80cf856464ac4fc55d6f05f4c863b9588::ray_math::ray_div((arg0.total_supply as u256), ((arg0.end_at - arg0.start_at) as u256))
    }

    public fun calculate_user_effective_amount(arg0: u8, arg1: u256, arg2: u256, arg3: u256) : u256 {
        if (arg0 == 3) {
            let v0 = arg1 ^ arg2;
            let v1 = v0 ^ arg2;
            arg2 = v1;
            arg1 = v0 ^ v1;
        };
        let v2 = 0x57085c1f4a2d163d23aae1906e8055f80cf856464ac4fc55d6f05f4c863b9588::ray_math::ray_mul(arg2, arg3);
        if (arg1 > v2) {
            return arg1 - v2
        };
        0
    }

    public entry fun claim_reward<T0>(arg0: &0x2::clock::Clock, arg1: &mut Incentive, arg2: &mut IncentiveFundsPool<T0>, arg3: &mut 0x57085c1f4a2d163d23aae1906e8055f80cf856464ac4fc55d6f05f4c863b9588::storage::Storage, arg4: u8, arg5: u8, arg6: &mut 0x2::tx_context::TxContext) {
        version_verification(arg1);
        let v0 = 0x2::tx_context::sender(arg6);
        update_reward(arg0, arg1, arg3, arg4, arg5, v0);
        let v1 = get_pool_obj_from_funds_pool<T0>(arg1, arg2, arg4, arg5);
        let v2 = 0x1::vector::length<address>(&v1);
        let v3 = 0;
        while (v2 > 0) {
            let v4 = *0x1::vector::borrow<address>(&v1, v2 - 1);
            let v5 = 0x2::table::borrow_mut<address, IncentivePool>(&mut arg1.pools, v4);
            if (v5.closed_at > 0 && 0x2::clock::timestamp_ms(arg0) > v5.closed_at) {
                v2 = v2 - 1;
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
            let v8 = (((v6 - v7) / 0x57085c1f4a2d163d23aae1906e8055f80cf856464ac4fc55d6f05f4c863b9588::ray_math::ray()) as u64);
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
            };
            v2 = v2 - 1;
        };
        if (v3 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(decrease_balance<T0>(arg2, v3), arg6), v0);
        };
    }

    public fun create_funds_pool<T0>(arg0: &OwnerCap, arg1: &mut Incentive, arg2: u8, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) {
        version_verification(arg1);
        let v0 = 0x2::object::new(arg4);
        let v1 = IncentiveFundsPool<T0>{
            id        : v0,
            oracle_id : arg2,
            balance   : 0x2::balance::zero<T0>(),
            coin_type : 0x1::type_name::get<T0>(),
        };
        0x2::transfer::share_object<IncentiveFundsPool<T0>>(v1);
        let v2 = IncentiveFundsPoolInfo{
            id        : 0x2::object::new(arg4),
            oracle_id : arg2,
            coin_type : 0x1::type_name::get<T0>(),
        };
        0x2::table::add<address, IncentiveFundsPoolInfo>(&mut arg1.funds, 0x2::object::uid_to_address(&v0), v2);
        let v3 = CreateFundsPool{
            sender    : 0x2::tx_context::sender(arg4),
            coin_type : 0x1::type_name::get<T0>(),
            oracle_id : arg2,
            force     : arg3,
        };
        0x2::event::emit<CreateFundsPool>(v3);
    }

    public fun create_incentive(arg0: &OwnerCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg1);
        let v1 = Incentive{
            id            : v0,
            version       : 0,
            pool_objs     : 0x1::vector::empty<address>(),
            inactive_objs : 0x1::vector::empty<address>(),
            pools         : 0x2::table::new<address, IncentivePool>(arg1),
            funds         : 0x2::table::new<address, IncentiveFundsPoolInfo>(arg1),
        };
        0x2::transfer::share_object<Incentive>(v1);
        let v2 = CreateIncentive{
            sender             : 0x2::tx_context::sender(arg1),
            incentive_pool_pro : 0x2::object::uid_to_address(&v0),
        };
        0x2::event::emit<CreateIncentive>(v2);
    }

    public fun create_incentive_pool<T0>(arg0: &OwnerCap, arg1: &mut Incentive, arg2: &IncentiveFundsPool<T0>, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u8, arg9: u8, arg10: u256, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(arg4 < arg5, 8001);
        assert!(arg6 == 0 || arg6 > arg5, 8001);
        let v0 = 0x2::object::new(arg11);
        let v1 = 0x2::object::uid_to_address(&v0);
        let v2 = IncentivePool{
            id                     : v0,
            phase                  : arg3,
            funds                  : 0x2::object::uid_to_address(&arg2.id),
            start_at               : arg4,
            end_at                 : arg5,
            closed_at              : arg6,
            total_supply           : arg7,
            option                 : arg8,
            asset_id               : arg9,
            factor                 : arg10,
            last_update_at         : arg4,
            distributed            : 0,
            index_reward           : 0,
            index_rewards_paids    : 0x2::table::new<address, u256>(arg11),
            total_rewards_of_users : 0x2::table::new<address, u256>(arg11),
            total_claimed_of_users : 0x2::table::new<address, u256>(arg11),
        };
        0x2::table::add<address, IncentivePool>(&mut arg1.pools, v1, v2);
        0x1::vector::push_back<address>(&mut arg1.pool_objs, v1);
        let v3 = CreateIncentivePool{
            sender : 0x2::tx_context::sender(arg11),
            pool   : v1,
        };
        0x2::event::emit<CreateIncentivePool>(v3);
    }

    fun decrease_balance<T0>(arg0: &mut IncentiveFundsPool<T0>, arg1: u64) : 0x2::balance::Balance<T0> {
        0x2::balance::split<T0>(&mut arg0.balance, arg1)
    }

    public entry fun entry_borrow<T0>(arg0: &0x2::clock::Clock, arg1: &0x859de5e155d57462d3fe0aeb980b9a3f9cdccf76522d9499f372789183440aca::oracle::PriceOracle, arg2: &mut 0x57085c1f4a2d163d23aae1906e8055f80cf856464ac4fc55d6f05f4c863b9588::storage::Storage, arg3: &mut 0x57085c1f4a2d163d23aae1906e8055f80cf856464ac4fc55d6f05f4c863b9588::pool::Pool<T0>, arg4: u8, arg5: u64, arg6: &mut Incentive, arg7: &mut 0x2::tx_context::TxContext) {
        update_reward(arg0, arg6, arg2, arg4, 3, 0x2::tx_context::sender(arg7));
        0x57085c1f4a2d163d23aae1906e8055f80cf856464ac4fc55d6f05f4c863b9588::lending::entry_borrow_coin<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg7);
    }

    public entry fun entry_deposit<T0>(arg0: &0x2::clock::Clock, arg1: &mut 0x57085c1f4a2d163d23aae1906e8055f80cf856464ac4fc55d6f05f4c863b9588::storage::Storage, arg2: &mut 0x57085c1f4a2d163d23aae1906e8055f80cf856464ac4fc55d6f05f4c863b9588::pool::Pool<T0>, arg3: u8, arg4: 0x2::coin::Coin<T0>, arg5: u64, arg6: &mut Incentive, arg7: &mut 0x2::tx_context::TxContext) {
        update_reward(arg0, arg6, arg1, arg3, 1, 0x2::tx_context::sender(arg7));
        0x57085c1f4a2d163d23aae1906e8055f80cf856464ac4fc55d6f05f4c863b9588::lending::entry_deposit_coin<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg7);
    }

    public entry fun entry_repay<T0>(arg0: &0x2::clock::Clock, arg1: &0x859de5e155d57462d3fe0aeb980b9a3f9cdccf76522d9499f372789183440aca::oracle::PriceOracle, arg2: &mut 0x57085c1f4a2d163d23aae1906e8055f80cf856464ac4fc55d6f05f4c863b9588::storage::Storage, arg3: &mut 0x57085c1f4a2d163d23aae1906e8055f80cf856464ac4fc55d6f05f4c863b9588::pool::Pool<T0>, arg4: u8, arg5: 0x2::coin::Coin<T0>, arg6: u64, arg7: &mut Incentive, arg8: &mut 0x2::tx_context::TxContext) {
        update_reward(arg0, arg7, arg2, arg4, 4, 0x2::tx_context::sender(arg8));
        0x57085c1f4a2d163d23aae1906e8055f80cf856464ac4fc55d6f05f4c863b9588::lending::entry_repay_coin<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg8);
    }

    public entry fun entry_withdraw<T0>(arg0: &0x2::clock::Clock, arg1: &0x859de5e155d57462d3fe0aeb980b9a3f9cdccf76522d9499f372789183440aca::oracle::PriceOracle, arg2: &mut 0x57085c1f4a2d163d23aae1906e8055f80cf856464ac4fc55d6f05f4c863b9588::storage::Storage, arg3: &mut 0x57085c1f4a2d163d23aae1906e8055f80cf856464ac4fc55d6f05f4c863b9588::pool::Pool<T0>, arg4: u8, arg5: u64, arg6: &mut Incentive, arg7: &mut 0x2::tx_context::TxContext) {
        update_reward(arg0, arg6, arg2, arg4, 2, 0x2::tx_context::sender(arg7));
        0x57085c1f4a2d163d23aae1906e8055f80cf856464ac4fc55d6f05f4c863b9588::lending::entry_withdraw_coin<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg7);
    }

    public fun get_active_pools(arg0: &Incentive, arg1: u8, arg2: u8, arg3: u64) : vector<address> {
        let v0 = arg0.pool_objs;
        let v1 = 0x1::vector::length<address>(&v0);
        let v2 = 0x1::vector::empty<address>();
        while (v1 > 0) {
            let v3 = *0x1::vector::borrow<address>(&v0, v1 - 1);
            let v4 = 0x2::table::borrow<address, IncentivePool>(&arg0.pools, v3);
            if (v4.asset_id == arg1 && v4.option == arg2 && v4.start_at <= arg3 && v4.end_at >= arg3) {
                0x1::vector::push_back<address>(&mut v2, v3);
            };
            v1 = v1 - 1;
        };
        v2
    }

    public fun get_incentive_apy(arg0: &0x2::clock::Clock, arg1: &Incentive, arg2: &mut 0x57085c1f4a2d163d23aae1906e8055f80cf856464ac4fc55d6f05f4c863b9588::storage::Storage, arg3: &0x859de5e155d57462d3fe0aeb980b9a3f9cdccf76522d9499f372789183440aca::oracle::PriceOracle, arg4: u8) : vector<IncentiveAPYInfo> {
        let v0 = 0x1::vector::empty<IncentiveAPYInfo>();
        let v1 = 0x57085c1f4a2d163d23aae1906e8055f80cf856464ac4fc55d6f05f4c863b9588::storage::get_reserves_count(arg2);
        while (v1 > 0) {
            let v2 = v1 - 1;
            let (v3, v4) = 0x57085c1f4a2d163d23aae1906e8055f80cf856464ac4fc55d6f05f4c863b9588::storage::get_total_supply(arg2, v2);
            let v5 = v3;
            if (arg4 == 3) {
                v5 = v4;
            };
            let v6 = get_active_pools(arg1, v2, arg4, 0x2::clock::timestamp_ms(arg0));
            let v7 = 0x1::vector::length<address>(&v6);
            if (v7 == 0) {
                v1 = v1 - 1;
                continue
            };
            let v8 = 0;
            let v9 = 0x1::vector::empty<0x1::ascii::String>();
            while (v7 > 0) {
                let v10 = 0x2::table::borrow<address, IncentivePool>(&arg1.pools, *0x1::vector::borrow<address>(&v6, v7 - 1));
                let v11 = 0x2::table::borrow<address, IncentiveFundsPoolInfo>(&arg1.funds, v10.funds);
                v8 = v8 + 0x57085c1f4a2d163d23aae1906e8055f80cf856464ac4fc55d6f05f4c863b9588::calculator::calculate_value(arg0, arg3, (v10.total_supply as u256), v11.oracle_id) / ((v10.end_at - v10.start_at) as u256) * (31536000000 as u256) / 0x57085c1f4a2d163d23aae1906e8055f80cf856464ac4fc55d6f05f4c863b9588::calculator::calculate_value(arg0, arg3, v5, 0x57085c1f4a2d163d23aae1906e8055f80cf856464ac4fc55d6f05f4c863b9588::storage::get_oracle_id(arg2, v2));
                let v12 = 0x1::type_name::into_string(v11.coin_type);
                if (!0x1::vector::contains<0x1::ascii::String>(&v9, &v12)) {
                    0x1::vector::push_back<0x1::ascii::String>(&mut v9, 0x1::type_name::into_string(v11.coin_type));
                };
                v7 = v7 - 1;
            };
            let v13 = IncentiveAPYInfo{
                asset_id   : v2,
                apy        : v8,
                coin_types : v9,
            };
            0x1::vector::push_back<IncentiveAPYInfo>(&mut v0, v13);
            v1 = v1 - 1;
        };
        v0
    }

    public fun get_incentive_pools(arg0: &0x2::clock::Clock, arg1: &Incentive, arg2: &mut 0x57085c1f4a2d163d23aae1906e8055f80cf856464ac4fc55d6f05f4c863b9588::storage::Storage, arg3: u8, arg4: u8, arg5: address) : vector<IncentivePoolInfo> {
        let v0 = 0x1::vector::empty<IncentivePoolInfo>();
        let (_, _, v3) = get_pool_from_asset_and_option(arg1, arg3, arg4);
        let v4 = v3;
        let v5 = 0x1::vector::length<address>(&v4);
        let (v6, v7) = 0x57085c1f4a2d163d23aae1906e8055f80cf856464ac4fc55d6f05f4c863b9588::storage::get_user_balance(arg2, arg3, arg5);
        let (v8, v9) = 0x57085c1f4a2d163d23aae1906e8055f80cf856464ac4fc55d6f05f4c863b9588::storage::get_total_supply(arg2, arg3);
        let v10 = v8;
        if (arg4 == 3) {
            v10 = v9;
        };
        while (v5 > 0) {
            let v11 = 0x2::table::borrow<address, IncentivePool>(&arg1.pools, *0x1::vector::borrow<address>(&v4, v5 - 1));
            let (_, v13) = calculate_one(v11, 0x2::clock::timestamp_ms(arg0), v10, arg5, calculate_user_effective_amount(arg4, v6, v7, v11.factor));
            let v14 = 0;
            if (0x2::table::contains<address, u256>(&v11.total_claimed_of_users, arg5)) {
                v14 = *0x2::table::borrow<address, u256>(&v11.total_claimed_of_users, arg5);
            };
            let v15 = IncentivePoolInfo{
                pool_id      : 0x2::object::uid_to_address(&v11.id),
                funds        : v11.funds,
                phase        : v11.phase,
                start_at     : v11.start_at,
                end_at       : v11.end_at,
                closed_at    : v11.closed_at,
                total_supply : v11.total_supply,
                asset_id     : v11.asset_id,
                option       : v11.option,
                factor       : v11.factor,
                available    : v13 - v14,
                total        : v13,
            };
            0x1::vector::push_back<IncentivePoolInfo>(&mut v0, v15);
            v5 = v5 - 1;
        };
        v0
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

    public fun get_pool_obj_from_funds_pool<T0>(arg0: &Incentive, arg1: &IncentiveFundsPool<T0>, arg2: u8, arg3: u8) : vector<address> {
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

    public fun repay<T0>(arg0: &0x2::clock::Clock, arg1: &0x859de5e155d57462d3fe0aeb980b9a3f9cdccf76522d9499f372789183440aca::oracle::PriceOracle, arg2: &mut 0x57085c1f4a2d163d23aae1906e8055f80cf856464ac4fc55d6f05f4c863b9588::storage::Storage, arg3: &mut 0x57085c1f4a2d163d23aae1906e8055f80cf856464ac4fc55d6f05f4c863b9588::pool::Pool<T0>, arg4: u8, arg5: 0x2::coin::Coin<T0>, arg6: u64, arg7: &mut Incentive, arg8: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        update_reward(arg0, arg7, arg2, arg4, 4, 0x2::tx_context::sender(arg8));
        0x57085c1f4a2d163d23aae1906e8055f80cf856464ac4fc55d6f05f4c863b9588::lending::repay_coin<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg8)
    }

    fun update_reward(arg0: &0x2::clock::Clock, arg1: &mut Incentive, arg2: &mut 0x57085c1f4a2d163d23aae1906e8055f80cf856464ac4fc55d6f05f4c863b9588::storage::Storage, arg3: u8, arg4: u8, arg5: address) {
        version_verification(arg1);
        let v0 = 0x2::clock::timestamp_ms(arg0);
        let (_, _, v3) = get_pool_from_asset_and_option(arg1, arg3, arg4);
        let v4 = v3;
        let v5 = 0x1::vector::length<address>(&v4);
        let (v6, v7) = 0x57085c1f4a2d163d23aae1906e8055f80cf856464ac4fc55d6f05f4c863b9588::storage::get_user_balance(arg2, arg3, arg5);
        let (v8, v9) = 0x57085c1f4a2d163d23aae1906e8055f80cf856464ac4fc55d6f05f4c863b9588::storage::get_total_supply(arg2, arg3);
        let v10 = v8;
        if (arg4 == 3) {
            v10 = v9;
        };
        while (v5 > 0) {
            let v11 = 0x2::table::borrow_mut<address, IncentivePool>(&mut arg1.pools, *0x1::vector::borrow<address>(&v4, v5 - 1));
            let (v12, v13) = calculate_one(v11, v0, v10, arg5, calculate_user_effective_amount(arg4, v6, v7, v11.factor));
            v11.index_reward = v12;
            v11.last_update_at = v0;
            if (0x2::table::contains<address, u256>(&v11.index_rewards_paids, arg5)) {
                0x2::table::remove<address, u256>(&mut v11.index_rewards_paids, arg5);
            };
            0x2::table::add<address, u256>(&mut v11.index_rewards_paids, arg5, v12);
            if (0x2::table::contains<address, u256>(&v11.total_rewards_of_users, arg5)) {
                0x2::table::remove<address, u256>(&mut v11.total_rewards_of_users, arg5);
            };
            0x2::table::add<address, u256>(&mut v11.total_rewards_of_users, arg5, v13);
            v5 = v5 - 1;
        };
    }

    public fun version_migrate(arg0: &OwnerCap, arg1: &mut Incentive) {
        assert!(arg1.version < 0, 7999);
        arg1.version = 0;
    }

    public fun version_verification(arg0: &Incentive) {
        assert!(arg0.version == 0, 7999);
    }

    public fun withdraw<T0>(arg0: &0x2::clock::Clock, arg1: &0x859de5e155d57462d3fe0aeb980b9a3f9cdccf76522d9499f372789183440aca::oracle::PriceOracle, arg2: &mut 0x57085c1f4a2d163d23aae1906e8055f80cf856464ac4fc55d6f05f4c863b9588::storage::Storage, arg3: &mut 0x57085c1f4a2d163d23aae1906e8055f80cf856464ac4fc55d6f05f4c863b9588::pool::Pool<T0>, arg4: u8, arg5: u64, arg6: &mut Incentive, arg7: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        update_reward(arg0, arg6, arg2, arg4, 2, 0x2::tx_context::sender(arg7));
        0x57085c1f4a2d163d23aae1906e8055f80cf856464ac4fc55d6f05f4c863b9588::lending::withdraw_coin<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg7)
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

