module 0x38747d8471b55cfdd72ba8331877392bdb5416e241d3103f1836409faa1301ba::ve {
    public fun collect_protocol_fee_with_cap<T0, T1>(arg0: &mut 0x38747d8471b55cfdd72ba8331877392bdb5416e241d3103f1836409faa1301ba::pool::Pool<T0, T1>, arg1: &0x38747d8471b55cfdd72ba8331877392bdb5416e241d3103f1836409faa1301ba::app::VeCap, arg2: u64, arg3: u64, arg4: &0x38747d8471b55cfdd72ba8331877392bdb5416e241d3103f1836409faa1301ba::version::Version, arg5: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        0x38747d8471b55cfdd72ba8331877392bdb5416e241d3103f1836409faa1301ba::version::assert_supported_version(arg4);
        0x38747d8471b55cfdd72ba8331877392bdb5416e241d3103f1836409faa1301ba::pool::assert_not_pause<T0, T1>(arg0);
        0x38747d8471b55cfdd72ba8331877392bdb5416e241d3103f1836409faa1301ba::admin::collect_protocol_fees_<T0, T1>(arg0, arg2, arg3, arg5)
    }

    public fun initialize_pool_reward_with_cap<T0, T1, T2>(arg0: &mut 0x38747d8471b55cfdd72ba8331877392bdb5416e241d3103f1836409faa1301ba::pool::Pool<T0, T1>, arg1: &0x38747d8471b55cfdd72ba8331877392bdb5416e241d3103f1836409faa1301ba::app::VeCap, arg2: u64, arg3: u64, arg4: 0x2::balance::Balance<T2>, arg5: &0x2::clock::Clock, arg6: &0x38747d8471b55cfdd72ba8331877392bdb5416e241d3103f1836409faa1301ba::version::Version, arg7: &0x2::tx_context::TxContext) : (u64, u64) {
        0x38747d8471b55cfdd72ba8331877392bdb5416e241d3103f1836409faa1301ba::version::assert_supported_version(arg6);
        0x38747d8471b55cfdd72ba8331877392bdb5416e241d3103f1836409faa1301ba::pool::assert_not_pause<T0, T1>(arg0);
        0x38747d8471b55cfdd72ba8331877392bdb5416e241d3103f1836409faa1301ba::admin::initialize_pool_reward_<T0, T1, T2>(arg0, arg2, arg3, arg4, arg5, arg7)
    }

    public fun set_pool_ve_enabled<T0, T1>(arg0: &mut 0x38747d8471b55cfdd72ba8331877392bdb5416e241d3103f1836409faa1301ba::pool::Pool<T0, T1>, arg1: &0x38747d8471b55cfdd72ba8331877392bdb5416e241d3103f1836409faa1301ba::version::Version, arg2: &0x38747d8471b55cfdd72ba8331877392bdb5416e241d3103f1836409faa1301ba::app::VeCap) {
        0x38747d8471b55cfdd72ba8331877392bdb5416e241d3103f1836409faa1301ba::version::assert_supported_version(arg1);
        0x38747d8471b55cfdd72ba8331877392bdb5416e241d3103f1836409faa1301ba::pool::assert_not_pause<T0, T1>(arg0);
        0x38747d8471b55cfdd72ba8331877392bdb5416e241d3103f1836409faa1301ba::pool::set_ve_enabled<T0, T1>(arg0);
    }

    public fun update_pool_reward_emission_with_cap<T0, T1, T2>(arg0: &0x38747d8471b55cfdd72ba8331877392bdb5416e241d3103f1836409faa1301ba::app::VeCap, arg1: &mut 0x38747d8471b55cfdd72ba8331877392bdb5416e241d3103f1836409faa1301ba::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T2>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x38747d8471b55cfdd72ba8331877392bdb5416e241d3103f1836409faa1301ba::version::Version, arg6: &0x2::tx_context::TxContext) : (u64, u64) {
        0x38747d8471b55cfdd72ba8331877392bdb5416e241d3103f1836409faa1301ba::version::assert_supported_version(arg5);
        0x38747d8471b55cfdd72ba8331877392bdb5416e241d3103f1836409faa1301ba::pool::assert_not_pause<T0, T1>(arg1);
        0x38747d8471b55cfdd72ba8331877392bdb5416e241d3103f1836409faa1301ba::admin::update_pool_reward_emission_<T0, T1, T2>(arg1, arg2, arg3, arg4, arg6)
    }

    // decompiled from Move bytecode v6
}

