module 0x9721b245ae60522bb1124048c0cdedbaeb72a631a8041b0fbe1fa68ad2f4d5fe::ve {
    public fun collect_protocol_fee_with_cap<T0, T1>(arg0: &mut 0x9721b245ae60522bb1124048c0cdedbaeb72a631a8041b0fbe1fa68ad2f4d5fe::pool::Pool<T0, T1>, arg1: &0x9721b245ae60522bb1124048c0cdedbaeb72a631a8041b0fbe1fa68ad2f4d5fe::app::VeCap, arg2: u64, arg3: u64, arg4: &0x9721b245ae60522bb1124048c0cdedbaeb72a631a8041b0fbe1fa68ad2f4d5fe::version::Version, arg5: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        0x9721b245ae60522bb1124048c0cdedbaeb72a631a8041b0fbe1fa68ad2f4d5fe::version::assert_supported_version(arg4);
        0x9721b245ae60522bb1124048c0cdedbaeb72a631a8041b0fbe1fa68ad2f4d5fe::pool::assert_not_pause<T0, T1>(arg0);
        0x9721b245ae60522bb1124048c0cdedbaeb72a631a8041b0fbe1fa68ad2f4d5fe::admin::collect_protocol_fees_<T0, T1>(arg0, arg2, arg3, arg5)
    }

    public fun initialize_pool_reward_with_cap<T0, T1, T2>(arg0: &mut 0x9721b245ae60522bb1124048c0cdedbaeb72a631a8041b0fbe1fa68ad2f4d5fe::pool::Pool<T0, T1>, arg1: &0x9721b245ae60522bb1124048c0cdedbaeb72a631a8041b0fbe1fa68ad2f4d5fe::app::VeCap, arg2: u64, arg3: u64, arg4: 0x2::balance::Balance<T2>, arg5: &0x2::clock::Clock, arg6: &0x9721b245ae60522bb1124048c0cdedbaeb72a631a8041b0fbe1fa68ad2f4d5fe::version::Version, arg7: &0x2::tx_context::TxContext) : (u64, u64) {
        0x9721b245ae60522bb1124048c0cdedbaeb72a631a8041b0fbe1fa68ad2f4d5fe::version::assert_supported_version(arg6);
        0x9721b245ae60522bb1124048c0cdedbaeb72a631a8041b0fbe1fa68ad2f4d5fe::pool::assert_not_pause<T0, T1>(arg0);
        0x9721b245ae60522bb1124048c0cdedbaeb72a631a8041b0fbe1fa68ad2f4d5fe::admin::initialize_pool_reward_<T0, T1, T2>(arg0, arg2, arg3, arg4, arg5, arg7)
    }

    public fun set_pool_ve_enabled<T0, T1>(arg0: &mut 0x9721b245ae60522bb1124048c0cdedbaeb72a631a8041b0fbe1fa68ad2f4d5fe::pool::Pool<T0, T1>, arg1: &0x9721b245ae60522bb1124048c0cdedbaeb72a631a8041b0fbe1fa68ad2f4d5fe::version::Version, arg2: &0x9721b245ae60522bb1124048c0cdedbaeb72a631a8041b0fbe1fa68ad2f4d5fe::app::VeCap) {
        0x9721b245ae60522bb1124048c0cdedbaeb72a631a8041b0fbe1fa68ad2f4d5fe::version::assert_supported_version(arg1);
        0x9721b245ae60522bb1124048c0cdedbaeb72a631a8041b0fbe1fa68ad2f4d5fe::pool::assert_not_pause<T0, T1>(arg0);
        0x9721b245ae60522bb1124048c0cdedbaeb72a631a8041b0fbe1fa68ad2f4d5fe::pool::set_ve_enabled<T0, T1>(arg0);
    }

    public fun update_pool_reward_emission_with_cap<T0, T1, T2>(arg0: &0x9721b245ae60522bb1124048c0cdedbaeb72a631a8041b0fbe1fa68ad2f4d5fe::app::VeCap, arg1: &mut 0x9721b245ae60522bb1124048c0cdedbaeb72a631a8041b0fbe1fa68ad2f4d5fe::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T2>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x9721b245ae60522bb1124048c0cdedbaeb72a631a8041b0fbe1fa68ad2f4d5fe::version::Version, arg6: &0x2::tx_context::TxContext) : (u64, u64) {
        0x9721b245ae60522bb1124048c0cdedbaeb72a631a8041b0fbe1fa68ad2f4d5fe::version::assert_supported_version(arg5);
        0x9721b245ae60522bb1124048c0cdedbaeb72a631a8041b0fbe1fa68ad2f4d5fe::pool::assert_not_pause<T0, T1>(arg1);
        0x9721b245ae60522bb1124048c0cdedbaeb72a631a8041b0fbe1fa68ad2f4d5fe::admin::update_pool_reward_emission_<T0, T1, T2>(arg1, arg2, arg3, arg4, arg6)
    }

    // decompiled from Move bytecode v6
}

