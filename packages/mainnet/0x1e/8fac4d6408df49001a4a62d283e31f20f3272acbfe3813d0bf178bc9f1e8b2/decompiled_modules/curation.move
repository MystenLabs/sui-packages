module 0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::curation {
    struct ManagerCap<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
    }

    struct ActuatorCap<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
    }

    struct TransferManagerCapWish has drop, store {
        vault: 0x2::object::ID,
        cap_id: 0x2::object::ID,
        recipient: address,
    }

    struct SetTimelockWish has drop, store {
        ms: u64,
    }

    struct SetVaultParamsWish has drop, store {
        params: 0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::config::VaultParams,
    }

    struct SetFeeWish has drop, store {
        fee: 0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::config::FeeStructure,
    }

    struct ChangeManagerWish has drop, store {
        new_manager: address,
    }

    public fun cancel_admin_wish<T0, T1, T2: drop + store>(arg0: &0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::global::SuperAdminCap, arg1: &mut 0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::vault::Vault<T0, T1>, arg2: &0x2::clock::Clock) {
        0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::vault::ensure_version_matches<T0, T1>(arg1);
        0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::timelock::cancel<T2>(0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::vault::borrow_wishes_mut<T0, T1>(arg1), 0x2::object::id<0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::vault::Vault<T0, T1>>(arg1), true, arg2);
    }

    public fun cancel_manager_wish<T0, T1, T2: drop + store>(arg0: &mut 0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::vault::Vault<T0, T1>, arg1: &ManagerCap<T0, T1>, arg2: &0x2::clock::Clock) {
        ensure_manager_allowed<T0, T1>(arg0, arg1);
        0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::timelock::cancel<T2>(0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::vault::borrow_wishes_mut<T0, T1>(arg0), 0x2::object::id<0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::vault::Vault<T0, T1>>(arg0), false, arg2);
    }

    public fun create_vault<T0: drop, T1>(arg0: &0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::global::SuperAdminCap, arg1: &mut 0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::global::VaultRegistry, arg2: T0, arg3: address, arg4: address, arg5: 0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::config::FeeStructure, arg6: 0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::config::VaultParams, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg9);
        let v1 = 0x2::object::uid_to_inner(&v0);
        let v2 = 0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::vault::new_vault<T0, T1>(arg1, arg2, arg6, v1, arg5, arg4, arg7, arg9);
        let v3 = 0x2::object::id<0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::vault::Vault<T0, T1>>(&v2);
        let v4 = ManagerCap<T0, T1>{
            id       : v0,
            vault_id : v3,
        };
        0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::event::emit_vault_created(v3, 0x1::type_name::with_defining_ids<T0>(), 0x1::type_name::with_defining_ids<T1>(), v1, arg3, arg4, arg5, arg6, arg7, 0x2::clock::timestamp_ms(arg8));
        0x2::transfer::transfer<ManagerCap<T0, T1>>(v4, arg3);
        0x2::transfer::public_share_object<0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::vault::Vault<T0, T1>>(v2);
    }

    public(friend) fun ensure_actuator_allowed<T0, T1>(arg0: &0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::vault::Vault<T0, T1>, arg1: &ActuatorCap<T0, T1>) {
        0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::vault::ensure_version_matches<T0, T1>(arg0);
        assert!(0x2::object::id<0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::vault::Vault<T0, T1>>(arg0) == arg1.vault_id, 0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::error::wrong_vault());
        assert!(0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::config::is_actuator_allowed(0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::vault::borrow_config<T0, T1>(arg0), 0x2::object::id<ActuatorCap<T0, T1>>(arg1)), 0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::error::not_allowed());
    }

    public(friend) fun ensure_manager_allowed<T0, T1>(arg0: &0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::vault::Vault<T0, T1>, arg1: &ManagerCap<T0, T1>) {
        0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::vault::ensure_version_matches<T0, T1>(arg0);
        assert!(0x2::object::id<0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::vault::Vault<T0, T1>>(arg0) == arg1.vault_id, 0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::error::wrong_vault());
        assert!(0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::config::is_manager_allowed(0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::vault::borrow_config<T0, T1>(arg0), 0x2::object::id<ManagerCap<T0, T1>>(arg1)), 0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::error::not_allowed());
    }

    public fun execute_change_manager<T0, T1>(arg0: &0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::global::SuperAdminCap, arg1: &mut 0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::vault::Vault<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::vault::ensure_version_matches<T0, T1>(arg1);
        let v0 = 0x2::object::id<0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::vault::Vault<T0, T1>>(arg1);
        let ChangeManagerWish { new_manager: v1 } = 0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::timelock::execute<ChangeManagerWish>(0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::vault::borrow_wishes_mut<T0, T1>(arg1), v0, arg2);
        let v2 = ManagerCap<T0, T1>{
            id       : 0x2::object::new(arg3),
            vault_id : v0,
        };
        0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::config::set_manager(0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::vault::borrow_config_mut<T0, T1>(arg1), 0x2::object::id<ManagerCap<T0, T1>>(&v2));
        0x2::transfer::transfer<ManagerCap<T0, T1>>(v2, v1);
    }

    public fun execute_fee<T0, T1>(arg0: &0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::global::SuperAdminCap, arg1: &mut 0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::vault::Vault<T0, T1>, arg2: &0x2::clock::Clock) {
        0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::vault::ensure_version_matches<T0, T1>(arg1);
        0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::config::ensure_not_circuit_breaked(0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::vault::borrow_config<T0, T1>(arg1));
        let SetFeeWish { fee: v0 } = 0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::timelock::execute<SetFeeWish>(0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::vault::borrow_wishes_mut<T0, T1>(arg1), 0x2::object::id<0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::vault::Vault<T0, T1>>(arg1), arg2);
        0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::config::set_fees(0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::vault::borrow_config_mut<T0, T1>(arg1), v0);
    }

    public fun execute_timelock<T0, T1>(arg0: &mut 0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::vault::Vault<T0, T1>, arg1: &ManagerCap<T0, T1>, arg2: &0x2::clock::Clock) {
        ensure_manager_allowed<T0, T1>(arg0, arg1);
        0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::config::ensure_not_circuit_breaked(0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::vault::borrow_config<T0, T1>(arg0));
        let SetTimelockWish { ms: v0 } = 0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::timelock::execute<SetTimelockWish>(0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::vault::borrow_wishes_mut<T0, T1>(arg0), 0x2::object::id<0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::vault::Vault<T0, T1>>(arg0), arg2);
        0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::config::set_timelock(0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::vault::borrow_config_mut<T0, T1>(arg0), v0);
    }

    public fun execute_update_vault_params<T0, T1>(arg0: &mut 0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::vault::Vault<T0, T1>, arg1: &ManagerCap<T0, T1>, arg2: &0x2::clock::Clock) {
        ensure_manager_allowed<T0, T1>(arg0, arg1);
        0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::config::ensure_not_circuit_breaked(0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::vault::borrow_config<T0, T1>(arg0));
        let SetVaultParamsWish { params: v0 } = 0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::timelock::execute<SetVaultParamsWish>(0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::vault::borrow_wishes_mut<T0, T1>(arg0), 0x2::object::id<0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::vault::Vault<T0, T1>>(arg0), arg2);
        0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::config::set_vault_params(0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::vault::borrow_config_mut<T0, T1>(arg0), v0);
    }

    public fun fulfill_redeem<T0, T1>(arg0: &mut 0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::vault::Vault<T0, T1>, arg1: &mut 0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::global::VaultRegistry, arg2: &ActuatorCap<T0, T1>, arg3: u64, arg4: address, arg5: 0x2::coin::Coin<T1>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        ensure_actuator_allowed<T0, T1>(arg0, arg2);
        0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::config::ensure_not_circuit_breaked(0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::vault::borrow_config<T0, T1>(arg0));
        let v0 = 0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::vault::fulfill_redeem<T0, T1>(arg0, arg1, arg3, arg4, arg6, arg7);
        assert!(0x2::coin::value<T1>(&arg5) >= v0, 0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::error::not_enough_amount());
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::split<T1>(&mut arg5, v0, arg7), arg4);
        0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::event::emit_redeem_fulfilled(0x2::object::id<0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::vault::Vault<T0, T1>>(arg0), 0x2::tx_context::sender(arg7), arg3, arg4, v0, 0x2::clock::timestamp_ms(arg6));
        arg5
    }

    public fun mint_actuator_cap<T0, T1>(arg0: &mut 0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::vault::Vault<T0, T1>, arg1: &ManagerCap<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : ActuatorCap<T0, T1> {
        ensure_manager_allowed<T0, T1>(arg0, arg1);
        let v0 = 0x2::object::id<0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::vault::Vault<T0, T1>>(arg0);
        let v1 = ActuatorCap<T0, T1>{
            id       : 0x2::object::new(arg3),
            vault_id : v0,
        };
        0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::config::set_actuators(0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::vault::borrow_config_mut<T0, T1>(arg0), 0x2::object::id<ActuatorCap<T0, T1>>(&v1), false);
        0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::event::emit_actuator_updated(v0, 0x2::tx_context::sender(arg3), 0x2::object::id<ActuatorCap<T0, T1>>(&v1), true, 0x2::clock::timestamp_ms(arg2));
        v1
    }

    public fun pause<T0, T1>(arg0: &mut 0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::vault::Vault<T0, T1>, arg1: &ActuatorCap<T0, T1>, arg2: u8, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        ensure_actuator_allowed<T0, T1>(arg0, arg1);
        let v0 = 0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::vault::borrow_config_mut<T0, T1>(arg0);
        let v1 = &arg2;
        let v2 = 0;
        if (v1 == &v2) {
            0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::config::set_pause_deposit(v0, true);
        } else {
            let v3 = 1;
            if (v1 == &v3) {
                0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::config::set_pause_redeem(v0, true);
            } else {
                let v4 = 2;
                assert!(v1 == &v4, 0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::error::invalid_pause_kind());
                0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::config::set_pause_withdraw(v0, true);
            };
        };
        0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::event::emit_paused(0x2::object::id<0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::vault::Vault<T0, T1>>(arg0), 0x2::tx_context::sender(arg4), arg2, true, 0x2::clock::timestamp_ms(arg3));
    }

    public fun remove_actuator<T0, T1>(arg0: &mut 0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::vault::Vault<T0, T1>, arg1: &ManagerCap<T0, T1>, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        ensure_manager_allowed<T0, T1>(arg0, arg1);
        0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::config::set_actuators(0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::vault::borrow_config_mut<T0, T1>(arg0), arg2, true);
        0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::event::emit_actuator_updated(0x2::object::id<0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::vault::Vault<T0, T1>>(arg0), 0x2::tx_context::sender(arg4), arg2, false, 0x2::clock::timestamp_ms(arg3));
    }

    public fun transfer_manager_cap<T0, T1>(arg0: &mut 0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::vault::Vault<T0, T1>, arg1: ManagerCap<T0, T1>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        ensure_manager_allowed<T0, T1>(arg0, &arg1);
        0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::config::ensure_not_circuit_breaked(0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::vault::borrow_config<T0, T1>(arg0));
        let v0 = 0x2::object::id<0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::vault::Vault<T0, T1>>(arg0);
        let TransferManagerCapWish {
            vault     : v1,
            cap_id    : v2,
            recipient : v3,
        } = 0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::timelock::execute<TransferManagerCapWish>(0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::vault::borrow_wishes_mut<T0, T1>(arg0), v0, arg2);
        assert!(v1 == v0, 0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::error::wrong_vault());
        assert!(v2 == 0x2::object::id<ManagerCap<T0, T1>>(&arg1), 0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::error::not_allowed());
        0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::event::emit_vault_cap_transferred(v0, 0x2::tx_context::sender(arg3), 0x1::type_name::with_defining_ids<ManagerCap<T0, T1>>(), v3, 0x2::clock::timestamp_ms(arg2));
        0x2::transfer::transfer<ManagerCap<T0, T1>>(arg1, v3);
    }

    public fun unpause<T0, T1>(arg0: &mut 0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::vault::Vault<T0, T1>, arg1: &ManagerCap<T0, T1>, arg2: u8, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        ensure_manager_allowed<T0, T1>(arg0, arg1);
        0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::config::ensure_not_circuit_breaked(0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::vault::borrow_config<T0, T1>(arg0));
        let v0 = 0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::vault::borrow_config_mut<T0, T1>(arg0);
        let v1 = &arg2;
        let v2 = 0;
        if (v1 == &v2) {
            0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::config::set_pause_deposit(v0, false);
        } else {
            let v3 = 1;
            if (v1 == &v3) {
                0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::config::set_pause_redeem(v0, false);
            } else {
                let v4 = 2;
                assert!(v1 == &v4, 0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::error::invalid_pause_kind());
                0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::config::set_pause_withdraw(v0, false);
            };
        };
        0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::event::emit_paused(0x2::object::id<0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::vault::Vault<T0, T1>>(arg0), 0x2::tx_context::sender(arg4), arg2, false, 0x2::clock::timestamp_ms(arg3));
    }

    public fun update_circuit_break<T0, T1>(arg0: &0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::global::SuperAdminCap, arg1: &mut 0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::vault::Vault<T0, T1>, arg2: bool, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::vault::ensure_version_matches<T0, T1>(arg1);
        0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::config::set_circuit_break(0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::vault::borrow_config_mut<T0, T1>(arg1), arg2);
        0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::event::emit_circuit_break(0x2::object::id<0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::vault::Vault<T0, T1>>(arg1), 0x2::tx_context::sender(arg4), arg2, 0x2::clock::timestamp_ms(arg3));
    }

    public fun update_interest_rate<T0, T1>(arg0: &mut 0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::vault::Vault<T0, T1>, arg1: &mut 0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::global::VaultRegistry, arg2: &ManagerCap<T0, T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        ensure_manager_allowed<T0, T1>(arg0, arg2);
        0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::config::ensure_not_circuit_breaked(0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::vault::borrow_config<T0, T1>(arg0));
        assert!(arg3 <= 317097919, 0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::error::invalid_fee());
        0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::vault::update_interest_rate<T0, T1>(arg0, arg1, arg3, arg4, arg5);
    }

    public fun update_timelock<T0, T1>(arg0: &mut 0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::vault::Vault<T0, T1>, arg1: &ManagerCap<T0, T1>, arg2: u64, arg3: &0x2::clock::Clock) {
        ensure_manager_allowed<T0, T1>(arg0, arg1);
        0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::config::ensure_not_circuit_breaked(0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::vault::borrow_config<T0, T1>(arg0));
        0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::config::ensure_valid_timelock(arg2);
        let v0 = 0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::config::timelock(0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::vault::borrow_config<T0, T1>(arg0));
        if (arg2 < v0) {
            let v1 = SetTimelockWish{ms: arg2};
            0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::timelock::submit<SetTimelockWish>(0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::vault::borrow_wishes_mut<T0, T1>(arg0), 0x2::object::id<0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::vault::Vault<T0, T1>>(arg0), v0, v1, false, arg3);
        } else {
            0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::config::set_timelock(0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::vault::borrow_config_mut<T0, T1>(arg0), arg2);
        };
    }

    public fun wish_change_manager<T0, T1>(arg0: &0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::global::SuperAdminCap, arg1: &mut 0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::vault::Vault<T0, T1>, arg2: address, arg3: &0x2::clock::Clock) {
        0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::vault::ensure_version_matches<T0, T1>(arg1);
        let v0 = ChangeManagerWish{new_manager: arg2};
        0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::timelock::submit<ChangeManagerWish>(0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::vault::borrow_wishes_mut<T0, T1>(arg1), 0x2::object::id<0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::vault::Vault<T0, T1>>(arg1), 0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::config::timelock(0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::vault::borrow_config<T0, T1>(arg1)), v0, true, arg3);
    }

    public fun wish_transfer_manager_cap<T0, T1>(arg0: &mut 0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::vault::Vault<T0, T1>, arg1: &ManagerCap<T0, T1>, arg2: address, arg3: &0x2::clock::Clock) {
        ensure_manager_allowed<T0, T1>(arg0, arg1);
        0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::config::ensure_not_circuit_breaked(0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::vault::borrow_config<T0, T1>(arg0));
        let v0 = 0x2::object::id<0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::vault::Vault<T0, T1>>(arg0);
        let v1 = TransferManagerCapWish{
            vault     : v0,
            cap_id    : 0x2::object::id<ManagerCap<T0, T1>>(arg1),
            recipient : arg2,
        };
        0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::timelock::submit<TransferManagerCapWish>(0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::vault::borrow_wishes_mut<T0, T1>(arg0), v0, 0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::config::timelock(0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::vault::borrow_config<T0, T1>(arg0)), v1, false, arg3);
    }

    public fun wish_update_fee<T0, T1>(arg0: &0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::global::SuperAdminCap, arg1: &mut 0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::vault::Vault<T0, T1>, arg2: 0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::config::FeeStructure, arg3: &0x2::clock::Clock) {
        0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::vault::ensure_version_matches<T0, T1>(arg1);
        let v0 = SetFeeWish{fee: arg2};
        0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::timelock::submit<SetFeeWish>(0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::vault::borrow_wishes_mut<T0, T1>(arg1), 0x2::object::id<0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::vault::Vault<T0, T1>>(arg1), 0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::config::timelock(0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::vault::borrow_config<T0, T1>(arg1)), v0, true, arg3);
    }

    public fun wish_update_vault_params<T0, T1>(arg0: &mut 0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::vault::Vault<T0, T1>, arg1: &ManagerCap<T0, T1>, arg2: 0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::config::VaultParams, arg3: &0x2::clock::Clock) {
        ensure_manager_allowed<T0, T1>(arg0, arg1);
        0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::config::ensure_not_circuit_breaked(0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::vault::borrow_config<T0, T1>(arg0));
        let v0 = SetVaultParamsWish{params: arg2};
        0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::timelock::submit<SetVaultParamsWish>(0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::vault::borrow_wishes_mut<T0, T1>(arg0), 0x2::object::id<0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::vault::Vault<T0, T1>>(arg0), 0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::config::timelock(0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::vault::borrow_config<T0, T1>(arg0)), v0, false, arg3);
    }

    public fun withdraw_liquidity<T0, T1>(arg0: &mut 0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::vault::Vault<T0, T1>, arg1: &ActuatorCap<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        ensure_actuator_allowed<T0, T1>(arg0, arg1);
        0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::config::ensure_not_circuit_breaked(0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::vault::borrow_config<T0, T1>(arg0));
        let v0 = 0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::config::custody_recipient(0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::vault::borrow_config<T0, T1>(arg0));
        let v1 = 0x2::coin::from_balance<T1>(0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::vault::empty_liquidity<T0, T1>(arg0), arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v1, v0);
        0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::event::emit_liquidity_withdrawn(0x2::object::id<0x1e8fac4d6408df49001a4a62d283e31f20f3272acbfe3813d0bf178bc9f1e8b2::vault::Vault<T0, T1>>(arg0), 0x2::tx_context::sender(arg3), v0, 0x2::coin::value<T1>(&v1), 0x2::clock::timestamp_ms(arg2));
    }

    // decompiled from Move bytecode v7
}

