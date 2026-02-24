module 0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::storage {
    struct AddStorageEvent has copy, drop {
        current_epoch: u32,
        added_epoch: u32,
        added_size: u64,
    }

    struct RemoveStorageEvent has copy, drop {
        current_epoch: u32,
        removed_epoch: u32,
        removed_size: u64,
    }

    struct AllocateStorageEvent has copy, drop {
        current_epoch: u32,
        start_epoch: u32,
        end_epoch: u32,
        size_per_epoch: u64,
    }

    struct DeallocateStorageEvent has copy, drop {
        current_epoch: u32,
        start_epoch: u32,
        end_epoch: u32,
        size_per_epoch: u64,
    }

    struct STORAGE has drop {
        dummy_field: bool,
    }

    struct StorageTreasury has key {
        id: 0x2::object::UID,
        tier_plan: 0x2::vec_map::VecMap<u8, StorageTier>,
        storages_by_epoch: 0x2::vec_map::VecMap<u32, 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::Storage>,
        total_used_storage_size_by_epoch: 0x2::vec_map::VecMap<u32, u64>,
        wal_treasury: 0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>,
        wal_treasury_usage_budget: 0x2::vec_map::VecMap<u8, TreasuryUsageBudget>,
    }

    struct TreasuryUsageBudget has copy, drop, store {
        duration: u64,
        max_budget: u64,
    }

    struct StorageTier has copy, drop, store {
        price: u64,
        duration_days: u16,
        storage_limit: u64,
    }

    struct StorageSpace has key {
        id: 0x2::object::UID,
        owner: address,
        tier: 0x1::option::Option<u8>,
        storage_used: 0x2::vec_map::VecMap<u32, u64>,
        credits: u64,
        treasury_usage: TreasuryUsage,
    }

    struct TreasuryUsage has store {
        accumlataed_budget: u64,
        start_at: u64,
    }

    struct UsageReceipt {
        start_budget: u64,
    }

    public(friend) fun new(arg0: &mut 0x2::object::UID, arg1: address) : StorageSpace {
        let v0 = TreasuryUsage{
            accumlataed_budget : 0,
            start_at           : 0,
        };
        StorageSpace{
            id             : 0x2::derived_object::claim<vector<u8>>(arg0, b"storage"),
            owner          : arg1,
            tier           : 0x1::option::none<u8>(),
            storage_used   : 0x2::vec_map::empty<u32, u64>(),
            credits        : 0,
            treasury_usage : v0,
        }
    }

    public(friend) fun add_credits(arg0: &mut StorageSpace, arg1: u64) {
        arg0.credits = arg0.credits + arg1;
    }

    public(friend) fun add_storage_space_accumulated_budget(arg0: &StorageTreasury, arg1: &mut StorageSpace, arg2: u64, arg3: UsageReceipt) {
        let UsageReceipt {  } = arg3;
        arg1.treasury_usage.accumlataed_budget = arg1.treasury_usage.accumlataed_budget + arg2;
        if (0x1::option::is_some<u8>(&arg1.tier)) {
            assert!(arg1.treasury_usage.accumlataed_budget <= 0x2::vec_map::get<u8, TreasuryUsageBudget>(&arg0.wal_treasury_usage_budget, 0x1::option::borrow<u8>(&arg1.tier)).max_budget, 105);
        } else {
            assert!(arg2 == 0, 105);
        };
    }

    public fun add_storage_to_treasury(arg0: &mut StorageTreasury, arg1: &0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::config::Config, arg2: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg3: 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::Storage, arg4: &mut 0x2::tx_context::TxContext) : u64 {
        0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::config::assert_version(arg1);
        0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::config::assert_not_paused(arg1);
        add_storage_to_treasury_(arg0, arg2, arg3, arg4)
    }

    public(friend) fun add_storage_to_treasury_(arg0: &mut StorageTreasury, arg1: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg2: 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::Storage, arg3: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0;
        let v1 = 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::epoch(arg1);
        let v2 = 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::start_epoch(&arg2);
        let v3 = 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::end_epoch(&arg2) - 1;
        while (v3 > v2) {
            let v4 = 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::split_by_epoch(&mut arg2, v3, arg3);
            if (v3 >= v1) {
                v0 = v0 + 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::size(&v4);
            };
            let v5 = AddStorageEvent{
                current_epoch : v3,
                added_epoch   : 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::end_epoch(&v4),
                added_size    : 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::size(&v4),
            };
            0x2::event::emit<AddStorageEvent>(v5);
            if (0x2::vec_map::contains<u32, 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::Storage>(&arg0.storages_by_epoch, &v3)) {
                0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::fuse_amount(0x2::vec_map::get_mut<u32, 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::Storage>(&mut arg0.storages_by_epoch, &v3), v4);
            } else {
                0x2::vec_map::insert<u32, 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::Storage>(&mut arg0.storages_by_epoch, v3, v4);
            };
            let v6 = v3;
            v3 = v6 - 1;
        };
        if (v3 >= v1) {
            v0 = v0 + 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::size(&arg2);
        };
        let v7 = AddStorageEvent{
            current_epoch : v3,
            added_epoch   : 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::end_epoch(&arg2),
            added_size    : 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::size(&arg2),
        };
        0x2::event::emit<AddStorageEvent>(v7);
        if (0x2::vec_map::contains<u32, 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::Storage>(&arg0.storages_by_epoch, &v2)) {
            0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::fuse_amount(0x2::vec_map::get_mut<u32, 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::Storage>(&mut arg0.storages_by_epoch, &v2), arg2);
        } else {
            0x2::vec_map::insert<u32, 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::Storage>(&mut arg0.storages_by_epoch, v2, arg2);
        };
        v0
    }

    public(friend) fun allocate_storage_from_treasury(arg0: &mut StorageTreasury, arg1: &mut StorageSpace, arg2: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg3: u32, arg4: u32, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::Storage {
        assert!(arg4 > 0, 102);
        assert!(arg5 > 0, 103);
        let v0 = 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::epoch(arg2);
        assert!(arg3 >= v0, 106);
        let v1 = remove_storage_from_treasury_(arg0, arg3, arg5, arg6);
        let v2 = RemoveStorageEvent{
            current_epoch : v0,
            removed_epoch : arg3,
            removed_size  : arg5,
        };
        0x2::event::emit<RemoveStorageEvent>(v2);
        let v3 = 0;
        while (v3 < arg4 - 1) {
            let v4 = arg3 + v3 + 1;
            let v5 = remove_storage_from_treasury_(arg0, v4, arg5, arg6);
            0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::fuse_periods(&mut v1, v5);
            let v6 = RemoveStorageEvent{
                current_epoch : v0,
                removed_epoch : v4,
                removed_size  : arg5,
            };
            0x2::event::emit<RemoveStorageEvent>(v6);
            v3 = v3 + 1;
        };
        while (arg3 < arg3 + arg4) {
            if (!0x2::vec_map::contains<u32, u64>(&arg0.total_used_storage_size_by_epoch, &arg3)) {
                0x2::vec_map::insert<u32, u64>(&mut arg0.total_used_storage_size_by_epoch, arg3, 0);
            };
            if (!0x2::vec_map::contains<u32, u64>(&arg1.storage_used, &arg3)) {
                0x2::vec_map::insert<u32, u64>(&mut arg1.storage_used, arg3, 0);
            };
            assert!(*0x2::vec_map::get<u32, u64>(&arg1.storage_used, &arg3) + arg5 <= storage_limit(arg0, arg1), 104);
            *0x2::vec_map::get_mut<u32, u64>(&mut arg0.total_used_storage_size_by_epoch, &arg3) = *0x2::vec_map::get<u32, u64>(&arg0.total_used_storage_size_by_epoch, &arg3) + arg5;
            *0x2::vec_map::get_mut<u32, u64>(&mut arg1.storage_used, &arg3) = *0x2::vec_map::get<u32, u64>(&arg1.storage_used, &arg3) + arg5;
            arg3 = arg3 + 1;
        };
        let v7 = AllocateStorageEvent{
            current_epoch  : v0,
            start_epoch    : arg3,
            end_epoch      : 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::end_epoch(&v1),
            size_per_epoch : arg5,
        };
        0x2::event::emit<AllocateStorageEvent>(v7);
        v1
    }

    public(friend) fun assert_owner(arg0: &StorageSpace, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg1), 101);
    }

    public(friend) fun borrow_wal_treasury_with_storage_space(arg0: &mut StorageTreasury, arg1: &mut StorageSpace, arg2: &0x2::clock::Clock) : (&mut 0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>, UsageReceipt) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let (v1, v2) = if (0x1::option::is_some<u8>(&arg1.tier)) {
            let v3 = 0x2::vec_map::get<u8, TreasuryUsageBudget>(&arg0.wal_treasury_usage_budget, 0x1::option::borrow<u8>(&arg1.tier));
            (v3.duration, v3.max_budget)
        } else {
            (0, 0)
        };
        if (arg1.treasury_usage.start_at == 0 || arg1.treasury_usage.start_at + v1 < v0) {
            arg1.treasury_usage.start_at = v0;
            arg1.treasury_usage.accumlataed_budget = 0;
        };
        assert!(arg1.treasury_usage.accumlataed_budget < v2, 105);
        let v4 = UsageReceipt{start_budget: arg1.treasury_usage.accumlataed_budget};
        (&mut arg0.wal_treasury, v4)
    }

    public fun credits(arg0: &StorageSpace) : u64 {
        arg0.credits
    }

    public(friend) fun deallocate_storage_from_treasury(arg0: &mut StorageTreasury, arg1: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg2: 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::epoch(arg1);
        if (0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::end_epoch(&arg2) <= v0) {
            0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::burn(arg2);
        } else {
            let v1 = 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::delete_blob(arg1, arg2);
            let v2 = 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::start_epoch(&v1);
            let v3 = 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::end_epoch(&v1);
            while (v2 < v3) {
                if (0x2::vec_map::contains<u32, u64>(&arg0.total_used_storage_size_by_epoch, &v2) && v2 >= v0) {
                    let v4 = *0x2::vec_map::get<u32, u64>(&arg0.total_used_storage_size_by_epoch, &v2);
                    let v5 = if (v4 <= 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::size(&v1)) {
                        0
                    } else {
                        v4 - 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::size(&v1)
                    };
                    *0x2::vec_map::get_mut<u32, u64>(&mut arg0.total_used_storage_size_by_epoch, &v2) = v5;
                };
                v2 = v2 + 1;
            };
            let v6 = DeallocateStorageEvent{
                current_epoch  : 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::epoch(arg1),
                start_epoch    : v2,
                end_epoch      : v3,
                size_per_epoch : 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::size(&v1),
            };
            0x2::event::emit<DeallocateStorageEvent>(v6);
            add_storage_to_treasury_(arg0, arg1, v1, arg3);
        };
    }

    public fun fund_wal_treasury(arg0: &mut StorageTreasury, arg1: &0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::config::Config, arg2: 0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>) {
        0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::config::assert_version(arg1);
        0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::config::assert_not_paused(arg1);
        0x2::coin::join<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&mut arg0.wal_treasury, arg2);
    }

    fun init(arg0: STORAGE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = StorageTreasury{
            id                               : 0x2::object::new(arg1),
            tier_plan                        : 0x2::vec_map::empty<u8, StorageTier>(),
            storages_by_epoch                : 0x2::vec_map::empty<u32, 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::Storage>(),
            total_used_storage_size_by_epoch : 0x2::vec_map::empty<u32, u64>(),
            wal_treasury                     : 0x2::coin::zero<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(arg1),
            wal_treasury_usage_budget        : 0x2::vec_map::empty<u8, TreasuryUsageBudget>(),
        };
        0x2::transfer::share_object<StorageTreasury>(v0);
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<STORAGE>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    public fun owner(arg0: &StorageSpace) : address {
        arg0.owner
    }

    public(friend) fun reduce_storage_usage(arg0: &mut StorageSpace, arg1: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::Storage) {
        let v0 = 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::start_epoch(arg1);
        while (v0 < 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::end_epoch(arg1)) {
            if (0x2::vec_map::contains<u32, u64>(&arg0.storage_used, &v0)) {
                let v1 = *0x2::vec_map::get<u32, u64>(&arg0.storage_used, &v0);
                let v2 = if (v1 <= 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::size(arg1)) {
                    0
                } else {
                    v1 - 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::size(arg1)
                };
                *0x2::vec_map::get_mut<u32, u64>(&mut arg0.storage_used, &v0) = v2;
            };
            v0 = v0 + 1;
        };
    }

    public fun remaining_storage(arg0: &StorageTreasury, arg1: &StorageSpace, arg2: u32) : u64 {
        let v0 = if (0x2::vec_map::contains<u32, u64>(&arg1.storage_used, &arg2)) {
            *0x2::vec_map::get<u32, u64>(&arg1.storage_used, &arg2)
        } else {
            0
        };
        let v1 = storage_limit(arg0, arg1);
        v1 - 0x1::u64::min(v1, v0)
    }

    public fun remove_storage_by_admin(arg0: &mut StorageTreasury, arg1: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg2: &0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::config::Config, arg3: &0x2dce2e2a3bc345b2c048477bd5f1fc0dfddce631b14ceeced3075cebe28955dd::admin::AdminCap, arg4: u32, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::Storage {
        0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::config::assert_version(arg2);
        0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::config::assert_not_paused(arg2);
        let v0 = RemoveStorageEvent{
            current_epoch : 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::epoch(arg1),
            removed_epoch : arg4,
            removed_size  : arg5,
        };
        0x2::event::emit<RemoveStorageEvent>(v0);
        remove_storage_from_treasury_(arg0, arg4, arg5, arg6)
    }

    fun remove_storage_from_treasury_(arg0: &mut StorageTreasury, arg1: u32, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::Storage {
        assert!(0x2::vec_map::contains<u32, 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::Storage>(&arg0.storages_by_epoch, &arg1), 107);
        let (_, v1) = 0x2::vec_map::remove<u32, 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::Storage>(&mut arg0.storages_by_epoch, &arg1);
        let v2 = v1;
        if (0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::size(&v2) == arg2) {
            return v2
        };
        0x2::vec_map::insert<u32, 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::Storage>(&mut arg0.storages_by_epoch, arg1, 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::split_by_size(&mut v2, arg2, arg3));
        v2
    }

    public fun share_storage_space(arg0: StorageSpace) {
        0x2::transfer::share_object<StorageSpace>(arg0);
    }

    public fun storage_limit(arg0: &StorageTreasury, arg1: &StorageSpace) : u64 {
        if (0x1::option::is_some<u8>(&arg1.tier)) {
            0x2::vec_map::get<u8, StorageTier>(&arg0.tier_plan, 0x1::option::borrow<u8>(&arg1.tier)).storage_limit
        } else {
            0
        }
    }

    public fun storage_space_treasury_usage(arg0: &StorageSpace) : &TreasuryUsage {
        &arg0.treasury_usage
    }

    public fun storage_used(arg0: &StorageSpace) : 0x2::vec_map::VecMap<u32, u64> {
        arg0.storage_used
    }

    public fun storage_used_by_epoch(arg0: &StorageSpace, arg1: u32) : u64 {
        *0x2::vec_map::get<u32, u64>(&arg0.storage_used, &arg1)
    }

    public(friend) fun storage_used_mut(arg0: &mut StorageSpace) : &mut 0x2::vec_map::VecMap<u32, u64> {
        &mut arg0.storage_used
    }

    public fun storages_by_epoch(arg0: &StorageTreasury) : &0x2::vec_map::VecMap<u32, 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::Storage> {
        &arg0.storages_by_epoch
    }

    public(friend) fun subtract_credits(arg0: &mut StorageSpace, arg1: u64) {
        let v0 = arg0.credits;
        arg0.credits = v0 - 0x1::u64::min(v0, arg1);
    }

    public fun tier(arg0: &StorageSpace) : 0x1::option::Option<u8> {
        arg0.tier
    }

    public fun tier_duration(arg0: StorageTier) : u64 {
        (arg0.duration_days as u64) * 0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::config::day_in_milliesecond()
    }

    public fun tier_duration_days(arg0: StorageTier) : u16 {
        arg0.duration_days
    }

    public fun tier_plan(arg0: &StorageTreasury) : 0x2::vec_map::VecMap<u8, StorageTier> {
        arg0.tier_plan
    }

    public fun tier_price(arg0: StorageTier) : u64 {
        arg0.price
    }

    public fun tier_storage_limit(arg0: StorageTier) : u64 {
        arg0.storage_limit
    }

    public fun total_used_storage_size_by_epoch(arg0: &StorageTreasury) : &0x2::vec_map::VecMap<u32, u64> {
        &arg0.total_used_storage_size_by_epoch
    }

    public fun treasury_usage_accumulated_budget(arg0: &TreasuryUsage) : u64 {
        arg0.accumlataed_budget
    }

    public fun treasury_usage_duration(arg0: &TreasuryUsageBudget) : u64 {
        arg0.duration
    }

    public fun treasury_usage_max_budget(arg0: &TreasuryUsageBudget) : u64 {
        arg0.max_budget
    }

    public fun treasury_usage_start_at(arg0: &TreasuryUsage) : u64 {
        arg0.start_at
    }

    public(friend) fun update_tier(arg0: &mut StorageSpace, arg1: u8) {
        0x1::option::swap_or_fill<u8>(&mut arg0.tier, arg1);
    }

    public fun update_tier_plan(arg0: &mut StorageTreasury, arg1: &0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::config::Config, arg2: &0x2dce2e2a3bc345b2c048477bd5f1fc0dfddce631b14ceeced3075cebe28955dd::admin::AdminCap, arg3: u8, arg4: u64, arg5: u16, arg6: u64) {
        0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::config::assert_version(arg1);
        0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::config::assert_not_paused(arg1);
        if (0x2::vec_map::contains<u8, StorageTier>(&arg0.tier_plan, &arg3)) {
            let v0 = 0x2::vec_map::get_mut<u8, StorageTier>(&mut arg0.tier_plan, &arg3);
            v0.price = arg4;
            v0.duration_days = arg5;
            v0.storage_limit = arg6;
        } else {
            let v1 = StorageTier{
                price         : arg4,
                duration_days : arg5,
                storage_limit : arg6,
            };
            0x2::vec_map::insert<u8, StorageTier>(&mut arg0.tier_plan, arg3, v1);
        };
    }

    public fun update_wal_treasury_usage_budget(arg0: &mut StorageTreasury, arg1: &0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::config::Config, arg2: &0x2dce2e2a3bc345b2c048477bd5f1fc0dfddce631b14ceeced3075cebe28955dd::admin::AdminCap, arg3: u8, arg4: u64, arg5: u64) {
        0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::config::assert_version(arg1);
        0x6ee54cd57f6f30a70cffeccb16251fc59be211a9706d7c8f0ea8e08c22aaf667::config::assert_not_paused(arg1);
        if (0x2::vec_map::contains<u8, TreasuryUsageBudget>(&arg0.wal_treasury_usage_budget, &arg3)) {
            let v0 = 0x2::vec_map::get_mut<u8, TreasuryUsageBudget>(&mut arg0.wal_treasury_usage_budget, &arg3);
            v0.duration = arg4;
            v0.max_budget = arg5;
        } else {
            let v1 = TreasuryUsageBudget{
                duration   : arg4,
                max_budget : arg5,
            };
            0x2::vec_map::insert<u8, TreasuryUsageBudget>(&mut arg0.wal_treasury_usage_budget, arg3, v1);
        };
    }

    public fun wal_treasury(arg0: &StorageTreasury) : u64 {
        0x2::coin::value<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&arg0.wal_treasury)
    }

    public fun wal_treasury_usage_budget(arg0: &StorageTreasury) : 0x2::vec_map::VecMap<u8, TreasuryUsageBudget> {
        arg0.wal_treasury_usage_budget
    }

    // decompiled from Move bytecode v6
}

