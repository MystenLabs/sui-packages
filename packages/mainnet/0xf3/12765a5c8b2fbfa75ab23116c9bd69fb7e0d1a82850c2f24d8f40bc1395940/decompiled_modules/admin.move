module 0xf312765a5c8b2fbfa75ab23116c9bd69fb7e0d1a82850c2f24d8f40bc1395940::admin {
    struct CollectProtocolFeeEvent has copy, drop, store {
        sender: address,
        pool_id: 0x2::object::ID,
        amount_x: u64,
        amount_y: u64,
    }

    struct SetProtocolFeeRateEvent has copy, drop, store {
        sender: address,
        pool_id: 0x2::object::ID,
        protocol_fee_rate_x_old: u64,
        protocol_fee_rate_y_old: u64,
        protocol_fee_rate_x_new: u64,
        protocol_fee_rate_y_new: u64,
    }

    public fun add_balance_to_reward_emission<T0, T1, T2>(arg0: &0xf312765a5c8b2fbfa75ab23116c9bd69fb7e0d1a82850c2f24d8f40bc1395940::app::AdminCap, arg1: &mut 0xf312765a5c8b2fbfa75ab23116c9bd69fb7e0d1a82850c2f24d8f40bc1395940::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T2>, arg3: &0x2::clock::Clock, arg4: &0xf312765a5c8b2fbfa75ab23116c9bd69fb7e0d1a82850c2f24d8f40bc1395940::version::Version, arg5: &0x2::tx_context::TxContext) {
        0xf312765a5c8b2fbfa75ab23116c9bd69fb7e0d1a82850c2f24d8f40bc1395940::version::assert_supported_version(arg4);
        0xf312765a5c8b2fbfa75ab23116c9bd69fb7e0d1a82850c2f24d8f40bc1395940::pool::update_reward_infos<T0, T1>(arg1, 0xf312765a5c8b2fbfa75ab23116c9bd69fb7e0d1a82850c2f24d8f40bc1395940::utils::to_seconds(0x2::clock::timestamp_ms(arg3)));
        0xf312765a5c8b2fbfa75ab23116c9bd69fb7e0d1a82850c2f24d8f40bc1395940::pool::update_pool_reward_emission<T0, T1, T2>(arg1, arg2, 0, arg5);
    }

    public fun add_seconds_to_reward_emission<T0, T1, T2>(arg0: &0xf312765a5c8b2fbfa75ab23116c9bd69fb7e0d1a82850c2f24d8f40bc1395940::app::AdminCap, arg1: &mut 0xf312765a5c8b2fbfa75ab23116c9bd69fb7e0d1a82850c2f24d8f40bc1395940::pool::Pool<T0, T1>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0xf312765a5c8b2fbfa75ab23116c9bd69fb7e0d1a82850c2f24d8f40bc1395940::version::Version, arg5: &0x2::tx_context::TxContext) {
        0xf312765a5c8b2fbfa75ab23116c9bd69fb7e0d1a82850c2f24d8f40bc1395940::version::assert_supported_version(arg4);
        0xf312765a5c8b2fbfa75ab23116c9bd69fb7e0d1a82850c2f24d8f40bc1395940::pool::update_reward_infos<T0, T1>(arg1, 0xf312765a5c8b2fbfa75ab23116c9bd69fb7e0d1a82850c2f24d8f40bc1395940::utils::to_seconds(0x2::clock::timestamp_ms(arg3)));
        0xf312765a5c8b2fbfa75ab23116c9bd69fb7e0d1a82850c2f24d8f40bc1395940::pool::update_pool_reward_emission<T0, T1, T2>(arg1, 0x2::balance::zero<T2>(), arg2, arg5);
    }

    public fun collect_protocol_fee<T0, T1>(arg0: &0xf312765a5c8b2fbfa75ab23116c9bd69fb7e0d1a82850c2f24d8f40bc1395940::app::AdminCap, arg1: &mut 0xf312765a5c8b2fbfa75ab23116c9bd69fb7e0d1a82850c2f24d8f40bc1395940::pool::Pool<T0, T1>, arg2: u64, arg3: u64, arg4: &0xf312765a5c8b2fbfa75ab23116c9bd69fb7e0d1a82850c2f24d8f40bc1395940::version::Version, arg5: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        0xf312765a5c8b2fbfa75ab23116c9bd69fb7e0d1a82850c2f24d8f40bc1395940::version::assert_supported_version(arg4);
        let v0 = 0x2::math::min(arg2, 0xf312765a5c8b2fbfa75ab23116c9bd69fb7e0d1a82850c2f24d8f40bc1395940::pool::protocol_fee_x<T0, T1>(arg1));
        let v1 = 0x2::math::min(arg3, 0xf312765a5c8b2fbfa75ab23116c9bd69fb7e0d1a82850c2f24d8f40bc1395940::pool::protocol_fee_y<T0, T1>(arg1));
        0xf312765a5c8b2fbfa75ab23116c9bd69fb7e0d1a82850c2f24d8f40bc1395940::pool::set_protocol_fee_x<T0, T1>(arg1, 0xf312765a5c8b2fbfa75ab23116c9bd69fb7e0d1a82850c2f24d8f40bc1395940::pool::protocol_fee_x<T0, T1>(arg1) - v0);
        0xf312765a5c8b2fbfa75ab23116c9bd69fb7e0d1a82850c2f24d8f40bc1395940::pool::set_protocol_fee_y<T0, T1>(arg1, 0xf312765a5c8b2fbfa75ab23116c9bd69fb7e0d1a82850c2f24d8f40bc1395940::pool::protocol_fee_y<T0, T1>(arg1) - v1);
        let v2 = CollectProtocolFeeEvent{
            sender   : 0x2::tx_context::sender(arg5),
            pool_id  : 0x2::object::id<0xf312765a5c8b2fbfa75ab23116c9bd69fb7e0d1a82850c2f24d8f40bc1395940::pool::Pool<T0, T1>>(arg1),
            amount_x : v0,
            amount_y : v1,
        };
        0x2::event::emit<CollectProtocolFeeEvent>(v2);
        0xf312765a5c8b2fbfa75ab23116c9bd69fb7e0d1a82850c2f24d8f40bc1395940::pool::take_from_reserves<T0, T1>(arg1, v0, v1)
    }

    public fun increase_observation_cardinality_next<T0, T1>(arg0: &0xf312765a5c8b2fbfa75ab23116c9bd69fb7e0d1a82850c2f24d8f40bc1395940::app::AdminCap, arg1: &mut 0xf312765a5c8b2fbfa75ab23116c9bd69fb7e0d1a82850c2f24d8f40bc1395940::pool::Pool<T0, T1>, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0xf312765a5c8b2fbfa75ab23116c9bd69fb7e0d1a82850c2f24d8f40bc1395940::pool::increase_observation_cardinality_next<T0, T1>(arg1, arg2, arg3);
    }

    public fun initialize_pool_reward<T0, T1, T2>(arg0: &0xf312765a5c8b2fbfa75ab23116c9bd69fb7e0d1a82850c2f24d8f40bc1395940::app::AdminCap, arg1: &mut 0xf312765a5c8b2fbfa75ab23116c9bd69fb7e0d1a82850c2f24d8f40bc1395940::pool::Pool<T0, T1>, arg2: u64, arg3: u64, arg4: 0x2::balance::Balance<T2>, arg5: &0x2::clock::Clock, arg6: &0xf312765a5c8b2fbfa75ab23116c9bd69fb7e0d1a82850c2f24d8f40bc1395940::version::Version, arg7: &0x2::tx_context::TxContext) {
        0xf312765a5c8b2fbfa75ab23116c9bd69fb7e0d1a82850c2f24d8f40bc1395940::version::assert_supported_version(arg6);
        assert!(arg2 > 0xf312765a5c8b2fbfa75ab23116c9bd69fb7e0d1a82850c2f24d8f40bc1395940::utils::to_seconds(0x2::clock::timestamp_ms(arg5)), 0xf312765a5c8b2fbfa75ab23116c9bd69fb7e0d1a82850c2f24d8f40bc1395940::error::invalid_timestamp());
        0xf312765a5c8b2fbfa75ab23116c9bd69fb7e0d1a82850c2f24d8f40bc1395940::pool::add_reward_info<T0, T1, T2>(arg1, 0xf312765a5c8b2fbfa75ab23116c9bd69fb7e0d1a82850c2f24d8f40bc1395940::pool::default_reward_info(0x1::type_name::get<T2>(), arg2), arg7);
        0xf312765a5c8b2fbfa75ab23116c9bd69fb7e0d1a82850c2f24d8f40bc1395940::pool::update_pool_reward_emission<T0, T1, T2>(arg1, arg4, arg3, arg7);
    }

    public fun set_protocol_fee_rate<T0, T1>(arg0: &0xf312765a5c8b2fbfa75ab23116c9bd69fb7e0d1a82850c2f24d8f40bc1395940::app::AdminCap, arg1: &mut 0xf312765a5c8b2fbfa75ab23116c9bd69fb7e0d1a82850c2f24d8f40bc1395940::pool::Pool<T0, T1>, arg2: u64, arg3: u64, arg4: &0xf312765a5c8b2fbfa75ab23116c9bd69fb7e0d1a82850c2f24d8f40bc1395940::version::Version, arg5: &0x2::tx_context::TxContext) {
        0xf312765a5c8b2fbfa75ab23116c9bd69fb7e0d1a82850c2f24d8f40bc1395940::version::assert_supported_version(arg4);
        let v0 = arg2 != 0 && (arg2 < 4 || arg2 > 10) || arg3 != 0 && (arg3 < 4 || arg3 > 10);
        assert!(!v0, 0xf312765a5c8b2fbfa75ab23116c9bd69fb7e0d1a82850c2f24d8f40bc1395940::error::invalid_protocol_fee());
        0xf312765a5c8b2fbfa75ab23116c9bd69fb7e0d1a82850c2f24d8f40bc1395940::pool::set_protocol_fee_rate<T0, T1>(arg1, arg2 + (arg3 << 4));
        let v1 = SetProtocolFeeRateEvent{
            sender                  : 0x2::tx_context::sender(arg5),
            pool_id                 : 0x2::object::id<0xf312765a5c8b2fbfa75ab23116c9bd69fb7e0d1a82850c2f24d8f40bc1395940::pool::Pool<T0, T1>>(arg1),
            protocol_fee_rate_x_old : 0xf312765a5c8b2fbfa75ab23116c9bd69fb7e0d1a82850c2f24d8f40bc1395940::pool::protocol_fee_rate<T0, T1>(arg1) % 16,
            protocol_fee_rate_y_old : 0xf312765a5c8b2fbfa75ab23116c9bd69fb7e0d1a82850c2f24d8f40bc1395940::pool::protocol_fee_rate<T0, T1>(arg1) >> 4,
            protocol_fee_rate_x_new : arg2,
            protocol_fee_rate_y_new : arg3,
        };
        0x2::event::emit<SetProtocolFeeRateEvent>(v1);
    }

    // decompiled from Move bytecode v6
}

