module 0x154f7b4fd744764152ec1f674903bd10e21f5b25ad2fa574c5e32cde5e6c06a7::launch {
    struct VaultLaunch has key {
        id: 0x2::object::UID,
        creator: address,
        status: u8,
        deposit_open: u64,
        deposit_close: u64,
        crank_open: u64,
        activation_time: u64,
        vesting_end: u64,
        individual_deposit_cap: u64,
        max_backer_passes: u64,
        total_deposited: u64,
        depositor_count: u64,
        platform_fees_accrued: u64,
        project_fees_accrued: u64,
        pool_id: 0x1::option::Option<0x2::object::ID>,
        total_base_tokens: u64,
    }

    struct LaunchCap has store, key {
        id: 0x2::object::UID,
        launch_id: 0x2::object::ID,
    }

    struct QuoteBalanceKey has copy, drop, store {
        dummy_field: bool,
    }

    struct PlatformFeeKey has copy, drop, store {
        dummy_field: bool,
    }

    struct ProjectFeeKey has copy, drop, store {
        dummy_field: bool,
    }

    public fun activation_time(arg0: &VaultLaunch) : u64 {
        arg0.activation_time
    }

    public fun add_deposit(arg0: &mut VaultLaunch, arg1: u64, arg2: u64, arg3: u64) {
        arg0.total_deposited = arg0.total_deposited + arg1;
        arg0.depositor_count = arg0.depositor_count + 1;
        arg0.platform_fees_accrued = arg0.platform_fees_accrued + arg2;
        arg0.project_fees_accrued = arg0.project_fees_accrued + arg3;
    }

    public fun borrow_uid(arg0: &VaultLaunch) : &0x2::object::UID {
        &arg0.id
    }

    public entry fun close_launch(arg0: &mut VaultLaunch, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 0x154f7b4fd744764152ec1f674903bd10e21f5b25ad2fa574c5e32cde5e6c06a7::config::status_live(), 100);
        arg0.status = 0x154f7b4fd744764152ec1f674903bd10e21f5b25ad2fa574c5e32cde5e6c06a7::config::status_closed();
        0x154f7b4fd744764152ec1f674903bd10e21f5b25ad2fa574c5e32cde5e6c06a7::events::emit_status_changed(0x2::object::uid_to_inner(&arg0.id), arg0.status, 0x154f7b4fd744764152ec1f674903bd10e21f5b25ad2fa574c5e32cde5e6c06a7::config::status_closed(), 0x2::clock::timestamp_ms(arg1));
    }

    public entry fun create_launch<T0>(arg0: &mut 0x154f7b4fd744764152ec1f674903bd10e21f5b25ad2fa574c5e32cde5e6c06a7::config::GlobalConfig, arg1: &0x154f7b4fd744764152ec1f674903bd10e21f5b25ad2fa574c5e32cde5e6c06a7::config::LaunchCreatorCap, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 >= 0x2::clock::timestamp_ms(arg4), 101);
        let v0 = arg2 + 0x154f7b4fd744764152ec1f674903bd10e21f5b25ad2fa574c5e32cde5e6c06a7::config::deposit_duration_ms();
        let v1 = v0 + 0x154f7b4fd744764152ec1f674903bd10e21f5b25ad2fa574c5e32cde5e6c06a7::config::activation_delay_ms();
        let v2 = 0x2::object::new(arg5);
        let v3 = 0x2::object::uid_to_inner(&v2);
        let v4 = VaultLaunch{
            id                     : v2,
            creator                : 0x2::tx_context::sender(arg5),
            status                 : 0x154f7b4fd744764152ec1f674903bd10e21f5b25ad2fa574c5e32cde5e6c06a7::config::status_funding(),
            deposit_open           : arg2,
            deposit_close          : v0,
            crank_open             : v0 + 0x154f7b4fd744764152ec1f674903bd10e21f5b25ad2fa574c5e32cde5e6c06a7::config::crank_delay_ms(),
            activation_time        : v1,
            vesting_end            : v1 + 0x154f7b4fd744764152ec1f674903bd10e21f5b25ad2fa574c5e32cde5e6c06a7::config::vesting_duration_ms(),
            individual_deposit_cap : arg3,
            max_backer_passes      : 3,
            total_deposited        : 0,
            depositor_count        : 0,
            platform_fees_accrued  : 0,
            project_fees_accrued   : 0,
            pool_id                : 0x1::option::none<0x2::object::ID>(),
            total_base_tokens      : 0x154f7b4fd744764152ec1f674903bd10e21f5b25ad2fa574c5e32cde5e6c06a7::config::total_supply_const(),
        };
        let v5 = LaunchCap{
            id        : 0x2::object::new(arg5),
            launch_id : v3,
        };
        0x154f7b4fd744764152ec1f674903bd10e21f5b25ad2fa574c5e32cde5e6c06a7::config::increment_launch_count(arg0);
        0x154f7b4fd744764152ec1f674903bd10e21f5b25ad2fa574c5e32cde5e6c06a7::events::emit_launch_created(v3, 0x2::tx_context::sender(arg5), arg2, v0, v1, arg3);
        0x2::transfer::share_object<VaultLaunch>(v4);
        0x2::transfer::transfer<LaunchCap>(v5, 0x2::tx_context::sender(arg5));
    }

    public fun creator(arg0: &VaultLaunch) : address {
        arg0.creator
    }

    public fun deposit_close(arg0: &VaultLaunch) : u64 {
        arg0.deposit_close
    }

    public fun deposit_open(arg0: &VaultLaunch) : u64 {
        arg0.deposit_open
    }

    public fun id(arg0: &VaultLaunch) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun individual_deposit_cap(arg0: &VaultLaunch) : u64 {
        arg0.individual_deposit_cap
    }

    public entry fun mark_live(arg0: &mut VaultLaunch, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 0x154f7b4fd744764152ec1f674903bd10e21f5b25ad2fa574c5e32cde5e6c06a7::config::status_cranking(), 100);
        assert!(0x1::option::is_some<0x2::object::ID>(&arg0.pool_id), 400);
        arg0.status = 0x154f7b4fd744764152ec1f674903bd10e21f5b25ad2fa574c5e32cde5e6c06a7::config::status_live();
        0x154f7b4fd744764152ec1f674903bd10e21f5b25ad2fa574c5e32cde5e6c06a7::events::emit_status_changed(0x2::object::uid_to_inner(&arg0.id), arg0.status, 0x154f7b4fd744764152ec1f674903bd10e21f5b25ad2fa574c5e32cde5e6c06a7::config::status_live(), 0x2::clock::timestamp_ms(arg1));
    }

    public fun max_backer_passes(arg0: &VaultLaunch) : u64 {
        arg0.max_backer_passes
    }

    public fun pool_id(arg0: &VaultLaunch) : 0x1::option::Option<0x2::object::ID> {
        arg0.pool_id
    }

    public fun set_pool_id(arg0: &mut VaultLaunch, arg1: 0x2::object::ID) {
        assert!(0x1::option::is_none<0x2::object::ID>(&arg0.pool_id), 400);
        arg0.pool_id = 0x1::option::some<0x2::object::ID>(arg1);
    }

    public entry fun start_cranking(arg0: &mut VaultLaunch, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 0x154f7b4fd744764152ec1f674903bd10e21f5b25ad2fa574c5e32cde5e6c06a7::config::status_funding(), 100);
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.crank_open, 102);
        arg0.status = 0x154f7b4fd744764152ec1f674903bd10e21f5b25ad2fa574c5e32cde5e6c06a7::config::status_cranking();
        0x154f7b4fd744764152ec1f674903bd10e21f5b25ad2fa574c5e32cde5e6c06a7::events::emit_status_changed(0x2::object::uid_to_inner(&arg0.id), arg0.status, 0x154f7b4fd744764152ec1f674903bd10e21f5b25ad2fa574c5e32cde5e6c06a7::config::status_cranking(), 0x2::clock::timestamp_ms(arg1));
    }

    public fun status(arg0: &VaultLaunch) : u8 {
        arg0.status
    }

    public fun total_deposited(arg0: &VaultLaunch) : u64 {
        arg0.total_deposited
    }

    public fun uid_mut(arg0: &mut VaultLaunch) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public fun vesting_end(arg0: &VaultLaunch) : u64 {
        arg0.vesting_end
    }

    // decompiled from Move bytecode v7
}

