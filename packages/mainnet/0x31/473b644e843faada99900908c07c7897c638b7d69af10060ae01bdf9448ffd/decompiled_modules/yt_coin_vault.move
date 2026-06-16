module 0x31473b644e843faada99900908c07c7897c638b7d69af10060ae01bdf9448ffd::yt_coin_vault {
    struct YTCoinVault<phantom T0, phantom T1, phantom T2> has key {
        id: 0x2::object::UID,
        market_core_id: 0x2::object::ID,
        yt_vault_id: 0x2::object::ID,
        maturity_ms: u64,
        treasury_cap: 0x2::coin::TreasuryCap<T2>,
        inventory: 0x2::object_table::ObjectTable<0x2::object::ID, 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::yt_vault::VaultShare<T1>>,
        inventory_ids: 0x2::linked_table::LinkedTable<0x2::object::ID, bool>,
        share_sync_epochs: 0x2::table::Table<0x2::object::ID, u64>,
        reserve_sui: 0x2::balance::Balance<0x2::sui::SUI>,
        total_underlying_shares: u64,
        reserve_synced_epoch: u64,
        sync_in_progress: bool,
        sync_target_epoch: u64,
        sync_remaining: u64,
        settled: bool,
    }

    public fun new<T0, T1, T2>(arg0: &0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::yt_vault::YTVault<T0, T1>, arg1: 0x2::coin::TreasuryCap<T2>, arg2: &mut 0x2::tx_context::TxContext) : YTCoinVault<T0, T1, T2> {
        assert!(0x2::coin::total_supply<T2>(&arg1) == 0, 195);
        YTCoinVault<T0, T1, T2>{
            id                      : 0x2::object::new(arg2),
            market_core_id          : 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::yt_vault::market_core_id<T0, T1>(arg0),
            yt_vault_id             : 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::yt_vault::id<T0, T1>(arg0),
            maturity_ms             : 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::yt_vault::maturity_ms<T0, T1>(arg0),
            treasury_cap            : arg1,
            inventory               : 0x2::object_table::new<0x2::object::ID, 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::yt_vault::VaultShare<T1>>(arg2),
            inventory_ids           : 0x2::linked_table::new<0x2::object::ID, bool>(arg2),
            share_sync_epochs       : 0x2::table::new<0x2::object::ID, u64>(arg2),
            reserve_sui             : 0x2::balance::zero<0x2::sui::SUI>(),
            total_underlying_shares : 0,
            reserve_synced_epoch    : 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::yt_vault::current_epoch<T0, T1>(arg0),
            sync_in_progress        : false,
            sync_target_epoch       : 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::yt_vault::current_epoch<T0, T1>(arg0),
            sync_remaining          : 0,
            settled                 : false,
        }
    }

    public fun id<T0, T1, T2>(arg0: &YTCoinVault<T0, T1, T2>) : 0x2::object::ID {
        0x2::object::id<YTCoinVault<T0, T1, T2>>(arg0)
    }

    fun assert_bound_yt_vault<T0, T1, T2>(arg0: &YTCoinVault<T0, T1, T2>, arg1: &0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::yt_vault::YTVault<T0, T1>) {
        assert!(0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::yt_vault::id<T0, T1>(arg1) == arg0.yt_vault_id, 194);
    }

    fun assert_inventory_not_full(arg0: u64) {
        assert!(arg0 < 10000, 201);
    }

    fun assert_reserve_fresh<T0, T1, T2>(arg0: &YTCoinVault<T0, T1, T2>, arg1: &0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::yt_vault::YTVault<T0, T1>) {
        assert_bound_yt_vault<T0, T1, T2>(arg0, arg1);
        assert!(!arg0.sync_in_progress, 203);
        assert!(arg0.reserve_synced_epoch == 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::yt_vault::current_epoch<T0, T1>(arg1), 202);
    }

    public fun begin_reserve_sync<T0, T1, T2>(arg0: &mut YTCoinVault<T0, T1, T2>, arg1: &0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::yt_vault::YTVault<T0, T1>) {
        assert_bound_yt_vault<T0, T1, T2>(arg0, arg1);
        assert!(!arg0.sync_in_progress, 203);
        let v0 = 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::yt_vault::current_epoch<T0, T1>(arg1);
        assert!(arg0.reserve_synced_epoch <= v0, 197);
        let v1 = count_unsynced_inventory<T0, T1, T2>(arg0, v0);
        assert!(arg0.reserve_synced_epoch < v0 || v1 > 0, 208);
        if (v1 == 0) {
            arg0.reserve_synced_epoch = v0;
            arg0.sync_target_epoch = v0;
            arg0.sync_remaining = 0;
            return
        };
        arg0.sync_in_progress = true;
        arg0.sync_target_epoch = v0;
        arg0.sync_remaining = v1;
    }

    public fun coin_supply<T0, T1, T2>(arg0: &YTCoinVault<T0, T1, T2>) : u64 {
        0x2::coin::total_supply<T2>(&arg0.treasury_cap)
    }

    public fun collect_to_reserve_step<T0, T1, T2>(arg0: &mut YTCoinVault<T0, T1, T2>, arg1: &mut 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::yt_vault::YTVault<T0, T1>, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        assert_bound_yt_vault<T0, T1, T2>(arg0, arg1);
        assert!(arg0.sync_in_progress, 204);
        assert!(contains_inventory<T0, T1, T2>(arg0, arg2), 198);
        let v0 = share_sync_epoch<T0, T1, T2>(arg0, arg2);
        assert!(v0 < arg0.sync_target_epoch, 205);
        let v1 = 0x2::object_table::borrow_mut<0x2::object::ID, 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::yt_vault::VaultShare<T1>>(&mut arg0.inventory, arg2);
        let v2 = 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::yt_vault::share_entry_epoch<T1>(v1);
        assert!(v0 <= v2, 197);
        let v3 = if (v2 > arg0.sync_target_epoch) {
            arg0.sync_target_epoch
        } else {
            v2
        };
        set_share_sync_epoch<T0, T1, T2>(arg0, arg2, v3);
        if (v3 >= arg0.sync_target_epoch) {
            assert!(arg0.sync_remaining > 0, 197);
            arg0.sync_remaining = arg0.sync_remaining - 1;
        };
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.reserve_sui, 0x2::coin::into_balance<0x2::sui::SUI>(0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::yt_vault::claim_vault_yield<T0, T1>(arg1, v1, arg3)));
    }

    fun contains_inventory<T0, T1, T2>(arg0: &YTCoinVault<T0, T1, T2>, arg1: 0x2::object::ID) : bool {
        0x2::linked_table::contains<0x2::object::ID, bool>(&arg0.inventory_ids, arg1)
    }

    fun count_unsynced_inventory<T0, T1, T2>(arg0: &YTCoinVault<T0, T1, T2>, arg1: u64) : u64 {
        let v0 = 0;
        let v1 = *0x2::linked_table::front<0x2::object::ID, bool>(&arg0.inventory_ids);
        while (0x1::option::is_some<0x2::object::ID>(&v1)) {
            let v2 = *0x1::option::borrow<0x2::object::ID>(&v1);
            if (share_sync_epoch<T0, T1, T2>(arg0, v2) < arg1) {
                assert!(v0 < 18446744073709551615, 197);
                v0 = v0 + 1;
            };
            v1 = *0x2::linked_table::next<0x2::object::ID, bool>(&arg0.inventory_ids, v2);
        };
        v0
    }

    public fun deposit_yt_and_mint_coin<T0, T1, T2>(arg0: 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::yt_vault::VaultShare<T1>, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut YTCoinVault<T0, T1, T2>, arg3: &0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::yt_vault::YTVault<T0, T1>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        mint_from_share<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5)
    }

    public fun deposit_yt_and_mint_coin_with_topup<T0, T1, T2>(arg0: 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::yt_vault::VaultShare<T1>, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut YTCoinVault<T0, T1, T2>, arg4: &0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::yt_vault::YTVault<T0, T1>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        let v0 = 0x2::coin::into_balance<0x2::sui::SUI>(arg1);
        0x2::balance::join<0x2::sui::SUI>(&mut v0, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
        mint_from_share_balance<T0, T1, T2>(arg0, v0, arg3, arg4, arg5, arg6)
    }

    public fun finalize_at_maturity<T0, T1, T2>(arg0: &mut YTCoinVault<T0, T1, T2>, arg1: &0x2::clock::Clock) {
        assert!(!arg0.settled, 196);
        assert!(0x2::clock::timestamp_ms(arg1) >= arg0.maturity_ms, 193);
        assert!(0x2::linked_table::length<0x2::object::ID, bool>(&arg0.inventory_ids) == 0 && arg0.total_underlying_shares == 0, 199);
        arg0.settled = true;
    }

    public fun finalize_reserve_sync<T0, T1, T2>(arg0: &mut YTCoinVault<T0, T1, T2>) {
        assert!(arg0.sync_in_progress, 204);
        assert!(arg0.sync_remaining == 0, 206);
        arg0.reserve_synced_epoch = arg0.sync_target_epoch;
        arg0.sync_in_progress = false;
    }

    public fun inventory_len<T0, T1, T2>(arg0: &YTCoinVault<T0, T1, T2>) : u64 {
        0x2::linked_table::length<0x2::object::ID, bool>(&arg0.inventory_ids)
    }

    public fun is_settled<T0, T1, T2>(arg0: &YTCoinVault<T0, T1, T2>) : bool {
        arg0.settled
    }

    public fun market_core_id<T0, T1, T2>(arg0: &YTCoinVault<T0, T1, T2>) : 0x2::object::ID {
        arg0.market_core_id
    }

    public fun maturity_ms<T0, T1, T2>(arg0: &YTCoinVault<T0, T1, T2>) : u64 {
        arg0.maturity_ms
    }

    public fun max_inventory() : u64 {
        10000
    }

    fun mint_from_share<T0, T1, T2>(arg0: 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::yt_vault::VaultShare<T1>, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut YTCoinVault<T0, T1, T2>, arg3: &0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::yt_vault::YTVault<T0, T1>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        mint_from_share_balance<T0, T1, T2>(arg0, 0x2::coin::into_balance<0x2::sui::SUI>(arg1), arg2, arg3, arg4, arg5)
    }

    fun mint_from_share_balance<T0, T1, T2>(arg0: 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::yt_vault::VaultShare<T1>, arg1: 0x2::balance::Balance<0x2::sui::SUI>, arg2: &mut YTCoinVault<T0, T1, T2>, arg3: &0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::yt_vault::YTVault<T0, T1>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        refresh_empty_inventory_reserve<T0, T1, T2>(arg2, arg3);
        assert_reserve_fresh<T0, T1, T2>(arg2, arg3);
        assert!(!arg2.settled, 196);
        assert!(0x2::clock::timestamp_ms(arg4) < arg2.maturity_ms, 193);
        assert!(0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::yt_vault::share_vault_id<T1>(&arg0) == arg2.yt_vault_id, 194);
        let v0 = 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::yt_vault::current_epoch<T0, T1>(arg3);
        assert!(0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::yt_vault::share_entry_epoch<T1>(&arg0) == v0, 207);
        let v1 = 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::yt_vault::share_value<T1>(&arg0);
        assert!(v1 > 0, 195);
        assert_inventory_not_full(0x2::linked_table::length<0x2::object::ID, bool>(&arg2.inventory_ids));
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg1) >= required_catchup_sui_for_shares<T0, T1, T2>(arg2, v1), 200);
        let v2 = 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::yt_vault::share_id<T1>(&arg0);
        0x2::object_table::add<0x2::object::ID, 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::yt_vault::VaultShare<T1>>(&mut arg2.inventory, v2, arg0);
        0x2::linked_table::push_back<0x2::object::ID, bool>(&mut arg2.inventory_ids, v2, true);
        set_share_sync_epoch<T0, T1, T2>(arg2, v2, v0);
        assert!(v1 <= 18446744073709551615 - arg2.total_underlying_shares, 197);
        arg2.total_underlying_shares = arg2.total_underlying_shares + v1;
        0x2::balance::join<0x2::sui::SUI>(&mut arg2.reserve_sui, arg1);
        0x2::coin::mint<T2>(&mut arg2.treasury_cap, v1, arg5)
    }

    fun mul_div_down(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = (arg0 as u128) * (arg1 as u128) / (arg2 as u128);
        assert!(v0 <= 18446744073709551615, 197);
        (v0 as u64)
    }

    fun mul_div_up(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = ((arg0 as u128) * (arg1 as u128) + (arg2 as u128) - 1) / (arg2 as u128);
        assert!(v0 <= 18446744073709551615, 197);
        (v0 as u64)
    }

    public fun redeem_underlying_share_to_reserve<T0, T1, T2>(arg0: &mut YTCoinVault<T0, T1, T2>, arg1: &mut 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::yt_vault::YTVault<T0, T1>, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        assert_bound_yt_vault<T0, T1, T2>(arg0, arg1);
        assert!(contains_inventory<T0, T1, T2>(arg0, arg2), 198);
        let v0 = if (arg0.sync_in_progress) {
            share_sync_epoch<T0, T1, T2>(arg0, arg2) < arg0.sync_target_epoch
        } else {
            false
        };
        let v1 = 0x2::object_table::remove<0x2::object::ID, 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::yt_vault::VaultShare<T1>>(&mut arg0.inventory, arg2);
        let v2 = 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::yt_vault::share_value<T1>(&v1);
        0x2::linked_table::remove<0x2::object::ID, bool>(&mut arg0.inventory_ids, arg2);
        remove_share_sync_epoch_if_exists<T0, T1, T2>(arg0, arg2);
        assert!(v2 <= arg0.total_underlying_shares, 197);
        arg0.total_underlying_shares = arg0.total_underlying_shares - v2;
        if (v0) {
            assert!(arg0.sync_remaining > 0, 197);
            arg0.sync_remaining = arg0.sync_remaining - 1;
        };
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.reserve_sui, 0x2::coin::into_balance<0x2::sui::SUI>(0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::yt_vault::redeem_vault_share<T0, T1>(arg1, v1, arg3)));
    }

    public fun redeem_yt_coin<T0, T1, T2>(arg0: 0x2::coin::Coin<T2>, arg1: &mut YTCoinVault<T0, T1, T2>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(arg1.settled, 192);
        assert!(0x2::clock::timestamp_ms(arg2) >= arg1.maturity_ms, 193);
        let v0 = 0x2::coin::value<T2>(&arg0);
        let v1 = 0x2::coin::total_supply<T2>(&arg1.treasury_cap);
        let v2 = if (v0 > 0) {
            if (v1 > 0) {
                v0 <= v1
            } else {
                false
            }
        } else {
            false
        };
        assert!(v2, 195);
        let v3 = 0x2::balance::value<0x2::sui::SUI>(&arg1.reserve_sui);
        let v4 = if (v0 == v1) {
            v3
        } else {
            mul_div_down(v0, v3, v1)
        };
        0x2::coin::burn<T2>(&mut arg1.treasury_cap, arg0);
        let v5 = if (v4 == v3) {
            0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg1.reserve_sui)
        } else {
            0x2::balance::split<0x2::sui::SUI>(&mut arg1.reserve_sui, v4)
        };
        0x2::coin::from_balance<0x2::sui::SUI>(v5, arg3)
    }

    fun refresh_empty_inventory_reserve<T0, T1, T2>(arg0: &mut YTCoinVault<T0, T1, T2>, arg1: &0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::yt_vault::YTVault<T0, T1>) {
        assert_bound_yt_vault<T0, T1, T2>(arg0, arg1);
        let v0 = if (!arg0.sync_in_progress) {
            if (0x2::linked_table::length<0x2::object::ID, bool>(&arg0.inventory_ids) == 0) {
                arg0.total_underlying_shares == 0
            } else {
                false
            }
        } else {
            false
        };
        if (v0) {
            let v1 = 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::yt_vault::current_epoch<T0, T1>(arg1);
            assert!(arg0.reserve_synced_epoch <= v1, 197);
            arg0.reserve_synced_epoch = v1;
            arg0.sync_target_epoch = v1;
            arg0.sync_remaining = 0;
        };
    }

    fun remove_share_sync_epoch_if_exists<T0, T1, T2>(arg0: &mut YTCoinVault<T0, T1, T2>, arg1: 0x2::object::ID) {
        if (0x2::table::contains<0x2::object::ID, u64>(&arg0.share_sync_epochs, arg1)) {
            0x2::table::remove<0x2::object::ID, u64>(&mut arg0.share_sync_epochs, arg1);
        };
    }

    public fun required_catchup_sui_for_shares<T0, T1, T2>(arg0: &YTCoinVault<T0, T1, T2>, arg1: u64) : u64 {
        let v0 = 0x2::coin::total_supply<T2>(&arg0.treasury_cap);
        if (v0 == 0 || arg1 == 0) {
            return 0
        };
        mul_div_up(arg1, 0x2::balance::value<0x2::sui::SUI>(&arg0.reserve_sui), v0)
    }

    public fun reserve_sui_value<T0, T1, T2>(arg0: &YTCoinVault<T0, T1, T2>) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.reserve_sui)
    }

    public fun reserve_synced_epoch<T0, T1, T2>(arg0: &YTCoinVault<T0, T1, T2>) : u64 {
        arg0.reserve_synced_epoch
    }

    fun set_share_sync_epoch<T0, T1, T2>(arg0: &mut YTCoinVault<T0, T1, T2>, arg1: 0x2::object::ID, arg2: u64) {
        if (0x2::table::contains<0x2::object::ID, u64>(&arg0.share_sync_epochs, arg1)) {
            *0x2::table::borrow_mut<0x2::object::ID, u64>(&mut arg0.share_sync_epochs, arg1) = arg2;
        } else {
            0x2::table::add<0x2::object::ID, u64>(&mut arg0.share_sync_epochs, arg1, arg2);
        };
    }

    public fun share<T0, T1, T2>(arg0: YTCoinVault<T0, T1, T2>) {
        0x2::transfer::share_object<YTCoinVault<T0, T1, T2>>(arg0);
    }

    fun share_sync_epoch<T0, T1, T2>(arg0: &YTCoinVault<T0, T1, T2>, arg1: 0x2::object::ID) : u64 {
        if (0x2::table::contains<0x2::object::ID, u64>(&arg0.share_sync_epochs, arg1)) {
            *0x2::table::borrow<0x2::object::ID, u64>(&arg0.share_sync_epochs, arg1)
        } else {
            0
        }
    }

    public fun share_synced_epoch<T0, T1, T2>(arg0: &YTCoinVault<T0, T1, T2>, arg1: 0x2::object::ID) : u64 {
        share_sync_epoch<T0, T1, T2>(arg0, arg1)
    }

    public fun sync_in_progress<T0, T1, T2>(arg0: &YTCoinVault<T0, T1, T2>) : bool {
        arg0.sync_in_progress
    }

    public fun sync_remaining<T0, T1, T2>(arg0: &YTCoinVault<T0, T1, T2>) : u64 {
        arg0.sync_remaining
    }

    public fun sync_target_epoch<T0, T1, T2>(arg0: &YTCoinVault<T0, T1, T2>) : u64 {
        arg0.sync_target_epoch
    }

    public fun total_underlying_shares<T0, T1, T2>(arg0: &YTCoinVault<T0, T1, T2>) : u64 {
        arg0.total_underlying_shares
    }

    public fun wrap_vault_share_and_mint_coin<T0, T1, T2>(arg0: 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::yt_vault::VaultShare<T1>, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut YTCoinVault<T0, T1, T2>, arg3: &0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::yt_vault::YTVault<T0, T1>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        mint_from_share<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, arg5)
    }

    public fun yt_vault_id<T0, T1, T2>(arg0: &YTCoinVault<T0, T1, T2>) : 0x2::object::ID {
        arg0.yt_vault_id
    }

    // decompiled from Move bytecode v7
}

