module 0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::rescuable {
    entry fun rescue_tokens<T0>(arg0: &mut 0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::state::State, arg1: 0x2::transfer::Receiving<0x2::coin::Coin<T0>>, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::version_control::assert_object_version_is_compatible_with_package(0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::state::compatible_versions(arg0));
        0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::state::rescue_coin<T0>(arg0, arg1, arg2, arg3, arg4);
    }

    // decompiled from Move bytecode v7
}

