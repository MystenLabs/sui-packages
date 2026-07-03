module 0xaba12ff07741a77fa678d8a37cb0dffc8b148217fadc214747346800fe68a3b1::stoken_proxy {
    struct TargetConfig has copy, drop, store {
        target_custody: address,
        active: bool,
        created_at: u64,
        updated_at: u64,
    }

    struct ProxyPendingLimits has copy, drop, store {
        processor_daily_limit: 0x1::option::Option<u64>,
        processor_max_per_tx: 0x1::option::Option<u64>,
        manager_daily_limit: 0x1::option::Option<u64>,
        manager_max_per_tx: 0x1::option::Option<u64>,
        processor_cooldown: 0x1::option::Option<u64>,
        emergency_cooldown: 0x1::option::Option<u64>,
        proposed_at: u64,
    }

    struct ProxyAdminCap has store, key {
        id: 0x2::object::UID,
        proxy_id: 0x2::object::ID,
    }

    struct ProxyManagerCap has store, key {
        id: 0x2::object::UID,
        proxy_id: 0x2::object::ID,
    }

    struct ProxyProcessorCap has store, key {
        id: 0x2::object::UID,
        proxy_id: 0x2::object::ID,
    }

    struct ProxyAssetManager<phantom T0> has key {
        id: 0x2::object::UID,
        version: u64,
        vault_id: 0x2::object::ID,
        underlying: 0x2::balance::Balance<T0>,
        paused: bool,
        force_paused: bool,
        paused_at: u64,
        processor_cooldown: u64,
        processor_max_per_tx: u64,
        processor_daily_limit: u64,
        processor_daily_used: u64,
        manager_max_per_tx: u64,
        manager_daily_limit: u64,
        manager_daily_used: u64,
        last_daily_reset: u64,
        last_operation_time: u64,
        emergency_cooldown: u64,
        manager_change_cooldown: u64,
        processor_change_cooldown: u64,
        limits_cooldown: u64,
        manager: address,
        processor: address,
        pending_manager: 0x1::option::Option<address>,
        pending_manager_ts: u64,
        pending_processor: 0x1::option::Option<address>,
        pending_processor_ts: u64,
        pending_limits: 0x1::option::Option<ProxyPendingLimits>,
        targets: 0x2::table::Table<address, TargetConfig>,
    }

    public fun accept_limits<T0>(arg0: &mut ProxyAssetManager<T0>, arg1: &ProxyManagerCap, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(arg1.proxy_id == 0x2::object::id<ProxyAssetManager<T0>>(arg0), 0xaba12ff07741a77fa678d8a37cb0dffc8b148217fadc214747346800fe68a3b1::stoken_errors::unauthorized());
        assert_version<T0>(arg0);
        assert!(0x2::tx_context::sender(arg3) == arg0.manager, 0xaba12ff07741a77fa678d8a37cb0dffc8b148217fadc214747346800fe68a3b1::stoken_errors::unauthorized());
        assert!(0x1::option::is_some<ProxyPendingLimits>(&arg0.pending_limits), 0xaba12ff07741a77fa678d8a37cb0dffc8b148217fadc214747346800fe68a3b1::stoken_errors::proxy_no_pending_limits_change());
        let v0 = 0x1::option::extract<ProxyPendingLimits>(&mut arg0.pending_limits);
        assert!(0x2::clock::timestamp_ms(arg2) / 1000 >= v0.proposed_at + arg0.limits_cooldown, 0xaba12ff07741a77fa678d8a37cb0dffc8b148217fadc214747346800fe68a3b1::stoken_errors::proxy_limits_change_timelock_active());
        if (0x1::option::is_some<u64>(&v0.processor_daily_limit)) {
            arg0.processor_daily_limit = *0x1::option::borrow<u64>(&v0.processor_daily_limit);
        };
        if (0x1::option::is_some<u64>(&v0.processor_max_per_tx)) {
            arg0.processor_max_per_tx = *0x1::option::borrow<u64>(&v0.processor_max_per_tx);
        };
        if (0x1::option::is_some<u64>(&v0.manager_daily_limit)) {
            arg0.manager_daily_limit = *0x1::option::borrow<u64>(&v0.manager_daily_limit);
        };
        if (0x1::option::is_some<u64>(&v0.manager_max_per_tx)) {
            arg0.manager_max_per_tx = *0x1::option::borrow<u64>(&v0.manager_max_per_tx);
        };
        if (0x1::option::is_some<u64>(&v0.processor_cooldown)) {
            arg0.processor_cooldown = *0x1::option::borrow<u64>(&v0.processor_cooldown);
        };
        if (0x1::option::is_some<u64>(&v0.emergency_cooldown)) {
            arg0.emergency_cooldown = *0x1::option::borrow<u64>(&v0.emergency_cooldown);
        };
        0xaba12ff07741a77fa678d8a37cb0dffc8b148217fadc214747346800fe68a3b1::stoken_events::emit_proxy_limits_updated(0x2::object::id<ProxyAssetManager<T0>>(arg0), 0x2::clock::timestamp_ms(arg2));
    }

    public fun accept_manager_change<T0>(arg0: &mut ProxyAssetManager<T0>, arg1: &ProxyManagerCap, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(arg1.proxy_id == 0x2::object::id<ProxyAssetManager<T0>>(arg0), 0xaba12ff07741a77fa678d8a37cb0dffc8b148217fadc214747346800fe68a3b1::stoken_errors::unauthorized());
        assert_version<T0>(arg0);
        assert!(0x2::tx_context::sender(arg3) == arg0.manager, 0xaba12ff07741a77fa678d8a37cb0dffc8b148217fadc214747346800fe68a3b1::stoken_errors::unauthorized());
        assert!(0x1::option::is_some<address>(&arg0.pending_manager), 0xaba12ff07741a77fa678d8a37cb0dffc8b148217fadc214747346800fe68a3b1::stoken_errors::proxy_no_pending_manager_change());
        assert!(0x2::clock::timestamp_ms(arg2) / 1000 >= arg0.pending_manager_ts + arg0.manager_change_cooldown, 0xaba12ff07741a77fa678d8a37cb0dffc8b148217fadc214747346800fe68a3b1::stoken_errors::proxy_cooldown_not_elapsed());
        arg0.manager = 0x1::option::extract<address>(&mut arg0.pending_manager);
        arg0.pending_manager_ts = 0;
        0xaba12ff07741a77fa678d8a37cb0dffc8b148217fadc214747346800fe68a3b1::stoken_events::emit_proxy_manager_updated(0x2::object::id<ProxyAssetManager<T0>>(arg0), arg0.manager, 0x2::clock::timestamp_ms(arg2));
    }

    public fun accept_processor_change<T0>(arg0: &mut ProxyAssetManager<T0>, arg1: &ProxyManagerCap, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(arg1.proxy_id == 0x2::object::id<ProxyAssetManager<T0>>(arg0), 0xaba12ff07741a77fa678d8a37cb0dffc8b148217fadc214747346800fe68a3b1::stoken_errors::unauthorized());
        assert_version<T0>(arg0);
        assert!(0x2::tx_context::sender(arg3) == arg0.manager, 0xaba12ff07741a77fa678d8a37cb0dffc8b148217fadc214747346800fe68a3b1::stoken_errors::unauthorized());
        assert!(0x1::option::is_some<address>(&arg0.pending_processor), 0xaba12ff07741a77fa678d8a37cb0dffc8b148217fadc214747346800fe68a3b1::stoken_errors::proxy_no_pending_processor_change());
        assert!(0x2::clock::timestamp_ms(arg2) / 1000 >= arg0.pending_processor_ts + arg0.processor_change_cooldown, 0xaba12ff07741a77fa678d8a37cb0dffc8b148217fadc214747346800fe68a3b1::stoken_errors::proxy_cooldown_not_elapsed());
        arg0.processor = 0x1::option::extract<address>(&mut arg0.pending_processor);
        arg0.pending_processor_ts = 0;
        0xaba12ff07741a77fa678d8a37cb0dffc8b148217fadc214747346800fe68a3b1::stoken_events::emit_proxy_processor_updated(0x2::object::id<ProxyAssetManager<T0>>(arg0), arg0.processor, 0x2::clock::timestamp_ms(arg2));
    }

    public(friend) fun accept_underlying<T0>(arg0: &mut ProxyAssetManager<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x2::balance::join<T0>(&mut arg0.underlying, 0x2::coin::into_balance<T0>(arg1));
    }

    public fun activate_target<T0>(arg0: &mut ProxyAssetManager<T0>, arg1: &ProxyManagerCap, arg2: address, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(arg1.proxy_id == 0x2::object::id<ProxyAssetManager<T0>>(arg0), 0xaba12ff07741a77fa678d8a37cb0dffc8b148217fadc214747346800fe68a3b1::stoken_errors::unauthorized());
        assert_version<T0>(arg0);
        assert!(0x2::tx_context::sender(arg4) == arg0.manager, 0xaba12ff07741a77fa678d8a37cb0dffc8b148217fadc214747346800fe68a3b1::stoken_errors::unauthorized());
        assert!(0x2::table::contains<address, TargetConfig>(&arg0.targets, arg2), 0xaba12ff07741a77fa678d8a37cb0dffc8b148217fadc214747346800fe68a3b1::stoken_errors::proxy_target_not_found());
        let v0 = 0x2::table::borrow_mut<address, TargetConfig>(&mut arg0.targets, arg2);
        assert!(!v0.active, 0xaba12ff07741a77fa678d8a37cb0dffc8b148217fadc214747346800fe68a3b1::stoken_errors::invalid_argument());
        v0.active = true;
        v0.updated_at = 0x2::clock::timestamp_ms(arg3) / 1000;
        0xaba12ff07741a77fa678d8a37cb0dffc8b148217fadc214747346800fe68a3b1::stoken_events::emit_proxy_target_updated(0x2::object::id<ProxyAssetManager<T0>>(arg0), arg2, true, 0x2::clock::timestamp_ms(arg3));
    }

    public fun add_target<T0>(arg0: &mut ProxyAssetManager<T0>, arg1: &ProxyManagerCap, arg2: address, arg3: address, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert!(arg1.proxy_id == 0x2::object::id<ProxyAssetManager<T0>>(arg0), 0xaba12ff07741a77fa678d8a37cb0dffc8b148217fadc214747346800fe68a3b1::stoken_errors::unauthorized());
        assert_version<T0>(arg0);
        assert!(0x2::tx_context::sender(arg5) == arg0.manager, 0xaba12ff07741a77fa678d8a37cb0dffc8b148217fadc214747346800fe68a3b1::stoken_errors::unauthorized());
        assert!(!0x2::table::contains<address, TargetConfig>(&arg0.targets, arg2), 0xaba12ff07741a77fa678d8a37cb0dffc8b148217fadc214747346800fe68a3b1::stoken_errors::proxy_target_already_exists());
        0x2::table::add<address, TargetConfig>(&mut arg0.targets, arg2, new_target_config(arg3, 0x2::clock::timestamp_ms(arg4) / 1000));
        0xaba12ff07741a77fa678d8a37cb0dffc8b148217fadc214747346800fe68a3b1::stoken_events::emit_proxy_target_updated(0x2::object::id<ProxyAssetManager<T0>>(arg0), arg2, true, 0x2::clock::timestamp_ms(arg4));
    }

    fun assert_version<T0>(arg0: &ProxyAssetManager<T0>) {
        assert!(arg0.version == 1, 0xaba12ff07741a77fa678d8a37cb0dffc8b148217fadc214747346800fe68a3b1::stoken_errors::wrong_version());
    }

    public fun cancel_limits<T0>(arg0: &mut ProxyAssetManager<T0>, arg1: &ProxyManagerCap, arg2: &0x2::tx_context::TxContext) {
        assert!(arg1.proxy_id == 0x2::object::id<ProxyAssetManager<T0>>(arg0), 0xaba12ff07741a77fa678d8a37cb0dffc8b148217fadc214747346800fe68a3b1::stoken_errors::unauthorized());
        assert_version<T0>(arg0);
        assert!(0x2::tx_context::sender(arg2) == arg0.manager, 0xaba12ff07741a77fa678d8a37cb0dffc8b148217fadc214747346800fe68a3b1::stoken_errors::unauthorized());
        arg0.pending_limits = 0x1::option::none<ProxyPendingLimits>();
    }

    public fun cancel_manager_change<T0>(arg0: &mut ProxyAssetManager<T0>, arg1: &ProxyManagerCap, arg2: &0x2::tx_context::TxContext) {
        assert!(arg1.proxy_id == 0x2::object::id<ProxyAssetManager<T0>>(arg0), 0xaba12ff07741a77fa678d8a37cb0dffc8b148217fadc214747346800fe68a3b1::stoken_errors::unauthorized());
        assert_version<T0>(arg0);
        assert!(0x2::tx_context::sender(arg2) == arg0.manager, 0xaba12ff07741a77fa678d8a37cb0dffc8b148217fadc214747346800fe68a3b1::stoken_errors::unauthorized());
        arg0.pending_manager = 0x1::option::none<address>();
        arg0.pending_manager_ts = 0;
    }

    public fun cancel_processor_change<T0>(arg0: &mut ProxyAssetManager<T0>, arg1: &ProxyManagerCap, arg2: &0x2::tx_context::TxContext) {
        assert!(arg1.proxy_id == 0x2::object::id<ProxyAssetManager<T0>>(arg0), 0xaba12ff07741a77fa678d8a37cb0dffc8b148217fadc214747346800fe68a3b1::stoken_errors::unauthorized());
        assert_version<T0>(arg0);
        assert!(0x2::tx_context::sender(arg2) == arg0.manager, 0xaba12ff07741a77fa678d8a37cb0dffc8b148217fadc214747346800fe68a3b1::stoken_errors::unauthorized());
        arg0.pending_processor = 0x1::option::none<address>();
        arg0.pending_processor_ts = 0;
    }

    public fun create_proxy<T0>(arg0: 0x2::object::ID, arg1: address, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (ProxyAdminCap, ProxyManagerCap, ProxyProcessorCap) {
        assert!(arg1 != @0x0, 0xaba12ff07741a77fa678d8a37cb0dffc8b148217fadc214747346800fe68a3b1::stoken_errors::invalid_argument());
        assert!(arg2 != @0x0, 0xaba12ff07741a77fa678d8a37cb0dffc8b148217fadc214747346800fe68a3b1::stoken_errors::invalid_argument());
        let v0 = ProxyAssetManager<T0>{
            id                        : 0x2::object::new(arg4),
            version                   : 1,
            vault_id                  : arg0,
            underlying                : 0x2::balance::zero<T0>(),
            paused                    : false,
            force_paused              : false,
            paused_at                 : 0,
            processor_cooldown        : 60,
            processor_max_per_tx      : 100000000000,
            processor_daily_limit     : 1000000000000,
            processor_daily_used      : 0,
            manager_max_per_tx        : 1000000000000,
            manager_daily_limit       : 10000000000000,
            manager_daily_used        : 0,
            last_daily_reset          : 0x2::clock::timestamp_ms(arg3) / 1000,
            last_operation_time       : 0,
            emergency_cooldown        : 60,
            manager_change_cooldown   : 60,
            processor_change_cooldown : 60,
            limits_cooldown           : 60,
            manager                   : arg1,
            processor                 : arg2,
            pending_manager           : 0x1::option::none<address>(),
            pending_manager_ts        : 0,
            pending_processor         : 0x1::option::none<address>(),
            pending_processor_ts      : 0,
            pending_limits            : 0x1::option::none<ProxyPendingLimits>(),
            targets                   : 0x2::table::new<address, TargetConfig>(arg4),
        };
        let v1 = 0x2::object::id<ProxyAssetManager<T0>>(&v0);
        0xaba12ff07741a77fa678d8a37cb0dffc8b148217fadc214747346800fe68a3b1::stoken_events::emit_proxy_initialized(v1, arg0, 0x2::clock::timestamp_ms(arg3));
        0x2::transfer::share_object<ProxyAssetManager<T0>>(v0);
        let v2 = ProxyAdminCap{
            id       : 0x2::object::new(arg4),
            proxy_id : v1,
        };
        let v3 = ProxyManagerCap{
            id       : 0x2::object::new(arg4),
            proxy_id : v1,
        };
        let v4 = ProxyProcessorCap{
            id       : 0x2::object::new(arg4),
            proxy_id : v1,
        };
        (v2, v3, v4)
    }

    public fun current_module_version() : u64 {
        1
    }

    public fun deactivate_target<T0>(arg0: &mut ProxyAssetManager<T0>, arg1: &ProxyManagerCap, arg2: address, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(arg1.proxy_id == 0x2::object::id<ProxyAssetManager<T0>>(arg0), 0xaba12ff07741a77fa678d8a37cb0dffc8b148217fadc214747346800fe68a3b1::stoken_errors::unauthorized());
        assert_version<T0>(arg0);
        assert!(0x2::tx_context::sender(arg4) == arg0.manager, 0xaba12ff07741a77fa678d8a37cb0dffc8b148217fadc214747346800fe68a3b1::stoken_errors::unauthorized());
        assert!(0x2::table::contains<address, TargetConfig>(&arg0.targets, arg2), 0xaba12ff07741a77fa678d8a37cb0dffc8b148217fadc214747346800fe68a3b1::stoken_errors::proxy_target_not_found());
        let v0 = 0x2::table::borrow_mut<address, TargetConfig>(&mut arg0.targets, arg2);
        assert!(v0.active, 0xaba12ff07741a77fa678d8a37cb0dffc8b148217fadc214747346800fe68a3b1::stoken_errors::proxy_target_inactive());
        v0.active = false;
        v0.updated_at = 0x2::clock::timestamp_ms(arg3) / 1000;
        0xaba12ff07741a77fa678d8a37cb0dffc8b148217fadc214747346800fe68a3b1::stoken_events::emit_proxy_target_updated(0x2::object::id<ProxyAssetManager<T0>>(arg0), arg2, false, 0x2::clock::timestamp_ms(arg3));
    }

    public fun deposit_funds<T0>(arg0: &mut ProxyAssetManager<T0>, arg1: &ProxyManagerCap, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::tx_context::TxContext) {
        assert!(arg1.proxy_id == 0x2::object::id<ProxyAssetManager<T0>>(arg0), 0xaba12ff07741a77fa678d8a37cb0dffc8b148217fadc214747346800fe68a3b1::stoken_errors::unauthorized());
        assert_version<T0>(arg0);
        assert!(0x2::tx_context::sender(arg3) == arg0.manager, 0xaba12ff07741a77fa678d8a37cb0dffc8b148217fadc214747346800fe68a3b1::stoken_errors::unauthorized());
        0x2::balance::join<T0>(&mut arg0.underlying, 0x2::coin::into_balance<T0>(arg2));
    }

    public fun emergency_sweep<T0>(arg0: &mut ProxyAssetManager<T0>, arg1: &ProxyManagerCap, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg1.proxy_id == 0x2::object::id<ProxyAssetManager<T0>>(arg0), 0xaba12ff07741a77fa678d8a37cb0dffc8b148217fadc214747346800fe68a3b1::stoken_errors::unauthorized());
        assert_version<T0>(arg0);
        assert!(0x2::tx_context::sender(arg4) == arg0.manager, 0xaba12ff07741a77fa678d8a37cb0dffc8b148217fadc214747346800fe68a3b1::stoken_errors::unauthorized());
        assert!(arg0.paused, 0xaba12ff07741a77fa678d8a37cb0dffc8b148217fadc214747346800fe68a3b1::stoken_errors::proxy_not_paused());
        assert!(0x2::clock::timestamp_ms(arg3) / 1000 >= arg0.paused_at + arg0.emergency_cooldown, 0xaba12ff07741a77fa678d8a37cb0dffc8b148217fadc214747346800fe68a3b1::stoken_errors::proxy_cooldown_not_elapsed());
        let v0 = 0x2::balance::value<T0>(&arg0.underlying);
        let v1 = if (arg2 == 0) {
            v0
        } else {
            arg2
        };
        assert!(v0 >= v1, 0xaba12ff07741a77fa678d8a37cb0dffc8b148217fadc214747346800fe68a3b1::stoken_errors::insufficient_balance());
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.underlying, v1), arg4)
    }

    public fun force_pause<T0>(arg0: &mut ProxyAssetManager<T0>, arg1: &ProxyAdminCap, arg2: &0x2::clock::Clock) {
        assert!(arg1.proxy_id == 0x2::object::id<ProxyAssetManager<T0>>(arg0), 0xaba12ff07741a77fa678d8a37cb0dffc8b148217fadc214747346800fe68a3b1::stoken_errors::unauthorized());
        assert_version<T0>(arg0);
        arg0.paused = true;
        arg0.force_paused = true;
        arg0.paused_at = 0x2::clock::timestamp_ms(arg2) / 1000;
        0xaba12ff07741a77fa678d8a37cb0dffc8b148217fadc214747346800fe68a3b1::stoken_events::emit_proxy_paused(0x2::object::id<ProxyAssetManager<T0>>(arg0), 0x2::clock::timestamp_ms(arg2));
    }

    public fun force_unpause<T0>(arg0: &mut ProxyAssetManager<T0>, arg1: &ProxyAdminCap, arg2: &0x2::clock::Clock) {
        assert!(arg1.proxy_id == 0x2::object::id<ProxyAssetManager<T0>>(arg0), 0xaba12ff07741a77fa678d8a37cb0dffc8b148217fadc214747346800fe68a3b1::stoken_errors::unauthorized());
        assert_version<T0>(arg0);
        arg0.force_paused = false;
        arg0.paused = false;
        0xaba12ff07741a77fa678d8a37cb0dffc8b148217fadc214747346800fe68a3b1::stoken_events::emit_proxy_unpaused(0x2::object::id<ProxyAssetManager<T0>>(arg0), 0x2::clock::timestamp_ms(arg2));
    }

    public fun forward_funds<T0>(arg0: &mut ProxyAssetManager<T0>, arg1: &ProxyProcessorCap, arg2: address, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        forward_funds_processor<T0>(arg0, arg1, arg2, arg3, arg4, arg5)
    }

    public fun forward_funds_manager<T0>(arg0: &mut ProxyAssetManager<T0>, arg1: &ProxyManagerCap, arg2: address, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg1.proxy_id == 0x2::object::id<ProxyAssetManager<T0>>(arg0), 0xaba12ff07741a77fa678d8a37cb0dffc8b148217fadc214747346800fe68a3b1::stoken_errors::unauthorized());
        assert_version<T0>(arg0);
        assert!(0x2::tx_context::sender(arg5) == arg0.manager, 0xaba12ff07741a77fa678d8a37cb0dffc8b148217fadc214747346800fe68a3b1::stoken_errors::unauthorized());
        assert!(!arg0.paused, 0xaba12ff07741a77fa678d8a37cb0dffc8b148217fadc214747346800fe68a3b1::stoken_errors::proxy_paused());
        assert!(arg3 > 0, 0xaba12ff07741a77fa678d8a37cb0dffc8b148217fadc214747346800fe68a3b1::stoken_errors::invalid_amount());
        assert!(arg3 <= arg0.manager_max_per_tx, 0xaba12ff07741a77fa678d8a37cb0dffc8b148217fadc214747346800fe68a3b1::stoken_errors::proxy_amount_exceeds_max());
        maybe_reset_daily<T0>(arg0, 0x2::clock::timestamp_ms(arg4) / 1000);
        assert!(arg0.manager_daily_used + arg3 <= arg0.manager_daily_limit, 0xaba12ff07741a77fa678d8a37cb0dffc8b148217fadc214747346800fe68a3b1::stoken_errors::proxy_daily_limit_exceeded());
        assert!(0x2::table::contains<address, TargetConfig>(&arg0.targets, arg2), 0xaba12ff07741a77fa678d8a37cb0dffc8b148217fadc214747346800fe68a3b1::stoken_errors::proxy_target_not_found());
        assert!(0x2::table::borrow<address, TargetConfig>(&arg0.targets, arg2).active, 0xaba12ff07741a77fa678d8a37cb0dffc8b148217fadc214747346800fe68a3b1::stoken_errors::proxy_target_inactive());
        arg0.manager_daily_used = arg0.manager_daily_used + arg3;
        0xaba12ff07741a77fa678d8a37cb0dffc8b148217fadc214747346800fe68a3b1::stoken_events::emit_proxy_funds_forwarded(0x2::object::id<ProxyAssetManager<T0>>(arg0), arg2, arg3, 0x2::clock::timestamp_ms(arg4));
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.underlying, arg3), arg5)
    }

    public fun forward_funds_processor<T0>(arg0: &mut ProxyAssetManager<T0>, arg1: &ProxyProcessorCap, arg2: address, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg1.proxy_id == 0x2::object::id<ProxyAssetManager<T0>>(arg0), 0xaba12ff07741a77fa678d8a37cb0dffc8b148217fadc214747346800fe68a3b1::stoken_errors::unauthorized());
        assert_version<T0>(arg0);
        assert!(0x2::tx_context::sender(arg5) == arg0.processor, 0xaba12ff07741a77fa678d8a37cb0dffc8b148217fadc214747346800fe68a3b1::stoken_errors::unauthorized());
        assert!(!arg0.paused, 0xaba12ff07741a77fa678d8a37cb0dffc8b148217fadc214747346800fe68a3b1::stoken_errors::proxy_paused());
        assert!(arg3 > 0, 0xaba12ff07741a77fa678d8a37cb0dffc8b148217fadc214747346800fe68a3b1::stoken_errors::invalid_amount());
        assert!(arg3 <= arg0.processor_max_per_tx, 0xaba12ff07741a77fa678d8a37cb0dffc8b148217fadc214747346800fe68a3b1::stoken_errors::proxy_amount_exceeds_max());
        let v0 = 0x2::clock::timestamp_ms(arg4) / 1000;
        maybe_reset_daily<T0>(arg0, v0);
        if (arg0.last_operation_time > 0 && arg0.processor_cooldown > 0) {
            assert!(v0 >= arg0.last_operation_time + arg0.processor_cooldown, 0xaba12ff07741a77fa678d8a37cb0dffc8b148217fadc214747346800fe68a3b1::stoken_errors::proxy_cooldown_not_elapsed());
        };
        assert!(arg0.processor_daily_used + arg3 <= arg0.processor_daily_limit, 0xaba12ff07741a77fa678d8a37cb0dffc8b148217fadc214747346800fe68a3b1::stoken_errors::proxy_daily_limit_exceeded());
        assert!(0x2::table::contains<address, TargetConfig>(&arg0.targets, arg2), 0xaba12ff07741a77fa678d8a37cb0dffc8b148217fadc214747346800fe68a3b1::stoken_errors::proxy_target_not_found());
        assert!(0x2::table::borrow<address, TargetConfig>(&arg0.targets, arg2).active, 0xaba12ff07741a77fa678d8a37cb0dffc8b148217fadc214747346800fe68a3b1::stoken_errors::proxy_target_inactive());
        arg0.processor_daily_used = arg0.processor_daily_used + arg3;
        arg0.last_operation_time = v0;
        0xaba12ff07741a77fa678d8a37cb0dffc8b148217fadc214747346800fe68a3b1::stoken_events::emit_proxy_funds_forwarded(0x2::object::id<ProxyAssetManager<T0>>(arg0), arg2, arg3, 0x2::clock::timestamp_ms(arg4));
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.underlying, arg3), arg5)
    }

    public fun forward_to_ccam<T0>(arg0: &mut ProxyAssetManager<T0>, arg1: &ProxyProcessorCap, arg2: &mut 0xaba12ff07741a77fa678d8a37cb0dffc8b148217fadc214747346800fe68a3b1::stoken_cross_chain_asset_manager::CrossChainAssetManager<T0>, arg3: &0xaba12ff07741a77fa678d8a37cb0dffc8b148217fadc214747346800fe68a3b1::stoken_cross_chain_asset_manager::CcamProcessorCap, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0xaba12ff07741a77fa678d8a37cb0dffc8b148217fadc214747346800fe68a3b1::stoken_cross_chain_asset_manager::get_proxy_id<T0>(arg2) == 0x2::object::id<ProxyAssetManager<T0>>(arg0), 0xaba12ff07741a77fa678d8a37cb0dffc8b148217fadc214747346800fe68a3b1::stoken_errors::unauthorized());
        let v0 = 0x2::object::id<0xaba12ff07741a77fa678d8a37cb0dffc8b148217fadc214747346800fe68a3b1::stoken_cross_chain_asset_manager::CrossChainAssetManager<T0>>(arg2);
        let v1 = forward_funds<T0>(arg0, arg1, 0x2::object::id_to_address(&v0), arg4, arg5, arg6);
        0xaba12ff07741a77fa678d8a37cb0dffc8b148217fadc214747346800fe68a3b1::stoken_cross_chain_asset_manager::deposit<T0>(arg2, arg3, v1, arg6);
    }

    public fun get_balance<T0>(arg0: &ProxyAssetManager<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.underlying)
    }

    public fun get_manager<T0>(arg0: &ProxyAssetManager<T0>) : address {
        arg0.manager
    }

    public fun get_manager_cap_proxy_id(arg0: &ProxyManagerCap) : 0x2::object::ID {
        arg0.proxy_id
    }

    public fun get_manager_daily_used<T0>(arg0: &ProxyAssetManager<T0>) : u64 {
        arg0.manager_daily_used
    }

    public fun get_module_version<T0>(arg0: &ProxyAssetManager<T0>) : u64 {
        arg0.version
    }

    public fun get_processor<T0>(arg0: &ProxyAssetManager<T0>) : address {
        arg0.processor
    }

    public fun get_processor_cap_proxy_id(arg0: &ProxyProcessorCap) : 0x2::object::ID {
        arg0.proxy_id
    }

    public fun get_processor_daily_used<T0>(arg0: &ProxyAssetManager<T0>) : u64 {
        arg0.processor_daily_used
    }

    public fun get_vault_id<T0>(arg0: &ProxyAssetManager<T0>) : 0x2::object::ID {
        arg0.vault_id
    }

    public fun is_force_paused<T0>(arg0: &ProxyAssetManager<T0>) : bool {
        arg0.force_paused
    }

    public fun is_paused<T0>(arg0: &ProxyAssetManager<T0>) : bool {
        arg0.paused
    }

    fun maybe_reset_daily<T0>(arg0: &mut ProxyAssetManager<T0>, arg1: u64) {
        if (arg1 >= arg0.last_daily_reset + 86400) {
            arg0.processor_daily_used = 0;
            arg0.manager_daily_used = 0;
            arg0.last_daily_reset = arg1;
        };
    }

    public fun migrate<T0>(arg0: &mut ProxyAssetManager<T0>, arg1: &ProxyAdminCap) {
        assert!(arg1.proxy_id == 0x2::object::id<ProxyAssetManager<T0>>(arg0), 0xaba12ff07741a77fa678d8a37cb0dffc8b148217fadc214747346800fe68a3b1::stoken_errors::unauthorized());
        assert!(arg0.version < 1, 0xaba12ff07741a77fa678d8a37cb0dffc8b148217fadc214747346800fe68a3b1::stoken_errors::not_upgrade());
        arg0.version = 1;
    }

    fun new_target_config(arg0: address, arg1: u64) : TargetConfig {
        TargetConfig{
            target_custody : arg0,
            active         : true,
            created_at     : arg1,
            updated_at     : arg1,
        }
    }

    public fun pause<T0>(arg0: &mut ProxyAssetManager<T0>, arg1: &ProxyManagerCap, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(arg1.proxy_id == 0x2::object::id<ProxyAssetManager<T0>>(arg0), 0xaba12ff07741a77fa678d8a37cb0dffc8b148217fadc214747346800fe68a3b1::stoken_errors::unauthorized());
        assert_version<T0>(arg0);
        assert!(0x2::tx_context::sender(arg3) == arg0.manager, 0xaba12ff07741a77fa678d8a37cb0dffc8b148217fadc214747346800fe68a3b1::stoken_errors::unauthorized());
        assert!(!arg0.paused, 0xaba12ff07741a77fa678d8a37cb0dffc8b148217fadc214747346800fe68a3b1::stoken_errors::proxy_already_paused());
        arg0.paused = true;
        arg0.paused_at = 0x2::clock::timestamp_ms(arg2) / 1000;
        0xaba12ff07741a77fa678d8a37cb0dffc8b148217fadc214747346800fe68a3b1::stoken_events::emit_proxy_paused(0x2::object::id<ProxyAssetManager<T0>>(arg0), 0x2::clock::timestamp_ms(arg2));
    }

    public fun propose_limits<T0>(arg0: &mut ProxyAssetManager<T0>, arg1: &ProxyManagerCap, arg2: 0x1::option::Option<u64>, arg3: 0x1::option::Option<u64>, arg4: 0x1::option::Option<u64>, arg5: 0x1::option::Option<u64>, arg6: 0x1::option::Option<u64>, arg7: 0x1::option::Option<u64>, arg8: &0x2::clock::Clock, arg9: &0x2::tx_context::TxContext) {
        assert!(arg1.proxy_id == 0x2::object::id<ProxyAssetManager<T0>>(arg0), 0xaba12ff07741a77fa678d8a37cb0dffc8b148217fadc214747346800fe68a3b1::stoken_errors::unauthorized());
        assert_version<T0>(arg0);
        assert!(0x2::tx_context::sender(arg9) == arg0.manager, 0xaba12ff07741a77fa678d8a37cb0dffc8b148217fadc214747346800fe68a3b1::stoken_errors::unauthorized());
        let v0 = if (0x1::option::is_some<u64>(&arg2)) {
            true
        } else if (0x1::option::is_some<u64>(&arg3)) {
            true
        } else if (0x1::option::is_some<u64>(&arg4)) {
            true
        } else if (0x1::option::is_some<u64>(&arg5)) {
            true
        } else if (0x1::option::is_some<u64>(&arg6)) {
            true
        } else {
            0x1::option::is_some<u64>(&arg7)
        };
        assert!(v0, 0xaba12ff07741a77fa678d8a37cb0dffc8b148217fadc214747346800fe68a3b1::stoken_errors::proxy_no_limits_changes());
        let v1 = if (0x1::option::is_some<u64>(&arg2)) {
            *0x1::option::borrow<u64>(&arg2)
        } else {
            arg0.processor_daily_limit
        };
        let v2 = if (0x1::option::is_some<u64>(&arg3)) {
            *0x1::option::borrow<u64>(&arg3)
        } else {
            arg0.processor_max_per_tx
        };
        let v3 = if (0x1::option::is_some<u64>(&arg4)) {
            *0x1::option::borrow<u64>(&arg4)
        } else {
            arg0.manager_daily_limit
        };
        let v4 = if (0x1::option::is_some<u64>(&arg5)) {
            *0x1::option::borrow<u64>(&arg5)
        } else {
            arg0.manager_max_per_tx
        };
        assert!(v1 >= v2, 0xaba12ff07741a77fa678d8a37cb0dffc8b148217fadc214747346800fe68a3b1::stoken_errors::invalid_limit());
        assert!(v3 >= v4, 0xaba12ff07741a77fa678d8a37cb0dffc8b148217fadc214747346800fe68a3b1::stoken_errors::invalid_limit());
        if (0x1::option::is_some<u64>(&arg6)) {
            let v5 = *0x1::option::borrow<u64>(&arg6);
            assert!(v5 >= 60 && v5 <= 604800, 0xaba12ff07741a77fa678d8a37cb0dffc8b148217fadc214747346800fe68a3b1::stoken_errors::invalid_limit());
        };
        if (0x1::option::is_some<u64>(&arg7)) {
            let v6 = *0x1::option::borrow<u64>(&arg7);
            assert!(v6 >= 60 && v6 <= 604800, 0xaba12ff07741a77fa678d8a37cb0dffc8b148217fadc214747346800fe68a3b1::stoken_errors::invalid_limit());
        };
        let v7 = ProxyPendingLimits{
            processor_daily_limit : arg2,
            processor_max_per_tx  : arg3,
            manager_daily_limit   : arg4,
            manager_max_per_tx    : arg5,
            processor_cooldown    : arg6,
            emergency_cooldown    : arg7,
            proposed_at           : 0x2::clock::timestamp_ms(arg8) / 1000,
        };
        arg0.pending_limits = 0x1::option::some<ProxyPendingLimits>(v7);
        0xaba12ff07741a77fa678d8a37cb0dffc8b148217fadc214747346800fe68a3b1::stoken_events::emit_proxy_limits_change_pending(0x2::object::id<ProxyAssetManager<T0>>(arg0), 0x2::clock::timestamp_ms(arg8) / 1000 + arg0.limits_cooldown, 0x2::clock::timestamp_ms(arg8));
    }

    public fun propose_manager_change<T0>(arg0: &mut ProxyAssetManager<T0>, arg1: &ProxyManagerCap, arg2: address, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(arg1.proxy_id == 0x2::object::id<ProxyAssetManager<T0>>(arg0), 0xaba12ff07741a77fa678d8a37cb0dffc8b148217fadc214747346800fe68a3b1::stoken_errors::unauthorized());
        assert_version<T0>(arg0);
        assert!(0x2::tx_context::sender(arg4) == arg0.manager, 0xaba12ff07741a77fa678d8a37cb0dffc8b148217fadc214747346800fe68a3b1::stoken_errors::unauthorized());
        assert!(arg2 != arg0.manager, 0xaba12ff07741a77fa678d8a37cb0dffc8b148217fadc214747346800fe68a3b1::stoken_errors::invalid_argument());
        arg0.pending_manager = 0x1::option::some<address>(arg2);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        arg0.pending_manager_ts = v0 / 1000;
        0xaba12ff07741a77fa678d8a37cb0dffc8b148217fadc214747346800fe68a3b1::stoken_events::emit_proxy_manager_change_pending(0x2::object::id<ProxyAssetManager<T0>>(arg0), arg2, v0 / 1000 + arg0.manager_change_cooldown, v0);
    }

    public fun propose_processor_change<T0>(arg0: &mut ProxyAssetManager<T0>, arg1: &ProxyManagerCap, arg2: address, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(arg1.proxy_id == 0x2::object::id<ProxyAssetManager<T0>>(arg0), 0xaba12ff07741a77fa678d8a37cb0dffc8b148217fadc214747346800fe68a3b1::stoken_errors::unauthorized());
        assert_version<T0>(arg0);
        assert!(0x2::tx_context::sender(arg4) == arg0.manager, 0xaba12ff07741a77fa678d8a37cb0dffc8b148217fadc214747346800fe68a3b1::stoken_errors::unauthorized());
        arg0.pending_processor = 0x1::option::some<address>(arg2);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        arg0.pending_processor_ts = v0 / 1000;
        0xaba12ff07741a77fa678d8a37cb0dffc8b148217fadc214747346800fe68a3b1::stoken_events::emit_proxy_processor_change_pending(0x2::object::id<ProxyAssetManager<T0>>(arg0), arg2, v0 / 1000 + arg0.processor_change_cooldown, v0);
    }

    public fun receive_funds<T0>(arg0: &mut ProxyAssetManager<T0>, arg1: &ProxyProcessorCap, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(arg1.proxy_id == 0x2::object::id<ProxyAssetManager<T0>>(arg0), 0xaba12ff07741a77fa678d8a37cb0dffc8b148217fadc214747346800fe68a3b1::stoken_errors::unauthorized());
        assert_version<T0>(arg0);
        assert!(0x2::tx_context::sender(arg4) == arg0.processor, 0xaba12ff07741a77fa678d8a37cb0dffc8b148217fadc214747346800fe68a3b1::stoken_errors::unauthorized());
        0x2::balance::join<T0>(&mut arg0.underlying, 0x2::coin::into_balance<T0>(arg2));
    }

    public fun receive_funds_manager<T0>(arg0: &mut ProxyAssetManager<T0>, arg1: &ProxyManagerCap, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(arg1.proxy_id == 0x2::object::id<ProxyAssetManager<T0>>(arg0), 0xaba12ff07741a77fa678d8a37cb0dffc8b148217fadc214747346800fe68a3b1::stoken_errors::unauthorized());
        assert_version<T0>(arg0);
        assert!(0x2::tx_context::sender(arg4) == arg0.manager, 0xaba12ff07741a77fa678d8a37cb0dffc8b148217fadc214747346800fe68a3b1::stoken_errors::unauthorized());
        0x2::balance::join<T0>(&mut arg0.underlying, 0x2::coin::into_balance<T0>(arg2));
    }

    public fun receive_funds_processor<T0>(arg0: &mut ProxyAssetManager<T0>, arg1: &ProxyProcessorCap, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::tx_context::TxContext) {
        assert!(arg1.proxy_id == 0x2::object::id<ProxyAssetManager<T0>>(arg0), 0xaba12ff07741a77fa678d8a37cb0dffc8b148217fadc214747346800fe68a3b1::stoken_errors::unauthorized());
        assert_version<T0>(arg0);
        assert!(0x2::tx_context::sender(arg3) == arg0.processor, 0xaba12ff07741a77fa678d8a37cb0dffc8b148217fadc214747346800fe68a3b1::stoken_errors::unauthorized());
        0x2::balance::join<T0>(&mut arg0.underlying, 0x2::coin::into_balance<T0>(arg2));
    }

    public fun remove_target<T0>(arg0: &mut ProxyAssetManager<T0>, arg1: &ProxyManagerCap, arg2: address, arg3: &0x2::tx_context::TxContext) {
        assert!(arg1.proxy_id == 0x2::object::id<ProxyAssetManager<T0>>(arg0), 0xaba12ff07741a77fa678d8a37cb0dffc8b148217fadc214747346800fe68a3b1::stoken_errors::unauthorized());
        assert_version<T0>(arg0);
        assert!(0x2::tx_context::sender(arg3) == arg0.manager, 0xaba12ff07741a77fa678d8a37cb0dffc8b148217fadc214747346800fe68a3b1::stoken_errors::unauthorized());
        assert!(0x2::table::contains<address, TargetConfig>(&arg0.targets, arg2), 0xaba12ff07741a77fa678d8a37cb0dffc8b148217fadc214747346800fe68a3b1::stoken_errors::proxy_target_not_found());
        0x2::table::remove<address, TargetConfig>(&mut arg0.targets, arg2);
        0xaba12ff07741a77fa678d8a37cb0dffc8b148217fadc214747346800fe68a3b1::stoken_events::emit_proxy_target_updated(0x2::object::id<ProxyAssetManager<T0>>(arg0), arg2, false, 0);
    }

    public fun return_funds<T0>(arg0: &mut ProxyAssetManager<T0>, arg1: &ProxyProcessorCap, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        return_funds_to_vault_processor<T0>(arg0, arg1, arg2, arg3, arg4)
    }

    public fun return_funds_manager<T0>(arg0: &mut ProxyAssetManager<T0>, arg1: &ProxyManagerCap, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg1.proxy_id == 0x2::object::id<ProxyAssetManager<T0>>(arg0), 0xaba12ff07741a77fa678d8a37cb0dffc8b148217fadc214747346800fe68a3b1::stoken_errors::unauthorized());
        assert_version<T0>(arg0);
        assert!(0x2::tx_context::sender(arg4) == arg0.manager, 0xaba12ff07741a77fa678d8a37cb0dffc8b148217fadc214747346800fe68a3b1::stoken_errors::unauthorized());
        assert!(arg2 > 0, 0xaba12ff07741a77fa678d8a37cb0dffc8b148217fadc214747346800fe68a3b1::stoken_errors::invalid_amount());
        assert!(0x2::balance::value<T0>(&arg0.underlying) >= arg2, 0xaba12ff07741a77fa678d8a37cb0dffc8b148217fadc214747346800fe68a3b1::stoken_errors::insufficient_vault_funds());
        0xaba12ff07741a77fa678d8a37cb0dffc8b148217fadc214747346800fe68a3b1::stoken_events::emit_proxy_funds_returned(0x2::object::id<ProxyAssetManager<T0>>(arg0), arg2, 0x2::clock::timestamp_ms(arg3));
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.underlying, arg2), arg4)
    }

    public fun return_funds_processor<T0>(arg0: &mut ProxyAssetManager<T0>, arg1: &ProxyProcessorCap, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::tx_context::TxContext, arg4: &0x2::clock::Clock) {
        receive_funds<T0>(arg0, arg1, arg2, arg4, arg3);
    }

    public fun return_funds_to_vault_processor<T0>(arg0: &mut ProxyAssetManager<T0>, arg1: &ProxyProcessorCap, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg1.proxy_id == 0x2::object::id<ProxyAssetManager<T0>>(arg0), 0xaba12ff07741a77fa678d8a37cb0dffc8b148217fadc214747346800fe68a3b1::stoken_errors::unauthorized());
        assert_version<T0>(arg0);
        assert!(0x2::tx_context::sender(arg4) == arg0.processor, 0xaba12ff07741a77fa678d8a37cb0dffc8b148217fadc214747346800fe68a3b1::stoken_errors::unauthorized());
        assert!(arg2 > 0, 0xaba12ff07741a77fa678d8a37cb0dffc8b148217fadc214747346800fe68a3b1::stoken_errors::invalid_amount());
        assert!(0x2::balance::value<T0>(&arg0.underlying) >= arg2, 0xaba12ff07741a77fa678d8a37cb0dffc8b148217fadc214747346800fe68a3b1::stoken_errors::insufficient_vault_funds());
        0xaba12ff07741a77fa678d8a37cb0dffc8b148217fadc214747346800fe68a3b1::stoken_events::emit_proxy_funds_returned(0x2::object::id<ProxyAssetManager<T0>>(arg0), arg2, 0x2::clock::timestamp_ms(arg3));
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.underlying, arg2), arg4)
    }

    public fun unpause<T0>(arg0: &mut ProxyAssetManager<T0>, arg1: &ProxyManagerCap, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(arg1.proxy_id == 0x2::object::id<ProxyAssetManager<T0>>(arg0), 0xaba12ff07741a77fa678d8a37cb0dffc8b148217fadc214747346800fe68a3b1::stoken_errors::unauthorized());
        assert_version<T0>(arg0);
        assert!(0x2::tx_context::sender(arg3) == arg0.manager, 0xaba12ff07741a77fa678d8a37cb0dffc8b148217fadc214747346800fe68a3b1::stoken_errors::unauthorized());
        assert!(arg0.paused, 0xaba12ff07741a77fa678d8a37cb0dffc8b148217fadc214747346800fe68a3b1::stoken_errors::proxy_not_paused());
        assert!(!arg0.force_paused, 0xaba12ff07741a77fa678d8a37cb0dffc8b148217fadc214747346800fe68a3b1::stoken_errors::proxy_force_paused());
        arg0.paused = false;
        0xaba12ff07741a77fa678d8a37cb0dffc8b148217fadc214747346800fe68a3b1::stoken_events::emit_proxy_unpaused(0x2::object::id<ProxyAssetManager<T0>>(arg0), 0x2::clock::timestamp_ms(arg2));
    }

    // decompiled from Move bytecode v7
}

