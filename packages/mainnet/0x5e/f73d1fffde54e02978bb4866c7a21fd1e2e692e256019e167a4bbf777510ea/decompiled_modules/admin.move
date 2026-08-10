module 0x5ef73d1fffde54e02978bb4866c7a21fd1e2e692e256019e167a4bbf777510ea::admin {
    struct EmergencyRegistry has key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
        announced: 0x2::table::Table<0x1::type_name::TypeName, u64>,
        delay_ms: u64,
    }

    struct EmergencyAnnounced has copy, drop {
        token_type: 0x1::type_name::TypeName,
        announced_ms: u64,
        executable_after_ms: u64,
        announced_by: address,
    }

    struct EmergencyCancelled has copy, drop {
        token_type: 0x1::type_name::TypeName,
        cancelled_by: address,
        timestamp_ms: u64,
    }

    struct EmergencyWithdrawExecuted has copy, drop {
        token_type: 0x1::type_name::TypeName,
        amount: u64,
        recipient: address,
        timestamp_ms: u64,
    }

    struct EmergencyDelayUpdated has copy, drop {
        old_delay_ms: u64,
        new_delay_ms: u64,
    }

    struct EmergencyExitExecuted has copy, drop {
        token: 0x1::type_name::TypeName,
        amount_sold: u64,
        received: u64,
        min_out_manual: u64,
        by: address,
    }

    struct SwapReceipt {
        token: 0x1::type_name::TypeName,
        amount_out_min: u64,
        amount_sold: u64,
    }

    entry fun announce_emergency_withdraw<T0>(arg0: &mut EmergencyRegistry, arg1: &0x5ef73d1fffde54e02978bb4866c7a21fd1e2e692e256019e167a4bbf777510ea::vault::AdminCap, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::get<T0>();
        assert!(!0x2::table::contains<0x1::type_name::TypeName, u64>(&arg0.announced, v0), 703);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        let v2 = v1 + arg0.delay_ms;
        0x2::table::add<0x1::type_name::TypeName, u64>(&mut arg0.announced, v0, v2);
        let v3 = EmergencyAnnounced{
            token_type          : v0,
            announced_ms        : v1,
            executable_after_ms : v2,
            announced_by        : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<EmergencyAnnounced>(v3);
    }

    entry fun cancel_emergency_withdraw<T0>(arg0: &mut EmergencyRegistry, arg1: &0x5ef73d1fffde54e02978bb4866c7a21fd1e2e692e256019e167a4bbf777510ea::vault::AdminCap, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, u64>(&arg0.announced, v0), 701);
        0x2::table::remove<0x1::type_name::TypeName, u64>(&mut arg0.announced, v0);
        let v1 = EmergencyCancelled{
            token_type   : v0,
            cancelled_by : 0x2::tx_context::sender(arg3),
            timestamp_ms : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<EmergencyCancelled>(v1);
    }

    entry fun create_registry(arg0: &0x5ef73d1fffde54e02978bb4866c7a21fd1e2e692e256019e167a4bbf777510ea::vault::SuiX5Vault, arg1: &0x5ef73d1fffde54e02978bb4866c7a21fd1e2e692e256019e167a4bbf777510ea::vault::AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = EmergencyRegistry{
            id        : 0x2::object::new(arg2),
            vault_id  : 0x2::object::id<0x5ef73d1fffde54e02978bb4866c7a21fd1e2e692e256019e167a4bbf777510ea::vault::SuiX5Vault>(arg0),
            announced : 0x2::table::new<0x1::type_name::TypeName, u64>(arg2),
            delay_ms  : 172800000,
        };
        0x2::transfer::share_object<EmergencyRegistry>(v0);
    }

    public fun delay_ms(arg0: &EmergencyRegistry) : u64 {
        arg0.delay_ms
    }

    public fun emergency_exit_begin<T0, T1>(arg0: &mut 0x5ef73d1fffde54e02978bb4866c7a21fd1e2e692e256019e167a4bbf777510ea::vault::SuiX5Vault, arg1: &0x5ef73d1fffde54e02978bb4866c7a21fd1e2e692e256019e167a4bbf777510ea::vault::AdminCap, arg2: u64, arg3: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, SwapReceipt) {
        assert!(0x5ef73d1fffde54e02978bb4866c7a21fd1e2e692e256019e167a4bbf777510ea::vault::is_paused(arg0), 708);
        let v0 = 0x5ef73d1fffde54e02978bb4866c7a21fd1e2e692e256019e167a4bbf777510ea::vault::balance_of<T0>(arg0);
        assert!(v0 > 0, 709);
        let v1 = SwapReceipt{
            token          : 0x1::type_name::get<T0>(),
            amount_out_min : arg2,
            amount_sold    : v0,
        };
        (0x5ef73d1fffde54e02978bb4866c7a21fd1e2e692e256019e167a4bbf777510ea::vault::split_balance<T0>(arg0, v0), v1)
    }

    public fun emergency_exit_settle<T0, T1>(arg0: &mut 0x5ef73d1fffde54e02978bb4866c7a21fd1e2e692e256019e167a4bbf777510ea::vault::SuiX5Vault, arg1: &0x5ef73d1fffde54e02978bb4866c7a21fd1e2e692e256019e167a4bbf777510ea::vault::AdminCap, arg2: 0x2::balance::Balance<T1>, arg3: SwapReceipt, arg4: &0x2::tx_context::TxContext) {
        let SwapReceipt {
            token          : v0,
            amount_out_min : v1,
            amount_sold    : v2,
        } = arg3;
        assert!(v0 == 0x1::type_name::get<T0>(), 711);
        let v3 = 0x2::balance::value<T1>(&arg2);
        assert!(v3 >= v1, 710);
        0x5ef73d1fffde54e02978bb4866c7a21fd1e2e692e256019e167a4bbf777510ea::vault::join_balance<T1>(arg0, arg2);
        let v4 = EmergencyExitExecuted{
            token          : v0,
            amount_sold    : v2,
            received       : v3,
            min_out_manual : v1,
            by             : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<EmergencyExitExecuted>(v4);
    }

    public fun executable_after(arg0: &EmergencyRegistry, arg1: 0x1::type_name::TypeName) : u64 {
        if (!0x2::table::contains<0x1::type_name::TypeName, u64>(&arg0.announced, arg1)) {
            return 0
        };
        *0x2::table::borrow<0x1::type_name::TypeName, u64>(&arg0.announced, arg1)
    }

    entry fun execute_emergency_withdraw<T0>(arg0: &mut 0x5ef73d1fffde54e02978bb4866c7a21fd1e2e692e256019e167a4bbf777510ea::vault::SuiX5Vault, arg1: &mut EmergencyRegistry, arg2: &0x5ef73d1fffde54e02978bb4866c7a21fd1e2e692e256019e167a4bbf777510ea::vault::AdminCap, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x5ef73d1fffde54e02978bb4866c7a21fd1e2e692e256019e167a4bbf777510ea::vault::is_paused(arg0), 700);
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, u64>(&arg1.announced, v0), 701);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        assert!(v1 >= 0x2::table::remove<0x1::type_name::TypeName, u64>(&mut arg1.announced, v0), 702);
        let v2 = 0x5ef73d1fffde54e02978bb4866c7a21fd1e2e692e256019e167a4bbf777510ea::vault::balance_of<T0>(arg0);
        assert!(v2 > 0, 706);
        let v3 = 0x5ef73d1fffde54e02978bb4866c7a21fd1e2e692e256019e167a4bbf777510ea::vault::admin(arg0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x5ef73d1fffde54e02978bb4866c7a21fd1e2e692e256019e167a4bbf777510ea::vault::split_balance<T0>(arg0, v2), arg4), v3);
        let v4 = EmergencyWithdrawExecuted{
            token_type   : v0,
            amount       : v2,
            recipient    : v3,
            timestamp_ms : v1,
        };
        0x2::event::emit<EmergencyWithdrawExecuted>(v4);
    }

    public fun is_announced(arg0: &EmergencyRegistry, arg1: 0x1::type_name::TypeName) : bool {
        0x2::table::contains<0x1::type_name::TypeName, u64>(&arg0.announced, arg1)
    }

    entry fun set_emergency_delay(arg0: &mut EmergencyRegistry, arg1: &0x5ef73d1fffde54e02978bb4866c7a21fd1e2e692e256019e167a4bbf777510ea::vault::AdminCap, arg2: u64) {
        assert!(arg2 >= 172800000, 704);
        assert!(arg2 <= 2592000000, 705);
        arg0.delay_ms = arg2;
        let v0 = EmergencyDelayUpdated{
            old_delay_ms : arg0.delay_ms,
            new_delay_ms : arg2,
        };
        0x2::event::emit<EmergencyDelayUpdated>(v0);
    }

    // decompiled from Move bytecode v7
}

