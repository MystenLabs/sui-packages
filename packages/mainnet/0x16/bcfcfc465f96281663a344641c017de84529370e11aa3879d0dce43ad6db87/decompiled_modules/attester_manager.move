module 0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::attester_manager {
    struct SignatureThresholdUpdated has copy, drop {
        old_signature_threshold: u64,
        new_signature_threshold: u64,
    }

    struct AttesterEnabled has copy, drop {
        attester: address,
    }

    struct AttesterDisabled has copy, drop {
        attester: address,
    }

    entry fun disable_attester(arg0: address, arg1: &mut 0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::state::State, arg2: &0x2::tx_context::TxContext) {
        0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::version_control::assert_object_version_is_compatible_with_package(0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::state::compatible_versions(arg1));
        verify_attester_manager(arg1, arg2);
        let v0 = 0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::state::get_num_enabled_attesters(arg1);
        assert!(v0 > 1, 3);
        assert!(v0 > 0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::state::signature_threshold(arg1), 4);
        assert!(0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::state::is_attester_enabled(arg1, arg0), 1);
        0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::state::disable_attester(arg1, arg0);
        let v1 = AttesterDisabled{attester: arg0};
        0x2::event::emit<AttesterDisabled>(v1);
    }

    entry fun enable_attester(arg0: address, arg1: &mut 0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::state::State, arg2: &0x2::tx_context::TxContext) {
        enable_attester_internal(arg0, arg1, arg2);
    }

    public(friend) fun enable_attester_internal(arg0: address, arg1: &mut 0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::state::State, arg2: &0x2::tx_context::TxContext) {
        0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::version_control::assert_object_version_is_compatible_with_package(0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::state::compatible_versions(arg1));
        verify_attester_manager(arg1, arg2);
        assert!(arg0 != @0x0, 8);
        assert!(!0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::state::is_attester_enabled(arg1, arg0), 0);
        0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::state::enable_attester(arg1, arg0);
        let v0 = AttesterEnabled{attester: arg0};
        0x2::event::emit<AttesterEnabled>(v0);
    }

    entry fun set_signature_threshold(arg0: u64, arg1: &mut 0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::state::State, arg2: &0x2::tx_context::TxContext) {
        0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::version_control::assert_object_version_is_compatible_with_package(0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::state::compatible_versions(arg1));
        verify_attester_manager(arg1, arg2);
        assert!(arg0 != 0, 7);
        assert!(arg0 <= 0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::state::get_num_enabled_attesters(arg1), 6);
        assert!(arg0 != 0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::state::signature_threshold(arg1), 5);
        0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::state::set_signature_threshold(arg1, arg0);
        let v0 = SignatureThresholdUpdated{
            old_signature_threshold : 0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::state::signature_threshold(arg1),
            new_signature_threshold : arg0,
        };
        0x2::event::emit<SignatureThresholdUpdated>(v0);
    }

    fun verify_attester_manager(arg0: &0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::state::State, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == 0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::roles::attester_manager(0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::state::roles(arg0)), 2);
    }

    // decompiled from Move bytecode v7
}

