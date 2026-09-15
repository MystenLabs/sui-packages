module 0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::pausable {
    struct Pause has copy, drop {
        dummy_field: bool,
    }

    struct Unpause has copy, drop {
        dummy_field: bool,
    }

    entry fun pause(arg0: &mut 0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::state::State, arg1: &0x2::tx_context::TxContext) {
        0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::version_control::assert_object_version_is_compatible_with_package(0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::state::compatible_versions(arg0));
        verify_pauser(arg0, arg1);
        assert!(!0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::state::paused(arg0), 1);
        0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::state::set_paused(arg0, true);
        let v0 = Pause{dummy_field: false};
        0x2::event::emit<Pause>(v0);
    }

    entry fun unpause(arg0: &mut 0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::state::State, arg1: &0x2::tx_context::TxContext) {
        0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::version_control::assert_object_version_is_compatible_with_package(0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::state::compatible_versions(arg0));
        verify_pauser(arg0, arg1);
        assert!(0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::state::paused(arg0), 2);
        0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::state::set_paused(arg0, false);
        let v0 = Unpause{dummy_field: false};
        0x2::event::emit<Unpause>(v0);
    }

    fun verify_pauser(arg0: &0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::state::State, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == 0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::roles::pauser(0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::state::roles(arg0)), 0);
    }

    // decompiled from Move bytecode v7
}

