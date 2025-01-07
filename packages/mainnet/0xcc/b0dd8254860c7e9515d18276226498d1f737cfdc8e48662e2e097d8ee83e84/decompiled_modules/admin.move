module 0xccb0dd8254860c7e9515d18276226498d1f737cfdc8e48662e2e097d8ee83e84::admin {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct CreateSpoolEvent has copy, drop {
        spool_id: 0x2::object::ID,
        staking_type: 0x1::type_name::TypeName,
        distributed_point_per_period: u64,
        point_distribution_time: u64,
        max_distributed_point: u64,
        max_stakes: u64,
        created_at: u64,
    }

    struct UpdateSpoolConfigEvent has copy, drop {
        spool_id: 0x2::object::ID,
        distributed_point_per_period: u64,
        point_distribution_time: u64,
        max_distributed_point: u64,
        max_stakes: u64,
        updated_at: u64,
    }

    public entry fun add_rewards<T0>(arg0: &mut 0xccb0dd8254860c7e9515d18276226498d1f737cfdc8e48662e2e097d8ee83e84::rewards_pool::RewardsPool<T0>, arg1: 0x2::coin::Coin<T0>) {
        0xccb0dd8254860c7e9515d18276226498d1f737cfdc8e48662e2e097d8ee83e84::rewards_pool::add_rewards<T0>(arg0, 0x2::coin::into_balance<T0>(arg1));
    }

    public entry fun create_rewards_pool<T0>(arg0: &AdminCap, arg1: &0xccb0dd8254860c7e9515d18276226498d1f737cfdc8e48662e2e097d8ee83e84::spool::Spool, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_share_object<0xccb0dd8254860c7e9515d18276226498d1f737cfdc8e48662e2e097d8ee83e84::rewards_pool::RewardsPool<T0>>(0xccb0dd8254860c7e9515d18276226498d1f737cfdc8e48662e2e097d8ee83e84::rewards_pool::new<T0>(arg1, arg2, arg3, arg4));
    }

    public entry fun create_spool<T0>(arg0: &AdminCap, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xccb0dd8254860c7e9515d18276226498d1f737cfdc8e48662e2e097d8ee83e84::spool::new<T0>(arg1, arg2, arg3, arg4, arg5, arg6);
        let v1 = CreateSpoolEvent{
            spool_id                     : 0x2::object::id<0xccb0dd8254860c7e9515d18276226498d1f737cfdc8e48662e2e097d8ee83e84::spool::Spool>(&v0),
            staking_type                 : 0x1::type_name::get<T0>(),
            distributed_point_per_period : arg1,
            point_distribution_time      : arg2,
            max_distributed_point        : arg3,
            max_stakes                   : arg4,
            created_at                   : 0x2::clock::timestamp_ms(arg5) / 1000,
        };
        0x2::event::emit<CreateSpoolEvent>(v1);
        0x2::transfer::public_share_object<0xccb0dd8254860c7e9515d18276226498d1f737cfdc8e48662e2e097d8ee83e84::spool::Spool>(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun take_rewards<T0>(arg0: &AdminCap, arg1: &mut 0xccb0dd8254860c7e9515d18276226498d1f737cfdc8e48662e2e097d8ee83e84::rewards_pool::RewardsPool<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::from_balance<T0>(0xccb0dd8254860c7e9515d18276226498d1f737cfdc8e48662e2e097d8ee83e84::rewards_pool::take_rewards<T0>(arg1, arg2), arg3)
    }

    public entry fun update_spool_config(arg0: &AdminCap, arg1: &mut 0xccb0dd8254860c7e9515d18276226498d1f737cfdc8e48662e2e097d8ee83e84::spool::Spool, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock) {
        0xccb0dd8254860c7e9515d18276226498d1f737cfdc8e48662e2e097d8ee83e84::spool::accrue_points(arg1, arg6);
        0xccb0dd8254860c7e9515d18276226498d1f737cfdc8e48662e2e097d8ee83e84::spool::update_config(arg1, arg2, arg3, arg4, arg5);
        let v0 = UpdateSpoolConfigEvent{
            spool_id                     : 0x2::object::id<0xccb0dd8254860c7e9515d18276226498d1f737cfdc8e48662e2e097d8ee83e84::spool::Spool>(arg1),
            distributed_point_per_period : arg2,
            point_distribution_time      : arg3,
            max_distributed_point        : arg4,
            max_stakes                   : arg5,
            updated_at                   : 0x2::clock::timestamp_ms(arg6) / 1000,
        };
        0x2::event::emit<UpdateSpoolConfigEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

