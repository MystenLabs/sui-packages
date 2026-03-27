module 0x988f4f9ab9540eeb476be8751ded1b396cca6a43599fadfe7126b55cff6fb356::action_validation {
    public fun assert_action_type<T0: drop>(arg0: &0x988f4f9ab9540eeb476be8751ded1b396cca6a43599fadfe7126b55cff6fb356::intents::ActionSpec) {
        assert!(0x988f4f9ab9540eeb476be8751ded1b396cca6a43599fadfe7126b55cff6fb356::intents::action_spec_type(arg0) == 0x1::type_name::with_original_ids<T0>(), 0);
    }

    public fun is_action_type<T0: drop>(arg0: &0x988f4f9ab9540eeb476be8751ded1b396cca6a43599fadfe7126b55cff6fb356::intents::ActionSpec) : bool {
        0x988f4f9ab9540eeb476be8751ded1b396cca6a43599fadfe7126b55cff6fb356::intents::action_spec_type(arg0) == 0x1::type_name::with_original_ids<T0>()
    }

    // decompiled from Move bytecode v6
}

