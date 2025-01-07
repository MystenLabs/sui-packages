module 0xcefd0f021d66e30132620142fef8590638cedce9f8e23b3d7fb04be2cf088c44::incentive_pools_query {
    struct IncentivePoolPointData has copy, drop, store {
        point_type: 0x1::type_name::TypeName,
        distributed_point_per_period: u64,
        point_distribution_time: u64,
        distributed_point: u64,
        points: u64,
        index: u64,
        base_weight: u64,
        weighted_amount: u64,
        last_update: u64,
        created_at: u64,
    }

    struct IncentivePoolData has copy, drop, store {
        pool_type: 0x1::type_name::TypeName,
        points: vector<IncentivePoolPointData>,
        min_stakes: u64,
        max_stakes: u64,
        stakes: u64,
    }

    struct IncentivePoolsData has copy, drop {
        incentive_pools: vector<IncentivePoolData>,
    }

    public fun incentive_pools_data(arg0: &0x41354112a4df1cd228ea558aaf309700025b36270c743a008b38f514848798fc::incentive_pool::IncentivePools) {
        let v0 = 0x1::vector::empty<IncentivePoolData>();
        let v1 = 0x41354112a4df1cd228ea558aaf309700025b36270c743a008b38f514848798fc::incentive_pool::pool_types(arg0);
        let v2 = 0x2::vec_set::keys<0x1::type_name::TypeName>(&v1);
        let v3 = 0;
        while (v3 < 0x1::vector::length<0x1::type_name::TypeName>(v2)) {
            let v4 = *0x1::vector::borrow<0x1::type_name::TypeName>(v2, v3);
            let v5 = 0x2::table::borrow<0x1::type_name::TypeName, 0x41354112a4df1cd228ea558aaf309700025b36270c743a008b38f514848798fc::incentive_pool::IncentivePool>(0x41354112a4df1cd228ea558aaf309700025b36270c743a008b38f514848798fc::incentive_pool::pools(arg0), v4);
            let v6 = IncentivePoolData{
                pool_type  : v4,
                points     : pool_point_data(v5),
                min_stakes : 0x41354112a4df1cd228ea558aaf309700025b36270c743a008b38f514848798fc::incentive_pool::min_stakes(v5),
                max_stakes : 0x41354112a4df1cd228ea558aaf309700025b36270c743a008b38f514848798fc::incentive_pool::max_stakes(v5),
                stakes     : 0x41354112a4df1cd228ea558aaf309700025b36270c743a008b38f514848798fc::incentive_pool::stakes(v5),
            };
            0x1::vector::push_back<IncentivePoolData>(&mut v0, v6);
            v3 = v3 + 1;
        };
        let v7 = IncentivePoolsData{incentive_pools: v0};
        0x2::event::emit<IncentivePoolsData>(v7);
    }

    fun pool_point_data(arg0: &0x41354112a4df1cd228ea558aaf309700025b36270c743a008b38f514848798fc::incentive_pool::IncentivePool) : vector<IncentivePoolPointData> {
        let v0 = 0x1::vector::empty<IncentivePoolPointData>();
        let v1 = *0x41354112a4df1cd228ea558aaf309700025b36270c743a008b38f514848798fc::incentive_pool::points_list(arg0);
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(&v1)) {
            let v3 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v1, v2);
            let v4 = 0x41354112a4df1cd228ea558aaf309700025b36270c743a008b38f514848798fc::incentive_pool::pool_point(arg0, v3);
            let v5 = IncentivePoolPointData{
                point_type                   : v3,
                distributed_point_per_period : 0x41354112a4df1cd228ea558aaf309700025b36270c743a008b38f514848798fc::incentive_pool::distributed_point_per_period(v4),
                point_distribution_time      : 0x41354112a4df1cd228ea558aaf309700025b36270c743a008b38f514848798fc::incentive_pool::point_distribution_time(v4),
                distributed_point            : 0x41354112a4df1cd228ea558aaf309700025b36270c743a008b38f514848798fc::incentive_pool::distributed_point(v4),
                points                       : 0x41354112a4df1cd228ea558aaf309700025b36270c743a008b38f514848798fc::incentive_pool::points(v4),
                index                        : 0x41354112a4df1cd228ea558aaf309700025b36270c743a008b38f514848798fc::incentive_pool::index(v4),
                base_weight                  : 0x41354112a4df1cd228ea558aaf309700025b36270c743a008b38f514848798fc::incentive_pool::base_weight(v4),
                weighted_amount              : 0x41354112a4df1cd228ea558aaf309700025b36270c743a008b38f514848798fc::incentive_pool::weighted_amount(v4),
                last_update                  : 0x41354112a4df1cd228ea558aaf309700025b36270c743a008b38f514848798fc::incentive_pool::last_update(v4),
                created_at                   : 0x41354112a4df1cd228ea558aaf309700025b36270c743a008b38f514848798fc::incentive_pool::created_at(v4),
            };
            0x1::vector::push_back<IncentivePoolPointData>(&mut v0, v5);
            v2 = v2 + 1;
        };
        v0
    }

    // decompiled from Move bytecode v6
}

