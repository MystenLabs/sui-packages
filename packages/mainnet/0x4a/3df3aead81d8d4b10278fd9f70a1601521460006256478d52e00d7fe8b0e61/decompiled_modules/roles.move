module 0x4a3df3aead81d8d4b10278fd9f70a1601521460006256478d52e00d7fe8b0e61::roles {
    struct ContractManager has drop {
        dummy_field: bool,
    }

    struct Admin has drop {
        dummy_field: bool,
    }

    struct Manager has drop {
        dummy_field: bool,
    }

    public(friend) fun setup_roles<T0>(arg0: &mut 0x4a3df3aead81d8d4b10278fd9f70a1601521460006256478d52e00d7fe8b0e61::controlled_treasury::ControlledTreasury<T0>, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x4a3df3aead81d8d4b10278fd9f70a1601521460006256478d52e00d7fe8b0e61::controlled_treasury::borrow_caps<T0, Admin>(arg0, arg1);
        let v1 = &v0;
        0x4a3df3aead81d8d4b10278fd9f70a1601521460006256478d52e00d7fe8b0e61::controlled_treasury::add_role_ability<T0, Admin, 0x4a3df3aead81d8d4b10278fd9f70a1601521460006256478d52e00d7fe8b0e61::rules::EditRulesAbility>(arg0, v1, arg1);
        0x4a3df3aead81d8d4b10278fd9f70a1601521460006256478d52e00d7fe8b0e61::controlled_treasury::add_role_ability<T0, ContractManager, 0x4a3df3aead81d8d4b10278fd9f70a1601521460006256478d52e00d7fe8b0e61::mint::MintAbility>(arg0, v1, arg1);
        0x4a3df3aead81d8d4b10278fd9f70a1601521460006256478d52e00d7fe8b0e61::controlled_treasury::add_role_ability<T0, ContractManager, 0x4a3df3aead81d8d4b10278fd9f70a1601521460006256478d52e00d7fe8b0e61::burn::BurnAbility>(arg0, v1, arg1);
        0x4a3df3aead81d8d4b10278fd9f70a1601521460006256478d52e00d7fe8b0e61::controlled_treasury::add_role_ability<T0, ContractManager, 0x4a3df3aead81d8d4b10278fd9f70a1601521460006256478d52e00d7fe8b0e61::transferflag::UpdateTransferFlagAbility>(arg0, v1, arg1);
        0x4a3df3aead81d8d4b10278fd9f70a1601521460006256478d52e00d7fe8b0e61::controlled_treasury::add_role_ability<T0, Manager, 0x4a3df3aead81d8d4b10278fd9f70a1601521460006256478d52e00d7fe8b0e61::whitelist::WhitelistInvestorAbility>(arg0, v1, arg1);
        0x4a3df3aead81d8d4b10278fd9f70a1601521460006256478d52e00d7fe8b0e61::controlled_treasury::add_role_ability<T0, Manager, 0x4a3df3aead81d8d4b10278fd9f70a1601521460006256478d52e00d7fe8b0e61::remove::RemoveInvestorAbility>(arg0, v1, arg1);
        0x4a3df3aead81d8d4b10278fd9f70a1601521460006256478d52e00d7fe8b0e61::controlled_treasury::add_role_ability<T0, Manager, 0x4a3df3aead81d8d4b10278fd9f70a1601521460006256478d52e00d7fe8b0e61::blocklist::BlocklistInvestorAbility>(arg0, v1, arg1);
        0x4a3df3aead81d8d4b10278fd9f70a1601521460006256478d52e00d7fe8b0e61::controlled_treasury::add_role_ability<T0, Manager, 0x4a3df3aead81d8d4b10278fd9f70a1601521460006256478d52e00d7fe8b0e61::restrict::RestrictInvestorAbility>(arg0, v1, arg1);
        0x4a3df3aead81d8d4b10278fd9f70a1601521460006256478d52e00d7fe8b0e61::controlled_treasury::return_caps<T0>(arg0, v0);
    }

    // decompiled from Move bytecode v6
}

