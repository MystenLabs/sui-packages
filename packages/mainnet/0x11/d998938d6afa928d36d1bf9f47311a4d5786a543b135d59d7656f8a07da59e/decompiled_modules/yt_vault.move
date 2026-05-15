module 0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::yt_vault {
    struct YTVault<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        market_core_id: 0x2::object::ID,
        adapter_auth_type: 0x1::type_name::TypeName,
        maturity_ms: u64,
        inventory: 0x2::object_table::ObjectTable<0x2::object::ID, 0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::yt_object::YTObject>,
        inventory_ids: 0x2::linked_table::LinkedTable<0x2::object::ID, bool>,
        inventory_entry_epochs: 0x2::table::Table<0x2::object::ID, u64>,
        inventory_shares: 0x2::table::Table<0x2::object::ID, u64>,
        paused_claim_epochs: 0x2::table::Table<0x2::object::ID, vector<u64>>,
        finalized_inventory: 0x2::table::Table<0x2::object::ID, bool>,
        total_notional: u64,
        total_shares_committed: u64,
        total_shares_pending: u64,
        current_epoch: u64,
        last_collected_epoch: u64,
        last_collect_finalized: bool,
        active_collect_receipt: 0x1::option::Option<0x2::object::ID>,
        active_collect_expire_at_ms: u64,
        active_collect_sy_acc: 0x2::balance::Balance<T0>,
        epoch_yield_net: 0x2::table::Table<u64, u64>,
        epoch_shares: 0x2::table::Table<u64, u64>,
        yield_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        unallocated_yield: 0x2::balance::Balance<0x2::sui::SUI>,
        forfeited_sy: 0x2::balance::Balance<T0>,
        paused: bool,
    }

    struct VaultShare<phantom T0> has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
        yt_id: 0x2::object::ID,
        shares: u64,
        entry_epoch: u64,
    }

    struct CollectReceipt<phantom T0> has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
        epoch: u64,
        snapshot_ids: vector<0x2::object::ID>,
        next_index: u64,
        final_collect: bool,
        snapshot_shares: u64,
        yt_count: u64,
        finalized_count: u64,
        paused_ids: vector<0x2::object::ID>,
        current_index: u128,
        expire_at_ms: u64,
    }

    struct CollectReceiptRealized {
        vault_id: 0x2::object::ID,
        receipt_id: 0x2::object::ID,
        epoch: u64,
        snapshot_len: u64,
        next_index: u64,
        final_collect: bool,
        snapshot_shares: u64,
        yt_count: u64,
        finalized_count: u64,
        paused_ids: vector<0x2::object::ID>,
    }

    public fun new<T0, T1>(arg0: &0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::market_core::MarketCore<T0>, arg1: &mut 0x2::tx_context::TxContext) : YTVault<T0, T1> {
        YTVault<T0, T1>{
            id                          : 0x2::object::new(arg1),
            market_core_id              : 0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::market_core::id<T0>(arg0),
            adapter_auth_type           : 0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::market_core::adapter_auth_type<T0>(arg0),
            maturity_ms                 : 0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::market_core::maturity_ms<T0>(arg0),
            inventory                   : 0x2::object_table::new<0x2::object::ID, 0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::yt_object::YTObject>(arg1),
            inventory_ids               : 0x2::linked_table::new<0x2::object::ID, bool>(arg1),
            inventory_entry_epochs      : 0x2::table::new<0x2::object::ID, u64>(arg1),
            inventory_shares            : 0x2::table::new<0x2::object::ID, u64>(arg1),
            paused_claim_epochs         : 0x2::table::new<0x2::object::ID, vector<u64>>(arg1),
            finalized_inventory         : 0x2::table::new<0x2::object::ID, bool>(arg1),
            total_notional              : 0,
            total_shares_committed      : 0,
            total_shares_pending        : 0,
            current_epoch               : 0,
            last_collected_epoch        : 0,
            last_collect_finalized      : false,
            active_collect_receipt      : 0x1::option::none<0x2::object::ID>(),
            active_collect_expire_at_ms : 0,
            active_collect_sy_acc       : 0x2::balance::zero<T0>(),
            epoch_yield_net             : 0x2::table::new<u64, u64>(arg1),
            epoch_shares                : 0x2::table::new<u64, u64>(arg1),
            yield_balance               : 0x2::balance::zero<0x2::sui::SUI>(),
            unallocated_yield           : 0x2::balance::zero<0x2::sui::SUI>(),
            forfeited_sy                : 0x2::balance::zero<T0>(),
            paused                      : false,
        }
    }

    public fun id<T0, T1>(arg0: &YTVault<T0, T1>) : 0x2::object::ID {
        0x2::object::id<YTVault<T0, T1>>(arg0)
    }

    public fun maturity_ms<T0, T1>(arg0: &YTVault<T0, T1>) : u64 {
        arg0.maturity_ms
    }

    public fun is_paused<T0, T1>(arg0: &YTVault<T0, T1>) : bool {
        arg0.paused
    }

    public fun market_core_id<T0, T1>(arg0: &YTVault<T0, T1>) : 0x2::object::ID {
        arg0.market_core_id
    }

    public fun adapter_auth_type_ref<T0, T1>(arg0: &YTVault<T0, T1>) : &0x1::type_name::TypeName {
        &arg0.adapter_auth_type
    }

    public fun active_collect_expire_at_ms<T0, T1>(arg0: &YTVault<T0, T1>) : u64 {
        arg0.active_collect_expire_at_ms
    }

    public fun active_collect_receipt<T0, T1>(arg0: &YTVault<T0, T1>) : 0x1::option::Option<0x2::object::ID> {
        arg0.active_collect_receipt
    }

    public fun active_collect_sy_value<T0, T1>(arg0: &YTVault<T0, T1>) : u64 {
        0x2::balance::value<T0>(&arg0.active_collect_sy_acc)
    }

    fun active_receipt_id<T0, T1>(arg0: &YTVault<T0, T1>) : 0x2::object::ID {
        assert!(0x1::option::is_some<0x2::object::ID>(&arg0.active_collect_receipt), 0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::errors::e_no_active_collect());
        *0x1::option::borrow<0x2::object::ID>(&arg0.active_collect_receipt)
    }

    fun assert_active_collect_receipt<T0, T1>(arg0: &YTVault<T0, T1>, arg1: 0x2::object::ID) {
        assert!(active_receipt_id<T0, T1>(arg0) == arg1, 0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::errors::e_no_active_collect());
    }

    public fun begin_collect_yield<T0, T1, T2: drop>(arg0: &mut YTVault<T0, T1>, arg1: &0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::market_core::MarketCore<T0>, arg2: &T2, arg3: &0x2::clock::Clock, arg4: u128, arg5: &mut 0x2::tx_context::TxContext) : CollectReceipt<T0> {
        0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::auth::assert_auth<T2>(&arg0.adapter_auth_type);
        assert!(!arg0.paused, 0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::errors::e_yt_vault_paused());
        assert!(arg0.market_core_id == 0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::market_core::id<T0>(arg1), 0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::errors::e_wrong_market_core());
        0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::market_core::assert_registered_yt_vault<T0>(arg1, 0x2::object::id<YTVault<T0, T1>>(arg0));
        assert!(0x1::option::is_none<0x2::object::ID>(&arg0.active_collect_receipt), 0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::errors::e_collect_in_progress());
        assert!(!arg0.last_collect_finalized || arg0.last_collected_epoch < arg0.current_epoch, 0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::errors::e_collect_already_done_this_epoch());
        assert!(0x2::linked_table::length<0x2::object::ID, bool>(&arg0.inventory_ids) <= 0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::constants::max_inventory_snapshot(), 0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::errors::e_collect_inventory_snapshot_too_large());
        let v0 = 0x2::clock::timestamp_ms(arg3);
        CollectReceipt<T0>{
            id              : 0x2::object::new(arg5),
            vault_id        : 0x2::object::id<YTVault<T0, T1>>(arg0),
            epoch           : arg0.current_epoch,
            snapshot_ids    : snapshot_inventory_ids(&arg0.inventory_ids),
            next_index      : 0,
            final_collect   : v0 >= arg0.maturity_ms,
            snapshot_shares : arg0.total_shares_committed,
            yt_count        : 0,
            finalized_count : 0,
            paused_ids      : 0x1::vector::empty<0x2::object::ID>(),
            current_index   : arg4,
            expire_at_ms    : v0 + 0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::constants::collect_receipt_ttl_ms(),
        }
    }

    fun bounded_end_epoch(arg0: u64, arg1: u64, arg2: u64) : u64 {
        if (arg0 >= arg1) {
            return arg0
        };
        if (arg1 - arg0 <= arg2) {
            arg1
        } else {
            arg0 + arg2
        }
    }

    fun can_record_paused_claim_epoch<T0, T1>(arg0: &YTVault<T0, T1>, arg1: 0x2::object::ID, arg2: u64) : bool {
        if (!0x2::table::contains<0x2::object::ID, vector<u64>>(&arg0.paused_claim_epochs, arg1)) {
            return true
        };
        let v0 = 0x2::table::borrow<0x2::object::ID, vector<u64>>(&arg0.paused_claim_epochs, arg1);
        vector_contains_u64(v0, arg2) || 0x1::vector::length<u64>(v0) < 1024
    }

    fun can_record_paused_claim_epochs<T0, T1>(arg0: &YTVault<T0, T1>, arg1: &vector<0x2::object::ID>, arg2: u64) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x2::object::ID>(arg1)) {
            if (!can_record_paused_claim_epoch<T0, T1>(arg0, *0x1::vector::borrow<0x2::object::ID>(arg1, v0), arg2)) {
                return false
            };
            v0 = v0 + 1;
        };
        true
    }

    public fun cancel_collect_due_to_adapter_pause<T0, T1, T2: drop>(arg0: CollectReceipt<T0>, arg1: &mut YTVault<T0, T1>, arg2: &T2, arg3: &0x2::clock::Clock) {
        0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::auth::assert_auth<T2>(&arg1.adapter_auth_type);
        let v0 = 0x1::option::is_some<0x2::object::ID>(&arg1.active_collect_receipt);
        if (v0) {
            assert_active_collect_receipt<T0, T1>(arg1, 0x2::object::id<CollectReceipt<T0>>(&arg0));
        };
        let CollectReceipt {
            id              : v1,
            vault_id        : v2,
            epoch           : v3,
            snapshot_ids    : _,
            next_index      : v5,
            final_collect   : _,
            snapshot_shares : _,
            yt_count        : v8,
            finalized_count : _,
            paused_ids      : _,
            current_index   : _,
            expire_at_ms    : _,
        } = arg0;
        let v13 = v1;
        assert!(v2 == 0x2::object::id<YTVault<T0, T1>>(arg1), 0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::errors::e_wrong_market_core());
        assert!(v5 == 0 && v8 == 0, 0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::errors::e_collect_progress_started());
        assert!(0x2::balance::value<T0>(&arg1.active_collect_sy_acc) == 0, 0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::errors::e_collect_progress_started());
        let v14 = 0x2::balance::withdraw_all<T0>(&mut arg1.active_collect_sy_acc);
        0x2::balance::join<T0>(&mut arg1.forfeited_sy, v14);
        0x2::object::delete(v13);
        if (v0) {
            0x1::option::extract<0x2::object::ID>(&mut arg1.active_collect_receipt);
            arg1.active_collect_expire_at_ms = 0;
        };
        0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::events::emit_collect_cancelled(v2, 0x2::object::uid_to_inner(&v13), v3, v8, 0x2::balance::value<T0>(&v14), 0x2::clock::timestamp_ms(arg3), true);
    }

    public fun cancel_collect_yield<T0, T1, T2: drop>(arg0: CollectReceipt<T0>, arg1: &mut YTVault<T0, T1>, arg2: &T2, arg3: &0x2::clock::Clock) {
        0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::auth::assert_auth<T2>(&arg1.adapter_auth_type);
        let v0 = 0x1::option::is_some<0x2::object::ID>(&arg1.active_collect_receipt);
        if (v0) {
            assert_active_collect_receipt<T0, T1>(arg1, 0x2::object::id<CollectReceipt<T0>>(&arg0));
        };
        let CollectReceipt {
            id              : v1,
            vault_id        : v2,
            epoch           : v3,
            snapshot_ids    : _,
            next_index      : v5,
            final_collect   : _,
            snapshot_shares : _,
            yt_count        : v8,
            finalized_count : _,
            paused_ids      : _,
            current_index   : _,
            expire_at_ms    : _,
        } = arg0;
        let v13 = v1;
        assert!(v2 == 0x2::object::id<YTVault<T0, T1>>(arg1), 0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::errors::e_wrong_market_core());
        assert!(v5 == 0 && v8 == 0, 0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::errors::e_collect_progress_started());
        assert!(0x2::balance::value<T0>(&arg1.active_collect_sy_acc) == 0, 0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::errors::e_collect_progress_started());
        let v14 = 0x2::balance::withdraw_all<T0>(&mut arg1.active_collect_sy_acc);
        0x2::balance::destroy_zero<T0>(v14);
        0x2::object::delete(v13);
        if (v0) {
            0x1::option::extract<0x2::object::ID>(&mut arg1.active_collect_receipt);
            arg1.active_collect_expire_at_ms = 0;
        };
        0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::events::emit_collect_cancelled(v2, 0x2::object::uid_to_inner(&v13), v3, v8, 0x2::balance::value<T0>(&v14), 0x2::clock::timestamp_ms(arg3), false);
    }

    public fun claim_vault_yield<T0, T1>(arg0: &mut YTVault<T0, T1>, arg1: &mut VaultShare<T1>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        claim_vault_yield_chunk<T0, T1>(arg0, arg1, 64, arg2)
    }

    public fun claim_vault_yield_chunk<T0, T1>(arg0: &mut YTVault<T0, T1>, arg1: &mut VaultShare<T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(arg2 > 0, 0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::errors::e_epoch_overflow());
        assert!(arg2 <= 64, 0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::errors::e_epoch_overflow());
        assert!(arg1.vault_id == 0x2::object::id<YTVault<T0, T1>>(arg0), 0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::errors::e_wrong_market_core());
        assert!(0x2::linked_table::contains<0x2::object::ID, bool>(&arg0.inventory_ids, arg1.yt_id), 0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::errors::e_wrong_escrow());
        let v0 = arg1.entry_epoch;
        let v1 = bounded_end_epoch(v0, arg0.current_epoch, arg2);
        let v2 = sum_epoch_yields<T0, T1>(arg0, arg1.yt_id, arg1.shares, v0, v1);
        arg1.entry_epoch = v1;
        prune_paused_claim_epochs<T0, T1>(arg0, arg1.yt_id, v1);
        let v3 = if (v2 > 0) {
            0x2::balance::split<0x2::sui::SUI>(&mut arg0.yield_balance, v2)
        } else {
            0x2::balance::zero<0x2::sui::SUI>()
        };
        let v4 = if (v1 > v0) {
            v1 - v0
        } else {
            0
        };
        0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::events::emit_vault_yield_claimed(0x2::object::id<YTVault<T0, T1>>(arg0), 0x2::tx_context::sender(arg3), v0, v1, v4, v2);
        0x2::coin::from_balance<0x2::sui::SUI>(v3, arg3)
    }

    public fun collect_step<T0, T1, T2: drop>(arg0: &mut CollectReceipt<T0>, arg1: &mut YTVault<T0, T1>, arg2: &mut 0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::market_core::MarketCore<T0>, arg3: &mut 0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::split_escrow::SplitEscrow<T0>, arg4: 0x2::object::ID, arg5: &T2, arg6: &0x2::clock::Clock) {
        0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::auth::assert_auth<T2>(&arg1.adapter_auth_type);
        assert!(arg0.vault_id == 0x2::object::id<YTVault<T0, T1>>(arg1), 0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::errors::e_wrong_market_core());
        ensure_active_collect_receipt<T0, T1>(arg1, 0x2::object::id<CollectReceipt<T0>>(arg0), arg0.expire_at_ms);
        assert!(arg1.market_core_id == 0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::market_core::id<T0>(arg2), 0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::errors::e_wrong_market_core());
        0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::market_core::assert_registered_yt_vault<T0>(arg2, 0x2::object::id<YTVault<T0, T1>>(arg1));
        assert!(arg0.epoch == arg1.current_epoch, 0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::errors::e_collect_epoch_mismatch());
        assert!(0x2::clock::timestamp_ms(arg6) < arg0.expire_at_ms, 0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::errors::e_collect_receipt_expired());
        assert!(arg0.next_index < 0x1::vector::length<0x2::object::ID>(&arg0.snapshot_ids), 0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::errors::e_insufficient_inventory());
        assert!(*0x1::vector::borrow<0x2::object::ID>(&arg0.snapshot_ids, arg0.next_index) == arg4, 0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::errors::e_collect_inventory_incomplete());
        assert!(0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::yt_object::escrow_id(0x2::object_table::borrow<0x2::object::ID, 0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::yt_object::YTObject>(&arg1.inventory, arg4)) == 0x2::object::id<0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::split_escrow::SplitEscrow<T0>>(arg3), 0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::errors::e_wrong_escrow());
        let v0 = *0x2::table::borrow<0x2::object::ID, u64>(&arg1.inventory_shares, arg4);
        if (0x2::table::contains<0x2::object::ID, bool>(&arg1.finalized_inventory, arg4)) {
            assert!(v0 <= arg0.snapshot_shares, 0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::errors::e_underflow());
            arg0.snapshot_shares = arg0.snapshot_shares - v0;
            arg0.next_index = arg0.next_index + 1;
            return
        };
        if (*0x2::table::borrow<0x2::object::ID, u64>(&arg1.inventory_entry_epochs, arg4) > arg1.current_epoch) {
            arg0.next_index = arg0.next_index + 1;
            return
        };
        if (0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::split_escrow::is_paused<T0>(arg3)) {
            assert!(v0 <= arg0.snapshot_shares, 0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::errors::e_underflow());
            arg0.snapshot_shares = arg0.snapshot_shares - v0;
            0x1::vector::push_back<0x2::object::ID>(&mut arg0.paused_ids, arg4);
            arg0.next_index = arg0.next_index + 1;
            return
        };
        if (0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::split_escrow::is_yt_consumed<T0>(arg3)) {
            record_finalized_inventory<T0, T1>(arg1, arg4);
            arg0.finalized_count = arg0.finalized_count + 1;
            arg0.next_index = arg0.next_index + 1;
            return
        };
        let v1 = 0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::split_escrow::is_pt_consumed<T0>(arg3);
        let v2 = if (v1) {
            0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::split_escrow::drain_yt_after_pt_closed<T0, T2>(arg3, arg2, arg5)
        } else {
            let (v3, _, _, _) = 0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::split_escrow::yield_out_into_balance<T0>(0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::split_escrow::realize_yield_capped<T0, T2>(arg3, arg2, arg5, arg0.current_index, arg6));
            v3
        };
        0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::yt_object::set_yield_debt<T0, T2>(0x2::object_table::borrow_mut<0x2::object::ID, 0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::yt_object::YTObject>(&mut arg1.inventory, arg4), arg2, arg5, arg0.current_index);
        if (arg0.final_collect && !v1) {
            0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::split_escrow::mark_yt_consumed<T0>(arg3);
        };
        if (arg0.final_collect || v1) {
            record_finalized_inventory<T0, T1>(arg1, arg4);
            arg0.finalized_count = arg0.finalized_count + 1;
        };
        0x2::balance::join<T0>(&mut arg1.active_collect_sy_acc, v2);
        arg0.yt_count = arg0.yt_count + 1;
        arg0.next_index = arg0.next_index + 1;
    }

    public fun current_epoch<T0, T1>(arg0: &YTVault<T0, T1>) : u64 {
        arg0.current_epoch
    }

    public fun deposit_yt_primitive<T0, T1, T2: drop>(arg0: 0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::yt_object::YTObject, arg1: &0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::split_escrow::SplitEscrow<T0>, arg2: &mut YTVault<T0, T1>, arg3: &0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::market_core::MarketCore<T0>, arg4: u64, arg5: u64, arg6: &T2, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : VaultShare<T1> {
        0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::auth::assert_auth<T2>(&arg2.adapter_auth_type);
        assert!(!arg2.paused, 0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::errors::e_yt_vault_paused());
        assert!(arg2.market_core_id == 0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::market_core::id<T0>(arg3), 0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::errors::e_wrong_market_core());
        0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::market_core::assert_registered_yt_vault<T0>(arg3, 0x2::object::id<YTVault<T0, T1>>(arg2));
        assert!(0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::split_escrow::market_core_id<T0>(arg1) == 0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::market_core::id<T0>(arg3), 0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::errors::e_wrong_market_core());
        assert!(0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::yt_object::escrow_id(&arg0) == 0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::split_escrow::id<T0>(arg1), 0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::errors::e_wrong_escrow());
        assert!(!0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::split_escrow::is_pt_consumed<T0>(arg1), 0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::errors::e_pt_already_consumed_use_drain());
        assert!(!0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::split_escrow::is_paused<T0>(arg1), 0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::errors::e_escrow_paused());
        assert!(!0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::split_escrow::is_yt_consumed<T0>(arg1), 0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::errors::e_already_consumed());
        0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::market_core::assert_entry_open<T0>(arg3, 0x2::clock::timestamp_ms(arg7));
        assert!(0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::yt_object::market_core_id(&arg0) == 0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::market_core::id<T0>(arg3), 0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::errors::e_wrong_market());
        0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::auth::assert_auth_match(&arg2.adapter_auth_type, 0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::yt_object::adapter_auth_type_ref(&arg0));
        assert!(0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::yt_object::maturity_ms(&arg0) == arg2.maturity_ms, 0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::errors::e_wrong_market());
        assert!(0x2::linked_table::length<0x2::object::ID, bool>(&arg2.inventory_ids) < 0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::constants::max_inventory_snapshot(), 0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::errors::e_yt_inventory_full());
        let v0 = 0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::yt_object::notional(&arg0);
        assert!(v0 > 0, 0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::errors::e_zero_amount());
        let v1 = 0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::split_escrow::remaining_extractable_sy<T0>(arg1);
        assert!(v1 > 0, 0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::errors::e_hard_cap_breached());
        let v2 = arg2.current_epoch + 1;
        let v3 = 0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::yt_object::id(&arg0);
        let v4 = VaultShare<T1>{
            id          : 0x2::object::new(arg8),
            vault_id    : 0x2::object::id<YTVault<T0, T1>>(arg2),
            yt_id       : v3,
            shares      : v1,
            entry_epoch : v2,
        };
        0x2::object_table::add<0x2::object::ID, 0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::yt_object::YTObject>(&mut arg2.inventory, v3, arg0);
        0x2::linked_table::push_back<0x2::object::ID, bool>(&mut arg2.inventory_ids, v3, true);
        0x2::table::add<0x2::object::ID, u64>(&mut arg2.inventory_entry_epochs, v3, v2);
        0x2::table::add<0x2::object::ID, u64>(&mut arg2.inventory_shares, v3, v1);
        arg2.total_notional = arg2.total_notional + v0;
        arg2.total_shares_pending = arg2.total_shares_pending + v1;
        0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::events::emit_vault_deposit(0x2::object::id<YTVault<T0, T1>>(arg2), v3, v0, arg4, v1, v2, arg5);
        v4
    }

    fun destroy_id_vector(arg0: vector<0x2::object::ID>) {
        while (!0x1::vector::is_empty<0x2::object::ID>(&arg0)) {
            0x1::vector::pop_back<0x2::object::ID>(&mut arg0);
        };
        0x1::vector::destroy_empty<0x2::object::ID>(arg0);
    }

    public fun destroy_stale_receipt<T0, T1>(arg0: CollectReceipt<T0>, arg1: &YTVault<T0, T1>) {
        assert!(arg0.vault_id == 0x2::object::id<YTVault<T0, T1>>(arg1), 0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::errors::e_wrong_market_core());
        if (0x1::option::is_some<0x2::object::ID>(&arg1.active_collect_receipt)) {
            assert!(*0x1::option::borrow<0x2::object::ID>(&arg1.active_collect_receipt) != 0x2::object::id<CollectReceipt<T0>>(&arg0), 0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::errors::e_collect_in_progress());
        };
        let CollectReceipt {
            id              : v0,
            vault_id        : _,
            epoch           : _,
            snapshot_ids    : _,
            next_index      : _,
            final_collect   : _,
            snapshot_shares : _,
            yt_count        : _,
            finalized_count : _,
            paused_ids      : _,
            current_index   : _,
            expire_at_ms    : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    fun ensure_active_collect_receipt<T0, T1>(arg0: &mut YTVault<T0, T1>, arg1: 0x2::object::ID, arg2: u64) {
        if (0x1::option::is_some<0x2::object::ID>(&arg0.active_collect_receipt)) {
            assert!(active_receipt_id<T0, T1>(arg0) == arg1, 0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::errors::e_no_active_collect());
        } else {
            0x1::option::fill<0x2::object::ID>(&mut arg0.active_collect_receipt, arg1);
            arg0.active_collect_expire_at_ms = arg2;
        };
    }

    public fun epoch_shares_at<T0, T1>(arg0: &YTVault<T0, T1>, arg1: u64) : u64 {
        if (0x2::table::contains<u64, u64>(&arg0.epoch_shares, arg1)) {
            *0x2::table::borrow<u64, u64>(&arg0.epoch_shares, arg1)
        } else {
            0
        }
    }

    public fun epoch_yield_net_at<T0, T1>(arg0: &YTVault<T0, T1>, arg1: u64) : u64 {
        if (0x2::table::contains<u64, u64>(&arg0.epoch_yield_net, arg1)) {
            *0x2::table::borrow<u64, u64>(&arg0.epoch_yield_net, arg1)
        } else {
            0
        }
    }

    public fun finalize_collect_yield<T0, T1, T2: drop>(arg0: CollectReceiptRealized, arg1: 0x2::balance::Balance<0x2::sui::SUI>, arg2: u64, arg3: &mut YTVault<T0, T1>, arg4: &T2) {
        let CollectReceiptRealized {
            vault_id        : v0,
            receipt_id      : v1,
            epoch           : v2,
            snapshot_len    : v3,
            next_index      : v4,
            final_collect   : _,
            snapshot_shares : v6,
            yt_count        : v7,
            finalized_count : v8,
            paused_ids      : v9,
        } = arg0;
        let v10 = v9;
        0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::auth::assert_auth<T2>(&arg3.adapter_auth_type);
        assert!(v0 == 0x2::object::id<YTVault<T0, T1>>(arg3), 0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::errors::e_wrong_market_core());
        assert!(v2 == arg3.current_epoch, 0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::errors::e_collect_epoch_mismatch());
        assert!(v4 == v3, 0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::errors::e_collect_inventory_incomplete());
        assert_active_collect_receipt<T0, T1>(arg3, v1);
        let v11 = 0x2::balance::value<0x2::sui::SUI>(&arg1);
        let v12 = !can_record_paused_claim_epochs<T0, T1>(arg3, &v10, v2);
        let v13 = if (v11 > 0) {
            if (v6 > 0) {
                v7 > 0
            } else {
                false
            }
        } else {
            false
        };
        let v14 = if (v13) {
            true
        } else if (arg3.total_shares_pending > 0) {
            true
        } else if (v8 > 0) {
            true
        } else {
            v12
        };
        assert!(v14, 0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::errors::e_collect_no_work());
        if (v12) {
            destroy_id_vector(v10);
        } else {
            record_paused_claim_epochs<T0, T1>(arg3, v10, v2);
        };
        let v15 = if (v12 || v6 == 0) {
            if (v11 > 0) {
                0x2::balance::join<0x2::sui::SUI>(&mut arg3.unallocated_yield, arg1);
                0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::events::emit_unallocated_yield_parked(v0, v2, v11);
            } else {
                0x2::balance::destroy_zero<0x2::sui::SUI>(arg1);
            };
            0
        } else {
            0x2::balance::join<0x2::sui::SUI>(&mut arg3.yield_balance, arg1);
            v11
        };
        let v16 = if (v12) {
            0
        } else {
            v6
        };
        0x2::table::add<u64, u64>(&mut arg3.epoch_yield_net, v2, v15);
        0x2::table::add<u64, u64>(&mut arg3.epoch_shares, v2, v16);
        arg3.total_shares_committed = arg3.total_shares_committed + arg3.total_shares_pending;
        arg3.total_shares_pending = 0;
        arg3.last_collected_epoch = v2;
        arg3.last_collect_finalized = true;
        arg3.current_epoch = v2 + 1;
        0x1::option::extract<0x2::object::ID>(&mut arg3.active_collect_receipt);
        arg3.active_collect_expire_at_ms = 0;
        0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::events::emit_vault_collect(v0, v2, v7, v15, arg2, v6);
    }

    public fun finalize_paused_yt<T0, T1>(arg0: &mut YTVault<T0, T1>, arg1: &mut 0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::split_escrow::SplitEscrow<T0>, arg2: &0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::market_core::MarketCore<T0>, arg3: 0x2::object::ID, arg4: &0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::caps::MarketAdminCap, arg5: 0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::timelock::TimelockReceipt, arg6: &0x2::clock::Clock) {
        let v0 = 0x2::object::id<YTVault<T0, T1>>(arg0);
        let v1 = 0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::split_escrow::id<T0>(arg1);
        0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::timelock::consume_receipt_with_payload(arg5, 0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::timelock::action_finalize_paused_yt(), v1, finalize_paused_yt_payload_hash(v0, arg3), arg6);
        assert!(arg0.market_core_id == 0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::market_core::id<T0>(arg2), 0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::errors::e_wrong_market_core());
        0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::market_core::assert_registered_yt_vault<T0>(arg2, v0);
        assert!(0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::split_escrow::market_core_id<T0>(arg1) == 0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::market_core::id<T0>(arg2), 0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::errors::e_wrong_market_core());
        assert!(0x2::linked_table::contains<0x2::object::ID, bool>(&arg0.inventory_ids, arg3), 0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::errors::e_wrong_escrow());
        assert!(!0x2::table::contains<0x2::object::ID, bool>(&arg0.finalized_inventory, arg3), 0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::errors::e_already_consumed());
        assert!(0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::yt_object::escrow_id(0x2::object_table::borrow<0x2::object::ID, 0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::yt_object::YTObject>(&arg0.inventory, arg3)) == v1, 0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::errors::e_wrong_escrow());
        let v2 = 0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::split_escrow::force_finalize_paused_yt<T0>(arg1);
        0x2::balance::join<T0>(&mut arg0.forfeited_sy, v2);
        record_finalized_inventory<T0, T1>(arg0, arg3);
        0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::events::emit_paused_yt_finalized(v0, v1, arg3, 0x2::balance::value<T0>(&v2), 0x2::clock::timestamp_ms(arg6));
    }

    public fun finalize_paused_yt_payload_hash(arg0: 0x2::object::ID, arg1: 0x2::object::ID) : vector<u8> {
        let v0 = b"nemo:finalize_paused_yt:v1";
        0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::timelock::append_bcs<0x2::object::ID>(&mut v0, &arg0);
        0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::timelock::append_bcs<0x2::object::ID>(&mut v0, &arg1);
        0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::timelock::hash_payload(v0)
    }

    public fun force_cancel_expired_collect_yield<T0, T1>(arg0: &mut YTVault<T0, T1>, arg1: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        assert!(v0 >= arg0.active_collect_expire_at_ms, 0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::errors::e_collect_receipt_not_expired());
        let v1 = 0x2::balance::withdraw_all<T0>(&mut arg0.active_collect_sy_acc);
        0x2::balance::join<T0>(&mut arg0.forfeited_sy, v1);
        0x1::option::extract<0x2::object::ID>(&mut arg0.active_collect_receipt);
        arg0.active_collect_expire_at_ms = 0;
        0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::events::emit_collect_cancelled(0x2::object::id<YTVault<T0, T1>>(arg0), active_receipt_id<T0, T1>(arg0), arg0.current_epoch, 0, 0x2::balance::value<T0>(&v1), v0, true);
    }

    public fun forfeited_sy_value<T0, T1>(arg0: &YTVault<T0, T1>) : u64 {
        0x2::balance::value<T0>(&arg0.forfeited_sy)
    }

    public fun inventory_contains<T0, T1>(arg0: &YTVault<T0, T1>, arg1: 0x2::object::ID) : bool {
        0x2::linked_table::contains<0x2::object::ID, bool>(&arg0.inventory_ids, arg1)
    }

    public fun inventory_len<T0, T1>(arg0: &YTVault<T0, T1>) : u64 {
        0x2::linked_table::length<0x2::object::ID, bool>(&arg0.inventory_ids)
    }

    fun is_paused_claim_epoch<T0, T1>(arg0: &YTVault<T0, T1>, arg1: 0x2::object::ID, arg2: u64) : bool {
        if (!0x2::table::contains<0x2::object::ID, vector<u64>>(&arg0.paused_claim_epochs, arg1)) {
            return false
        };
        vector_contains_u64(0x2::table::borrow<0x2::object::ID, vector<u64>>(&arg0.paused_claim_epochs, arg1), arg2)
    }

    public fun last_collect_finalized<T0, T1>(arg0: &YTVault<T0, T1>) : bool {
        arg0.last_collect_finalized
    }

    public fun last_collected_epoch<T0, T1>(arg0: &YTVault<T0, T1>) : u64 {
        arg0.last_collected_epoch
    }

    public fun max_epochs_per_claim() : u64 {
        64
    }

    public fun max_paused_claim_epochs() : u64 {
        1024
    }

    public fun pause<T0, T1>(arg0: &mut YTVault<T0, T1>, arg1: &0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::caps::PauseCap, arg2: vector<u8>) {
        arg0.paused = true;
        0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::events::emit_paused(4, 0x2::object::id<YTVault<T0, T1>>(arg0), 0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::pause_state::lock_global(), 0, arg2);
    }

    fun prune_paused_claim_epochs<T0, T1>(arg0: &mut YTVault<T0, T1>, arg1: 0x2::object::ID, arg2: u64) {
        if (!0x2::table::contains<0x2::object::ID, vector<u64>>(&arg0.paused_claim_epochs, arg1)) {
            return
        };
        let v0 = 0x2::table::remove<0x2::object::ID, vector<u64>>(&mut arg0.paused_claim_epochs, arg1);
        let v1 = 0x1::vector::empty<u64>();
        while (!0x1::vector::is_empty<u64>(&v0)) {
            let v2 = 0x1::vector::pop_back<u64>(&mut v0);
            if (v2 >= arg2) {
                0x1::vector::push_back<u64>(&mut v1, v2);
            };
        };
        0x1::vector::destroy_empty<u64>(v0);
        if (0x1::vector::is_empty<u64>(&v1)) {
            0x1::vector::destroy_empty<u64>(v1);
        } else {
            0x2::table::add<0x2::object::ID, vector<u64>>(&mut arg0.paused_claim_epochs, arg1, v1);
        };
    }

    public fun receipt_epoch<T0>(arg0: &CollectReceipt<T0>) : u64 {
        arg0.epoch
    }

    public fun receipt_expire_at_ms<T0>(arg0: &CollectReceipt<T0>) : u64 {
        arg0.expire_at_ms
    }

    public fun receipt_id<T0>(arg0: &CollectReceipt<T0>) : 0x2::object::ID {
        0x2::object::id<CollectReceipt<T0>>(arg0)
    }

    public fun receipt_next_index<T0>(arg0: &CollectReceipt<T0>) : u64 {
        arg0.next_index
    }

    public fun receipt_snapshot_len<T0>(arg0: &CollectReceipt<T0>) : u64 {
        0x1::vector::length<0x2::object::ID>(&arg0.snapshot_ids)
    }

    public fun receipt_vault_id<T0>(arg0: &CollectReceipt<T0>) : 0x2::object::ID {
        arg0.vault_id
    }

    public fun receipt_yt_count<T0>(arg0: &CollectReceipt<T0>) : u64 {
        arg0.yt_count
    }

    fun record_finalized_inventory<T0, T1>(arg0: &mut YTVault<T0, T1>, arg1: 0x2::object::ID) {
        if (!0x2::table::contains<0x2::object::ID, bool>(&arg0.finalized_inventory, arg1)) {
            0x2::table::add<0x2::object::ID, bool>(&mut arg0.finalized_inventory, arg1, true);
        };
    }

    fun record_paused_claim_epoch<T0, T1>(arg0: &mut YTVault<T0, T1>, arg1: 0x2::object::ID, arg2: u64) {
        if (0x2::table::contains<0x2::object::ID, vector<u64>>(&arg0.paused_claim_epochs, arg1)) {
            let v0 = 0x2::table::borrow_mut<0x2::object::ID, vector<u64>>(&mut arg0.paused_claim_epochs, arg1);
            if (!vector_contains_u64(v0, arg2)) {
                assert!(0x1::vector::length<u64>(v0) < 1024, 0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::errors::e_epoch_overflow());
                0x1::vector::push_back<u64>(v0, arg2);
            };
        } else {
            let v1 = 0x1::vector::empty<u64>();
            0x1::vector::push_back<u64>(&mut v1, arg2);
            0x2::table::add<0x2::object::ID, vector<u64>>(&mut arg0.paused_claim_epochs, arg1, v1);
        };
    }

    fun record_paused_claim_epochs<T0, T1>(arg0: &mut YTVault<T0, T1>, arg1: vector<0x2::object::ID>, arg2: u64) {
        while (!0x1::vector::is_empty<0x2::object::ID>(&arg1)) {
            record_paused_claim_epoch<T0, T1>(arg0, 0x1::vector::pop_back<0x2::object::ID>(&mut arg1), arg2);
        };
    }

    public fun redeem_vault_share<T0, T1>(arg0: &mut YTVault<T0, T1>, arg1: VaultShare<T1>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(0x1::option::is_none<0x2::object::ID>(&arg0.active_collect_receipt), 0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::errors::e_collect_in_progress());
        let VaultShare {
            id          : v0,
            vault_id    : v1,
            yt_id       : v2,
            shares      : v3,
            entry_epoch : v4,
        } = arg1;
        assert!(v1 == 0x2::object::id<YTVault<T0, T1>>(arg0), 0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::errors::e_wrong_market_core());
        0x2::object::delete(v0);
        let v5 = arg0.current_epoch;
        assert!(v4 >= v5 || bounded_end_epoch(v4, v5, 64) == v5, 0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::errors::e_claim_required_before_redeem());
        assert!(0x2::table::contains<0x2::object::ID, bool>(&arg0.finalized_inventory, v2), 0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::errors::e_final_collect_required_before_redeem());
        let v6 = sum_epoch_yields<T0, T1>(arg0, v2, v3, v4, v5);
        assert!(v3 <= arg0.total_shares_committed, 0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::errors::e_no_shares());
        arg0.total_shares_committed = arg0.total_shares_committed - v3;
        0x2::linked_table::remove<0x2::object::ID, bool>(&mut arg0.inventory_ids, v2);
        let v7 = 0x2::object_table::remove<0x2::object::ID, 0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::yt_object::YTObject>(&mut arg0.inventory, v2);
        let v8 = 0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::yt_object::notional(&v7);
        assert!(0x2::table::remove<0x2::object::ID, u64>(&mut arg0.inventory_shares, v2) == v3, 0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::errors::e_wrong_escrow());
        assert!(v8 <= arg0.total_notional, 0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::errors::e_underflow());
        arg0.total_notional = arg0.total_notional - v8;
        0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::yt_object::destroy_for_base(v7);
        0x2::table::remove<0x2::object::ID, u64>(&mut arg0.inventory_entry_epochs, v2);
        if (0x2::table::contains<0x2::object::ID, vector<u64>>(&arg0.paused_claim_epochs, v2)) {
            0x2::table::remove<0x2::object::ID, vector<u64>>(&mut arg0.paused_claim_epochs, v2);
        };
        0x2::table::remove<0x2::object::ID, bool>(&mut arg0.finalized_inventory, v2);
        let v9 = if (v6 > 0) {
            0x2::balance::split<0x2::sui::SUI>(&mut arg0.yield_balance, v6)
        } else {
            0x2::balance::zero<0x2::sui::SUI>()
        };
        let v10 = if (v5 > v4) {
            v5 - v4
        } else {
            0
        };
        0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::events::emit_vault_share_redeemed(0x2::object::id<YTVault<T0, T1>>(arg0), 0x2::tx_context::sender(arg2), v3, v4, v10, v6);
        0x2::coin::from_balance<0x2::sui::SUI>(v9, arg2)
    }

    public fun scope_yt_vault() : u8 {
        4
    }

    public fun share<T0, T1>(arg0: YTVault<T0, T1>) {
        0x2::transfer::share_object<YTVault<T0, T1>>(arg0);
    }

    public fun share_entry_epoch<T0>(arg0: &VaultShare<T0>) : u64 {
        arg0.entry_epoch
    }

    public fun share_id<T0>(arg0: &VaultShare<T0>) : 0x2::object::ID {
        0x2::object::id<VaultShare<T0>>(arg0)
    }

    public fun share_value<T0>(arg0: &VaultShare<T0>) : u64 {
        arg0.shares
    }

    public fun share_vault_id<T0>(arg0: &VaultShare<T0>) : 0x2::object::ID {
        arg0.vault_id
    }

    public fun share_yt_id<T0>(arg0: &VaultShare<T0>) : 0x2::object::ID {
        arg0.yt_id
    }

    fun snapshot_inventory_ids(arg0: &0x2::linked_table::LinkedTable<0x2::object::ID, bool>) : vector<0x2::object::ID> {
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        let v1 = *0x2::linked_table::front<0x2::object::ID, bool>(arg0);
        while (0x1::option::is_some<0x2::object::ID>(&v1)) {
            let v2 = *0x1::option::borrow<0x2::object::ID>(&v1);
            0x1::vector::push_back<0x2::object::ID>(&mut v0, v2);
            v1 = *0x2::linked_table::next<0x2::object::ID, bool>(arg0, v2);
        };
        v0
    }

    fun sum_epoch_yields<T0, T1>(arg0: &YTVault<T0, T1>, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: u64) : u64 {
        if (arg2 == 0 || arg3 >= arg4) {
            return 0
        };
        let v0 = 0;
        while (arg3 < arg4) {
            let v1 = if (!is_paused_claim_epoch<T0, T1>(arg0, arg1, arg3)) {
                if (0x2::table::contains<u64, u64>(&arg0.epoch_yield_net, arg3)) {
                    0x2::table::contains<u64, u64>(&arg0.epoch_shares, arg3)
                } else {
                    false
                }
            } else {
                false
            };
            if (v1) {
                let v2 = *0x2::table::borrow<u64, u64>(&arg0.epoch_shares, arg3);
                if (v2 > 0) {
                    v0 = v0 + 0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::math_ext::mul_div_down_u128((arg2 as u128), (*0x2::table::borrow<u64, u64>(&arg0.epoch_yield_net, arg3) as u128), (v2 as u128));
                };
            };
            arg3 = arg3 + 1;
        };
        assert!(v0 <= 18446744073709551615, 0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::errors::e_overflow());
        (v0 as u64)
    }

    public fun take_collect_sy<T0, T1, T2: drop>(arg0: CollectReceipt<T0>, arg1: &mut YTVault<T0, T1>, arg2: &T2) : (CollectReceiptRealized, 0x2::balance::Balance<T0>) {
        let v0 = 0x2::object::id<CollectReceipt<T0>>(&arg0);
        0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::auth::assert_auth<T2>(&arg1.adapter_auth_type);
        assert!(arg0.vault_id == 0x2::object::id<YTVault<T0, T1>>(arg1), 0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::errors::e_wrong_market_core());
        if (0x1::option::is_some<0x2::object::ID>(&arg1.active_collect_receipt)) {
            assert_active_collect_receipt<T0, T1>(arg1, v0);
        } else {
            assert!(0x1::vector::length<0x2::object::ID>(&arg0.snapshot_ids) == 0 && arg0.next_index == 0, 0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::errors::e_no_active_collect());
            0x1::option::fill<0x2::object::ID>(&mut arg1.active_collect_receipt, v0);
            arg1.active_collect_expire_at_ms = arg0.expire_at_ms;
        };
        let CollectReceipt {
            id              : v1,
            vault_id        : v2,
            epoch           : v3,
            snapshot_ids    : v4,
            next_index      : v5,
            final_collect   : v6,
            snapshot_shares : v7,
            yt_count        : v8,
            finalized_count : v9,
            paused_ids      : v10,
            current_index   : _,
            expire_at_ms    : _,
        } = arg0;
        let v13 = v4;
        let v14 = 0x1::vector::length<0x2::object::ID>(&v13);
        assert!(v5 == v14, 0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::errors::e_collect_inventory_incomplete());
        0x2::object::delete(v1);
        let v15 = CollectReceiptRealized{
            vault_id        : v2,
            receipt_id      : v0,
            epoch           : v3,
            snapshot_len    : v14,
            next_index      : v5,
            final_collect   : v6,
            snapshot_shares : v7,
            yt_count        : v8,
            finalized_count : v9,
            paused_ids      : v10,
        };
        (v15, 0x2::balance::withdraw_all<T0>(&mut arg1.active_collect_sy_acc))
    }

    public fun total_notional<T0, T1>(arg0: &YTVault<T0, T1>) : u64 {
        arg0.total_notional
    }

    public fun total_shares<T0, T1>(arg0: &YTVault<T0, T1>) : u64 {
        arg0.total_shares_committed + arg0.total_shares_pending
    }

    public fun total_shares_committed<T0, T1>(arg0: &YTVault<T0, T1>) : u64 {
        arg0.total_shares_committed
    }

    public fun total_shares_pending<T0, T1>(arg0: &YTVault<T0, T1>) : u64 {
        arg0.total_shares_pending
    }

    public fun unallocated_yield_value<T0, T1>(arg0: &YTVault<T0, T1>) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.unallocated_yield)
    }

    public fun unpause<T0, T1>(arg0: &mut YTVault<T0, T1>, arg1: &0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::caps::MarketAdminCap, arg2: 0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::timelock::TimelockReceipt, arg3: &0x2::clock::Clock) {
        0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::timelock::consume_receipt(arg2, 0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::timelock::action_unpause_yt_vault(), 0x2::object::id<YTVault<T0, T1>>(arg0), arg3);
        arg0.paused = false;
        0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::events::emit_unpaused(4, 0x2::object::id<YTVault<T0, T1>>(arg0));
    }

    fun vector_contains_u64(arg0: &vector<u64>, arg1: u64) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u64>(arg0)) {
            if (*0x1::vector::borrow<u64>(arg0, v0) == arg1) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    public fun withdraw_forfeited_sy<T0, T1>(arg0: &mut YTVault<T0, T1>, arg1: &0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::caps::MarketAdminCap, arg2: 0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::timelock::TimelockReceipt, arg3: address, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::timelock::consume_receipt_with_payload(arg2, 0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::timelock::action_withdraw_forfeited_sy(), 0x2::object::id<YTVault<T0, T1>>(arg0), withdraw_forfeited_sy_payload_hash(arg3, arg4), arg5);
        let v0 = 0x2::balance::value<T0>(&arg0.forfeited_sy);
        assert!(0x2::tx_context::sender(arg6) == arg3, 0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::errors::e_wrong_recipient());
        assert!(v0 <= arg4, 0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::errors::e_amount_exceeds_max());
        if (v0 > 0) {
            0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::events::emit_forfeited_sy_withdrawn(0x2::object::id<YTVault<T0, T1>>(arg0), v0, 0x2::tx_context::sender(arg6));
        };
        0x2::balance::withdraw_all<T0>(&mut arg0.forfeited_sy)
    }

    public fun withdraw_forfeited_sy_payload_hash(arg0: address, arg1: u64) : vector<u8> {
        let v0 = b"nemo:withdraw_forfeited_sy:v1";
        0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::timelock::append_bcs<address>(&mut v0, &arg0);
        0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::timelock::append_bcs<u64>(&mut v0, &arg1);
        0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::timelock::hash_payload(v0)
    }

    public fun withdraw_unallocated_yield<T0, T1>(arg0: &mut YTVault<T0, T1>, arg1: &0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::caps::MarketAdminCap, arg2: 0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::timelock::TimelockReceipt, arg3: address, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::timelock::consume_receipt_with_payload(arg2, 0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::timelock::action_withdraw_unallocated_yield(), 0x2::object::id<YTVault<T0, T1>>(arg0), withdraw_unallocated_yield_payload_hash(arg3, arg4), arg5);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.unallocated_yield);
        assert!(0x2::tx_context::sender(arg6) == arg3, 0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::errors::e_wrong_recipient());
        assert!(v0 <= arg4, 0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::errors::e_amount_exceeds_max());
        if (v0 > 0) {
            0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::events::emit_unallocated_yield_withdrawn(0x2::object::id<YTVault<T0, T1>>(arg0), v0, 0x2::tx_context::sender(arg6));
        };
        0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.unallocated_yield)
    }

    public fun withdraw_unallocated_yield_payload_hash(arg0: address, arg1: u64) : vector<u8> {
        let v0 = b"nemo:withdraw_unallocated_yield:v1";
        0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::timelock::append_bcs<address>(&mut v0, &arg0);
        0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::timelock::append_bcs<u64>(&mut v0, &arg1);
        0x11d998938d6afa928d36d1bf9f47311a4d5786a543b135d59d7656f8a07da59e::timelock::hash_payload(v0)
    }

    public fun yield_balance_value<T0, T1>(arg0: &YTVault<T0, T1>) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.yield_balance)
    }

    // decompiled from Move bytecode v7
}

