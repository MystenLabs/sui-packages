module 0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::message_size {
    struct MaxMessageBodySizeUpdated has copy, drop {
        new_max_message_body_size: u64,
    }

    entry fun set_max_message_body_size(arg0: u64, arg1: &mut 0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::state::State, arg2: &0x2::tx_context::TxContext) {
        0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::version_control::assert_object_version_is_compatible_with_package(0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::state::compatible_versions(arg1));
        assert!(0x2::tx_context::sender(arg2) == 0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::roles::owner(0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::state::roles(arg1)), 0);
        0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::state::set_max_message_body_size(arg1, arg0);
        let v0 = MaxMessageBodySizeUpdated{new_max_message_body_size: arg0};
        0x2::event::emit<MaxMessageBodySizeUpdated>(v0);
    }

    // decompiled from Move bytecode v7
}

