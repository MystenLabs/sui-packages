module 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::pausable {
    struct Pause has copy, drop {
        dummy_field: bool,
    }

    struct Unpause has copy, drop {
        dummy_field: bool,
    }

    entry fun pause(arg0: &mut 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::state::State, arg1: &0x2::tx_context::TxContext) {
        0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::version_control::assert_object_version_is_compatible_with_package(0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::state::compatible_versions(arg0));
        verify_pauser(arg0, arg1);
        assert!(!0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::state::paused(arg0), 1);
        0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::state::set_paused(arg0, true);
        let v0 = Pause{dummy_field: false};
        0x2::event::emit<Pause>(v0);
    }

    entry fun unpause(arg0: &mut 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::state::State, arg1: &0x2::tx_context::TxContext) {
        0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::version_control::assert_object_version_is_compatible_with_package(0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::state::compatible_versions(arg0));
        verify_pauser(arg0, arg1);
        assert!(0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::state::paused(arg0), 2);
        0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::state::set_paused(arg0, false);
        let v0 = Unpause{dummy_field: false};
        0x2::event::emit<Unpause>(v0);
    }

    fun verify_pauser(arg0: &0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::state::State, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::roles::pauser(0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::state::roles(arg0)), 0);
    }

    // decompiled from Move bytecode v6
}

