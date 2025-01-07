module 0x41354112a4df1cd228ea558aaf309700025b36270c743a008b38f514848798fc::incentive_pool {
    struct IncentivePoolPoint has store {
        distributed_point_per_period: u64,
        point_distribution_time: u64,
        distributed_point: u64,
        points: u64,
        base_weight: u64,
        weighted_amount: u64,
        index: u64,
        last_update: u64,
        created_at: u64,
    }

    struct IncentivePool has store {
        pool_type: 0x1::type_name::TypeName,
        points: 0x2::table::Table<0x1::type_name::TypeName, IncentivePoolPoint>,
        points_list: vector<0x1::type_name::TypeName>,
        min_stakes: u64,
        max_stakes: u64,
        stakes: u64,
    }

    struct IncentivePools has key {
        id: 0x2::object::UID,
        pools: 0x2::table::Table<0x1::type_name::TypeName, IncentivePool>,
        pool_types: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
        rewards: 0x2::table::Table<0x1::type_name::TypeName, 0x2::bag::Bag>,
        reward_fee_numerator: u64,
        reward_fee_denominator: u64,
        reward_fee_recipient: 0x1::option::Option<address>,
        ve_sca_bind: 0x2::table::Table<0x41354112a4df1cd228ea558aaf309700025b36270c743a008b38f514848798fc::typed_id::TypedID<0xb220d034bdf335d77ae5bfbf6daf059c2cc7a1f719b12bfed75d1736fac038c8::ve_sca::VeScaKey>, 0x41354112a4df1cd228ea558aaf309700025b36270c743a008b38f514848798fc::typed_id::TypedID<0xc9f859f98ca352a11b97a038c4b4162bee437b8df8caa047990fe9cb03d4f778::obligation::Obligation>>,
    }

    public fun incentive_pool(arg0: &IncentivePools, arg1: 0x1::type_name::TypeName) : &IncentivePool {
        0x2::table::borrow<0x1::type_name::TypeName, IncentivePool>(&arg0.pools, arg1)
    }

    public(friend) fun accrue_all_points(arg0: &mut IncentivePools, arg1: &0x2::clock::Clock) {
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
        if (arg0.stakes == 0 || arg0.min_stakes > arg0.stakes) {
            update_all_last_updates(arg0, v0);
            return
        };
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::type_name::TypeName>(&arg0.points_list)) {
            let v2 = 0x2::table::borrow_mut<0x1::type_name::TypeName, IncentivePoolPoint>(&mut arg0.points, *0x1::vector::borrow<0x1::type_name::TypeName>(&arg0.points_list, v1));
            let v3 = v0 - v2.last_update;
            let v4 = v3 / v2.point_distribution_time;
            if (v4 == 0) {
                return
            };
            let v5 = 0x2::math::min(v2.distributed_point_per_period * v4, v2.points);
            v2.last_update = v0 - v3 % v2.point_distribution_time;
            v2.distributed_point = v2.distributed_point + v5;
            v2.points = v2.points - v5;
            if (v5 == 0) {
                return
            };
            v2.index = v2.index + 0x41354112a4df1cd228ea558aaf309700025b36270c743a008b38f514848798fc::utils::mul_div(1000000000, v5, v2.weighted_amount);
            v1 = v1 + 1;
        };
    }

    public(friend) fun add_rewards<T0>(arg0: &mut IncentivePools, arg1: 0x1::type_name::TypeName, arg2: 0x2::balance::Balance<T0>) {
        let v0 = 0x2::table::borrow_mut<0x1::type_name::TypeName, 0x2::bag::Bag>(&mut arg0.rewards, arg1);
        let v1 = 0x1::type_name::get<T0>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(v0, v1)) {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(v0, v1), arg2);
        } else {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(v0, v1, arg2);
        };
    }

    public fun base_index_rate() : u64 {
        1000000000
    }

    public fun base_weight(arg0: &IncentivePoolPoint) : u64 {
        arg0.base_weight
    }

    public(friend) fun bind_ve_sca_to_incentive_account(arg0: &mut IncentivePools, arg1: 0x41354112a4df1cd228ea558aaf309700025b36270c743a008b38f514848798fc::typed_id::TypedID<0xb220d034bdf335d77ae5bfbf6daf059c2cc7a1f719b12bfed75d1736fac038c8::ve_sca::VeScaKey>, arg2: 0x41354112a4df1cd228ea558aaf309700025b36270c743a008b38f514848798fc::typed_id::TypedID<0xc9f859f98ca352a11b97a038c4b4162bee437b8df8caa047990fe9cb03d4f778::obligation::Obligation>) {
        0x2::table::add<0x41354112a4df1cd228ea558aaf309700025b36270c743a008b38f514848798fc::typed_id::TypedID<0xb220d034bdf335d77ae5bfbf6daf059c2cc7a1f719b12bfed75d1736fac038c8::ve_sca::VeScaKey>, 0x41354112a4df1cd228ea558aaf309700025b36270c743a008b38f514848798fc::typed_id::TypedID<0xc9f859f98ca352a11b97a038c4b4162bee437b8df8caa047990fe9cb03d4f778::obligation::Obligation>>(&mut arg0.ve_sca_bind, arg1, arg2);
    }

    public(friend) fun claim_rewards<T0>(arg0: &mut IncentivePools, arg1: 0x1::type_name::TypeName, arg2: u64) : (u64, 0x2::balance::Balance<T0>) {
        let v0 = 0x2::math::min(arg2, remaining_rewards<T0>(arg0, arg1));
        (v0, take_rewards<T0>(arg0, arg1, v0))
    }

    public(friend) fun create_incentive_pool_if_not_exist<T0>(arg0: &mut IncentivePools, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::get<T0>();
        if (!0x2::table::contains<0x1::type_name::TypeName, IncentivePool>(&arg0.pools, v0)) {
            let v1 = IncentivePool{
                pool_type   : v0,
                points      : 0x2::table::new<0x1::type_name::TypeName, IncentivePoolPoint>(arg1),
                points_list : 0x1::vector::empty<0x1::type_name::TypeName>(),
                min_stakes  : 0,
                max_stakes  : 0,
                stakes      : 0,
            };
            0x2::table::add<0x1::type_name::TypeName, IncentivePool>(&mut arg0.pools, v0, v1);
            0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg0.pool_types, v0);
            0x2::table::add<0x1::type_name::TypeName, 0x2::bag::Bag>(&mut arg0.rewards, v0, 0x2::bag::new(arg1));
        };
    }

    public(friend) fun create_incentive_pool_point_if_not_exist<T0, T1>(arg0: &mut IncentivePools, arg1: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg1) / 1000;
        let v1 = 0x2::table::borrow_mut<0x1::type_name::TypeName, IncentivePool>(&mut arg0.pools, 0x1::type_name::get<T0>());
        let v2 = 0x1::type_name::get<T1>();
        if (!0x2::table::contains<0x1::type_name::TypeName, IncentivePoolPoint>(&v1.points, v2)) {
            let v3 = IncentivePoolPoint{
                distributed_point_per_period : 0,
                point_distribution_time      : 1,
                distributed_point            : 0,
                points                       : 0,
                base_weight                  : weight_scale(),
                weighted_amount              : 0,
                index                        : 1000000000,
                last_update                  : v0,
                created_at                   : v0,
            };
            0x2::table::add<0x1::type_name::TypeName, IncentivePoolPoint>(&mut v1.points, v2, v3);
            0x1::vector::push_back<0x1::type_name::TypeName>(&mut v1.points_list, v2);
        };
    }

    public(friend) fun create_incentive_pools(arg0: &mut 0x2::tx_context::TxContext) : 0x41354112a4df1cd228ea558aaf309700025b36270c743a008b38f514848798fc::typed_id::TypedID<IncentivePools> {
        let v0 = IncentivePools{
            id                     : 0x2::object::new(arg0),
            pools                  : 0x2::table::new<0x1::type_name::TypeName, IncentivePool>(arg0),
            pool_types             : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
            rewards                : 0x2::table::new<0x1::type_name::TypeName, 0x2::bag::Bag>(arg0),
            reward_fee_numerator   : 0,
            reward_fee_denominator : 1,
            reward_fee_recipient   : 0x1::option::none<address>(),
            ve_sca_bind            : 0x2::table::new<0x41354112a4df1cd228ea558aaf309700025b36270c743a008b38f514848798fc::typed_id::TypedID<0xb220d034bdf335d77ae5bfbf6daf059c2cc7a1f719b12bfed75d1736fac038c8::ve_sca::VeScaKey>, 0x41354112a4df1cd228ea558aaf309700025b36270c743a008b38f514848798fc::typed_id::TypedID<0xc9f859f98ca352a11b97a038c4b4162bee437b8df8caa047990fe9cb03d4f778::obligation::Obligation>>(arg0),
        };
        0x2::transfer::share_object<IncentivePools>(v0);
        0x41354112a4df1cd228ea558aaf309700025b36270c743a008b38f514848798fc::typed_id::new<IncentivePools>(&v0)
    }

    public fun created_at(arg0: &IncentivePoolPoint) : u64 {
        arg0.created_at
    }

    public(friend) fun decrease_weighted_amount(arg0: &mut IncentivePoolPoint, arg1: u64) {
        arg0.weighted_amount = arg0.weighted_amount - arg1;
    }

    public fun distributed_point(arg0: &IncentivePoolPoint) : u64 {
        arg0.distributed_point
    }

    public fun distributed_point_per_period(arg0: &IncentivePoolPoint) : u64 {
        arg0.distributed_point_per_period
    }

    public(friend) fun incentive_pool_mut(arg0: &mut IncentivePools, arg1: 0x1::type_name::TypeName) : &mut IncentivePool {
        0x2::table::borrow_mut<0x1::type_name::TypeName, IncentivePool>(&mut arg0.pools, arg1)
    }

    public(friend) fun increase_weighted_amount(arg0: &mut IncentivePoolPoint, arg1: u64) {
        arg0.weighted_amount = arg0.weighted_amount + arg1;
    }

    public fun index(arg0: &IncentivePoolPoint) : u64 {
        arg0.index
    }

    fun is_every_points_in_a_pool_up_to_date(arg0: &IncentivePool, arg1: &0x2::clock::Clock) : bool {
        let v0 = true;
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::type_name::TypeName>(&arg0.points_list)) {
            let v2 = 0x2::table::borrow<0x1::type_name::TypeName, IncentivePoolPoint>(&arg0.points, *0x1::vector::borrow<0x1::type_name::TypeName>(&arg0.points_list, v1));
            if (!(0x2::clock::timestamp_ms(arg1) / 1000 - v2.last_update < v2.point_distribution_time)) {
                v0 = false;
                break
            };
            v1 = v1 + 1;
        };
        v0
    }

    public fun is_points_up_to_date(arg0: &IncentivePools, arg1: &0x2::clock::Clock) : bool {
        let v0 = true;
        let v1 = 0x2::vec_set::keys<0x1::type_name::TypeName>(&arg0.pool_types);
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(v1)) {
            if (!is_every_points_in_a_pool_up_to_date(0x2::table::borrow<0x1::type_name::TypeName, IncentivePool>(&arg0.pools, *0x1::vector::borrow<0x1::type_name::TypeName>(v1, v2)), arg1)) {
                v0 = false;
                break
            };
            v2 = v2 + 1;
        };
        v0
    }

    public fun is_pool_exist(arg0: &IncentivePools, arg1: 0x1::type_name::TypeName) : bool {
        0x2::table::contains<0x1::type_name::TypeName, IncentivePool>(&arg0.pools, arg1)
    }

    public fun is_reward_fee_recipient_exist(arg0: &IncentivePools) : bool {
        0x1::option::is_some<address>(&arg0.reward_fee_recipient)
    }

    public fun is_ve_sca_binded(arg0: &IncentivePools, arg1: 0x41354112a4df1cd228ea558aaf309700025b36270c743a008b38f514848798fc::typed_id::TypedID<0xb220d034bdf335d77ae5bfbf6daf059c2cc7a1f719b12bfed75d1736fac038c8::ve_sca::VeScaKey>) : bool {
        0x2::table::contains<0x41354112a4df1cd228ea558aaf309700025b36270c743a008b38f514848798fc::typed_id::TypedID<0xb220d034bdf335d77ae5bfbf6daf059c2cc7a1f719b12bfed75d1736fac038c8::ve_sca::VeScaKey>, 0x41354112a4df1cd228ea558aaf309700025b36270c743a008b38f514848798fc::typed_id::TypedID<0xc9f859f98ca352a11b97a038c4b4162bee437b8df8caa047990fe9cb03d4f778::obligation::Obligation>>(&arg0.ve_sca_bind, arg1)
    }

    public fun last_update(arg0: &IncentivePoolPoint) : u64 {
        arg0.last_update
    }

    public fun max_stakes(arg0: &IncentivePool) : u64 {
        arg0.max_stakes
    }

    public fun min_stakes(arg0: &IncentivePool) : u64 {
        arg0.min_stakes
    }

    public fun point_distribution_time(arg0: &IncentivePoolPoint) : u64 {
        arg0.point_distribution_time
    }

    public fun points(arg0: &IncentivePoolPoint) : u64 {
        arg0.points
    }

    public fun points_list(arg0: &IncentivePool) : &vector<0x1::type_name::TypeName> {
        &arg0.points_list
    }

    public fun pool_point(arg0: &IncentivePool, arg1: 0x1::type_name::TypeName) : &IncentivePoolPoint {
        0x2::table::borrow<0x1::type_name::TypeName, IncentivePoolPoint>(&arg0.points, arg1)
    }

    public(friend) fun pool_point_mut(arg0: &mut IncentivePool, arg1: 0x1::type_name::TypeName) : &mut IncentivePoolPoint {
        0x2::table::borrow_mut<0x1::type_name::TypeName, IncentivePoolPoint>(&mut arg0.points, arg1)
    }

    public fun pool_type(arg0: &IncentivePool) : 0x1::type_name::TypeName {
        arg0.pool_type
    }

    public fun pool_types(arg0: &IncentivePools) : 0x2::vec_set::VecSet<0x1::type_name::TypeName> {
        arg0.pool_types
    }

    public fun pools(arg0: &IncentivePools) : &0x2::table::Table<0x1::type_name::TypeName, IncentivePool> {
        &arg0.pools
    }

    public fun remaining_rewards<T0>(arg0: &IncentivePools, arg1: 0x1::type_name::TypeName) : u64 {
        0x2::balance::value<T0>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(0x2::table::borrow<0x1::type_name::TypeName, 0x2::bag::Bag>(&arg0.rewards, arg1), 0x1::type_name::get<T0>()))
    }

    public fun reward_fee(arg0: &IncentivePools) : (u64, u64) {
        (arg0.reward_fee_numerator, arg0.reward_fee_denominator)
    }

    public fun reward_fee_recipient(arg0: &IncentivePools) : address {
        assert!(is_reward_fee_recipient_exist(arg0), 0x41354112a4df1cd228ea558aaf309700025b36270c743a008b38f514848798fc::app_error::reward_fee_recipient_not_exist());
        *0x1::option::borrow<address>(&arg0.reward_fee_recipient)
    }

    public(friend) fun stake(arg0: &mut IncentivePools, arg1: 0x1::type_name::TypeName, arg2: u64) {
        let v0 = 0x2::table::borrow_mut<0x1::type_name::TypeName, IncentivePool>(&mut arg0.pools, arg1);
        assert!(v0.stakes + arg2 <= v0.max_stakes, 1);
        v0.stakes = v0.stakes + arg2;
    }

    public fun stakes(arg0: &IncentivePool) : u64 {
        arg0.stakes
    }

    public(friend) fun take_rewards<T0>(arg0: &mut IncentivePools, arg1: 0x1::type_name::TypeName, arg2: u64) : 0x2::balance::Balance<T0> {
        0x2::balance::split<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(0x2::table::borrow_mut<0x1::type_name::TypeName, 0x2::bag::Bag>(&mut arg0.rewards, arg1), 0x1::type_name::get<T0>()), arg2)
    }

    public(friend) fun unbind_ve_sca_from_incentive_account(arg0: &mut IncentivePools, arg1: 0x41354112a4df1cd228ea558aaf309700025b36270c743a008b38f514848798fc::typed_id::TypedID<0xb220d034bdf335d77ae5bfbf6daf059c2cc7a1f719b12bfed75d1736fac038c8::ve_sca::VeScaKey>, arg2: 0x41354112a4df1cd228ea558aaf309700025b36270c743a008b38f514848798fc::typed_id::TypedID<0xc9f859f98ca352a11b97a038c4b4162bee437b8df8caa047990fe9cb03d4f778::obligation::Obligation>) {
        assert!(0x2::table::remove<0x41354112a4df1cd228ea558aaf309700025b36270c743a008b38f514848798fc::typed_id::TypedID<0xb220d034bdf335d77ae5bfbf6daf059c2cc7a1f719b12bfed75d1736fac038c8::ve_sca::VeScaKey>, 0x41354112a4df1cd228ea558aaf309700025b36270c743a008b38f514848798fc::typed_id::TypedID<0xc9f859f98ca352a11b97a038c4b4162bee437b8df8caa047990fe9cb03d4f778::obligation::Obligation>>(&mut arg0.ve_sca_bind, arg1) == arg2, 2);
    }

    public(friend) fun unstake(arg0: &mut IncentivePools, arg1: 0x1::type_name::TypeName, arg2: u64) {
        let v0 = 0x2::table::borrow_mut<0x1::type_name::TypeName, IncentivePool>(&mut arg0.pools, arg1);
        v0.stakes = v0.stakes - arg2;
    }

    fun update_all_last_updates(arg0: &mut IncentivePool, arg1: u64) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x1::type_name::TypeName>(&arg0.points_list)) {
            0x2::table::borrow_mut<0x1::type_name::TypeName, IncentivePoolPoint>(&mut arg0.points, *0x1::vector::borrow<0x1::type_name::TypeName>(&arg0.points_list, v0)).last_update = arg1;
            v0 = v0 + 1;
        };
    }

    public(friend) fun update_incentive_pool_params<T0>(arg0: &mut IncentivePools, arg1: u64, arg2: u64) {
        let v0 = 0x2::table::borrow_mut<0x1::type_name::TypeName, IncentivePool>(&mut arg0.pools, 0x1::type_name::get<T0>());
        v0.min_stakes = arg1;
        v0.max_stakes = arg2;
    }

    public(friend) fun update_incentive_pool_point<T0, T1>(arg0: &mut IncentivePools, arg1: u64, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = 0x2::table::borrow_mut<0x1::type_name::TypeName, IncentivePool>(&mut arg0.pools, 0x1::type_name::get<T0>());
        update_pool_point(v0, 0x1::type_name::get<T1>(), arg2, arg1, arg3, arg4);
    }

    fun update_pool_point(arg0: &mut IncentivePool, arg1: 0x1::type_name::TypeName, arg2: u64, arg3: u64, arg4: u64, arg5: u64) {
        let v0 = 0x2::table::borrow_mut<0x1::type_name::TypeName, IncentivePoolPoint>(&mut arg0.points, arg1);
        v0.point_distribution_time = arg2;
        v0.points = arg5;
        v0.base_weight = arg4;
        v0.distributed_point_per_period = arg3;
    }

    public(friend) fun update_reward_fee(arg0: &mut IncentivePools, arg1: u64, arg2: u64, arg3: address) {
        arg0.reward_fee_numerator = arg1;
        arg0.reward_fee_denominator = arg2;
        arg0.reward_fee_recipient = 0x1::option::some<address>(arg3);
    }

    public fun weight_scale() : u64 {
        1000000000000
    }

    public fun weighted_amount(arg0: &IncentivePoolPoint) : u64 {
        arg0.weighted_amount
    }

    // decompiled from Move bytecode v6
}

