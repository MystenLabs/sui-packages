module 0xcbc92f35a2ee5f589a6e0090c9b55b9cc9b02ab9670d15b8b116da0f815bfbd2::admin {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct FarmCreatedEvent has copy, drop, store {
        farm_id: 0x2::object::ID,
        base_token_type: 0x1::type_name::TypeName,
    }

    struct RewardsUpdatedEvent has copy, drop, store {
        farm_id: 0x2::object::ID,
        reward_token_type: 0x1::type_name::TypeName,
        rewards_per_sec: u64,
        is_claimable: bool,
    }

    public fun add_reward<T0, T1>(arg0: &AdminCap, arg1: &mut 0xcbc92f35a2ee5f589a6e0090c9b55b9cc9b02ab9670d15b8b116da0f815bfbd2::farm::Farm<T0>, arg2: 0x2::balance::Balance<T1>, arg3: u64, arg4: bool, arg5: &0xcbc92f35a2ee5f589a6e0090c9b55b9cc9b02ab9670d15b8b116da0f815bfbd2::version::Version, arg6: &0x2::clock::Clock) {
        0xcbc92f35a2ee5f589a6e0090c9b55b9cc9b02ab9670d15b8b116da0f815bfbd2::version::assert_supported_version(arg5);
        0xcbc92f35a2ee5f589a6e0090c9b55b9cc9b02ab9670d15b8b116da0f815bfbd2::farm::add_reward<T0, T1>(arg1, arg2, arg3, arg4, arg6);
        let v0 = RewardsUpdatedEvent{
            farm_id           : 0x2::object::id<0xcbc92f35a2ee5f589a6e0090c9b55b9cc9b02ab9670d15b8b116da0f815bfbd2::farm::Farm<T0>>(arg1),
            reward_token_type : 0x1::type_name::get<T1>(),
            rewards_per_sec   : arg3,
            is_claimable      : arg4,
        };
        0x2::event::emit<RewardsUpdatedEvent>(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun initialize_farm<T0>(arg0: &AdminCap, arg1: &0xcbc92f35a2ee5f589a6e0090c9b55b9cc9b02ab9670d15b8b116da0f815bfbd2::version::Version, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0xcbc92f35a2ee5f589a6e0090c9b55b9cc9b02ab9670d15b8b116da0f815bfbd2::version::assert_supported_version(arg1);
        let v0 = 0xcbc92f35a2ee5f589a6e0090c9b55b9cc9b02ab9670d15b8b116da0f815bfbd2::farm::initialize<T0>(arg2, arg3);
        let v1 = FarmCreatedEvent{
            farm_id         : 0x2::object::id<0xcbc92f35a2ee5f589a6e0090c9b55b9cc9b02ab9670d15b8b116da0f815bfbd2::farm::Farm<T0>>(&v0),
            base_token_type : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<FarmCreatedEvent>(v1);
        0x2::transfer::public_share_object<0xcbc92f35a2ee5f589a6e0090c9b55b9cc9b02ab9670d15b8b116da0f815bfbd2::farm::Farm<T0>>(v0);
    }

    public fun initialize_farm_with_return<T0>(arg0: &AdminCap, arg1: &0xcbc92f35a2ee5f589a6e0090c9b55b9cc9b02ab9670d15b8b116da0f815bfbd2::version::Version, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0xcbc92f35a2ee5f589a6e0090c9b55b9cc9b02ab9670d15b8b116da0f815bfbd2::farm::Farm<T0> {
        0xcbc92f35a2ee5f589a6e0090c9b55b9cc9b02ab9670d15b8b116da0f815bfbd2::version::assert_supported_version(arg1);
        let v0 = 0xcbc92f35a2ee5f589a6e0090c9b55b9cc9b02ab9670d15b8b116da0f815bfbd2::farm::initialize<T0>(arg2, arg3);
        let v1 = FarmCreatedEvent{
            farm_id         : 0x2::object::id<0xcbc92f35a2ee5f589a6e0090c9b55b9cc9b02ab9670d15b8b116da0f815bfbd2::farm::Farm<T0>>(&v0),
            base_token_type : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<FarmCreatedEvent>(v1);
        v0
    }

    public fun update_reward<T0, T1>(arg0: &AdminCap, arg1: &mut 0xcbc92f35a2ee5f589a6e0090c9b55b9cc9b02ab9670d15b8b116da0f815bfbd2::farm::Farm<T0>, arg2: 0x2::balance::Balance<T1>, arg3: u64, arg4: bool, arg5: &0xcbc92f35a2ee5f589a6e0090c9b55b9cc9b02ab9670d15b8b116da0f815bfbd2::version::Version, arg6: &0x2::clock::Clock) {
        0xcbc92f35a2ee5f589a6e0090c9b55b9cc9b02ab9670d15b8b116da0f815bfbd2::version::assert_supported_version(arg5);
        0xcbc92f35a2ee5f589a6e0090c9b55b9cc9b02ab9670d15b8b116da0f815bfbd2::farm::update_reward<T0, T1>(arg1, arg2, arg3, arg4, arg6);
        let v0 = RewardsUpdatedEvent{
            farm_id           : 0x2::object::id<0xcbc92f35a2ee5f589a6e0090c9b55b9cc9b02ab9670d15b8b116da0f815bfbd2::farm::Farm<T0>>(arg1),
            reward_token_type : 0x1::type_name::get<T1>(),
            rewards_per_sec   : arg3,
            is_claimable      : arg4,
        };
        0x2::event::emit<RewardsUpdatedEvent>(v0);
    }

    public fun withdraw_unharvested<T0, T1>(arg0: &AdminCap, arg1: &mut 0xcbc92f35a2ee5f589a6e0090c9b55b9cc9b02ab9670d15b8b116da0f815bfbd2::farm::Farm<T0>, arg2: &0xcbc92f35a2ee5f589a6e0090c9b55b9cc9b02ab9670d15b8b116da0f815bfbd2::version::Version, arg3: &0x2::clock::Clock) : 0x2::balance::Balance<T1> {
        0xcbc92f35a2ee5f589a6e0090c9b55b9cc9b02ab9670d15b8b116da0f815bfbd2::version::assert_supported_version(arg2);
        0xcbc92f35a2ee5f589a6e0090c9b55b9cc9b02ab9670d15b8b116da0f815bfbd2::farm::withdraw_unharvested<T0, T1>(arg1, arg3)
    }

    // decompiled from Move bytecode v6
}

