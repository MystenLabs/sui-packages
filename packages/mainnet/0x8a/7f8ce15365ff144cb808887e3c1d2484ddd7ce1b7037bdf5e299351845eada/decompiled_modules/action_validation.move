module 0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::action_validation {
    public fun assert_action_type<T0: drop>(arg0: &0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::intents::ActionSpec) {
        assert!(0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::intents::action_spec_type(arg0) == 0x1::type_name::with_original_ids<T0>(), 0);
    }

    public fun is_action_type<T0: drop>(arg0: &0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::intents::ActionSpec) : bool {
        0x8a7f8ce15365ff144cb808887e3c1d2484ddd7ce1b7037bdf5e299351845eada::intents::action_spec_type(arg0) == 0x1::type_name::with_original_ids<T0>()
    }

    // decompiled from Move bytecode v6
}

