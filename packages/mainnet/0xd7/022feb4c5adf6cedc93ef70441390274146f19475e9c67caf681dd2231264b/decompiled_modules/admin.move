module 0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::admin {
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

    public fun add_seconds_to_reward_emission<T0, T1, T2>(arg0: &0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::app::Acl, arg1: &mut 0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::pool::Pool<T0, T1>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::version::Version, arg5: &0x2::tx_context::TxContext) {
        0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::version::assert_supported_version(arg4);
        assert!(0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::app::get_rewarder_admin(arg0) == 0x2::tx_context::sender(arg5), 0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::error::not_authorised());
        0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::pool::update_reward_infos<T0, T1>(arg1, 0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::utils::to_seconds(0x2::clock::timestamp_ms(arg3)));
        0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::pool::update_pool_reward_emission<T0, T1, T2>(arg1, 0x2::balance::zero<T2>(), arg2, arg5);
    }

    public fun collect_protocol_fee<T0, T1>(arg0: &0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::app::AdminCap, arg1: &mut 0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::pool::Pool<T0, T1>, arg2: u64, arg3: u64, arg4: &0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::version::Version, arg5: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::version::assert_supported_version(arg4);
        let v0 = 0x2::math::min(arg2, 0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::pool::protocol_fee_x<T0, T1>(arg1));
        let v1 = 0x2::math::min(arg3, 0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::pool::protocol_fee_y<T0, T1>(arg1));
        0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::pool::set_protocol_fee_x<T0, T1>(arg1, 0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::pool::protocol_fee_x<T0, T1>(arg1) - v0);
        0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::pool::set_protocol_fee_y<T0, T1>(arg1, 0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::pool::protocol_fee_y<T0, T1>(arg1) - v1);
        let v2 = CollectProtocolFeeEvent{
            sender   : 0x2::tx_context::sender(arg5),
            pool_id  : 0x2::object::id<0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::pool::Pool<T0, T1>>(arg1),
            amount_x : v0,
            amount_y : v1,
        };
        0x2::event::emit<CollectProtocolFeeEvent>(v2);
        0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::pool::take_from_reserves<T0, T1>(arg1, v0, v1)
    }

    public fun increase_observation_cardinality_next<T0, T1>(arg0: &0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::app::Acl, arg1: &mut 0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::pool::Pool<T0, T1>, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert!(0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::app::get_pool_admin(arg0) == 0x2::tx_context::sender(arg3), 0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::error::not_authorised());
        0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::pool::increase_observation_cardinality_next<T0, T1>(arg1, arg2, arg3);
    }

    public fun initialize_pool_reward<T0, T1, T2>(arg0: &0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::app::Acl, arg1: &mut 0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::pool::Pool<T0, T1>, arg2: u64, arg3: u64, arg4: 0x2::balance::Balance<T2>, arg5: &0x2::clock::Clock, arg6: &0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::version::Version, arg7: &0x2::tx_context::TxContext) {
        0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::version::assert_supported_version(arg6);
        assert!(0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::app::get_rewarder_admin(arg0) == 0x2::tx_context::sender(arg7), 0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::error::not_authorised());
        assert!(arg2 > 0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::utils::to_seconds(0x2::clock::timestamp_ms(arg5)), 0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::error::invalid_timestamp());
        0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::pool::add_reward_info<T0, T1, T2>(arg1, 0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::pool::default_reward_info(0x1::type_name::get<T2>(), arg2), arg7);
        0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::pool::update_pool_reward_emission<T0, T1, T2>(arg1, arg4, arg3, arg7);
    }

    public fun set_protocol_flash_loan_fee_share<T0, T1>(arg0: &0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::app::Acl, arg1: &mut 0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::pool::Pool<T0, T1>, arg2: u64, arg3: &0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::version::Version, arg4: &0x2::tx_context::TxContext) {
        0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::version::assert_supported_version(arg3);
        assert!(0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::app::get_pool_admin(arg0) == 0x2::tx_context::sender(arg4), 0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::error::not_authorised());
        assert!(arg2 >= 0 && arg2 <= 750000, 0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::error::invalid_protocol_fee());
        let v0 = SetProtocolFlashLoanFeeRateEvent{
            sender                 : 0x2::tx_context::sender(arg4),
            pool_id                : 0x2::object::id<0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::pool::Pool<T0, T1>>(arg1),
            protocol_fee_share_old : 0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::pool::protocol_flash_loan_fee_share<T0, T1>(arg1),
            protocol_fee_share_new : arg2,
        };
        0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::pool::set_protocol_flash_loan_fee_share<T0, T1>(arg1, arg2);
        0x2::event::emit<SetProtocolFlashLoanFeeRateEvent>(v0);
    }

    public fun set_protocol_swap_fee_share<T0, T1>(arg0: &0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::app::Acl, arg1: &mut 0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::pool::Pool<T0, T1>, arg2: u64, arg3: &0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::version::Version, arg4: &0x2::tx_context::TxContext) {
        0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::version::assert_supported_version(arg3);
        assert!(0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::app::get_pool_admin(arg0) == 0x2::tx_context::sender(arg4), 0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::error::not_authorised());
        assert!(arg2 >= 0 && arg2 <= 750000, 0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::error::invalid_protocol_fee());
        let v0 = SetProtocolSwapFeeRateEvent{
            sender                 : 0x2::tx_context::sender(arg4),
            pool_id                : 0x2::object::id<0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::pool::Pool<T0, T1>>(arg1),
            protocol_fee_share_old : 0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::pool::protocol_flash_loan_fee_share<T0, T1>(arg1),
            protocol_fee_share_new : arg2,
        };
        0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::pool::set_protocol_fee_share<T0, T1>(arg1, arg2);
        0x2::event::emit<SetProtocolSwapFeeRateEvent>(v0);
    }

    public fun update_pool_reward_emission<T0, T1, T2>(arg0: &0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::app::Acl, arg1: &mut 0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T2>, arg3: &0x2::clock::Clock, arg4: &0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::version::Version, arg5: &0x2::tx_context::TxContext) {
        0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::version::assert_supported_version(arg4);
        assert!(0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::app::get_rewarder_admin(arg0) == 0x2::tx_context::sender(arg5), 0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::error::not_authorised());
        0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::pool::update_reward_infos<T0, T1>(arg1, 0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::utils::to_seconds(0x2::clock::timestamp_ms(arg3)));
        0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::pool::update_pool_reward_emission<T0, T1, T2>(arg1, arg2, 0, arg5);
    }

    // decompiled from Move bytecode v6
}

