module 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::message_size {
    struct MaxMessageBodySizeUpdated has copy, drop {
        new_max_message_body_size: u64,
    }

    entry fun set_max_message_body_size(arg0: u64, arg1: &mut 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::state::State, arg2: &0x2::tx_context::TxContext) {
        0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::version_control::assert_object_version_is_compatible_with_package(0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::state::compatible_versions(arg1));
        assert!(0x2::tx_context::sender(arg2) == 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::roles::owner(0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::state::roles(arg1)), 0);
        0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::state::set_max_message_body_size(arg1, arg0);
        let v0 = MaxMessageBodySizeUpdated{new_max_message_body_size: arg0};
        0x2::event::emit<MaxMessageBodySizeUpdated>(v0);
    }

    // decompiled from Move bytecode v6
}

