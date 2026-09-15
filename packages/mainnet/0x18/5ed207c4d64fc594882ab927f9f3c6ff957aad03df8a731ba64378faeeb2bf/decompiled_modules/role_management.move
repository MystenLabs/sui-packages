module 0x185ed207c4d64fc594882ab927f9f3c6ff957aad03df8a731ba64378faeeb2bf::role_management {
    struct MintControllerChanged has copy, drop {
        new_mint_controller: address,
    }

    entry fun accept_ownership(arg0: &mut 0x185ed207c4d64fc594882ab927f9f3c6ff957aad03df8a731ba64378faeeb2bf::state::State, arg1: &0x2::tx_context::TxContext) {
        0x185ed207c4d64fc594882ab927f9f3c6ff957aad03df8a731ba64378faeeb2bf::version_control::assert_object_version_is_compatible_with_package(0x185ed207c4d64fc594882ab927f9f3c6ff957aad03df8a731ba64378faeeb2bf::state::compatible_versions(arg0));
        0xe0917b74a5912e4ad186ac634e29c922ab83903f71af7500969f9411706f9b9a::two_step_role::accept_role<0x185ed207c4d64fc594882ab927f9f3c6ff957aad03df8a731ba64378faeeb2bf::roles::OwnerRole>(0x185ed207c4d64fc594882ab927f9f3c6ff957aad03df8a731ba64378faeeb2bf::roles::owner_role_mut(0x185ed207c4d64fc594882ab927f9f3c6ff957aad03df8a731ba64378faeeb2bf::state::roles_mut(arg0)), arg1);
    }

    entry fun transfer_ownership(arg0: address, arg1: &mut 0x185ed207c4d64fc594882ab927f9f3c6ff957aad03df8a731ba64378faeeb2bf::state::State, arg2: &0x2::tx_context::TxContext) {
        0x185ed207c4d64fc594882ab927f9f3c6ff957aad03df8a731ba64378faeeb2bf::version_control::assert_object_version_is_compatible_with_package(0x185ed207c4d64fc594882ab927f9f3c6ff957aad03df8a731ba64378faeeb2bf::state::compatible_versions(arg1));
        0xe0917b74a5912e4ad186ac634e29c922ab83903f71af7500969f9411706f9b9a::two_step_role::begin_role_transfer<0x185ed207c4d64fc594882ab927f9f3c6ff957aad03df8a731ba64378faeeb2bf::roles::OwnerRole>(0x185ed207c4d64fc594882ab927f9f3c6ff957aad03df8a731ba64378faeeb2bf::roles::owner_role_mut(0x185ed207c4d64fc594882ab927f9f3c6ff957aad03df8a731ba64378faeeb2bf::state::roles_mut(arg1)), arg0, arg2);
    }

    entry fun update_mint_controller(arg0: address, arg1: &mut 0x185ed207c4d64fc594882ab927f9f3c6ff957aad03df8a731ba64378faeeb2bf::state::State, arg2: &0x2::tx_context::TxContext) {
        0x185ed207c4d64fc594882ab927f9f3c6ff957aad03df8a731ba64378faeeb2bf::version_control::assert_object_version_is_compatible_with_package(0x185ed207c4d64fc594882ab927f9f3c6ff957aad03df8a731ba64378faeeb2bf::state::compatible_versions(arg1));
        assert!(0x185ed207c4d64fc594882ab927f9f3c6ff957aad03df8a731ba64378faeeb2bf::roles::owner(0x185ed207c4d64fc594882ab927f9f3c6ff957aad03df8a731ba64378faeeb2bf::state::roles(arg1)) == 0x2::tx_context::sender(arg2), 0);
        assert!(arg0 != @0x0, 2);
        assert!(arg0 != 0x185ed207c4d64fc594882ab927f9f3c6ff957aad03df8a731ba64378faeeb2bf::roles::mint_controller(0x185ed207c4d64fc594882ab927f9f3c6ff957aad03df8a731ba64378faeeb2bf::state::roles(arg1)), 1);
        0x185ed207c4d64fc594882ab927f9f3c6ff957aad03df8a731ba64378faeeb2bf::roles::update_mint_controller(0x185ed207c4d64fc594882ab927f9f3c6ff957aad03df8a731ba64378faeeb2bf::state::roles_mut(arg1), arg0);
        let v0 = MintControllerChanged{new_mint_controller: arg0};
        0x2::event::emit<MintControllerChanged>(v0);
    }

    // decompiled from Move bytecode v7
}

