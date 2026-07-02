module 0x9d6a20f9c4a038d95733a148864412c50927609ead7d6657ec8709932fa88e78::admin {
    public fun action_type_add_operator() : u8 {
        0
    }

    public fun action_type_add_target() : u8 {
        3
    }

    public fun action_type_remove_operator() : u8 {
        5
    }

    public fun action_type_remove_target() : u8 {
        4
    }

    public fun action_type_unpause() : u8 {
        2
    }

    public fun action_type_update_config() : u8 {
        1
    }

    public fun add_target(arg0: &mut 0x9d6a20f9c4a038d95733a148864412c50927609ead7d6657ec8709932fa88e78::vault_core::Vault, arg1: &0x9d6a20f9c4a038d95733a148864412c50927609ead7d6657ec8709932fa88e78::vault_core::AdminCap, arg2: address) {
        0x9d6a20f9c4a038d95733a148864412c50927609ead7d6657ec8709932fa88e78::vault_core::assert_version(arg0);
        assert!(0x9d6a20f9c4a038d95733a148864412c50927609ead7d6657ec8709932fa88e78::vault_core::admin_cap_vault_id(arg1) == 0x9d6a20f9c4a038d95733a148864412c50927609ead7d6657ec8709932fa88e78::vault_core::vault_id(arg0), 0x9d6a20f9c4a038d95733a148864412c50927609ead7d6657ec8709932fa88e78::errors::not_admin());
        0x9d6a20f9c4a038d95733a148864412c50927609ead7d6657ec8709932fa88e78::vault_core::add_allowed_target(arg0, arg2);
    }

    public fun cancel_action(arg0: &mut 0x9d6a20f9c4a038d95733a148864412c50927609ead7d6657ec8709932fa88e78::vault_core::Vault, arg1: &0x9d6a20f9c4a038d95733a148864412c50927609ead7d6657ec8709932fa88e78::vault_core::AdminCap, arg2: u64, arg3: &0x2::clock::Clock) {
        0x9d6a20f9c4a038d95733a148864412c50927609ead7d6657ec8709932fa88e78::vault_core::assert_version(arg0);
        assert!(0x9d6a20f9c4a038d95733a148864412c50927609ead7d6657ec8709932fa88e78::vault_core::has_pending_action(arg0, arg2), 0x9d6a20f9c4a038d95733a148864412c50927609ead7d6657ec8709932fa88e78::errors::action_not_found());
        0x9d6a20f9c4a038d95733a148864412c50927609ead7d6657ec8709932fa88e78::vault_core::remove_pending_action(arg0, arg2);
        0x9d6a20f9c4a038d95733a148864412c50927609ead7d6657ec8709932fa88e78::events::emit_action_cancelled(arg2, 0x2::clock::timestamp_ms(arg3) / 1000);
    }

    public fun collect_fees<T0>(arg0: &mut 0x9d6a20f9c4a038d95733a148864412c50927609ead7d6657ec8709932fa88e78::vault_core::Vault, arg1: &0x9d6a20f9c4a038d95733a148864412c50927609ead7d6657ec8709932fa88e78::vault_core::TreasurerCap, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x9d6a20f9c4a038d95733a148864412c50927609ead7d6657ec8709932fa88e78::vault_core::assert_version(arg0);
        assert!(0x9d6a20f9c4a038d95733a148864412c50927609ead7d6657ec8709932fa88e78::vault_core::treasurer_cap_vault_id(arg1) == 0x2::object::id<0x9d6a20f9c4a038d95733a148864412c50927609ead7d6657ec8709932fa88e78::vault_core::Vault>(arg0), 0x9d6a20f9c4a038d95733a148864412c50927609ead7d6657ec8709932fa88e78::errors::not_treasurer());
        let v0 = 0x9d6a20f9c4a038d95733a148864412c50927609ead7d6657ec8709932fa88e78::pools::fee_drain<T0>(0x9d6a20f9c4a038d95733a148864412c50927609ead7d6657ec8709932fa88e78::vault_core::borrow_fee_pool_mut(arg0));
        0x9d6a20f9c4a038d95733a148864412c50927609ead7d6657ec8709932fa88e78::events::emit_fees_collected(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()), 0x2::balance::value<T0>(&v0), 0x9d6a20f9c4a038d95733a148864412c50927609ead7d6657ec8709932fa88e78::vault_core::cfg_fee_recipient(0x9d6a20f9c4a038d95733a148864412c50927609ead7d6657ec8709932fa88e78::vault_core::config(arg0)), 0x2::clock::timestamp_ms(arg2) / 1000);
        0x2::coin::from_balance<T0>(v0, arg3)
    }

    public fun execute_action(arg0: &mut 0x9d6a20f9c4a038d95733a148864412c50927609ead7d6657ec8709932fa88e78::vault_core::Vault, arg1: &0x9d6a20f9c4a038d95733a148864412c50927609ead7d6657ec8709932fa88e78::vault_core::AdminCap, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x9d6a20f9c4a038d95733a148864412c50927609ead7d6657ec8709932fa88e78::vault_core::assert_version(arg0);
        assert!(0x9d6a20f9c4a038d95733a148864412c50927609ead7d6657ec8709932fa88e78::vault_core::has_pending_action(arg0, arg2), 0x9d6a20f9c4a038d95733a148864412c50927609ead7d6657ec8709932fa88e78::errors::action_not_found());
        let v0 = 0x2::clock::timestamp_ms(arg3) / 1000;
        let v1 = 0x9d6a20f9c4a038d95733a148864412c50927609ead7d6657ec8709932fa88e78::vault_core::remove_pending_action(arg0, arg2);
        assert!(v0 >= 0x9d6a20f9c4a038d95733a148864412c50927609ead7d6657ec8709932fa88e78::vault_core::pending_action_executable_at(&v1), 0x9d6a20f9c4a038d95733a148864412c50927609ead7d6657ec8709932fa88e78::errors::timelock_not_elapsed());
        let v2 = 0x9d6a20f9c4a038d95733a148864412c50927609ead7d6657ec8709932fa88e78::vault_core::pending_action_type(&v1);
        if (v2 == 0) {
            execute_add_operator(arg0, *0x9d6a20f9c4a038d95733a148864412c50927609ead7d6657ec8709932fa88e78::vault_core::pending_action_payload(&v1), arg4);
        } else if (v2 == 1) {
            execute_update_config(arg0, *0x9d6a20f9c4a038d95733a148864412c50927609ead7d6657ec8709932fa88e78::vault_core::pending_action_payload(&v1));
        } else if (v2 == 2) {
            0x9d6a20f9c4a038d95733a148864412c50927609ead7d6657ec8709932fa88e78::vault_core::set_paused(arg0, false, 0);
            0x9d6a20f9c4a038d95733a148864412c50927609ead7d6657ec8709932fa88e78::events::emit_pause(false, v0);
        } else if (v2 == 3) {
            execute_add_target(arg0, *0x9d6a20f9c4a038d95733a148864412c50927609ead7d6657ec8709932fa88e78::vault_core::pending_action_payload(&v1));
        } else if (v2 == 4) {
            execute_remove_target(arg0, *0x9d6a20f9c4a038d95733a148864412c50927609ead7d6657ec8709932fa88e78::vault_core::pending_action_payload(&v1));
        } else if (v2 == 5) {
            execute_remove_operator(arg0, *0x9d6a20f9c4a038d95733a148864412c50927609ead7d6657ec8709932fa88e78::vault_core::pending_action_payload(&v1));
        };
        0x9d6a20f9c4a038d95733a148864412c50927609ead7d6657ec8709932fa88e78::events::emit_action_executed(arg2, v2, v0);
    }

    fun execute_add_operator(arg0: &mut 0x9d6a20f9c4a038d95733a148864412c50927609ead7d6657ec8709932fa88e78::vault_core::Vault, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x9d6a20f9c4a038d95733a148864412c50927609ead7d6657ec8709932fa88e78::vault_core::operators_count(arg0) < (0x9d6a20f9c4a038d95733a148864412c50927609ead7d6657ec8709932fa88e78::vault_core::cfg_max_operators(0x9d6a20f9c4a038d95733a148864412c50927609ead7d6657ec8709932fa88e78::vault_core::config(arg0)) as u64), 0x9d6a20f9c4a038d95733a148864412c50927609ead7d6657ec8709932fa88e78::errors::max_operators_reached());
        let v0 = 0x2::bcs::new(arg1);
        let v1 = 0x2::bcs::peel_address(&mut v0);
        0x9d6a20f9c4a038d95733a148864412c50927609ead7d6657ec8709932fa88e78::vault_core::add_operator(arg0, v1);
        0x2::transfer::public_transfer<0x9d6a20f9c4a038d95733a148864412c50927609ead7d6657ec8709932fa88e78::vault_core::OperatorCap>(0x9d6a20f9c4a038d95733a148864412c50927609ead7d6657ec8709932fa88e78::vault_core::new_operator_cap(0x9d6a20f9c4a038d95733a148864412c50927609ead7d6657ec8709932fa88e78::vault_core::vault_id(arg0), 0x1::ascii::string(0x2::bcs::peel_vec_u8(&mut v0)), arg2), v1);
        0x9d6a20f9c4a038d95733a148864412c50927609ead7d6657ec8709932fa88e78::events::emit_operator_added(v1, 0);
    }

    fun execute_add_target(arg0: &mut 0x9d6a20f9c4a038d95733a148864412c50927609ead7d6657ec8709932fa88e78::vault_core::Vault, arg1: vector<u8>) {
        let v0 = 0x2::bcs::new(arg1);
        0x9d6a20f9c4a038d95733a148864412c50927609ead7d6657ec8709932fa88e78::vault_core::add_allowed_target(arg0, 0x2::bcs::peel_address(&mut v0));
    }

    fun execute_remove_operator(arg0: &mut 0x9d6a20f9c4a038d95733a148864412c50927609ead7d6657ec8709932fa88e78::vault_core::Vault, arg1: vector<u8>) {
        let v0 = 0x2::bcs::new(arg1);
        let v1 = 0x2::bcs::peel_address(&mut v0);
        0x9d6a20f9c4a038d95733a148864412c50927609ead7d6657ec8709932fa88e78::vault_core::remove_operator(arg0, v1);
        0x9d6a20f9c4a038d95733a148864412c50927609ead7d6657ec8709932fa88e78::events::emit_operator_removed(v1, 0);
    }

    fun execute_remove_target(arg0: &mut 0x9d6a20f9c4a038d95733a148864412c50927609ead7d6657ec8709932fa88e78::vault_core::Vault, arg1: vector<u8>) {
        let v0 = 0x2::bcs::new(arg1);
        0x9d6a20f9c4a038d95733a148864412c50927609ead7d6657ec8709932fa88e78::vault_core::remove_allowed_target(arg0, 0x2::bcs::peel_address(&mut v0));
    }

    fun execute_update_config(arg0: &mut 0x9d6a20f9c4a038d95733a148864412c50927609ead7d6657ec8709932fa88e78::vault_core::Vault, arg1: vector<u8>) {
        let v0 = 0x2::bcs::new(arg1);
        let v1 = 0x2::bcs::peel_u64(&mut v0);
        let v2 = 0x2::bcs::peel_u64(&mut v0);
        let v3 = 0x2::bcs::peel_u64(&mut v0);
        let v4 = 0x2::bcs::peel_u64(&mut v0);
        assert!(v1 <= 2000, 0x9d6a20f9c4a038d95733a148864412c50927609ead7d6657ec8709932fa88e78::errors::not_admin());
        assert!(v2 <= 1000, 0x9d6a20f9c4a038d95733a148864412c50927609ead7d6657ec8709932fa88e78::errors::not_admin());
        assert!(v3 <= 100, 0x9d6a20f9c4a038d95733a148864412c50927609ead7d6657ec8709932fa88e78::errors::not_admin());
        assert!(v4 <= 604800, 0x9d6a20f9c4a038d95733a148864412c50927609ead7d6657ec8709932fa88e78::errors::not_admin());
        0x9d6a20f9c4a038d95733a148864412c50927609ead7d6657ec8709932fa88e78::vault_core::replace_config(arg0, 0x9d6a20f9c4a038d95733a148864412c50927609ead7d6657ec8709932fa88e78::vault_core::new_vault_config(v1, v2, v3, 0x2::bcs::peel_u64(&mut v0), 0x2::bcs::peel_u64(&mut v0), 0x2::bcs::peel_u64(&mut v0), 0x2::bcs::peel_u64(&mut v0), 0x2::bcs::peel_u64(&mut v0), 0x2::bcs::peel_u64(&mut v0), 0x2::bcs::peel_u64(&mut v0), 0x2::bcs::peel_u64(&mut v0), 0x2::bcs::peel_u64(&mut v0), 0x2::bcs::peel_u64(&mut v0), 0x2::bcs::peel_u8(&mut v0), 0x2::bcs::peel_u8(&mut v0), 0x2::bcs::peel_u64(&mut v0), 0x2::bcs::peel_u64(&mut v0), v4, 0x2::bcs::peel_address(&mut v0), 0x2::bcs::peel_bool(&mut v0), 0x9d6a20f9c4a038d95733a148864412c50927609ead7d6657ec8709932fa88e78::vault_core::new_operator_rate_limits(0x2::bcs::peel_u64(&mut v0), 0x2::bcs::peel_u64(&mut v0), 0x2::bcs::peel_u64(&mut v0))));
    }

    public fun guardian_pause(arg0: &mut 0x9d6a20f9c4a038d95733a148864412c50927609ead7d6657ec8709932fa88e78::vault_core::Vault, arg1: &0x9d6a20f9c4a038d95733a148864412c50927609ead7d6657ec8709932fa88e78::vault_core::GuardianCap, arg2: &0x2::clock::Clock) {
        0x9d6a20f9c4a038d95733a148864412c50927609ead7d6657ec8709932fa88e78::vault_core::assert_version(arg0);
        assert!(0x9d6a20f9c4a038d95733a148864412c50927609ead7d6657ec8709932fa88e78::vault_core::guardian_cap_vault_id(arg1) == 0x9d6a20f9c4a038d95733a148864412c50927609ead7d6657ec8709932fa88e78::vault_core::vault_id(arg0), 0x9d6a20f9c4a038d95733a148864412c50927609ead7d6657ec8709932fa88e78::errors::not_admin());
        let v0 = 0x2::clock::timestamp_ms(arg2) / 1000;
        0x9d6a20f9c4a038d95733a148864412c50927609ead7d6657ec8709932fa88e78::vault_core::set_paused(arg0, true, v0);
        0x9d6a20f9c4a038d95733a148864412c50927609ead7d6657ec8709932fa88e78::events::emit_pause(true, v0);
    }

    public fun pause(arg0: &mut 0x9d6a20f9c4a038d95733a148864412c50927609ead7d6657ec8709932fa88e78::vault_core::Vault, arg1: &0x9d6a20f9c4a038d95733a148864412c50927609ead7d6657ec8709932fa88e78::vault_core::AdminCap, arg2: &0x2::clock::Clock) {
        0x9d6a20f9c4a038d95733a148864412c50927609ead7d6657ec8709932fa88e78::vault_core::assert_version(arg0);
        let v0 = 0x2::clock::timestamp_ms(arg2) / 1000;
        0x9d6a20f9c4a038d95733a148864412c50927609ead7d6657ec8709932fa88e78::vault_core::set_paused(arg0, true, v0);
        0x9d6a20f9c4a038d95733a148864412c50927609ead7d6657ec8709932fa88e78::events::emit_pause(true, v0);
    }

    public fun propose_action(arg0: &mut 0x9d6a20f9c4a038d95733a148864412c50927609ead7d6657ec8709932fa88e78::vault_core::Vault, arg1: &0x9d6a20f9c4a038d95733a148864412c50927609ead7d6657ec8709932fa88e78::vault_core::AdminCap, arg2: u8, arg3: vector<u8>, arg4: &0x2::clock::Clock) : u64 {
        0x9d6a20f9c4a038d95733a148864412c50927609ead7d6657ec8709932fa88e78::vault_core::assert_version(arg0);
        let v0 = 0x2::clock::timestamp_ms(arg4) / 1000;
        let v1 = 0x9d6a20f9c4a038d95733a148864412c50927609ead7d6657ec8709932fa88e78::vault_core::next_action_nonce(arg0);
        let v2 = v0 + 0x9d6a20f9c4a038d95733a148864412c50927609ead7d6657ec8709932fa88e78::vault_core::timelock_duration(arg0);
        0x9d6a20f9c4a038d95733a148864412c50927609ead7d6657ec8709932fa88e78::vault_core::add_pending_action(arg0, v1, 0x9d6a20f9c4a038d95733a148864412c50927609ead7d6657ec8709932fa88e78::vault_core::new_pending_action(arg2, arg3, v0, v2));
        0x9d6a20f9c4a038d95733a148864412c50927609ead7d6657ec8709932fa88e78::events::emit_action_proposed(v1, arg2, v2, v0);
        v1
    }

    public fun remove_target(arg0: &mut 0x9d6a20f9c4a038d95733a148864412c50927609ead7d6657ec8709932fa88e78::vault_core::Vault, arg1: &0x9d6a20f9c4a038d95733a148864412c50927609ead7d6657ec8709932fa88e78::vault_core::AdminCap, arg2: address) {
        0x9d6a20f9c4a038d95733a148864412c50927609ead7d6657ec8709932fa88e78::vault_core::assert_version(arg0);
        assert!(0x9d6a20f9c4a038d95733a148864412c50927609ead7d6657ec8709932fa88e78::vault_core::admin_cap_vault_id(arg1) == 0x9d6a20f9c4a038d95733a148864412c50927609ead7d6657ec8709932fa88e78::vault_core::vault_id(arg0), 0x9d6a20f9c4a038d95733a148864412c50927609ead7d6657ec8709932fa88e78::errors::not_admin());
        0x9d6a20f9c4a038d95733a148864412c50927609ead7d6657ec8709932fa88e78::vault_core::remove_allowed_target(arg0, arg2);
    }

    public fun set_deposit_cap<T0>(arg0: &mut 0x9d6a20f9c4a038d95733a148864412c50927609ead7d6657ec8709932fa88e78::vault_core::Vault, arg1: &0x9d6a20f9c4a038d95733a148864412c50927609ead7d6657ec8709932fa88e78::vault_core::AdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x9d6a20f9c4a038d95733a148864412c50927609ead7d6657ec8709932fa88e78::vault_core::assert_version(arg0);
        assert!(0x9d6a20f9c4a038d95733a148864412c50927609ead7d6657ec8709932fa88e78::vault_core::admin_cap_vault_id(arg1) == 0x9d6a20f9c4a038d95733a148864412c50927609ead7d6657ec8709932fa88e78::vault_core::vault_id(arg0), 0x9d6a20f9c4a038d95733a148864412c50927609ead7d6657ec8709932fa88e78::errors::not_admin());
        0x9d6a20f9c4a038d95733a148864412c50927609ead7d6657ec8709932fa88e78::vault_core::set_deposit_cap_for<T0>(arg0, arg2, arg3);
    }

    // decompiled from Move bytecode v7
}

