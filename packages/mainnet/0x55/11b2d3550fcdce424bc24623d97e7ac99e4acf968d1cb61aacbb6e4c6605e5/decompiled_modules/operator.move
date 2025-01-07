module 0x5511b2d3550fcdce424bc24623d97e7ac99e4acf968d1cb61aacbb6e4c6605e5::operator {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public entry fun create_pool<T0, T1>(arg0: &AdminCap, arg1: &mut 0x5511b2d3550fcdce424bc24623d97e7ac99e4acf968d1cb61aacbb6e4c6605e5::state::State, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x5511b2d3550fcdce424bc24623d97e7ac99e4acf968d1cb61aacbb6e4c6605e5::pool_registry::register<T0, T1>(0x5511b2d3550fcdce424bc24623d97e7ac99e4acf968d1cb61aacbb6e4c6605e5::state::borrow_mut_pool_registry(arg1), 0x5511b2d3550fcdce424bc24623d97e7ac99e4acf968d1cb61aacbb6e4c6605e5::pool::create_pool<T0, T1>(arg2, arg3, arg4, arg5, arg6));
    }

    fun decrease_for<T0, T1>(arg0: &mut 0x5511b2d3550fcdce424bc24623d97e7ac99e4acf968d1cb61aacbb6e4c6605e5::pool::Pool<T0, T1>, arg1: &mut 0x5511b2d3550fcdce424bc24623d97e7ac99e4acf968d1cb61aacbb6e4c6605e5::position::Position, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x5511b2d3550fcdce424bc24623d97e7ac99e4acf968d1cb61aacbb6e4c6605e5::position::decrease(arg1, arg2, arg3);
        0x5511b2d3550fcdce424bc24623d97e7ac99e4acf968d1cb61aacbb6e4c6605e5::custodian::withdraw<T0>(0x5511b2d3550fcdce424bc24623d97e7ac99e4acf968d1cb61aacbb6e4c6605e5::pool::borrow_mut_stake_token_custodian<T0, T1>(arg0), arg2, arg3)
    }

    public entry fun decrease_position<T0, T1>(arg0: &mut 0x5511b2d3550fcdce424bc24623d97e7ac99e4acf968d1cb61aacbb6e4c6605e5::state::State, arg1: &mut 0x5511b2d3550fcdce424bc24623d97e7ac99e4acf968d1cb61aacbb6e4c6605e5::position::Position, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = decrease_position_<T0, T1>(arg0, arg1, arg2, arg3, arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg4));
    }

    public fun decrease_position_<T0, T1>(arg0: &mut 0x5511b2d3550fcdce424bc24623d97e7ac99e4acf968d1cb61aacbb6e4c6605e5::state::State, arg1: &mut 0x5511b2d3550fcdce424bc24623d97e7ac99e4acf968d1cb61aacbb6e4c6605e5::position::Position, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg2 > 0, 3);
        let v0 = 0x5511b2d3550fcdce424bc24623d97e7ac99e4acf968d1cb61aacbb6e4c6605e5::pool_registry::borrow_mut_pool<T0, T1>(0x5511b2d3550fcdce424bc24623d97e7ac99e4acf968d1cb61aacbb6e4c6605e5::state::borrow_mut_pool_registry(arg0), 0x5511b2d3550fcdce424bc24623d97e7ac99e4acf968d1cb61aacbb6e4c6605e5::position::pool_idx(arg1));
        assert!(!0x5511b2d3550fcdce424bc24623d97e7ac99e4acf968d1cb61aacbb6e4c6605e5::pool::is_emergency<T0, T1>(v0), 0);
        assert!(0x5511b2d3550fcdce424bc24623d97e7ac99e4acf968d1cb61aacbb6e4c6605e5::pool::started_at<T0, T1>(v0) > 0x2::clock::timestamp_ms(arg3) || 0x5511b2d3550fcdce424bc24623d97e7ac99e4acf968d1cb61aacbb6e4c6605e5::pool::ended_at<T0, T1>(v0) <= 0x2::clock::timestamp_ms(arg3), 5);
        0x5511b2d3550fcdce424bc24623d97e7ac99e4acf968d1cb61aacbb6e4c6605e5::pool::update_pool<T0, T1>(v0, arg3);
        distribute_pending_reward<T0, T1>(v0, arg1, arg4);
        let v1 = decrease_for<T0, T1>(v0, arg1, arg2, arg4);
        recalc_reward_debt<T0, T1>(v0, arg1);
        v1
    }

    public entry fun decrease_position_emergency<T0, T1>(arg0: &mut 0x5511b2d3550fcdce424bc24623d97e7ac99e4acf968d1cb61aacbb6e4c6605e5::state::State, arg1: &mut 0x5511b2d3550fcdce424bc24623d97e7ac99e4acf968d1cb61aacbb6e4c6605e5::position::Position, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x5511b2d3550fcdce424bc24623d97e7ac99e4acf968d1cb61aacbb6e4c6605e5::pool_registry::borrow_mut_pool<T0, T1>(0x5511b2d3550fcdce424bc24623d97e7ac99e4acf968d1cb61aacbb6e4c6605e5::state::borrow_mut_pool_registry(arg0), 0x5511b2d3550fcdce424bc24623d97e7ac99e4acf968d1cb61aacbb6e4c6605e5::position::pool_idx(arg1));
        assert!(0x5511b2d3550fcdce424bc24623d97e7ac99e4acf968d1cb61aacbb6e4c6605e5::pool::is_emergency<T0, T1>(v0), 1);
        let v1 = 0x5511b2d3550fcdce424bc24623d97e7ac99e4acf968d1cb61aacbb6e4c6605e5::position::value(arg1);
        if (v1 > 0) {
            let v2 = decrease_for<T0, T1>(v0, arg1, v1, arg2);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, 0x2::tx_context::sender(arg2));
        };
    }

    fun distribute_pending_reward<T0, T1>(arg0: &mut 0x5511b2d3550fcdce424bc24623d97e7ac99e4acf968d1cb61aacbb6e4c6605e5::pool::Pool<T0, T1>, arg1: &0x5511b2d3550fcdce424bc24623d97e7ac99e4acf968d1cb61aacbb6e4c6605e5::position::Position, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x5511b2d3550fcdce424bc24623d97e7ac99e4acf968d1cb61aacbb6e4c6605e5::pool::calc_pending_reward<T0, T1>(arg0, arg1);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x5511b2d3550fcdce424bc24623d97e7ac99e4acf968d1cb61aacbb6e4c6605e5::custodian::safe_withdraw<T1>(0x5511b2d3550fcdce424bc24623d97e7ac99e4acf968d1cb61aacbb6e4c6605e5::pool::borrow_mut_reward_token_custodian<T0, T1>(arg0), v0, arg2), 0x2::tx_context::sender(arg2));
        };
    }

    public entry fun harvest<T0, T1>(arg0: &mut 0x5511b2d3550fcdce424bc24623d97e7ac99e4acf968d1cb61aacbb6e4c6605e5::state::State, arg1: &mut 0x5511b2d3550fcdce424bc24623d97e7ac99e4acf968d1cb61aacbb6e4c6605e5::position::Position, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = harvest_<T0, T1>(arg0, arg1, arg2, arg3);
        if (0x2::coin::value<T1>(&v1) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v1, v0);
        } else {
            0x2::coin::destroy_zero<T1>(v1);
        };
    }

    public fun harvest_<T0, T1>(arg0: &mut 0x5511b2d3550fcdce424bc24623d97e7ac99e4acf968d1cb61aacbb6e4c6605e5::state::State, arg1: &mut 0x5511b2d3550fcdce424bc24623d97e7ac99e4acf968d1cb61aacbb6e4c6605e5::position::Position, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x5511b2d3550fcdce424bc24623d97e7ac99e4acf968d1cb61aacbb6e4c6605e5::pool_registry::borrow_mut_pool<T0, T1>(0x5511b2d3550fcdce424bc24623d97e7ac99e4acf968d1cb61aacbb6e4c6605e5::state::borrow_mut_pool_registry(arg0), 0x5511b2d3550fcdce424bc24623d97e7ac99e4acf968d1cb61aacbb6e4c6605e5::position::pool_idx(arg1));
        assert!(!0x5511b2d3550fcdce424bc24623d97e7ac99e4acf968d1cb61aacbb6e4c6605e5::pool::is_emergency<T0, T1>(v0), 0);
        0x5511b2d3550fcdce424bc24623d97e7ac99e4acf968d1cb61aacbb6e4c6605e5::pool::update_pool<T0, T1>(v0, arg2);
        let v1 = if (0x5511b2d3550fcdce424bc24623d97e7ac99e4acf968d1cb61aacbb6e4c6605e5::position::value(arg1) > 0) {
            0x5511b2d3550fcdce424bc24623d97e7ac99e4acf968d1cb61aacbb6e4c6605e5::custodian::safe_withdraw<T1>(0x5511b2d3550fcdce424bc24623d97e7ac99e4acf968d1cb61aacbb6e4c6605e5::pool::borrow_mut_reward_token_custodian<T0, T1>(v0), 0x5511b2d3550fcdce424bc24623d97e7ac99e4acf968d1cb61aacbb6e4c6605e5::pool::calc_pending_reward<T0, T1>(v0, arg1), arg3)
        } else {
            0x2::coin::zero<T1>(arg3)
        };
        recalc_reward_debt<T0, T1>(v0, arg1);
        v1
    }

    fun increase_for<T0, T1>(arg0: &mut 0x5511b2d3550fcdce424bc24623d97e7ac99e4acf968d1cb61aacbb6e4c6605e5::pool::Pool<T0, T1>, arg1: &mut 0x5511b2d3550fcdce424bc24623d97e7ac99e4acf968d1cb61aacbb6e4c6605e5::position::Position, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        0x5511b2d3550fcdce424bc24623d97e7ac99e4acf968d1cb61aacbb6e4c6605e5::position::increase(arg1, 0x2::coin::value<T0>(&arg2), arg3);
        0x5511b2d3550fcdce424bc24623d97e7ac99e4acf968d1cb61aacbb6e4c6605e5::custodian::deposit<T0>(0x5511b2d3550fcdce424bc24623d97e7ac99e4acf968d1cb61aacbb6e4c6605e5::pool::borrow_mut_stake_token_custodian<T0, T1>(arg0), arg2);
    }

    public entry fun increase_position<T0, T1>(arg0: &mut 0x5511b2d3550fcdce424bc24623d97e7ac99e4acf968d1cb61aacbb6e4c6605e5::state::State, arg1: &mut 0x5511b2d3550fcdce424bc24623d97e7ac99e4acf968d1cb61aacbb6e4c6605e5::position::Position, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg2) > 0, 2);
        let v0 = 0x5511b2d3550fcdce424bc24623d97e7ac99e4acf968d1cb61aacbb6e4c6605e5::pool_registry::borrow_mut_pool<T0, T1>(0x5511b2d3550fcdce424bc24623d97e7ac99e4acf968d1cb61aacbb6e4c6605e5::state::borrow_mut_pool_registry(arg0), 0x5511b2d3550fcdce424bc24623d97e7ac99e4acf968d1cb61aacbb6e4c6605e5::position::pool_idx(arg1));
        assert!(!0x5511b2d3550fcdce424bc24623d97e7ac99e4acf968d1cb61aacbb6e4c6605e5::pool::is_emergency<T0, T1>(v0), 0);
        assert!(0x5511b2d3550fcdce424bc24623d97e7ac99e4acf968d1cb61aacbb6e4c6605e5::pool::started_at<T0, T1>(v0) > 0x2::clock::timestamp_ms(arg3), 4);
        0x5511b2d3550fcdce424bc24623d97e7ac99e4acf968d1cb61aacbb6e4c6605e5::pool::update_pool<T0, T1>(v0, arg3);
        increase_for<T0, T1>(v0, arg1, arg2, arg4);
        recalc_reward_debt<T0, T1>(v0, arg1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        0x2::transfer::public_share_object<0x5511b2d3550fcdce424bc24623d97e7ac99e4acf968d1cb61aacbb6e4c6605e5::state::State>(0x5511b2d3550fcdce424bc24623d97e7ac99e4acf968d1cb61aacbb6e4c6605e5::state::new(arg0));
    }

    public entry fun open_position<T0, T1>(arg0: &mut 0x5511b2d3550fcdce424bc24623d97e7ac99e4acf968d1cb61aacbb6e4c6605e5::state::State, arg1: u64, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x5511b2d3550fcdce424bc24623d97e7ac99e4acf968d1cb61aacbb6e4c6605e5::position::new(arg1, arg4);
        let v1 = &mut v0;
        increase_position<T0, T1>(arg0, v1, arg2, arg3, arg4);
        0x2::transfer::public_transfer<0x5511b2d3550fcdce424bc24623d97e7ac99e4acf968d1cb61aacbb6e4c6605e5::position::Position>(v0, 0x2::tx_context::sender(arg4));
    }

    fun recalc_reward_debt<T0, T1>(arg0: &0x5511b2d3550fcdce424bc24623d97e7ac99e4acf968d1cb61aacbb6e4c6605e5::pool::Pool<T0, T1>, arg1: &mut 0x5511b2d3550fcdce424bc24623d97e7ac99e4acf968d1cb61aacbb6e4c6605e5::position::Position) {
        0x5511b2d3550fcdce424bc24623d97e7ac99e4acf968d1cb61aacbb6e4c6605e5::position::change_reward_debt(arg1, 0x5511b2d3550fcdce424bc24623d97e7ac99e4acf968d1cb61aacbb6e4c6605e5::pool::calc_reward_for<T0, T1>(arg0, arg1));
    }

    public entry fun stop_reward<T0, T1>(arg0: &AdminCap, arg1: &mut 0x5511b2d3550fcdce424bc24623d97e7ac99e4acf968d1cb61aacbb6e4c6605e5::state::State, arg2: u64, arg3: &0x2::clock::Clock) {
        let v0 = 0x5511b2d3550fcdce424bc24623d97e7ac99e4acf968d1cb61aacbb6e4c6605e5::pool_registry::borrow_mut_pool<T0, T1>(0x5511b2d3550fcdce424bc24623d97e7ac99e4acf968d1cb61aacbb6e4c6605e5::state::borrow_mut_pool_registry(arg1), arg2);
        0x5511b2d3550fcdce424bc24623d97e7ac99e4acf968d1cb61aacbb6e4c6605e5::pool::stop_reward<T0, T1>(v0, arg3);
        0x5511b2d3550fcdce424bc24623d97e7ac99e4acf968d1cb61aacbb6e4c6605e5::pool::set_emergency<T0, T1>(v0);
    }

    public entry fun update_end_time<T0, T1>(arg0: &AdminCap, arg1: &mut 0x5511b2d3550fcdce424bc24623d97e7ac99e4acf968d1cb61aacbb6e4c6605e5::state::State, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock) {
        0x5511b2d3550fcdce424bc24623d97e7ac99e4acf968d1cb61aacbb6e4c6605e5::pool::set_end_time<T0, T1>(0x5511b2d3550fcdce424bc24623d97e7ac99e4acf968d1cb61aacbb6e4c6605e5::pool_registry::borrow_mut_pool<T0, T1>(0x5511b2d3550fcdce424bc24623d97e7ac99e4acf968d1cb61aacbb6e4c6605e5::state::borrow_mut_pool_registry(arg1), arg2), arg3, arg4);
    }

    public entry fun withdraw_reward<T0, T1>(arg0: &AdminCap, arg1: &mut 0x5511b2d3550fcdce424bc24623d97e7ac99e4acf968d1cb61aacbb6e4c6605e5::state::State, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x5511b2d3550fcdce424bc24623d97e7ac99e4acf968d1cb61aacbb6e4c6605e5::pool_registry::borrow_mut_pool<T0, T1>(0x5511b2d3550fcdce424bc24623d97e7ac99e4acf968d1cb61aacbb6e4c6605e5::state::borrow_mut_pool_registry(arg1), arg2);
        assert!(0x5511b2d3550fcdce424bc24623d97e7ac99e4acf968d1cb61aacbb6e4c6605e5::pool::is_emergency<T0, T1>(v0), 1);
        0x5511b2d3550fcdce424bc24623d97e7ac99e4acf968d1cb61aacbb6e4c6605e5::utils::transfer_or_destroy_zero<T1>(0x5511b2d3550fcdce424bc24623d97e7ac99e4acf968d1cb61aacbb6e4c6605e5::custodian::withdraw_all<T1>(0x5511b2d3550fcdce424bc24623d97e7ac99e4acf968d1cb61aacbb6e4c6605e5::pool::borrow_mut_reward_token_custodian<T0, T1>(v0), arg4), arg3);
    }

    // decompiled from Move bytecode v6
}

