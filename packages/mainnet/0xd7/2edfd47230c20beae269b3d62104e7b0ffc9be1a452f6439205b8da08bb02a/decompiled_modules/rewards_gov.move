module 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::rewards_gov {
    struct UpdateAuthority has drop {
        dummy_field: bool,
    }

    struct UpdateAuthorityParams has drop, store {
        pos0: address,
        pos1: bool,
    }

    struct UpdateAuth has drop {
        dummy_field: bool,
    }

    struct UpdateAuthParams has drop, store {
        pos0: address,
        pos1: bool,
    }

    struct UpdateMigrator has drop {
        dummy_field: bool,
    }

    struct UpdateMigratorParams has drop, store {
        pos0: address,
        pos1: bool,
    }

    struct CreateManager has drop {
        dummy_field: bool,
    }

    struct CreateManagerParams has drop, store {
        pos0: 0x2::object::ID,
    }

    struct StartRewards has drop {
        dummy_field: bool,
    }

    struct StartRewardsParams has drop, store {
        pos0: 0x2::object::ID,
        pos1: u64,
        pos2: u64,
        pos3: u64,
        pos4: u64,
    }

    struct StopRewards has drop {
        dummy_field: bool,
    }

    struct StopRewardsParams has drop, store {
        pos0: 0x2::object::ID,
    }

    struct QueueNextRewards has drop {
        dummy_field: bool,
    }

    struct QueueNextRewardsParams has drop, store {
        pos0: 0x2::object::ID,
        pos1: u64,
        pos2: u64,
    }

    struct CancelQueuedRewards has drop {
        dummy_field: bool,
    }

    struct CancelQueuedRewardsParams has drop, store {
        pos0: 0x2::object::ID,
    }

    struct DisableTimelock has drop {
        dummy_field: bool,
    }

    struct DisableTimelockParams has drop, store {
        dummy_field: bool,
    }

    public fun enable_timelock(arg0: &mut 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::CapStore, arg1: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::Auth, arg2: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::SetupCap, arg3: &mut 0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::rewards_auth::RewardsAuth, arg4: &mut 0x2::tx_context::TxContext) {
        0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::assert_roles_finalized(arg1);
        0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::store_cap<0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::timelock_cap::TimelockCap>(arg0, 0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::admin::mint_timelock_cap(arg3, arg4));
    }

    public fun execute_cancel_queued_rewards<T0>(arg0: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::CapStore, arg1: &mut 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::Timelock, arg2: &0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::registry::LendingRegistry, arg3: &0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::rewards_auth::RewardsAuth, arg4: &0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::rewards_manager::RewardsManager<T0>, arg5: &mut 0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::lending_state::LendingState<T0>, arg6: &0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::reserve::TokenReserve<T0>, arg7: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::Auth, arg8: vector<u8>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = CancelQueuedRewards{dummy_field: false};
        let (_, v2) = 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::consume<CancelQueuedRewards, CancelQueuedRewardsParams>(arg1, 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::execute_auth<CancelQueuedRewards, CancelQueuedRewardsParams>(arg0, arg1, arg7, arg8, arg9, arg10), v0);
        let CancelQueuedRewardsParams { pos0: v3 } = v2;
        0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::assert_target<0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::rewards_manager::RewardsManager<T0>>(arg4, v3);
        0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::admin::cancel_queued_rewards<T0>(arg2, arg3, ticket_of(arg0, arg3), arg4, arg5, arg6, arg9, arg10);
    }

    public fun execute_create_manager<T0>(arg0: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::CapStore, arg1: &mut 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::Timelock, arg2: &0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::rewards_auth::RewardsAuth, arg3: &0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::lending_state::LendingState<T0>, arg4: 0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::rewards::RewardsWriterCap<T0>, arg5: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::Auth, arg6: vector<u8>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = CreateManager{dummy_field: false};
        let (_, v2) = 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::consume<CreateManager, CreateManagerParams>(arg1, 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::execute_auth<CreateManager, CreateManagerParams>(arg0, arg1, arg5, arg6, arg7, arg8), v0);
        let CreateManagerParams { pos0: v3 } = v2;
        0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::assert_target<0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::lending_state::LendingState<T0>>(arg3, v3);
        0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::admin::create_manager<T0>(arg2, ticket_of(arg0, arg2), arg3, arg4, arg8);
    }

    public fun execute_disable_timelock(arg0: &mut 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::CapStore, arg1: &mut 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::Timelock, arg2: &mut 0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::rewards_auth::RewardsAuth, arg3: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::Auth, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = DisableTimelock{dummy_field: false};
        let (_, v2) = 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::consume<DisableTimelock, DisableTimelockParams>(arg1, 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::execute_admin<DisableTimelock, DisableTimelockParams>(arg0, arg1, arg3, arg4, arg5, arg6), v0);
        let DisableTimelockParams {  } = v2;
        0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::admin::disable_timelock(arg2, 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::remove<0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::timelock_cap::TimelockCap>(arg0), arg6);
    }

    public fun execute_queue_next_rewards<T0>(arg0: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::CapStore, arg1: &mut 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::Timelock, arg2: &0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::registry::LendingRegistry, arg3: &0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::rewards_auth::RewardsAuth, arg4: &0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::rewards_manager::RewardsManager<T0>, arg5: &mut 0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::lending_state::LendingState<T0>, arg6: &0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::reserve::TokenReserve<T0>, arg7: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::Auth, arg8: vector<u8>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = QueueNextRewards{dummy_field: false};
        let (_, v2) = 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::consume<QueueNextRewards, QueueNextRewardsParams>(arg1, 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::execute_auth<QueueNextRewards, QueueNextRewardsParams>(arg0, arg1, arg7, arg8, arg9, arg10), v0);
        let QueueNextRewardsParams {
            pos0 : v3,
            pos1 : v4,
            pos2 : v5,
        } = v2;
        0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::assert_target<0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::rewards_manager::RewardsManager<T0>>(arg4, v3);
        0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::admin::queue_next_rewards<T0>(arg2, arg3, ticket_of(arg0, arg3), arg4, arg5, arg6, v4, v5, arg9, arg10);
    }

    public fun execute_start_rewards<T0>(arg0: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::CapStore, arg1: &mut 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::Timelock, arg2: &0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::registry::LendingRegistry, arg3: &0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::rewards_auth::RewardsAuth, arg4: &0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::rewards_manager::RewardsManager<T0>, arg5: &mut 0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::lending_state::LendingState<T0>, arg6: &0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::reserve::TokenReserve<T0>, arg7: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::Auth, arg8: vector<u8>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = StartRewards{dummy_field: false};
        let (_, v2) = 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::consume<StartRewards, StartRewardsParams>(arg1, 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::execute_auth<StartRewards, StartRewardsParams>(arg0, arg1, arg7, arg8, arg9, arg10), v0);
        let StartRewardsParams {
            pos0 : v3,
            pos1 : v4,
            pos2 : v5,
            pos3 : v6,
            pos4 : v7,
        } = v2;
        0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::assert_target<0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::rewards_manager::RewardsManager<T0>>(arg4, v3);
        0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::admin::start_rewards<T0>(arg2, arg3, ticket_of(arg0, arg3), arg4, arg5, arg6, v4, v5, v6, v7, arg9, arg10);
    }

    public fun execute_stop_rewards<T0>(arg0: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::CapStore, arg1: &mut 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::Timelock, arg2: &0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::registry::LendingRegistry, arg3: &0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::rewards_auth::RewardsAuth, arg4: &0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::rewards_manager::RewardsManager<T0>, arg5: &mut 0xc63078660d7e3ed001e565b8bd7e2e6eb7313ef809051165cda901621e1db842::lending_state::LendingState<T0>, arg6: &0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::reserve::TokenReserve<T0>, arg7: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::Auth, arg8: vector<u8>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = StopRewards{dummy_field: false};
        let (_, v2) = 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::consume<StopRewards, StopRewardsParams>(arg1, 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::execute_auth<StopRewards, StopRewardsParams>(arg0, arg1, arg7, arg8, arg9, arg10), v0);
        let StopRewardsParams { pos0: v3 } = v2;
        0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::assert_target<0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::rewards_manager::RewardsManager<T0>>(arg4, v3);
        0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::admin::stop_rewards<T0>(arg2, arg3, ticket_of(arg0, arg3), arg4, arg5, arg6, arg9, arg10);
    }

    public fun execute_update_auth(arg0: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::CapStore, arg1: &mut 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::Timelock, arg2: &mut 0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::rewards_auth::RewardsAuth, arg3: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::Auth, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = UpdateAuth{dummy_field: false};
        let (_, v2) = 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::consume<UpdateAuth, UpdateAuthParams>(arg1, 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::execute_admin<UpdateAuth, UpdateAuthParams>(arg0, arg1, arg3, arg4, arg5, arg6), v0);
        let UpdateAuthParams {
            pos0 : v3,
            pos1 : v4,
        } = v2;
        0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::admin::update_auth(arg2, ticket_of(arg0, arg2), v3, v4, arg6);
    }

    public fun execute_update_authority(arg0: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::CapStore, arg1: &mut 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::Timelock, arg2: &mut 0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::rewards_auth::RewardsAuth, arg3: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::Auth, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = UpdateAuthority{dummy_field: false};
        let (_, v2) = 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::consume<UpdateAuthority, UpdateAuthorityParams>(arg1, 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::execute_admin<UpdateAuthority, UpdateAuthorityParams>(arg0, arg1, arg3, arg4, arg5, arg6), v0);
        let UpdateAuthorityParams {
            pos0 : v3,
            pos1 : v4,
        } = v2;
        0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::admin::update_authority(arg2, ticket_of(arg0, arg2), v3, v4, arg6);
    }

    public fun execute_update_migrator(arg0: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::CapStore, arg1: &mut 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::Timelock, arg2: &mut 0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::rewards_auth::RewardsAuth, arg3: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::Auth, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = UpdateMigrator{dummy_field: false};
        let (_, v2) = 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::consume<UpdateMigrator, UpdateMigratorParams>(arg1, 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::execute_admin<UpdateMigrator, UpdateMigratorParams>(arg0, arg1, arg3, arg4, arg5, arg6), v0);
        let UpdateMigratorParams {
            pos0 : v3,
            pos1 : v4,
        } = v2;
        0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::admin::update_migrator(arg2, ticket_of(arg0, arg2), v3, v4, arg6);
    }

    public fun schedule_cancel_queued_rewards(arg0: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::CapStore, arg1: &mut 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::Timelock, arg2: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::Auth, arg3: 0x2::object::ID, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : vector<u8> {
        let v0 = CancelQueuedRewardsParams{pos0: arg3};
        0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::schedule_auth<CancelQueuedRewards, CancelQueuedRewardsParams>(arg0, arg1, arg2, v0, arg4, arg5, arg6)
    }

    public fun schedule_create_manager(arg0: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::CapStore, arg1: &mut 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::Timelock, arg2: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::Auth, arg3: 0x2::object::ID, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : vector<u8> {
        let v0 = CreateManagerParams{pos0: arg3};
        0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::schedule_auth<CreateManager, CreateManagerParams>(arg0, arg1, arg2, v0, arg4, arg5, arg6)
    }

    public fun schedule_disable_timelock(arg0: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::CapStore, arg1: &mut 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::Timelock, arg2: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::Auth, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : vector<u8> {
        let v0 = DisableTimelockParams{dummy_field: false};
        0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::schedule_admin<DisableTimelock, DisableTimelockParams>(arg0, arg1, arg2, v0, arg3, arg4, arg5)
    }

    public fun schedule_queue_next_rewards(arg0: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::CapStore, arg1: &mut 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::Timelock, arg2: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::Auth, arg3: 0x2::object::ID, arg4: u64, arg5: u64, arg6: vector<u8>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : vector<u8> {
        let v0 = QueueNextRewardsParams{
            pos0 : arg3,
            pos1 : arg4,
            pos2 : arg5,
        };
        0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::schedule_auth<QueueNextRewards, QueueNextRewardsParams>(arg0, arg1, arg2, v0, arg6, arg7, arg8)
    }

    public fun schedule_start_rewards(arg0: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::CapStore, arg1: &mut 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::Timelock, arg2: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::Auth, arg3: 0x2::object::ID, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: vector<u8>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : vector<u8> {
        let v0 = StartRewardsParams{
            pos0 : arg3,
            pos1 : arg4,
            pos2 : arg5,
            pos3 : arg6,
            pos4 : arg7,
        };
        0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::schedule_auth<StartRewards, StartRewardsParams>(arg0, arg1, arg2, v0, arg8, arg9, arg10)
    }

    public fun schedule_stop_rewards(arg0: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::CapStore, arg1: &mut 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::Timelock, arg2: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::Auth, arg3: 0x2::object::ID, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : vector<u8> {
        let v0 = StopRewardsParams{pos0: arg3};
        0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::schedule_auth<StopRewards, StopRewardsParams>(arg0, arg1, arg2, v0, arg4, arg5, arg6)
    }

    public fun schedule_update_auth(arg0: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::CapStore, arg1: &mut 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::Timelock, arg2: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::Auth, arg3: address, arg4: bool, arg5: vector<u8>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : vector<u8> {
        let v0 = UpdateAuthParams{
            pos0 : arg3,
            pos1 : arg4,
        };
        0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::schedule_admin<UpdateAuth, UpdateAuthParams>(arg0, arg1, arg2, v0, arg5, arg6, arg7)
    }

    public fun schedule_update_authority(arg0: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::CapStore, arg1: &mut 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::Timelock, arg2: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::Auth, arg3: address, arg4: bool, arg5: vector<u8>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : vector<u8> {
        let v0 = UpdateAuthorityParams{
            pos0 : arg3,
            pos1 : arg4,
        };
        0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::schedule_admin<UpdateAuthority, UpdateAuthorityParams>(arg0, arg1, arg2, v0, arg5, arg6, arg7)
    }

    public fun schedule_update_migrator(arg0: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::CapStore, arg1: &mut 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::Timelock, arg2: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::Auth, arg3: address, arg4: bool, arg5: vector<u8>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : vector<u8> {
        let v0 = UpdateMigratorParams{
            pos0 : arg3,
            pos1 : arg4,
        };
        0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::schedule_admin<UpdateMigrator, UpdateMigratorParams>(arg0, arg1, arg2, v0, arg5, arg6, arg7)
    }

    fun ticket_of(arg0: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::CapStore, arg1: &0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::rewards_auth::RewardsAuth) : 0x1::option::Option<0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::timelock_cap::TimelockTicket> {
        if (!0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::holds<0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::timelock_cap::TimelockCap>(arg0)) {
            return 0x1::option::none<0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::timelock_cap::TimelockTicket>()
        };
        0x1::option::some<0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::timelock_cap::TimelockTicket>(0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::rewards_auth::timelock_ticket(arg1, 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::borrow<0x8269897ee68730b4bde175c883719f1fa108509113c2c177ad1b456bb3782ba2::timelock_cap::TimelockCap>(arg0)))
    }

    // decompiled from Move bytecode v7
}

