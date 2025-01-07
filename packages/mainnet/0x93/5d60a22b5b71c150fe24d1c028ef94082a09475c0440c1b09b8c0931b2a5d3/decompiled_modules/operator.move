module 0x935d60a22b5b71c150fe24d1c028ef94082a09475c0440c1b09b8c0931b2a5d3::operator {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public entry fun create_pool<T0, T1, T2, T3>(arg0: &mut 0x935d60a22b5b71c150fe24d1c028ef94082a09475c0440c1b09b8c0931b2a5d3::state::State, arg1: 0x2::coin::Coin<T2>, arg2: 0x2::coin::Coin<0x6dae8ca14311574fdfe555524ea48558e3d1360d1607d1c7f98af867e3b7976c::flx::FLX>, arg3: u64, arg4: u64, arg5: 0x2::coin::Coin<T3>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        if (0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::swap_utils::is_ordered<T0, T1>()) {
            0x935d60a22b5b71c150fe24d1c028ef94082a09475c0440c1b09b8c0931b2a5d3::pool_registry::register<T0, T1, T2>(0x935d60a22b5b71c150fe24d1c028ef94082a09475c0440c1b09b8c0931b2a5d3::state::borrow_mut_pool_registry(arg0), 0x935d60a22b5b71c150fe24d1c028ef94082a09475c0440c1b09b8c0931b2a5d3::pool::create_pool<T0, T1, T2>(arg1, arg2, arg3, arg4, arg6, arg7));
        } else {
            0x935d60a22b5b71c150fe24d1c028ef94082a09475c0440c1b09b8c0931b2a5d3::pool_registry::register<T1, T0, T2>(0x935d60a22b5b71c150fe24d1c028ef94082a09475c0440c1b09b8c0931b2a5d3::state::borrow_mut_pool_registry(arg0), 0x935d60a22b5b71c150fe24d1c028ef94082a09475c0440c1b09b8c0931b2a5d3::pool::create_pool<T1, T0, T2>(arg1, arg2, arg3, arg4, arg6, arg7));
        };
        let v0 = 0x935d60a22b5b71c150fe24d1c028ef94082a09475c0440c1b09b8c0931b2a5d3::fee_collector::fee_amount<T3>(0x935d60a22b5b71c150fe24d1c028ef94082a09475c0440c1b09b8c0931b2a5d3::state::borrow_active_fee_collector<T3>(arg0));
        if (v0 > 0) {
            0x935d60a22b5b71c150fe24d1c028ef94082a09475c0440c1b09b8c0931b2a5d3::fee_collector::deposit<T3>(0x935d60a22b5b71c150fe24d1c028ef94082a09475c0440c1b09b8c0931b2a5d3::state::borrow_mut_active_fee_collector<T3>(arg0), 0x2::coin::split<T3>(&mut arg5, v0, arg7));
        };
        0x935d60a22b5b71c150fe24d1c028ef94082a09475c0440c1b09b8c0931b2a5d3::utils::transfer_or_destroy_zero<T3>(arg5, 0x2::tx_context::sender(arg7));
    }

    fun decrease_for<T0, T1, T2>(arg0: &mut 0x935d60a22b5b71c150fe24d1c028ef94082a09475c0440c1b09b8c0931b2a5d3::pool::Pool<T0, T1, T2>, arg1: &mut 0x935d60a22b5b71c150fe24d1c028ef94082a09475c0440c1b09b8c0931b2a5d3::position::Position, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x935d60a22b5b71c150fe24d1c028ef94082a09475c0440c1b09b8c0931b2a5d3::position::decrease(arg1, arg2, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>>>(0x935d60a22b5b71c150fe24d1c028ef94082a09475c0440c1b09b8c0931b2a5d3::custodian::withdraw<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>>(0x935d60a22b5b71c150fe24d1c028ef94082a09475c0440c1b09b8c0931b2a5d3::pool::borrow_mut_lp_custodian<T0, T1, T2>(arg0), arg2, arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun decrease_position<T0, T1, T2>(arg0: &mut 0x935d60a22b5b71c150fe24d1c028ef94082a09475c0440c1b09b8c0931b2a5d3::state::State, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x935d60a22b5b71c150fe24d1c028ef94082a09475c0440c1b09b8c0931b2a5d3::state::borrow_mut_pool_registry_and_position_registry(arg0);
        let v2 = 0x935d60a22b5b71c150fe24d1c028ef94082a09475c0440c1b09b8c0931b2a5d3::pool_registry::borrow_mut_pool<T0, T1, T2>(v0, arg1);
        assert!(!0x935d60a22b5b71c150fe24d1c028ef94082a09475c0440c1b09b8c0931b2a5d3::pool::is_emergency<T0, T1, T2>(v2), 2);
        let v3 = 0x935d60a22b5b71c150fe24d1c028ef94082a09475c0440c1b09b8c0931b2a5d3::position_registry::borrow_mut_position(v1, arg1, 0x2::tx_context::sender(arg4));
        0x935d60a22b5b71c150fe24d1c028ef94082a09475c0440c1b09b8c0931b2a5d3::pool::update_pool<T0, T1, T2>(v2, arg3);
        if (0x935d60a22b5b71c150fe24d1c028ef94082a09475c0440c1b09b8c0931b2a5d3::position::value(v3) > 0) {
            distribute_pending_rewards<T0, T1, T2>(v2, v3, arg4);
        };
        if (arg2 > 0) {
            decrease_for<T0, T1, T2>(v2, v3, arg2, arg4);
        };
        recalc_reward_debts<T0, T1, T2>(v2, v3);
    }

    public entry fun decrease_position_emergency<T0, T1, T2>(arg0: &mut 0x935d60a22b5b71c150fe24d1c028ef94082a09475c0440c1b09b8c0931b2a5d3::state::State, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x935d60a22b5b71c150fe24d1c028ef94082a09475c0440c1b09b8c0931b2a5d3::state::borrow_mut_pool_registry_and_position_registry(arg0);
        let v2 = 0x935d60a22b5b71c150fe24d1c028ef94082a09475c0440c1b09b8c0931b2a5d3::pool_registry::borrow_mut_pool<T0, T1, T2>(v0, arg1);
        assert!(0x935d60a22b5b71c150fe24d1c028ef94082a09475c0440c1b09b8c0931b2a5d3::pool::is_emergency<T0, T1, T2>(v2), 1);
        let v3 = 0x935d60a22b5b71c150fe24d1c028ef94082a09475c0440c1b09b8c0931b2a5d3::position_registry::borrow_mut_position(v1, arg1, 0x2::tx_context::sender(arg2));
        let v4 = 0x935d60a22b5b71c150fe24d1c028ef94082a09475c0440c1b09b8c0931b2a5d3::position::value(v3);
        if (v4 > 0) {
            decrease_for<T0, T1, T2>(v2, v3, v4, arg2);
        };
    }

    fun distribute_pending_rewards<T0, T1, T2>(arg0: &mut 0x935d60a22b5b71c150fe24d1c028ef94082a09475c0440c1b09b8c0931b2a5d3::pool::Pool<T0, T1, T2>, arg1: &0x935d60a22b5b71c150fe24d1c028ef94082a09475c0440c1b09b8c0931b2a5d3::position::Position, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let (v1, v2) = 0x935d60a22b5b71c150fe24d1c028ef94082a09475c0440c1b09b8c0931b2a5d3::pool::calc_pending_rewards<T0, T1, T2>(arg0, arg1);
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x935d60a22b5b71c150fe24d1c028ef94082a09475c0440c1b09b8c0931b2a5d3::custodian::safe_withdraw<T2>(0x935d60a22b5b71c150fe24d1c028ef94082a09475c0440c1b09b8c0931b2a5d3::pool::borrow_mut_reward_token_custodian<T0, T1, T2>(arg0), v1, arg2), v0);
        };
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x6dae8ca14311574fdfe555524ea48558e3d1360d1607d1c7f98af867e3b7976c::flx::FLX>>(0x935d60a22b5b71c150fe24d1c028ef94082a09475c0440c1b09b8c0931b2a5d3::custodian::safe_withdraw<0x6dae8ca14311574fdfe555524ea48558e3d1360d1607d1c7f98af867e3b7976c::flx::FLX>(0x935d60a22b5b71c150fe24d1c028ef94082a09475c0440c1b09b8c0931b2a5d3::pool::borrow_mut_flx_custodian<T0, T1, T2>(arg0), v2, arg2), v0);
        };
    }

    fun increase_for<T0, T1, T2>(arg0: &mut 0x935d60a22b5b71c150fe24d1c028ef94082a09475c0440c1b09b8c0931b2a5d3::pool::Pool<T0, T1, T2>, arg1: &mut 0x935d60a22b5b71c150fe24d1c028ef94082a09475c0440c1b09b8c0931b2a5d3::position::Position, arg2: 0x2::coin::Coin<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>>, arg3: &mut 0x2::tx_context::TxContext) {
        0x935d60a22b5b71c150fe24d1c028ef94082a09475c0440c1b09b8c0931b2a5d3::position::increase(arg1, 0x2::coin::value<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>>(&arg2), arg3);
        0x935d60a22b5b71c150fe24d1c028ef94082a09475c0440c1b09b8c0931b2a5d3::custodian::deposit<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>>(0x935d60a22b5b71c150fe24d1c028ef94082a09475c0440c1b09b8c0931b2a5d3::pool::borrow_mut_lp_custodian<T0, T1, T2>(arg0), arg2);
    }

    public entry fun increase_position<T0, T1, T2>(arg0: &mut 0x935d60a22b5b71c150fe24d1c028ef94082a09475c0440c1b09b8c0931b2a5d3::state::State, arg1: u64, arg2: 0x2::coin::Coin<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x935d60a22b5b71c150fe24d1c028ef94082a09475c0440c1b09b8c0931b2a5d3::state::borrow_mut_pool_registry_and_position_registry(arg0);
        let v2 = 0x935d60a22b5b71c150fe24d1c028ef94082a09475c0440c1b09b8c0931b2a5d3::pool_registry::borrow_mut_pool<T0, T1, T2>(v0, arg1);
        assert!(!0x935d60a22b5b71c150fe24d1c028ef94082a09475c0440c1b09b8c0931b2a5d3::pool::is_emergency<T0, T1, T2>(v2), 2);
        let v3 = 0x935d60a22b5b71c150fe24d1c028ef94082a09475c0440c1b09b8c0931b2a5d3::position_registry::borrow_mut_position(v1, arg1, 0x2::tx_context::sender(arg4));
        0x935d60a22b5b71c150fe24d1c028ef94082a09475c0440c1b09b8c0931b2a5d3::pool::update_pool<T0, T1, T2>(v2, arg3);
        if (0x935d60a22b5b71c150fe24d1c028ef94082a09475c0440c1b09b8c0931b2a5d3::position::value(v3) > 0) {
            distribute_pending_rewards<T0, T1, T2>(v2, v3, arg4);
        };
        if (0x2::coin::value<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>>(&arg2) > 0) {
            increase_for<T0, T1, T2>(v2, v3, arg2, arg4);
        } else {
            0x2::coin::destroy_zero<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>>(arg2);
        };
        recalc_reward_debts<T0, T1, T2>(v2, v3);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun open_position<T0, T1, T2>(arg0: &mut 0x935d60a22b5b71c150fe24d1c028ef94082a09475c0440c1b09b8c0931b2a5d3::state::State, arg1: u64, arg2: 0x2::coin::Coin<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x935d60a22b5b71c150fe24d1c028ef94082a09475c0440c1b09b8c0931b2a5d3::pool_registry::borrow_mut_pool<T0, T1, T2>(0x935d60a22b5b71c150fe24d1c028ef94082a09475c0440c1b09b8c0931b2a5d3::state::borrow_mut_pool_registry(arg0), arg1);
        assert!(!0x935d60a22b5b71c150fe24d1c028ef94082a09475c0440c1b09b8c0931b2a5d3::pool::is_emergency<T0, T1, T2>(v0), 2);
        0x935d60a22b5b71c150fe24d1c028ef94082a09475c0440c1b09b8c0931b2a5d3::pool::update_pool<T0, T1, T2>(v0, arg3);
        let v1 = 0x935d60a22b5b71c150fe24d1c028ef94082a09475c0440c1b09b8c0931b2a5d3::position::new(arg1, arg4);
        if (0x2::coin::value<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>>(&arg2) > 0) {
            let v2 = &mut v1;
            increase_for<T0, T1, T2>(v0, v2, arg2, arg4);
        } else {
            0x2::coin::destroy_zero<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>>(arg2);
        };
        let v3 = &mut v1;
        recalc_reward_debts<T0, T1, T2>(v0, v3);
        0x935d60a22b5b71c150fe24d1c028ef94082a09475c0440c1b09b8c0931b2a5d3::position_registry::register(0x935d60a22b5b71c150fe24d1c028ef94082a09475c0440c1b09b8c0931b2a5d3::state::borrow_mut_position_registry(arg0), arg1, 0x2::tx_context::sender(arg4), v1);
    }

    fun recalc_reward_debts<T0, T1, T2>(arg0: &0x935d60a22b5b71c150fe24d1c028ef94082a09475c0440c1b09b8c0931b2a5d3::pool::Pool<T0, T1, T2>, arg1: &mut 0x935d60a22b5b71c150fe24d1c028ef94082a09475c0440c1b09b8c0931b2a5d3::position::Position) {
        let (v0, v1) = 0x935d60a22b5b71c150fe24d1c028ef94082a09475c0440c1b09b8c0931b2a5d3::pool::calc_rewards_for<T0, T1, T2>(arg0, arg1);
        0x935d60a22b5b71c150fe24d1c028ef94082a09475c0440c1b09b8c0931b2a5d3::position::change_token_reward_debt(arg1, v0);
        0x935d60a22b5b71c150fe24d1c028ef94082a09475c0440c1b09b8c0931b2a5d3::position::change_flx_reward_debt(arg1, v1);
    }

    public entry fun register_fee_collector<T0>(arg0: &AdminCap, arg1: &mut 0x935d60a22b5b71c150fe24d1c028ef94082a09475c0440c1b09b8c0931b2a5d3::state::State, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x935d60a22b5b71c150fe24d1c028ef94082a09475c0440c1b09b8c0931b2a5d3::state::register_active_fee_collector<T0>(arg1, 0x935d60a22b5b71c150fe24d1c028ef94082a09475c0440c1b09b8c0931b2a5d3::fee_collector::new<T0>(arg2, arg3));
    }

    public entry fun set_fee_amount<T0>(arg0: &AdminCap, arg1: &mut 0x935d60a22b5b71c150fe24d1c028ef94082a09475c0440c1b09b8c0931b2a5d3::state::State, arg2: u64) {
        0x935d60a22b5b71c150fe24d1c028ef94082a09475c0440c1b09b8c0931b2a5d3::fee_collector::change_fee<T0>(0x935d60a22b5b71c150fe24d1c028ef94082a09475c0440c1b09b8c0931b2a5d3::state::borrow_mut_active_fee_collector<T0>(arg1), arg2);
    }

    public entry fun setup(arg0: &AdminCap, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_share_object<0x935d60a22b5b71c150fe24d1c028ef94082a09475c0440c1b09b8c0931b2a5d3::state::State>(0x935d60a22b5b71c150fe24d1c028ef94082a09475c0440c1b09b8c0931b2a5d3::state::new(arg1, arg2));
    }

    public entry fun stop_reward<T0, T1, T2>(arg0: &AdminCap, arg1: &mut 0x935d60a22b5b71c150fe24d1c028ef94082a09475c0440c1b09b8c0931b2a5d3::state::State, arg2: u64, arg3: &0x2::clock::Clock) {
        let v0 = 0x935d60a22b5b71c150fe24d1c028ef94082a09475c0440c1b09b8c0931b2a5d3::pool_registry::borrow_mut_pool<T0, T1, T2>(0x935d60a22b5b71c150fe24d1c028ef94082a09475c0440c1b09b8c0931b2a5d3::state::borrow_mut_pool_registry(arg1), arg2);
        0x935d60a22b5b71c150fe24d1c028ef94082a09475c0440c1b09b8c0931b2a5d3::pool::stop_reward<T0, T1, T2>(v0, arg3);
        0x935d60a22b5b71c150fe24d1c028ef94082a09475c0440c1b09b8c0931b2a5d3::pool::set_emergency<T0, T1, T2>(v0);
    }

    public entry fun update_end_time<T0, T1, T2>(arg0: &mut 0x935d60a22b5b71c150fe24d1c028ef94082a09475c0440c1b09b8c0931b2a5d3::state::State, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x935d60a22b5b71c150fe24d1c028ef94082a09475c0440c1b09b8c0931b2a5d3::pool::set_end_time<T0, T1, T2>(0x935d60a22b5b71c150fe24d1c028ef94082a09475c0440c1b09b8c0931b2a5d3::pool_registry::borrow_mut_pool<T0, T1, T2>(0x935d60a22b5b71c150fe24d1c028ef94082a09475c0440c1b09b8c0931b2a5d3::state::borrow_mut_pool_registry(arg0), arg1), arg2, arg3, arg4);
    }

    public entry fun withdraw_fee<T0>(arg0: &AdminCap, arg1: &mut 0x935d60a22b5b71c150fe24d1c028ef94082a09475c0440c1b09b8c0931b2a5d3::state::State, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x935d60a22b5b71c150fe24d1c028ef94082a09475c0440c1b09b8c0931b2a5d3::fee_collector::withdraw<T0>(0x935d60a22b5b71c150fe24d1c028ef94082a09475c0440c1b09b8c0931b2a5d3::state::borrow_mut_active_fee_collector<T0>(arg1), arg2, arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun withdraw_rewards<T0, T1, T2>(arg0: &AdminCap, arg1: &mut 0x935d60a22b5b71c150fe24d1c028ef94082a09475c0440c1b09b8c0931b2a5d3::state::State, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x935d60a22b5b71c150fe24d1c028ef94082a09475c0440c1b09b8c0931b2a5d3::pool_registry::borrow_mut_pool<T0, T1, T2>(0x935d60a22b5b71c150fe24d1c028ef94082a09475c0440c1b09b8c0931b2a5d3::state::borrow_mut_pool_registry(arg1), arg2);
        assert!(0x935d60a22b5b71c150fe24d1c028ef94082a09475c0440c1b09b8c0931b2a5d3::pool::is_emergency<T0, T1, T2>(v0), 1);
        0x935d60a22b5b71c150fe24d1c028ef94082a09475c0440c1b09b8c0931b2a5d3::utils::transfer_or_destroy_zero<T2>(0x935d60a22b5b71c150fe24d1c028ef94082a09475c0440c1b09b8c0931b2a5d3::custodian::withdraw_all<T2>(0x935d60a22b5b71c150fe24d1c028ef94082a09475c0440c1b09b8c0931b2a5d3::pool::borrow_mut_reward_token_custodian<T0, T1, T2>(v0), arg4), arg3);
        0x935d60a22b5b71c150fe24d1c028ef94082a09475c0440c1b09b8c0931b2a5d3::utils::transfer_or_destroy_zero<0x6dae8ca14311574fdfe555524ea48558e3d1360d1607d1c7f98af867e3b7976c::flx::FLX>(0x935d60a22b5b71c150fe24d1c028ef94082a09475c0440c1b09b8c0931b2a5d3::custodian::withdraw_all<0x6dae8ca14311574fdfe555524ea48558e3d1360d1607d1c7f98af867e3b7976c::flx::FLX>(0x935d60a22b5b71c150fe24d1c028ef94082a09475c0440c1b09b8c0931b2a5d3::pool::borrow_mut_flx_custodian<T0, T1, T2>(v0), arg4), arg3);
    }

    // decompiled from Move bytecode v6
}

