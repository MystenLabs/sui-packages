module 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::operator {
    struct CustodianDfKey has copy, drop, store {
        dummy_field: bool,
    }

    struct FeeCollectorDfKey has copy, drop, store {
        dummy_field: bool,
    }

    struct Earned has copy, drop {
        amount: u64,
        sender: address,
    }

    fun assert_in_emergency(arg0: &0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::pool::Pool) {
        assert!(0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::pool::is_emergency(arg0), 1);
    }

    fun assert_not_emergency(arg0: &0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::pool::Pool) {
        assert!(!0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::pool::is_emergency(arg0), 0);
    }

    public fun borrow_staked_token_custodian<T0>(arg0: &0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::state::State, arg1: u64) : &0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::custodian::Custodian<T0> {
        let v0 = CustodianDfKey{dummy_field: false};
        0x2::dynamic_field::borrow<CustodianDfKey, 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::custodian::Custodian<T0>>(0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::pool::uid(0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::pool_registry::borrow_pool(0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::state::borrow_pool_registry(arg0), arg1)), v0)
    }

    public entry fun create_pool<T0>(arg0: &0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::admin_cap::AdminCap, arg1: &0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::versioned::Versioned, arg2: &mut 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::state::State, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::versioned::check_version(arg1);
        0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::versioned::check_pause(arg1);
        create_pool_internal<T0>(arg2, arg3, arg4, arg5, arg6);
    }

    fun create_pool_internal<T0>(arg0: &mut 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::state::State, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        mass_update_pool(arg0, arg3);
        let v0 = 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::pool::create_pool(0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::state::started_at(arg0), 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::state::ended_at(arg0), arg1, arg3, arg4);
        let v1 = CustodianDfKey{dummy_field: false};
        0x2::dynamic_field::add<CustodianDfKey, 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::custodian::Custodian<T0>>(0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::pool::uid_mut(&mut v0), v1, 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::custodian::new<T0>());
        let v2 = FeeCollectorDfKey{dummy_field: false};
        0x2::dynamic_field::add<FeeCollectorDfKey, 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::fee_collector::FeeCollector<T0>>(0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::pool::uid_mut(&mut v0), v2, 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::fee_collector::new<T0>(arg2, arg4));
        0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::state::increase_alloc_point(arg0, arg1);
        0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::pool_registry::register(0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::state::borrow_mut_pool_registry(arg0), v0);
    }

    fun decrease_for<T0>(arg0: &mut 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::pool::Pool, arg1: &mut 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::position::Position, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::position::decrease(arg1, arg2, arg3);
        0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::pool::decrease_staked_amount(arg0, arg2);
        let v0 = CustodianDfKey{dummy_field: false};
        0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::custodian::withdraw<T0>(0x2::dynamic_field::borrow_mut<CustodianDfKey, 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::custodian::Custodian<T0>>(0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::pool::uid_mut(arg0), v0), arg2, arg3)
    }

    public entry fun decrease_position<T0>(arg0: &0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::versioned::Versioned, arg1: &mut 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::state::State, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::versioned::check_version(arg0);
        0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::versioned::check_pause(arg0);
        let (v0, v1, v2) = 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::state::borrow_mut_pool_registry_and_position_registry_and_reward_token_custodian(arg1);
        let v3 = 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::pool_registry::borrow_mut_pool(v0, arg2);
        assert_not_emergency(v3);
        let v4 = 0x2::tx_context::sender(arg5);
        let v5 = 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::position_registry::borrow_mut_position(v1, arg2, v4);
        0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::pool::update_pool(v3, 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::state::total_alloc_point(arg1), 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::state::reward_per_sec(arg1), arg4);
        if (0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::position::value(v5) > 0) {
            let v6 = 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::pool::calc_pending_rewards(v3, v5);
            if (v6 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::custodian::safe_withdraw<0x2::sui::SUI>(v2, v6, arg5), v4);
            };
        };
        if (arg3 > 0) {
            let v7 = decrease_for<T0>(v3, v5, arg3, arg5);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v7, v4);
        };
        recalc_reward_debts(v3, v5);
    }

    public entry fun decrease_position_emergency<T0>(arg0: &0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::versioned::Versioned, arg1: &mut 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::state::State, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::versioned::check_version(arg0);
        0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::versioned::check_pause(arg0);
        let (v0, v1, _) = 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::state::borrow_mut_pool_registry_and_position_registry_and_reward_token_custodian(arg1);
        let v3 = 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::pool_registry::borrow_mut_pool(v0, arg2);
        assert_in_emergency(v3);
        let v4 = 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::position_registry::borrow_mut_position(v1, arg2, 0x2::tx_context::sender(arg3));
        let v5 = 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::position::value(v4);
        if (v5 > 0) {
            let v6 = decrease_for<T0>(v3, v4, v5, arg3);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v6, 0x2::tx_context::sender(arg3));
        };
    }

    public entry fun deposit_reward_token_custodian(arg0: &mut 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::state::State, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        let (_, _, v2) = 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::state::borrow_mut_pool_registry_and_position_registry_and_reward_token_custodian(arg0);
        0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::custodian::deposit<0x2::sui::SUI>(v2, arg1);
    }

    fun increase_for<T0>(arg0: &mut 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::pool::Pool, arg1: &mut 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::position::Position, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg2);
        0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::position::increase(arg1, v0, arg3);
        let v1 = CustodianDfKey{dummy_field: false};
        0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::custodian::deposit<T0>(0x2::dynamic_field::borrow_mut<CustodianDfKey, 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::custodian::Custodian<T0>>(0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::pool::uid_mut(arg0), v1), arg2);
        0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::pool::increase_staked_amount(arg0, v0);
    }

    public entry fun increase_position<T0>(arg0: &0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::versioned::Versioned, arg1: &mut 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::state::State, arg2: u64, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::versioned::check_version(arg0);
        0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::versioned::check_pause(arg0);
        let v0 = 0x2::tx_context::sender(arg5);
        let (v1, v2, v3) = 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::state::borrow_mut_pool_registry_and_position_registry_and_reward_token_custodian(arg1);
        let v4 = 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::pool_registry::borrow_mut_pool(v1, arg2);
        assert_not_emergency(v4);
        if (!0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::position_registry::is_registered(v2, arg2, v0)) {
            0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::position_registry::register(v2, arg2, v0, 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::position::new(arg2, arg5));
        };
        let v5 = 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::position_registry::borrow_mut_position(v2, arg2, v0);
        0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::pool::update_pool(v4, 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::state::total_alloc_point(arg1), 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::state::reward_per_sec(arg1), arg4);
        if (0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::position::value(v5) > 0) {
            let v6 = 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::pool::calc_pending_rewards(v4, v5);
            if (v6 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::custodian::safe_withdraw<0x2::sui::SUI>(v3, v6, arg5), v0);
                let v7 = Earned{
                    amount : v6,
                    sender : v0,
                };
                0x2::event::emit<Earned>(v7);
            };
        };
        let v8 = 0x2::coin::value<T0>(&arg3);
        if (v8 > 0) {
            let v9 = FeeCollectorDfKey{dummy_field: false};
            let v10 = 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::fee_collector::fee_amount<T0>(0x2::dynamic_field::borrow<FeeCollectorDfKey, 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::fee_collector::FeeCollector<T0>>(0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::pool::uid(v4), v9), v8);
            if (v10 > 0) {
                let v11 = FeeCollectorDfKey{dummy_field: false};
                0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::fee_collector::deposit<T0>(0x2::dynamic_field::borrow_mut<FeeCollectorDfKey, 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::fee_collector::FeeCollector<T0>>(0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::pool::uid_mut(v4), v11), 0x2::coin::split<T0>(&mut arg3, v10, arg5));
            };
            increase_for<T0>(v4, v5, arg3, arg5);
        } else {
            0x2::coin::destroy_zero<T0>(arg3);
        };
        recalc_reward_debts(v4, v5);
    }

    fun mass_update_pool(arg0: &mut 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::state::State, arg1: &0x2::clock::Clock) {
        let v0 = 0;
        while (v0 < 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::pool_registry::num_pools(0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::state::borrow_pool_registry(arg0))) {
            0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::pool::update_pool(0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::pool_registry::borrow_mut_pool(0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::state::borrow_mut_pool_registry(arg0), v0), 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::state::total_alloc_point(arg0), 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::state::reward_per_sec(arg0), arg1);
            v0 = v0 + 1;
        };
    }

    fun recalc_reward_debts(arg0: &0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::pool::Pool, arg1: &mut 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::position::Position) {
        0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::position::change_reward_debt(arg1, 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::pool::calc_rewards_for(arg0, arg1));
    }

    public entry fun set_alloc_point(arg0: &0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::admin_cap::AdminCap, arg1: &0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::versioned::Versioned, arg2: &mut 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::state::State, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock) {
        0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::versioned::check_version(arg1);
        0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::versioned::check_pause(arg1);
        set_alloc_point_interanl(arg2, arg3, arg4, arg5);
    }

    fun set_alloc_point_interanl(arg0: &mut 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::state::State, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock) {
        mass_update_pool(arg0, arg3);
        let v0 = 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::pool_registry::borrow_mut_pool(0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::state::borrow_mut_pool_registry(arg0), arg1);
        0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::pool::set_alloc_point(v0, arg2);
        0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::state::decrease_alloc_point(arg0, 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::pool::alloc_point(v0));
        0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::state::increase_alloc_point(arg0, arg2);
    }

    public entry fun set_ended_at_sec(arg0: &0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::admin_cap::AdminCap, arg1: &mut 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::state::State, arg2: u64, arg3: &0x2::clock::Clock) {
        set_ended_at_sec_internal(arg1, arg2, arg3);
    }

    public(friend) fun set_ended_at_sec_internal(arg0: &mut 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::state::State, arg1: u64, arg2: &0x2::clock::Clock) {
        let v0 = 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::utils::to_seconds(0x2::clock::timestamp_ms(arg2));
        assert!(arg1 > v0, 3);
        assert!(0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::state::ended_at(arg0) <= v0, 2);
        0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::state::set_ended_at_sec(arg0, arg1);
        let v1 = 0;
        while (v1 < 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::pool_registry::num_pools(0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::state::borrow_pool_registry(arg0))) {
            0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::pool::set_ended_at_sec(0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::pool_registry::borrow_mut_pool(0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::state::borrow_mut_pool_registry(arg0), v1), arg1);
            v1 = v1 + 1;
        };
    }

    public entry fun set_fee_rate<T0>(arg0: &0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::admin_cap::AdminCap, arg1: &mut 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::state::State, arg2: u64, arg3: u64) {
        let v0 = FeeCollectorDfKey{dummy_field: false};
        0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::fee_collector::change_fee<T0>(0x2::dynamic_field::borrow_mut<FeeCollectorDfKey, 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::fee_collector::FeeCollector<T0>>(0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::pool::uid_mut(0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::pool_registry::borrow_mut_pool(0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::state::borrow_mut_pool_registry(arg1), arg2)), v0), arg3);
    }

    public entry fun set_reward_per_sec(arg0: &mut 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::admin_cap::AdminCap, arg1: &mut 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::state::State, arg2: u64, arg3: &0x2::clock::Clock) {
        set_reward_per_sec_internal(arg1, arg2, arg3);
    }

    public(friend) fun set_reward_per_sec_internal(arg0: &mut 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::state::State, arg1: u64, arg2: &0x2::clock::Clock) {
        mass_update_pool(arg0, arg2);
        0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::state::set_reward_per_sec(arg0, arg1);
    }

    public entry fun setup(arg0: &mut 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::admin_cap::AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::state::new(arg1, 0, 0);
        0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::state::set_reward_per_sec(&mut v0, 0);
        0x2::transfer::public_share_object<0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::state::State>(v0);
    }

    public entry fun stop_reward(arg0: &0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::admin_cap::AdminCap, arg1: &mut 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::state::State) {
        let v0 = 0;
        while (v0 < 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::pool_registry::num_pools(0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::state::borrow_pool_registry(arg1))) {
            0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::pool::set_emergency(0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::pool_registry::borrow_mut_pool(0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::state::borrow_mut_pool_registry(arg1), v0));
            v0 = v0 + 1;
        };
        0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::state::set_reward_per_sec(arg1, 0);
    }

    public entry fun withdraw_fee<T0>(arg0: &0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::admin_cap::AdminCap, arg1: &mut 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::state::State, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = FeeCollectorDfKey{dummy_field: false};
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::fee_collector::withdraw_all<T0>(0x2::dynamic_field::borrow_mut<FeeCollectorDfKey, 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::fee_collector::FeeCollector<T0>>(0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::pool::uid_mut(0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::pool_registry::borrow_mut_pool(0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::state::borrow_mut_pool_registry(arg1), arg2)), v0), arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun withdraw_reward_token_custodian(arg0: &mut 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::admin_cap::AdminCap, arg1: &mut 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::state::State, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let (_, _, v2) = 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::state::borrow_mut_pool_registry_and_position_registry_and_reward_token_custodian(arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::custodian::withdraw<0x2::sui::SUI>(v2, arg2, arg4), arg3);
    }

    // decompiled from Move bytecode v6
}

