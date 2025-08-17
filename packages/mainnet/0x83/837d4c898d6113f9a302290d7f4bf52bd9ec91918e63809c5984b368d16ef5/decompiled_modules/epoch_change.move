module 0x83837d4c898d6113f9a302290d7f4bf52bd9ec91918e63809c5984b368d16ef5::epoch_change {
    struct InitializeEpochRewardEvent has copy, drop, store {
        pool_id: address,
        gauge_id: address,
        start_at: u64,
        ends_at: u64,
        balance: u64,
    }

    struct UpdateEpochRewardEvent has copy, drop, store {
        pool_id: address,
        gauge_id: address,
        last_end_at: u64,
        new_end_at: u64,
        balance: u64,
    }

    public fun initialize_epoch_reward<T0, T1>(arg0: &mut 0x83837d4c898d6113f9a302290d7f4bf52bd9ec91918e63809c5984b368d16ef5::ve_mmt::VeMMT, arg1: &mut 0x38747d8471b55cfdd72ba8331877392bdb5416e241d3103f1836409faa1301ba::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<0x83837d4c898d6113f9a302290d7f4bf52bd9ec91918e63809c5984b368d16ef5::mmt::MMT>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0x38747d8471b55cfdd72ba8331877392bdb5416e241d3103f1836409faa1301ba::version::Version, arg7: &0x2::tx_context::TxContext) {
        0x83837d4c898d6113f9a302290d7f4bf52bd9ec91918e63809c5984b368d16ef5::ve_mmt::assert_supported_version(arg0);
        0x83837d4c898d6113f9a302290d7f4bf52bd9ec91918e63809c5984b368d16ef5::ve_mmt::assert_gauge_operator(arg0, arg7);
        let (_, _, v2, v3) = 0x83837d4c898d6113f9a302290d7f4bf52bd9ec91918e63809c5984b368d16ef5::ve_mmt::gauge_fields(arg0);
        let (_, _) = 0x38747d8471b55cfdd72ba8331877392bdb5416e241d3103f1836409faa1301ba::ve::initialize_pool_reward_with_cap<T0, T1, 0x83837d4c898d6113f9a302290d7f4bf52bd9ec91918e63809c5984b368d16ef5::mmt::MMT>(arg1, v3, arg3, arg4, arg2, arg5, arg6, arg7);
        let v6 = 0x38747d8471b55cfdd72ba8331877392bdb5416e241d3103f1836409faa1301ba::pool::pool_id<T0, T1>(arg1);
        let v7 = 0x2::object::id_to_address(&v6);
        let v8 = InitializeEpochRewardEvent{
            pool_id  : v7,
            gauge_id : 0x83837d4c898d6113f9a302290d7f4bf52bd9ec91918e63809c5984b368d16ef5::gauge::gauge_id(0x83837d4c898d6113f9a302290d7f4bf52bd9ec91918e63809c5984b368d16ef5::gauge_globals::get_gauge_by_pool_id(v2, &v7)),
            start_at : arg3,
            ends_at  : arg3 + arg4,
            balance  : 0x2::balance::value<0x83837d4c898d6113f9a302290d7f4bf52bd9ec91918e63809c5984b368d16ef5::mmt::MMT>(&arg2),
        };
        0x83837d4c898d6113f9a302290d7f4bf52bd9ec91918e63809c5984b368d16ef5::event::emit<InitializeEpochRewardEvent>(v8);
    }

    public fun update_epoch_reward<T0, T1>(arg0: &mut 0x83837d4c898d6113f9a302290d7f4bf52bd9ec91918e63809c5984b368d16ef5::ve_mmt::VeMMT, arg1: &mut 0x38747d8471b55cfdd72ba8331877392bdb5416e241d3103f1836409faa1301ba::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<0x83837d4c898d6113f9a302290d7f4bf52bd9ec91918e63809c5984b368d16ef5::mmt::MMT>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x38747d8471b55cfdd72ba8331877392bdb5416e241d3103f1836409faa1301ba::version::Version, arg6: &0x2::tx_context::TxContext) {
        0x83837d4c898d6113f9a302290d7f4bf52bd9ec91918e63809c5984b368d16ef5::ve_mmt::assert_supported_version(arg0);
        0x83837d4c898d6113f9a302290d7f4bf52bd9ec91918e63809c5984b368d16ef5::ve_mmt::assert_gauge_operator(arg0, arg6);
        let (_, _, v2, v3) = 0x83837d4c898d6113f9a302290d7f4bf52bd9ec91918e63809c5984b368d16ef5::ve_mmt::gauge_fields(arg0);
        let (v4, v5) = 0x38747d8471b55cfdd72ba8331877392bdb5416e241d3103f1836409faa1301ba::ve::update_pool_reward_emission_with_cap<T0, T1, 0x83837d4c898d6113f9a302290d7f4bf52bd9ec91918e63809c5984b368d16ef5::mmt::MMT>(v3, arg1, arg2, arg3, arg4, arg5, arg6);
        let v6 = 0x38747d8471b55cfdd72ba8331877392bdb5416e241d3103f1836409faa1301ba::pool::pool_id<T0, T1>(arg1);
        let v7 = 0x2::object::id_to_address(&v6);
        let v8 = UpdateEpochRewardEvent{
            pool_id     : v7,
            gauge_id    : 0x83837d4c898d6113f9a302290d7f4bf52bd9ec91918e63809c5984b368d16ef5::gauge::gauge_id(0x83837d4c898d6113f9a302290d7f4bf52bd9ec91918e63809c5984b368d16ef5::gauge_globals::get_gauge_by_pool_id(v2, &v7)),
            last_end_at : v4,
            new_end_at  : v5,
            balance     : 0x2::balance::value<0x83837d4c898d6113f9a302290d7f4bf52bd9ec91918e63809c5984b368d16ef5::mmt::MMT>(&arg2),
        };
        0x83837d4c898d6113f9a302290d7f4bf52bd9ec91918e63809c5984b368d16ef5::event::emit<UpdateEpochRewardEvent>(v8);
    }

    // decompiled from Move bytecode v6
}

