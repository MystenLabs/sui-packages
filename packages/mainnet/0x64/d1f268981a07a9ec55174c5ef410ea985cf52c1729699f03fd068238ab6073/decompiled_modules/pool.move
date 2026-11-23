module 0x64d1f268981a07a9ec55174c5ef410ea985cf52c1729699f03fd068238ab6073::pool {
    struct Pool has key {
        id: 0x2::object::UID,
        version: u64,
        wal: 0x2::balance::Balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>,
        sui: 0x2::balance::Balance<0x2::sui::SUI>,
        blobs: 0x2::object_table::ObjectTable<0x2::object::ID, 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>,
        by_blob_id: 0x2::table::Table<u256, 0x2::object::ID>,
        config: Config,
        spend: 0x64d1f268981a07a9ec55174c5ef410ea985cf52c1729699f03fd068238ab6073::limits::EpochSpend,
    }

    struct BlobRegistered has copy, drop {
        pool_id: 0x2::object::ID,
        blob_object_id: 0x2::object::ID,
        blob_id: u256,
        size: u64,
        end_epoch: u32,
        sender: address,
    }

    struct BlobCertified has copy, drop {
        pool_id: 0x2::object::ID,
        blob_object_id: 0x2::object::ID,
        blob_id: u256,
    }

    struct BlobDeleted has copy, drop {
        pool_id: 0x2::object::ID,
        blob_object_id: 0x2::object::ID,
    }

    struct BlobBurned has copy, drop {
        pool_id: 0x2::object::ID,
        blob_object_id: 0x2::object::ID,
    }

    struct BlobExtended has copy, drop {
        pool_id: 0x2::object::ID,
        blob_object_id: 0x2::object::ID,
        epochs: u32,
        end_epoch: u32,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
    }

    struct Config has copy, drop, store {
        max_size: u64,
        epochs: u32,
        max_wal_per_call: u64,
        epoch_budget_wal: u64,
        epoch_budget_sui: u64,
        tip_address: address,
        tip_base: u64,
        tip_per_kib: u64,
        renew_window: u32,
        renew_epochs: u32,
        paused: bool,
    }

    fun assert_admin(arg0: &Pool, arg1: &AdminCap) {
        assert_version(arg0);
        assert!(arg1.pool_id == 0x2::object::id<Pool>(arg0), 0);
    }

    fun assert_version(arg0: &Pool) {
        assert!(arg0.version == 1, 1);
    }

    public fun blob_count(arg0: &Pool) : u64 {
        assert_version(arg0);
        0x2::object_table::length<0x2::object::ID, 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(&arg0.blobs)
    }

    public fun burn_expired(arg0: &mut Pool, arg1: &AdminCap, arg2: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg3: 0x2::object::ID) {
        assert_admin(arg0, arg1);
        check_blob_exists(arg0, arg3);
        assert!(0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::end_epoch(0x2::object_table::borrow<0x2::object::ID, 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(&arg0.blobs, arg3)) <= 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::epoch(arg2), 9);
        let v0 = 0x2::object_table::remove<0x2::object::ID, 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(&mut arg0.blobs, arg3);
        index_remove(arg0, 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::blob_id(&v0), arg3);
        0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::burn(v0);
        let v1 = BlobBurned{
            pool_id        : 0x2::object::id<Pool>(arg0),
            blob_object_id : arg3,
        };
        0x2::event::emit<BlobBurned>(v1);
    }

    public fun certify(arg0: &mut Pool, arg1: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg2: 0x2::object::ID, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>) {
        assert_version(arg0);
        check_blob_exists(arg0, arg2);
        let v0 = 0x2::object_table::borrow_mut<0x2::object::ID, 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(&mut arg0.blobs, arg2);
        0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::certify_blob(arg1, v0, arg3, arg4, arg5);
        let v1 = 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::blob_id(v0);
        let v2 = 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::end_epoch(v0);
        let v3 = BlobCertified{
            pool_id        : 0x2::object::id<Pool>(arg0),
            blob_object_id : arg2,
            blob_id        : v1,
        };
        0x2::event::emit<BlobCertified>(v3);
        index_certified(arg0, 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::epoch(arg1), v1, arg2, v2);
    }

    public(friend) fun check_blob_exists(arg0: &Pool, arg1: 0x2::object::ID) {
        assert!(0x2::object_table::contains<0x2::object::ID, 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(&arg0.blobs, arg1), 4);
    }

    public(friend) fun check_register_preconditions(arg0: &Pool, arg1: u64) {
        assert_version(arg0);
        assert!(!arg0.config.paused, 2);
        assert!(arg1 <= arg0.config.max_size, 3);
    }

    public fun config(arg0: &Pool) : Config {
        assert_version(arg0);
        arg0.config
    }

    public fun contains_blob(arg0: &Pool, arg1: 0x2::object::ID) : bool {
        0x2::object_table::contains<0x2::object::ID, 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(&arg0.blobs, arg1)
    }

    public fun create(arg0: Config, arg1: &mut 0x2::tx_context::TxContext) : AdminCap {
        let v0 = Pool{
            id         : 0x2::object::new(arg1),
            version    : 1,
            wal        : 0x2::balance::zero<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(),
            sui        : 0x2::balance::zero<0x2::sui::SUI>(),
            blobs      : 0x2::object_table::new<0x2::object::ID, 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(arg1),
            by_blob_id : 0x2::table::new<u256, 0x2::object::ID>(arg1),
            config     : arg0,
            spend      : 0x64d1f268981a07a9ec55174c5ef410ea985cf52c1729699f03fd068238ab6073::limits::new(),
        };
        let v1 = AdminCap{
            id      : 0x2::object::new(arg1),
            pool_id : 0x2::object::id<Pool>(&v0),
        };
        0x2::transfer::share_object<Pool>(v0);
        v1
    }

    public fun delete(arg0: &mut Pool, arg1: &AdminCap, arg2: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg3: 0x2::object::ID) {
        assert_admin(arg0, arg1);
        check_blob_exists(arg0, arg3);
        let v0 = 0x2::object_table::remove<0x2::object::ID, 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(&mut arg0.blobs, arg3);
        index_remove(arg0, 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::blob_id(&v0), arg3);
        0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::destroy(0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::delete_blob(arg2, v0));
        let v1 = BlobDeleted{
            pool_id        : 0x2::object::id<Pool>(arg0),
            blob_object_id : arg3,
        };
        0x2::event::emit<BlobDeleted>(v1);
    }

    public fun deposit_sui(arg0: &mut Pool, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        assert_version(arg0);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
    }

    public fun deposit_wal(arg0: &mut Pool, arg1: 0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>) {
        assert_version(arg0);
        0x2::balance::join<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&mut arg0.wal, 0x2::coin::into_balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(arg1));
    }

    public fun epoch_budget_sui(arg0: &Config) : u64 {
        arg0.epoch_budget_sui
    }

    public fun epoch_budget_wal(arg0: &Config) : u64 {
        arg0.epoch_budget_wal
    }

    public fun epochs(arg0: &Config) : u32 {
        arg0.epochs
    }

    public fun extend(arg0: &mut Pool, arg1: &AdminCap, arg2: &mut 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg3: 0x2::object::ID, arg4: u32, arg5: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, arg1);
        check_blob_exists(arg0, arg3);
        let v0 = 0x2::balance::value<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&arg0.wal);
        assert!(v0 > 0, 5);
        let v1 = 0x2::coin::take<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&mut arg0.wal, v0, arg5);
        let v2 = 0x2::object_table::borrow_mut<0x2::object::ID, 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(&mut arg0.blobs, arg3);
        0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::extend_blob(arg2, v2, arg4, &mut v1);
        let v3 = BlobExtended{
            pool_id        : 0x2::object::id<Pool>(arg0),
            blob_object_id : arg3,
            epochs         : arg4,
            end_epoch      : 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::end_epoch(v2),
        };
        0x2::event::emit<BlobExtended>(v3);
        0x2::balance::join<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&mut arg0.wal, 0x2::coin::into_balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(v1));
    }

    public(friend) fun index_certified(arg0: &mut Pool, arg1: u32, arg2: u256, arg3: 0x2::object::ID, arg4: u32) {
        if (!0x2::table::contains<u256, 0x2::object::ID>(&arg0.by_blob_id, arg2)) {
            0x2::table::add<u256, 0x2::object::ID>(&mut arg0.by_blob_id, arg2, arg3);
            return
        };
        let v0 = *0x2::table::borrow<u256, 0x2::object::ID>(&arg0.by_blob_id, arg2);
        if (v0 == arg3) {
            return
        };
        let v1 = if (0x2::object_table::contains<0x2::object::ID, 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(&arg0.blobs, v0)) {
            let v2 = 0x2::object_table::borrow<0x2::object::ID, 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(&arg0.blobs, v0);
            if (0x1::option::is_some<u32>(0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::certified_epoch(v2))) {
                if (0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::end_epoch(v2) > arg1) {
                    0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::end_epoch(v2) >= arg4
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        if (!v1) {
            *0x2::table::borrow_mut<u256, 0x2::object::ID>(&mut arg0.by_blob_id, arg2) = arg3;
        };
    }

    public(friend) fun index_remove(arg0: &mut Pool, arg1: u256, arg2: 0x2::object::ID) {
        if (0x2::table::contains<u256, 0x2::object::ID>(&arg0.by_blob_id, arg1) && *0x2::table::borrow<u256, 0x2::object::ID>(&arg0.by_blob_id, arg1) == arg2) {
            0x2::table::remove<u256, 0x2::object::ID>(&mut arg0.by_blob_id, arg1);
        };
    }

    public fun lookup(arg0: &Pool, arg1: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg2: u256) : (bool, 0x2::object::ID, u32, bool) {
        if (!0x2::table::contains<u256, 0x2::object::ID>(&arg0.by_blob_id, arg2)) {
            return (false, 0x2::object::id_from_address(@0x0), 0, false)
        };
        let v0 = *0x2::table::borrow<u256, 0x2::object::ID>(&arg0.by_blob_id, arg2);
        let v1 = 0x2::object_table::borrow<0x2::object::ID, 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(&arg0.blobs, v0);
        (true, v0, 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::end_epoch(v1), 0x64d1f268981a07a9ec55174c5ef410ea985cf52c1729699f03fd068238ab6073::limits::renewable(0x1::option::is_some<u32>(0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::certified_epoch(v1)), 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::end_epoch(v1), 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::epoch(arg1), arg0.config.renew_window))
    }

    public fun max_size(arg0: &Config) : u64 {
        arg0.max_size
    }

    public fun max_wal_per_call(arg0: &Config) : u64 {
        arg0.max_wal_per_call
    }

    public fun migrate(arg0: &mut Pool, arg1: &AdminCap) {
        assert!(arg1.pool_id == 0x2::object::id<Pool>(arg0), 0);
        assert!(arg0.version < 1, 1);
        arg0.version = 1;
    }

    public fun new_config(arg0: u64, arg1: u32, arg2: u64, arg3: u64, arg4: u64, arg5: address, arg6: u64, arg7: u64, arg8: u32, arg9: u32) : Config {
        let v0 = if (arg1 > 0) {
            if (arg9 > 0) {
                arg9 >= arg8
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 8);
        Config{
            max_size         : arg0,
            epochs           : arg1,
            max_wal_per_call : arg2,
            epoch_budget_wal : arg3,
            epoch_budget_sui : arg4,
            tip_address      : arg5,
            tip_base         : arg6,
            tip_per_kib      : arg7,
            renew_window     : arg8,
            renew_epochs     : arg9,
            paused           : false,
        }
    }

    public fun paused(arg0: &Config) : bool {
        arg0.paused
    }

    public fun pool_id(arg0: &AdminCap) : 0x2::object::ID {
        arg0.pool_id
    }

    public fun register(arg0: &mut Pool, arg1: &mut 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg2: u256, arg3: u256, arg4: u64, arg5: u8, arg6: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        check_register_preconditions(arg0, arg4);
        let v0 = arg0.config;
        let v1 = 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::encoding::encoded_blob_length(arg4, arg5, 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::n_shards(arg1));
        let v2 = 0x2::balance::value<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&arg0.wal);
        assert!(v2 > 0, 5);
        let v3 = 0x1::u64::min(v0.max_wal_per_call, v2);
        let v4 = 0x2::coin::take<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&mut arg0.wal, v3, arg6);
        let v5 = 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::register_blob(arg1, 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::reserve_space(arg1, v1, v0.epochs, &mut v4, arg6), arg2, arg3, arg4, arg5, true, &mut v4, arg6);
        0x2::balance::join<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&mut arg0.wal, 0x2::coin::into_balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(v4));
        let v6 = 0x64d1f268981a07a9ec55174c5ef410ea985cf52c1729699f03fd068238ab6073::limits::tip_amount(v1, v0.tip_base, v0.tip_per_kib);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.sui) >= v6, 6);
        0x64d1f268981a07a9ec55174c5ef410ea985cf52c1729699f03fd068238ab6073::limits::charge(&mut arg0.spend, 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::epoch(arg1), v3 - 0x2::coin::value<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&v4), v6, v0.epoch_budget_wal, v0.epoch_budget_sui);
        if (v6 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.sui, v6, arg6), v0.tip_address);
        };
        let v7 = 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::object_id(&v5);
        let v8 = BlobRegistered{
            pool_id        : 0x2::object::id<Pool>(arg0),
            blob_object_id : v7,
            blob_id        : arg2,
            size           : arg4,
            end_epoch      : 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::end_epoch(&v5),
            sender         : 0x2::tx_context::sender(arg6),
        };
        0x2::event::emit<BlobRegistered>(v8);
        0x2::object_table::add<0x2::object::ID, 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(&mut arg0.blobs, v7, v5);
        v7
    }

    public fun renew(arg0: &mut Pool, arg1: &mut 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert!(!arg0.config.paused, 2);
        check_blob_exists(arg0, arg2);
        let v0 = arg0.config;
        let v1 = 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::epoch(arg1);
        let v2 = 0x2::object_table::borrow<0x2::object::ID, 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(&arg0.blobs, arg2);
        assert!(0x64d1f268981a07a9ec55174c5ef410ea985cf52c1729699f03fd068238ab6073::limits::renewable(0x1::option::is_some<u32>(0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::certified_epoch(v2)), 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::end_epoch(v2), v1, v0.renew_window), 7);
        let v3 = 0x2::balance::value<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&arg0.wal);
        assert!(v3 > 0, 5);
        let v4 = 0x1::u64::min(v0.max_wal_per_call, v3);
        let v5 = 0x2::coin::take<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&mut arg0.wal, v4, arg3);
        let v6 = 0x2::object_table::borrow_mut<0x2::object::ID, 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(&mut arg0.blobs, arg2);
        0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::extend_blob(arg1, v6, v0.renew_epochs, &mut v5);
        0x2::balance::join<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&mut arg0.wal, 0x2::coin::into_balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(v5));
        0x64d1f268981a07a9ec55174c5ef410ea985cf52c1729699f03fd068238ab6073::limits::charge(&mut arg0.spend, v1, v4 - 0x2::coin::value<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&v5), 0, v0.epoch_budget_wal, v0.epoch_budget_sui);
        let v7 = BlobExtended{
            pool_id        : 0x2::object::id<Pool>(arg0),
            blob_object_id : arg2,
            epochs         : v0.renew_epochs,
            end_epoch      : 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::end_epoch(v6),
        };
        0x2::event::emit<BlobExtended>(v7);
    }

    public fun renew_epochs(arg0: &Config) : u32 {
        arg0.renew_epochs
    }

    public fun renew_window(arg0: &Config) : u32 {
        arg0.renew_window
    }

    public fun set_config(arg0: &mut Pool, arg1: &AdminCap, arg2: Config) {
        assert_admin(arg0, arg1);
        arg0.config = arg2;
    }

    public fun set_paused(arg0: &mut Pool, arg1: &AdminCap, arg2: bool) {
        assert_admin(arg0, arg1);
        arg0.config.paused = arg2;
    }

    public fun sui_balance(arg0: &Pool) : u64 {
        assert_version(arg0);
        0x2::balance::value<0x2::sui::SUI>(&arg0.sui)
    }

    public fun tip_address(arg0: &Config) : address {
        arg0.tip_address
    }

    public fun tip_base(arg0: &Config) : u64 {
        arg0.tip_base
    }

    public fun tip_per_kib(arg0: &Config) : u64 {
        arg0.tip_per_kib
    }

    public fun wal_balance(arg0: &Pool) : u64 {
        assert_version(arg0);
        0x2::balance::value<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&arg0.wal)
    }

    public fun withdraw_sui(arg0: &mut Pool, arg1: &AdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert_admin(arg0, arg1);
        0x2::coin::take<0x2::sui::SUI>(&mut arg0.sui, arg2, arg3)
    }

    public fun withdraw_wal(arg0: &mut Pool, arg1: &AdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL> {
        assert_admin(arg0, arg1);
        0x2::coin::take<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&mut arg0.wal, arg2, arg3)
    }

    // decompiled from Move bytecode v7
}

