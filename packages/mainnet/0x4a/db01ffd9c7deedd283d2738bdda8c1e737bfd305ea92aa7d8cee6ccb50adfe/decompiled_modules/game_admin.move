module 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::game_admin {
    public fun add_verified_caller(arg0: &0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::AdminCap, arg1: &mut 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::VerifiedCallers, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 != @0x0, 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::constants::invalid_address());
        let v0 = 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::verified_callers_allowlist_mut(arg1);
        assert!(!0x2::vec_set::contains<address>(v0, &arg2), 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::constants::caller_already_added());
        0x2::vec_set::insert<address>(v0, arg2);
        0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_events::emit_caller_added(arg2, 0x2::tx_context::epoch_timestamp_ms(arg3));
    }

    public fun is_caller_verified(arg0: &0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::VerifiedCallers, arg1: address) : bool {
        0x2::vec_set::contains<address>(0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::verified_callers_allowlist(arg0), &arg1)
    }

    public fun remove_verified_caller(arg0: &0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::AdminCap, arg1: &mut 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::VerifiedCallers, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_types::verified_callers_allowlist_mut(arg1);
        assert!(0x2::vec_set::contains<address>(v0, &arg2), 0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::constants::caller_not_found());
        0x2::vec_set::remove<address>(v0, &arg2);
        0x4adb01ffd9c7deedd283d2738bdda8c1e737bfd305ea92aa7d8cee6ccb50adfe::jolofi_games_events::emit_caller_removed(arg2, 0x2::tx_context::epoch_timestamp_ms(arg3));
    }

    // decompiled from Move bytecode v6
}

