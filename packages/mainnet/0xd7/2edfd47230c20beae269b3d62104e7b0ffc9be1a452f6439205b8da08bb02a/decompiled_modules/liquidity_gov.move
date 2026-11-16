module 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::liquidity_gov {
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

    struct UpdateAuths has drop {
        dummy_field: bool,
    }

    struct UpdateAuthsParams has drop, store {
        pos0: vector<0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::structs::AddressBool>,
    }

    struct UpdateGuardians has drop {
        dummy_field: bool,
    }

    struct UpdateGuardiansParams has drop, store {
        pos0: vector<0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::structs::AddressBool>,
    }

    struct UpdateMigrators has drop {
        dummy_field: bool,
    }

    struct UpdateMigratorsParams has drop, store {
        pos0: vector<0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::structs::AddressBool>,
    }

    struct UpdateRevenueCollector has drop {
        dummy_field: bool,
    }

    struct UpdateRevenueCollectorParams has drop, store {
        pos0: address,
    }

    struct MintUserCap has drop {
        dummy_field: bool,
    }

    struct MintUserCapParams has drop, store {
        pos0: 0x1::type_name::TypeName,
        pos1: 0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::keys::Holder,
        pos2: address,
    }

    struct SetUserAuthorization has drop {
        dummy_field: bool,
    }

    struct SetUserAuthorizationParams has drop, store {
        pos0: 0x1::type_name::TypeName,
        pos1: 0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::keys::Holder,
        pos2: bool,
    }

    struct UnpauseGlobal has drop {
        dummy_field: bool,
    }

    struct UnpauseGlobalParams has drop, store {
        pos0: 0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::pause::Action,
    }

    struct UnpauseToken has drop {
        dummy_field: bool,
    }

    struct UnpauseTokenParams has drop, store {
        pos0: 0x2::object::ID,
        pos1: 0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::pause::Action,
    }

    struct UnpauseUser has drop {
        dummy_field: bool,
    }

    struct UnpauseUserParams has drop, store {
        pos0: 0x2::object::ID,
        pos1: 0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::keys::Holder,
        pos2: 0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::pause::Action,
    }

    struct InitTokenReserve has drop {
        dummy_field: bool,
    }

    struct InitTokenReserveParams has drop, store {
        pos0: 0x1::type_name::TypeName,
    }

    struct InitTokenReserveWithMetadata has drop {
        dummy_field: bool,
    }

    struct InitTokenReserveWithMetadataParams has drop, store {
        pos0: 0x1::type_name::TypeName,
    }

    struct UpdateRateDataV1 has drop {
        dummy_field: bool,
    }

    struct UpdateRateDataV1Params has drop, store {
        pos0: 0x2::object::ID,
        pos1: 0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::structs::RateDataV1Params,
    }

    struct UpdateRateDataV2 has drop {
        dummy_field: bool,
    }

    struct UpdateRateDataV2Params has drop, store {
        pos0: 0x2::object::ID,
        pos1: 0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::structs::RateDataV2Params,
    }

    struct UpdateTokenConfig has drop {
        dummy_field: bool,
    }

    struct UpdateTokenConfigParams has drop, store {
        pos0: 0x2::object::ID,
        pos1: 0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::structs::TokenConfig,
    }

    struct UpdateUserSupplyConfig has drop {
        dummy_field: bool,
    }

    struct UpdateUserSupplyConfigParams has drop, store {
        pos0: 0x2::object::ID,
        pos1: 0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::keys::Holder,
        pos2: 0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::structs::UserSupplyConfig,
    }

    struct UpdateUserBorrowConfigs has drop {
        dummy_field: bool,
    }

    struct UpdateUserBorrowConfigsParams has drop, store {
        pos0: 0x2::object::ID,
        pos1: 0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::keys::Holder,
        pos2: 0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::structs::UserBorrowConfig,
    }

    struct UpdateUserWithdrawalLimit has drop {
        dummy_field: bool,
    }

    struct UpdateUserWithdrawalLimitParams has drop, store {
        pos0: 0x2::object::ID,
        pos1: 0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::keys::Holder,
        pos2: u64,
    }

    struct CollectRevenue has drop {
        dummy_field: bool,
    }

    struct CollectRevenueParams has drop, store {
        pos0: 0x2::object::ID,
    }

    struct DisableTimelock has drop {
        dummy_field: bool,
    }

    struct DisableTimelockParams has drop, store {
        dummy_field: bool,
    }

    public fun enable_timelock(arg0: &mut 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::CapStore, arg1: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::Auth, arg2: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::SetupCap, arg3: &mut 0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::auth::Auth, arg4: &0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::registry::Registry, arg5: &mut 0x2::tx_context::TxContext) {
        0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::assert_roles_finalized(arg1);
        0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::store_cap<0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::timelock_cap::TimelockCap>(arg0, 0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::admin::mint_timelock_cap(arg3, arg4, arg5));
    }

    public fun execute_add_admin(arg0: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::CapStore, arg1: &mut 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::Timelock, arg2: &mut 0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::auth::Auth, arg3: &0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::registry::Registry, arg4: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::Auth, arg5: vector<u8>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = AddAdmin{dummy_field: false};
        let (_, v2) = 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::consume<AddAdmin, AddAdminParams>(arg1, 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::execute_admin<AddAdmin, AddAdminParams>(arg0, arg1, arg4, arg5, arg6, arg7), v0);
        let AddAdminParams { pos0: v3 } = v2;
        0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::admin::add_admin(arg2, arg3, ticket_of(arg0, arg2), v3, arg7);
    }

    public fun execute_collect_revenue<T0>(arg0: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::CapStore, arg1: &mut 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::Timelock, arg2: &0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::auth::Auth, arg3: &0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::registry::Registry, arg4: &mut 0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::reserve::TokenReserve<T0>, arg5: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::Auth, arg6: vector<u8>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = CollectRevenue{dummy_field: false};
        let (_, v2) = 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::consume<CollectRevenue, CollectRevenueParams>(arg1, 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::execute_auth<CollectRevenue, CollectRevenueParams>(arg0, arg1, arg5, arg6, arg7, arg8), v0);
        let CollectRevenueParams { pos0: v3 } = v2;
        0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::assert_target<0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::reserve::TokenReserve<T0>>(arg4, v3);
        0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::admin::collect_revenue<T0>(arg2, arg3, ticket_of(arg0, arg2), arg4, arg7, arg8);
    }

    public fun execute_disable_timelock(arg0: &mut 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::CapStore, arg1: &mut 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::Timelock, arg2: &mut 0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::auth::Auth, arg3: &0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::registry::Registry, arg4: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::Auth, arg5: vector<u8>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = DisableTimelock{dummy_field: false};
        let (_, v2) = 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::consume<DisableTimelock, DisableTimelockParams>(arg1, 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::execute_admin<DisableTimelock, DisableTimelockParams>(arg0, arg1, arg4, arg5, arg6, arg7), v0);
        let DisableTimelockParams {  } = v2;
        0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::admin::disable_timelock(arg2, arg3, 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::remove<0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::timelock_cap::TimelockCap>(arg0), arg7);
    }

    public fun execute_init_token_reserve<T0>(arg0: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::CapStore, arg1: &mut 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::Timelock, arg2: &0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::auth::Auth, arg3: &mut 0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::registry::Registry, arg4: &0x2::coin_registry::Currency<T0>, arg5: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::Auth, arg6: vector<u8>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = InitTokenReserve{dummy_field: false};
        let (_, v2) = 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::consume<InitTokenReserve, InitTokenReserveParams>(arg1, 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::execute_auth<InitTokenReserve, InitTokenReserveParams>(arg0, arg1, arg5, arg6, arg7, arg8), v0);
        let InitTokenReserveParams { pos0: v3 } = v2;
        0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::assert_type<T0>(v3);
        0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::admin::init_token_reserve<T0>(arg2, arg3, ticket_of(arg0, arg2), arg4, arg7, arg8);
    }

    public fun execute_init_token_reserve_with_metadata<T0>(arg0: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::CapStore, arg1: &mut 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::Timelock, arg2: &0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::auth::Auth, arg3: &mut 0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::registry::Registry, arg4: &0x2::coin::CoinMetadata<T0>, arg5: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::Auth, arg6: vector<u8>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = InitTokenReserveWithMetadata{dummy_field: false};
        let (_, v2) = 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::consume<InitTokenReserveWithMetadata, InitTokenReserveWithMetadataParams>(arg1, 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::execute_auth<InitTokenReserveWithMetadata, InitTokenReserveWithMetadataParams>(arg0, arg1, arg5, arg6, arg7, arg8), v0);
        let InitTokenReserveWithMetadataParams { pos0: v3 } = v2;
        0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::assert_type<T0>(v3);
        0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::admin::init_token_reserve_with_metadata<T0>(arg2, arg3, ticket_of(arg0, arg2), arg4, arg7, arg8);
    }

    public fun execute_mint_user_cap<T0>(arg0: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::CapStore, arg1: &mut 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::Timelock, arg2: &0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::auth::Auth, arg3: &mut 0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::registry::Registry, arg4: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::Auth, arg5: vector<u8>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = MintUserCap{dummy_field: false};
        let (_, v2) = 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::consume<MintUserCap, MintUserCapParams>(arg1, 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::execute_admin<MintUserCap, MintUserCapParams>(arg0, arg1, arg4, arg5, arg6, arg7), v0);
        let MintUserCapParams {
            pos0 : v3,
            pos1 : v4,
            pos2 : v5,
        } = v2;
        0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::assert_type<T0>(v3);
        0x2::transfer::public_transfer<0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::user_cap::UserCap<T0>>(0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::admin::mint_user_cap<T0>(arg2, arg3, ticket_of(arg0, arg2), v4, arg7), v5);
    }

    public fun execute_remove_admin(arg0: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::CapStore, arg1: &mut 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::Timelock, arg2: &mut 0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::auth::Auth, arg3: &0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::registry::Registry, arg4: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::Auth, arg5: vector<u8>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = RemoveAdmin{dummy_field: false};
        let (_, v2) = 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::consume<RemoveAdmin, RemoveAdminParams>(arg1, 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::execute_admin<RemoveAdmin, RemoveAdminParams>(arg0, arg1, arg4, arg5, arg6, arg7), v0);
        let RemoveAdminParams { pos0: v3 } = v2;
        0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::admin::remove_admin(arg2, arg3, ticket_of(arg0, arg2), v3, arg7);
    }

    public fun execute_set_user_authorization<T0>(arg0: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::CapStore, arg1: &mut 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::Timelock, arg2: &0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::auth::Auth, arg3: &mut 0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::registry::Registry, arg4: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::Auth, arg5: vector<u8>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = SetUserAuthorization{dummy_field: false};
        let (_, v2) = 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::consume<SetUserAuthorization, SetUserAuthorizationParams>(arg1, 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::execute_admin<SetUserAuthorization, SetUserAuthorizationParams>(arg0, arg1, arg4, arg5, arg6, arg7), v0);
        let SetUserAuthorizationParams {
            pos0 : v3,
            pos1 : v4,
            pos2 : v5,
        } = v2;
        0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::assert_type<T0>(v3);
        0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::admin::set_user_authorization<T0>(arg2, arg3, ticket_of(arg0, arg2), v4, v5, arg7);
    }

    public fun execute_unpause_global(arg0: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::CapStore, arg1: &mut 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::Timelock, arg2: &0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::auth::Auth, arg3: &mut 0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::registry::Registry, arg4: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::Auth, arg5: vector<u8>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = UnpauseGlobal{dummy_field: false};
        let (_, v2) = 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::consume<UnpauseGlobal, UnpauseGlobalParams>(arg1, 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::execute_admin<UnpauseGlobal, UnpauseGlobalParams>(arg0, arg1, arg4, arg5, arg6, arg7), v0);
        let UnpauseGlobalParams { pos0: v3 } = v2;
        0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::admin::unpause_global(arg2, arg3, ticket_of(arg0, arg2), v3, arg7);
    }

    public fun execute_unpause_token<T0>(arg0: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::CapStore, arg1: &mut 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::Timelock, arg2: &0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::auth::Auth, arg3: &0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::registry::Registry, arg4: &mut 0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::reserve::TokenReserve<T0>, arg5: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::Auth, arg6: vector<u8>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = UnpauseToken{dummy_field: false};
        let (_, v2) = 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::consume<UnpauseToken, UnpauseTokenParams>(arg1, 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::execute_admin<UnpauseToken, UnpauseTokenParams>(arg0, arg1, arg5, arg6, arg7, arg8), v0);
        let UnpauseTokenParams {
            pos0 : v3,
            pos1 : v4,
        } = v2;
        0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::assert_target<0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::reserve::TokenReserve<T0>>(arg4, v3);
        0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::admin::unpause_token<T0>(arg2, arg3, ticket_of(arg0, arg2), arg4, v4, arg8);
    }

    public fun execute_unpause_user<T0>(arg0: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::CapStore, arg1: &mut 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::Timelock, arg2: &0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::auth::Auth, arg3: &0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::registry::Registry, arg4: &mut 0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::reserve::TokenReserve<T0>, arg5: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::Auth, arg6: vector<u8>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = UnpauseUser{dummy_field: false};
        let (_, v2) = 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::consume<UnpauseUser, UnpauseUserParams>(arg1, 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::execute_admin<UnpauseUser, UnpauseUserParams>(arg0, arg1, arg5, arg6, arg7, arg8), v0);
        let UnpauseUserParams {
            pos0 : v3,
            pos1 : v4,
            pos2 : v5,
        } = v2;
        0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::assert_target<0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::reserve::TokenReserve<T0>>(arg4, v3);
        0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::admin::unpause_user<T0>(arg2, arg3, ticket_of(arg0, arg2), arg4, v4, v5, arg8);
    }

    public fun execute_update_auths(arg0: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::CapStore, arg1: &mut 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::Timelock, arg2: &mut 0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::auth::Auth, arg3: &0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::registry::Registry, arg4: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::Auth, arg5: vector<u8>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = UpdateAuths{dummy_field: false};
        let (_, v2) = 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::consume<UpdateAuths, UpdateAuthsParams>(arg1, 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::execute_admin<UpdateAuths, UpdateAuthsParams>(arg0, arg1, arg4, arg5, arg6, arg7), v0);
        let UpdateAuthsParams { pos0: v3 } = v2;
        0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::admin::update_auths(arg2, arg3, ticket_of(arg0, arg2), v3, arg7);
    }

    public fun execute_update_guardians(arg0: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::CapStore, arg1: &mut 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::Timelock, arg2: &mut 0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::auth::Auth, arg3: &0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::registry::Registry, arg4: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::Auth, arg5: vector<u8>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = UpdateGuardians{dummy_field: false};
        let (_, v2) = 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::consume<UpdateGuardians, UpdateGuardiansParams>(arg1, 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::execute_admin<UpdateGuardians, UpdateGuardiansParams>(arg0, arg1, arg4, arg5, arg6, arg7), v0);
        let UpdateGuardiansParams { pos0: v3 } = v2;
        0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::admin::update_guardians(arg2, arg3, ticket_of(arg0, arg2), v3, arg7);
    }

    public fun execute_update_migrators(arg0: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::CapStore, arg1: &mut 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::Timelock, arg2: &mut 0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::auth::Auth, arg3: &0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::registry::Registry, arg4: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::Auth, arg5: vector<u8>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = UpdateMigrators{dummy_field: false};
        let (_, v2) = 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::consume<UpdateMigrators, UpdateMigratorsParams>(arg1, 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::execute_admin<UpdateMigrators, UpdateMigratorsParams>(arg0, arg1, arg4, arg5, arg6, arg7), v0);
        let UpdateMigratorsParams { pos0: v3 } = v2;
        0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::admin::update_migrators(arg2, arg3, ticket_of(arg0, arg2), v3, arg7);
    }

    public fun execute_update_rate_data_v1<T0>(arg0: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::CapStore, arg1: &mut 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::Timelock, arg2: &0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::auth::Auth, arg3: &0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::registry::Registry, arg4: &mut 0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::reserve::TokenReserve<T0>, arg5: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::Auth, arg6: vector<u8>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = UpdateRateDataV1{dummy_field: false};
        let (_, v2) = 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::consume<UpdateRateDataV1, UpdateRateDataV1Params>(arg1, 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::execute_auth<UpdateRateDataV1, UpdateRateDataV1Params>(arg0, arg1, arg5, arg6, arg7, arg8), v0);
        let UpdateRateDataV1Params {
            pos0 : v3,
            pos1 : v4,
        } = v2;
        0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::assert_target<0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::reserve::TokenReserve<T0>>(arg4, v3);
        0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::admin::update_rate_data_v1<T0>(arg2, arg3, ticket_of(arg0, arg2), arg4, v4, arg7, arg8);
    }

    public fun execute_update_rate_data_v2<T0>(arg0: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::CapStore, arg1: &mut 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::Timelock, arg2: &0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::auth::Auth, arg3: &0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::registry::Registry, arg4: &mut 0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::reserve::TokenReserve<T0>, arg5: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::Auth, arg6: vector<u8>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = UpdateRateDataV2{dummy_field: false};
        let (_, v2) = 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::consume<UpdateRateDataV2, UpdateRateDataV2Params>(arg1, 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::execute_auth<UpdateRateDataV2, UpdateRateDataV2Params>(arg0, arg1, arg5, arg6, arg7, arg8), v0);
        let UpdateRateDataV2Params {
            pos0 : v3,
            pos1 : v4,
        } = v2;
        0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::assert_target<0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::reserve::TokenReserve<T0>>(arg4, v3);
        0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::admin::update_rate_data_v2<T0>(arg2, arg3, ticket_of(arg0, arg2), arg4, v4, arg7, arg8);
    }

    public fun execute_update_revenue_collector(arg0: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::CapStore, arg1: &mut 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::Timelock, arg2: &0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::auth::Auth, arg3: &mut 0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::registry::Registry, arg4: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::Auth, arg5: vector<u8>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = UpdateRevenueCollector{dummy_field: false};
        let (_, v2) = 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::consume<UpdateRevenueCollector, UpdateRevenueCollectorParams>(arg1, 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::execute_admin<UpdateRevenueCollector, UpdateRevenueCollectorParams>(arg0, arg1, arg4, arg5, arg6, arg7), v0);
        let UpdateRevenueCollectorParams { pos0: v3 } = v2;
        0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::admin::update_revenue_collector(arg2, arg3, ticket_of(arg0, arg2), v3, arg7);
    }

    public fun execute_update_token_config<T0>(arg0: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::CapStore, arg1: &mut 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::Timelock, arg2: &0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::auth::Auth, arg3: &0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::registry::Registry, arg4: &mut 0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::reserve::TokenReserve<T0>, arg5: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::Auth, arg6: vector<u8>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = UpdateTokenConfig{dummy_field: false};
        let (_, v2) = 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::consume<UpdateTokenConfig, UpdateTokenConfigParams>(arg1, 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::execute_auth<UpdateTokenConfig, UpdateTokenConfigParams>(arg0, arg1, arg5, arg6, arg7, arg8), v0);
        let UpdateTokenConfigParams {
            pos0 : v3,
            pos1 : v4,
        } = v2;
        0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::assert_target<0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::reserve::TokenReserve<T0>>(arg4, v3);
        0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::admin::update_token_config<T0>(arg2, arg3, ticket_of(arg0, arg2), arg4, v4, arg7, arg8);
    }

    public fun execute_update_user_borrow_configs<T0>(arg0: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::CapStore, arg1: &mut 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::Timelock, arg2: &0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::auth::Auth, arg3: &0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::registry::Registry, arg4: &mut 0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::reserve::TokenReserve<T0>, arg5: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::Auth, arg6: vector<u8>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = UpdateUserBorrowConfigs{dummy_field: false};
        let (_, v2) = 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::consume<UpdateUserBorrowConfigs, UpdateUserBorrowConfigsParams>(arg1, 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::execute_auth<UpdateUserBorrowConfigs, UpdateUserBorrowConfigsParams>(arg0, arg1, arg5, arg6, arg7, arg8), v0);
        let UpdateUserBorrowConfigsParams {
            pos0 : v3,
            pos1 : v4,
            pos2 : v5,
        } = v2;
        0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::assert_target<0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::reserve::TokenReserve<T0>>(arg4, v3);
        0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::admin::update_user_borrow_configs<T0>(arg2, arg3, ticket_of(arg0, arg2), arg4, v4, v5, arg7, arg8);
    }

    public fun execute_update_user_supply_config<T0>(arg0: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::CapStore, arg1: &mut 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::Timelock, arg2: &0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::auth::Auth, arg3: &0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::registry::Registry, arg4: &mut 0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::reserve::TokenReserve<T0>, arg5: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::Auth, arg6: vector<u8>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = UpdateUserSupplyConfig{dummy_field: false};
        let (_, v2) = 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::consume<UpdateUserSupplyConfig, UpdateUserSupplyConfigParams>(arg1, 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::execute_auth<UpdateUserSupplyConfig, UpdateUserSupplyConfigParams>(arg0, arg1, arg5, arg6, arg7, arg8), v0);
        let UpdateUserSupplyConfigParams {
            pos0 : v3,
            pos1 : v4,
            pos2 : v5,
        } = v2;
        0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::assert_target<0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::reserve::TokenReserve<T0>>(arg4, v3);
        0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::admin::update_user_supply_config<T0>(arg2, arg3, ticket_of(arg0, arg2), arg4, v4, v5, arg7, arg8);
    }

    public fun execute_update_user_withdrawal_limit<T0>(arg0: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::CapStore, arg1: &mut 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::Timelock, arg2: &0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::auth::Auth, arg3: &0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::registry::Registry, arg4: &mut 0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::reserve::TokenReserve<T0>, arg5: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::Auth, arg6: vector<u8>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = UpdateUserWithdrawalLimit{dummy_field: false};
        let (_, v2) = 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::consume<UpdateUserWithdrawalLimit, UpdateUserWithdrawalLimitParams>(arg1, 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::execute_auth<UpdateUserWithdrawalLimit, UpdateUserWithdrawalLimitParams>(arg0, arg1, arg5, arg6, arg7, arg8), v0);
        let UpdateUserWithdrawalLimitParams {
            pos0 : v3,
            pos1 : v4,
            pos2 : v5,
        } = v2;
        0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::assert_target<0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::reserve::TokenReserve<T0>>(arg4, v3);
        0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::admin::update_user_withdrawal_limit<T0>(arg2, arg3, ticket_of(arg0, arg2), arg4, v4, v5, arg7, arg8);
    }

    public fun schedule_add_admin(arg0: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::CapStore, arg1: &mut 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::Timelock, arg2: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::Auth, arg3: address, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : vector<u8> {
        let v0 = AddAdminParams{pos0: arg3};
        0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::schedule_admin<AddAdmin, AddAdminParams>(arg0, arg1, arg2, v0, arg4, arg5, arg6)
    }

    public fun schedule_collect_revenue(arg0: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::CapStore, arg1: &mut 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::Timelock, arg2: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::Auth, arg3: 0x2::object::ID, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : vector<u8> {
        let v0 = CollectRevenueParams{pos0: arg3};
        0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::schedule_auth<CollectRevenue, CollectRevenueParams>(arg0, arg1, arg2, v0, arg4, arg5, arg6)
    }

    public fun schedule_disable_timelock(arg0: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::CapStore, arg1: &mut 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::Timelock, arg2: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::Auth, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : vector<u8> {
        let v0 = DisableTimelockParams{dummy_field: false};
        0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::schedule_admin<DisableTimelock, DisableTimelockParams>(arg0, arg1, arg2, v0, arg3, arg4, arg5)
    }

    public fun schedule_init_token_reserve<T0>(arg0: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::CapStore, arg1: &mut 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::Timelock, arg2: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::Auth, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : vector<u8> {
        let v0 = InitTokenReserveParams{pos0: 0x1::type_name::with_original_ids<T0>()};
        0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::schedule_auth<InitTokenReserve, InitTokenReserveParams>(arg0, arg1, arg2, v0, arg3, arg4, arg5)
    }

    public fun schedule_init_token_reserve_with_metadata<T0>(arg0: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::CapStore, arg1: &mut 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::Timelock, arg2: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::Auth, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : vector<u8> {
        let v0 = InitTokenReserveWithMetadataParams{pos0: 0x1::type_name::with_original_ids<T0>()};
        0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::schedule_auth<InitTokenReserveWithMetadata, InitTokenReserveWithMetadataParams>(arg0, arg1, arg2, v0, arg3, arg4, arg5)
    }

    public fun schedule_mint_user_cap<T0>(arg0: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::CapStore, arg1: &mut 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::Timelock, arg2: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::Auth, arg3: 0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::keys::Holder, arg4: address, arg5: vector<u8>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : vector<u8> {
        let v0 = MintUserCapParams{
            pos0 : 0x1::type_name::with_original_ids<T0>(),
            pos1 : arg3,
            pos2 : arg4,
        };
        0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::schedule_admin<MintUserCap, MintUserCapParams>(arg0, arg1, arg2, v0, arg5, arg6, arg7)
    }

    public fun schedule_remove_admin(arg0: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::CapStore, arg1: &mut 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::Timelock, arg2: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::Auth, arg3: address, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : vector<u8> {
        let v0 = RemoveAdminParams{pos0: arg3};
        0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::schedule_admin<RemoveAdmin, RemoveAdminParams>(arg0, arg1, arg2, v0, arg4, arg5, arg6)
    }

    public fun schedule_set_user_authorization<T0>(arg0: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::CapStore, arg1: &mut 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::Timelock, arg2: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::Auth, arg3: 0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::keys::Holder, arg4: bool, arg5: vector<u8>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : vector<u8> {
        let v0 = SetUserAuthorizationParams{
            pos0 : 0x1::type_name::with_original_ids<T0>(),
            pos1 : arg3,
            pos2 : arg4,
        };
        0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::schedule_admin<SetUserAuthorization, SetUserAuthorizationParams>(arg0, arg1, arg2, v0, arg5, arg6, arg7)
    }

    public fun schedule_unpause_global(arg0: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::CapStore, arg1: &mut 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::Timelock, arg2: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::Auth, arg3: 0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::pause::Action, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : vector<u8> {
        let v0 = UnpauseGlobalParams{pos0: arg3};
        0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::schedule_admin<UnpauseGlobal, UnpauseGlobalParams>(arg0, arg1, arg2, v0, arg4, arg5, arg6)
    }

    public fun schedule_unpause_token(arg0: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::CapStore, arg1: &mut 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::Timelock, arg2: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::Auth, arg3: 0x2::object::ID, arg4: 0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::pause::Action, arg5: vector<u8>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : vector<u8> {
        let v0 = UnpauseTokenParams{
            pos0 : arg3,
            pos1 : arg4,
        };
        0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::schedule_admin<UnpauseToken, UnpauseTokenParams>(arg0, arg1, arg2, v0, arg5, arg6, arg7)
    }

    public fun schedule_unpause_user(arg0: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::CapStore, arg1: &mut 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::Timelock, arg2: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::Auth, arg3: 0x2::object::ID, arg4: 0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::keys::Holder, arg5: 0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::pause::Action, arg6: vector<u8>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : vector<u8> {
        let v0 = UnpauseUserParams{
            pos0 : arg3,
            pos1 : arg4,
            pos2 : arg5,
        };
        0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::schedule_admin<UnpauseUser, UnpauseUserParams>(arg0, arg1, arg2, v0, arg6, arg7, arg8)
    }

    public fun schedule_update_auths(arg0: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::CapStore, arg1: &mut 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::Timelock, arg2: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::Auth, arg3: vector<0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::structs::AddressBool>, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : vector<u8> {
        let v0 = UpdateAuthsParams{pos0: arg3};
        0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::schedule_admin<UpdateAuths, UpdateAuthsParams>(arg0, arg1, arg2, v0, arg4, arg5, arg6)
    }

    public fun schedule_update_guardians(arg0: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::CapStore, arg1: &mut 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::Timelock, arg2: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::Auth, arg3: vector<0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::structs::AddressBool>, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : vector<u8> {
        let v0 = &arg3;
        let v1 = 0;
        let v2;
        while (v1 < 0x1::vector::length<0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::structs::AddressBool>(v0)) {
            if (!0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::structs::get_address_bool_value(0x1::vector::borrow<0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::structs::AddressBool>(v0, v1))) {
                v2 = false;
                /* label 6 */
                assert!(v2, 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::errors::guardian_update_adds_only());
                let v3 = UpdateGuardiansParams{pos0: arg3};
                return 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::schedule_admin<UpdateGuardians, UpdateGuardiansParams>(arg0, arg1, arg2, v3, arg4, arg5, arg6)
            };
            v1 = v1 + 1;
        };
        v2 = true;
        /* goto 6 */
    }

    public fun schedule_update_migrators(arg0: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::CapStore, arg1: &mut 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::Timelock, arg2: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::Auth, arg3: vector<0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::structs::AddressBool>, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : vector<u8> {
        let v0 = UpdateMigratorsParams{pos0: arg3};
        0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::schedule_admin<UpdateMigrators, UpdateMigratorsParams>(arg0, arg1, arg2, v0, arg4, arg5, arg6)
    }

    public fun schedule_update_rate_data_v1(arg0: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::CapStore, arg1: &mut 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::Timelock, arg2: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::Auth, arg3: 0x2::object::ID, arg4: 0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::structs::RateDataV1Params, arg5: vector<u8>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : vector<u8> {
        let v0 = UpdateRateDataV1Params{
            pos0 : arg3,
            pos1 : arg4,
        };
        0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::schedule_auth<UpdateRateDataV1, UpdateRateDataV1Params>(arg0, arg1, arg2, v0, arg5, arg6, arg7)
    }

    public fun schedule_update_rate_data_v2(arg0: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::CapStore, arg1: &mut 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::Timelock, arg2: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::Auth, arg3: 0x2::object::ID, arg4: 0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::structs::RateDataV2Params, arg5: vector<u8>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : vector<u8> {
        let v0 = UpdateRateDataV2Params{
            pos0 : arg3,
            pos1 : arg4,
        };
        0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::schedule_auth<UpdateRateDataV2, UpdateRateDataV2Params>(arg0, arg1, arg2, v0, arg5, arg6, arg7)
    }

    public fun schedule_update_revenue_collector(arg0: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::CapStore, arg1: &mut 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::Timelock, arg2: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::Auth, arg3: address, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : vector<u8> {
        let v0 = UpdateRevenueCollectorParams{pos0: arg3};
        0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::schedule_admin<UpdateRevenueCollector, UpdateRevenueCollectorParams>(arg0, arg1, arg2, v0, arg4, arg5, arg6)
    }

    public fun schedule_update_token_config(arg0: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::CapStore, arg1: &mut 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::Timelock, arg2: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::Auth, arg3: 0x2::object::ID, arg4: 0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::structs::TokenConfig, arg5: vector<u8>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : vector<u8> {
        let v0 = UpdateTokenConfigParams{
            pos0 : arg3,
            pos1 : arg4,
        };
        0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::schedule_auth<UpdateTokenConfig, UpdateTokenConfigParams>(arg0, arg1, arg2, v0, arg5, arg6, arg7)
    }

    public fun schedule_update_user_borrow_configs(arg0: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::CapStore, arg1: &mut 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::Timelock, arg2: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::Auth, arg3: 0x2::object::ID, arg4: 0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::keys::Holder, arg5: 0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::structs::UserBorrowConfig, arg6: vector<u8>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : vector<u8> {
        let v0 = UpdateUserBorrowConfigsParams{
            pos0 : arg3,
            pos1 : arg4,
            pos2 : arg5,
        };
        0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::schedule_auth<UpdateUserBorrowConfigs, UpdateUserBorrowConfigsParams>(arg0, arg1, arg2, v0, arg6, arg7, arg8)
    }

    public fun schedule_update_user_supply_config(arg0: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::CapStore, arg1: &mut 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::Timelock, arg2: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::Auth, arg3: 0x2::object::ID, arg4: 0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::keys::Holder, arg5: 0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::structs::UserSupplyConfig, arg6: vector<u8>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : vector<u8> {
        let v0 = UpdateUserSupplyConfigParams{
            pos0 : arg3,
            pos1 : arg4,
            pos2 : arg5,
        };
        0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::schedule_auth<UpdateUserSupplyConfig, UpdateUserSupplyConfigParams>(arg0, arg1, arg2, v0, arg6, arg7, arg8)
    }

    public fun schedule_update_user_withdrawal_limit(arg0: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::CapStore, arg1: &mut 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::Timelock, arg2: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::Auth, arg3: 0x2::object::ID, arg4: 0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::keys::Holder, arg5: u64, arg6: vector<u8>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : vector<u8> {
        let v0 = UpdateUserWithdrawalLimitParams{
            pos0 : arg3,
            pos1 : arg4,
            pos2 : arg5,
        };
        0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::schedule_auth<UpdateUserWithdrawalLimit, UpdateUserWithdrawalLimitParams>(arg0, arg1, arg2, v0, arg6, arg7, arg8)
    }

    fun ticket_of(arg0: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::CapStore, arg1: &0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::auth::Auth) : 0x1::option::Option<0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::timelock_cap::TimelockTicket> {
        if (!0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::holds<0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::timelock_cap::TimelockCap>(arg0)) {
            return 0x1::option::none<0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::timelock_cap::TimelockTicket>()
        };
        0x1::option::some<0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::timelock_cap::TimelockTicket>(0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::auth::timelock_ticket(arg1, 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::borrow<0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::timelock_cap::TimelockCap>(arg0)))
    }

    // decompiled from Move bytecode v7
}

