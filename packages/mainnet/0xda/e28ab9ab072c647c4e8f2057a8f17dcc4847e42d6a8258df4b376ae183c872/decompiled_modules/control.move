module 0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::control {
    public entry fun add_operators(arg0: &0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::AdminCap, arg1: &mut 0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::Global, arg2: vector<address>, arg3: &0x2::tx_context::TxContext) {
        0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::check_version(arg1);
        0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::check_is_normal(arg1);
        let v0 = 0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::get_mut_operators(arg1);
        let v1 = 0x1::vector::length<address>(&arg2);
        assert!(v1 > 0, 104);
        let v2 = 0;
        while (v2 < v1) {
            0x2::vec_set::insert<address>(v0, *0x1::vector::borrow<address>(&arg2, v2));
            v2 = v2 + 1;
        };
        0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::event::admin_add_operators_event(0x2::tx_context::sender(arg3), arg2);
    }

    public entry fun control_protocol_fee_switch(arg0: &mut 0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::Global, arg1: bool, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::check_version(arg0);
        0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::check_is_normal(arg0);
        0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::check_operator(arg0, v0);
        0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::control_protocol_fee_switch(arg0, arg1);
        0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::event::operator_control_protocol_fee_switch_event(v0, arg1);
    }

    public entry fun create_pool_by_operator<T0, T1>(arg0: &mut 0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::Global, arg1: 0x1::option::Option<u64>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::check_version(arg0);
        0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::check_is_normal(arg0);
        0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::check_operator(arg0, v0);
        let (v1, v2, v3) = if (0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::comparator::is_order<T0, T1>()) {
            0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::create_pool<T0, T1>(arg0, arg1, arg2, arg3)
        } else {
            0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::create_pool<T1, T0>(arg0, arg1, arg2, arg3)
        };
        0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::event::operator_create_pool_event(v0, v1, v2, v3);
    }

    public entry fun modify_fee_rate<T0, T1>(arg0: &0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::Global, arg1: &mut 0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::Pool<T0, T1>, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::check_version(arg0);
        0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::check_is_normal(arg0);
        0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::check_operator(arg0, v0);
        0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::modify_fee_rate<T0, T1>(arg1, arg2);
        0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::event::operator_modify_fee_rate_event(v0, 0x2::object::id_address<0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::Pool<T0, T1>>(arg1), arg2);
    }

    public entry fun modify_min_add_liquidity_lp_amount<T0, T1>(arg0: &0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::Global, arg1: &mut 0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::Pool<T0, T1>, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::check_version(arg0);
        0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::check_is_normal(arg0);
        0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::check_operator(arg0, v0);
        0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::modify_min_add_liquidity_lp_amount<T0, T1>(arg1, arg2);
        0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::event::operator_modify_min_add_liquidity_lp_amount_event(v0, 0x2::object::id_address<0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::Pool<T0, T1>>(arg1), arg2);
    }

    public entry fun pause(arg0: &mut 0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::Global, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::check_version(arg0);
        assert!(!0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::has_paused(arg0), 101);
        0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::check_operator(arg0, v0);
        0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::pause(arg0);
        0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::event::operator_pause_event(v0);
    }

    public entry fun remove_operators(arg0: &0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::AdminCap, arg1: &mut 0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::Global, arg2: vector<address>, arg3: &0x2::tx_context::TxContext) {
        0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::check_version(arg1);
        0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::check_is_normal(arg1);
        let v0 = 0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::get_mut_operators(arg1);
        let v1 = 0x1::vector::length<address>(&arg2);
        assert!(v1 > 0, 104);
        let v2 = 0;
        while (v2 < v1) {
            0x2::vec_set::remove<address>(v0, 0x1::vector::borrow<address>(&arg2, v2));
            v2 = v2 + 1;
        };
        0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::event::admin_remove_operators_event(0x2::tx_context::sender(arg3), arg2);
    }

    public entry fun resume(arg0: &mut 0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::Global, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::check_version(arg0);
        assert!(0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::has_paused(arg0), 102);
        0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::check_operator(arg0, v0);
        0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::resume(arg0);
        0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::event::operator_resume_event(v0);
    }

    public entry fun transfer_admin_cap(arg0: 0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::AdminCap, arg1: &0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::Global, arg2: address, arg3: &0x2::tx_context::TxContext) {
        0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::check_version(arg1);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(arg2 != v0 && arg2 != @0x0, 103);
        0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::transfer_admin_cap(arg0, arg2);
        0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::event::admin_transfer_admin_cap_event(v0, arg2);
    }

    entry fun upgrade(arg0: &mut 0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::Global, arg1: &0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::AdminCap, arg2: &0x2::tx_context::TxContext) {
        0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::upgrade(arg0);
        0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::event::admin_upgrade_event(0x2::tx_context::sender(arg2));
    }

    public entry fun withdraw<T0, T1>(arg0: &0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::AdminCap, arg1: &0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::Global, arg2: &mut 0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::Pool<T0, T1>, arg3: 0x1::option::Option<address>, arg4: &mut 0x2::tx_context::TxContext) {
        0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::check_version(arg1);
        0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::check_is_normal(arg1);
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = if (0x1::option::is_some<address>(&arg3)) {
            0x1::option::extract<address>(&mut arg3)
        } else {
            v0
        };
        assert!(v1 != @0x0, 105);
        let (v2, v3, v4, v5) = 0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::withdraw<T0, T1>(arg2, arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v2, v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v3, v1);
        0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::event::admin_withdraw_event(v0, v1, 0x2::object::id_address<0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::Pool<T0, T1>>(arg2), 0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::comparator::get_lp_name<T0, T1>(), v4, v5);
    }

    // decompiled from Move bytecode v6
}

