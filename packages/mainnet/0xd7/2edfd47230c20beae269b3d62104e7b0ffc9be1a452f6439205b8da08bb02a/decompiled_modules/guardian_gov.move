module 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::guardian_gov {
    struct RemoveGuardian has drop {
        dummy_field: bool,
    }

    struct RemoveGuardianParams has drop, store {
        pos0: address,
    }

    public fun cancel_admin<T0: drop + store>(arg0: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::CapStore, arg1: &mut 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::Timelock, arg2: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::Auth, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::assert_version(arg0);
        0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::assert_admin_timelock(arg0, arg1);
        0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::assert_has_role<0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::GuardianRole>(arg2, 0x2::tx_context::sender(arg4));
        assert!(0x1::type_name::with_original_ids<T0>() != 0x1::type_name::with_original_ids<RemoveGuardianParams>(), 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::errors::guardian_cannot_cancel());
        0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::cancel_internal<T0>(arg1, arg3, arg4);
    }

    public fun complete_remove_guardian(arg0: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::CapStore, arg1: &mut 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::Auth, arg2: &mut 0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::auth::Auth, arg3: &0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::registry::Registry, arg4: address, arg5: &0x2::tx_context::TxContext) {
        0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::assert_version(arg0);
        0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::assert_has_role<0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::ExecutorRole>(arg1, 0x2::tx_context::sender(arg5));
        assert!(!0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::has_role<0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::GuardianRole>(arg1, arg4), 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::errors::guardian_reappointed());
        0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::take_pending_guardian_removal(arg1, arg4);
        let v0 = if (0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::holds<0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::timelock_cap::TimelockCap>(arg0)) {
            0x1::option::some<0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::timelock_cap::TimelockTicket>(0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::auth::timelock_ticket(arg2, 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::borrow<0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::timelock_cap::TimelockCap>(arg0)))
        } else {
            0x1::option::none<0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::timelock_cap::TimelockTicket>()
        };
        let v1 = 0x1::vector::empty<0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::structs::AddressBool>();
        0x1::vector::push_back<0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::structs::AddressBool>(&mut v1, 0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::structs::new_address_bool(arg4, false));
        0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::admin::update_guardians(arg2, arg3, v0, v1, arg5);
        0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::events::emit_guardian_removal_completed(arg4);
    }

    public fun execute_remove_guardian(arg0: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::CapStore, arg1: &mut 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::Timelock, arg2: &mut 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::Auth, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = RemoveGuardian{dummy_field: false};
        let (_, v2) = 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::consume<RemoveGuardian, RemoveGuardianParams>(arg1, 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::execute_admin<RemoveGuardian, RemoveGuardianParams>(arg0, arg1, arg2, arg3, arg4, arg5), v0);
        let RemoveGuardianParams { pos0: v3 } = v2;
        if (0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::has_role<0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::GuardianRole>(arg2, v3)) {
            0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::revoke_guardian_role<0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::GuardianRole>(arg2, v3);
            if (0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::has_role<0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::AuthCancellerRole>(arg2, v3)) {
                0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::revoke_guardian_role<0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::AuthCancellerRole>(arg2, v3);
            };
        };
        0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::add_pending_guardian_removal(arg2, v3);
        0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::events::emit_guardian_removal_pending(v3);
    }

    public fun schedule_remove_guardian(arg0: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::CapStore, arg1: &mut 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::Timelock, arg2: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::Auth, arg3: address, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : vector<u8> {
        let v0 = RemoveGuardianParams{pos0: arg3};
        0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::schedule_admin<RemoveGuardian, RemoveGuardianParams>(arg0, arg1, arg2, v0, arg4, arg5, arg6)
    }

    // decompiled from Move bytecode v7
}

