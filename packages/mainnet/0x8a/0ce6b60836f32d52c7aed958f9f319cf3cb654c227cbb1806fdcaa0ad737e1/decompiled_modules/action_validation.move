module 0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::action_validation {
    public fun assert_action_type<T0: drop>(arg0: &0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::ActionSpec) {
        assert!(0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::action_spec_type(arg0) == 0x1::type_name::with_original_ids<T0>(), 0);
    }

    public fun is_action_type<T0: drop>(arg0: &0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::ActionSpec) : bool {
        0x8a0ce6b60836f32d52c7aed958f9f319cf3cb654c227cbb1806fdcaa0ad737e1::intents::action_spec_type(arg0) == 0x1::type_name::with_original_ids<T0>()
    }

    // decompiled from Move bytecode v6
}

