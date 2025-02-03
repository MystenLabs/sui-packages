module 0xfc699b39e2e9d02d99a08d25d621982887c7d586bceeab5e20ff8743a7d771b4::roles {
    struct ContractManager has drop {
        dummy_field: bool,
    }

    struct Admin has drop {
        dummy_field: bool,
    }

    struct Manager has drop {
        dummy_field: bool,
    }

    public(friend) fun setup_roles<T0>(arg0: &mut 0xfc699b39e2e9d02d99a08d25d621982887c7d586bceeab5e20ff8743a7d771b4::controlled_treasury::ControlledTreasury<T0>, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0xfc699b39e2e9d02d99a08d25d621982887c7d586bceeab5e20ff8743a7d771b4::controlled_treasury::borrow_caps<T0, Admin>(arg0, arg1);
        let v1 = &v0;
        0xfc699b39e2e9d02d99a08d25d621982887c7d586bceeab5e20ff8743a7d771b4::controlled_treasury::add_role_ability<T0, Admin, 0xfc699b39e2e9d02d99a08d25d621982887c7d586bceeab5e20ff8743a7d771b4::rules::EditRulesAbility>(arg0, v1, arg1);
        0xfc699b39e2e9d02d99a08d25d621982887c7d586bceeab5e20ff8743a7d771b4::controlled_treasury::add_role_ability<T0, ContractManager, 0xfc699b39e2e9d02d99a08d25d621982887c7d586bceeab5e20ff8743a7d771b4::mint::MintAbility>(arg0, v1, arg1);
        0xfc699b39e2e9d02d99a08d25d621982887c7d586bceeab5e20ff8743a7d771b4::controlled_treasury::add_role_ability<T0, ContractManager, 0xfc699b39e2e9d02d99a08d25d621982887c7d586bceeab5e20ff8743a7d771b4::burn::BurnAbility>(arg0, v1, arg1);
        0xfc699b39e2e9d02d99a08d25d621982887c7d586bceeab5e20ff8743a7d771b4::controlled_treasury::add_role_ability<T0, ContractManager, 0xfc699b39e2e9d02d99a08d25d621982887c7d586bceeab5e20ff8743a7d771b4::transferflag::UpdateTransferFlagAbility>(arg0, v1, arg1);
        0xfc699b39e2e9d02d99a08d25d621982887c7d586bceeab5e20ff8743a7d771b4::controlled_treasury::add_role_ability<T0, Manager, 0xfc699b39e2e9d02d99a08d25d621982887c7d586bceeab5e20ff8743a7d771b4::whitelist::WhitelistInvestorAbility>(arg0, v1, arg1);
        0xfc699b39e2e9d02d99a08d25d621982887c7d586bceeab5e20ff8743a7d771b4::controlled_treasury::add_role_ability<T0, Manager, 0xfc699b39e2e9d02d99a08d25d621982887c7d586bceeab5e20ff8743a7d771b4::remove::RemoveInvestorAbility>(arg0, v1, arg1);
        0xfc699b39e2e9d02d99a08d25d621982887c7d586bceeab5e20ff8743a7d771b4::controlled_treasury::add_role_ability<T0, Manager, 0xfc699b39e2e9d02d99a08d25d621982887c7d586bceeab5e20ff8743a7d771b4::blocklist::BlocklistInvestorAbility>(arg0, v1, arg1);
        0xfc699b39e2e9d02d99a08d25d621982887c7d586bceeab5e20ff8743a7d771b4::controlled_treasury::add_role_ability<T0, Manager, 0xfc699b39e2e9d02d99a08d25d621982887c7d586bceeab5e20ff8743a7d771b4::restrict::RestrictInvestorAbility>(arg0, v1, arg1);
        0xfc699b39e2e9d02d99a08d25d621982887c7d586bceeab5e20ff8743a7d771b4::controlled_treasury::return_caps<T0>(arg0, v0);
    }

    // decompiled from Move bytecode v6
}

