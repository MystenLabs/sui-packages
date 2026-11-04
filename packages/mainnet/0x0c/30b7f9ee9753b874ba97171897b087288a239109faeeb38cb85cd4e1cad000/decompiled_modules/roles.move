module 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::roles {
    struct ContractAdmin has drop {
        dummy_field: bool,
    }

    struct ReserveAdmin has drop {
        dummy_field: bool,
    }

    struct TransferAdmin has drop {
        dummy_field: bool,
    }

    struct WalletsAdmin has drop {
        dummy_field: bool,
    }

    struct TimelockCanceler has drop {
        dummy_field: bool,
    }

    public(friend) fun setup_roles<T0>(arg0: &mut 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::controlled_treasury::ControlledTreasury<T0>, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::controlled_treasury::borrow_caps<T0, ContractAdmin>(arg0, arg1);
        let v1 = &v0;
        0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::controlled_treasury::add_role_ability<T0, ContractAdmin, 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::accepted_currencies::AcceptCurrencyAbility>(arg0, v1, arg1);
        0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::controlled_treasury::add_role_ability<T0, ContractAdmin, 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::rules::EditRulesAbility>(arg0, v1, arg1);
        0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::controlled_treasury::add_role_ability<T0, ContractAdmin, 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::timelock::FundScheduleAbility>(arg0, v1, arg1);
        0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::controlled_treasury::add_role_ability<T0, ContractAdmin, 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::pause_token::PauseTokenAbility>(arg0, v1, arg1);
        0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::controlled_treasury::add_role_ability<T0, ContractAdmin, 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::controlled_treasury::PauseTreasuryAbility>(arg0, v1, arg1);
        0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::controlled_treasury::add_role_ability<T0, ContractAdmin, 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::release_schedule::ReleaseScheduleAbility>(arg0, v1, arg1);
        0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::controlled_treasury::add_role_ability<T0, ContractAdmin, 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::snapshot::SnapshotAbility>(arg0, v1, arg1);
        0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::controlled_treasury::add_role_ability<T0, ContractAdmin, 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::soft_pause::SoftPauseAbility>(arg0, v1, arg1);
        0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::controlled_treasury::add_role_ability<T0, ReserveAdmin, 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::burn::BurnAbility>(arg0, v1, arg1);
        0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::controlled_treasury::add_role_ability<T0, ReserveAdmin, 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::timelock::ForceClaimAbility>(arg0, v1, arg1);
        0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::controlled_treasury::add_role_ability<T0, ReserveAdmin, 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::force_transfer::ForceTransferAbility>(arg0, v1, arg1);
        0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::controlled_treasury::add_role_ability<T0, ReserveAdmin, 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::timelock::ForceFundScheduleAbility>(arg0, v1, arg1);
        0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::controlled_treasury::add_role_ability<T0, ReserveAdmin, 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::timelock::FundScheduleAbility>(arg0, v1, arg1);
        0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::controlled_treasury::add_role_ability<T0, ReserveAdmin, 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::mint::MintAbility>(arg0, v1, arg1);
        0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::controlled_treasury::add_role_ability<T0, ReserveAdmin, 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::release_schedule::ReleaseScheduleAbility>(arg0, v1, arg1);
        0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::controlled_treasury::add_role_ability<T0, ReserveAdmin, 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::reclaimer::SetReclaimerAbility>(arg0, v1, arg1);
        0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::controlled_treasury::add_role_ability<T0, ReserveAdmin, 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::timelock::SetTimelockOwnerAbility>(arg0, v1, arg1);
        0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::controlled_treasury::add_role_ability<T0, TransferAdmin, 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::dividends::DividendsAbility>(arg0, v1, arg1);
        0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::controlled_treasury::add_role_ability<T0, TransferAdmin, 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::groups::EditGroupsAbility>(arg0, v1, arg1);
        0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::controlled_treasury::add_role_ability<T0, TransferAdmin, 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::holders::EditHoldersAbility>(arg0, v1, arg1);
        0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::controlled_treasury::add_role_ability<T0, TransferAdmin, 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::timelock::ForceClaimAbility>(arg0, v1, arg1);
        0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::controlled_treasury::add_role_ability<T0, TransferAdmin, 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::freeze_address::FreezeAddressAbility>(arg0, v1, arg1);
        0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::controlled_treasury::add_role_ability<T0, TransferAdmin, 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::timelock::FundScheduleAbility>(arg0, v1, arg1);
        0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::controlled_treasury::add_role_ability<T0, TransferAdmin, 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::group_transfer::GroupTransferAbility>(arg0, v1, arg1);
        0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::controlled_treasury::add_role_ability<T0, TransferAdmin, 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::min_token_balance::MinTokenBalanceAbility>(arg0, v1, arg1);
        0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::controlled_treasury::add_role_ability<T0, TransferAdmin, 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::release_schedule::ReleaseScheduleAbility>(arg0, v1, arg1);
        0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::controlled_treasury::add_role_ability<T0, TransferAdmin, 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::address_permission::SetAddressPermissionAbility>(arg0, v1, arg1);
        0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::controlled_treasury::add_role_ability<T0, TransferAdmin, 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::timelock::SetTimelockOwnerAbility>(arg0, v1, arg1);
        0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::controlled_treasury::add_role_ability<T0, TransferAdmin, 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::soft_pause::SoftPauseAbility>(arg0, v1, arg1);
        0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::controlled_treasury::add_role_ability<T0, WalletsAdmin, 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::holders::EditHoldersAbility>(arg0, v1, arg1);
        0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::controlled_treasury::add_role_ability<T0, WalletsAdmin, 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::freeze_address::FreezeAddressAbility>(arg0, v1, arg1);
        0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::controlled_treasury::add_role_ability<T0, WalletsAdmin, 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::timelock::FundScheduleAbility>(arg0, v1, arg1);
        0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::controlled_treasury::add_role_ability<T0, WalletsAdmin, 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::release_schedule::ReleaseScheduleAbility>(arg0, v1, arg1);
        0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::controlled_treasury::add_role_ability<T0, WalletsAdmin, 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::address_permission::SetAddressPermissionAbility>(arg0, v1, arg1);
        0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::controlled_treasury::add_role_ability<T0, TimelockCanceler, 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::timelock::TimelockCancelAbility>(arg0, v1, arg1);
        0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::controlled_treasury::return_caps<T0>(arg0, v0);
    }

    // decompiled from Move bytecode v7
}

