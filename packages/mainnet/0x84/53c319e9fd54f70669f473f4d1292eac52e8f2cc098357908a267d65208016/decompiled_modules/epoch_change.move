module 0x8453c319e9fd54f70669f473f4d1292eac52e8f2cc098357908a267d65208016::epoch_change {
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

    public fun initialize_epoch_reward<T0, T1>(arg0: &mut 0x8453c319e9fd54f70669f473f4d1292eac52e8f2cc098357908a267d65208016::ve_mmt::VeMMT, arg1: &mut 0x61fabbf6309d124a060daef146c02f84302921312718ea689306ff6ace670970::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<0x8453c319e9fd54f70669f473f4d1292eac52e8f2cc098357908a267d65208016::mmt::MMT>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0x61fabbf6309d124a060daef146c02f84302921312718ea689306ff6ace670970::version::Version, arg7: &0x2::tx_context::TxContext) {
        0x8453c319e9fd54f70669f473f4d1292eac52e8f2cc098357908a267d65208016::ve_mmt::assert_supported_version(arg0);
        0x8453c319e9fd54f70669f473f4d1292eac52e8f2cc098357908a267d65208016::ve_mmt::assert_gauge_operator(arg0, arg7);
        let (_, _, v2, v3) = 0x8453c319e9fd54f70669f473f4d1292eac52e8f2cc098357908a267d65208016::ve_mmt::gauge_fields(arg0);
        let (_, _) = 0x61fabbf6309d124a060daef146c02f84302921312718ea689306ff6ace670970::admin::initialize_pool_reward_with_cap<T0, T1, 0x8453c319e9fd54f70669f473f4d1292eac52e8f2cc098357908a267d65208016::mmt::MMT>(v3, arg1, arg3, arg4, arg2, arg5, arg6, arg7);
        let v6 = 0x61fabbf6309d124a060daef146c02f84302921312718ea689306ff6ace670970::pool::pool_id<T0, T1>(arg1);
        let v7 = 0x2::object::id_to_address(&v6);
        let v8 = InitializeEpochRewardEvent{
            pool_id  : v7,
            gauge_id : 0x8453c319e9fd54f70669f473f4d1292eac52e8f2cc098357908a267d65208016::gauge::gauge_id(0x8453c319e9fd54f70669f473f4d1292eac52e8f2cc098357908a267d65208016::gauge_globals::get_gauge_by_pool_id(v2, &v7)),
            start_at : arg3,
            ends_at  : arg3 + arg4,
            balance  : 0x2::balance::value<0x8453c319e9fd54f70669f473f4d1292eac52e8f2cc098357908a267d65208016::mmt::MMT>(&arg2),
        };
        0x8453c319e9fd54f70669f473f4d1292eac52e8f2cc098357908a267d65208016::event::emit<InitializeEpochRewardEvent>(v8);
    }

    public fun update_epoch_reward<T0, T1>(arg0: &mut 0x8453c319e9fd54f70669f473f4d1292eac52e8f2cc098357908a267d65208016::ve_mmt::VeMMT, arg1: &mut 0x61fabbf6309d124a060daef146c02f84302921312718ea689306ff6ace670970::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<0x8453c319e9fd54f70669f473f4d1292eac52e8f2cc098357908a267d65208016::mmt::MMT>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x61fabbf6309d124a060daef146c02f84302921312718ea689306ff6ace670970::version::Version, arg6: &0x2::tx_context::TxContext) {
        0x8453c319e9fd54f70669f473f4d1292eac52e8f2cc098357908a267d65208016::ve_mmt::assert_supported_version(arg0);
        0x8453c319e9fd54f70669f473f4d1292eac52e8f2cc098357908a267d65208016::ve_mmt::assert_gauge_operator(arg0, arg6);
        let (_, _, v2, v3) = 0x8453c319e9fd54f70669f473f4d1292eac52e8f2cc098357908a267d65208016::ve_mmt::gauge_fields(arg0);
        let (v4, v5) = 0x61fabbf6309d124a060daef146c02f84302921312718ea689306ff6ace670970::admin::update_pool_reward_emission_with_cap<T0, T1, 0x8453c319e9fd54f70669f473f4d1292eac52e8f2cc098357908a267d65208016::mmt::MMT>(v3, arg1, arg2, arg3, arg4, arg5, arg6);
        let v6 = 0x61fabbf6309d124a060daef146c02f84302921312718ea689306ff6ace670970::pool::pool_id<T0, T1>(arg1);
        let v7 = 0x2::object::id_to_address(&v6);
        let v8 = UpdateEpochRewardEvent{
            pool_id     : v7,
            gauge_id    : 0x8453c319e9fd54f70669f473f4d1292eac52e8f2cc098357908a267d65208016::gauge::gauge_id(0x8453c319e9fd54f70669f473f4d1292eac52e8f2cc098357908a267d65208016::gauge_globals::get_gauge_by_pool_id(v2, &v7)),
            last_end_at : v4,
            new_end_at  : v5,
            balance     : 0x2::balance::value<0x8453c319e9fd54f70669f473f4d1292eac52e8f2cc098357908a267d65208016::mmt::MMT>(&arg2),
        };
        0x8453c319e9fd54f70669f473f4d1292eac52e8f2cc098357908a267d65208016::event::emit<UpdateEpochRewardEvent>(v8);
    }

    // decompiled from Move bytecode v6
}

