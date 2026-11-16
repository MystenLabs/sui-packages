module 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::lending_gov {
    struct UpdateAdmin has drop {
        dummy_field: bool,
    }

    struct UpdateAdminParams has drop, store {
        pos0: address,
        pos1: bool,
    }

    struct UpdateRole has drop {
        dummy_field: bool,
    }

    struct UpdateRoleParams has drop, store {
        pos0: 0x1::type_name::TypeName,
        pos1: address,
        pos2: bool,
    }

    struct InitLending has drop {
        dummy_field: bool,
    }

    struct InitLendingParams has drop, store {
        pos0: 0x1::type_name::TypeName,
    }

    struct InitLendingWithMetadata has drop {
        dummy_field: bool,
    }

    struct InitLendingWithMetadataParams has drop, store {
        pos0: 0x1::type_name::TypeName,
    }

    struct MintRewardsWriterCap has drop {
        dummy_field: bool,
    }

    struct MintRewardsWriterCapParams has drop, store {
        pos0: 0x2::object::ID,
        pos1: address,
    }

    struct RevokeRewardsWriter has drop {
        dummy_field: bool,
    }

    struct RevokeRewardsWriterParams has drop, store {
        pos0: 0x2::object::ID,
    }

    struct DisableTimelock has drop {
        dummy_field: bool,
    }

    struct DisableTimelockParams has drop, store {
        dummy_field: bool,
    }

    public fun enable_timelock(arg0: &mut 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::CapStore, arg1: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::Auth, arg2: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::SetupCap, arg3: &0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::registry::LendingRegistry, arg4: &mut 0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::auth::Auth, arg5: &mut 0x2::tx_context::TxContext) {
        0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::assert_roles_finalized(arg1);
        0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::store_cap<0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::timelock_cap::TimelockCap>(arg0, 0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::admin::mint_timelock_cap(arg3, arg4, arg5));
    }

    public fun execute_disable_timelock(arg0: &mut 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::CapStore, arg1: &mut 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::Timelock, arg2: &0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::registry::LendingRegistry, arg3: &mut 0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::auth::Auth, arg4: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::Auth, arg5: vector<u8>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = DisableTimelock{dummy_field: false};
        let (_, v2) = 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::consume<DisableTimelock, DisableTimelockParams>(arg1, 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::execute_admin<DisableTimelock, DisableTimelockParams>(arg0, arg1, arg4, arg5, arg6, arg7), v0);
        let DisableTimelockParams {  } = v2;
        0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::admin::disable_timelock(arg2, arg3, 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::remove<0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::timelock_cap::TimelockCap>(arg0), arg7);
    }

    public fun execute_init_lending<T0>(arg0: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::CapStore, arg1: &mut 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::Timelock, arg2: &mut 0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::registry::LendingRegistry, arg3: &0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::auth::Auth, arg4: &mut 0x2::coin_registry::CoinRegistry, arg5: &0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::reserve::TokenReserve<T0>, arg6: &0x2::coin_registry::Currency<T0>, arg7: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::Auth, arg8: vector<u8>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = InitLending{dummy_field: false};
        let (_, v2) = 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::consume<InitLending, InitLendingParams>(arg1, 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::execute_admin<InitLending, InitLendingParams>(arg0, arg1, arg7, arg8, arg9, arg10), v0);
        let InitLendingParams { pos0: v3 } = v2;
        0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::assert_type<T0>(v3);
        0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::admin::init_lending<T0>(arg2, arg3, ticket_of(arg0, arg3), arg4, arg5, arg6, arg9, arg10);
    }

    public fun execute_init_lending_with_metadata<T0>(arg0: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::CapStore, arg1: &mut 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::Timelock, arg2: &mut 0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::registry::LendingRegistry, arg3: &0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::auth::Auth, arg4: &mut 0x2::coin_registry::CoinRegistry, arg5: &0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::reserve::TokenReserve<T0>, arg6: &0x2::coin::CoinMetadata<T0>, arg7: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::Auth, arg8: vector<u8>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = InitLendingWithMetadata{dummy_field: false};
        let (_, v2) = 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::consume<InitLendingWithMetadata, InitLendingWithMetadataParams>(arg1, 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::execute_admin<InitLendingWithMetadata, InitLendingWithMetadataParams>(arg0, arg1, arg7, arg8, arg9, arg10), v0);
        let InitLendingWithMetadataParams { pos0: v3 } = v2;
        0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::assert_type<T0>(v3);
        0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::admin::init_lending_with_metadata<T0>(arg2, arg3, ticket_of(arg0, arg3), arg4, arg5, arg6, arg9, arg10);
    }

    public fun execute_mint_rewards_writer_cap<T0>(arg0: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::CapStore, arg1: &mut 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::Timelock, arg2: &0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::registry::LendingRegistry, arg3: &0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::auth::Auth, arg4: &mut 0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::lending_state::LendingState<T0>, arg5: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::Auth, arg6: vector<u8>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = MintRewardsWriterCap{dummy_field: false};
        let (_, v2) = 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::consume<MintRewardsWriterCap, MintRewardsWriterCapParams>(arg1, 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::execute_admin<MintRewardsWriterCap, MintRewardsWriterCapParams>(arg0, arg1, arg5, arg6, arg7, arg8), v0);
        let MintRewardsWriterCapParams {
            pos0 : v3,
            pos1 : v4,
        } = v2;
        0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::assert_target<0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::lending_state::LendingState<T0>>(arg4, v3);
        0x2::transfer::public_transfer<0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::rewards::RewardsWriterCap<T0>>(0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::admin::mint_rewards_writer_cap<T0>(arg2, arg3, ticket_of(arg0, arg3), arg4, arg8), v4);
    }

    public fun execute_revoke_rewards_writer<T0>(arg0: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::CapStore, arg1: &mut 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::Timelock, arg2: &0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::registry::LendingRegistry, arg3: &0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::auth::Auth, arg4: &mut 0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::lending_state::LendingState<T0>, arg5: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::Auth, arg6: vector<u8>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = RevokeRewardsWriter{dummy_field: false};
        let (_, v2) = 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::consume<RevokeRewardsWriter, RevokeRewardsWriterParams>(arg1, 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::execute_admin<RevokeRewardsWriter, RevokeRewardsWriterParams>(arg0, arg1, arg5, arg6, arg7, arg8), v0);
        let RevokeRewardsWriterParams { pos0: v3 } = v2;
        0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::assert_target<0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::lending_state::LendingState<T0>>(arg4, v3);
        0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::admin::revoke_rewards_writer<T0>(arg2, arg3, ticket_of(arg0, arg3), arg4, arg8);
    }

    public fun execute_update_admin(arg0: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::CapStore, arg1: &mut 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::Timelock, arg2: &0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::registry::LendingRegistry, arg3: &mut 0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::auth::Auth, arg4: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::Auth, arg5: vector<u8>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = UpdateAdmin{dummy_field: false};
        let (_, v2) = 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::consume<UpdateAdmin, UpdateAdminParams>(arg1, 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::execute_admin<UpdateAdmin, UpdateAdminParams>(arg0, arg1, arg4, arg5, arg6, arg7), v0);
        let UpdateAdminParams {
            pos0 : v3,
            pos1 : v4,
        } = v2;
        0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::admin::update_admin(arg2, arg3, ticket_of(arg0, arg3), v3, v4, arg7);
    }

    public fun execute_update_role<T0: drop + store>(arg0: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::CapStore, arg1: &mut 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::Timelock, arg2: &0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::registry::LendingRegistry, arg3: &mut 0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::auth::Auth, arg4: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::Auth, arg5: vector<u8>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = UpdateRole{dummy_field: false};
        let (_, v2) = 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::consume<UpdateRole, UpdateRoleParams>(arg1, 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::execute_admin<UpdateRole, UpdateRoleParams>(arg0, arg1, arg4, arg5, arg6, arg7), v0);
        let UpdateRoleParams {
            pos0 : v3,
            pos1 : v4,
            pos2 : v5,
        } = v2;
        0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::assert_type<T0>(v3);
        0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::admin::update_role<T0>(arg2, arg3, ticket_of(arg0, arg3), v4, v5, arg7);
    }

    public fun schedule_disable_timelock(arg0: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::CapStore, arg1: &mut 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::Timelock, arg2: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::Auth, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : vector<u8> {
        let v0 = DisableTimelockParams{dummy_field: false};
        0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::schedule_admin<DisableTimelock, DisableTimelockParams>(arg0, arg1, arg2, v0, arg3, arg4, arg5)
    }

    public fun schedule_init_lending<T0>(arg0: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::CapStore, arg1: &mut 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::Timelock, arg2: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::Auth, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : vector<u8> {
        let v0 = InitLendingParams{pos0: 0x1::type_name::with_original_ids<T0>()};
        0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::schedule_admin<InitLending, InitLendingParams>(arg0, arg1, arg2, v0, arg3, arg4, arg5)
    }

    public fun schedule_init_lending_with_metadata<T0>(arg0: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::CapStore, arg1: &mut 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::Timelock, arg2: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::Auth, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : vector<u8> {
        let v0 = InitLendingWithMetadataParams{pos0: 0x1::type_name::with_original_ids<T0>()};
        0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::schedule_admin<InitLendingWithMetadata, InitLendingWithMetadataParams>(arg0, arg1, arg2, v0, arg3, arg4, arg5)
    }

    public fun schedule_mint_rewards_writer_cap(arg0: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::CapStore, arg1: &mut 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::Timelock, arg2: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::Auth, arg3: 0x2::object::ID, arg4: address, arg5: vector<u8>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : vector<u8> {
        let v0 = MintRewardsWriterCapParams{
            pos0 : arg3,
            pos1 : arg4,
        };
        0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::schedule_admin<MintRewardsWriterCap, MintRewardsWriterCapParams>(arg0, arg1, arg2, v0, arg5, arg6, arg7)
    }

    public fun schedule_revoke_rewards_writer(arg0: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::CapStore, arg1: &mut 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::Timelock, arg2: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::Auth, arg3: 0x2::object::ID, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : vector<u8> {
        let v0 = RevokeRewardsWriterParams{pos0: arg3};
        0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::schedule_admin<RevokeRewardsWriter, RevokeRewardsWriterParams>(arg0, arg1, arg2, v0, arg4, arg5, arg6)
    }

    public fun schedule_update_admin(arg0: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::CapStore, arg1: &mut 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::Timelock, arg2: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::Auth, arg3: address, arg4: bool, arg5: vector<u8>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : vector<u8> {
        let v0 = UpdateAdminParams{
            pos0 : arg3,
            pos1 : arg4,
        };
        0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::schedule_admin<UpdateAdmin, UpdateAdminParams>(arg0, arg1, arg2, v0, arg5, arg6, arg7)
    }

    public fun schedule_update_role<T0: drop + store>(arg0: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::CapStore, arg1: &mut 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::Timelock, arg2: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::Auth, arg3: address, arg4: bool, arg5: vector<u8>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : vector<u8> {
        let v0 = UpdateRoleParams{
            pos0 : 0x1::type_name::with_original_ids<T0>(),
            pos1 : arg3,
            pos2 : arg4,
        };
        0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::schedule_admin<UpdateRole, UpdateRoleParams>(arg0, arg1, arg2, v0, arg5, arg6, arg7)
    }

    fun ticket_of(arg0: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::CapStore, arg1: &0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::auth::Auth) : 0x1::option::Option<0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::timelock_cap::TimelockTicket> {
        if (!0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::holds<0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::timelock_cap::TimelockCap>(arg0)) {
            return 0x1::option::none<0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::timelock_cap::TimelockTicket>()
        };
        0x1::option::some<0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::timelock_cap::TimelockTicket>(0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::auth::timelock_ticket(arg1, 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::borrow<0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::timelock_cap::TimelockCap>(arg0)))
    }

    // decompiled from Move bytecode v7
}

