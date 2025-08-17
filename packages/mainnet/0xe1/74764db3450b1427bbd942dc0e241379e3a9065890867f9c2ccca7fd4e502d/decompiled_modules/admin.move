module 0xe174764db3450b1427bbd942dc0e241379e3a9065890867f9c2ccca7fd4e502d::admin {
    struct CollectProtocolFeeEvent has copy, drop, store {
        sender: address,
        pool_id: 0x2::object::ID,
        amount_x: u64,
        amount_y: u64,
    }

    struct SetProtocolSwapFeeRateEvent has copy, drop, store {
        sender: address,
        pool_id: 0x2::object::ID,
        protocol_fee_share_old: u64,
        protocol_fee_share_new: u64,
    }

    struct SetProtocolFlashLoanFeeRateEvent has copy, drop, store {
        sender: address,
        pool_id: 0x2::object::ID,
        protocol_fee_share_old: u64,
        protocol_fee_share_new: u64,
    }

    struct SetSwapFeeRateEvent has copy, drop, store {
        sender: address,
        pool_id: 0x2::object::ID,
        swap_fee_rate_old: u64,
        swap_fee_rate_new: u64,
    }

    struct SetFlashLoanFeeRateEvent has copy, drop, store {
        sender: address,
        pool_id: 0x2::object::ID,
        flash_loan_fee_rate_old: u64,
        flash_loan_fee_rate_new: u64,
    }

    public fun add_seconds_to_reward_emission<T0, T1, T2>(arg0: &0xe174764db3450b1427bbd942dc0e241379e3a9065890867f9c2ccca7fd4e502d::app::Acl, arg1: &mut 0xe174764db3450b1427bbd942dc0e241379e3a9065890867f9c2ccca7fd4e502d::pool::Pool<T0, T1>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0xe174764db3450b1427bbd942dc0e241379e3a9065890867f9c2ccca7fd4e502d::version::Version, arg5: &0x2::tx_context::TxContext) {
        0xe174764db3450b1427bbd942dc0e241379e3a9065890867f9c2ccca7fd4e502d::version::assert_supported_version(arg4);
        0xe174764db3450b1427bbd942dc0e241379e3a9065890867f9c2ccca7fd4e502d::pool::assert_not_pause<T0, T1>(arg1);
        assert!(0xe174764db3450b1427bbd942dc0e241379e3a9065890867f9c2ccca7fd4e502d::app::get_rewarder_admin(arg0) == 0x2::tx_context::sender(arg5), 0xe174764db3450b1427bbd942dc0e241379e3a9065890867f9c2ccca7fd4e502d::error::not_authorised());
        0xe174764db3450b1427bbd942dc0e241379e3a9065890867f9c2ccca7fd4e502d::pool::update_reward_infos<T0, T1>(arg1, 0xe174764db3450b1427bbd942dc0e241379e3a9065890867f9c2ccca7fd4e502d::utils::to_seconds(0x2::clock::timestamp_ms(arg3)));
        let (_, _) = 0xe174764db3450b1427bbd942dc0e241379e3a9065890867f9c2ccca7fd4e502d::pool::update_pool_reward_emission<T0, T1, T2>(arg1, 0x2::balance::zero<T2>(), arg2, arg5);
    }

    public fun collect_protocol_fee<T0, T1>(arg0: &0xe174764db3450b1427bbd942dc0e241379e3a9065890867f9c2ccca7fd4e502d::app::Acl, arg1: &mut 0xe174764db3450b1427bbd942dc0e241379e3a9065890867f9c2ccca7fd4e502d::pool::Pool<T0, T1>, arg2: u64, arg3: u64, arg4: &0xe174764db3450b1427bbd942dc0e241379e3a9065890867f9c2ccca7fd4e502d::version::Version, arg5: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        0xe174764db3450b1427bbd942dc0e241379e3a9065890867f9c2ccca7fd4e502d::version::assert_supported_version(arg4);
        0xe174764db3450b1427bbd942dc0e241379e3a9065890867f9c2ccca7fd4e502d::pool::assert_not_pause<T0, T1>(arg1);
        assert!(0xe174764db3450b1427bbd942dc0e241379e3a9065890867f9c2ccca7fd4e502d::pool::is_ve_enabled<T0, T1>(arg1), 0xe174764db3450b1427bbd942dc0e241379e3a9065890867f9c2ccca7fd4e502d::error::forbidden_after_ve());
        assert!(0xe174764db3450b1427bbd942dc0e241379e3a9065890867f9c2ccca7fd4e502d::app::get_pool_admin(arg0) == 0x2::tx_context::sender(arg5), 0xe174764db3450b1427bbd942dc0e241379e3a9065890867f9c2ccca7fd4e502d::error::not_authorised());
        collect_protocol_fees_<T0, T1>(arg1, arg2, arg3, arg5)
    }

    public(friend) fun collect_protocol_fees_<T0, T1>(arg0: &mut 0xe174764db3450b1427bbd942dc0e241379e3a9065890867f9c2ccca7fd4e502d::pool::Pool<T0, T1>, arg1: u64, arg2: u64, arg3: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let v0 = 0x2::math::min(arg1, 0xe174764db3450b1427bbd942dc0e241379e3a9065890867f9c2ccca7fd4e502d::pool::protocol_fee_x<T0, T1>(arg0));
        let v1 = 0x2::math::min(arg2, 0xe174764db3450b1427bbd942dc0e241379e3a9065890867f9c2ccca7fd4e502d::pool::protocol_fee_y<T0, T1>(arg0));
        0xe174764db3450b1427bbd942dc0e241379e3a9065890867f9c2ccca7fd4e502d::pool::set_protocol_fee_x<T0, T1>(arg0, 0xe174764db3450b1427bbd942dc0e241379e3a9065890867f9c2ccca7fd4e502d::pool::protocol_fee_x<T0, T1>(arg0) - v0);
        0xe174764db3450b1427bbd942dc0e241379e3a9065890867f9c2ccca7fd4e502d::pool::set_protocol_fee_y<T0, T1>(arg0, 0xe174764db3450b1427bbd942dc0e241379e3a9065890867f9c2ccca7fd4e502d::pool::protocol_fee_y<T0, T1>(arg0) - v1);
        let v2 = CollectProtocolFeeEvent{
            sender   : 0x2::tx_context::sender(arg3),
            pool_id  : 0x2::object::id<0xe174764db3450b1427bbd942dc0e241379e3a9065890867f9c2ccca7fd4e502d::pool::Pool<T0, T1>>(arg0),
            amount_x : v0,
            amount_y : v1,
        };
        0x2::event::emit<CollectProtocolFeeEvent>(v2);
        0xe174764db3450b1427bbd942dc0e241379e3a9065890867f9c2ccca7fd4e502d::pool::take_from_reserves<T0, T1>(arg0, v0, v1)
    }

    public fun get_max_protocol_fee_share() : u64 {
        0xe174764db3450b1427bbd942dc0e241379e3a9065890867f9c2ccca7fd4e502d::full_math_u64::mul_div_floor(0xe174764db3450b1427bbd942dc0e241379e3a9065890867f9c2ccca7fd4e502d::constants::protocol_fee_share_denominator(), 0xe174764db3450b1427bbd942dc0e241379e3a9065890867f9c2ccca7fd4e502d::constants::max_protocol_fee_percent(), 100)
    }

    public fun increase_observation_cardinality_next<T0, T1>(arg0: &0xe174764db3450b1427bbd942dc0e241379e3a9065890867f9c2ccca7fd4e502d::app::Acl, arg1: &mut 0xe174764db3450b1427bbd942dc0e241379e3a9065890867f9c2ccca7fd4e502d::pool::Pool<T0, T1>, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert!(0xe174764db3450b1427bbd942dc0e241379e3a9065890867f9c2ccca7fd4e502d::app::get_pool_admin(arg0) == 0x2::tx_context::sender(arg3), 0xe174764db3450b1427bbd942dc0e241379e3a9065890867f9c2ccca7fd4e502d::error::not_authorised());
        0xe174764db3450b1427bbd942dc0e241379e3a9065890867f9c2ccca7fd4e502d::pool::assert_not_pause<T0, T1>(arg1);
        0xe174764db3450b1427bbd942dc0e241379e3a9065890867f9c2ccca7fd4e502d::pool::increase_observation_cardinality_next<T0, T1>(arg1, arg2, arg3);
    }

    public fun initialize_pool_reward<T0, T1, T2>(arg0: &0xe174764db3450b1427bbd942dc0e241379e3a9065890867f9c2ccca7fd4e502d::app::Acl, arg1: &mut 0xe174764db3450b1427bbd942dc0e241379e3a9065890867f9c2ccca7fd4e502d::pool::Pool<T0, T1>, arg2: u64, arg3: u64, arg4: 0x2::balance::Balance<T2>, arg5: &0x2::clock::Clock, arg6: &0xe174764db3450b1427bbd942dc0e241379e3a9065890867f9c2ccca7fd4e502d::version::Version, arg7: &0x2::tx_context::TxContext) {
        0xe174764db3450b1427bbd942dc0e241379e3a9065890867f9c2ccca7fd4e502d::version::assert_supported_version(arg6);
        0xe174764db3450b1427bbd942dc0e241379e3a9065890867f9c2ccca7fd4e502d::pool::assert_not_pause<T0, T1>(arg1);
        assert!(0xe174764db3450b1427bbd942dc0e241379e3a9065890867f9c2ccca7fd4e502d::app::get_rewarder_admin(arg0) == 0x2::tx_context::sender(arg7), 0xe174764db3450b1427bbd942dc0e241379e3a9065890867f9c2ccca7fd4e502d::error::not_authorised());
        let (_, _) = initialize_pool_reward_<T0, T1, T2>(arg1, arg2, arg3, arg4, arg5, arg7);
    }

    public(friend) fun initialize_pool_reward_<T0, T1, T2>(arg0: &mut 0xe174764db3450b1427bbd942dc0e241379e3a9065890867f9c2ccca7fd4e502d::pool::Pool<T0, T1>, arg1: u64, arg2: u64, arg3: 0x2::balance::Balance<T2>, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) : (u64, u64) {
        assert!(arg1 > 0xe174764db3450b1427bbd942dc0e241379e3a9065890867f9c2ccca7fd4e502d::utils::to_seconds(0x2::clock::timestamp_ms(arg4)), 0xe174764db3450b1427bbd942dc0e241379e3a9065890867f9c2ccca7fd4e502d::error::invalid_timestamp());
        0xe174764db3450b1427bbd942dc0e241379e3a9065890867f9c2ccca7fd4e502d::pool::add_reward_info<T0, T1, T2>(arg0, 0xe174764db3450b1427bbd942dc0e241379e3a9065890867f9c2ccca7fd4e502d::pool::default_reward_info(0x1::type_name::get<T2>(), arg1), arg5);
        0xe174764db3450b1427bbd942dc0e241379e3a9065890867f9c2ccca7fd4e502d::pool::update_pool_reward_emission<T0, T1, T2>(arg0, arg3, arg2, arg5)
    }

    public fun set_flash_loan_fee_rate<T0, T1>(arg0: &0xe174764db3450b1427bbd942dc0e241379e3a9065890867f9c2ccca7fd4e502d::app::Acl, arg1: &mut 0xe174764db3450b1427bbd942dc0e241379e3a9065890867f9c2ccca7fd4e502d::pool::Pool<T0, T1>, arg2: u64, arg3: &0xe174764db3450b1427bbd942dc0e241379e3a9065890867f9c2ccca7fd4e502d::version::Version, arg4: &0x2::tx_context::TxContext) {
        0xe174764db3450b1427bbd942dc0e241379e3a9065890867f9c2ccca7fd4e502d::version::assert_supported_version(arg3);
        0xe174764db3450b1427bbd942dc0e241379e3a9065890867f9c2ccca7fd4e502d::pool::assert_not_pause<T0, T1>(arg1);
        assert!(0xe174764db3450b1427bbd942dc0e241379e3a9065890867f9c2ccca7fd4e502d::app::get_pool_admin(arg0) == 0x2::tx_context::sender(arg4), 0xe174764db3450b1427bbd942dc0e241379e3a9065890867f9c2ccca7fd4e502d::error::not_authorised());
        assert!(arg2 > 0 && arg2 < 1000000, 0xe174764db3450b1427bbd942dc0e241379e3a9065890867f9c2ccca7fd4e502d::error::invalid_fee_rate());
        let v0 = SetFlashLoanFeeRateEvent{
            sender                  : 0x2::tx_context::sender(arg4),
            pool_id                 : 0x2::object::id<0xe174764db3450b1427bbd942dc0e241379e3a9065890867f9c2ccca7fd4e502d::pool::Pool<T0, T1>>(arg1),
            flash_loan_fee_rate_old : 0xe174764db3450b1427bbd942dc0e241379e3a9065890867f9c2ccca7fd4e502d::pool::flash_loan_fee_rate<T0, T1>(arg1),
            flash_loan_fee_rate_new : arg2,
        };
        0xe174764db3450b1427bbd942dc0e241379e3a9065890867f9c2ccca7fd4e502d::pool::set_flash_loan_fee_rate<T0, T1>(arg1, arg2);
        0x2::event::emit<SetFlashLoanFeeRateEvent>(v0);
    }

    public fun set_protocol_flash_loan_fee_share<T0, T1>(arg0: &0xe174764db3450b1427bbd942dc0e241379e3a9065890867f9c2ccca7fd4e502d::app::Acl, arg1: &mut 0xe174764db3450b1427bbd942dc0e241379e3a9065890867f9c2ccca7fd4e502d::pool::Pool<T0, T1>, arg2: u64, arg3: &0xe174764db3450b1427bbd942dc0e241379e3a9065890867f9c2ccca7fd4e502d::version::Version, arg4: &0x2::tx_context::TxContext) {
        0xe174764db3450b1427bbd942dc0e241379e3a9065890867f9c2ccca7fd4e502d::version::assert_supported_version(arg3);
        0xe174764db3450b1427bbd942dc0e241379e3a9065890867f9c2ccca7fd4e502d::pool::assert_not_pause<T0, T1>(arg1);
        assert!(0xe174764db3450b1427bbd942dc0e241379e3a9065890867f9c2ccca7fd4e502d::app::get_pool_admin(arg0) == 0x2::tx_context::sender(arg4), 0xe174764db3450b1427bbd942dc0e241379e3a9065890867f9c2ccca7fd4e502d::error::not_authorised());
        assert!(arg2 >= 0 && arg2 <= get_max_protocol_fee_share(), 0xe174764db3450b1427bbd942dc0e241379e3a9065890867f9c2ccca7fd4e502d::error::invalid_protocol_fee());
        let v0 = SetProtocolFlashLoanFeeRateEvent{
            sender                 : 0x2::tx_context::sender(arg4),
            pool_id                : 0x2::object::id<0xe174764db3450b1427bbd942dc0e241379e3a9065890867f9c2ccca7fd4e502d::pool::Pool<T0, T1>>(arg1),
            protocol_fee_share_old : 0xe174764db3450b1427bbd942dc0e241379e3a9065890867f9c2ccca7fd4e502d::pool::protocol_flash_loan_fee_share<T0, T1>(arg1),
            protocol_fee_share_new : arg2,
        };
        0xe174764db3450b1427bbd942dc0e241379e3a9065890867f9c2ccca7fd4e502d::pool::set_protocol_flash_loan_fee_share<T0, T1>(arg1, arg2);
        0x2::event::emit<SetProtocolFlashLoanFeeRateEvent>(v0);
    }

    public fun set_protocol_swap_fee_share<T0, T1>(arg0: &0xe174764db3450b1427bbd942dc0e241379e3a9065890867f9c2ccca7fd4e502d::app::Acl, arg1: &mut 0xe174764db3450b1427bbd942dc0e241379e3a9065890867f9c2ccca7fd4e502d::pool::Pool<T0, T1>, arg2: u64, arg3: &0xe174764db3450b1427bbd942dc0e241379e3a9065890867f9c2ccca7fd4e502d::version::Version, arg4: &0x2::tx_context::TxContext) {
        0xe174764db3450b1427bbd942dc0e241379e3a9065890867f9c2ccca7fd4e502d::version::assert_supported_version(arg3);
        0xe174764db3450b1427bbd942dc0e241379e3a9065890867f9c2ccca7fd4e502d::pool::assert_not_pause<T0, T1>(arg1);
        assert!(0xe174764db3450b1427bbd942dc0e241379e3a9065890867f9c2ccca7fd4e502d::app::get_pool_admin(arg0) == 0x2::tx_context::sender(arg4), 0xe174764db3450b1427bbd942dc0e241379e3a9065890867f9c2ccca7fd4e502d::error::not_authorised());
        assert!(arg2 >= 0 && arg2 <= get_max_protocol_fee_share(), 0xe174764db3450b1427bbd942dc0e241379e3a9065890867f9c2ccca7fd4e502d::error::invalid_protocol_fee());
        let v0 = SetProtocolSwapFeeRateEvent{
            sender                 : 0x2::tx_context::sender(arg4),
            pool_id                : 0x2::object::id<0xe174764db3450b1427bbd942dc0e241379e3a9065890867f9c2ccca7fd4e502d::pool::Pool<T0, T1>>(arg1),
            protocol_fee_share_old : 0xe174764db3450b1427bbd942dc0e241379e3a9065890867f9c2ccca7fd4e502d::pool::protocol_fee_share<T0, T1>(arg1),
            protocol_fee_share_new : arg2,
        };
        0xe174764db3450b1427bbd942dc0e241379e3a9065890867f9c2ccca7fd4e502d::pool::set_protocol_fee_share<T0, T1>(arg1, arg2);
        0x2::event::emit<SetProtocolSwapFeeRateEvent>(v0);
    }

    public fun set_swap_fee_rate<T0, T1>(arg0: &0xe174764db3450b1427bbd942dc0e241379e3a9065890867f9c2ccca7fd4e502d::app::Acl, arg1: &mut 0xe174764db3450b1427bbd942dc0e241379e3a9065890867f9c2ccca7fd4e502d::pool::Pool<T0, T1>, arg2: u64, arg3: &0xe174764db3450b1427bbd942dc0e241379e3a9065890867f9c2ccca7fd4e502d::version::Version, arg4: &0x2::tx_context::TxContext) {
        0xe174764db3450b1427bbd942dc0e241379e3a9065890867f9c2ccca7fd4e502d::version::assert_supported_version(arg3);
        0xe174764db3450b1427bbd942dc0e241379e3a9065890867f9c2ccca7fd4e502d::pool::assert_not_pause<T0, T1>(arg1);
        assert!(0xe174764db3450b1427bbd942dc0e241379e3a9065890867f9c2ccca7fd4e502d::app::get_pool_admin(arg0) == 0x2::tx_context::sender(arg4), 0xe174764db3450b1427bbd942dc0e241379e3a9065890867f9c2ccca7fd4e502d::error::not_authorised());
        assert!(arg2 > 0 && arg2 < 1000000, 0xe174764db3450b1427bbd942dc0e241379e3a9065890867f9c2ccca7fd4e502d::error::invalid_fee_rate());
        let v0 = SetSwapFeeRateEvent{
            sender            : 0x2::tx_context::sender(arg4),
            pool_id           : 0x2::object::id<0xe174764db3450b1427bbd942dc0e241379e3a9065890867f9c2ccca7fd4e502d::pool::Pool<T0, T1>>(arg1),
            swap_fee_rate_old : 0xe174764db3450b1427bbd942dc0e241379e3a9065890867f9c2ccca7fd4e502d::pool::swap_fee_rate<T0, T1>(arg1),
            swap_fee_rate_new : arg2,
        };
        0xe174764db3450b1427bbd942dc0e241379e3a9065890867f9c2ccca7fd4e502d::pool::set_swap_fee_rate<T0, T1>(arg1, arg2);
        0x2::event::emit<SetSwapFeeRateEvent>(v0);
    }

    public fun toggle_trading<T0, T1>(arg0: &0xe174764db3450b1427bbd942dc0e241379e3a9065890867f9c2ccca7fd4e502d::app::AdminCap, arg1: &mut 0xe174764db3450b1427bbd942dc0e241379e3a9065890867f9c2ccca7fd4e502d::pool::Pool<T0, T1>, arg2: bool, arg3: &0x2::tx_context::TxContext) {
        0xe174764db3450b1427bbd942dc0e241379e3a9065890867f9c2ccca7fd4e502d::pool::toggle_trading<T0, T1>(arg0, arg1, arg2);
    }

    public fun update_pool_reward_emission<T0, T1, T2>(arg0: &0xe174764db3450b1427bbd942dc0e241379e3a9065890867f9c2ccca7fd4e502d::app::Acl, arg1: &mut 0xe174764db3450b1427bbd942dc0e241379e3a9065890867f9c2ccca7fd4e502d::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T2>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0xe174764db3450b1427bbd942dc0e241379e3a9065890867f9c2ccca7fd4e502d::version::Version, arg6: &0x2::tx_context::TxContext) {
        0xe174764db3450b1427bbd942dc0e241379e3a9065890867f9c2ccca7fd4e502d::version::assert_supported_version(arg5);
        0xe174764db3450b1427bbd942dc0e241379e3a9065890867f9c2ccca7fd4e502d::pool::assert_not_pause<T0, T1>(arg1);
        assert!(0xe174764db3450b1427bbd942dc0e241379e3a9065890867f9c2ccca7fd4e502d::app::get_rewarder_admin(arg0) == 0x2::tx_context::sender(arg6), 0xe174764db3450b1427bbd942dc0e241379e3a9065890867f9c2ccca7fd4e502d::error::not_authorised());
        let (_, _) = update_pool_reward_emission_<T0, T1, T2>(arg1, arg2, arg3, arg4, arg6);
    }

    public(friend) fun update_pool_reward_emission_<T0, T1, T2>(arg0: &mut 0xe174764db3450b1427bbd942dc0e241379e3a9065890867f9c2ccca7fd4e502d::pool::Pool<T0, T1>, arg1: 0x2::balance::Balance<T2>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) : (u64, u64) {
        0xe174764db3450b1427bbd942dc0e241379e3a9065890867f9c2ccca7fd4e502d::pool::update_reward_infos<T0, T1>(arg0, 0xe174764db3450b1427bbd942dc0e241379e3a9065890867f9c2ccca7fd4e502d::utils::to_seconds(0x2::clock::timestamp_ms(arg3)));
        0xe174764db3450b1427bbd942dc0e241379e3a9065890867f9c2ccca7fd4e502d::pool::update_pool_reward_emission<T0, T1, T2>(arg0, arg1, arg2, arg4)
    }

    // decompiled from Move bytecode v6
}

