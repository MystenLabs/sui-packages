module 0x42d37e584c4a02465938055d26787b8c1a87bff58c709031417cdab64bb6abf5::eternity_vault {
    struct ETERNITY_VAULT has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct RenewalPolicy has copy, drop, store {
        target_horizon_epochs: u32,
        renew_window_epochs: u32,
        safety_margin_epochs: u32,
        max_price_per_unit_epoch: u64,
        tip_floor_frost: u64,
        tip_ceiling_frost: u64,
        tip_curve_exponent: u8,
        tip_max_bps_of_escrow: u64,
        low_water_mark_frost: u64,
        expected_gas_frost: u64,
        profit_epsilon_frost: u64,
    }

    struct EternityVault has key {
        id: 0x2::object::UID,
        blob: 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob,
        escrow: 0x2::balance::Balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>,
        policy: RenewalPolicy,
        committed_blob_id: u256,
        cached_charged_units: u64,
        last_cranked_window: u32,
        last_paid_end_epoch: u32,
        state: u8,
        version: u64,
        obligation_count: u64,
        beneficiary: address,
        owner_cap_id: 0x2::object::ID,
        code_version: u64,
        close_unlock_epoch: u32,
        reactivate_after_epoch: u32,
    }

    struct VaultOwnerCap has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
    }

    struct AvailabilityWitness {
        vault_id: 0x2::object::ID,
        blob_id: u256,
        live_through_epoch: u32,
        version: u64,
    }

    struct ReceiptView has copy, drop {
        vault_id: 0x2::object::ID,
        blob_id: u256,
        end_epoch: u32,
        cur_epoch: u32,
        headroom_windows: u32,
        state: u8,
        escrow: u64,
        version: u64,
        obligation_count: u64,
    }

    struct ObligationTicket has store {
        vault_id: 0x2::object::ID,
    }

    struct RankPreimage has drop {
        vault_id: address,
        window: u32,
        keeper: address,
    }

    struct Opened has copy, drop {
        vault_id: 0x2::object::ID,
        blob_id: u256,
        end_epoch: u32,
        owner_cap_id: 0x2::object::ID,
    }

    struct Funded has copy, drop {
        vault_id: 0x2::object::ID,
        amount: u64,
        escrow: u64,
        reactivated: bool,
    }

    struct Cranked has copy, drop {
        vault_id: 0x2::object::ID,
        blob_id: u256,
        keeper: address,
        epoch: u32,
        old_end_epoch: u32,
        new_end_epoch: u32,
        wal_spent: u64,
        tip_paid: u64,
        window: u32,
        version: u64,
    }

    struct Underfunded has copy, drop {
        vault_id: 0x2::object::ID,
        blob_id: u256,
        end_epoch: u32,
        escrow_remaining: u64,
        epoch: u32,
    }

    struct Closed has copy, drop {
        vault_id: 0x2::object::ID,
        blob_id: u256,
    }

    fun assert_cap(arg0: &EternityVault, arg1: &VaultOwnerCap) {
        assert!(arg0.owner_cap_id == 0x2::object::uid_to_inner(&arg1.id), 11);
    }

    fun assert_policy_static(arg0: &RenewalPolicy) {
        assert!(arg0.safety_margin_epochs >= 1, 4);
        assert!(arg0.renew_window_epochs > arg0.safety_margin_epochs, 4);
        assert!(arg0.target_horizon_epochs >= 2 * arg0.renew_window_epochs, 4);
        assert!(arg0.target_horizon_epochs <= 53, 4);
        assert!(arg0.tip_curve_exponent >= 1, 4);
        assert!(arg0.tip_ceiling_frost >= arg0.tip_floor_frost, 4);
        assert!(arg0.tip_floor_frost >= arg0.expected_gas_frost + arg0.profit_epsilon_frost, 4);
    }

    fun build_vault(arg0: 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob, arg1: 0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>, arg2: RenewalPolicy, arg3: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg4: address, arg5: &mut 0x2::tx_context::TxContext) : (EternityVault, VaultOwnerCap) {
        assert_policy_static(&arg2);
        assert!(arg2.target_horizon_epochs <= 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_accounting::max_epochs_ahead(0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::future_accounting(arg3)), 4);
        assert!(0x1::option::is_some<u32>(0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::certified_epoch(&arg0)), 1);
        assert!(!0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::is_deletable(&arg0), 2);
        let v0 = 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::end_epoch(&arg0);
        assert!(v0 > 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::epoch(arg3), 3);
        let v1 = 0x42d37e584c4a02465938055d26787b8c1a87bff58c709031417cdab64bb6abf5::economics::charged_units(0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::size(0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::storage(&arg0)));
        assert!(arg2.low_water_mark_frost >= 0x42d37e584c4a02465938055d26787b8c1a87bff58c709031417cdab64bb6abf5::economics::price_cap(arg2.max_price_per_unit_epoch, v1, arg2.target_horizon_epochs) + arg2.tip_ceiling_frost, 4);
        let v2 = 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::blob_id(&arg0);
        let v3 = 0x2::object::new(arg5);
        let v4 = 0x2::object::uid_to_inner(&v3);
        let v5 = 0x2::object::new(arg5);
        let v6 = 0x2::object::uid_to_inner(&v5);
        let v7 = EternityVault{
            id                     : v3,
            blob                   : arg0,
            escrow                 : 0x2::coin::into_balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(arg1),
            policy                 : arg2,
            committed_blob_id      : v2,
            cached_charged_units   : v1,
            last_cranked_window    : 4294967295,
            last_paid_end_epoch    : v0,
            state                  : 0,
            version                : 0,
            obligation_count       : 0,
            beneficiary            : arg4,
            owner_cap_id           : v6,
            code_version           : 2,
            close_unlock_epoch     : 0,
            reactivate_after_epoch : 0,
        };
        let v8 = Opened{
            vault_id     : v4,
            blob_id      : v2,
            end_epoch    : v0,
            owner_cap_id : v6,
        };
        0x2::event::emit<Opened>(v8);
        let v9 = VaultOwnerCap{
            id       : v5,
            vault_id : v4,
        };
        (v7, v9)
    }

    public fun committed_blob_id(arg0: &EternityVault) : u256 {
        arg0.committed_blob_id
    }

    public fun consume_witness(arg0: AvailabilityWitness) : (0x2::object::ID, u256, u32, u64) {
        let AvailabilityWitness {
            vault_id           : v0,
            blob_id            : v1,
            live_through_epoch : v2,
            version            : v3,
        } = arg0;
        (v0, v1, v2, v3)
    }

    public fun crank(arg0: &mut EternityVault, arg1: &mut 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL> {
        assert!(arg0.code_version == 2, 14);
        assert!(arg0.state == 0, 5);
        let v0 = arg0.policy;
        let v1 = 0x2::object::uid_to_inner(&arg0.id);
        let v2 = 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::epoch(arg1);
        let v3 = 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::end_epoch(&arg0.blob);
        assert!(v3 > v2, 5);
        let v4 = v3 - v2;
        let v5 = v0.renew_window_epochs;
        let v6 = v0.safety_margin_epochs;
        assert!(v4 >= v6 && v4 <= v5, 6);
        assert!(keeper_rank(0x2::object::id_to_address(&v1), 0x42d37e584c4a02465938055d26787b8c1a87bff58c709031417cdab64bb6abf5::economics::window_of(v3, v5), 0x2::tx_context::sender(arg2)) <= (((64 as u128) * ((v5 - v4) as u128) / ((v5 - v6) as u128)) as u64) || v4 <= v6 + 1, 19);
        let v7 = 0x42d37e584c4a02465938055d26787b8c1a87bff58c709031417cdab64bb6abf5::economics::extend_epochs(v4, v0.target_horizon_epochs);
        assert!(v7 >= v5, 8);
        assert!(v3 + v7 - v2 <= 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_accounting::max_epochs_ahead(0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::future_accounting(arg1)), 10);
        let v8 = 0x42d37e584c4a02465938055d26787b8c1a87bff58c709031417cdab64bb6abf5::economics::price_cap(v0.max_price_per_unit_epoch, arg0.cached_charged_units, v7);
        let v9 = 0x2::balance::value<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&arg0.escrow);
        let v10 = if (v9 >= v8) {
            v8
        } else {
            v9
        };
        let v11 = 0x2::coin::take<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&mut arg0.escrow, v10, arg2);
        0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::extend_blob(arg1, &mut arg0.blob, v7, &mut v11);
        let v12 = 0x2::coin::value<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&v11) - 0x2::coin::value<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&v11);
        assert!(v12 <= v8, 9);
        0x2::balance::join<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&mut arg0.escrow, 0x2::coin::into_balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(v11));
        let v13 = 0x42d37e584c4a02465938055d26787b8c1a87bff58c709031417cdab64bb6abf5::economics::tip_capped(0x42d37e584c4a02465938055d26787b8c1a87bff58c709031417cdab64bb6abf5::economics::tip_raw(v4, v6, v5, v0.tip_curve_exponent, v0.tip_floor_frost, v0.tip_ceiling_frost), 0x2::balance::value<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&arg0.escrow), v0.low_water_mark_frost, v0.tip_max_bps_of_escrow);
        let v14 = 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::end_epoch(&arg0.blob);
        let v15 = 0x42d37e584c4a02465938055d26787b8c1a87bff58c709031417cdab64bb6abf5::economics::window_of(v14, v5);
        assert!(arg0.last_cranked_window == 4294967295 || v15 > arg0.last_cranked_window, 8);
        arg0.last_cranked_window = v15;
        arg0.last_paid_end_epoch = v14;
        arg0.version = arg0.version + 1;
        let v16 = 0x2::balance::value<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&arg0.escrow);
        if (v16 < v0.low_water_mark_frost) {
            arg0.state = 1;
            arg0.reactivate_after_epoch = v2 + 2;
            let v17 = Underfunded{
                vault_id         : v1,
                blob_id          : arg0.committed_blob_id,
                end_epoch        : v14,
                escrow_remaining : v16,
                epoch            : v2,
            };
            0x2::event::emit<Underfunded>(v17);
        };
        let v18 = Cranked{
            vault_id      : v1,
            blob_id       : arg0.committed_blob_id,
            keeper        : 0x2::tx_context::sender(arg2),
            epoch         : v2,
            old_end_epoch : v3,
            new_end_epoch : v14,
            wal_spent     : v12,
            tip_paid      : v13,
            window        : v15,
            version       : arg0.version,
        };
        0x2::event::emit<Cranked>(v18);
        0x2::coin::take<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&mut arg0.escrow, v13, arg2)
    }

    public fun escrow_balance(arg0: &EternityVault) : u64 {
        0x2::balance::value<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&arg0.escrow)
    }

    public fun finalize_close(arg0: EternityVault, arg1: VaultOwnerCap, arg2: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL> {
        assert!(arg0.code_version == 2, 14);
        assert!(arg0.owner_cap_id == 0x2::object::uid_to_inner(&arg1.id), 11);
        assert!(arg0.obligation_count == 0, 12);
        assert!(arg0.close_unlock_epoch != 0 && 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::epoch(arg2) >= arg0.close_unlock_epoch, 15);
        let EternityVault {
            id                     : v0,
            blob                   : v1,
            escrow                 : v2,
            policy                 : _,
            committed_blob_id      : v4,
            cached_charged_units   : _,
            last_cranked_window    : _,
            last_paid_end_epoch    : _,
            state                  : _,
            version                : _,
            obligation_count       : _,
            beneficiary            : v11,
            owner_cap_id           : _,
            code_version           : _,
            close_unlock_epoch     : _,
            reactivate_after_epoch : _,
        } = arg0;
        let v16 = v0;
        let v17 = Closed{
            vault_id : 0x2::object::uid_to_inner(&v16),
            blob_id  : v4,
        };
        0x2::event::emit<Closed>(v17);
        0x2::object::delete(v16);
        0x2::transfer::public_transfer<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(v1, v11);
        let VaultOwnerCap {
            id       : v18,
            vault_id : _,
        } = arg1;
        0x2::object::delete(v18);
        0x2::coin::from_balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(v2, arg3)
    }

    public fun fund(arg0: &mut EternityVault, arg1: 0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>, arg2: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System) {
        assert!(arg0.code_version == 2, 14);
        0x2::balance::join<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&mut arg0.escrow, 0x2::coin::into_balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(arg1));
        let v0 = false;
        let v1 = if (arg0.state == 1) {
            if (0x2::balance::value<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&arg0.escrow) >= arg0.policy.low_water_mark_frost) {
                0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::epoch(arg2) >= arg0.reactivate_after_epoch
            } else {
                false
            }
        } else {
            false
        };
        if (v1) {
            arg0.state = 0;
            arg0.reactivate_after_epoch = 0;
            v0 = true;
        };
        let v2 = Funded{
            vault_id    : 0x2::object::uid_to_inner(&arg0.id),
            amount      : 0x2::coin::value<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&arg1),
            escrow      : 0x2::balance::value<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&arg0.escrow),
            reactivated : v0,
        };
        0x2::event::emit<Funded>(v2);
    }

    fun init(arg0: ETERNITY_VAULT, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::types::is_one_time_witness<ETERNITY_VAULT>(&arg0), 20);
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun is_certified_live(arg0: &EternityVault, arg1: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System) : bool {
        if (arg0.state == 0) {
            if (0x1::option::is_some<u32>(0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::certified_epoch(&arg0.blob))) {
                0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::end_epoch(&arg0.blob) > 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::epoch(arg1)
            } else {
                false
            }
        } else {
            false
        }
    }

    public fun is_underfunded(arg0: &EternityVault) : bool {
        arg0.state == 1
    }

    fun keeper_rank(arg0: address, arg1: u32, arg2: address) : u64 {
        let v0 = RankPreimage{
            vault_id : arg0,
            window   : arg1,
            keeper   : arg2,
        };
        let v1 = 0x2::bcs::to_bytes<RankPreimage>(&v0);
        let v2 = 0x2::bcs::new(0x2::hash::blake2b256(&v1));
        ((0x2::bcs::peel_u256(&mut v2) % (64 as u256)) as u64)
    }

    public fun live_through_epoch(arg0: &EternityVault) : u32 {
        0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::end_epoch(&arg0.blob)
    }

    public fun lock_obligation(arg0: &mut EternityVault) : ObligationTicket {
        assert!(arg0.code_version == 2, 14);
        arg0.obligation_count = arg0.obligation_count + 1;
        ObligationTicket{vault_id: 0x2::object::uid_to_inner(&arg0.id)}
    }

    public fun migrate(arg0: &mut EternityVault, arg1: &AdminCap) {
        arg0.code_version = 2;
    }

    public fun new_policy(arg0: u32, arg1: u32, arg2: u32, arg3: u64, arg4: u64, arg5: u64, arg6: u8, arg7: u64, arg8: u64, arg9: u64, arg10: u64) : RenewalPolicy {
        let v0 = RenewalPolicy{
            target_horizon_epochs    : arg0,
            renew_window_epochs      : arg1,
            safety_margin_epochs     : arg2,
            max_price_per_unit_epoch : arg3,
            tip_floor_frost          : arg4,
            tip_ceiling_frost        : arg5,
            tip_curve_exponent       : arg6,
            tip_max_bps_of_escrow    : arg7,
            low_water_mark_frost     : arg8,
            expected_gas_frost       : arg9,
            profit_epsilon_frost     : arg10,
        };
        assert_policy_static(&v0);
        v0
    }

    public fun obligations(arg0: &EternityVault) : u64 {
        arg0.obligation_count
    }

    public fun open_funded(arg0: 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob, arg1: 0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>, arg2: RenewalPolicy, arg3: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg4: address, arg5: &mut 0x2::tx_context::TxContext) : VaultOwnerCap {
        let (v0, v1) = build_vault(arg0, arg1, arg2, arg3, arg4, arg5);
        0x2::transfer::share_object<EternityVault>(v0);
        v1
    }

    public fun prove_live(arg0: &EternityVault, arg1: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System) : AvailabilityWitness {
        assert!(is_certified_live(arg0, arg1), 16);
        AvailabilityWitness{
            vault_id           : 0x2::object::uid_to_inner(&arg0.id),
            blob_id            : arg0.committed_blob_id,
            live_through_epoch : 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::end_epoch(&arg0.blob),
            version            : arg0.version,
        }
    }

    public fun raise_price_cap(arg0: &mut EternityVault, arg1: &VaultOwnerCap, arg2: u64) {
        assert!(arg0.code_version == 2, 14);
        assert_cap(arg0, arg1);
        assert!(arg2 >= arg0.policy.max_price_per_unit_epoch, 4);
        arg0.policy.max_price_per_unit_epoch = arg2;
    }

    public fun raise_tip_ceiling(arg0: &mut EternityVault, arg1: &VaultOwnerCap, arg2: u64) {
        assert!(arg0.code_version == 2, 14);
        assert_cap(arg0, arg1);
        assert!(arg2 >= arg0.policy.tip_ceiling_frost, 4);
        arg0.policy.tip_ceiling_frost = arg2;
    }

    public fun raise_tip_floor(arg0: &mut EternityVault, arg1: &VaultOwnerCap, arg2: u64) {
        assert!(arg0.code_version == 2, 14);
        assert_cap(arg0, arg1);
        assert!(arg2 >= arg0.policy.tip_floor_frost, 4);
        assert!(arg0.policy.tip_ceiling_frost >= arg2, 4);
        arg0.policy.tip_floor_frost = arg2;
    }

    public fun receipt_version(arg0: &EternityVault) : u64 {
        arg0.version
    }

    public fun receipt_view(arg0: &EternityVault, arg1: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System) : ReceiptView {
        let v0 = 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::epoch(arg1);
        let v1 = 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::end_epoch(&arg0.blob);
        let v2 = if (v1 > v0) {
            (v1 - v0) / arg0.policy.renew_window_epochs
        } else {
            0
        };
        ReceiptView{
            vault_id         : 0x2::object::uid_to_inner(&arg0.id),
            blob_id          : arg0.committed_blob_id,
            end_epoch        : v1,
            cur_epoch        : v0,
            headroom_windows : v2,
            state            : arg0.state,
            escrow           : 0x2::balance::value<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&arg0.escrow),
            version          : arg0.version,
            obligation_count : arg0.obligation_count,
        }
    }

    public fun request_close(arg0: &mut EternityVault, arg1: &VaultOwnerCap, arg2: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System) {
        assert!(arg0.code_version == 2, 14);
        assert_cap(arg0, arg1);
        arg0.close_unlock_epoch = 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::epoch(arg2) + 2;
    }

    public fun state_closed() : u8 {
        2
    }

    public fun ticket_vault_id(arg0: &ObligationTicket) : 0x2::object::ID {
        arg0.vault_id
    }

    public fun unlock_obligation(arg0: &mut EternityVault, arg1: ObligationTicket) {
        assert!(arg0.code_version == 2, 14);
        let ObligationTicket { vault_id: v0 } = arg1;
        assert!(v0 == 0x2::object::uid_to_inner(&arg0.id), 18);
        assert!(arg0.obligation_count > 0, 17);
        arg0.obligation_count = arg0.obligation_count - 1;
    }

    public fun vault_id(arg0: &EternityVault) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun vault_state(arg0: &EternityVault) : u8 {
        arg0.state
    }

    public fun view_blob_id(arg0: &ReceiptView) : u256 {
        arg0.blob_id
    }

    public fun view_end_epoch(arg0: &ReceiptView) : u32 {
        arg0.end_epoch
    }

    public fun view_escrow(arg0: &ReceiptView) : u64 {
        arg0.escrow
    }

    public fun view_headroom_windows(arg0: &ReceiptView) : u32 {
        arg0.headroom_windows
    }

    public fun view_state(arg0: &ReceiptView) : u8 {
        arg0.state
    }

    public fun view_vault_id(arg0: &ReceiptView) : 0x2::object::ID {
        arg0.vault_id
    }

    public fun withdraw_surplus(arg0: &mut EternityVault, arg1: &VaultOwnerCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL> {
        assert!(arg0.code_version == 2, 14);
        assert_cap(arg0, arg1);
        let v0 = arg0.policy;
        assert!(0x2::balance::value<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&arg0.escrow) >= arg2 + 0x42d37e584c4a02465938055d26787b8c1a87bff58c709031417cdab64bb6abf5::economics::price_cap(v0.max_price_per_unit_epoch, arg0.cached_charged_units, v0.target_horizon_epochs) + v0.tip_ceiling_frost + v0.low_water_mark_frost, 13);
        0x2::coin::take<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&mut arg0.escrow, arg2, arg3)
    }

    public fun witness_blob_id(arg0: &AvailabilityWitness) : u256 {
        arg0.blob_id
    }

    public fun witness_live_through(arg0: &AvailabilityWitness) : u32 {
        arg0.live_through_epoch
    }

    public fun witness_vault_id(arg0: &AvailabilityWitness) : 0x2::object::ID {
        arg0.vault_id
    }

    public fun witness_version(arg0: &AvailabilityWitness) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v7
}

