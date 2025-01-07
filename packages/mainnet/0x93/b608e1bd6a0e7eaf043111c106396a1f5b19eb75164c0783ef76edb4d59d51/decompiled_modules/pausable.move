module 0x93b608e1bd6a0e7eaf043111c106396a1f5b19eb75164c0783ef76edb4d59d51::pausable {
    struct Pause has copy, drop {
        dummy_field: bool,
    }

    struct Unpause has copy, drop {
        dummy_field: bool,
    }

    entry fun pause(arg0: &mut 0x93b608e1bd6a0e7eaf043111c106396a1f5b19eb75164c0783ef76edb4d59d51::state::State, arg1: &0x2::tx_context::TxContext) {
        0x93b608e1bd6a0e7eaf043111c106396a1f5b19eb75164c0783ef76edb4d59d51::version_control::assert_object_version_is_compatible_with_package(*0x93b608e1bd6a0e7eaf043111c106396a1f5b19eb75164c0783ef76edb4d59d51::state::compatible_versions(arg0));
        verify_pauser(arg0, arg1);
        assert!(!0x93b608e1bd6a0e7eaf043111c106396a1f5b19eb75164c0783ef76edb4d59d51::state::paused(arg0), 1);
        0x93b608e1bd6a0e7eaf043111c106396a1f5b19eb75164c0783ef76edb4d59d51::state::set_paused(arg0, true);
        let v0 = Pause{dummy_field: false};
        0x2::event::emit<Pause>(v0);
    }

    entry fun unpause(arg0: &mut 0x93b608e1bd6a0e7eaf043111c106396a1f5b19eb75164c0783ef76edb4d59d51::state::State, arg1: &0x2::tx_context::TxContext) {
        0x93b608e1bd6a0e7eaf043111c106396a1f5b19eb75164c0783ef76edb4d59d51::version_control::assert_object_version_is_compatible_with_package(*0x93b608e1bd6a0e7eaf043111c106396a1f5b19eb75164c0783ef76edb4d59d51::state::compatible_versions(arg0));
        verify_pauser(arg0, arg1);
        assert!(0x93b608e1bd6a0e7eaf043111c106396a1f5b19eb75164c0783ef76edb4d59d51::state::paused(arg0), 2);
        0x93b608e1bd6a0e7eaf043111c106396a1f5b19eb75164c0783ef76edb4d59d51::state::set_paused(arg0, false);
        let v0 = Unpause{dummy_field: false};
        0x2::event::emit<Unpause>(v0);
    }

    fun verify_pauser(arg0: &0x93b608e1bd6a0e7eaf043111c106396a1f5b19eb75164c0783ef76edb4d59d51::state::State, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == 0x93b608e1bd6a0e7eaf043111c106396a1f5b19eb75164c0783ef76edb4d59d51::roles::pauser(0x93b608e1bd6a0e7eaf043111c106396a1f5b19eb75164c0783ef76edb4d59d51::state::roles(arg0)), 0);
    }

    // decompiled from Move bytecode v6
}

