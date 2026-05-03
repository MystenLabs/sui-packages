module 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::action_validation {
    public fun assert_action_type<T0: drop>(arg0: &0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::ActionSpec) {
        assert!(0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::action_spec_type(arg0) == 0x1::type_name::with_original_ids<T0>(), 0);
    }

    public fun is_action_type<T0: drop>(arg0: &0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::ActionSpec) : bool {
        0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::action_spec_type(arg0) == 0x1::type_name::with_original_ids<T0>()
    }

    // decompiled from Move bytecode v6
}

