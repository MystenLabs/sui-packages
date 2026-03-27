module 0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::action_validation {
    public fun assert_action_type<T0: drop>(arg0: &0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::intents::ActionSpec) {
        assert!(0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::intents::action_spec_type(arg0) == 0x1::type_name::with_original_ids<T0>(), 0);
    }

    public fun is_action_type<T0: drop>(arg0: &0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::intents::ActionSpec) : bool {
        0x3cacffe79bfedd8d0e1473d8e57b95b729803b680e4badb11a545e5cd2660cf2::intents::action_spec_type(arg0) == 0x1::type_name::with_original_ids<T0>()
    }

    // decompiled from Move bytecode v6
}

