module 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_cross_chain_asset_manager {
    struct CcamAdminCap has store, key {
        id: 0x2::object::UID,
        ccam_id: 0x2::object::ID,
    }

    struct CcamManagerCap has store, key {
        id: 0x2::object::UID,
        ccam_id: 0x2::object::ID,
    }

    struct CcamProcessorCap has store, key {
        id: 0x2::object::UID,
        ccam_id: 0x2::object::ID,
    }

    struct PendingRole has copy, drop, store {
        value: address,
        proposed_at: u64,
    }

    struct PendingAddress has copy, drop, store {
        value: address,
        proposed_at: u64,
    }

    struct PendingLimits has copy, drop, store {
        daily_limit: 0x1::option::Option<u64>,
        max_per_tx: 0x1::option::Option<u64>,
        processor_cooldown: 0x1::option::Option<u64>,
        emergency_cooldown: 0x1::option::Option<u64>,
        proposed_at: u64,
    }

    struct CctpDestination has copy, drop, store {
        domain: u32,
        recipient: address,
        active: bool,
    }

    struct AdapterBinding has copy, drop, store {
        adapter: address,
        active: bool,
        status: u8,
        created_at: u64,
        updated_at: u64,
    }

    struct CcamCooldowns has store {
        emergency_cooldown: u64,
        manager_change_cooldown: u64,
        processor_change_cooldown: u64,
        limits_cooldown: u64,
        adapter_change_cooldown: u64,
        config_change_cooldown: u64,
    }

    struct CrossChainAssetManager<phantom T0> has key {
        id: 0x2::object::UID,
        version: u64,
        proxy_id: 0x2::object::ID,
        underlying: 0x2::balance::Balance<T0>,
        manager: address,
        processor: address,
        paused: bool,
        force_paused: bool,
        paused_at: u64,
        processor_cooldown: u64,
        processor_max_per_tx: u64,
        processor_daily_limit: u64,
        processor_daily_used: u64,
        last_daily_reset: u64,
        last_operation_time: u64,
        gov_cooldowns: CcamCooldowns,
        token_messenger_minter: 0x1::option::Option<address>,
        pending_token_messenger_minter: 0x1::option::Option<PendingAddress>,
        aggregator: 0x1::option::Option<address>,
        pending_aggregator: 0x1::option::Option<PendingAddress>,
        pending_manager: 0x1::option::Option<PendingRole>,
        pending_processor: 0x1::option::Option<PendingRole>,
        pending_limits: 0x1::option::Option<PendingLimits>,
        pending_withdraw_destination: 0x1::option::Option<PendingAddress>,
        allowed_tokens: 0x2::table::Table<0x1::type_name::TypeName, bool>,
        cctp_destinations: 0x2::table::Table<u32, CctpDestination>,
        adapters: 0x2::table::Table<address, AdapterBinding>,
        withdraw_destinations: 0x2::table::Table<address, bool>,
        adapter_count: u64,
    }

    struct CcamInitializedEvent has copy, drop {
        ccam_id: 0x2::object::ID,
        proxy_id: 0x2::object::ID,
        manager: address,
        processor: address,
    }

    struct CcamFundsDepositedEvent has copy, drop {
        ccam_id: 0x2::object::ID,
        amount: u64,
    }

    struct CcamFundsWithdrawnEvent has copy, drop {
        ccam_id: 0x2::object::ID,
        amount: u64,
        to: address,
    }

    struct CcamFundsReturnedToProxyEvent has copy, drop {
        ccam_id: 0x2::object::ID,
        amount: u64,
    }

    struct CcamEmergencySweepEvent has copy, drop {
        ccam_id: 0x2::object::ID,
        amount: u64,
    }

    struct CcamPausedEvent has copy, drop {
        ccam_id: 0x2::object::ID,
    }

    struct CcamUnpausedEvent has copy, drop {
        ccam_id: 0x2::object::ID,
    }

    struct CcamForcePausedEvent has copy, drop {
        ccam_id: 0x2::object::ID,
    }

    struct CcamForceUnpausedEvent has copy, drop {
        ccam_id: 0x2::object::ID,
    }

    struct CcamCctpMessengerProposedEvent has copy, drop {
        ccam_id: 0x2::object::ID,
        new_address: address,
        effective_time: u64,
    }

    struct CcamCctpMessengerUpdatedEvent has copy, drop {
        ccam_id: 0x2::object::ID,
        new_address: address,
    }

    struct CcamCctpDestinationUpdatedEvent has copy, drop {
        ccam_id: 0x2::object::ID,
        domain: u32,
        recipient: address,
        allowed: bool,
    }

    struct CcamCctpSendInitiatedEvent has copy, drop {
        ccam_id: 0x2::object::ID,
        amount: u64,
        destination_domain: u32,
        mint_recipient: address,
    }

    struct CcamAggregatorProposedEvent has copy, drop {
        ccam_id: 0x2::object::ID,
        new_address: address,
        effective_time: u64,
    }

    struct CcamAggregatorUpdatedEvent has copy, drop {
        ccam_id: 0x2::object::ID,
        new_address: address,
    }

    struct CcamAllowedTokenUpdatedEvent has copy, drop {
        ccam_id: 0x2::object::ID,
        token: 0x1::type_name::TypeName,
        allowed: bool,
    }

    struct CcamSwapExecutedEvent has copy, drop {
        ccam_id: 0x2::object::ID,
        token_in: 0x1::type_name::TypeName,
        token_out: 0x1::type_name::TypeName,
        amount_in: u64,
        amount_out_min: u64,
    }

    struct CcamAdapterProposedEvent has copy, drop {
        ccam_id: 0x2::object::ID,
        adapter: address,
        effective_time: u64,
    }

    struct CcamAdapterAcceptedEvent has copy, drop {
        ccam_id: 0x2::object::ID,
        adapter: address,
    }

    struct CcamAdapterRemovedEvent has copy, drop {
        ccam_id: 0x2::object::ID,
        adapter: address,
    }

    struct CcamAdapterDisabledEvent has copy, drop {
        ccam_id: 0x2::object::ID,
        adapter: address,
    }

    struct CcamAdapterEnabledEvent has copy, drop {
        ccam_id: 0x2::object::ID,
        adapter: address,
    }

    struct CcamAdapterPushedEvent has copy, drop {
        ccam_id: 0x2::object::ID,
        adapter: address,
        amount: u64,
    }

    struct CcamManagerChangePendingEvent has copy, drop {
        ccam_id: 0x2::object::ID,
        new_manager: address,
        effective_time: u64,
    }

    struct CcamManagerUpdatedEvent has copy, drop {
        ccam_id: 0x2::object::ID,
        old_manager: address,
        new_manager: address,
    }

    struct CcamManagerChangeCancelledEvent has copy, drop {
        ccam_id: 0x2::object::ID,
        cancelled_new_manager: address,
    }

    struct CcamProcessorChangePendingEvent has copy, drop {
        ccam_id: 0x2::object::ID,
        new_processor: address,
        effective_time: u64,
    }

    struct CcamProcessorUpdatedEvent has copy, drop {
        ccam_id: 0x2::object::ID,
        old_processor: address,
        new_processor: address,
    }

    struct CcamProcessorChangeCancelledEvent has copy, drop {
        ccam_id: 0x2::object::ID,
        cancelled_new_processor: address,
    }

    struct CcamLimitsChangePendingEvent has copy, drop {
        ccam_id: 0x2::object::ID,
        effective_time: u64,
    }

    struct CcamLimitsUpdatedEvent has copy, drop {
        ccam_id: 0x2::object::ID,
    }

    struct CcamLimitsChangeCancelledEvent has copy, drop {
        ccam_id: 0x2::object::ID,
    }

    struct CcamWithdrawDestinationProposedEvent has copy, drop {
        ccam_id: 0x2::object::ID,
        destination: address,
        effective_time: u64,
    }

    struct CcamWithdrawDestinationAddedEvent has copy, drop {
        ccam_id: 0x2::object::ID,
        destination: address,
    }

    struct CcamWithdrawDestinationCancelledEvent has copy, drop {
        ccam_id: 0x2::object::ID,
        destination: address,
    }

    struct CcamWithdrawDestinationRemovedEvent has copy, drop {
        ccam_id: 0x2::object::ID,
        destination: address,
    }

    public fun accept_adapter<T0>(arg0: &mut CrossChainAssetManager<T0>, arg1: &CcamManagerCap, arg2: address, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert_manager<T0>(arg0, arg1, arg4);
        assert!(0x2::table::contains<address, AdapterBinding>(&arg0.adapters, arg2), 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::escrow_no_pending_adapter());
        let v0 = now_secs(arg3);
        let v1 = arg0.adapter_count;
        let v2 = 0x2::table::borrow_mut<address, AdapterBinding>(&mut arg0.adapters, arg2);
        assert!(v2.status == 0, 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::escrow_no_pending_adapter());
        assert!(v0 >= v2.created_at + arg0.gov_cooldowns.adapter_change_cooldown, 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::escrow_adapter_delay_not_elapsed());
        assert!(v1 < 8, 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::escrow_max_adapters_reached());
        v2.status = 1;
        v2.active = true;
        v2.updated_at = v0;
        arg0.adapter_count = v1 + 1;
        let v3 = CcamAdapterAcceptedEvent{
            ccam_id : 0x2::object::id<CrossChainAssetManager<T0>>(arg0),
            adapter : arg2,
        };
        0x2::event::emit<CcamAdapterAcceptedEvent>(v3);
    }

    public fun accept_aggregator<T0>(arg0: &mut CrossChainAssetManager<T0>, arg1: &CcamManagerCap, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert_manager<T0>(arg0, arg1, arg3);
        assert!(0x1::option::is_some<PendingAddress>(&arg0.pending_aggregator), 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::escrow_no_pending_config());
        let v0 = 0x1::option::extract<PendingAddress>(&mut arg0.pending_aggregator);
        assert!(now_secs(arg2) >= v0.proposed_at + arg0.gov_cooldowns.config_change_cooldown, 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::escrow_config_delay_not_elapsed());
        arg0.aggregator = 0x1::option::some<address>(v0.value);
        let v1 = CcamAggregatorUpdatedEvent{
            ccam_id     : 0x2::object::id<CrossChainAssetManager<T0>>(arg0),
            new_address : v0.value,
        };
        0x2::event::emit<CcamAggregatorUpdatedEvent>(v1);
    }

    public fun accept_cctp_messenger<T0>(arg0: &mut CrossChainAssetManager<T0>, arg1: &CcamManagerCap, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert_manager<T0>(arg0, arg1, arg3);
        assert!(0x1::option::is_some<PendingAddress>(&arg0.pending_token_messenger_minter), 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::escrow_no_pending_config());
        let v0 = 0x1::option::extract<PendingAddress>(&mut arg0.pending_token_messenger_minter);
        assert!(now_secs(arg2) >= v0.proposed_at + arg0.gov_cooldowns.config_change_cooldown, 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::escrow_config_delay_not_elapsed());
        arg0.token_messenger_minter = 0x1::option::some<address>(v0.value);
        let v1 = CcamCctpMessengerUpdatedEvent{
            ccam_id     : 0x2::object::id<CrossChainAssetManager<T0>>(arg0),
            new_address : v0.value,
        };
        0x2::event::emit<CcamCctpMessengerUpdatedEvent>(v1);
    }

    public fun accept_limits<T0>(arg0: &mut CrossChainAssetManager<T0>, arg1: &CcamManagerCap, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert_manager<T0>(arg0, arg1, arg3);
        assert!(0x1::option::is_some<PendingLimits>(&arg0.pending_limits), 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::escrow_no_pending_limits_change());
        let v0 = 0x1::option::extract<PendingLimits>(&mut arg0.pending_limits);
        assert!(now_secs(arg2) >= v0.proposed_at + arg0.gov_cooldowns.limits_cooldown, 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::escrow_limits_change_timelock_active());
        if (0x1::option::is_some<u64>(&v0.daily_limit)) {
            arg0.processor_daily_limit = *0x1::option::borrow<u64>(&v0.daily_limit);
        };
        if (0x1::option::is_some<u64>(&v0.max_per_tx)) {
            arg0.processor_max_per_tx = *0x1::option::borrow<u64>(&v0.max_per_tx);
        };
        if (0x1::option::is_some<u64>(&v0.processor_cooldown)) {
            arg0.processor_cooldown = *0x1::option::borrow<u64>(&v0.processor_cooldown);
        };
        if (0x1::option::is_some<u64>(&v0.emergency_cooldown)) {
            arg0.gov_cooldowns.emergency_cooldown = *0x1::option::borrow<u64>(&v0.emergency_cooldown);
        };
        let v1 = CcamLimitsUpdatedEvent{ccam_id: 0x2::object::id<CrossChainAssetManager<T0>>(arg0)};
        0x2::event::emit<CcamLimitsUpdatedEvent>(v1);
    }

    public fun accept_manager<T0>(arg0: &mut CrossChainAssetManager<T0>, arg1: &CcamManagerCap, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert_manager<T0>(arg0, arg1, arg3);
        assert!(0x1::option::is_some<PendingRole>(&arg0.pending_manager), 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::escrow_no_pending_manager_change());
        let v0 = 0x1::option::extract<PendingRole>(&mut arg0.pending_manager);
        assert!(now_secs(arg2) >= v0.proposed_at + arg0.gov_cooldowns.manager_change_cooldown, 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::escrow_manager_change_cooldown_not_expired());
        arg0.manager = v0.value;
        let v1 = CcamManagerUpdatedEvent{
            ccam_id     : 0x2::object::id<CrossChainAssetManager<T0>>(arg0),
            old_manager : arg0.manager,
            new_manager : v0.value,
        };
        0x2::event::emit<CcamManagerUpdatedEvent>(v1);
    }

    public fun accept_processor<T0>(arg0: &mut CrossChainAssetManager<T0>, arg1: &CcamManagerCap, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert_manager<T0>(arg0, arg1, arg3);
        assert!(0x1::option::is_some<PendingRole>(&arg0.pending_processor), 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::escrow_no_pending_processor_change());
        let v0 = 0x1::option::extract<PendingRole>(&mut arg0.pending_processor);
        assert!(now_secs(arg2) >= v0.proposed_at + arg0.gov_cooldowns.processor_change_cooldown, 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::escrow_processor_change_cooldown_not_expired());
        arg0.processor = v0.value;
        let v1 = CcamProcessorUpdatedEvent{
            ccam_id       : 0x2::object::id<CrossChainAssetManager<T0>>(arg0),
            old_processor : arg0.processor,
            new_processor : v0.value,
        };
        0x2::event::emit<CcamProcessorUpdatedEvent>(v1);
    }

    public fun accept_withdraw_destination<T0>(arg0: &mut CrossChainAssetManager<T0>, arg1: &CcamManagerCap, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert_manager<T0>(arg0, arg1, arg3);
        assert!(0x1::option::is_some<PendingAddress>(&arg0.pending_withdraw_destination), 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::escrow_no_pending_withdraw_destination());
        let v0 = 0x1::option::extract<PendingAddress>(&mut arg0.pending_withdraw_destination);
        assert!(now_secs(arg2) >= v0.proposed_at + arg0.gov_cooldowns.config_change_cooldown, 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::escrow_withdraw_destination_delay_not_elapsed());
        if (0x2::table::contains<address, bool>(&arg0.withdraw_destinations, v0.value)) {
            *0x2::table::borrow_mut<address, bool>(&mut arg0.withdraw_destinations, v0.value) = true;
        } else {
            0x2::table::add<address, bool>(&mut arg0.withdraw_destinations, v0.value, true);
        };
        let v1 = CcamWithdrawDestinationAddedEvent{
            ccam_id     : 0x2::object::id<CrossChainAssetManager<T0>>(arg0),
            destination : v0.value,
        };
        0x2::event::emit<CcamWithdrawDestinationAddedEvent>(v1);
    }

    public fun assert_adapter_active<T0>(arg0: &CrossChainAssetManager<T0>, arg1: address) {
        assert!(0x2::table::contains<address, AdapterBinding>(&arg0.adapters, arg1), 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::escrow_adapter_not_allowed());
        let v0 = 0x2::table::borrow<address, AdapterBinding>(&arg0.adapters, arg1);
        assert!(v0.status == 1, 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::escrow_adapter_not_active());
        assert!(v0.active, 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::escrow_adapter_disabled());
    }

    fun assert_admin<T0>(arg0: &CrossChainAssetManager<T0>, arg1: &CcamAdminCap) {
        assert!(arg1.ccam_id == 0x2::object::id<CrossChainAssetManager<T0>>(arg0), 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::unauthorized());
        assert_version<T0>(arg0);
    }

    fun assert_manager<T0>(arg0: &CrossChainAssetManager<T0>, arg1: &CcamManagerCap, arg2: &0x2::tx_context::TxContext) {
        assert!(arg1.ccam_id == 0x2::object::id<CrossChainAssetManager<T0>>(arg0), 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::unauthorized());
        assert_version<T0>(arg0);
        assert!(0x2::tx_context::sender(arg2) == arg0.manager, 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::unauthorized());
    }

    fun assert_processor<T0>(arg0: &CrossChainAssetManager<T0>, arg1: &CcamProcessorCap, arg2: &0x2::tx_context::TxContext) {
        assert!(arg1.ccam_id == 0x2::object::id<CrossChainAssetManager<T0>>(arg0), 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::unauthorized());
        assert_version<T0>(arg0);
        assert!(0x2::tx_context::sender(arg2) == arg0.processor, 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::unauthorized());
    }

    public fun assert_processor_cap<T0>(arg0: &CrossChainAssetManager<T0>, arg1: &CcamProcessorCap, arg2: &0x2::tx_context::TxContext) {
        assert_processor<T0>(arg0, arg1, arg2);
    }

    fun assert_version<T0>(arg0: &CrossChainAssetManager<T0>) {
        assert!(arg0.version == 1, 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::wrong_version());
    }

    public fun cancel_limits<T0>(arg0: &mut CrossChainAssetManager<T0>, arg1: &CcamManagerCap, arg2: &0x2::tx_context::TxContext) {
        assert_manager<T0>(arg0, arg1, arg2);
        assert!(0x1::option::is_some<PendingLimits>(&arg0.pending_limits), 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::escrow_no_pending_limits_change());
        0x1::option::extract<PendingLimits>(&mut arg0.pending_limits);
        let v0 = CcamLimitsChangeCancelledEvent{ccam_id: 0x2::object::id<CrossChainAssetManager<T0>>(arg0)};
        0x2::event::emit<CcamLimitsChangeCancelledEvent>(v0);
    }

    public fun cancel_manager<T0>(arg0: &mut CrossChainAssetManager<T0>, arg1: &CcamManagerCap, arg2: &0x2::tx_context::TxContext) {
        assert_manager<T0>(arg0, arg1, arg2);
        assert!(0x1::option::is_some<PendingRole>(&arg0.pending_manager), 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::escrow_no_pending_manager_change());
        let v0 = 0x1::option::extract<PendingRole>(&mut arg0.pending_manager);
        let v1 = CcamManagerChangeCancelledEvent{
            ccam_id               : 0x2::object::id<CrossChainAssetManager<T0>>(arg0),
            cancelled_new_manager : v0.value,
        };
        0x2::event::emit<CcamManagerChangeCancelledEvent>(v1);
    }

    public fun cancel_processor<T0>(arg0: &mut CrossChainAssetManager<T0>, arg1: &CcamManagerCap, arg2: &0x2::tx_context::TxContext) {
        assert_manager<T0>(arg0, arg1, arg2);
        assert!(0x1::option::is_some<PendingRole>(&arg0.pending_processor), 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::escrow_no_pending_processor_change());
        let v0 = 0x1::option::extract<PendingRole>(&mut arg0.pending_processor);
        let v1 = CcamProcessorChangeCancelledEvent{
            ccam_id                 : 0x2::object::id<CrossChainAssetManager<T0>>(arg0),
            cancelled_new_processor : v0.value,
        };
        0x2::event::emit<CcamProcessorChangeCancelledEvent>(v1);
    }

    public fun cancel_withdraw_destination<T0>(arg0: &mut CrossChainAssetManager<T0>, arg1: &CcamManagerCap, arg2: &0x2::tx_context::TxContext) {
        assert_manager<T0>(arg0, arg1, arg2);
        assert!(0x1::option::is_some<PendingAddress>(&arg0.pending_withdraw_destination), 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::escrow_no_pending_withdraw_destination());
        let v0 = 0x1::option::extract<PendingAddress>(&mut arg0.pending_withdraw_destination);
        let v1 = CcamWithdrawDestinationCancelledEvent{
            ccam_id     : 0x2::object::id<CrossChainAssetManager<T0>>(arg0),
            destination : v0.value,
        };
        0x2::event::emit<CcamWithdrawDestinationCancelledEvent>(v1);
    }

    fun check_processor_limits<T0>(arg0: &CrossChainAssetManager<T0>, arg1: u64, arg2: u64) {
        assert!(arg1 <= arg0.processor_max_per_tx, 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::escrow_amount_exceeds_max());
        assert!(arg0.processor_daily_used + arg1 <= arg0.processor_daily_limit, 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::escrow_daily_limit_exceeded());
        if (arg0.last_operation_time > 0 && arg0.processor_cooldown > 0) {
            assert!(arg2 >= arg0.last_operation_time + arg0.processor_cooldown, 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::escrow_cooldown_not_elapsed());
        };
    }

    public fun create_ccam<T0>(arg0: 0x2::object::ID, arg1: address, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (CcamAdminCap, CcamManagerCap, CcamProcessorCap) {
        assert!(arg1 != @0x0 && arg2 != @0x0, 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::invalid_argument());
        let v0 = CcamCooldowns{
            emergency_cooldown        : 60,
            manager_change_cooldown   : 60,
            processor_change_cooldown : 60,
            limits_cooldown           : 60,
            adapter_change_cooldown   : 60,
            config_change_cooldown    : 60,
        };
        let v1 = CrossChainAssetManager<T0>{
            id                             : 0x2::object::new(arg4),
            version                        : 1,
            proxy_id                       : arg0,
            underlying                     : 0x2::balance::zero<T0>(),
            manager                        : arg1,
            processor                      : arg2,
            paused                         : false,
            force_paused                   : false,
            paused_at                      : 0,
            processor_cooldown             : 60,
            processor_max_per_tx           : 100000000000,
            processor_daily_limit          : 1000000000000,
            processor_daily_used           : 0,
            last_daily_reset               : now_secs(arg3),
            last_operation_time            : 0,
            gov_cooldowns                  : v0,
            token_messenger_minter         : 0x1::option::none<address>(),
            pending_token_messenger_minter : 0x1::option::none<PendingAddress>(),
            aggregator                     : 0x1::option::none<address>(),
            pending_aggregator             : 0x1::option::none<PendingAddress>(),
            pending_manager                : 0x1::option::none<PendingRole>(),
            pending_processor              : 0x1::option::none<PendingRole>(),
            pending_limits                 : 0x1::option::none<PendingLimits>(),
            pending_withdraw_destination   : 0x1::option::none<PendingAddress>(),
            allowed_tokens                 : 0x2::table::new<0x1::type_name::TypeName, bool>(arg4),
            cctp_destinations              : 0x2::table::new<u32, CctpDestination>(arg4),
            adapters                       : 0x2::table::new<address, AdapterBinding>(arg4),
            withdraw_destinations          : 0x2::table::new<address, bool>(arg4),
            adapter_count                  : 0,
        };
        let v2 = 0x2::object::id<CrossChainAssetManager<T0>>(&v1);
        0x2::transfer::share_object<CrossChainAssetManager<T0>>(v1);
        let v3 = CcamInitializedEvent{
            ccam_id   : v2,
            proxy_id  : arg0,
            manager   : arg1,
            processor : arg2,
        };
        0x2::event::emit<CcamInitializedEvent>(v3);
        let v4 = CcamAdminCap{
            id      : 0x2::object::new(arg4),
            ccam_id : v2,
        };
        let v5 = CcamManagerCap{
            id      : 0x2::object::new(arg4),
            ccam_id : v2,
        };
        let v6 = CcamProcessorCap{
            id      : 0x2::object::new(arg4),
            ccam_id : v2,
        };
        (v4, v5, v6)
    }

    public fun current_module_version() : u64 {
        1
    }

    public fun deposit<T0>(arg0: &mut CrossChainAssetManager<T0>, arg1: &CcamProcessorCap, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::tx_context::TxContext) {
        assert_processor<T0>(arg0, arg1, arg3);
        require_not_paused<T0>(arg0);
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(v0 > 0, 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::escrow_zero_amount());
        0x2::balance::join<T0>(&mut arg0.underlying, 0x2::coin::into_balance<T0>(arg2));
        let v1 = CcamFundsDepositedEvent{
            ccam_id : 0x2::object::id<CrossChainAssetManager<T0>>(arg0),
            amount  : v0,
        };
        0x2::event::emit<CcamFundsDepositedEvent>(v1);
    }

    public fun deposit_from_proxy<T0>(arg0: &mut CrossChainAssetManager<T0>, arg1: &CcamProcessorCap, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::tx_context::TxContext) {
        deposit<T0>(arg0, arg1, arg2, arg3);
    }

    public fun disable_adapter<T0>(arg0: &mut CrossChainAssetManager<T0>, arg1: &CcamManagerCap, arg2: address, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert_manager<T0>(arg0, arg1, arg4);
        assert!(0x2::table::contains<address, AdapterBinding>(&arg0.adapters, arg2), 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::escrow_adapter_not_allowed());
        let v0 = 0x2::table::borrow_mut<address, AdapterBinding>(&mut arg0.adapters, arg2);
        assert!(v0.status == 1, 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::escrow_adapter_not_active());
        v0.active = false;
        v0.updated_at = now_secs(arg3);
        let v1 = CcamAdapterDisabledEvent{
            ccam_id : 0x2::object::id<CrossChainAssetManager<T0>>(arg0),
            adapter : arg2,
        };
        0x2::event::emit<CcamAdapterDisabledEvent>(v1);
    }

    public fun emergency_sweep<T0>(arg0: &mut CrossChainAssetManager<T0>, arg1: &CcamManagerCap, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_manager<T0>(arg0, arg1, arg4);
        assert!(arg0.paused, 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::escrow_not_paused());
        assert!(now_secs(arg3) >= arg0.paused_at + arg0.gov_cooldowns.emergency_cooldown, 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::escrow_emergency_cooldown_not_met());
        let v0 = 0x2::balance::value<T0>(&arg0.underlying);
        let v1 = if (arg2 == 0) {
            v0
        } else {
            arg2
        };
        assert!(v0 >= v1, 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::escrow_insufficient_funds());
        let v2 = CcamEmergencySweepEvent{
            ccam_id : 0x2::object::id<CrossChainAssetManager<T0>>(arg0),
            amount  : v1,
        };
        0x2::event::emit<CcamEmergencySweepEvent>(v2);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.underlying, v1), arg4)
    }

    public fun enable_adapter<T0>(arg0: &mut CrossChainAssetManager<T0>, arg1: &CcamManagerCap, arg2: address, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert_manager<T0>(arg0, arg1, arg4);
        assert!(0x2::table::contains<address, AdapterBinding>(&arg0.adapters, arg2), 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::escrow_adapter_not_allowed());
        let v0 = 0x2::table::borrow_mut<address, AdapterBinding>(&mut arg0.adapters, arg2);
        assert!(v0.status == 1, 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::escrow_adapter_not_active());
        v0.active = true;
        v0.updated_at = now_secs(arg3);
        let v1 = CcamAdapterEnabledEvent{
            ccam_id : 0x2::object::id<CrossChainAssetManager<T0>>(arg0),
            adapter : arg2,
        };
        0x2::event::emit<CcamAdapterEnabledEvent>(v1);
    }

    public fun execute_swap<T0, T1>(arg0: &mut CrossChainAssetManager<T0>, arg1: &CcamProcessorCap, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_processor<T0>(arg0, arg1, arg5);
        require_not_paused<T0>(arg0);
        assert!(arg2 > 0, 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::escrow_zero_amount());
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = 0x1::type_name::with_defining_ids<T1>();
        assert!(v0 != v1, 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::escrow_swap_tokens_must_differ());
        assert!(0x1::option::is_some<address>(&arg0.aggregator), 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::escrow_aggregator_not_set());
        assert!(token_allowed<T0>(arg0, v0), 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::escrow_token_not_allowed());
        assert!(token_allowed<T0>(arg0, v1), 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::escrow_token_not_allowed());
        let v2 = now_secs(arg4);
        maybe_reset_daily<T0>(arg0, v2);
        check_processor_limits<T0>(arg0, arg2, v2);
        assert!(0x2::balance::value<T0>(&arg0.underlying) >= arg2, 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::escrow_insufficient_funds());
        record_processor_operation<T0>(arg0, arg2, v2);
        let v3 = CcamSwapExecutedEvent{
            ccam_id        : 0x2::object::id<CrossChainAssetManager<T0>>(arg0),
            token_in       : v0,
            token_out      : v1,
            amount_in      : arg2,
            amount_out_min : arg3,
        };
        0x2::event::emit<CcamSwapExecutedEvent>(v3);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.underlying, arg2), arg5)
    }

    public fun force_pause<T0>(arg0: &mut CrossChainAssetManager<T0>, arg1: &CcamAdminCap, arg2: &0x2::clock::Clock) {
        assert_admin<T0>(arg0, arg1);
        arg0.paused = true;
        arg0.force_paused = true;
        arg0.paused_at = now_secs(arg2);
        let v0 = CcamForcePausedEvent{ccam_id: 0x2::object::id<CrossChainAssetManager<T0>>(arg0)};
        0x2::event::emit<CcamForcePausedEvent>(v0);
    }

    public fun force_unpause<T0>(arg0: &mut CrossChainAssetManager<T0>, arg1: &CcamAdminCap) {
        assert_admin<T0>(arg0, arg1);
        arg0.paused = false;
        arg0.force_paused = false;
        arg0.paused_at = 0;
        let v0 = CcamForceUnpausedEvent{ccam_id: 0x2::object::id<CrossChainAssetManager<T0>>(arg0)};
        0x2::event::emit<CcamForceUnpausedEvent>(v0);
    }

    public fun get_adapter_count<T0>(arg0: &CrossChainAssetManager<T0>) : u64 {
        arg0.adapter_count
    }

    public fun get_aggregator<T0>(arg0: &CrossChainAssetManager<T0>) : 0x1::option::Option<address> {
        arg0.aggregator
    }

    public fun get_balance<T0>(arg0: &CrossChainAssetManager<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.underlying)
    }

    public fun get_cctp_messenger<T0>(arg0: &CrossChainAssetManager<T0>) : 0x1::option::Option<address> {
        arg0.token_messenger_minter
    }

    public fun get_manager<T0>(arg0: &CrossChainAssetManager<T0>) : address {
        arg0.manager
    }

    public fun get_module_version<T0>(arg0: &CrossChainAssetManager<T0>) : u64 {
        arg0.version
    }

    public fun get_processor<T0>(arg0: &CrossChainAssetManager<T0>) : address {
        arg0.processor
    }

    public fun get_processor_daily_used<T0>(arg0: &CrossChainAssetManager<T0>) : u64 {
        arg0.processor_daily_used
    }

    public fun get_processor_limits<T0>(arg0: &CrossChainAssetManager<T0>) : (u64, u64, u64) {
        (arg0.processor_max_per_tx, arg0.processor_daily_limit, arg0.processor_cooldown)
    }

    public fun get_proxy_id<T0>(arg0: &CrossChainAssetManager<T0>) : 0x2::object::ID {
        arg0.proxy_id
    }

    public fun is_adapter_active<T0>(arg0: &CrossChainAssetManager<T0>, arg1: address) : bool {
        0x2::table::contains<address, AdapterBinding>(&arg0.adapters, arg1) && 0x2::table::borrow<address, AdapterBinding>(&arg0.adapters, arg1).active
    }

    public fun is_cctp_destination_active<T0>(arg0: &CrossChainAssetManager<T0>, arg1: u32) : bool {
        0x2::table::contains<u32, CctpDestination>(&arg0.cctp_destinations, arg1) && 0x2::table::borrow<u32, CctpDestination>(&arg0.cctp_destinations, arg1).active
    }

    public fun is_force_paused<T0>(arg0: &CrossChainAssetManager<T0>) : bool {
        arg0.force_paused
    }

    public fun is_paused<T0>(arg0: &CrossChainAssetManager<T0>) : bool {
        arg0.paused
    }

    public fun is_token_allowed<T0, T1>(arg0: &CrossChainAssetManager<T1>) : bool {
        token_allowed<T1>(arg0, 0x1::type_name::with_defining_ids<T0>())
    }

    public fun is_withdraw_destination_allowed<T0>(arg0: &CrossChainAssetManager<T0>, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.withdraw_destinations, arg1) && *0x2::table::borrow<address, bool>(&arg0.withdraw_destinations, arg1)
    }

    fun maybe_reset_daily<T0>(arg0: &mut CrossChainAssetManager<T0>, arg1: u64) {
        if (arg1 >= arg0.last_daily_reset + 86400) {
            arg0.processor_daily_used = 0;
            arg0.last_daily_reset = arg1;
        };
    }

    public fun migrate<T0>(arg0: &mut CrossChainAssetManager<T0>, arg1: &CcamAdminCap) {
        assert!(arg1.ccam_id == 0x2::object::id<CrossChainAssetManager<T0>>(arg0), 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::unauthorized());
        assert!(arg0.version < 1, 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::not_upgrade());
        arg0.version = 1;
    }

    fun now_secs(arg0: &0x2::clock::Clock) : u64 {
        0x2::clock::timestamp_ms(arg0) / 1000
    }

    public fun pause<T0>(arg0: &mut CrossChainAssetManager<T0>, arg1: &CcamManagerCap, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert_manager<T0>(arg0, arg1, arg3);
        assert!(!arg0.paused, 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::escrow_already_paused());
        arg0.paused = true;
        arg0.paused_at = now_secs(arg2);
        let v0 = CcamPausedEvent{ccam_id: 0x2::object::id<CrossChainAssetManager<T0>>(arg0)};
        0x2::event::emit<CcamPausedEvent>(v0);
    }

    public fun propose_adapter<T0>(arg0: &mut CrossChainAssetManager<T0>, arg1: &CcamManagerCap, arg2: address, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert_manager<T0>(arg0, arg1, arg4);
        if (0x2::table::contains<address, AdapterBinding>(&arg0.adapters, arg2)) {
            let v0 = 0x2::table::borrow<address, AdapterBinding>(&arg0.adapters, arg2);
            assert!(v0.status != 1, 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::escrow_adapter_already_allowed());
            assert!(v0.status != 0, 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::escrow_adapter_already_pending());
        };
        let v1 = now_secs(arg3);
        let v2 = AdapterBinding{
            adapter    : arg2,
            active     : false,
            status     : 0,
            created_at : v1,
            updated_at : v1,
        };
        if (0x2::table::contains<address, AdapterBinding>(&arg0.adapters, arg2)) {
            *0x2::table::borrow_mut<address, AdapterBinding>(&mut arg0.adapters, arg2) = v2;
        } else {
            0x2::table::add<address, AdapterBinding>(&mut arg0.adapters, arg2, v2);
        };
        let v3 = CcamAdapterProposedEvent{
            ccam_id        : 0x2::object::id<CrossChainAssetManager<T0>>(arg0),
            adapter        : arg2,
            effective_time : v1 + arg0.gov_cooldowns.adapter_change_cooldown,
        };
        0x2::event::emit<CcamAdapterProposedEvent>(v3);
    }

    public fun propose_aggregator<T0>(arg0: &mut CrossChainAssetManager<T0>, arg1: &CcamManagerCap, arg2: address, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert_manager<T0>(arg0, arg1, arg4);
        assert!(0x1::option::is_none<PendingAddress>(&arg0.pending_aggregator), 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::escrow_config_unchanged());
        let v0 = now_secs(arg3);
        let v1 = PendingAddress{
            value       : arg2,
            proposed_at : v0,
        };
        arg0.pending_aggregator = 0x1::option::some<PendingAddress>(v1);
        let v2 = CcamAggregatorProposedEvent{
            ccam_id        : 0x2::object::id<CrossChainAssetManager<T0>>(arg0),
            new_address    : arg2,
            effective_time : v0 + arg0.gov_cooldowns.config_change_cooldown,
        };
        0x2::event::emit<CcamAggregatorProposedEvent>(v2);
    }

    public fun propose_cctp_messenger<T0>(arg0: &mut CrossChainAssetManager<T0>, arg1: &CcamManagerCap, arg2: address, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert_manager<T0>(arg0, arg1, arg4);
        assert!(0x1::option::is_none<PendingAddress>(&arg0.pending_token_messenger_minter), 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::escrow_config_unchanged());
        let v0 = now_secs(arg3);
        let v1 = PendingAddress{
            value       : arg2,
            proposed_at : v0,
        };
        arg0.pending_token_messenger_minter = 0x1::option::some<PendingAddress>(v1);
        let v2 = CcamCctpMessengerProposedEvent{
            ccam_id        : 0x2::object::id<CrossChainAssetManager<T0>>(arg0),
            new_address    : arg2,
            effective_time : v0 + arg0.gov_cooldowns.config_change_cooldown,
        };
        0x2::event::emit<CcamCctpMessengerProposedEvent>(v2);
    }

    public fun propose_limits<T0>(arg0: &mut CrossChainAssetManager<T0>, arg1: &CcamManagerCap, arg2: 0x1::option::Option<u64>, arg3: 0x1::option::Option<u64>, arg4: 0x1::option::Option<u64>, arg5: 0x1::option::Option<u64>, arg6: &0x2::clock::Clock, arg7: &0x2::tx_context::TxContext) {
        assert_manager<T0>(arg0, arg1, arg7);
        let v0 = if (0x1::option::is_some<u64>(&arg2)) {
            true
        } else if (0x1::option::is_some<u64>(&arg3)) {
            true
        } else if (0x1::option::is_some<u64>(&arg4)) {
            true
        } else {
            0x1::option::is_some<u64>(&arg5)
        };
        assert!(v0, 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::escrow_no_limits_changes());
        if (0x1::option::is_some<u64>(&arg2)) {
            assert!(*0x1::option::borrow<u64>(&arg2) <= 1000000000000000000, 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::escrow_invalid_limit());
        };
        if (0x1::option::is_some<u64>(&arg3)) {
            assert!(*0x1::option::borrow<u64>(&arg3) <= 1000000000000000000, 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::escrow_invalid_limit());
        };
        if (0x1::option::is_some<u64>(&arg4)) {
            validate_cooldown(*0x1::option::borrow<u64>(&arg4));
        };
        if (0x1::option::is_some<u64>(&arg5)) {
            validate_cooldown(*0x1::option::borrow<u64>(&arg5));
        };
        let v1 = now_secs(arg6);
        let v2 = PendingLimits{
            daily_limit        : arg2,
            max_per_tx         : arg3,
            processor_cooldown : arg4,
            emergency_cooldown : arg5,
            proposed_at        : v1,
        };
        arg0.pending_limits = 0x1::option::some<PendingLimits>(v2);
        let v3 = CcamLimitsChangePendingEvent{
            ccam_id        : 0x2::object::id<CrossChainAssetManager<T0>>(arg0),
            effective_time : v1 + arg0.gov_cooldowns.limits_cooldown,
        };
        0x2::event::emit<CcamLimitsChangePendingEvent>(v3);
    }

    public fun propose_manager<T0>(arg0: &mut CrossChainAssetManager<T0>, arg1: &CcamManagerCap, arg2: address, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert_manager<T0>(arg0, arg1, arg4);
        assert!(arg2 != @0x0, 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::invalid_argument());
        assert!(arg2 != arg0.manager, 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::escrow_invalid_manager());
        let v0 = now_secs(arg3);
        let v1 = PendingRole{
            value       : arg2,
            proposed_at : v0,
        };
        arg0.pending_manager = 0x1::option::some<PendingRole>(v1);
        let v2 = CcamManagerChangePendingEvent{
            ccam_id        : 0x2::object::id<CrossChainAssetManager<T0>>(arg0),
            new_manager    : arg2,
            effective_time : v0 + arg0.gov_cooldowns.manager_change_cooldown,
        };
        0x2::event::emit<CcamManagerChangePendingEvent>(v2);
    }

    public fun propose_processor<T0>(arg0: &mut CrossChainAssetManager<T0>, arg1: &CcamManagerCap, arg2: address, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert_manager<T0>(arg0, arg1, arg4);
        assert!(arg2 != @0x0, 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::invalid_argument());
        assert!(arg2 != arg0.processor, 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::escrow_invalid_processor());
        let v0 = now_secs(arg3);
        let v1 = PendingRole{
            value       : arg2,
            proposed_at : v0,
        };
        arg0.pending_processor = 0x1::option::some<PendingRole>(v1);
        let v2 = CcamProcessorChangePendingEvent{
            ccam_id        : 0x2::object::id<CrossChainAssetManager<T0>>(arg0),
            new_processor  : arg2,
            effective_time : v0 + arg0.gov_cooldowns.processor_change_cooldown,
        };
        0x2::event::emit<CcamProcessorChangePendingEvent>(v2);
    }

    public fun propose_withdraw_destination<T0>(arg0: &mut CrossChainAssetManager<T0>, arg1: &CcamManagerCap, arg2: address, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert_manager<T0>(arg0, arg1, arg4);
        let v0 = 0x2::table::contains<address, bool>(&arg0.withdraw_destinations, arg2) && *0x2::table::borrow<address, bool>(&arg0.withdraw_destinations, arg2);
        assert!(!v0, 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::escrow_withdraw_destination_already_allowed());
        assert!(0x1::option::is_none<PendingAddress>(&arg0.pending_withdraw_destination), 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::escrow_config_unchanged());
        let v1 = now_secs(arg3);
        let v2 = PendingAddress{
            value       : arg2,
            proposed_at : v1,
        };
        arg0.pending_withdraw_destination = 0x1::option::some<PendingAddress>(v2);
        let v3 = CcamWithdrawDestinationProposedEvent{
            ccam_id        : 0x2::object::id<CrossChainAssetManager<T0>>(arg0),
            destination    : arg2,
            effective_time : v1 + arg0.gov_cooldowns.config_change_cooldown,
        };
        0x2::event::emit<CcamWithdrawDestinationProposedEvent>(v3);
    }

    public fun push_to_adapter<T0>(arg0: &mut CrossChainAssetManager<T0>, arg1: &CcamProcessorCap, arg2: address, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_processor<T0>(arg0, arg1, arg5);
        require_not_paused<T0>(arg0);
        assert!(0x2::table::contains<address, AdapterBinding>(&arg0.adapters, arg2), 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::escrow_adapter_not_allowed());
        let v0 = 0x2::table::borrow<address, AdapterBinding>(&arg0.adapters, arg2);
        assert!(v0.status == 1, 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::escrow_adapter_not_active());
        assert!(v0.active, 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::escrow_adapter_disabled());
        assert!(arg3 > 0, 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::escrow_zero_amount());
        let v1 = now_secs(arg4);
        maybe_reset_daily<T0>(arg0, v1);
        check_processor_limits<T0>(arg0, arg3, v1);
        assert!(0x2::balance::value<T0>(&arg0.underlying) >= arg3, 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::escrow_insufficient_funds());
        record_processor_operation<T0>(arg0, arg3, v1);
        let v2 = CcamAdapterPushedEvent{
            ccam_id : 0x2::object::id<CrossChainAssetManager<T0>>(arg0),
            adapter : arg2,
            amount  : arg3,
        };
        0x2::event::emit<CcamAdapterPushedEvent>(v2);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.underlying, arg3), arg5)
    }

    fun record_processor_operation<T0>(arg0: &mut CrossChainAssetManager<T0>, arg1: u64, arg2: u64) {
        arg0.processor_daily_used = arg0.processor_daily_used + arg1;
        arg0.last_operation_time = arg2;
    }

    public fun remove_adapter<T0>(arg0: &mut CrossChainAssetManager<T0>, arg1: &CcamManagerCap, arg2: address, arg3: &0x2::tx_context::TxContext) {
        assert_manager<T0>(arg0, arg1, arg3);
        assert!(0x2::table::contains<address, AdapterBinding>(&arg0.adapters, arg2), 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::escrow_adapter_not_allowed());
        let v0 = 0x2::table::remove<address, AdapterBinding>(&mut arg0.adapters, arg2);
        if (v0.status == 1 && arg0.adapter_count > 0) {
            arg0.adapter_count = arg0.adapter_count - 1;
        };
        let v1 = CcamAdapterRemovedEvent{
            ccam_id : 0x2::object::id<CrossChainAssetManager<T0>>(arg0),
            adapter : arg2,
        };
        0x2::event::emit<CcamAdapterRemovedEvent>(v1);
    }

    public fun remove_withdraw_destination<T0>(arg0: &mut CrossChainAssetManager<T0>, arg1: &CcamManagerCap, arg2: address, arg3: &0x2::tx_context::TxContext) {
        assert_manager<T0>(arg0, arg1, arg3);
        assert!(0x2::table::contains<address, bool>(&arg0.withdraw_destinations, arg2) && *0x2::table::borrow<address, bool>(&arg0.withdraw_destinations, arg2), 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::escrow_withdraw_destination_not_allowed());
        *0x2::table::borrow_mut<address, bool>(&mut arg0.withdraw_destinations, arg2) = false;
        let v0 = CcamWithdrawDestinationRemovedEvent{
            ccam_id     : 0x2::object::id<CrossChainAssetManager<T0>>(arg0),
            destination : arg2,
        };
        0x2::event::emit<CcamWithdrawDestinationRemovedEvent>(v0);
    }

    fun require_not_force_paused<T0>(arg0: &CrossChainAssetManager<T0>) {
        assert!(!arg0.force_paused, 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::escrow_force_paused_by_admin());
    }

    fun require_not_paused<T0>(arg0: &CrossChainAssetManager<T0>) {
        assert!(!arg0.paused, 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::vault_paused());
    }

    public fun return_to_proxy<T0>(arg0: &mut CrossChainAssetManager<T0>, arg1: &CcamProcessorCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_processor<T0>(arg0, arg1, arg3);
        return_to_proxy_internal<T0>(arg0, arg2, arg3)
    }

    fun return_to_proxy_internal<T0>(arg0: &mut CrossChainAssetManager<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg1 > 0, 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::escrow_zero_amount());
        assert!(0x2::balance::value<T0>(&arg0.underlying) >= arg1, 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::escrow_insufficient_funds());
        let v0 = CcamFundsReturnedToProxyEvent{
            ccam_id : 0x2::object::id<CrossChainAssetManager<T0>>(arg0),
            amount  : arg1,
        };
        0x2::event::emit<CcamFundsReturnedToProxyEvent>(v0);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.underlying, arg1), arg2)
    }

    public fun return_to_proxy_manager<T0>(arg0: &mut CrossChainAssetManager<T0>, arg1: &CcamManagerCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_manager<T0>(arg0, arg1, arg3);
        return_to_proxy_internal<T0>(arg0, arg2, arg3)
    }

    public fun return_to_proxy_processor<T0>(arg0: &mut CrossChainAssetManager<T0>, arg1: &CcamProcessorCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        return_to_proxy<T0>(arg0, arg1, arg2, arg3)
    }

    public fun send_via_cctp<T0>(arg0: &mut CrossChainAssetManager<T0>, arg1: &CcamProcessorCap, arg2: u64, arg3: u32, arg4: address, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_processor<T0>(arg0, arg1, arg6);
        require_not_paused<T0>(arg0);
        assert!(arg2 > 0, 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::escrow_zero_amount());
        assert!(arg4 != @0x0, 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::escrow_invalid_mint_recipient());
        assert!(0x1::option::is_some<address>(&arg0.token_messenger_minter), 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::escrow_cctp_messenger_not_set());
        assert!(0x2::table::contains<u32, CctpDestination>(&arg0.cctp_destinations, arg3), 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::escrow_cctp_destination_not_allowed());
        let v0 = 0x2::table::borrow<u32, CctpDestination>(&arg0.cctp_destinations, arg3);
        assert!(v0.active && v0.recipient == arg4, 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::escrow_cctp_destination_not_allowed());
        let v1 = now_secs(arg5);
        maybe_reset_daily<T0>(arg0, v1);
        check_processor_limits<T0>(arg0, arg2, v1);
        assert!(0x2::balance::value<T0>(&arg0.underlying) >= arg2, 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::escrow_insufficient_funds());
        record_processor_operation<T0>(arg0, arg2, v1);
        let v2 = CcamCctpSendInitiatedEvent{
            ccam_id            : 0x2::object::id<CrossChainAssetManager<T0>>(arg0),
            amount             : arg2,
            destination_domain : arg3,
            mint_recipient     : arg4,
        };
        0x2::event::emit<CcamCctpSendInitiatedEvent>(v2);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.underlying, arg2), arg6)
    }

    public fun set_allowed_token<T0, T1>(arg0: &mut CrossChainAssetManager<T1>, arg1: &CcamManagerCap, arg2: bool, arg3: &0x2::tx_context::TxContext) {
        assert_manager<T1>(arg0, arg1, arg3);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (0x2::table::contains<0x1::type_name::TypeName, bool>(&arg0.allowed_tokens, v0)) {
            *0x2::table::borrow_mut<0x1::type_name::TypeName, bool>(&mut arg0.allowed_tokens, v0) = arg2;
        } else {
            0x2::table::add<0x1::type_name::TypeName, bool>(&mut arg0.allowed_tokens, v0, arg2);
        };
        let v1 = CcamAllowedTokenUpdatedEvent{
            ccam_id : 0x2::object::id<CrossChainAssetManager<T1>>(arg0),
            token   : v0,
            allowed : arg2,
        };
        0x2::event::emit<CcamAllowedTokenUpdatedEvent>(v1);
    }

    public fun set_cctp_destination<T0>(arg0: &mut CrossChainAssetManager<T0>, arg1: &CcamManagerCap, arg2: u32, arg3: address, arg4: bool, arg5: &0x2::tx_context::TxContext) {
        assert_manager<T0>(arg0, arg1, arg5);
        assert!(arg3 != @0x0, 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::escrow_invalid_mint_recipient());
        if (arg4) {
            let v0 = CctpDestination{
                domain    : arg2,
                recipient : arg3,
                active    : true,
            };
            if (0x2::table::contains<u32, CctpDestination>(&arg0.cctp_destinations, arg2)) {
                *0x2::table::borrow_mut<u32, CctpDestination>(&mut arg0.cctp_destinations, arg2) = v0;
            } else {
                0x2::table::add<u32, CctpDestination>(&mut arg0.cctp_destinations, arg2, v0);
            };
        } else if (0x2::table::contains<u32, CctpDestination>(&arg0.cctp_destinations, arg2)) {
            0x2::table::remove<u32, CctpDestination>(&mut arg0.cctp_destinations, arg2);
        };
        let v1 = CcamCctpDestinationUpdatedEvent{
            ccam_id   : 0x2::object::id<CrossChainAssetManager<T0>>(arg0),
            domain    : arg2,
            recipient : arg3,
            allowed   : arg4,
        };
        0x2::event::emit<CcamCctpDestinationUpdatedEvent>(v1);
    }

    fun token_allowed<T0>(arg0: &CrossChainAssetManager<T0>, arg1: 0x1::type_name::TypeName) : bool {
        0x2::table::contains<0x1::type_name::TypeName, bool>(&arg0.allowed_tokens, arg1) && *0x2::table::borrow<0x1::type_name::TypeName, bool>(&arg0.allowed_tokens, arg1)
    }

    public fun unpause<T0>(arg0: &mut CrossChainAssetManager<T0>, arg1: &CcamManagerCap, arg2: &0x2::tx_context::TxContext) {
        assert_manager<T0>(arg0, arg1, arg2);
        assert!(arg0.paused, 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::escrow_not_paused());
        assert!(!arg0.force_paused, 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::escrow_force_paused_by_admin());
        arg0.paused = false;
        arg0.paused_at = 0;
        let v0 = CcamUnpausedEvent{ccam_id: 0x2::object::id<CrossChainAssetManager<T0>>(arg0)};
        0x2::event::emit<CcamUnpausedEvent>(v0);
    }

    fun validate_cooldown(arg0: u64) {
        assert!(arg0 >= 60 && arg0 <= 604800, 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::escrow_invalid_cooldown());
    }

    public fun withdraw<T0>(arg0: &mut CrossChainAssetManager<T0>, arg1: &CcamManagerCap, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert_manager<T0>(arg0, arg1, arg4);
        require_not_force_paused<T0>(arg0);
        assert!(arg2 > 0, 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::escrow_zero_amount());
        assert!(0x2::table::contains<address, bool>(&arg0.withdraw_destinations, arg3) && *0x2::table::borrow<address, bool>(&arg0.withdraw_destinations, arg3), 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::escrow_withdraw_destination_not_allowed());
        assert!(0x2::balance::value<T0>(&arg0.underlying) >= arg2, 0xecc7a8cf07c20142899b5f3e668dd50a73e474bfa5962e81a48e07b523905e79::stoken_errors::escrow_insufficient_funds());
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.underlying, arg2), arg4), arg3);
        let v0 = CcamFundsWithdrawnEvent{
            ccam_id : 0x2::object::id<CrossChainAssetManager<T0>>(arg0),
            amount  : arg2,
            to      : arg3,
        };
        0x2::event::emit<CcamFundsWithdrawnEvent>(v0);
    }

    // decompiled from Move bytecode v7
}

