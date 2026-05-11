module 0x8cd25cd3ae7966b61eeae97d77b7e029b29b37307b533b505c6a76b63e22d727::sign_gate {
    struct PolicyVault has store, key {
        id: 0x2::object::UID,
        dwallet_cap: 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::DWalletCap,
        presigns: vector<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::UnverifiedPresignCap>,
        dwallet_network_encryption_key_id: 0x2::object::ID,
        curve: u32,
        signature_algorithm: u32,
        daily_cap_micros: u64,
        spent_today_micros: u64,
        epoch_day: u64,
        cool_down_ms: u64,
        last_sign_at_ms: u64,
        panicked: bool,
        panic_at_ms: u64,
        actuators: vector<address>,
        unfreeze_delay_ms: u64,
        rescue_address_bytes: 0x1::option::Option<vector<u8>>,
        stage_cap_raises: bool,
        pending_cap_micros: 0x1::option::Option<u64>,
        pending_cap_at_ms: u64,
        pending_stage_off: bool,
        pending_stage_off_at_ms: u64,
        stage_delay_ms: u64,
        ika_balance: 0x2::balance::Balance<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>,
        sui_balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct VaultCreated has copy, drop {
        vault_id: 0x2::object::ID,
        dwallet_id: 0x2::object::ID,
        primary_actuator: address,
        daily_cap_micros: u64,
        unfreeze_delay_ms: u64,
    }

    struct PolicySigned has copy, drop {
        vault_id: 0x2::object::ID,
        dwallet_id: 0x2::object::ID,
        sign_id: 0x2::object::ID,
        declared_value_micros: u64,
        spent_today_after_micros: u64,
        daily_cap_micros: u64,
        actuator: address,
    }

    struct PanicTriggered has copy, drop {
        vault_id: 0x2::object::ID,
        dwallet_id: 0x2::object::ID,
        actuator: address,
        panic_at_ms: u64,
        unfreeze_delay_ms: u64,
    }

    struct UnfrozeTriggered has copy, drop {
        vault_id: 0x2::object::ID,
        dwallet_id: 0x2::object::ID,
        actuator: address,
        panic_was_at_ms: u64,
        unfreeze_at_ms: u64,
    }

    struct RescueSigned has copy, drop {
        vault_id: 0x2::object::ID,
        dwallet_id: 0x2::object::ID,
        sign_id: 0x2::object::ID,
        rescue_dest: vector<u8>,
        actuator: address,
    }

    struct ActuatorAdded has copy, drop {
        vault_id: 0x2::object::ID,
        actuator: address,
    }

    struct ActuatorRemoved has copy, drop {
        vault_id: 0x2::object::ID,
        actuator: address,
    }

    struct DailyCapChanged has copy, drop {
        vault_id: 0x2::object::ID,
        prev: u64,
        next: u64,
    }

    struct CoolDownChanged has copy, drop {
        vault_id: 0x2::object::ID,
        prev: u64,
        next: u64,
    }

    struct RescueAddressChanged has copy, drop {
        vault_id: 0x2::object::ID,
        has_address: bool,
    }

    struct StageCapRaisesToggled has copy, drop {
        vault_id: 0x2::object::ID,
        prev: bool,
        next: bool,
        staged_until_ms: u64,
    }

    struct PendingCapStaged has copy, drop {
        vault_id: 0x2::object::ID,
        prev: u64,
        pending: u64,
        commits_at_ms: u64,
    }

    struct PendingCapCommitted has copy, drop {
        vault_id: 0x2::object::ID,
        prev: u64,
        next: u64,
    }

    struct PendingStageOffStaged has copy, drop {
        vault_id: 0x2::object::ID,
        commits_at_ms: u64,
    }

    struct PendingStageOffCommitted has copy, drop {
        vault_id: 0x2::object::ID,
    }

    struct StageDelayChanged has copy, drop {
        vault_id: 0x2::object::ID,
        prev: u64,
        next: u64,
        staged: bool,
    }

    public fun actuators(arg0: &PolicyVault) : vector<address> {
        arg0.actuators
    }

    public fun add_actuator(arg0: &mut PolicyVault, arg1: address, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x1::vector::contains<address>(&arg0.actuators, &v0), 1);
        assert!(!arg0.panicked, 4);
        assert!(!0x1::vector::contains<address>(&arg0.actuators, &arg1), 9);
        0x1::vector::push_back<address>(&mut arg0.actuators, arg1);
        let v1 = ActuatorAdded{
            vault_id : 0x2::object::uid_to_inner(&arg0.id),
            actuator : arg1,
        };
        0x2::event::emit<ActuatorAdded>(v1);
    }

    public fun add_ika_balance(arg0: &mut PolicyVault, arg1: 0x2::coin::Coin<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>) {
        0x2::balance::join<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>(&mut arg0.ika_balance, 0x2::coin::into_balance<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>(arg1));
    }

    public fun add_sui_balance(arg0: &mut PolicyVault, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
    }

    public fun commit_pending_cap(arg0: &mut PolicyVault, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x1::vector::contains<address>(&arg0.actuators, &v0), 1);
        lazy_commit_pending(arg0, 0x2::clock::timestamp_ms(arg1));
    }

    public fun commit_pending_stage_off(arg0: &mut PolicyVault, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x1::vector::contains<address>(&arg0.actuators, &v0), 1);
        lazy_commit_pending(arg0, 0x2::clock::timestamp_ms(arg1));
    }

    public fun cool_down_ms(arg0: &PolicyVault) : u64 {
        arg0.cool_down_ms
    }

    public fun curve(arg0: &PolicyVault) : u32 {
        arg0.curve
    }

    public fun daily_cap_micros(arg0: &PolicyVault) : u64 {
        arg0.daily_cap_micros
    }

    public fun epoch_day(arg0: &PolicyVault) : u64 {
        arg0.epoch_day
    }

    public fun has_pending_cap(arg0: &PolicyVault) : bool {
        0x1::option::is_some<u64>(&arg0.pending_cap_micros)
    }

    public fun has_rescue_address(arg0: &PolicyVault) : bool {
        0x1::option::is_some<vector<u8>>(&arg0.rescue_address_bytes)
    }

    public fun ika_balance_value(arg0: &PolicyVault) : u64 {
        0x2::balance::value<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>(&arg0.ika_balance)
    }

    public fun is_panicked(arg0: &PolicyVault) : bool {
        arg0.panicked
    }

    public fun last_sign_at_ms(arg0: &PolicyVault) : u64 {
        arg0.last_sign_at_ms
    }

    fun lazy_commit_pending(arg0: &mut PolicyVault, arg1: u64) {
        if (0x1::option::is_some<u64>(&arg0.pending_cap_micros) && arg1 >= arg0.pending_cap_at_ms) {
            let v0 = 0x1::option::extract<u64>(&mut arg0.pending_cap_micros);
            arg0.daily_cap_micros = v0;
            arg0.pending_cap_at_ms = 0;
            let v1 = PendingCapCommitted{
                vault_id : 0x2::object::uid_to_inner(&arg0.id),
                prev     : arg0.daily_cap_micros,
                next     : v0,
            };
            0x2::event::emit<PendingCapCommitted>(v1);
        };
        if (arg0.pending_stage_off && arg1 >= arg0.pending_stage_off_at_ms) {
            arg0.stage_cap_raises = false;
            arg0.pending_stage_off = false;
            arg0.pending_stage_off_at_ms = 0;
            let v2 = PendingStageOffCommitted{vault_id: 0x2::object::uid_to_inner(&arg0.id)};
            0x2::event::emit<PendingStageOffCommitted>(v2);
        };
    }

    public fun panic(arg0: &mut PolicyVault, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x1::vector::contains<address>(&arg0.actuators, &v0), 1);
        if (!arg0.panicked) {
            arg0.panicked = true;
            arg0.panic_at_ms = 0x2::clock::timestamp_ms(arg1);
            let v1 = PanicTriggered{
                vault_id          : 0x2::object::uid_to_inner(&arg0.id),
                dwallet_id        : 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::dwallet_id(&arg0.dwallet_cap),
                actuator          : v0,
                panic_at_ms       : arg0.panic_at_ms,
                unfreeze_delay_ms : arg0.unfreeze_delay_ms,
            };
            0x2::event::emit<PanicTriggered>(v1);
        };
    }

    public fun panic_at_ms(arg0: &PolicyVault) : u64 {
        arg0.panic_at_ms
    }

    public fun pending_cap_at_ms(arg0: &PolicyVault) : u64 {
        arg0.pending_cap_at_ms
    }

    public fun pending_stage_off(arg0: &PolicyVault) : bool {
        arg0.pending_stage_off
    }

    public fun pending_stage_off_at_ms(arg0: &PolicyVault) : u64 {
        arg0.pending_stage_off_at_ms
    }

    public fun pop_presign(arg0: &mut PolicyVault, arg1: &0x2::tx_context::TxContext) : 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::UnverifiedPresignCap {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x1::vector::contains<address>(&arg0.actuators, &v0), 1);
        assert!(!arg0.panicked, 4);
        assert!(0x1::vector::length<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::UnverifiedPresignCap>(&arg0.presigns) > 0, 11);
        0x1::vector::pop_back<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::UnverifiedPresignCap>(&mut arg0.presigns)
    }

    public fun pop_presign_for_rescue(arg0: &mut PolicyVault, arg1: &0x2::tx_context::TxContext) : 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::UnverifiedPresignCap {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x1::vector::contains<address>(&arg0.actuators, &v0), 1);
        assert!(arg0.panicked, 5);
        assert!(0x1::vector::length<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::UnverifiedPresignCap>(&arg0.presigns) > 0, 11);
        0x1::vector::pop_back<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::UnverifiedPresignCap>(&mut arg0.presigns)
    }

    public fun presigns_remaining(arg0: &PolicyVault) : u64 {
        0x1::vector::length<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::UnverifiedPresignCap>(&arg0.presigns)
    }

    fun random_session(arg0: &mut 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::DWalletCoordinator, arg1: &mut 0x2::tx_context::TxContext) : 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::sessions_manager::SessionIdentifier {
        0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::register_session_identifier(arg0, 0x2::address::to_bytes(0x2::tx_context::fresh_object_address(arg1)), arg1)
    }

    public fun remove_actuator(arg0: &mut PolicyVault, arg1: address, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x1::vector::contains<address>(&arg0.actuators, &v0), 1);
        assert!(!arg0.panicked, 4);
        assert!(0x1::vector::length<address>(&arg0.actuators) > 1, 10);
        let (v1, v2) = 0x1::vector::index_of<address>(&arg0.actuators, &arg1);
        assert!(v1, 10);
        0x1::vector::swap_remove<address>(&mut arg0.actuators, v2);
        let v3 = ActuatorRemoved{
            vault_id : 0x2::object::uid_to_inner(&arg0.id),
            actuator : arg1,
        };
        0x2::event::emit<ActuatorRemoved>(v3);
    }

    public fun replenish_presign(arg0: &mut PolicyVault, arg1: &mut 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::DWalletCoordinator, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x1::vector::contains<address>(&arg0.actuators, &v0), 1);
        assert!(!arg0.panicked, 4);
        let (v1, v2) = withdraw_payment_coins(arg0, arg2);
        let v3 = v2;
        let v4 = v1;
        let v5 = random_session(arg1, arg2);
        0x1::vector::push_back<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::UnverifiedPresignCap>(&mut arg0.presigns, 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::request_global_presign(arg1, arg0.dwallet_network_encryption_key_id, arg0.curve, arg0.signature_algorithm, v5, &mut v4, &mut v3, arg2));
        return_payment_coins(arg0, v4, v3);
    }

    public fun rescue_sign(arg0: &mut PolicyVault, arg1: &mut 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::DWalletCoordinator, arg2: 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::UnverifiedPresignCap, arg3: vector<u8>, arg4: vector<u8>, arg5: u32, arg6: vector<u8>, arg7: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::tx_context::sender(arg7);
        assert!(0x1::vector::contains<address>(&arg0.actuators, &v0), 1);
        assert!(arg0.panicked, 5);
        assert!(0x1::option::is_some<vector<u8>>(&arg0.rescue_address_bytes), 8);
        assert!(*0x1::option::borrow<vector<u8>>(&arg0.rescue_address_bytes) == arg4, 7);
        let (v1, v2) = withdraw_payment_coins(arg0, arg7);
        let v3 = v2;
        let v4 = v1;
        let v5 = 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::verify_presign_cap(arg1, arg2, arg7);
        let v6 = 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::approve_message(arg1, &arg0.dwallet_cap, arg0.signature_algorithm, arg5, arg3);
        let v7 = random_session(arg1, arg7);
        let v8 = 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::request_sign_and_return_id(arg1, v5, v6, arg6, v7, &mut v4, &mut v3, arg7);
        return_payment_coins(arg0, v4, v3);
        let v9 = RescueSigned{
            vault_id    : 0x2::object::uid_to_inner(&arg0.id),
            dwallet_id  : 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::dwallet_id(&arg0.dwallet_cap),
            sign_id     : v8,
            rescue_dest : arg4,
            actuator    : v0,
        };
        0x2::event::emit<RescueSigned>(v9);
        v8
    }

    fun return_payment_coins(arg0: &mut PolicyVault, arg1: 0x2::coin::Coin<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>, arg2: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x2::balance::join<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>(&mut arg0.ika_balance, 0x2::coin::into_balance<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>(arg1));
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
    }

    public fun set_cool_down(arg0: &mut PolicyVault, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x1::vector::contains<address>(&arg0.actuators, &v0), 1);
        assert!(!arg0.panicked, 4);
        arg0.cool_down_ms = arg1;
        let v1 = CoolDownChanged{
            vault_id : 0x2::object::uid_to_inner(&arg0.id),
            prev     : arg0.cool_down_ms,
            next     : arg1,
        };
        0x2::event::emit<CoolDownChanged>(v1);
    }

    public fun set_daily_cap(arg0: &mut PolicyVault, arg1: u64, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x1::vector::contains<address>(&arg0.actuators, &v0), 1);
        assert!(!arg0.panicked, 4);
        lazy_commit_pending(arg0, 0x2::clock::timestamp_ms(arg2));
        let v1 = arg0.daily_cap_micros;
        if (!arg0.stage_cap_raises || arg1 <= v1) {
            arg0.daily_cap_micros = arg1;
            if (0x1::option::is_some<u64>(&arg0.pending_cap_micros)) {
                0x1::option::extract<u64>(&mut arg0.pending_cap_micros);
                arg0.pending_cap_at_ms = 0;
            };
            let v2 = DailyCapChanged{
                vault_id : 0x2::object::uid_to_inner(&arg0.id),
                prev     : v1,
                next     : arg1,
            };
            0x2::event::emit<DailyCapChanged>(v2);
        } else {
            if (0x1::option::is_some<u64>(&arg0.pending_cap_micros)) {
                0x1::option::extract<u64>(&mut arg0.pending_cap_micros);
            };
            arg0.pending_cap_micros = 0x1::option::some<u64>(arg1);
            arg0.pending_cap_at_ms = 0x2::clock::timestamp_ms(arg2) + arg0.stage_delay_ms;
            let v3 = PendingCapStaged{
                vault_id      : 0x2::object::uid_to_inner(&arg0.id),
                prev          : v1,
                pending       : arg1,
                commits_at_ms : arg0.pending_cap_at_ms,
            };
            0x2::event::emit<PendingCapStaged>(v3);
        };
    }

    public fun set_rescue_address(arg0: &mut PolicyVault, arg1: 0x1::option::Option<vector<u8>>, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x1::vector::contains<address>(&arg0.actuators, &v0), 1);
        assert!(!arg0.panicked, 4);
        arg0.rescue_address_bytes = arg1;
        let v1 = RescueAddressChanged{
            vault_id    : 0x2::object::uid_to_inner(&arg0.id),
            has_address : 0x1::option::is_some<vector<u8>>(&arg1),
        };
        0x2::event::emit<RescueAddressChanged>(v1);
    }

    public fun set_stage_cap_raises(arg0: &mut PolicyVault, arg1: bool, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x1::vector::contains<address>(&arg0.actuators, &v0), 1);
        assert!(!arg0.panicked, 4);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        lazy_commit_pending(arg0, v1);
        let v2 = arg0.stage_cap_raises;
        if (v2 == arg1) {
            return
        };
        if (!v2 && arg1) {
            arg0.stage_cap_raises = true;
            arg0.pending_stage_off = false;
            arg0.pending_stage_off_at_ms = 0;
            let v3 = StageCapRaisesToggled{
                vault_id        : 0x2::object::uid_to_inner(&arg0.id),
                prev            : v2,
                next            : arg1,
                staged_until_ms : 0,
            };
            0x2::event::emit<StageCapRaisesToggled>(v3);
        } else {
            arg0.pending_stage_off = true;
            arg0.pending_stage_off_at_ms = v1 + arg0.stage_delay_ms;
            let v4 = PendingStageOffStaged{
                vault_id      : 0x2::object::uid_to_inner(&arg0.id),
                commits_at_ms : arg0.pending_stage_off_at_ms,
            };
            0x2::event::emit<PendingStageOffStaged>(v4);
        };
    }

    public fun set_stage_delay_ms(arg0: &mut PolicyVault, arg1: u64, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x1::vector::contains<address>(&arg0.actuators, &v0), 1);
        assert!(!arg0.panicked, 4);
        lazy_commit_pending(arg0, 0x2::clock::timestamp_ms(arg2));
        let v1 = arg0.stage_delay_ms;
        if (!arg0.stage_cap_raises || arg1 >= v1) {
            arg0.stage_delay_ms = arg1;
            let v2 = StageDelayChanged{
                vault_id : 0x2::object::uid_to_inner(&arg0.id),
                prev     : v1,
                next     : arg1,
                staged   : false,
            };
            0x2::event::emit<StageDelayChanged>(v2);
        } else {
            let v3 = StageDelayChanged{
                vault_id : 0x2::object::uid_to_inner(&arg0.id),
                prev     : v1,
                next     : arg1,
                staged   : true,
            };
            0x2::event::emit<StageDelayChanged>(v3);
        };
    }

    public fun sign_with_policy(arg0: &mut PolicyVault, arg1: &mut 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::DWalletCoordinator, arg2: 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::UnverifiedPresignCap, arg3: vector<u8>, arg4: u64, arg5: u32, arg6: vector<u8>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::tx_context::sender(arg8);
        assert!(0x1::vector::contains<address>(&arg0.actuators, &v0), 1);
        assert!(!arg0.panicked, 4);
        let v1 = 0x2::clock::timestamp_ms(arg7);
        lazy_commit_pending(arg0, v1);
        assert!(v1 >= arg0.last_sign_at_ms + arg0.cool_down_ms, 3);
        let v2 = v1 / 86400000;
        if (v2 != arg0.epoch_day) {
            arg0.spent_today_micros = 0;
            arg0.epoch_day = v2;
        };
        if (arg0.daily_cap_micros > 0) {
            assert!(arg0.spent_today_micros + arg4 <= arg0.daily_cap_micros, 2);
        };
        let (v3, v4) = withdraw_payment_coins(arg0, arg8);
        let v5 = v4;
        let v6 = v3;
        let v7 = 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::verify_presign_cap(arg1, arg2, arg8);
        let v8 = 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::approve_message(arg1, &arg0.dwallet_cap, arg0.signature_algorithm, arg5, arg3);
        let v9 = random_session(arg1, arg8);
        let v10 = 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::request_sign_and_return_id(arg1, v7, v8, arg6, v9, &mut v6, &mut v5, arg8);
        arg0.spent_today_micros = arg0.spent_today_micros + arg4;
        arg0.last_sign_at_ms = v1;
        return_payment_coins(arg0, v6, v5);
        let v11 = PolicySigned{
            vault_id                 : 0x2::object::uid_to_inner(&arg0.id),
            dwallet_id               : 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::dwallet_id(&arg0.dwallet_cap),
            sign_id                  : v10,
            declared_value_micros    : arg4,
            spent_today_after_micros : arg0.spent_today_micros,
            daily_cap_micros         : arg0.daily_cap_micros,
            actuator                 : v0,
        };
        0x2::event::emit<PolicySigned>(v11);
        v10
    }

    public fun signature_algorithm(arg0: &PolicyVault) : u32 {
        arg0.signature_algorithm
    }

    public fun spent_today_micros(arg0: &PolicyVault) : u64 {
        arg0.spent_today_micros
    }

    public fun stage_cap_raises(arg0: &PolicyVault) : bool {
        arg0.stage_cap_raises
    }

    public fun stage_delay_ms(arg0: &PolicyVault) : u64 {
        arg0.stage_delay_ms
    }

    public fun sui_balance_value(arg0: &PolicyVault) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance)
    }

    public fun unfreeze(arg0: &mut PolicyVault, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x1::vector::contains<address>(&arg0.actuators, &v0), 1);
        assert!(arg0.panicked, 5);
        let v1 = 0x2::clock::timestamp_ms(arg1);
        assert!(v1 >= arg0.panic_at_ms + arg0.unfreeze_delay_ms, 6);
        arg0.panicked = false;
        arg0.panic_at_ms = 0;
        let v2 = UnfrozeTriggered{
            vault_id        : 0x2::object::uid_to_inner(&arg0.id),
            dwallet_id      : 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::dwallet_id(&arg0.dwallet_cap),
            actuator        : v0,
            panic_was_at_ms : arg0.panic_at_ms,
            unfreeze_at_ms  : v1,
        };
        0x2::event::emit<UnfrozeTriggered>(v2);
    }

    public fun unfreeze_delay_ms(arg0: &PolicyVault) : u64 {
        arg0.unfreeze_delay_ms
    }

    public fun unfreeze_unlocks_at_ms(arg0: &PolicyVault) : u64 {
        arg0.panic_at_ms + arg0.unfreeze_delay_ms
    }

    fun withdraw_payment_coins(arg0: &mut PolicyVault, arg1: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>, 0x2::coin::Coin<0x2::sui::SUI>) {
        (0x2::coin::from_balance<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>(0x2::balance::withdraw_all<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>(&mut arg0.ika_balance), arg1), 0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.sui_balance), arg1))
    }

    public fun wrap_dwallet_cap(arg0: 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::DWalletCap, arg1: 0x2::object::ID, arg2: u32, arg3: u32, arg4: u64, arg5: u64, arg6: u64, arg7: 0x1::option::Option<vector<u8>>, arg8: u64, arg9: 0x2::coin::Coin<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>, arg10: 0x2::coin::Coin<0x2::sui::SUI>, arg11: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(arg6 >= 0, 12);
        let v0 = 0x2::tx_context::sender(arg11);
        let v1 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v1, v0);
        let v2 = PolicyVault{
            id                                : 0x2::object::new(arg11),
            dwallet_cap                       : arg0,
            presigns                          : 0x1::vector::empty<0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::UnverifiedPresignCap>(),
            dwallet_network_encryption_key_id : arg1,
            curve                             : arg2,
            signature_algorithm               : arg3,
            daily_cap_micros                  : arg4,
            spent_today_micros                : 0,
            epoch_day                         : 0,
            cool_down_ms                      : arg5,
            last_sign_at_ms                   : 0,
            panicked                          : false,
            panic_at_ms                       : 0,
            actuators                         : v1,
            unfreeze_delay_ms                 : arg6,
            rescue_address_bytes              : arg7,
            stage_cap_raises                  : false,
            pending_cap_micros                : 0x1::option::none<u64>(),
            pending_cap_at_ms                 : 0,
            pending_stage_off                 : false,
            pending_stage_off_at_ms           : 0,
            stage_delay_ms                    : arg8,
            ika_balance                       : 0x2::coin::into_balance<0x7262fb2f7a3a14c888c438a3cd9b912469a58cf60f367352c46584262e8299aa::ika::IKA>(arg9),
            sui_balance                       : 0x2::coin::into_balance<0x2::sui::SUI>(arg10),
        };
        let v3 = 0x2::object::uid_to_inner(&v2.id);
        let v4 = VaultCreated{
            vault_id          : v3,
            dwallet_id        : 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator_inner::dwallet_id(&arg0),
            primary_actuator  : v0,
            daily_cap_micros  : arg4,
            unfreeze_delay_ms : arg6,
        };
        0x2::event::emit<VaultCreated>(v4);
        0x2::transfer::public_share_object<PolicyVault>(v2);
        v3
    }

    // decompiled from Move bytecode v7
}

