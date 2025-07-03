module 0x42cf58fd8eb079de620f1b5161deaaa923ffbb8e4da0c2f3bdcf71fc4591dc69::staking {
    public entry fun add_stake<T0>(arg0: &mut 0x42cf58fd8eb079de620f1b5161deaaa923ffbb8e4da0c2f3bdcf71fc4591dc69::staking_pool::StakingPool<T0>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: bool, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert_version<T0>(arg0);
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x2::coin::value<T0>(&arg1);
        assert!(v1 > 0, 4);
        assert!(arg2 >= 1 && arg2 <= 52, 1);
        let v2 = 0x42cf58fd8eb079de620f1b5161deaaa923ffbb8e4da0c2f3bdcf71fc4591dc69::staking_pool::min_stake_amount<T0>(arg0);
        if (v2 > 0) {
            assert!(v1 >= v2, 7);
        };
        let v3 = 0x42cf58fd8eb079de620f1b5161deaaa923ffbb8e4da0c2f3bdcf71fc4591dc69::staking_pool::stake<T0>(arg0, 0x2::coin::into_balance<T0>(arg1), v1, arg2, arg3, arg4, v0, arg5);
        0x2::transfer::public_transfer<0x42cf58fd8eb079de620f1b5161deaaa923ffbb8e4da0c2f3bdcf71fc4591dc69::vetoken::VeHAEDAL<T0>>(v3, v0);
        0x42cf58fd8eb079de620f1b5161deaaa923ffbb8e4da0c2f3bdcf71fc4591dc69::Events::emit_stake_event<T0>(v0, 0x1::option::some<0x2::object::ID>(0x2::object::id<0x42cf58fd8eb079de620f1b5161deaaa923ffbb8e4da0c2f3bdcf71fc4591dc69::vetoken::VeHAEDAL<T0>>(&v3)), v1, 0x2::clock::timestamp_ms(arg4) + arg2 * 7 * 3600 * 1000, 0x42cf58fd8eb079de620f1b5161deaaa923ffbb8e4da0c2f3bdcf71fc4591dc69::vetoken::get_initial_amount<T0>(&v3), arg3, arg2);
    }

    public entry fun add_to_existing_stake<T0>(arg0: &mut 0x42cf58fd8eb079de620f1b5161deaaa923ffbb8e4da0c2f3bdcf71fc4591dc69::staking_pool::StakingPool<T0>, arg1: &mut 0x42cf58fd8eb079de620f1b5161deaaa923ffbb8e4da0c2f3bdcf71fc4591dc69::vetoken::VeHAEDAL<T0>, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_version<T0>(arg0);
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::coin::value<T0>(&arg2);
        assert!(0x42cf58fd8eb079de620f1b5161deaaa923ffbb8e4da0c2f3bdcf71fc4591dc69::vetoken::get_owner<T0>(arg1) == v0, 2);
        assert!(v1 > 0, 4);
        let v2 = if (!0x42cf58fd8eb079de620f1b5161deaaa923ffbb8e4da0c2f3bdcf71fc4591dc69::vetoken::is_decaying<T0>(arg1)) {
            0x42cf58fd8eb079de620f1b5161deaaa923ffbb8e4da0c2f3bdcf71fc4591dc69::vetoken::get_remaining_lock_weeks_when_stopped_decay<T0>(arg1)
        } else {
            let v3 = 0x2::clock::timestamp_ms(arg3);
            if (v3 >= 0x42cf58fd8eb079de620f1b5161deaaa923ffbb8e4da0c2f3bdcf71fc4591dc69::vetoken::get_lock_end_time<T0>(arg1)) {
                0
            } else {
                (0x42cf58fd8eb079de620f1b5161deaaa923ffbb8e4da0c2f3bdcf71fc4591dc69::vetoken::get_lock_end_time<T0>(arg1) - v3) / 7 * 3600 * 1000
            }
        };
        assert!(v2 >= 1, 1);
        if (0x42cf58fd8eb079de620f1b5161deaaa923ffbb8e4da0c2f3bdcf71fc4591dc69::vetoken::is_decaying<T0>(arg1)) {
            assert!(!0x42cf58fd8eb079de620f1b5161deaaa923ffbb8e4da0c2f3bdcf71fc4591dc69::vetoken::is_expired<T0>(arg1, arg3), 6);
        };
        0x42cf58fd8eb079de620f1b5161deaaa923ffbb8e4da0c2f3bdcf71fc4591dc69::staking_pool::update_user_stake<T0>(arg0, arg1, 0x2::coin::into_balance<T0>(arg2), v1, arg4);
        0x42cf58fd8eb079de620f1b5161deaaa923ffbb8e4da0c2f3bdcf71fc4591dc69::Events::emit_stake_added_event<T0>(v0, 0x2::object::id<0x42cf58fd8eb079de620f1b5161deaaa923ffbb8e4da0c2f3bdcf71fc4591dc69::vetoken::VeHAEDAL<T0>>(arg1), v1, 0x42cf58fd8eb079de620f1b5161deaaa923ffbb8e4da0c2f3bdcf71fc4591dc69::vetoken::add_locked_amount<T0>(arg1, v1, arg3));
    }

    public fun assert_version<T0>(arg0: &mut 0x42cf58fd8eb079de620f1b5161deaaa923ffbb8e4da0c2f3bdcf71fc4591dc69::staking_pool::StakingPool<T0>) {
        assert!(0x42cf58fd8eb079de620f1b5161deaaa923ffbb8e4da0c2f3bdcf71fc4591dc69::staking_pool::get_version<T0>(arg0) == 0x42cf58fd8eb079de620f1b5161deaaa923ffbb8e4da0c2f3bdcf71fc4591dc69::version::get_program_version(), 8);
    }

    public entry fun create_and_share_pool<T0>(arg0: &0x42cf58fd8eb079de620f1b5161deaaa923ffbb8e4da0c2f3bdcf71fc4591dc69::admin::AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x42cf58fd8eb079de620f1b5161deaaa923ffbb8e4da0c2f3bdcf71fc4591dc69::staking_pool::create_pool<T0>(arg1);
        0x42cf58fd8eb079de620f1b5161deaaa923ffbb8e4da0c2f3bdcf71fc4591dc69::staking_pool::set_min_stake_amount<T0>(&mut v0, 10000000000);
        0x42cf58fd8eb079de620f1b5161deaaa923ffbb8e4da0c2f3bdcf71fc4591dc69::staking_pool::share_pool<T0>(v0);
    }

    public entry fun extend_existing_lock<T0>(arg0: &mut 0x42cf58fd8eb079de620f1b5161deaaa923ffbb8e4da0c2f3bdcf71fc4591dc69::staking_pool::StakingPool<T0>, arg1: &mut 0x42cf58fd8eb079de620f1b5161deaaa923ffbb8e4da0c2f3bdcf71fc4591dc69::vetoken::VeHAEDAL<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_version<T0>(arg0);
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(0x42cf58fd8eb079de620f1b5161deaaa923ffbb8e4da0c2f3bdcf71fc4591dc69::vetoken::get_owner<T0>(arg1) == v0, 2);
        assert!(arg2 > 0 && arg2 <= 52, 1);
        let v1 = if (!0x42cf58fd8eb079de620f1b5161deaaa923ffbb8e4da0c2f3bdcf71fc4591dc69::vetoken::is_decaying<T0>(arg1)) {
            0x42cf58fd8eb079de620f1b5161deaaa923ffbb8e4da0c2f3bdcf71fc4591dc69::vetoken::get_remaining_lock_weeks_when_stopped_decay<T0>(arg1)
        } else {
            let v2 = 0x2::clock::timestamp_ms(arg3);
            if (v2 >= 0x42cf58fd8eb079de620f1b5161deaaa923ffbb8e4da0c2f3bdcf71fc4591dc69::vetoken::get_lock_end_time<T0>(arg1)) {
                0
            } else {
                (0x42cf58fd8eb079de620f1b5161deaaa923ffbb8e4da0c2f3bdcf71fc4591dc69::vetoken::get_lock_end_time<T0>(arg1) - v2) / 7 * 3600 * 1000
            }
        };
        assert!(v1 + arg2 <= 52, 1);
        if (0x42cf58fd8eb079de620f1b5161deaaa923ffbb8e4da0c2f3bdcf71fc4591dc69::vetoken::is_decaying<T0>(arg1)) {
            assert!(!0x42cf58fd8eb079de620f1b5161deaaa923ffbb8e4da0c2f3bdcf71fc4591dc69::vetoken::is_expired<T0>(arg1, arg3), 6);
        };
        let v3 = 0x42cf58fd8eb079de620f1b5161deaaa923ffbb8e4da0c2f3bdcf71fc4591dc69::vetoken::extend_lock<T0>(arg1, arg2, arg3);
        0x42cf58fd8eb079de620f1b5161deaaa923ffbb8e4da0c2f3bdcf71fc4591dc69::staking_pool::update_lock_period<T0>(arg0, 0x42cf58fd8eb079de620f1b5161deaaa923ffbb8e4da0c2f3bdcf71fc4591dc69::vetoken::get_initial_amount<T0>(arg1), v3);
        0x42cf58fd8eb079de620f1b5161deaaa923ffbb8e4da0c2f3bdcf71fc4591dc69::Events::emit_extend_lock_event<T0>(v0, 0x2::object::id<0x42cf58fd8eb079de620f1b5161deaaa923ffbb8e4da0c2f3bdcf71fc4591dc69::vetoken::VeHAEDAL<T0>>(arg1), 0x42cf58fd8eb079de620f1b5161deaaa923ffbb8e4da0c2f3bdcf71fc4591dc69::vetoken::get_lock_end_time<T0>(arg1), v3, arg2);
    }

    public fun get_current_veheadal<T0>(arg0: &0x42cf58fd8eb079de620f1b5161deaaa923ffbb8e4da0c2f3bdcf71fc4591dc69::vetoken::VeHAEDAL<T0>, arg1: &0x2::clock::Clock) : u64 {
        0x42cf58fd8eb079de620f1b5161deaaa923ffbb8e4da0c2f3bdcf71fc4591dc69::vetoken::get_current_value<T0>(arg0, arg1)
    }

    public entry fun start_decay<T0>(arg0: &mut 0x42cf58fd8eb079de620f1b5161deaaa923ffbb8e4da0c2f3bdcf71fc4591dc69::staking_pool::StakingPool<T0>, arg1: &mut 0x42cf58fd8eb079de620f1b5161deaaa923ffbb8e4da0c2f3bdcf71fc4591dc69::vetoken::VeHAEDAL<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert_version<T0>(arg0);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x42cf58fd8eb079de620f1b5161deaaa923ffbb8e4da0c2f3bdcf71fc4591dc69::vetoken::get_owner<T0>(arg1) == v0, 2);
        assert!(!0x42cf58fd8eb079de620f1b5161deaaa923ffbb8e4da0c2f3bdcf71fc4591dc69::vetoken::is_decaying<T0>(arg1), 0);
        0x42cf58fd8eb079de620f1b5161deaaa923ffbb8e4da0c2f3bdcf71fc4591dc69::staking_pool::start_decay<T0>(arg1, arg2);
        0x42cf58fd8eb079de620f1b5161deaaa923ffbb8e4da0c2f3bdcf71fc4591dc69::Events::emit_user_decay_started_event<T0>(v0, 0x2::object::id<0x42cf58fd8eb079de620f1b5161deaaa923ffbb8e4da0c2f3bdcf71fc4591dc69::vetoken::VeHAEDAL<T0>>(arg1), 0, 0);
    }

    public entry fun stop_decay<T0>(arg0: &mut 0x42cf58fd8eb079de620f1b5161deaaa923ffbb8e4da0c2f3bdcf71fc4591dc69::staking_pool::StakingPool<T0>, arg1: &mut 0x42cf58fd8eb079de620f1b5161deaaa923ffbb8e4da0c2f3bdcf71fc4591dc69::vetoken::VeHAEDAL<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert_version<T0>(arg0);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x42cf58fd8eb079de620f1b5161deaaa923ffbb8e4da0c2f3bdcf71fc4591dc69::vetoken::get_owner<T0>(arg1) == v0, 2);
        assert!(0x42cf58fd8eb079de620f1b5161deaaa923ffbb8e4da0c2f3bdcf71fc4591dc69::vetoken::is_decaying<T0>(arg1), 0);
        assert!(!0x42cf58fd8eb079de620f1b5161deaaa923ffbb8e4da0c2f3bdcf71fc4591dc69::vetoken::is_expired<T0>(arg1, arg2), 6);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        let v2 = if (v1 >= 0x42cf58fd8eb079de620f1b5161deaaa923ffbb8e4da0c2f3bdcf71fc4591dc69::vetoken::get_lock_end_time<T0>(arg1)) {
            0
        } else {
            (0x42cf58fd8eb079de620f1b5161deaaa923ffbb8e4da0c2f3bdcf71fc4591dc69::vetoken::get_lock_end_time<T0>(arg1) - v1) / 7 * 3600 * 1000
        };
        assert!(v2 >= 1, 1);
        0x42cf58fd8eb079de620f1b5161deaaa923ffbb8e4da0c2f3bdcf71fc4591dc69::staking_pool::stop_decay<T0>(arg1, arg2);
        0x42cf58fd8eb079de620f1b5161deaaa923ffbb8e4da0c2f3bdcf71fc4591dc69::Events::emit_user_decay_stopped_event<T0>(v0, 0x2::object::id<0x42cf58fd8eb079de620f1b5161deaaa923ffbb8e4da0c2f3bdcf71fc4591dc69::vetoken::VeHAEDAL<T0>>(arg1), 0, 0);
    }

    public entry fun unstake_and_claim<T0>(arg0: &mut 0x42cf58fd8eb079de620f1b5161deaaa923ffbb8e4da0c2f3bdcf71fc4591dc69::staking_pool::StakingPool<T0>, arg1: 0x42cf58fd8eb079de620f1b5161deaaa923ffbb8e4da0c2f3bdcf71fc4591dc69::vetoken::VeHAEDAL<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert_version<T0>(arg0);
        let v0 = 0x2::tx_context::sender(arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(unstake_and_claim_coin<T0>(arg0, arg1, arg2, arg3), v0);
    }

    public fun unstake_and_claim_coin<T0>(arg0: &mut 0x42cf58fd8eb079de620f1b5161deaaa923ffbb8e4da0c2f3bdcf71fc4591dc69::staking_pool::StakingPool<T0>, arg1: 0x42cf58fd8eb079de620f1b5161deaaa923ffbb8e4da0c2f3bdcf71fc4591dc69::vetoken::VeHAEDAL<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_version<T0>(arg0);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x42cf58fd8eb079de620f1b5161deaaa923ffbb8e4da0c2f3bdcf71fc4591dc69::vetoken::get_owner<T0>(&arg1) == v0, 2);
        if (!0x42cf58fd8eb079de620f1b5161deaaa923ffbb8e4da0c2f3bdcf71fc4591dc69::vetoken::is_expired<T0>(&arg1, arg2)) {
            assert!(0x42cf58fd8eb079de620f1b5161deaaa923ffbb8e4da0c2f3bdcf71fc4591dc69::vetoken::is_expired_same_day<T0>(&arg1, arg2), 5);
        };
        assert!(0x42cf58fd8eb079de620f1b5161deaaa923ffbb8e4da0c2f3bdcf71fc4591dc69::vetoken::is_decaying<T0>(&arg1), 0);
        let v1 = 0x42cf58fd8eb079de620f1b5161deaaa923ffbb8e4da0c2f3bdcf71fc4591dc69::staking_pool::unstake_and_claim<T0>(arg0, arg1, arg2, arg3);
        let v2 = 0x2::balance::value<T0>(&v1);
        assert!(v2 > 0, 3);
        0x42cf58fd8eb079de620f1b5161deaaa923ffbb8e4da0c2f3bdcf71fc4591dc69::Events::emit_claim_unstaked_event<T0>(v0, v2, 0x1::option::some<0x2::object::ID>(0x2::object::id<0x42cf58fd8eb079de620f1b5161deaaa923ffbb8e4da0c2f3bdcf71fc4591dc69::vetoken::VeHAEDAL<T0>>(&arg1)));
        0x2::coin::from_balance<T0>(v1, arg3)
    }

    // decompiled from Move bytecode v6
}

