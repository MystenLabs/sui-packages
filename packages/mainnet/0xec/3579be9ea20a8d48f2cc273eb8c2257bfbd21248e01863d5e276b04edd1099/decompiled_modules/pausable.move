module 0xec3579be9ea20a8d48f2cc273eb8c2257bfbd21248e01863d5e276b04edd1099::pausable {
    struct Pause has copy, drop {
        dummy_field: bool,
    }

    struct Unpause has copy, drop {
        dummy_field: bool,
    }

    entry fun pause(arg0: &mut 0xec3579be9ea20a8d48f2cc273eb8c2257bfbd21248e01863d5e276b04edd1099::state::State, arg1: &0x2::tx_context::TxContext) {
        0xec3579be9ea20a8d48f2cc273eb8c2257bfbd21248e01863d5e276b04edd1099::version_control::assert_object_version_is_compatible_with_package(*0xec3579be9ea20a8d48f2cc273eb8c2257bfbd21248e01863d5e276b04edd1099::state::compatible_versions(arg0));
        verify_pauser(arg0, arg1);
        assert!(!0xec3579be9ea20a8d48f2cc273eb8c2257bfbd21248e01863d5e276b04edd1099::state::paused(arg0), 1);
        0xec3579be9ea20a8d48f2cc273eb8c2257bfbd21248e01863d5e276b04edd1099::state::set_paused(arg0, true);
        let v0 = Pause{dummy_field: false};
        0x2::event::emit<Pause>(v0);
    }

    entry fun unpause(arg0: &mut 0xec3579be9ea20a8d48f2cc273eb8c2257bfbd21248e01863d5e276b04edd1099::state::State, arg1: &0x2::tx_context::TxContext) {
        0xec3579be9ea20a8d48f2cc273eb8c2257bfbd21248e01863d5e276b04edd1099::version_control::assert_object_version_is_compatible_with_package(*0xec3579be9ea20a8d48f2cc273eb8c2257bfbd21248e01863d5e276b04edd1099::state::compatible_versions(arg0));
        verify_pauser(arg0, arg1);
        assert!(0xec3579be9ea20a8d48f2cc273eb8c2257bfbd21248e01863d5e276b04edd1099::state::paused(arg0), 2);
        0xec3579be9ea20a8d48f2cc273eb8c2257bfbd21248e01863d5e276b04edd1099::state::set_paused(arg0, false);
        let v0 = Unpause{dummy_field: false};
        0x2::event::emit<Unpause>(v0);
    }

    fun verify_pauser(arg0: &0xec3579be9ea20a8d48f2cc273eb8c2257bfbd21248e01863d5e276b04edd1099::state::State, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == 0xec3579be9ea20a8d48f2cc273eb8c2257bfbd21248e01863d5e276b04edd1099::roles::pauser(0xec3579be9ea20a8d48f2cc273eb8c2257bfbd21248e01863d5e276b04edd1099::state::roles(arg0)), 0);
    }

    // decompiled from Move bytecode v6
}

