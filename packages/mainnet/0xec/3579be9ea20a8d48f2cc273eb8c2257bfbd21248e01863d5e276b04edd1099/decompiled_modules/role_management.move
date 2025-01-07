module 0xec3579be9ea20a8d48f2cc273eb8c2257bfbd21248e01863d5e276b04edd1099::role_management {
    struct AttesterManagerUpdated has copy, drop {
        previous_attester_manager: address,
        new_attester_manager: address,
    }

    struct PauserChanged has copy, drop {
        new_pauser: address,
    }

    entry fun accept_ownership(arg0: &mut 0xec3579be9ea20a8d48f2cc273eb8c2257bfbd21248e01863d5e276b04edd1099::state::State, arg1: &0x2::tx_context::TxContext) {
        0xec3579be9ea20a8d48f2cc273eb8c2257bfbd21248e01863d5e276b04edd1099::version_control::assert_object_version_is_compatible_with_package(*0xec3579be9ea20a8d48f2cc273eb8c2257bfbd21248e01863d5e276b04edd1099::state::compatible_versions(arg0));
        0xe0917b74a5912e4ad186ac634e29c922ab83903f71af7500969f9411706f9b9a::two_step_role::accept_role<0xec3579be9ea20a8d48f2cc273eb8c2257bfbd21248e01863d5e276b04edd1099::roles::OwnerRole>(0xec3579be9ea20a8d48f2cc273eb8c2257bfbd21248e01863d5e276b04edd1099::roles::owner_role_mut(0xec3579be9ea20a8d48f2cc273eb8c2257bfbd21248e01863d5e276b04edd1099::state::roles_mut(arg0)), arg1);
    }

    entry fun transfer_ownership(arg0: address, arg1: &mut 0xec3579be9ea20a8d48f2cc273eb8c2257bfbd21248e01863d5e276b04edd1099::state::State, arg2: &0x2::tx_context::TxContext) {
        0xec3579be9ea20a8d48f2cc273eb8c2257bfbd21248e01863d5e276b04edd1099::version_control::assert_object_version_is_compatible_with_package(*0xec3579be9ea20a8d48f2cc273eb8c2257bfbd21248e01863d5e276b04edd1099::state::compatible_versions(arg1));
        0xe0917b74a5912e4ad186ac634e29c922ab83903f71af7500969f9411706f9b9a::two_step_role::begin_role_transfer<0xec3579be9ea20a8d48f2cc273eb8c2257bfbd21248e01863d5e276b04edd1099::roles::OwnerRole>(0xec3579be9ea20a8d48f2cc273eb8c2257bfbd21248e01863d5e276b04edd1099::roles::owner_role_mut(0xec3579be9ea20a8d48f2cc273eb8c2257bfbd21248e01863d5e276b04edd1099::state::roles_mut(arg1)), arg0, arg2);
    }

    entry fun update_attester_manager(arg0: address, arg1: &mut 0xec3579be9ea20a8d48f2cc273eb8c2257bfbd21248e01863d5e276b04edd1099::state::State, arg2: &0x2::tx_context::TxContext) {
        0xec3579be9ea20a8d48f2cc273eb8c2257bfbd21248e01863d5e276b04edd1099::version_control::assert_object_version_is_compatible_with_package(*0xec3579be9ea20a8d48f2cc273eb8c2257bfbd21248e01863d5e276b04edd1099::state::compatible_versions(arg1));
        validate_role_transfer(arg0, 0xec3579be9ea20a8d48f2cc273eb8c2257bfbd21248e01863d5e276b04edd1099::roles::attester_manager(0xec3579be9ea20a8d48f2cc273eb8c2257bfbd21248e01863d5e276b04edd1099::state::roles(arg1)), arg1, arg2);
        0xec3579be9ea20a8d48f2cc273eb8c2257bfbd21248e01863d5e276b04edd1099::roles::update_attester_manager(0xec3579be9ea20a8d48f2cc273eb8c2257bfbd21248e01863d5e276b04edd1099::state::roles_mut(arg1), arg0);
        let v0 = AttesterManagerUpdated{
            previous_attester_manager : 0xec3579be9ea20a8d48f2cc273eb8c2257bfbd21248e01863d5e276b04edd1099::roles::attester_manager(0xec3579be9ea20a8d48f2cc273eb8c2257bfbd21248e01863d5e276b04edd1099::state::roles(arg1)),
            new_attester_manager      : 0xec3579be9ea20a8d48f2cc273eb8c2257bfbd21248e01863d5e276b04edd1099::roles::attester_manager(0xec3579be9ea20a8d48f2cc273eb8c2257bfbd21248e01863d5e276b04edd1099::state::roles(arg1)),
        };
        0x2::event::emit<AttesterManagerUpdated>(v0);
    }

    entry fun update_pauser(arg0: address, arg1: &mut 0xec3579be9ea20a8d48f2cc273eb8c2257bfbd21248e01863d5e276b04edd1099::state::State, arg2: &0x2::tx_context::TxContext) {
        0xec3579be9ea20a8d48f2cc273eb8c2257bfbd21248e01863d5e276b04edd1099::version_control::assert_object_version_is_compatible_with_package(*0xec3579be9ea20a8d48f2cc273eb8c2257bfbd21248e01863d5e276b04edd1099::state::compatible_versions(arg1));
        validate_role_transfer(arg0, 0xec3579be9ea20a8d48f2cc273eb8c2257bfbd21248e01863d5e276b04edd1099::roles::pauser(0xec3579be9ea20a8d48f2cc273eb8c2257bfbd21248e01863d5e276b04edd1099::state::roles(arg1)), arg1, arg2);
        0xec3579be9ea20a8d48f2cc273eb8c2257bfbd21248e01863d5e276b04edd1099::roles::update_pauser(0xec3579be9ea20a8d48f2cc273eb8c2257bfbd21248e01863d5e276b04edd1099::state::roles_mut(arg1), arg0);
        let v0 = PauserChanged{new_pauser: 0xec3579be9ea20a8d48f2cc273eb8c2257bfbd21248e01863d5e276b04edd1099::roles::pauser(0xec3579be9ea20a8d48f2cc273eb8c2257bfbd21248e01863d5e276b04edd1099::state::roles(arg1))};
        0x2::event::emit<PauserChanged>(v0);
    }

    fun validate_role_transfer(arg0: address, arg1: address, arg2: &0xec3579be9ea20a8d48f2cc273eb8c2257bfbd21248e01863d5e276b04edd1099::state::State, arg3: &0x2::tx_context::TxContext) {
        0xe0917b74a5912e4ad186ac634e29c922ab83903f71af7500969f9411706f9b9a::two_step_role::assert_sender_is_active_role<0xec3579be9ea20a8d48f2cc273eb8c2257bfbd21248e01863d5e276b04edd1099::roles::OwnerRole>(0xec3579be9ea20a8d48f2cc273eb8c2257bfbd21248e01863d5e276b04edd1099::roles::owner_role(0xec3579be9ea20a8d48f2cc273eb8c2257bfbd21248e01863d5e276b04edd1099::state::roles(arg2)), arg3);
        assert!(arg0 != arg1, 0);
    }

    // decompiled from Move bytecode v6
}

