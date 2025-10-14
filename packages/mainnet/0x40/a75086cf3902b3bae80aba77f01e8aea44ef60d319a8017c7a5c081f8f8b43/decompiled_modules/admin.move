module 0x40a75086cf3902b3bae80aba77f01e8aea44ef60d319a8017c7a5c081f8f8b43::admin {
    struct SetPauseEvent has copy, drop, store {
        admin: address,
        paused: bool,
    }

    struct SetIncentiveAdminEvent has copy, drop, store {
        old_admin: address,
        new_admin: address,
        changed_by: address,
    }

    public fun set_reward_admin(arg0: &0x40a75086cf3902b3bae80aba77f01e8aea44ef60d319a8017c7a5c081f8f8b43::acl::AdminCap, arg1: &mut 0x40a75086cf3902b3bae80aba77f01e8aea44ef60d319a8017c7a5c081f8f8b43::acl::Acl, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x40a75086cf3902b3bae80aba77f01e8aea44ef60d319a8017c7a5c081f8f8b43::acl::set_reward_admin(arg1, arg2);
        let v0 = SetIncentiveAdminEvent{
            old_admin  : 0x40a75086cf3902b3bae80aba77f01e8aea44ef60d319a8017c7a5c081f8f8b43::acl::get_reward_admin(arg1),
            new_admin  : arg2,
            changed_by : 0x2::tx_context::sender(arg3),
        };
        0x40a75086cf3902b3bae80aba77f01e8aea44ef60d319a8017c7a5c081f8f8b43::event::emit<SetIncentiveAdminEvent>(v0);
    }

    public fun add_ms_to_reward_emission(arg0: &0x40a75086cf3902b3bae80aba77f01e8aea44ef60d319a8017c7a5c081f8f8b43::ve_mmt::VeMMT, arg1: &0x40a75086cf3902b3bae80aba77f01e8aea44ef60d319a8017c7a5c081f8f8b43::acl::Acl, arg2: &mut 0x40a75086cf3902b3bae80aba77f01e8aea44ef60d319a8017c7a5c081f8f8b43::staking_pool::StakingPool, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x40a75086cf3902b3bae80aba77f01e8aea44ef60d319a8017c7a5c081f8f8b43::version::Version, arg6: &0x2::tx_context::TxContext) {
        0x40a75086cf3902b3bae80aba77f01e8aea44ef60d319a8017c7a5c081f8f8b43::version::assert_supported_version(arg5);
        assert!(!0x40a75086cf3902b3bae80aba77f01e8aea44ef60d319a8017c7a5c081f8f8b43::ve_mmt::is_paused(arg0), 0x40a75086cf3902b3bae80aba77f01e8aea44ef60d319a8017c7a5c081f8f8b43::error::e_paused());
        0x40a75086cf3902b3bae80aba77f01e8aea44ef60d319a8017c7a5c081f8f8b43::acl::assert_reward_admin(arg1, arg6);
        0x40a75086cf3902b3bae80aba77f01e8aea44ef60d319a8017c7a5c081f8f8b43::assert::assert_additional_ms(arg3, 0x40a75086cf3902b3bae80aba77f01e8aea44ef60d319a8017c7a5c081f8f8b43::ve_mmt::ep_config(arg0));
        0x40a75086cf3902b3bae80aba77f01e8aea44ef60d319a8017c7a5c081f8f8b43::staking_pool::update_reward_info(arg2, 0x2::clock::timestamp_ms(arg4));
        0x40a75086cf3902b3bae80aba77f01e8aea44ef60d319a8017c7a5c081f8f8b43::staking_pool::update_reward_emission(arg2, 0x2::balance::zero<0x307bcac69a2b657cd7d06b895d290cfaa728a243a4119e01a9300535943aac2::mmt::MMT>(), arg3, arg6);
    }

    public fun init_reward(arg0: &0x40a75086cf3902b3bae80aba77f01e8aea44ef60d319a8017c7a5c081f8f8b43::ve_mmt::VeMMT, arg1: &0x40a75086cf3902b3bae80aba77f01e8aea44ef60d319a8017c7a5c081f8f8b43::acl::Acl, arg2: &mut 0x40a75086cf3902b3bae80aba77f01e8aea44ef60d319a8017c7a5c081f8f8b43::staking_pool::StakingPool, arg3: u64, arg4: u64, arg5: 0x2::balance::Balance<0x307bcac69a2b657cd7d06b895d290cfaa728a243a4119e01a9300535943aac2::mmt::MMT>, arg6: &0x2::clock::Clock, arg7: &0x40a75086cf3902b3bae80aba77f01e8aea44ef60d319a8017c7a5c081f8f8b43::version::Version, arg8: &0x2::tx_context::TxContext) {
        0x40a75086cf3902b3bae80aba77f01e8aea44ef60d319a8017c7a5c081f8f8b43::version::assert_supported_version(arg7);
        assert!(!0x40a75086cf3902b3bae80aba77f01e8aea44ef60d319a8017c7a5c081f8f8b43::ve_mmt::is_paused(arg0), 0x40a75086cf3902b3bae80aba77f01e8aea44ef60d319a8017c7a5c081f8f8b43::error::e_paused());
        0x40a75086cf3902b3bae80aba77f01e8aea44ef60d319a8017c7a5c081f8f8b43::acl::assert_reward_admin(arg1, arg8);
        0x40a75086cf3902b3bae80aba77f01e8aea44ef60d319a8017c7a5c081f8f8b43::assert::assert_init_reward_valid(arg3, arg4, arg6, 0x40a75086cf3902b3bae80aba77f01e8aea44ef60d319a8017c7a5c081f8f8b43::ve_mmt::ep_config(arg0));
        assert!(0x2::balance::value<0x307bcac69a2b657cd7d06b895d290cfaa728a243a4119e01a9300535943aac2::mmt::MMT>(&arg5) > 0, 0x40a75086cf3902b3bae80aba77f01e8aea44ef60d319a8017c7a5c081f8f8b43::error::e_invalid_amount());
        0x40a75086cf3902b3bae80aba77f01e8aea44ef60d319a8017c7a5c081f8f8b43::staking_pool::init_reward(arg2, arg3);
        0x40a75086cf3902b3bae80aba77f01e8aea44ef60d319a8017c7a5c081f8f8b43::staking_pool::update_reward_emission(arg2, arg5, arg4, arg8);
    }

    public fun initialize_pool(arg0: &0x40a75086cf3902b3bae80aba77f01e8aea44ef60d319a8017c7a5c081f8f8b43::acl::AdminCap, arg1: &mut 0x40a75086cf3902b3bae80aba77f01e8aea44ef60d319a8017c7a5c081f8f8b43::staking_pool::StakingPool, arg2: &0x40a75086cf3902b3bae80aba77f01e8aea44ef60d319a8017c7a5c081f8f8b43::epoch::EpochConfig, arg3: &0x2::clock::Clock) {
        0x40a75086cf3902b3bae80aba77f01e8aea44ef60d319a8017c7a5c081f8f8b43::staking_pool::initialize(arg1, arg2, arg3);
    }

    public fun set_pause(arg0: &0x40a75086cf3902b3bae80aba77f01e8aea44ef60d319a8017c7a5c081f8f8b43::acl::AdminCap, arg1: &mut 0x40a75086cf3902b3bae80aba77f01e8aea44ef60d319a8017c7a5c081f8f8b43::ve_mmt::VeMMT, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 != 0x40a75086cf3902b3bae80aba77f01e8aea44ef60d319a8017c7a5c081f8f8b43::ve_mmt::is_paused(arg1), 0x40a75086cf3902b3bae80aba77f01e8aea44ef60d319a8017c7a5c081f8f8b43::error::e_no_state_change());
        0x40a75086cf3902b3bae80aba77f01e8aea44ef60d319a8017c7a5c081f8f8b43::ve_mmt::set_paused(arg1, arg2);
        let v0 = SetPauseEvent{
            admin  : 0x2::tx_context::sender(arg3),
            paused : arg2,
        };
        0x40a75086cf3902b3bae80aba77f01e8aea44ef60d319a8017c7a5c081f8f8b43::event::emit<SetPauseEvent>(v0);
    }

    public fun update_pool_reward_emission(arg0: &0x40a75086cf3902b3bae80aba77f01e8aea44ef60d319a8017c7a5c081f8f8b43::ve_mmt::VeMMT, arg1: &0x40a75086cf3902b3bae80aba77f01e8aea44ef60d319a8017c7a5c081f8f8b43::acl::Acl, arg2: &mut 0x40a75086cf3902b3bae80aba77f01e8aea44ef60d319a8017c7a5c081f8f8b43::staking_pool::StakingPool, arg3: 0x2::balance::Balance<0x307bcac69a2b657cd7d06b895d290cfaa728a243a4119e01a9300535943aac2::mmt::MMT>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &0x40a75086cf3902b3bae80aba77f01e8aea44ef60d319a8017c7a5c081f8f8b43::version::Version, arg7: &0x2::tx_context::TxContext) {
        0x40a75086cf3902b3bae80aba77f01e8aea44ef60d319a8017c7a5c081f8f8b43::version::assert_supported_version(arg6);
        0x40a75086cf3902b3bae80aba77f01e8aea44ef60d319a8017c7a5c081f8f8b43::acl::assert_reward_admin(arg1, arg7);
        0x40a75086cf3902b3bae80aba77f01e8aea44ef60d319a8017c7a5c081f8f8b43::assert::assert_additional_ms(arg4, 0x40a75086cf3902b3bae80aba77f01e8aea44ef60d319a8017c7a5c081f8f8b43::ve_mmt::ep_config(arg0));
        assert!(0x2::balance::value<0x307bcac69a2b657cd7d06b895d290cfaa728a243a4119e01a9300535943aac2::mmt::MMT>(&arg3) > 0, 0x40a75086cf3902b3bae80aba77f01e8aea44ef60d319a8017c7a5c081f8f8b43::error::e_invalid_amount());
        0x40a75086cf3902b3bae80aba77f01e8aea44ef60d319a8017c7a5c081f8f8b43::staking_pool::update_reward_info(arg2, 0x2::clock::timestamp_ms(arg5));
        0x40a75086cf3902b3bae80aba77f01e8aea44ef60d319a8017c7a5c081f8f8b43::staking_pool::update_reward_emission(arg2, arg3, arg4, arg7);
    }

    // decompiled from Move bytecode v6
}

