module 0x3e9be26d634d11f8a95b0ac1432304e3a9e6d65dc381c048220db391251f3db6::vault {
    struct VaultAdminCap has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
    }

    struct NavState has copy, drop, store {
        last_reported_scaled: u128,
        last_timestamp_ms: u64,
        in_flight_inbound: u128,
        in_flight_outbound: u128,
        external_value: u128,
        deviation_bps_per_update: u64,
        max_staleness_ms: u64,
    }

    struct BufferParams has copy, drop, store {
        target_bps: u64,
        refill_threshold_bps: u64,
        max_bps: u64,
    }

    struct EpochInfo has copy, drop, store {
        current_id: u64,
        current_started_at_ms: u64,
        current_closed_at_ms: u64,
        duration_ms: u64,
    }

    struct FeeState has copy, drop, store {
        performance_bps: u64,
        management_bps: u64,
        high_water_mark_scaled: u128,
        last_mgmt_accrual_ms: u64,
        recipient: address,
        pending_for_recipient: u128,
        pending_for_protocol: u128,
    }

    struct Caps has store {
        deposit_usdc: u64,
        per_user_usdc: u64,
        user_deposits: 0x2::table::Table<address, u64>,
    }

    struct PauseFlags has copy, drop, store {
        deposits: bool,
        redemptions: bool,
        emergency: bool,
        is_ramping: bool,
    }

    struct OracleAuth has copy, drop, store {
        authority: address,
        fulfiller: address,
        pending_authority: address,
        pending_effective_ms: u64,
    }

    struct ForceWithdraw has copy, drop, store {
        amount: u64,
        recipient: address,
        effective_ms: u64,
    }

    struct Vault<phantom T0> has key {
        id: 0x2::object::UID,
        registry_id: 0x2::object::ID,
        creator: address,
        agent_id: vector<u8>,
        vault_kind: u8,
        idle_usdc: 0x2::balance::Balance<T0>,
        total_shares: u128,
        nav: NavState,
        buffer: BufferParams,
        epoch: EpochInfo,
        fees: FeeState,
        caps: Caps,
        pause: PauseFlags,
        oracle: OracleAuth,
        force_withdraw: ForceWithdraw,
        creator_lockup_until_ms: u64,
    }

    public(friend) fun id<T0>(arg0: &Vault<T0>) : 0x2::object::ID {
        0x2::object::id<Vault<T0>>(arg0)
    }

    public(friend) fun accrue_fee_shares_to<T0>(arg0: &mut Vault<T0>, arg1: u8, arg2: u128) {
        arg0.total_shares = arg0.total_shares + arg2;
        if (arg1 == 0) {
            arg0.fees.pending_for_recipient = arg0.fees.pending_for_recipient + arg2;
        } else {
            arg0.fees.pending_for_protocol = arg0.fees.pending_for_protocol + arg2;
        };
    }

    public entry fun accrue_management_fee<T0>(arg0: &mut Vault<T0>, arg1: &0x3e9be26d634d11f8a95b0ac1432304e3a9e6d65dc381c048220db391251f3db6::registry::VaultRegistry, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert_registry_active<T0>(arg0, arg1);
        accrue_management_fee_internal<T0>(arg0, arg2, arg3);
    }

    public(friend) fun accrue_management_fee_internal<T0>(arg0: &mut Vault<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        if (v0 <= arg0.fees.last_mgmt_accrual_ms) {
            return
        };
        let v1 = v0 - arg0.fees.last_mgmt_accrual_ms;
        let v2 = arg0.fees.management_bps;
        if (v2 == 0 || arg0.total_shares == 0) {
            arg0.fees.last_mgmt_accrual_ms = v0;
            return
        };
        let v3 = 0x3e9be26d634d11f8a95b0ac1432304e3a9e6d65dc381c048220db391251f3db6::math::mul_mul_div(arg0.total_shares, (v2 as u128), (v1 as u128), 0x3e9be26d634d11f8a95b0ac1432304e3a9e6d65dc381c048220db391251f3db6::math::bps_denominator() * 0x3e9be26d634d11f8a95b0ac1432304e3a9e6d65dc381c048220db391251f3db6::math::ms_per_year());
        if (v3 > 0) {
            arg0.total_shares = arg0.total_shares + v3;
            arg0.fees.pending_for_recipient = arg0.fees.pending_for_recipient + v3;
            0x3e9be26d634d11f8a95b0ac1432304e3a9e6d65dc381c048220db391251f3db6::events::emit_management_fee(0x3e9be26d634d11f8a95b0ac1432304e3a9e6d65dc381c048220db391251f3db6::events::new_management_fee(0x2::object::id<Vault<T0>>(arg0), v3, v1, v0));
        };
        arg0.fees.last_mgmt_accrual_ms = v0;
    }

    public entry fun admin_clear_ramping<T0>(arg0: &mut Vault<T0>, arg1: &VaultAdminCap, arg2: &0x2::clock::Clock) {
        assert_admin_cap<T0>(arg0, arg1);
        if (arg0.pause.is_ramping) {
            arg0.pause.is_ramping = false;
            0x3e9be26d634d11f8a95b0ac1432304e3a9e6d65dc381c048220db391251f3db6::events::emit_ramping_flipped(0x3e9be26d634d11f8a95b0ac1432304e3a9e6d65dc381c048220db391251f3db6::events::new_ramping_flipped(0x2::object::id<Vault<T0>>(arg0), false, 0x2::clock::timestamp_ms(arg2)));
        };
    }

    public(friend) fun advance_epoch<T0>(arg0: &mut Vault<T0>, arg1: u64) : u64 {
        arg0.epoch.current_id = arg0.epoch.current_id + 1;
        arg0.epoch.current_started_at_ms = arg1;
        arg0.epoch.current_id
    }

    public(friend) fun agent_id<T0>(arg0: &Vault<T0>) : &vector<u8> {
        &arg0.agent_id
    }

    public(friend) fun assert_admin_cap<T0>(arg0: &Vault<T0>, arg1: &VaultAdminCap) {
        assert!(arg1.vault_id == 0x2::object::id<Vault<T0>>(arg0), 0x3e9be26d634d11f8a95b0ac1432304e3a9e6d65dc381c048220db391251f3db6::errors::vault_admin_cap_wrong_vault());
    }

    public(friend) fun assert_registry_active<T0>(arg0: &Vault<T0>, arg1: &0x3e9be26d634d11f8a95b0ac1432304e3a9e6d65dc381c048220db391251f3db6::registry::VaultRegistry) {
        assert!(0x2::object::id<0x3e9be26d634d11f8a95b0ac1432304e3a9e6d65dc381c048220db391251f3db6::registry::VaultRegistry>(arg1) == arg0.registry_id, 0x3e9be26d634d11f8a95b0ac1432304e3a9e6d65dc381c048220db391251f3db6::errors::wrong_registry());
        assert!(!0x3e9be26d634d11f8a95b0ac1432304e3a9e6d65dc381c048220db391251f3db6::registry::is_paused(arg1), 0x3e9be26d634d11f8a95b0ac1432304e3a9e6d65dc381c048220db391251f3db6::errors::registry_paused());
    }

    public(friend) fun burn_shares_from_total<T0>(arg0: &mut Vault<T0>, arg1: u128) {
        assert!(arg0.total_shares >= arg1, 0x3e9be26d634d11f8a95b0ac1432304e3a9e6d65dc381c048220db391251f3db6::errors::insufficient_shares());
        arg0.total_shares = arg0.total_shares - arg1;
    }

    public entry fun cancel_force_withdraw<T0>(arg0: &mut Vault<T0>, arg1: &VaultAdminCap, arg2: &0x2::clock::Clock) {
        assert_admin_cap<T0>(arg0, arg1);
        assert!(arg0.force_withdraw.amount > 0, 0x3e9be26d634d11f8a95b0ac1432304e3a9e6d65dc381c048220db391251f3db6::errors::no_pending_force_withdraw());
        arg0.force_withdraw.amount = 0;
        arg0.force_withdraw.recipient = @0x0;
        arg0.force_withdraw.effective_ms = 0;
        0x3e9be26d634d11f8a95b0ac1432304e3a9e6d65dc381c048220db391251f3db6::events::emit_force_withdraw_cancelled(0x3e9be26d634d11f8a95b0ac1432304e3a9e6d65dc381c048220db391251f3db6::events::new_force_withdraw_cancelled(0x2::object::id<Vault<T0>>(arg0), 0x2::clock::timestamp_ms(arg2)));
    }

    public entry fun claim_fees_protocol<T0>(arg0: &mut Vault<T0>, arg1: &0x3e9be26d634d11f8a95b0ac1432304e3a9e6d65dc381c048220db391251f3db6::registry::VaultRegistry, arg2: &mut 0x2::tx_context::TxContext) {
        assert_registry_active<T0>(arg0, arg1);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == 0x3e9be26d634d11f8a95b0ac1432304e3a9e6d65dc381c048220db391251f3db6::registry::protocol_fee_recipient(arg1), 0x3e9be26d634d11f8a95b0ac1432304e3a9e6d65dc381c048220db391251f3db6::errors::not_fee_recipient());
        let v1 = arg0.fees.pending_for_protocol;
        if (v1 > 0) {
            arg0.fees.pending_for_protocol = 0;
            0x3e9be26d634d11f8a95b0ac1432304e3a9e6d65dc381c048220db391251f3db6::shares::transfer_receipt(0x3e9be26d634d11f8a95b0ac1432304e3a9e6d65dc381c048220db391251f3db6::shares::new_receipt(0x2::object::id<Vault<T0>>(arg0), v1, arg2), v0);
        };
    }

    public entry fun claim_fees_protocol_into<T0>(arg0: &mut Vault<T0>, arg1: &0x3e9be26d634d11f8a95b0ac1432304e3a9e6d65dc381c048220db391251f3db6::registry::VaultRegistry, arg2: &mut 0x3e9be26d634d11f8a95b0ac1432304e3a9e6d65dc381c048220db391251f3db6::shares::ShareReceipt, arg3: &mut 0x2::tx_context::TxContext) {
        assert_registry_active<T0>(arg0, arg1);
        assert!(0x2::tx_context::sender(arg3) == 0x3e9be26d634d11f8a95b0ac1432304e3a9e6d65dc381c048220db391251f3db6::registry::protocol_fee_recipient(arg1), 0x3e9be26d634d11f8a95b0ac1432304e3a9e6d65dc381c048220db391251f3db6::errors::not_fee_recipient());
        assert!(0x3e9be26d634d11f8a95b0ac1432304e3a9e6d65dc381c048220db391251f3db6::shares::vault_id(arg2) == 0x2::object::id<Vault<T0>>(arg0), 0x3e9be26d634d11f8a95b0ac1432304e3a9e6d65dc381c048220db391251f3db6::errors::wrong_vault_id());
        let v0 = arg0.fees.pending_for_protocol;
        if (v0 > 0) {
            arg0.fees.pending_for_protocol = 0;
            0x3e9be26d634d11f8a95b0ac1432304e3a9e6d65dc381c048220db391251f3db6::shares::credit(arg2, v0);
        };
    }

    public entry fun claim_fees_recipient<T0>(arg0: &mut Vault<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(v0 == arg0.fees.recipient, 0x3e9be26d634d11f8a95b0ac1432304e3a9e6d65dc381c048220db391251f3db6::errors::not_fee_recipient());
        let v1 = arg0.fees.pending_for_recipient;
        if (v1 > 0) {
            arg0.fees.pending_for_recipient = 0;
            0x3e9be26d634d11f8a95b0ac1432304e3a9e6d65dc381c048220db391251f3db6::shares::transfer_receipt(0x3e9be26d634d11f8a95b0ac1432304e3a9e6d65dc381c048220db391251f3db6::shares::new_receipt(0x2::object::id<Vault<T0>>(arg0), v1, arg1), v0);
        };
    }

    public entry fun claim_fees_recipient_into<T0>(arg0: &mut Vault<T0>, arg1: &mut 0x3e9be26d634d11f8a95b0ac1432304e3a9e6d65dc381c048220db391251f3db6::shares::ShareReceipt, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.fees.recipient, 0x3e9be26d634d11f8a95b0ac1432304e3a9e6d65dc381c048220db391251f3db6::errors::not_fee_recipient());
        assert!(0x3e9be26d634d11f8a95b0ac1432304e3a9e6d65dc381c048220db391251f3db6::shares::vault_id(arg1) == 0x2::object::id<Vault<T0>>(arg0), 0x3e9be26d634d11f8a95b0ac1432304e3a9e6d65dc381c048220db391251f3db6::errors::wrong_vault_id());
        let v0 = arg0.fees.pending_for_recipient;
        if (v0 > 0) {
            arg0.fees.pending_for_recipient = 0;
            0x3e9be26d634d11f8a95b0ac1432304e3a9e6d65dc381c048220db391251f3db6::shares::credit(arg1, v0);
        };
    }

    public entry fun create_vault<T0>(arg0: &mut 0x3e9be26d634d11f8a95b0ac1432304e3a9e6d65dc381c048220db391251f3db6::registry::VaultRegistry, arg1: vector<u8>, arg2: u8, arg3: address, arg4: address, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: u64, arg16: 0x2::coin::Coin<T0>, arg17: &0x2::clock::Clock, arg18: &mut 0x2::tx_context::TxContext) {
        assert!(!0x3e9be26d634d11f8a95b0ac1432304e3a9e6d65dc381c048220db391251f3db6::registry::is_paused(arg0), 0x3e9be26d634d11f8a95b0ac1432304e3a9e6d65dc381c048220db391251f3db6::errors::registry_paused());
        assert!(arg2 == 0 || arg2 == 1, 0x3e9be26d634d11f8a95b0ac1432304e3a9e6d65dc381c048220db391251f3db6::errors::invalid_vault_kind());
        assert!(arg5 <= 5000, 0x3e9be26d634d11f8a95b0ac1432304e3a9e6d65dc381c048220db391251f3db6::errors::invalid_fee_bps());
        assert!(arg6 <= 1000, 0x3e9be26d634d11f8a95b0ac1432304e3a9e6d65dc381c048220db391251f3db6::errors::invalid_fee_bps());
        assert!(arg12 <= 10000, 0x3e9be26d634d11f8a95b0ac1432304e3a9e6d65dc381c048220db391251f3db6::errors::invalid_fee_bps());
        assert!(arg10 >= 5000 && arg10 <= 3600000, 0x3e9be26d634d11f8a95b0ac1432304e3a9e6d65dc381c048220db391251f3db6::errors::invalid_epoch_duration());
        let v0 = if (arg7 <= 10000) {
            if (arg8 <= arg7) {
                if (arg9 >= arg7) {
                    arg9 <= 10000
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 0x3e9be26d634d11f8a95b0ac1432304e3a9e6d65dc381c048220db391251f3db6::errors::invalid_buffer_params());
        let v1 = 0x2::coin::value<T0>(&arg16);
        assert!(v1 >= 0x3e9be26d634d11f8a95b0ac1432304e3a9e6d65dc381c048220db391251f3db6::registry::min_seed_deposit_usdc(arg0), 0x3e9be26d634d11f8a95b0ac1432304e3a9e6d65dc381c048220db391251f3db6::errors::seed_deposit_below_min());
        let v2 = 0x2::clock::timestamp_ms(arg17);
        let v3 = 0x2::tx_context::sender(arg18);
        let v4 = 0x3e9be26d634d11f8a95b0ac1432304e3a9e6d65dc381c048220db391251f3db6::math::shares_for_deposit(v1, 0, 0);
        let v5 = NavState{
            last_reported_scaled     : 0x3e9be26d634d11f8a95b0ac1432304e3a9e6d65dc381c048220db391251f3db6::math::usdc_to_nav_scaled((v1 as u128)),
            last_timestamp_ms        : v2,
            in_flight_inbound        : 0,
            in_flight_outbound       : 0,
            external_value           : 0,
            deviation_bps_per_update : arg12,
            max_staleness_ms         : arg11,
        };
        let v6 = BufferParams{
            target_bps           : arg7,
            refill_threshold_bps : arg8,
            max_bps              : arg9,
        };
        let v7 = EpochInfo{
            current_id            : 0,
            current_started_at_ms : v2,
            current_closed_at_ms  : 0,
            duration_ms           : arg10,
        };
        let v8 = FeeState{
            performance_bps        : arg5,
            management_bps         : arg6,
            high_water_mark_scaled : 0x3e9be26d634d11f8a95b0ac1432304e3a9e6d65dc381c048220db391251f3db6::math::precision(),
            last_mgmt_accrual_ms   : v2,
            recipient              : v3,
            pending_for_recipient  : 0,
            pending_for_protocol   : 0,
        };
        let v9 = Caps{
            deposit_usdc  : arg13,
            per_user_usdc : arg14,
            user_deposits : 0x2::table::new<address, u64>(arg18),
        };
        let v10 = PauseFlags{
            deposits    : false,
            redemptions : false,
            emergency   : false,
            is_ramping  : false,
        };
        let v11 = OracleAuth{
            authority            : arg3,
            fulfiller            : arg4,
            pending_authority    : @0x0,
            pending_effective_ms : 0,
        };
        let v12 = ForceWithdraw{
            amount       : 0,
            recipient    : @0x0,
            effective_ms : 0,
        };
        let v13 = Vault<T0>{
            id                      : 0x2::object::new(arg18),
            registry_id             : 0x2::object::id<0x3e9be26d634d11f8a95b0ac1432304e3a9e6d65dc381c048220db391251f3db6::registry::VaultRegistry>(arg0),
            creator                 : v3,
            agent_id                : arg1,
            vault_kind              : arg2,
            idle_usdc               : 0x2::coin::into_balance<T0>(arg16),
            total_shares            : v4,
            nav                     : v5,
            buffer                  : v6,
            epoch                   : v7,
            fees                    : v8,
            caps                    : v9,
            pause                   : v10,
            oracle                  : v11,
            force_withdraw          : v12,
            creator_lockup_until_ms : v2 + arg15,
        };
        let v14 = 0x2::object::id<Vault<T0>>(&v13);
        0x2::table::add<address, u64>(&mut v13.caps.user_deposits, v3, v1);
        0x2::transfer::share_object<Vault<T0>>(v13);
        0x3e9be26d634d11f8a95b0ac1432304e3a9e6d65dc381c048220db391251f3db6::shares::transfer_receipt(0x3e9be26d634d11f8a95b0ac1432304e3a9e6d65dc381c048220db391251f3db6::shares::new_receipt(v14, v4, arg18), v3);
        let v15 = VaultAdminCap{
            id       : 0x2::object::new(arg18),
            vault_id : v14,
        };
        0x2::transfer::transfer<VaultAdminCap>(v15, v3);
        0x3e9be26d634d11f8a95b0ac1432304e3a9e6d65dc381c048220db391251f3db6::registry::increment_vault_count(arg0);
        0x3e9be26d634d11f8a95b0ac1432304e3a9e6d65dc381c048220db391251f3db6::events::emit_vault_created(0x3e9be26d634d11f8a95b0ac1432304e3a9e6d65dc381c048220db391251f3db6::events::new_vault_created(v14, v3, arg1, arg2, v1, v4, v2));
    }

    public(friend) fun creator<T0>(arg0: &Vault<T0>) : address {
        arg0.creator
    }

    public(friend) fun creator_lockup_until_ms<T0>(arg0: &Vault<T0>) : u64 {
        arg0.creator_lockup_until_ms
    }

    public(friend) fun current_epoch_closed_at_ms<T0>(arg0: &Vault<T0>) : u64 {
        arg0.epoch.current_closed_at_ms
    }

    public(friend) fun current_epoch_id<T0>(arg0: &Vault<T0>) : u64 {
        arg0.epoch.current_id
    }

    public(friend) fun current_epoch_started_at_ms<T0>(arg0: &Vault<T0>) : u64 {
        arg0.epoch.current_started_at_ms
    }

    public entry fun deposit<T0>(arg0: &mut Vault<T0>, arg1: &0x3e9be26d634d11f8a95b0ac1432304e3a9e6d65dc381c048220db391251f3db6::registry::VaultRegistry, arg2: 0x2::coin::Coin<T0>, arg3: u128, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert_registry_active<T0>(arg0, arg1);
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = deposit_internal<T0>(arg0, arg2, arg3, arg4, arg5);
        0x3e9be26d634d11f8a95b0ac1432304e3a9e6d65dc381c048220db391251f3db6::shares::transfer_receipt(0x3e9be26d634d11f8a95b0ac1432304e3a9e6d65dc381c048220db391251f3db6::shares::new_receipt(0x2::object::id<Vault<T0>>(arg0), v1, arg5), v0);
    }

    public entry fun deposit_from_external<T0>(arg0: &mut Vault<T0>, arg1: 0x2::coin::Coin<T0>, arg2: u8, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = if (arg2 == 1) {
            true
        } else if (arg2 == 2) {
            true
        } else {
            arg2 == 3
        };
        assert!(v0, 0x3e9be26d634d11f8a95b0ac1432304e3a9e6d65dc381c048220db391251f3db6::errors::invalid_buffer_source());
        0x2::balance::join<T0>(&mut arg0.idle_usdc, 0x2::coin::into_balance<T0>(arg1));
        0x3e9be26d634d11f8a95b0ac1432304e3a9e6d65dc381c048220db391251f3db6::events::emit_buffer_op(0x3e9be26d634d11f8a95b0ac1432304e3a9e6d65dc381c048220db391251f3db6::events::new_buffer_op(0x2::object::id<Vault<T0>>(arg0), arg2, 0x2::coin::value<T0>(&arg1), 0x2::balance::value<T0>(&arg0.idle_usdc), 0x2::clock::timestamp_ms(arg3)));
    }

    fun deposit_internal<T0>(arg0: &mut Vault<T0>, arg1: 0x2::coin::Coin<T0>, arg2: u128, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : u128 {
        assert!(!arg0.pause.emergency, 0x3e9be26d634d11f8a95b0ac1432304e3a9e6d65dc381c048220db391251f3db6::errors::emergency_mode_active());
        assert!(!arg0.pause.deposits, 0x3e9be26d634d11f8a95b0ac1432304e3a9e6d65dc381c048220db391251f3db6::errors::deposits_paused());
        assert!(!arg0.pause.is_ramping, 0x3e9be26d634d11f8a95b0ac1432304e3a9e6d65dc381c048220db391251f3db6::errors::vault_ramping_deposit());
        let v0 = 0x2::clock::timestamp_ms(arg3);
        assert!(v0 <= arg0.nav.last_timestamp_ms + arg0.nav.max_staleness_ms, 0x3e9be26d634d11f8a95b0ac1432304e3a9e6d65dc381c048220db391251f3db6::errors::nav_stale());
        let v1 = 0x2::tx_context::sender(arg4);
        let v2 = 0x2::coin::value<T0>(&arg1);
        if (arg0.caps.deposit_usdc > 0) {
            assert!((0x3e9be26d634d11f8a95b0ac1432304e3a9e6d65dc381c048220db391251f3db6::math::nav_scaled_to_usdc(arg0.nav.last_reported_scaled) as u128) + (v2 as u128) <= (arg0.caps.deposit_usdc as u128), 0x3e9be26d634d11f8a95b0ac1432304e3a9e6d65dc381c048220db391251f3db6::errors::deposit_cap_exceeded());
        };
        if (arg0.caps.per_user_usdc > 0) {
            let v3 = if (0x2::table::contains<address, u64>(&arg0.caps.user_deposits, v1)) {
                *0x2::table::borrow<address, u64>(&arg0.caps.user_deposits, v1)
            } else {
                0
            };
            assert!((v3 as u128) + (v2 as u128) <= (arg0.caps.per_user_usdc as u128), 0x3e9be26d634d11f8a95b0ac1432304e3a9e6d65dc381c048220db391251f3db6::errors::per_user_cap_exceeded());
        };
        accrue_management_fee_internal<T0>(arg0, arg3, arg4);
        let v4 = 0x3e9be26d634d11f8a95b0ac1432304e3a9e6d65dc381c048220db391251f3db6::math::shares_for_deposit(v2, arg0.total_shares, arg0.nav.last_reported_scaled);
        assert!(v4 >= arg2, 0x3e9be26d634d11f8a95b0ac1432304e3a9e6d65dc381c048220db391251f3db6::errors::slippage_min_shares());
        0x2::balance::join<T0>(&mut arg0.idle_usdc, 0x2::coin::into_balance<T0>(arg1));
        arg0.total_shares = arg0.total_shares + v4;
        arg0.nav.last_reported_scaled = arg0.nav.last_reported_scaled + 0x3e9be26d634d11f8a95b0ac1432304e3a9e6d65dc381c048220db391251f3db6::math::usdc_to_nav_scaled((v2 as u128));
        if (0x2::table::contains<address, u64>(&arg0.caps.user_deposits, v1)) {
            0x2::table::add<address, u64>(&mut arg0.caps.user_deposits, v1, 0x2::table::remove<address, u64>(&mut arg0.caps.user_deposits, v1) + v2);
        } else {
            0x2::table::add<address, u64>(&mut arg0.caps.user_deposits, v1, v2);
        };
        0x3e9be26d634d11f8a95b0ac1432304e3a9e6d65dc381c048220db391251f3db6::events::emit_deposit(0x3e9be26d634d11f8a95b0ac1432304e3a9e6d65dc381c048220db391251f3db6::events::new_deposit(0x2::object::id<Vault<T0>>(arg0), v1, v2, v4, 0x3e9be26d634d11f8a95b0ac1432304e3a9e6d65dc381c048220db391251f3db6::math::share_price_scaled(arg0.total_shares, arg0.nav.last_reported_scaled), arg0.nav.last_reported_scaled, v0));
        v4
    }

    public entry fun deposit_into<T0>(arg0: &mut Vault<T0>, arg1: &0x3e9be26d634d11f8a95b0ac1432304e3a9e6d65dc381c048220db391251f3db6::registry::VaultRegistry, arg2: 0x2::coin::Coin<T0>, arg3: u128, arg4: &mut 0x3e9be26d634d11f8a95b0ac1432304e3a9e6d65dc381c048220db391251f3db6::shares::ShareReceipt, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert_registry_active<T0>(arg0, arg1);
        assert!(0x3e9be26d634d11f8a95b0ac1432304e3a9e6d65dc381c048220db391251f3db6::shares::vault_id(arg4) == 0x2::object::id<Vault<T0>>(arg0), 0x3e9be26d634d11f8a95b0ac1432304e3a9e6d65dc381c048220db391251f3db6::errors::wrong_vault_id());
        0x3e9be26d634d11f8a95b0ac1432304e3a9e6d65dc381c048220db391251f3db6::shares::credit(arg4, deposit_internal<T0>(arg0, arg2, arg3, arg5, arg6));
    }

    public(friend) fun emergency_mode<T0>(arg0: &Vault<T0>) : bool {
        arg0.pause.emergency
    }

    public(friend) fun epoch_duration_ms<T0>(arg0: &Vault<T0>) : u64 {
        arg0.epoch.duration_ms
    }

    public entry fun execute_force_withdraw<T0>(arg0: &mut Vault<T0>, arg1: &0x3e9be26d634d11f8a95b0ac1432304e3a9e6d65dc381c048220db391251f3db6::registry::VaultRegistry, arg2: &VaultAdminCap, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_registry_active<T0>(arg0, arg1);
        assert_admin_cap<T0>(arg0, arg2);
        let v0 = arg0.force_withdraw.amount;
        let v1 = arg0.force_withdraw.recipient;
        assert!(v0 > 0, 0x3e9be26d634d11f8a95b0ac1432304e3a9e6d65dc381c048220db391251f3db6::errors::no_pending_force_withdraw());
        let v2 = 0x2::clock::timestamp_ms(arg3);
        assert!(v2 >= arg0.force_withdraw.effective_ms, 0x3e9be26d634d11f8a95b0ac1432304e3a9e6d65dc381c048220db391251f3db6::errors::force_withdraw_not_due());
        assert!(0x2::balance::value<T0>(&arg0.idle_usdc) >= v0, 0x3e9be26d634d11f8a95b0ac1432304e3a9e6d65dc381c048220db391251f3db6::errors::withdraw_exceeds_idle());
        arg0.force_withdraw.amount = 0;
        arg0.force_withdraw.recipient = @0x0;
        arg0.force_withdraw.effective_ms = 0;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.idle_usdc, v0), arg4), v1);
        0x3e9be26d634d11f8a95b0ac1432304e3a9e6d65dc381c048220db391251f3db6::events::emit_force_withdraw_executed(0x3e9be26d634d11f8a95b0ac1432304e3a9e6d65dc381c048220db391251f3db6::events::new_force_withdraw_executed(0x2::object::id<Vault<T0>>(arg0), v0, v1, 0x2::balance::value<T0>(&arg0.idle_usdc), v2));
    }

    public entry fun execute_oracle_rotation<T0>(arg0: &mut Vault<T0>, arg1: &0x2::clock::Clock) {
        assert!(arg0.oracle.pending_authority != @0x0, 0x3e9be26d634d11f8a95b0ac1432304e3a9e6d65dc381c048220db391251f3db6::errors::no_pending_oracle_rotation());
        let v0 = 0x2::clock::timestamp_ms(arg1);
        assert!(v0 >= arg0.oracle.pending_effective_ms, 0x3e9be26d634d11f8a95b0ac1432304e3a9e6d65dc381c048220db391251f3db6::errors::oracle_rotation_not_due());
        let v1 = arg0.oracle.pending_authority;
        arg0.oracle.authority = v1;
        arg0.oracle.pending_authority = @0x0;
        arg0.oracle.pending_effective_ms = 0;
        0x3e9be26d634d11f8a95b0ac1432304e3a9e6d65dc381c048220db391251f3db6::events::emit_oracle_rotation_executed(0x3e9be26d634d11f8a95b0ac1432304e3a9e6d65dc381c048220db391251f3db6::events::new_oracle_rotation_executed(0x2::object::id<Vault<T0>>(arg0), v1, v0));
    }

    public(friend) fun fee_recipient<T0>(arg0: &Vault<T0>) : address {
        arg0.fees.recipient
    }

    public fun force_withdraw_timelock_ms() : u64 {
        86400000
    }

    public(friend) fun fulfiller_authority<T0>(arg0: &Vault<T0>) : address {
        arg0.oracle.fulfiller
    }

    public(friend) fun high_water_mark_scaled<T0>(arg0: &Vault<T0>) : u128 {
        arg0.fees.high_water_mark_scaled
    }

    public(friend) fun idle_usdc_value<T0>(arg0: &Vault<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.idle_usdc)
    }

    public(friend) fun is_ramping<T0>(arg0: &Vault<T0>) : bool {
        arg0.pause.is_ramping
    }

    public(friend) fun last_mgmt_fee_accrual_ms<T0>(arg0: &Vault<T0>) : u64 {
        arg0.fees.last_mgmt_accrual_ms
    }

    public(friend) fun last_nav_timestamp_ms<T0>(arg0: &Vault<T0>) : u64 {
        arg0.nav.last_timestamp_ms
    }

    public(friend) fun last_reported_nav_scaled<T0>(arg0: &Vault<T0>) : u128 {
        arg0.nav.last_reported_scaled
    }

    public(friend) fun management_fee_bps<T0>(arg0: &Vault<T0>) : u64 {
        arg0.fees.management_bps
    }

    public(friend) fun nav_deviation_bps_per_update<T0>(arg0: &Vault<T0>) : u64 {
        arg0.nav.deviation_bps_per_update
    }

    public(friend) fun nav_max_staleness_ms<T0>(arg0: &Vault<T0>) : u64 {
        arg0.nav.max_staleness_ms
    }

    public(friend) fun oracle_authority<T0>(arg0: &Vault<T0>) : address {
        arg0.oracle.authority
    }

    public fun oracle_rotation_timelock_ms() : u64 {
        86400000
    }

    public(friend) fun paused_deposits<T0>(arg0: &Vault<T0>) : bool {
        arg0.pause.deposits
    }

    public(friend) fun paused_redemptions<T0>(arg0: &Vault<T0>) : bool {
        arg0.pause.redemptions
    }

    public(friend) fun pending_fee_shares_for_protocol<T0>(arg0: &Vault<T0>) : u128 {
        arg0.fees.pending_for_protocol
    }

    public(friend) fun pending_fee_shares_for_recipient<T0>(arg0: &Vault<T0>) : u128 {
        arg0.fees.pending_for_recipient
    }

    public(friend) fun pending_force_withdraw_amount<T0>(arg0: &Vault<T0>) : u64 {
        arg0.force_withdraw.amount
    }

    public(friend) fun pending_force_withdraw_effective_ms<T0>(arg0: &Vault<T0>) : u64 {
        arg0.force_withdraw.effective_ms
    }

    public(friend) fun pending_force_withdraw_recipient<T0>(arg0: &Vault<T0>) : address {
        arg0.force_withdraw.recipient
    }

    public(friend) fun pending_oracle_authority<T0>(arg0: &Vault<T0>) : address {
        arg0.oracle.pending_authority
    }

    public(friend) fun pending_oracle_authority_effective_ms<T0>(arg0: &Vault<T0>) : u64 {
        arg0.oracle.pending_effective_ms
    }

    public(friend) fun performance_fee_bps<T0>(arg0: &Vault<T0>) : u64 {
        arg0.fees.performance_bps
    }

    public(friend) fun put_idle<T0>(arg0: &mut Vault<T0>, arg1: 0x2::balance::Balance<T0>) {
        0x2::balance::join<T0>(&mut arg0.idle_usdc, arg1);
    }

    public entry fun queue_force_withdraw<T0>(arg0: &mut Vault<T0>, arg1: &0x3e9be26d634d11f8a95b0ac1432304e3a9e6d65dc381c048220db391251f3db6::registry::VaultRegistry, arg2: &VaultAdminCap, arg3: u64, arg4: address, arg5: &0x2::clock::Clock) {
        assert_registry_active<T0>(arg0, arg1);
        assert_admin_cap<T0>(arg0, arg2);
        assert!(arg3 > 0, 0x3e9be26d634d11f8a95b0ac1432304e3a9e6d65dc381c048220db391251f3db6::errors::invalid_force_withdraw_amount());
        assert!(arg4 != @0x0, 0x3e9be26d634d11f8a95b0ac1432304e3a9e6d65dc381c048220db391251f3db6::errors::invalid_force_withdraw_recipient());
        let v0 = 0x2::clock::timestamp_ms(arg5);
        let v1 = v0 + 86400000;
        arg0.force_withdraw.amount = arg3;
        arg0.force_withdraw.recipient = arg4;
        arg0.force_withdraw.effective_ms = v1;
        0x3e9be26d634d11f8a95b0ac1432304e3a9e6d65dc381c048220db391251f3db6::events::emit_force_withdraw_queued(0x3e9be26d634d11f8a95b0ac1432304e3a9e6d65dc381c048220db391251f3db6::events::new_force_withdraw_queued(0x2::object::id<Vault<T0>>(arg0), arg3, arg4, v1, v0));
    }

    public entry fun queue_oracle_rotation<T0>(arg0: &mut Vault<T0>, arg1: &VaultAdminCap, arg2: address, arg3: &0x2::clock::Clock) {
        assert_admin_cap<T0>(arg0, arg1);
        assert!(arg2 != @0x0, 0x3e9be26d634d11f8a95b0ac1432304e3a9e6d65dc381c048220db391251f3db6::errors::not_oracle_authority());
        let v0 = 0x2::clock::timestamp_ms(arg3) + 86400000;
        arg0.oracle.pending_authority = arg2;
        arg0.oracle.pending_effective_ms = v0;
        0x3e9be26d634d11f8a95b0ac1432304e3a9e6d65dc381c048220db391251f3db6::events::emit_oracle_rotation_queued(0x3e9be26d634d11f8a95b0ac1432304e3a9e6d65dc381c048220db391251f3db6::events::new_oracle_rotation_queued(0x2::object::id<Vault<T0>>(arg0), arg2, v0));
    }

    public(friend) fun reduce_nav_scaled<T0>(arg0: &mut Vault<T0>, arg1: u128) {
        assert!(arg0.nav.last_reported_scaled >= arg1, 0x3e9be26d634d11f8a95b0ac1432304e3a9e6d65dc381c048220db391251f3db6::errors::arithmetic_underflow());
        arg0.nav.last_reported_scaled = arg0.nav.last_reported_scaled - arg1;
    }

    public(friend) fun registry_id<T0>(arg0: &Vault<T0>) : 0x2::object::ID {
        arg0.registry_id
    }

    public entry fun rotate_fulfiller<T0>(arg0: &mut Vault<T0>, arg1: &VaultAdminCap, arg2: address, arg3: &0x2::clock::Clock) {
        assert_admin_cap<T0>(arg0, arg1);
        assert!(arg2 != @0x0, 0x3e9be26d634d11f8a95b0ac1432304e3a9e6d65dc381c048220db391251f3db6::errors::not_fulfiller_authority());
        arg0.oracle.fulfiller = arg2;
        0x3e9be26d634d11f8a95b0ac1432304e3a9e6d65dc381c048220db391251f3db6::events::emit_fulfiller_rotated(0x3e9be26d634d11f8a95b0ac1432304e3a9e6d65dc381c048220db391251f3db6::events::new_fulfiller_rotated(0x2::object::id<Vault<T0>>(arg0), arg2, 0x2::clock::timestamp_ms(arg3)));
    }

    public(friend) fun set_current_epoch_closed_at_ms<T0>(arg0: &mut Vault<T0>, arg1: u64) {
        arg0.epoch.current_closed_at_ms = arg1;
    }

    public entry fun set_emergency_mode<T0>(arg0: &mut Vault<T0>, arg1: &VaultAdminCap, arg2: bool, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_admin_cap<T0>(arg0, arg1);
        accrue_management_fee_internal<T0>(arg0, arg3, arg4);
        arg0.pause.emergency = arg2;
        0x3e9be26d634d11f8a95b0ac1432304e3a9e6d65dc381c048220db391251f3db6::events::emit_emergency_mode(0x3e9be26d634d11f8a95b0ac1432304e3a9e6d65dc381c048220db391251f3db6::events::new_emergency_mode(0x2::object::id<Vault<T0>>(arg0), arg2, 0x2::clock::timestamp_ms(arg3)));
    }

    public(friend) fun set_high_water_mark<T0>(arg0: &mut Vault<T0>, arg1: u128) {
        arg0.fees.high_water_mark_scaled = arg1;
    }

    public(friend) fun set_last_mgmt_fee_accrual_ms<T0>(arg0: &mut Vault<T0>, arg1: u64) {
        arg0.fees.last_mgmt_accrual_ms = arg1;
    }

    public(friend) fun set_nav_components<T0>(arg0: &mut Vault<T0>, arg1: u128, arg2: u128, arg3: u128, arg4: u128, arg5: u64) {
        arg0.nav.last_reported_scaled = arg1;
        arg0.nav.in_flight_inbound = arg2;
        arg0.nav.in_flight_outbound = arg3;
        arg0.nav.external_value = arg4;
        arg0.nav.last_timestamp_ms = arg5;
    }

    public entry fun set_pause<T0>(arg0: &mut Vault<T0>, arg1: &VaultAdminCap, arg2: bool, arg3: bool, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert_admin_cap<T0>(arg0, arg1);
        accrue_management_fee_internal<T0>(arg0, arg4, arg5);
        arg0.pause.deposits = arg2;
        arg0.pause.redemptions = arg3;
        0x3e9be26d634d11f8a95b0ac1432304e3a9e6d65dc381c048220db391251f3db6::events::emit_pause(0x3e9be26d634d11f8a95b0ac1432304e3a9e6d65dc381c048220db391251f3db6::events::new_pause(0x2::object::id<Vault<T0>>(arg0), arg2, arg3, 0x2::clock::timestamp_ms(arg4)));
    }

    public(friend) fun set_ramping<T0>(arg0: &mut Vault<T0>, arg1: bool) {
        arg0.pause.is_ramping = arg1;
    }

    public(friend) fun take_idle<T0>(arg0: &mut Vault<T0>, arg1: u64) : 0x2::balance::Balance<T0> {
        assert!(0x2::balance::value<T0>(&arg0.idle_usdc) >= arg1, 0x3e9be26d634d11f8a95b0ac1432304e3a9e6d65dc381c048220db391251f3db6::errors::withdraw_exceeds_idle());
        0x2::balance::split<T0>(&mut arg0.idle_usdc, arg1)
    }

    public(friend) fun total_shares<T0>(arg0: &Vault<T0>) : u128 {
        arg0.total_shares
    }

    public entry fun update_buffer_params<T0>(arg0: &mut Vault<T0>, arg1: &VaultAdminCap, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock) {
        assert_admin_cap<T0>(arg0, arg1);
        let v0 = if (arg2 <= 10000) {
            if (arg3 <= arg2) {
                if (arg4 >= arg2) {
                    arg4 <= 10000
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 0x3e9be26d634d11f8a95b0ac1432304e3a9e6d65dc381c048220db391251f3db6::errors::invalid_buffer_params());
        arg0.buffer.target_bps = arg2;
        arg0.buffer.refill_threshold_bps = arg3;
        arg0.buffer.max_bps = arg4;
        0x3e9be26d634d11f8a95b0ac1432304e3a9e6d65dc381c048220db391251f3db6::events::emit_buffer_params_updated(0x3e9be26d634d11f8a95b0ac1432304e3a9e6d65dc381c048220db391251f3db6::events::new_buffer_params_updated(0x2::object::id<Vault<T0>>(arg0), arg2, arg3, arg4, 0x2::clock::timestamp_ms(arg5)));
    }

    public entry fun update_caps<T0>(arg0: &mut Vault<T0>, arg1: &VaultAdminCap, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock) {
        assert_admin_cap<T0>(arg0, arg1);
        arg0.caps.deposit_usdc = arg2;
        arg0.caps.per_user_usdc = arg3;
        0x3e9be26d634d11f8a95b0ac1432304e3a9e6d65dc381c048220db391251f3db6::events::emit_caps_updated(0x3e9be26d634d11f8a95b0ac1432304e3a9e6d65dc381c048220db391251f3db6::events::new_caps_updated(0x2::object::id<Vault<T0>>(arg0), arg2, arg3, 0x2::clock::timestamp_ms(arg4)));
    }

    public entry fun update_fee_recipient<T0>(arg0: &mut Vault<T0>, arg1: &VaultAdminCap, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_admin_cap<T0>(arg0, arg1);
        assert!(arg2 != @0x0, 0x3e9be26d634d11f8a95b0ac1432304e3a9e6d65dc381c048220db391251f3db6::errors::invalid_fee_recipient());
        accrue_management_fee_internal<T0>(arg0, arg3, arg4);
        arg0.fees.recipient = arg2;
        0x3e9be26d634d11f8a95b0ac1432304e3a9e6d65dc381c048220db391251f3db6::events::emit_fee_recipient_updated(0x3e9be26d634d11f8a95b0ac1432304e3a9e6d65dc381c048220db391251f3db6::events::new_fee_recipient_updated(0x2::object::id<Vault<T0>>(arg0), arg0.fees.recipient, arg2, 0x2::clock::timestamp_ms(arg3)));
    }

    public entry fun update_fees<T0>(arg0: &mut Vault<T0>, arg1: &VaultAdminCap, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert_admin_cap<T0>(arg0, arg1);
        assert!(arg2 <= 5000, 0x3e9be26d634d11f8a95b0ac1432304e3a9e6d65dc381c048220db391251f3db6::errors::invalid_fee_bps());
        assert!(arg3 <= 1000, 0x3e9be26d634d11f8a95b0ac1432304e3a9e6d65dc381c048220db391251f3db6::errors::invalid_fee_bps());
        accrue_management_fee_internal<T0>(arg0, arg4, arg5);
        let v0 = 0x3e9be26d634d11f8a95b0ac1432304e3a9e6d65dc381c048220db391251f3db6::math::share_price_scaled(arg0.total_shares, arg0.nav.last_reported_scaled);
        if (v0 > arg0.fees.high_water_mark_scaled) {
            arg0.fees.high_water_mark_scaled = v0;
        };
        arg0.fees.performance_bps = arg2;
        arg0.fees.management_bps = arg3;
        0x3e9be26d634d11f8a95b0ac1432304e3a9e6d65dc381c048220db391251f3db6::events::emit_fees_updated(0x3e9be26d634d11f8a95b0ac1432304e3a9e6d65dc381c048220db391251f3db6::events::new_fees_updated(0x2::object::id<Vault<T0>>(arg0), arg2, arg3, 0x2::clock::timestamp_ms(arg4)));
    }

    public fun vault_admin_cap_vault_id(arg0: &VaultAdminCap) : 0x2::object::ID {
        arg0.vault_id
    }

    public(friend) fun vault_kind<T0>(arg0: &Vault<T0>) : u8 {
        arg0.vault_kind
    }

    public fun vault_kind_hyperliquid_perp() : u8 {
        0
    }

    public fun vault_kind_polymarket_prediction() : u8 {
        1
    }

    public fun withdraw_for_deployment<T0>(arg0: &mut Vault<T0>, arg1: &0x3e9be26d634d11f8a95b0ac1432304e3a9e6d65dc381c048220db391251f3db6::registry::VaultRegistry, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_registry_active<T0>(arg0, arg1);
        assert!(0x2::tx_context::sender(arg4) == arg0.oracle.fulfiller, 0x3e9be26d634d11f8a95b0ac1432304e3a9e6d65dc381c048220db391251f3db6::errors::not_fulfiller_authority());
        assert!(!arg0.pause.emergency, 0x3e9be26d634d11f8a95b0ac1432304e3a9e6d65dc381c048220db391251f3db6::errors::emergency_mode_active());
        let v0 = 0x2::clock::timestamp_ms(arg3);
        assert!(v0 <= arg0.nav.last_timestamp_ms + arg0.nav.max_staleness_ms, 0x3e9be26d634d11f8a95b0ac1432304e3a9e6d65dc381c048220db391251f3db6::errors::nav_stale());
        let v1 = 0x2::balance::value<T0>(&arg0.idle_usdc);
        assert!(v1 >= arg2, 0x3e9be26d634d11f8a95b0ac1432304e3a9e6d65dc381c048220db391251f3db6::errors::withdraw_exceeds_idle());
        let v2 = 0x3e9be26d634d11f8a95b0ac1432304e3a9e6d65dc381c048220db391251f3db6::math::nav_scaled_to_usdc(arg0.nav.last_reported_scaled);
        if (v2 > 0) {
            assert!((0x3e9be26d634d11f8a95b0ac1432304e3a9e6d65dc381c048220db391251f3db6::math::mul_div(((v1 - arg2) as u128), 10000, (v2 as u128)) as u64) >= arg0.buffer.refill_threshold_bps, 0x3e9be26d634d11f8a95b0ac1432304e3a9e6d65dc381c048220db391251f3db6::errors::buffer_would_fall_below_refill());
        };
        0x3e9be26d634d11f8a95b0ac1432304e3a9e6d65dc381c048220db391251f3db6::events::emit_buffer_op(0x3e9be26d634d11f8a95b0ac1432304e3a9e6d65dc381c048220db391251f3db6::events::new_buffer_op(0x2::object::id<Vault<T0>>(arg0), 0, arg2, 0x2::balance::value<T0>(&arg0.idle_usdc), v0));
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.idle_usdc, arg2), arg4)
    }

    // decompiled from Move bytecode v7
}

