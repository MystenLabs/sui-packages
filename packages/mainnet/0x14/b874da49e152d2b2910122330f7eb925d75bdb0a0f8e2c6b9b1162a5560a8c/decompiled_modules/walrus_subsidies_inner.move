module 0x14b874da49e152d2b2910122330f7eb925d75bdb0a0f8e2c6b9b1162a5560a8c::walrus_subsidies_inner {
    struct WalrusSubsidiesInnerV1 has store {
        system_subsidy_rate: u32,
        subsidy_pool: 0x2::balance::Balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>,
        base_subsidy: u64,
        subsidy_per_shard: u64,
        latest_epoch: u32,
        already_subsidized_balances: 0x14b874da49e152d2b2910122330f7eb925d75bdb0a0f8e2c6b9b1162a5560a8c::epoch_balance::EpochBalanceRingBuffer,
        last_subsidized_ts: u64,
        extra_fields: 0x2::bag::Bag,
    }

    public(friend) fun new(arg0: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg1: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staking::Staking, arg2: u32, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : WalrusSubsidiesInnerV1 {
        let v0 = 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::future_accounting(arg0);
        let v1 = vector[];
        let v2 = 0;
        while (v2 < (0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_accounting::max_epochs_ahead(v0) as u64)) {
            0x1::vector::push_back<u64>(&mut v1, 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_accounting::rewards(0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_accounting::ring_lookup(v0, (v2 as u32))));
            v2 = v2 + 1;
        };
        let v3 = if (0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staking::epoch(arg1) == 0) {
            0
        } else {
            0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staking::epoch(arg1) - 1
        };
        WalrusSubsidiesInnerV1{
            system_subsidy_rate         : arg2,
            subsidy_pool                : 0x2::balance::zero<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(),
            base_subsidy                : arg3,
            subsidy_per_shard           : arg4,
            latest_epoch                : v3,
            already_subsidized_balances : 0x14b874da49e152d2b2910122330f7eb925d75bdb0a0f8e2c6b9b1162a5560a8c::epoch_balance::ring_new_from_balances(0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::epoch(arg0), v1),
            last_subsidized_ts          : 0,
            extra_fields                : 0x2::bag::new(arg5),
        }
    }

    public(friend) fun add_balance(arg0: &mut WalrusSubsidiesInnerV1, arg1: 0x2::balance::Balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>) {
        0x2::balance::join<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&mut arg0.subsidy_pool, arg1);
    }

    public(friend) fun base_subsidy(arg0: &WalrusSubsidiesInnerV1) : u64 {
        arg0.base_subsidy
    }

    public(friend) fun per_shard_subsidy(arg0: &WalrusSubsidiesInnerV1) : u64 {
        arg0.subsidy_per_shard
    }

    public(friend) fun process_fixed_rate_subsidies(arg0: &mut WalrusSubsidiesInnerV1, arg1: &mut 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staking::Staking) : bool {
        if (arg0.latest_epoch >= 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staking::epoch(arg1)) {
            return false
        };
        let (v0, v1) = 0x2::vec_map::into_keys_values<0x2::object::ID, vector<u16>>(0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::committee::to_inner(0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staking::committee(arg1)));
        let v2 = 0x1::vector::empty<0x2::balance::Balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>>();
        let v3 = v1;
        0x1::vector::reverse<vector<u16>>(&mut v3);
        let v4 = 0;
        while (v4 < 0x1::vector::length<vector<u16>>(&v3)) {
            let v5 = &mut v2;
            let v6 = 0x1::vector::pop_back<vector<u16>>(&mut v3);
            let v7 = arg0.base_subsidy + 0x1::vector::length<u16>(&v6) * arg0.subsidy_per_shard;
            assert!(0x2::balance::value<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&arg0.subsidy_pool) >= v7, 1);
            0x1::vector::push_back<0x2::balance::Balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>>(v5, 0x2::balance::split<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&mut arg0.subsidy_pool, v7));
            v4 = v4 + 1;
        };
        0x1::vector::destroy_empty<vector<u16>>(v3);
        0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staking::add_commission_to_pools(arg1, v0, v2);
        arg0.latest_epoch = 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staking::epoch(arg1);
        true
    }

    public(friend) fun process_subsidies(arg0: &mut WalrusSubsidiesInnerV1, arg1: &mut 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::staking::Staking, arg2: &mut 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg3: &0x2::clock::Clock) {
        process_fixed_rate_subsidies(arg0, arg1);
        process_usage_subsidies(arg0, arg2);
        arg0.last_subsidized_ts = 0x2::clock::timestamp_ms(arg3);
    }

    public(friend) fun process_usage_subsidies(arg0: &mut WalrusSubsidiesInnerV1, arg1: &mut 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System) {
        let v0 = &mut arg0.already_subsidized_balances;
        let v1 = 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::future_accounting(arg1);
        while (0x14b874da49e152d2b2910122330f7eb925d75bdb0a0f8e2c6b9b1162a5560a8c::epoch_balance::epoch(0x14b874da49e152d2b2910122330f7eb925d75bdb0a0f8e2c6b9b1162a5560a8c::epoch_balance::ring_lookup(v0, 0)) < 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_accounting::epoch(0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_accounting::ring_lookup(v1, 0))) {
            0x14b874da49e152d2b2910122330f7eb925d75bdb0a0f8e2c6b9b1162a5560a8c::epoch_balance::ring_pop_expand(v0);
        };
        let v2 = 0x1::vector::empty<0x2::balance::Balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>>();
        let v3 = 0;
        while (v3 < (0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_accounting::max_epochs_ahead(v1) as u64)) {
            let v4 = &mut v2;
            let v5 = (v3 as u32);
            let v6 = 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_accounting::rewards(0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_accounting::ring_lookup(v1, v5));
            let v7 = ((v6 - 0x14b874da49e152d2b2910122330f7eb925d75bdb0a0f8e2c6b9b1162a5560a8c::epoch_balance::balance(0x14b874da49e152d2b2910122330f7eb925d75bdb0a0f8e2c6b9b1162a5560a8c::epoch_balance::ring_lookup(v0, v5))) as u128) * (arg0.system_subsidy_rate as u128) / 10000;
            assert!(v7 <= (0x2::balance::value<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&arg0.subsidy_pool) as u128), 1);
            let v8 = 0x2::balance::split<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&mut arg0.subsidy_pool, (v7 as u64));
            0x14b874da49e152d2b2910122330f7eb925d75bdb0a0f8e2c6b9b1162a5560a8c::epoch_balance::set_balance(0x14b874da49e152d2b2910122330f7eb925d75bdb0a0f8e2c6b9b1162a5560a8c::epoch_balance::ring_lookup_mut(v0, v5), v6 + 0x2::balance::value<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&v8));
            0x1::vector::push_back<0x2::balance::Balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>>(v4, v8);
            v3 = v3 + 1;
        };
        0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::add_per_epoch_subsidies(arg1, v2);
    }

    public(friend) fun set_base_subsidy(arg0: &mut WalrusSubsidiesInnerV1, arg1: u64) {
        assert!((arg1 as u128) + (arg0.subsidy_per_shard as u128) * 1000 <= 18446744073709551615, 0);
        arg0.base_subsidy = arg1;
    }

    public(friend) fun set_per_shard_subsidy(arg0: &mut WalrusSubsidiesInnerV1, arg1: u64) {
        assert!((arg0.base_subsidy as u128) + (arg1 as u128) * 1000 <= 18446744073709551615, 0);
        arg0.subsidy_per_shard = arg1;
    }

    public(friend) fun set_system_subsidy_rate(arg0: &mut WalrusSubsidiesInnerV1, arg1: u32) {
        assert!(arg1 <= 1000000, 0);
        arg0.system_subsidy_rate = arg1;
    }

    public(friend) fun subsidy_pool_balance(arg0: &WalrusSubsidiesInnerV1) : u64 {
        0x2::balance::value<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&arg0.subsidy_pool)
    }

    public(friend) fun system_subsidy_rate(arg0: &WalrusSubsidiesInnerV1) : u32 {
        arg0.system_subsidy_rate
    }

    // decompiled from Move bytecode v6
}

