module 0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::game_admin {
    public fun add_verified_caller(arg0: &0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::types::AdminCap, arg1: &mut 0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::types::VerifiedCallers, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 != @0x0, 0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::constants::invalid_address());
        let v0 = 0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::types::verified_callers_allowlist_mut(arg1);
        assert!(!0x2::vec_set::contains<address>(v0, &arg2), 0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::constants::caller_already_added());
        0x2::vec_set::insert<address>(v0, arg2);
        0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::events::emit_caller_added(arg2, 0x2::tx_context::epoch_timestamp_ms(arg3));
    }

    public fun is_caller_verified(arg0: &0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::types::VerifiedCallers, arg1: address) : bool {
        0x2::vec_set::contains<address>(0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::types::verified_callers_allowlist(arg0), &arg1)
    }

    public fun remove_verified_caller(arg0: &0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::types::AdminCap, arg1: &mut 0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::types::VerifiedCallers, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::types::verified_callers_allowlist_mut(arg1);
        assert!(0x2::vec_set::contains<address>(v0, &arg2), 0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::constants::caller_not_found());
        0x2::vec_set::remove<address>(v0, &arg2);
        0x37a7cdec6b07234a7835db8e7f727ceddc8990dbda5b0767fc40974e91b1f0a8::events::emit_caller_removed(arg2, 0x2::tx_context::epoch_timestamp_ms(arg3));
    }

    // decompiled from Move bytecode v6
}

