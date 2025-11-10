module 0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::admin {
    struct SetVersionEvent has copy, drop {
        sender: address,
        major_version_old: u64,
        major_version_new: u64,
        minor_version_old: u64,
        minor_version_new: u64,
    }

    struct SetPauseEvent has copy, drop {
        admin: address,
        paused: bool,
    }

    struct SetIncentiveAdminEvent has copy, drop {
        old_admin: address,
        new_admin: address,
        changed_by: address,
    }

    public fun set_reward_admin(arg0: &0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::acl::AdminCap, arg1: &mut 0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::ve_mmt::VeMMT, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::acl::set_reward_admin(0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::ve_mmt::acl_mut(arg1), arg2);
        let v0 = SetIncentiveAdminEvent{
            old_admin  : 0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::acl::get_reward_admin(0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::ve_mmt::acl(arg1)),
            new_admin  : arg2,
            changed_by : 0x2::tx_context::sender(arg3),
        };
        0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::event::emit<SetIncentiveAdminEvent>(v0);
    }

    public fun add_ms_to_reward_emission(arg0: &0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::ve_mmt::VeMMT, arg1: &mut 0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::staking_pool::StakingPool, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::version::assert_supported_version(0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::ve_mmt::version(arg0));
        0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::acl::assert_reward_admin(0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::ve_mmt::acl(arg0), arg4);
        assert!(!0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::ve_mmt::is_paused(arg0), 0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::error::e_paused());
        assert!(0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::staking_pool::init_reward_at(arg1) != 0, 0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::error::e_reward_not_initialized());
        0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::assert::assert_additional_ms(arg2, 0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::ve_mmt::ep_config(arg0));
        0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::staking_pool::update_reward_info(arg1, 0x2::clock::timestamp_ms(arg3));
        0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::staking_pool::update_reward_emission(arg1, 0x2::balance::zero<0x35169bc93e1fddfcf3a82a9eae726d349689ed59e4b065369af8789fe59f8608::mmt::MMT>(), arg2, arg4);
    }

    public fun init_reward(arg0: &0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::ve_mmt::VeMMT, arg1: &mut 0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::staking_pool::StakingPool, arg2: u64, arg3: u64, arg4: 0x2::balance::Balance<0x35169bc93e1fddfcf3a82a9eae726d349689ed59e4b065369af8789fe59f8608::mmt::MMT>, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::version::assert_supported_version(0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::ve_mmt::version(arg0));
        0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::acl::assert_reward_admin(0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::ve_mmt::acl(arg0), arg6);
        assert!(!0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::ve_mmt::is_paused(arg0), 0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::error::e_paused());
        assert!(0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::staking_pool::init_reward_at(arg1) == 0, 0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::error::e_reward_already_initialized());
        0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::assert::assert_init_reward_valid(arg2, arg3, arg5, 0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::ve_mmt::ep_config(arg0));
        assert!(0x2::balance::value<0x35169bc93e1fddfcf3a82a9eae726d349689ed59e4b065369af8789fe59f8608::mmt::MMT>(&arg4) > 0, 0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::error::e_invalid_amount());
        0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::staking_pool::init_reward(arg1, arg2);
        0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::staking_pool::update_reward_emission(arg1, arg4, arg3, arg6);
    }

    public fun initialize_pool(arg0: &0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::acl::AdminCap, arg1: &0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::ve_mmt::VeMMT, arg2: &mut 0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::staking_pool::StakingPool, arg3: &0x2::clock::Clock) {
        assert!(0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::staking_pool::current_epoch(arg2) == 0, 0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::error::e_pool_already_initialized());
        0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::staking_pool::initialize(arg2, 0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::ve_mmt::ep_config(arg1), arg3);
    }

    public fun set_pause(arg0: &0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::acl::AdminCap, arg1: &mut 0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::ve_mmt::VeMMT, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 != 0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::ve_mmt::is_paused(arg1), 0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::error::e_no_state_change());
        0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::ve_mmt::set_paused(arg1, arg2);
        let v0 = SetPauseEvent{
            admin  : 0x2::tx_context::sender(arg3),
            paused : arg2,
        };
        0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::event::emit<SetPauseEvent>(v0);
    }

    public fun set_version(arg0: &mut 0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::ve_mmt::VeMMT, arg1: &0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::version::VersionCap, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::ve_mmt::version_mul(arg0);
        0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::version::set_version(v0, arg2, arg3);
        let v1 = SetVersionEvent{
            sender            : 0x2::tx_context::sender(arg4),
            major_version_old : 0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::version::value_major(v0),
            major_version_new : arg2,
            minor_version_old : 0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::version::value_minor(v0),
            minor_version_new : arg3,
        };
        0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::event::emit<SetVersionEvent>(v1);
    }

    public fun update_pool_reward_emission(arg0: &0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::ve_mmt::VeMMT, arg1: &mut 0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::staking_pool::StakingPool, arg2: 0x2::balance::Balance<0x35169bc93e1fddfcf3a82a9eae726d349689ed59e4b065369af8789fe59f8608::mmt::MMT>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::version::assert_supported_version(0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::ve_mmt::version(arg0));
        0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::acl::assert_reward_admin(0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::ve_mmt::acl(arg0), arg5);
        assert!(0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::staking_pool::init_reward_at(arg1) != 0, 0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::error::e_reward_not_initialized());
        assert!(!0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::ve_mmt::is_paused(arg0), 0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::error::e_paused());
        0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::assert::assert_additional_ms(arg3, 0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::ve_mmt::ep_config(arg0));
        assert!(0x2::balance::value<0x35169bc93e1fddfcf3a82a9eae726d349689ed59e4b065369af8789fe59f8608::mmt::MMT>(&arg2) > 0, 0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::error::e_invalid_amount());
        0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::staking_pool::update_reward_info(arg1, 0x2::clock::timestamp_ms(arg4));
        0x23ecc2b1c55a7e1c1c1e5091afee8ffdbbfc7b044d059d536804ad050c0c39f5::staking_pool::update_reward_emission(arg1, arg2, arg3, arg5);
    }

    // decompiled from Move bytecode v6
}

