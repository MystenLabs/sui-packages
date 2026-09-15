module 0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::pausable {
    struct Pause has copy, drop {
        dummy_field: bool,
    }

    struct Unpause has copy, drop {
        dummy_field: bool,
    }

    entry fun pause(arg0: &mut 0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::state::State, arg1: &0x2::tx_context::TxContext) {
        0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::version_control::assert_object_version_is_compatible_with_package(0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::state::compatible_versions(arg0));
        verify_pauser(arg0, arg1);
        assert!(!0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::state::paused(arg0), 1);
        0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::state::set_paused(arg0, true);
        let v0 = Pause{dummy_field: false};
        0x2::event::emit<Pause>(v0);
    }

    entry fun unpause(arg0: &mut 0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::state::State, arg1: &0x2::tx_context::TxContext) {
        0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::version_control::assert_object_version_is_compatible_with_package(0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::state::compatible_versions(arg0));
        verify_pauser(arg0, arg1);
        assert!(0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::state::paused(arg0), 2);
        0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::state::set_paused(arg0, false);
        let v0 = Unpause{dummy_field: false};
        0x2::event::emit<Unpause>(v0);
    }

    fun verify_pauser(arg0: &0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::state::State, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == 0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::roles::pauser(0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::state::roles(arg0)), 0);
    }

    // decompiled from Move bytecode v7
}

