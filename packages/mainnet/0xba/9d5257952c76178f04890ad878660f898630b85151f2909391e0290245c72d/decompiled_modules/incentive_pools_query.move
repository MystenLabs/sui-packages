module 0xba9d5257952c76178f04890ad878660f898630b85151f2909391e0290245c72d::incentive_pools_query {
    struct IncentivePoolData has copy, drop, store {
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

    struct RewardPoolData has copy, drop, store {
        reward_type: 0x1::type_name::TypeName,
        exchange_rate_numerator: u64,
        exchange_rate_denominator: u64,
        remaining_reward: u64,
        claimed_rewards: u64,
        rewards_fee_rate_numerator: u64,
        rewards_fee_rate_denominator: u64,
    }

    struct IncentivePoolsData has copy, drop {
        incentive_pools: vector<IncentivePoolData>,
        reward_pool: RewardPoolData,
    }

    public fun incentive_pools_data<T0>(arg0: &0x41c0788f4ab64cf36dc882174f467634c033bf68c3c1b5ef9819507825eb510b::incentive_pool::IncentivePools<T0>) {
        let v0 = 0x1::vector::empty<IncentivePoolData>();
        let v1 = 0x41c0788f4ab64cf36dc882174f467634c033bf68c3c1b5ef9819507825eb510b::incentive_pool::pool_types<T0>(arg0);
        let v2 = 0x2::vec_set::keys<0x1::type_name::TypeName>(&v1);
        let v3 = 0;
        while (v3 < 0x1::vector::length<0x1::type_name::TypeName>(v2)) {
            let v4 = *0x1::vector::borrow<0x1::type_name::TypeName>(v2, v3);
            let v5 = 0x2::table::borrow<0x1::type_name::TypeName, 0x41c0788f4ab64cf36dc882174f467634c033bf68c3c1b5ef9819507825eb510b::incentive_pool::IncentivePool>(0x41c0788f4ab64cf36dc882174f467634c033bf68c3c1b5ef9819507825eb510b::incentive_pool::pools<T0>(arg0), v4);
            let v6 = IncentivePoolData{
                pool_type                    : v4,
                distributed_point_per_period : 0x41c0788f4ab64cf36dc882174f467634c033bf68c3c1b5ef9819507825eb510b::incentive_pool::distributed_point_per_period(v5),
                point_distribution_time      : 0x41c0788f4ab64cf36dc882174f467634c033bf68c3c1b5ef9819507825eb510b::incentive_pool::point_distribution_time(v5),
                distributed_point            : 0x41c0788f4ab64cf36dc882174f467634c033bf68c3c1b5ef9819507825eb510b::incentive_pool::distributed_point(v5),
                max_distributed_point        : 0x41c0788f4ab64cf36dc882174f467634c033bf68c3c1b5ef9819507825eb510b::incentive_pool::max_distributed_point(v5),
                max_stakes                   : 0x41c0788f4ab64cf36dc882174f467634c033bf68c3c1b5ef9819507825eb510b::incentive_pool::max_stakes(v5),
                index                        : 0x41c0788f4ab64cf36dc882174f467634c033bf68c3c1b5ef9819507825eb510b::incentive_pool::index(v5),
                stakes                       : 0x41c0788f4ab64cf36dc882174f467634c033bf68c3c1b5ef9819507825eb510b::incentive_pool::stakes(v5),
                last_update                  : 0x41c0788f4ab64cf36dc882174f467634c033bf68c3c1b5ef9819507825eb510b::incentive_pool::last_update(v5),
                created_at                   : 0x41c0788f4ab64cf36dc882174f467634c033bf68c3c1b5ef9819507825eb510b::incentive_pool::created_at(v5),
            };
            0x1::vector::push_back<IncentivePoolData>(&mut v0, v6);
            v3 = v3 + 1;
        };
        let v7 = 0x41c0788f4ab64cf36dc882174f467634c033bf68c3c1b5ef9819507825eb510b::incentive_pool::reward_pool<T0>(arg0);
        let (v8, v9) = 0x41c0788f4ab64cf36dc882174f467634c033bf68c3c1b5ef9819507825eb510b::reward_pool::exchange_rate<T0>(v7);
        let (v10, v11) = 0x41c0788f4ab64cf36dc882174f467634c033bf68c3c1b5ef9819507825eb510b::incentive_pool::reward_fee<T0>(arg0);
        let v12 = RewardPoolData{
            reward_type                  : 0x1::type_name::get<T0>(),
            exchange_rate_numerator      : v8,
            exchange_rate_denominator    : v9,
            remaining_reward             : 0x41c0788f4ab64cf36dc882174f467634c033bf68c3c1b5ef9819507825eb510b::incentive_pool::remaining_rewards<T0>(arg0),
            claimed_rewards              : 0x41c0788f4ab64cf36dc882174f467634c033bf68c3c1b5ef9819507825eb510b::reward_pool::claimed_rewards<T0>(v7),
            rewards_fee_rate_numerator   : v10,
            rewards_fee_rate_denominator : v11,
        };
        let v13 = IncentivePoolsData{
            incentive_pools : v0,
            reward_pool     : v12,
        };
        0x2::event::emit<IncentivePoolsData>(v13);
    }

    // decompiled from Move bytecode v6
}

