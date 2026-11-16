module 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::vaults_gov {
    struct UpdateRebalancer has drop {
        dummy_field: bool,
    }

    struct UpdateRebalancerParams has drop, store {
        pos0: 0x2::object::ID,
        pos1: address,
        pos2: bool,
    }

    struct UpdateAuths has drop {
        dummy_field: bool,
    }

    struct UpdateAuthsParams has drop, store {
        pos0: address,
        pos1: bool,
    }

    struct UpdateMigrators has drop {
        dummy_field: bool,
    }

    struct UpdateMigratorsParams has drop, store {
        pos0: address,
        pos1: bool,
    }

    struct AddAdmin has drop {
        dummy_field: bool,
    }

    struct AddAdminParams has drop, store {
        pos0: address,
    }

    struct RemoveAdmin has drop {
        dummy_field: bool,
    }

    struct RemoveAdminParams has drop, store {
        pos0: address,
    }

    struct MintAndInstallCaps has drop {
        dummy_field: bool,
    }

    struct MintAndInstallCapsParams has drop, store {
        pos0: 0x2::object::ID,
        pos1: bool,
        pos2: bool,
    }

    struct InitVaultConfig has drop {
        dummy_field: bool,
    }

    struct InitVaultConfigParams has drop, store {
        pos0: 0x1::type_name::TypeName,
        pos1: 0x1::type_name::TypeName,
        pos2: 0x2::object::ID,
        pos3: 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::risk_config::RiskConfig,
        pos4: 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::structs::RateMagnifier,
        pos5: 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::structs::RateMagnifier,
        pos6: u8,
        pos7: u8,
    }

    struct InitVaultState has drop {
        dummy_field: bool,
    }

    struct InitVaultStateParams has drop, store {
        pos0: 0x2::object::ID,
    }

    struct UpdateSupplyRateMagnifier has drop {
        dummy_field: bool,
    }

    struct UpdateSupplyRateMagnifierParams has drop, store {
        pos0: 0x2::object::ID,
        pos1: 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::structs::RateMagnifier,
    }

    struct UpdateBorrowRateMagnifier has drop {
        dummy_field: bool,
    }

    struct UpdateBorrowRateMagnifierParams has drop, store {
        pos0: 0x2::object::ID,
        pos1: 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::structs::RateMagnifier,
    }

    struct UpdateCollateralFactor has drop {
        dummy_field: bool,
    }

    struct UpdateCollateralFactorParams has drop, store {
        pos0: 0x2::object::ID,
        pos1: u16,
    }

    struct UpdateLiquidationThreshold has drop {
        dummy_field: bool,
    }

    struct UpdateLiquidationThresholdParams has drop, store {
        pos0: 0x2::object::ID,
        pos1: u16,
    }

    struct UpdateLiquidationMaxLimit has drop {
        dummy_field: bool,
    }

    struct UpdateLiquidationMaxLimitParams has drop, store {
        pos0: 0x2::object::ID,
        pos1: u16,
    }

    struct UpdateWithdrawGap has drop {
        dummy_field: bool,
    }

    struct UpdateWithdrawGapParams has drop, store {
        pos0: 0x2::object::ID,
        pos1: u16,
    }

    struct UpdateLiquidationPenalty has drop {
        dummy_field: bool,
    }

    struct UpdateLiquidationPenaltyParams has drop, store {
        pos0: 0x2::object::ID,
        pos1: u16,
    }

    struct UpdateBorrowFee has drop {
        dummy_field: bool,
    }

    struct UpdateBorrowFeeParams has drop, store {
        pos0: 0x2::object::ID,
        pos1: u8,
    }

    struct UpdateCoreSettings has drop {
        dummy_field: bool,
    }

    struct UpdateCoreSettingsParams has drop, store {
        pos0: 0x2::object::ID,
        pos1: 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::risk_config::RiskConfig,
        pos2: 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::structs::RateMagnifier,
        pos3: 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::structs::RateMagnifier,
    }

    struct UpdateOracle has drop {
        dummy_field: bool,
    }

    struct UpdateOracleParams has drop, store {
        pos0: 0x2::object::ID,
        pos1: 0x2::object::ID,
    }

    struct CreateDisplay has drop {
        dummy_field: bool,
    }

    struct CreateDisplayParams has drop, store {
        dummy_field: bool,
    }

    struct DisableTimelock has drop {
        dummy_field: bool,
    }

    struct DisableTimelockParams has drop, store {
        dummy_field: bool,
    }

    public fun enable_timelock(arg0: &mut 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::CapStore, arg1: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::Auth, arg2: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::SetupCap, arg3: &0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::registry::VaultRegistry, arg4: &mut 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::auth::VaultAdmin, arg5: &mut 0x2::tx_context::TxContext) {
        0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::assert_roles_finalized(arg1);
        0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::store_cap<0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::timelock_cap::TimelockCap>(arg0, 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::admin::mint_timelock_cap(arg3, arg4, arg5));
    }

    public fun execute_add_admin(arg0: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::CapStore, arg1: &mut 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::Timelock, arg2: &0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::registry::VaultRegistry, arg3: &mut 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::auth::VaultAdmin, arg4: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::Auth, arg5: vector<u8>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = AddAdmin{dummy_field: false};
        let (_, v2) = 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::consume<AddAdmin, AddAdminParams>(arg1, 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::execute_admin<AddAdmin, AddAdminParams>(arg0, arg1, arg4, arg5, arg6, arg7), v0);
        let AddAdminParams { pos0: v3 } = v2;
        0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::admin::add_admin(arg2, arg3, ticket_of(arg0, arg3), v3, arg7);
    }

    public fun execute_create_display(arg0: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::CapStore, arg1: &mut 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::Timelock, arg2: &0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::registry::VaultRegistry, arg3: &mut 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::auth::VaultAdmin, arg4: &mut 0x2::display_registry::DisplayRegistry, arg5: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::Auth, arg6: vector<u8>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = CreateDisplay{dummy_field: false};
        let (_, v2) = 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::consume<CreateDisplay, CreateDisplayParams>(arg1, 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::execute_admin<CreateDisplay, CreateDisplayParams>(arg0, arg1, arg5, arg6, arg7, arg8), v0);
        let CreateDisplayParams {  } = v2;
        0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::position::create_display(arg2, arg3, ticket_of(arg0, arg3), arg4, arg8);
    }

    public fun execute_disable_timelock(arg0: &mut 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::CapStore, arg1: &mut 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::Timelock, arg2: &0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::registry::VaultRegistry, arg3: &mut 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::auth::VaultAdmin, arg4: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::Auth, arg5: vector<u8>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = DisableTimelock{dummy_field: false};
        let (_, v2) = 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::consume<DisableTimelock, DisableTimelockParams>(arg1, 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::execute_admin<DisableTimelock, DisableTimelockParams>(arg0, arg1, arg4, arg5, arg6, arg7), v0);
        let DisableTimelockParams {  } = v2;
        0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::admin::disable_timelock(arg2, arg3, 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::remove<0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::timelock_cap::TimelockCap>(arg0), arg7);
    }

    public fun execute_init_vault_config<T0, T1>(arg0: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::CapStore, arg1: &mut 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::Timelock, arg2: &mut 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::registry::VaultRegistry, arg3: &0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::auth::VaultAdmin, arg4: &0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::registry::Registry, arg5: &0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::oracle::Oracle, arg6: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::Auth, arg7: vector<u8>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = InitVaultConfig{dummy_field: false};
        let (_, v2) = 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::consume<InitVaultConfig, InitVaultConfigParams>(arg1, 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::execute_auth<InitVaultConfig, InitVaultConfigParams>(arg0, arg1, arg6, arg7, arg8, arg9), v0);
        let InitVaultConfigParams {
            pos0 : v3,
            pos1 : v4,
            pos2 : v5,
            pos3 : v6,
            pos4 : v7,
            pos5 : v8,
            pos6 : v9,
            pos7 : v10,
        } = v2;
        0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::assert_type<T0>(v3);
        0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::assert_type<T1>(v4);
        0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::assert_target<0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::oracle::Oracle>(arg5, v5);
        0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::admin::init_vault_config<T0, T1>(arg2, arg3, ticket_of(arg0, arg3), arg4, v6, v7, v8, arg5, v9, v10, arg8, arg9);
    }

    public fun execute_init_vault_state<T0, T1>(arg0: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::CapStore, arg1: &mut 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::Timelock, arg2: &mut 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::vault_market::VaultMarket<T0, T1>, arg3: &0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::registry::VaultRegistry, arg4: &0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::auth::VaultAdmin, arg5: &0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::reserve::TokenReserve<T0>, arg6: &0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::reserve::TokenReserve<T1>, arg7: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::Auth, arg8: vector<u8>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = InitVaultState{dummy_field: false};
        let (_, v2) = 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::consume<InitVaultState, InitVaultStateParams>(arg1, 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::execute_auth<InitVaultState, InitVaultStateParams>(arg0, arg1, arg7, arg8, arg9, arg10), v0);
        let InitVaultStateParams { pos0: v3 } = v2;
        0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::assert_target<0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::vault_market::VaultMarket<T0, T1>>(arg2, v3);
        0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::admin::init_vault_state<T0, T1>(arg2, arg3, arg4, ticket_of(arg0, arg4), arg5, arg6, arg9, arg10);
    }

    public fun execute_mint_and_install_caps<T0, T1>(arg0: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::CapStore, arg1: &mut 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::Timelock, arg2: &0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::auth::Auth, arg3: &mut 0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::registry::Registry, arg4: &mut 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::vault_market::VaultMarket<T0, T1>, arg5: &0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::registry::VaultRegistry, arg6: &0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::auth::VaultAdmin, arg7: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::Auth, arg8: vector<u8>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = MintAndInstallCaps{dummy_field: false};
        let (_, v2) = 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::consume<MintAndInstallCaps, MintAndInstallCapsParams>(arg1, 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::execute_admin<MintAndInstallCaps, MintAndInstallCapsParams>(arg0, arg1, arg7, arg8, arg9, arg10), v0);
        let MintAndInstallCapsParams {
            pos0 : v3,
            pos1 : v4,
            pos2 : v5,
        } = v2;
        0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::assert_target<0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::vault_market::VaultMarket<T0, T1>>(arg4, v3);
        0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::admin::mint_and_install_caps<T0, T1>(arg2, arg3, liq_ticket(arg0, arg2), liq_ticket(arg0, arg2), arg4, arg5, arg6, ticket_of(arg0, arg6), v4, v5, arg10);
    }

    public fun execute_remove_admin(arg0: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::CapStore, arg1: &mut 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::Timelock, arg2: &0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::registry::VaultRegistry, arg3: &mut 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::auth::VaultAdmin, arg4: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::Auth, arg5: vector<u8>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = RemoveAdmin{dummy_field: false};
        let (_, v2) = 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::consume<RemoveAdmin, RemoveAdminParams>(arg1, 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::execute_admin<RemoveAdmin, RemoveAdminParams>(arg0, arg1, arg4, arg5, arg6, arg7), v0);
        let RemoveAdminParams { pos0: v3 } = v2;
        0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::admin::remove_admin(arg2, arg3, ticket_of(arg0, arg3), v3, arg7);
    }

    public fun execute_update_auths(arg0: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::CapStore, arg1: &mut 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::Timelock, arg2: &0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::registry::VaultRegistry, arg3: &mut 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::auth::VaultAdmin, arg4: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::Auth, arg5: vector<u8>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = UpdateAuths{dummy_field: false};
        let (_, v2) = 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::consume<UpdateAuths, UpdateAuthsParams>(arg1, 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::execute_admin<UpdateAuths, UpdateAuthsParams>(arg0, arg1, arg4, arg5, arg6, arg7), v0);
        let UpdateAuthsParams {
            pos0 : v3,
            pos1 : v4,
        } = v2;
        0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::admin::update_auths(arg2, arg3, ticket_of(arg0, arg3), v3, v4, arg7);
    }

    public fun execute_update_borrow_fee<T0, T1>(arg0: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::CapStore, arg1: &mut 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::Timelock, arg2: &mut 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::vault_market::VaultMarket<T0, T1>, arg3: &0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::registry::VaultRegistry, arg4: &0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::auth::VaultAdmin, arg5: &0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::reserve::TokenReserve<T0>, arg6: &0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::reserve::TokenReserve<T1>, arg7: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::Auth, arg8: vector<u8>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = UpdateBorrowFee{dummy_field: false};
        let (_, v2) = 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::consume<UpdateBorrowFee, UpdateBorrowFeeParams>(arg1, 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::execute_auth<UpdateBorrowFee, UpdateBorrowFeeParams>(arg0, arg1, arg7, arg8, arg9, arg10), v0);
        let UpdateBorrowFeeParams {
            pos0 : v3,
            pos1 : v4,
        } = v2;
        0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::assert_target<0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::vault_market::VaultMarket<T0, T1>>(arg2, v3);
        0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::admin::update_borrow_fee<T0, T1>(arg2, arg3, arg4, ticket_of(arg0, arg4), arg5, arg6, v4, arg9, arg10);
    }

    public fun execute_update_borrow_rate_magnifier<T0, T1>(arg0: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::CapStore, arg1: &mut 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::Timelock, arg2: &mut 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::vault_market::VaultMarket<T0, T1>, arg3: &0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::registry::VaultRegistry, arg4: &0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::auth::VaultAdmin, arg5: &0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::reserve::TokenReserve<T0>, arg6: &0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::reserve::TokenReserve<T1>, arg7: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::Auth, arg8: vector<u8>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = UpdateBorrowRateMagnifier{dummy_field: false};
        let (_, v2) = 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::consume<UpdateBorrowRateMagnifier, UpdateBorrowRateMagnifierParams>(arg1, 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::execute_auth<UpdateBorrowRateMagnifier, UpdateBorrowRateMagnifierParams>(arg0, arg1, arg7, arg8, arg9, arg10), v0);
        let UpdateBorrowRateMagnifierParams {
            pos0 : v3,
            pos1 : v4,
        } = v2;
        0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::assert_target<0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::vault_market::VaultMarket<T0, T1>>(arg2, v3);
        0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::admin::update_borrow_rate_magnifier<T0, T1>(arg2, arg3, arg4, ticket_of(arg0, arg4), arg5, arg6, v4, arg9, arg10);
    }

    public fun execute_update_collateral_factor<T0, T1>(arg0: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::CapStore, arg1: &mut 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::Timelock, arg2: &mut 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::vault_market::VaultMarket<T0, T1>, arg3: &0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::registry::VaultRegistry, arg4: &0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::auth::VaultAdmin, arg5: &0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::reserve::TokenReserve<T0>, arg6: &0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::reserve::TokenReserve<T1>, arg7: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::Auth, arg8: vector<u8>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = UpdateCollateralFactor{dummy_field: false};
        let (_, v2) = 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::consume<UpdateCollateralFactor, UpdateCollateralFactorParams>(arg1, 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::execute_auth<UpdateCollateralFactor, UpdateCollateralFactorParams>(arg0, arg1, arg7, arg8, arg9, arg10), v0);
        let UpdateCollateralFactorParams {
            pos0 : v3,
            pos1 : v4,
        } = v2;
        0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::assert_target<0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::vault_market::VaultMarket<T0, T1>>(arg2, v3);
        0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::admin::update_collateral_factor<T0, T1>(arg2, arg3, arg4, ticket_of(arg0, arg4), arg5, arg6, v4, arg9, arg10);
    }

    public fun execute_update_core_settings<T0, T1>(arg0: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::CapStore, arg1: &mut 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::Timelock, arg2: &mut 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::vault_market::VaultMarket<T0, T1>, arg3: &0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::registry::VaultRegistry, arg4: &0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::auth::VaultAdmin, arg5: &0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::reserve::TokenReserve<T0>, arg6: &0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::reserve::TokenReserve<T1>, arg7: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::Auth, arg8: vector<u8>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = UpdateCoreSettings{dummy_field: false};
        let (_, v2) = 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::consume<UpdateCoreSettings, UpdateCoreSettingsParams>(arg1, 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::execute_auth<UpdateCoreSettings, UpdateCoreSettingsParams>(arg0, arg1, arg7, arg8, arg9, arg10), v0);
        let UpdateCoreSettingsParams {
            pos0 : v3,
            pos1 : v4,
            pos2 : v5,
            pos3 : v6,
        } = v2;
        0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::assert_target<0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::vault_market::VaultMarket<T0, T1>>(arg2, v3);
        0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::admin::update_core_settings<T0, T1>(arg2, arg3, arg4, ticket_of(arg0, arg4), arg5, arg6, v4, v5, v6, arg9, arg10);
    }

    public fun execute_update_liquidation_max_limit<T0, T1>(arg0: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::CapStore, arg1: &mut 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::Timelock, arg2: &mut 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::vault_market::VaultMarket<T0, T1>, arg3: &0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::registry::VaultRegistry, arg4: &0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::auth::VaultAdmin, arg5: &0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::reserve::TokenReserve<T0>, arg6: &0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::reserve::TokenReserve<T1>, arg7: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::Auth, arg8: vector<u8>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = UpdateLiquidationMaxLimit{dummy_field: false};
        let (_, v2) = 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::consume<UpdateLiquidationMaxLimit, UpdateLiquidationMaxLimitParams>(arg1, 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::execute_auth<UpdateLiquidationMaxLimit, UpdateLiquidationMaxLimitParams>(arg0, arg1, arg7, arg8, arg9, arg10), v0);
        let UpdateLiquidationMaxLimitParams {
            pos0 : v3,
            pos1 : v4,
        } = v2;
        0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::assert_target<0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::vault_market::VaultMarket<T0, T1>>(arg2, v3);
        0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::admin::update_liquidation_max_limit<T0, T1>(arg2, arg3, arg4, ticket_of(arg0, arg4), arg5, arg6, v4, arg9, arg10);
    }

    public fun execute_update_liquidation_penalty<T0, T1>(arg0: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::CapStore, arg1: &mut 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::Timelock, arg2: &mut 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::vault_market::VaultMarket<T0, T1>, arg3: &0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::registry::VaultRegistry, arg4: &0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::auth::VaultAdmin, arg5: &0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::reserve::TokenReserve<T0>, arg6: &0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::reserve::TokenReserve<T1>, arg7: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::Auth, arg8: vector<u8>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = UpdateLiquidationPenalty{dummy_field: false};
        let (_, v2) = 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::consume<UpdateLiquidationPenalty, UpdateLiquidationPenaltyParams>(arg1, 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::execute_auth<UpdateLiquidationPenalty, UpdateLiquidationPenaltyParams>(arg0, arg1, arg7, arg8, arg9, arg10), v0);
        let UpdateLiquidationPenaltyParams {
            pos0 : v3,
            pos1 : v4,
        } = v2;
        0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::assert_target<0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::vault_market::VaultMarket<T0, T1>>(arg2, v3);
        0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::admin::update_liquidation_penalty<T0, T1>(arg2, arg3, arg4, ticket_of(arg0, arg4), arg5, arg6, v4, arg9, arg10);
    }

    public fun execute_update_liquidation_threshold<T0, T1>(arg0: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::CapStore, arg1: &mut 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::Timelock, arg2: &mut 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::vault_market::VaultMarket<T0, T1>, arg3: &0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::registry::VaultRegistry, arg4: &0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::auth::VaultAdmin, arg5: &0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::reserve::TokenReserve<T0>, arg6: &0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::reserve::TokenReserve<T1>, arg7: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::Auth, arg8: vector<u8>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = UpdateLiquidationThreshold{dummy_field: false};
        let (_, v2) = 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::consume<UpdateLiquidationThreshold, UpdateLiquidationThresholdParams>(arg1, 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::execute_auth<UpdateLiquidationThreshold, UpdateLiquidationThresholdParams>(arg0, arg1, arg7, arg8, arg9, arg10), v0);
        let UpdateLiquidationThresholdParams {
            pos0 : v3,
            pos1 : v4,
        } = v2;
        0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::assert_target<0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::vault_market::VaultMarket<T0, T1>>(arg2, v3);
        0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::admin::update_liquidation_threshold<T0, T1>(arg2, arg3, arg4, ticket_of(arg0, arg4), arg5, arg6, v4, arg9, arg10);
    }

    public fun execute_update_migrators(arg0: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::CapStore, arg1: &mut 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::Timelock, arg2: &0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::registry::VaultRegistry, arg3: &mut 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::auth::VaultAdmin, arg4: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::Auth, arg5: vector<u8>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = UpdateMigrators{dummy_field: false};
        let (_, v2) = 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::consume<UpdateMigrators, UpdateMigratorsParams>(arg1, 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::execute_admin<UpdateMigrators, UpdateMigratorsParams>(arg0, arg1, arg4, arg5, arg6, arg7), v0);
        let UpdateMigratorsParams {
            pos0 : v3,
            pos1 : v4,
        } = v2;
        0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::admin::update_migrators(arg2, arg3, ticket_of(arg0, arg3), v3, v4, arg7);
    }

    public fun execute_update_oracle<T0, T1>(arg0: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::CapStore, arg1: &mut 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::Timelock, arg2: &mut 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::vault_market::VaultMarket<T0, T1>, arg3: &0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::registry::VaultRegistry, arg4: &0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::auth::VaultAdmin, arg5: &0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::reserve::TokenReserve<T0>, arg6: &0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::reserve::TokenReserve<T1>, arg7: &0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::oracle::Oracle, arg8: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::Auth, arg9: vector<u8>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = UpdateOracle{dummy_field: false};
        let (_, v2) = 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::consume<UpdateOracle, UpdateOracleParams>(arg1, 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::execute_auth<UpdateOracle, UpdateOracleParams>(arg0, arg1, arg8, arg9, arg10, arg11), v0);
        let UpdateOracleParams {
            pos0 : v3,
            pos1 : v4,
        } = v2;
        0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::assert_target<0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::vault_market::VaultMarket<T0, T1>>(arg2, v3);
        0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::assert_target<0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::oracle::Oracle>(arg7, v4);
        0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::admin::update_oracle<T0, T1>(arg2, arg3, arg4, ticket_of(arg0, arg4), arg5, arg6, arg7, arg10, arg11);
    }

    public fun execute_update_rebalancer<T0, T1>(arg0: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::CapStore, arg1: &mut 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::Timelock, arg2: &0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::registry::VaultRegistry, arg3: &mut 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::auth::VaultAdmin, arg4: &0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::vault_market::VaultMarket<T0, T1>, arg5: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::Auth, arg6: vector<u8>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = UpdateRebalancer{dummy_field: false};
        let (_, v2) = 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::consume<UpdateRebalancer, UpdateRebalancerParams>(arg1, 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::execute_admin<UpdateRebalancer, UpdateRebalancerParams>(arg0, arg1, arg5, arg6, arg7, arg8), v0);
        let UpdateRebalancerParams {
            pos0 : v3,
            pos1 : v4,
            pos2 : v5,
        } = v2;
        0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::assert_target<0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::vault_market::VaultMarket<T0, T1>>(arg4, v3);
        0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::admin::update_rebalancer<T0, T1>(arg2, arg3, ticket_of(arg0, arg3), arg4, v4, v5, arg8);
    }

    public fun execute_update_supply_rate_magnifier<T0, T1>(arg0: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::CapStore, arg1: &mut 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::Timelock, arg2: &mut 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::vault_market::VaultMarket<T0, T1>, arg3: &0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::registry::VaultRegistry, arg4: &0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::auth::VaultAdmin, arg5: &0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::reserve::TokenReserve<T0>, arg6: &0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::reserve::TokenReserve<T1>, arg7: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::Auth, arg8: vector<u8>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = UpdateSupplyRateMagnifier{dummy_field: false};
        let (_, v2) = 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::consume<UpdateSupplyRateMagnifier, UpdateSupplyRateMagnifierParams>(arg1, 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::execute_auth<UpdateSupplyRateMagnifier, UpdateSupplyRateMagnifierParams>(arg0, arg1, arg7, arg8, arg9, arg10), v0);
        let UpdateSupplyRateMagnifierParams {
            pos0 : v3,
            pos1 : v4,
        } = v2;
        0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::assert_target<0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::vault_market::VaultMarket<T0, T1>>(arg2, v3);
        0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::admin::update_supply_rate_magnifier<T0, T1>(arg2, arg3, arg4, ticket_of(arg0, arg4), arg5, arg6, v4, arg9, arg10);
    }

    public fun execute_update_withdraw_gap<T0, T1>(arg0: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::CapStore, arg1: &mut 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::Timelock, arg2: &mut 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::vault_market::VaultMarket<T0, T1>, arg3: &0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::registry::VaultRegistry, arg4: &0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::auth::VaultAdmin, arg5: &0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::reserve::TokenReserve<T0>, arg6: &0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::reserve::TokenReserve<T1>, arg7: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::Auth, arg8: vector<u8>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = UpdateWithdrawGap{dummy_field: false};
        let (_, v2) = 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::consume<UpdateWithdrawGap, UpdateWithdrawGapParams>(arg1, 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::execute_auth<UpdateWithdrawGap, UpdateWithdrawGapParams>(arg0, arg1, arg7, arg8, arg9, arg10), v0);
        let UpdateWithdrawGapParams {
            pos0 : v3,
            pos1 : v4,
        } = v2;
        0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::assert_target<0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::vault_market::VaultMarket<T0, T1>>(arg2, v3);
        0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::admin::update_withdraw_gap<T0, T1>(arg2, arg3, arg4, ticket_of(arg0, arg4), arg5, arg6, v4, arg9, arg10);
    }

    fun liq_ticket(arg0: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::CapStore, arg1: &0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::auth::Auth) : 0x1::option::Option<0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::timelock_cap::TimelockTicket> {
        if (!0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::holds<0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::timelock_cap::TimelockCap>(arg0)) {
            return 0x1::option::none<0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::timelock_cap::TimelockTicket>()
        };
        0x1::option::some<0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::timelock_cap::TimelockTicket>(0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::auth::timelock_ticket(arg1, 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::borrow<0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::timelock_cap::TimelockCap>(arg0)))
    }

    public fun schedule_add_admin(arg0: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::CapStore, arg1: &mut 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::Timelock, arg2: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::Auth, arg3: address, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : vector<u8> {
        let v0 = AddAdminParams{pos0: arg3};
        0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::schedule_admin<AddAdmin, AddAdminParams>(arg0, arg1, arg2, v0, arg4, arg5, arg6)
    }

    public fun schedule_create_display(arg0: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::CapStore, arg1: &mut 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::Timelock, arg2: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::Auth, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : vector<u8> {
        let v0 = CreateDisplayParams{dummy_field: false};
        0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::schedule_admin<CreateDisplay, CreateDisplayParams>(arg0, arg1, arg2, v0, arg3, arg4, arg5)
    }

    public fun schedule_disable_timelock(arg0: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::CapStore, arg1: &mut 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::Timelock, arg2: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::Auth, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : vector<u8> {
        let v0 = DisableTimelockParams{dummy_field: false};
        0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::schedule_admin<DisableTimelock, DisableTimelockParams>(arg0, arg1, arg2, v0, arg3, arg4, arg5)
    }

    public fun schedule_init_vault_config<T0, T1>(arg0: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::CapStore, arg1: &mut 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::Timelock, arg2: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::Auth, arg3: 0x2::object::ID, arg4: 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::risk_config::RiskConfig, arg5: 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::structs::RateMagnifier, arg6: 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::structs::RateMagnifier, arg7: u8, arg8: u8, arg9: vector<u8>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : vector<u8> {
        let v0 = InitVaultConfigParams{
            pos0 : 0x1::type_name::with_original_ids<T0>(),
            pos1 : 0x1::type_name::with_original_ids<T1>(),
            pos2 : arg3,
            pos3 : arg4,
            pos4 : arg5,
            pos5 : arg6,
            pos6 : arg7,
            pos7 : arg8,
        };
        0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::schedule_auth<InitVaultConfig, InitVaultConfigParams>(arg0, arg1, arg2, v0, arg9, arg10, arg11)
    }

    public fun schedule_init_vault_state(arg0: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::CapStore, arg1: &mut 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::Timelock, arg2: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::Auth, arg3: 0x2::object::ID, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : vector<u8> {
        let v0 = InitVaultStateParams{pos0: arg3};
        0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::schedule_auth<InitVaultState, InitVaultStateParams>(arg0, arg1, arg2, v0, arg4, arg5, arg6)
    }

    public fun schedule_mint_and_install_caps(arg0: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::CapStore, arg1: &mut 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::Timelock, arg2: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::Auth, arg3: 0x2::object::ID, arg4: bool, arg5: bool, arg6: vector<u8>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : vector<u8> {
        let v0 = MintAndInstallCapsParams{
            pos0 : arg3,
            pos1 : arg4,
            pos2 : arg5,
        };
        0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::schedule_admin<MintAndInstallCaps, MintAndInstallCapsParams>(arg0, arg1, arg2, v0, arg6, arg7, arg8)
    }

    public fun schedule_remove_admin(arg0: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::CapStore, arg1: &mut 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::Timelock, arg2: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::Auth, arg3: address, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : vector<u8> {
        let v0 = RemoveAdminParams{pos0: arg3};
        0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::schedule_admin<RemoveAdmin, RemoveAdminParams>(arg0, arg1, arg2, v0, arg4, arg5, arg6)
    }

    public fun schedule_update_auths(arg0: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::CapStore, arg1: &mut 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::Timelock, arg2: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::Auth, arg3: address, arg4: bool, arg5: vector<u8>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : vector<u8> {
        let v0 = UpdateAuthsParams{
            pos0 : arg3,
            pos1 : arg4,
        };
        0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::schedule_admin<UpdateAuths, UpdateAuthsParams>(arg0, arg1, arg2, v0, arg5, arg6, arg7)
    }

    public fun schedule_update_borrow_fee(arg0: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::CapStore, arg1: &mut 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::Timelock, arg2: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::Auth, arg3: 0x2::object::ID, arg4: u8, arg5: vector<u8>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : vector<u8> {
        let v0 = UpdateBorrowFeeParams{
            pos0 : arg3,
            pos1 : arg4,
        };
        0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::schedule_auth<UpdateBorrowFee, UpdateBorrowFeeParams>(arg0, arg1, arg2, v0, arg5, arg6, arg7)
    }

    public fun schedule_update_borrow_rate_magnifier(arg0: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::CapStore, arg1: &mut 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::Timelock, arg2: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::Auth, arg3: 0x2::object::ID, arg4: 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::structs::RateMagnifier, arg5: vector<u8>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : vector<u8> {
        let v0 = UpdateBorrowRateMagnifierParams{
            pos0 : arg3,
            pos1 : arg4,
        };
        0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::schedule_auth<UpdateBorrowRateMagnifier, UpdateBorrowRateMagnifierParams>(arg0, arg1, arg2, v0, arg5, arg6, arg7)
    }

    public fun schedule_update_collateral_factor(arg0: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::CapStore, arg1: &mut 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::Timelock, arg2: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::Auth, arg3: 0x2::object::ID, arg4: u16, arg5: vector<u8>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : vector<u8> {
        let v0 = UpdateCollateralFactorParams{
            pos0 : arg3,
            pos1 : arg4,
        };
        0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::schedule_auth<UpdateCollateralFactor, UpdateCollateralFactorParams>(arg0, arg1, arg2, v0, arg5, arg6, arg7)
    }

    public fun schedule_update_core_settings(arg0: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::CapStore, arg1: &mut 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::Timelock, arg2: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::Auth, arg3: 0x2::object::ID, arg4: 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::risk_config::RiskConfig, arg5: 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::structs::RateMagnifier, arg6: 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::structs::RateMagnifier, arg7: vector<u8>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : vector<u8> {
        let v0 = UpdateCoreSettingsParams{
            pos0 : arg3,
            pos1 : arg4,
            pos2 : arg5,
            pos3 : arg6,
        };
        0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::schedule_auth<UpdateCoreSettings, UpdateCoreSettingsParams>(arg0, arg1, arg2, v0, arg7, arg8, arg9)
    }

    public fun schedule_update_liquidation_max_limit(arg0: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::CapStore, arg1: &mut 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::Timelock, arg2: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::Auth, arg3: 0x2::object::ID, arg4: u16, arg5: vector<u8>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : vector<u8> {
        let v0 = UpdateLiquidationMaxLimitParams{
            pos0 : arg3,
            pos1 : arg4,
        };
        0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::schedule_auth<UpdateLiquidationMaxLimit, UpdateLiquidationMaxLimitParams>(arg0, arg1, arg2, v0, arg5, arg6, arg7)
    }

    public fun schedule_update_liquidation_penalty(arg0: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::CapStore, arg1: &mut 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::Timelock, arg2: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::Auth, arg3: 0x2::object::ID, arg4: u16, arg5: vector<u8>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : vector<u8> {
        let v0 = UpdateLiquidationPenaltyParams{
            pos0 : arg3,
            pos1 : arg4,
        };
        0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::schedule_auth<UpdateLiquidationPenalty, UpdateLiquidationPenaltyParams>(arg0, arg1, arg2, v0, arg5, arg6, arg7)
    }

    public fun schedule_update_liquidation_threshold(arg0: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::CapStore, arg1: &mut 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::Timelock, arg2: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::Auth, arg3: 0x2::object::ID, arg4: u16, arg5: vector<u8>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : vector<u8> {
        let v0 = UpdateLiquidationThresholdParams{
            pos0 : arg3,
            pos1 : arg4,
        };
        0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::schedule_auth<UpdateLiquidationThreshold, UpdateLiquidationThresholdParams>(arg0, arg1, arg2, v0, arg5, arg6, arg7)
    }

    public fun schedule_update_migrators(arg0: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::CapStore, arg1: &mut 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::Timelock, arg2: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::Auth, arg3: address, arg4: bool, arg5: vector<u8>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : vector<u8> {
        let v0 = UpdateMigratorsParams{
            pos0 : arg3,
            pos1 : arg4,
        };
        0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::schedule_admin<UpdateMigrators, UpdateMigratorsParams>(arg0, arg1, arg2, v0, arg5, arg6, arg7)
    }

    public fun schedule_update_oracle(arg0: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::CapStore, arg1: &mut 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::Timelock, arg2: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::Auth, arg3: 0x2::object::ID, arg4: 0x2::object::ID, arg5: vector<u8>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : vector<u8> {
        let v0 = UpdateOracleParams{
            pos0 : arg3,
            pos1 : arg4,
        };
        0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::schedule_auth<UpdateOracle, UpdateOracleParams>(arg0, arg1, arg2, v0, arg5, arg6, arg7)
    }

    public fun schedule_update_rebalancer(arg0: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::CapStore, arg1: &mut 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::Timelock, arg2: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::Auth, arg3: 0x2::object::ID, arg4: address, arg5: bool, arg6: vector<u8>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : vector<u8> {
        let v0 = UpdateRebalancerParams{
            pos0 : arg3,
            pos1 : arg4,
            pos2 : arg5,
        };
        0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::schedule_admin<UpdateRebalancer, UpdateRebalancerParams>(arg0, arg1, arg2, v0, arg6, arg7, arg8)
    }

    public fun schedule_update_supply_rate_magnifier(arg0: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::CapStore, arg1: &mut 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::Timelock, arg2: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::Auth, arg3: 0x2::object::ID, arg4: 0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::structs::RateMagnifier, arg5: vector<u8>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : vector<u8> {
        let v0 = UpdateSupplyRateMagnifierParams{
            pos0 : arg3,
            pos1 : arg4,
        };
        0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::schedule_auth<UpdateSupplyRateMagnifier, UpdateSupplyRateMagnifierParams>(arg0, arg1, arg2, v0, arg5, arg6, arg7)
    }

    public fun schedule_update_withdraw_gap(arg0: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::CapStore, arg1: &mut 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::Timelock, arg2: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::Auth, arg3: 0x2::object::ID, arg4: u16, arg5: vector<u8>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : vector<u8> {
        let v0 = UpdateWithdrawGapParams{
            pos0 : arg3,
            pos1 : arg4,
        };
        0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::schedule_auth<UpdateWithdrawGap, UpdateWithdrawGapParams>(arg0, arg1, arg2, v0, arg5, arg6, arg7)
    }

    fun ticket_of(arg0: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::CapStore, arg1: &0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::auth::VaultAdmin) : 0x1::option::Option<0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::timelock_cap::TimelockTicket> {
        if (!0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::holds<0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::timelock_cap::TimelockCap>(arg0)) {
            return 0x1::option::none<0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::timelock_cap::TimelockTicket>()
        };
        0x1::option::some<0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::timelock_cap::TimelockTicket>(0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::auth::timelock_ticket(arg1, 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::borrow<0x937156ee38d5c0a9e061dedd549867aeee88c478fad7f3213b66ca4f95906743::timelock_cap::TimelockCap>(arg0)))
    }

    // decompiled from Move bytecode v7
}

