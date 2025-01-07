module 0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::spool {
    struct Spool has store, key {
        id: 0x2::object::UID,
        stake_type: 0x1::type_name::TypeName,
        points: 0x2::table::Table<0x1::type_name::TypeName, SpoolPoint>,
        points_list: vector<0x1::type_name::TypeName>,
        ve_sca_bind: 0x2::table::Table<0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::typed_id::TypedID<0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca::VeScaKey>, 0x2::object::ID>,
        stakes: u64,
        min_stakes: u64,
        max_stakes: u64,
        rewards: 0x2::bag::Bag,
        reward_fee_numerator: u64,
        reward_fee_denominator: u64,
        reward_fee_recipient: 0x1::option::Option<address>,
    }

    struct SpoolPoint has store {
        distributed_point_per_period: u64,
        point_distribution_time: u64,
        distributed_point: u64,
        points: u64,
        base_weight: u64,
        index: u64,
        weighted_amount: u64,
        last_update: u64,
    }

    public(friend) fun new<T0>(arg0: u64, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : Spool {
        Spool{
            id                     : 0x2::object::new(arg2),
            stake_type             : 0x1::type_name::get<T0>(),
            points                 : 0x2::table::new<0x1::type_name::TypeName, SpoolPoint>(arg2),
            points_list            : 0x1::vector::empty<0x1::type_name::TypeName>(),
            ve_sca_bind            : 0x2::table::new<0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::typed_id::TypedID<0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca::VeScaKey>, 0x2::object::ID>(arg2),
            stakes                 : 0,
            min_stakes             : arg0,
            max_stakes             : arg1,
            rewards                : 0x2::bag::new(arg2),
            reward_fee_numerator   : 0,
            reward_fee_denominator : 1,
            reward_fee_recipient   : 0x1::option::none<address>(),
        }
    }

    public(friend) fun accrue_points(arg0: &mut Spool, arg1: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg1) / 1000;
        if (arg0.stakes == 0) {
            update_all_last_updates(arg0, v0);
            return
        };
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::type_name::TypeName>(&arg0.points_list)) {
            let v2 = 0x2::table::borrow_mut<0x1::type_name::TypeName, SpoolPoint>(&mut arg0.points, *0x1::vector::borrow<0x1::type_name::TypeName>(&arg0.points_list, v1));
            let v3 = v0 - v2.last_update;
            let v4 = v3 / v2.point_distribution_time;
            if (v4 == 0) {
                v1 = v1 + 1;
                continue
            };
            let v5 = 0x2::math::min(v2.distributed_point_per_period * v4, v2.points);
            v2.last_update = v0 - v3 % v2.point_distribution_time;
            if (v5 == 0 || v2.weighted_amount < arg0.min_stakes) {
                v1 = v1 + 1;
                continue
            };
            v2.distributed_point = v2.distributed_point + v5;
            v2.points = v2.points - v5;
            v2.index = v2.index + 0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::utils::mul_div(1000000000, v5, v2.weighted_amount);
            v1 = v1 + 1;
        };
    }

    public(friend) fun add_reward<T0>(arg0: &mut Spool, arg1: 0x2::balance::Balance<T0>) {
        0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.rewards, 0x1::type_name::get<T0>()), arg1);
    }

    public(friend) fun add_weighted_amount(arg0: &mut Spool, arg1: 0x1::type_name::TypeName, arg2: u64) {
        let v0 = 0x2::table::borrow_mut<0x1::type_name::TypeName, SpoolPoint>(&mut arg0.points, arg1);
        v0.weighted_amount = v0.weighted_amount + arg2;
    }

    public fun base_index_rate() : u64 {
        1000000000
    }

    public fun base_weight(arg0: &SpoolPoint) : u64 {
        arg0.base_weight
    }

    public(friend) fun bind_ve_sca_to_spool_account(arg0: &mut Spool, arg1: 0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::typed_id::TypedID<0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca::VeScaKey>, arg2: 0x2::object::ID) {
        0x2::table::add<0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::typed_id::TypedID<0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca::VeScaKey>, 0x2::object::ID>(&mut arg0.ve_sca_bind, arg1, arg2);
    }

    public(friend) fun create_spool_point_if_not_exist<T0>(arg0: &mut Spool, arg1: &0x2::clock::Clock) {
        let v0 = 0x1::type_name::get<T0>();
        if (!0x2::table::contains<0x1::type_name::TypeName, SpoolPoint>(&arg0.points, v0)) {
            let v1 = SpoolPoint{
                distributed_point_per_period : 0,
                point_distribution_time      : 1,
                distributed_point            : 0,
                points                       : 0,
                base_weight                  : weight_scale(),
                index                        : 1000000000,
                weighted_amount              : 0,
                last_update                  : 0x2::clock::timestamp_ms(arg1) / 1000,
            };
            0x2::table::add<0x1::type_name::TypeName, SpoolPoint>(&mut arg0.points, v0, v1);
            0x1::vector::push_back<0x1::type_name::TypeName>(&mut arg0.points_list, v0);
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.rewards, v0, 0x2::balance::zero<T0>());
        };
    }

    public(friend) fun deduct_weighted_amount(arg0: &mut Spool, arg1: 0x1::type_name::TypeName, arg2: u64) {
        let v0 = 0x2::table::borrow_mut<0x1::type_name::TypeName, SpoolPoint>(&mut arg0.points, arg1);
        v0.weighted_amount = v0.weighted_amount - arg2;
    }

    public fun distributed_point_per_period(arg0: &SpoolPoint) : u64 {
        arg0.distributed_point_per_period
    }

    public fun index(arg0: &SpoolPoint) : u64 {
        arg0.index
    }

    public fun is_points_up_to_date(arg0: &Spool, arg1: &0x2::clock::Clock) : bool {
        let v0 = true;
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::type_name::TypeName>(&arg0.points_list)) {
            let v2 = 0x2::table::borrow<0x1::type_name::TypeName, SpoolPoint>(&arg0.points, *0x1::vector::borrow<0x1::type_name::TypeName>(&arg0.points_list, v1));
            if (0x2::clock::timestamp_ms(arg1) / 1000 - v2.last_update >= v2.point_distribution_time) {
                v0 = false;
            };
            v1 = v1 + 1;
        };
        v0
    }

    public fun is_ve_sca_binded(arg0: &Spool, arg1: 0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::typed_id::TypedID<0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca::VeScaKey>) : bool {
        0x2::table::contains<0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::typed_id::TypedID<0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca::VeScaKey>, 0x2::object::ID>(&arg0.ve_sca_bind, arg1)
    }

    public fun last_update(arg0: &SpoolPoint) : u64 {
        arg0.last_update
    }

    public fun max_stakes(arg0: &Spool) : u64 {
        arg0.max_stakes
    }

    public fun point_distribution_time(arg0: &SpoolPoint) : u64 {
        arg0.point_distribution_time
    }

    public fun points(arg0: &SpoolPoint) : u64 {
        arg0.points
    }

    public fun points_list(arg0: &Spool) : &vector<0x1::type_name::TypeName> {
        &arg0.points_list
    }

    public fun remaining_reward<T0>(arg0: &Spool) : u64 {
        0x2::balance::value<T0>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.rewards, 0x1::type_name::get<T0>()))
    }

    public fun reward_fee(arg0: &Spool) : (u64, u64) {
        (arg0.reward_fee_numerator, arg0.reward_fee_denominator)
    }

    public fun reward_fee_recipient(arg0: &Spool) : address {
        *0x1::option::borrow<address>(&arg0.reward_fee_recipient)
    }

    public fun spool_point(arg0: &Spool, arg1: 0x1::type_name::TypeName) : &SpoolPoint {
        0x2::table::borrow<0x1::type_name::TypeName, SpoolPoint>(&arg0.points, arg1)
    }

    public(friend) fun stake(arg0: &mut Spool, arg1: u64) {
        arg0.stakes = arg0.stakes + arg1;
    }

    public fun stake_type(arg0: &Spool) : 0x1::type_name::TypeName {
        arg0.stake_type
    }

    public fun stakes(arg0: &Spool) : u64 {
        arg0.stakes
    }

    public(friend) fun take_reward<T0>(arg0: &mut Spool, arg1: u64) : 0x2::balance::Balance<T0> {
        0x2::balance::split<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.rewards, 0x1::type_name::get<T0>()), arg1)
    }

    public(friend) fun unbind_ve_sca_from_spool_account(arg0: &mut Spool, arg1: 0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::typed_id::TypedID<0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca::VeScaKey>, arg2: 0x2::object::ID) {
        assert!(0x2::table::remove<0x9d082b33f11d6257bee6f9c3de6daa666a8e9fb44dcb9b6e4bdbff5dc8fa234::typed_id::TypedID<0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca::VeScaKey>, 0x2::object::ID>(&mut arg0.ve_sca_bind, arg1) == arg2, 1);
    }

    public(friend) fun unstake(arg0: &mut Spool, arg1: u64) {
        arg0.stakes = arg0.stakes - arg1;
    }

    fun update_all_last_updates(arg0: &mut Spool, arg1: u64) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x1::type_name::TypeName>(&arg0.points_list)) {
            0x2::table::borrow_mut<0x1::type_name::TypeName, SpoolPoint>(&mut arg0.points, *0x1::vector::borrow<0x1::type_name::TypeName>(&arg0.points_list, v0)).last_update = arg1;
            v0 = v0 + 1;
        };
    }

    public(friend) fun update_point(arg0: &mut Spool, arg1: 0x1::type_name::TypeName, arg2: u64, arg3: u64, arg4: u64, arg5: u64) {
        let v0 = 0x2::table::borrow_mut<0x1::type_name::TypeName, SpoolPoint>(&mut arg0.points, arg1);
        v0.base_weight = arg2;
        v0.distributed_point_per_period = arg4;
        v0.point_distribution_time = arg3;
        v0.points = arg5;
    }

    public(friend) fun update_reward_fee(arg0: &mut Spool, arg1: u64, arg2: u64, arg3: address) {
        arg0.reward_fee_numerator = arg1;
        arg0.reward_fee_denominator = arg2;
        arg0.reward_fee_recipient = 0x1::option::some<address>(arg3);
    }

    public(friend) fun update_spool_params(arg0: &mut Spool, arg1: u64, arg2: u64) {
        arg0.min_stakes = arg1;
        arg0.max_stakes = arg2;
    }

    public fun weight_scale() : u64 {
        1000000000000
    }

    public fun weighted_amount(arg0: &SpoolPoint) : u64 {
        arg0.weighted_amount
    }

    // decompiled from Move bytecode v6
}

