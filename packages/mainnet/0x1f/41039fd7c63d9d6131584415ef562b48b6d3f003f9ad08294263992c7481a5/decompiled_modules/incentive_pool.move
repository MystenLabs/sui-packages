module 0x1f41039fd7c63d9d6131584415ef562b48b6d3f003f9ad08294263992c7481a5::incentive_pool {
    struct IncentivePool has store {
        pool_type: 0x1::type_name::TypeName,
        distributed_point_per_period: u64,
        point_distribution_time: u64,
        distributed_point: u64,
        max_distributed_point: u64,
        max_stakes: u64,
        index: u64,
        stakes: u64,
        last_update: u64,
        created_at: u64,
    }

    struct IncentivePools<phantom T0> has store, key {
        id: 0x2::object::UID,
        pools: 0x2::table::Table<0x1::type_name::TypeName, IncentivePool>,
        pool_types: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
        reward_pool: 0x1f41039fd7c63d9d6131584415ef562b48b6d3f003f9ad08294263992c7481a5::reward_pool::RewardPool<T0>,
    }

    public fun incentive_pool<T0>(arg0: &IncentivePools<T0>, arg1: 0x1::type_name::TypeName) : &IncentivePool {
        0x2::table::borrow<0x1::type_name::TypeName, IncentivePool>(&arg0.pools, arg1)
    }

    public(friend) fun accrue_all_points<T0>(arg0: &mut IncentivePools<T0>, arg1: &0x2::clock::Clock) {
        let v0 = 0x2::vec_set::keys<0x1::type_name::TypeName>(&arg0.pool_types);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::type_name::TypeName>(v0)) {
            let v2 = 0x2::table::borrow_mut<0x1::type_name::TypeName, IncentivePool>(&mut arg0.pools, *0x1::vector::borrow<0x1::type_name::TypeName>(v0, v1));
            accrue_points(v2, arg1);
            v1 = v1 + 1;
        };
    }

    fun accrue_points(arg0: &mut IncentivePool, arg1: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg1) / 1000;
        if (arg0.stakes == 0) {
            arg0.last_update = v0;
            return
        };
        let v1 = v0 - arg0.last_update;
        let v2 = v1 / arg0.point_distribution_time;
        if (v2 == 0) {
            return
        };
        let v3 = 0x2::math::min(arg0.distributed_point_per_period * v2, arg0.max_distributed_point - arg0.distributed_point);
        arg0.last_update = v0 - v1 % arg0.point_distribution_time;
        arg0.distributed_point = arg0.distributed_point + v3;
        if (v3 == 0) {
            return
        };
        arg0.index = arg0.index + 0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::u64::mul_div(1000000000, v3, arg0.stakes);
    }

    public(friend) fun add_rewards<T0>(arg0: &mut IncentivePools<T0>, arg1: 0x2::balance::Balance<T0>) {
        0x1f41039fd7c63d9d6131584415ef562b48b6d3f003f9ad08294263992c7481a5::reward_pool::add_reward<T0>(&mut arg0.reward_pool, arg1);
    }

    public fun base_index_rate() : u64 {
        1000000000
    }

    public(friend) fun claim_rewards<T0>(arg0: &mut IncentivePools<T0>, arg1: u64) : (u64, 0x2::balance::Balance<T0>) {
        0x1f41039fd7c63d9d6131584415ef562b48b6d3f003f9ad08294263992c7481a5::reward_pool::claim_reward<T0>(&mut arg0.reward_pool, arg1)
    }

    public(friend) fun create_incentive_pools<T0>(arg0: u64, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : IncentivePools<T0> {
        IncentivePools<T0>{
            id          : 0x2::object::new(arg2),
            pools       : 0x2::table::new<0x1::type_name::TypeName, IncentivePool>(arg2),
            pool_types  : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
            reward_pool : 0x1f41039fd7c63d9d6131584415ef562b48b6d3f003f9ad08294263992c7481a5::reward_pool::new<T0>(arg0, arg1),
        }
    }

    public fun created_at(arg0: &IncentivePool) : u64 {
        arg0.created_at
    }

    public fun distributed_point(arg0: &IncentivePool) : u64 {
        arg0.distributed_point
    }

    public fun distributed_point_per_period(arg0: &IncentivePool) : u64 {
        arg0.distributed_point_per_period
    }

    public fun index(arg0: &IncentivePool) : u64 {
        arg0.index
    }

    public fun is_points_up_to_date<T0>(arg0: &IncentivePools<T0>, arg1: &0x2::clock::Clock) : bool {
        let v0 = true;
        let v1 = 0x2::vec_set::keys<0x1::type_name::TypeName>(&arg0.pool_types);
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(v1)) {
            let v3 = 0x2::table::borrow<0x1::type_name::TypeName, IncentivePool>(&arg0.pools, *0x1::vector::borrow<0x1::type_name::TypeName>(v1, v2));
            if (!(0x2::clock::timestamp_ms(arg1) / 1000 - v3.last_update < v3.point_distribution_time)) {
                v0 = false;
            };
            v2 = v2 + 1;
        };
        v0
    }

    public fun is_pool_exist<T0>(arg0: &IncentivePools<T0>, arg1: 0x1::type_name::TypeName) : bool {
        0x2::table::contains<0x1::type_name::TypeName, IncentivePool>(&arg0.pools, arg1)
    }

    public fun last_update(arg0: &IncentivePool) : u64 {
        arg0.last_update
    }

    public fun max_distributed_point(arg0: &IncentivePool) : u64 {
        arg0.max_distributed_point
    }

    public fun max_stakes(arg0: &IncentivePool) : u64 {
        arg0.max_stakes
    }

    public fun point_distribution_time(arg0: &IncentivePool) : u64 {
        arg0.point_distribution_time
    }

    public fun pool_type(arg0: &IncentivePool) : 0x1::type_name::TypeName {
        arg0.pool_type
    }

    public(friend) fun stake<T0>(arg0: &mut IncentivePools<T0>, arg1: 0x1::type_name::TypeName, arg2: u64) {
        let v0 = 0x2::table::borrow_mut<0x1::type_name::TypeName, IncentivePool>(&mut arg0.pools, arg1);
        assert!(v0.stakes + arg2 <= v0.max_stakes, 1);
        v0.stakes = v0.stakes + arg2;
    }

    public fun stakes(arg0: &IncentivePool) : u64 {
        arg0.stakes
    }

    public(friend) fun take_rewards<T0>(arg0: &mut IncentivePools<T0>, arg1: u64) : 0x2::balance::Balance<T0> {
        0x1f41039fd7c63d9d6131584415ef562b48b6d3f003f9ad08294263992c7481a5::reward_pool::remove_reward<T0>(&mut arg0.reward_pool, arg1)
    }

    public(friend) fun unstake<T0>(arg0: &mut IncentivePools<T0>, arg1: 0x1::type_name::TypeName, arg2: u64) {
        let v0 = 0x2::table::borrow_mut<0x1::type_name::TypeName, IncentivePool>(&mut arg0.pools, arg1);
        v0.stakes = v0.stakes - arg2;
    }

    public(friend) fun update_pool<T0, T1>(arg0: &mut IncentivePools<T1>, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock) {
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::table::contains<0x1::type_name::TypeName, IncentivePool>(&arg0.pools, v0)) {
            let v1 = 0x2::table::borrow_mut<0x1::type_name::TypeName, IncentivePool>(&mut arg0.pools, v0);
            v1.distributed_point_per_period = arg1;
            v1.point_distribution_time = arg2;
            v1.max_distributed_point = arg3;
            v1.max_stakes = arg4;
        } else {
            let v2 = 0x2::clock::timestamp_ms(arg5) / 1000;
            let v3 = IncentivePool{
                pool_type                    : v0,
                distributed_point_per_period : arg1,
                point_distribution_time      : arg2,
                distributed_point            : 0,
                max_distributed_point        : arg3,
                max_stakes                   : arg4,
                index                        : 1000000000,
                stakes                       : 0,
                last_update                  : v2,
                created_at                   : v2,
            };
            0x2::table::add<0x1::type_name::TypeName, IncentivePool>(&mut arg0.pools, v0, v3);
            0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg0.pool_types, v0);
        };
    }

    public(friend) fun update_reward_pool<T0>(arg0: &mut IncentivePools<T0>, arg1: u64, arg2: u64) {
        0x1f41039fd7c63d9d6131584415ef562b48b6d3f003f9ad08294263992c7481a5::reward_pool::update_reward_pool<T0>(&mut arg0.reward_pool, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

