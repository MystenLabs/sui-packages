module 0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::sponsor_pool {
    struct SponsorConfig has key {
        id: 0x2::object::UID,
        fee_bps: u64,
        max_storage_price_per_unit: u64,
        max_write_price_per_unit: u64,
        fees: 0x2::balance::Balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>,
    }

    struct SponsorPool has key {
        id: 0x2::object::UID,
        form_id: address,
        config_id: 0x2::object::ID,
        wal: 0x2::balance::Balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>,
        sui: 0x2::balance::Balance<0x2::sui::SUI>,
        platform_fees: 0x2::balance::Balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>,
        enabled: bool,
        max_wal_per_upload: u64,
        max_tip_per_upload: u64,
        max_uploads_per_address: u64,
        uploads_by_address: 0x2::table::Table<address, u64>,
        settled_blobs: 0x2::table::Table<0x2::object::ID, bool>,
        total_uploads: u64,
        total_wal_spent: u64,
        total_fees_paid: u64,
        total_tips_paid: u64,
    }

    struct SponsorReceipt {
        pool_id: 0x2::object::ID,
        borrowed: u64,
        fee_bps: u64,
        fee_reserve: 0x2::balance::Balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>,
        tip: u64,
        tip_taken: bool,
    }

    struct SponsorConfigCreated has copy, drop {
        config_id: 0x2::object::ID,
        fee_bps: u64,
        max_storage_price_per_unit: u64,
        max_write_price_per_unit: u64,
    }

    struct SponsorConfigUpdated has copy, drop {
        config_id: 0x2::object::ID,
        fee_bps: u64,
        max_storage_price_per_unit: u64,
        max_write_price_per_unit: u64,
    }

    struct SponsorFeesWithdrawn has copy, drop {
        config_id: 0x2::object::ID,
        amount: u64,
    }

    struct SponsorPoolCreated has copy, drop {
        pool_id: 0x2::object::ID,
        form_id: address,
        config_id: 0x2::object::ID,
        creator: address,
    }

    struct SponsorPoolFunded has copy, drop {
        pool_id: 0x2::object::ID,
        form_id: address,
        funder: address,
        wal: u64,
        sui: u64,
    }

    struct SponsorPoolWithdrawn has copy, drop {
        pool_id: 0x2::object::ID,
        form_id: address,
        wal: u64,
        sui: u64,
    }

    struct SponsorPoolUpdated has copy, drop {
        pool_id: 0x2::object::ID,
        form_id: address,
        enabled: bool,
        max_wal_per_upload: u64,
        max_tip_per_upload: u64,
        max_uploads_per_address: u64,
    }

    struct SponsoredBlobRegistered has copy, drop {
        pool_id: 0x2::object::ID,
        form_id: address,
        uploader: address,
        blob_object_id: 0x2::object::ID,
        blob_id: u256,
        encoded_size: u64,
        end_epoch: u32,
        wal_spent: u64,
        fee: u64,
        tip: u64,
    }

    public fun borrow(arg0: &mut SponsorPool, arg1: &SponsorConfig, arg2: &0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::form::Form, arg3: &0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::allowlist::Allowlist, arg4: &0x2::clock::Clock, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>, SponsorReceipt) {
        assert!(arg0.config_id == 0x2::object::id<SponsorConfig>(arg1), 9);
        assert!(0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::form::id_address(arg2) == arg0.form_id, 1);
        assert!(arg0.enabled, 2);
        assert!(arg5 > 0, 21);
        assert!(arg5 <= arg0.max_wal_per_upload, 3);
        assert_can_submit(arg2, arg3, arg4, 0x2::tx_context::sender(arg6));
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = if (0x2::table::contains<address, u64>(&arg0.uploads_by_address, v0)) {
            *0x2::table::borrow<address, u64>(&arg0.uploads_by_address, v0)
        } else {
            0
        };
        assert!(arg0.max_uploads_per_address == 0 || v1 < arg0.max_uploads_per_address, 5);
        if (0x2::table::contains<address, u64>(&arg0.uploads_by_address, v0)) {
            *0x2::table::borrow_mut<address, u64>(&mut arg0.uploads_by_address, v0) = v1 + 1;
        } else {
            0x2::table::add<address, u64>(&mut arg0.uploads_by_address, v0, 1);
        };
        let v2 = arg1.fee_bps;
        let v3 = mul_div(arg5, v2, 10000);
        assert!(0x2::balance::value<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&arg0.wal) >= arg5 + v3, 6);
        let v4 = SponsorReceipt{
            pool_id     : 0x2::object::id<SponsorPool>(arg0),
            borrowed    : arg5,
            fee_bps     : v2,
            fee_reserve : 0x2::balance::split<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&mut arg0.wal, v3),
            tip         : 0,
            tip_taken   : false,
        };
        (0x2::coin::from_balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(0x2::balance::split<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&mut arg0.wal, arg5), arg6), v4)
    }

    fun assert_can_submit(arg0: &0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::form::Form, arg1: &0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::allowlist::Allowlist, arg2: &0x2::clock::Clock, arg3: address) {
        assert!(!0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::form::closed(arg0), 16);
        let v0 = 0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::form::settings(arg0);
        let v1 = 0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::form::closes_at_ms(v0);
        assert!(v1 == 0 || 0x2::clock::timestamp_ms(arg2) < v1, 17);
        let v2 = 0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::form::max_submissions(v0);
        assert!(v2 == 0 || 0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::form::submission_count(0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::form::stats(arg0)) < v2, 18);
        if (0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::form::access_mode(v0) == 0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::form::access_allowlist()) {
            assert!(0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::allowlist::form_id(arg1) == 0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::form::id_address(arg0), 20);
            assert!(0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::allowlist::contains(arg1, arg3), 19);
        };
    }

    fun assert_owner(arg0: &SponsorPool, arg1: &0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::form_owner_cap::FormOwnerCap) {
        assert!(0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::form_owner_cap::form_id(arg1) == arg0.form_id, 1);
    }

    public fun config_fee_bps(arg0: &SponsorConfig) : u64 {
        arg0.fee_bps
    }

    public fun config_fees(arg0: &SponsorConfig) : u64 {
        0x2::balance::value<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&arg0.fees)
    }

    public fun config_max_storage_price_per_unit(arg0: &SponsorConfig) : u64 {
        arg0.max_storage_price_per_unit
    }

    public fun config_max_write_price_per_unit(arg0: &SponsorConfig) : u64 {
        arg0.max_write_price_per_unit
    }

    public fun create_config(arg0: &0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::template::PlatformAdminCap, arg1: u64, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : SponsorConfig {
        assert!(arg1 <= 2000, 14);
        let v0 = SponsorConfig{
            id                         : 0x2::object::new(arg4),
            fee_bps                    : arg1,
            max_storage_price_per_unit : arg2,
            max_write_price_per_unit   : arg3,
            fees                       : 0x2::balance::zero<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(),
        };
        let v1 = SponsorConfigCreated{
            config_id                  : 0x2::object::id<SponsorConfig>(&v0),
            fee_bps                    : arg1,
            max_storage_price_per_unit : arg2,
            max_write_price_per_unit   : arg3,
        };
        0x2::event::emit<SponsorConfigCreated>(v1);
        v0
    }

    public fun create_config_and_share(arg0: &0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::template::PlatformAdminCap, arg1: u64, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        share_config(create_config(arg0, arg1, arg2, arg3, arg4));
    }

    public fun create_pool(arg0: &SponsorConfig, arg1: &0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::form_owner_cap::FormOwnerCap, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : SponsorPool {
        let v0 = SponsorPool{
            id                      : 0x2::object::new(arg5),
            form_id                 : 0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::form_owner_cap::form_id(arg1),
            config_id               : 0x2::object::id<SponsorConfig>(arg0),
            wal                     : 0x2::balance::zero<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(),
            sui                     : 0x2::balance::zero<0x2::sui::SUI>(),
            platform_fees           : 0x2::balance::zero<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(),
            enabled                 : true,
            max_wal_per_upload      : arg2,
            max_tip_per_upload      : arg3,
            max_uploads_per_address : arg4,
            uploads_by_address      : 0x2::table::new<address, u64>(arg5),
            settled_blobs           : 0x2::table::new<0x2::object::ID, bool>(arg5),
            total_uploads           : 0,
            total_wal_spent         : 0,
            total_fees_paid         : 0,
            total_tips_paid         : 0,
        };
        let v1 = SponsorPoolCreated{
            pool_id   : 0x2::object::id<SponsorPool>(&v0),
            form_id   : v0.form_id,
            config_id : v0.config_id,
            creator   : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<SponsorPoolCreated>(v1);
        v0
    }

    public fun create_pool_and_share(arg0: &SponsorConfig, arg1: &0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::form_owner_cap::FormOwnerCap, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        share_pool(create_pool(arg0, arg1, arg2, arg3, arg4, arg5));
    }

    public fun deposit_sui(arg0: &mut SponsorPool, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::tx_context::TxContext) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        let v0 = SponsorPoolFunded{
            pool_id : 0x2::object::id<SponsorPool>(arg0),
            form_id : arg0.form_id,
            funder  : 0x2::tx_context::sender(arg2),
            wal     : 0,
            sui     : 0x2::coin::value<0x2::sui::SUI>(&arg1),
        };
        0x2::event::emit<SponsorPoolFunded>(v0);
    }

    public fun deposit_wal(arg0: &mut SponsorPool, arg1: 0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>, arg2: &0x2::tx_context::TxContext) {
        0x2::balance::join<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&mut arg0.wal, 0x2::coin::into_balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(arg1));
        let v0 = SponsorPoolFunded{
            pool_id : 0x2::object::id<SponsorPool>(arg0),
            form_id : arg0.form_id,
            funder  : 0x2::tx_context::sender(arg2),
            wal     : 0x2::coin::value<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&arg1),
            sui     : 0,
        };
        0x2::event::emit<SponsorPoolFunded>(v0);
    }

    fun emit_config_updated(arg0: &SponsorConfig) {
        let v0 = SponsorConfigUpdated{
            config_id                  : 0x2::object::id<SponsorConfig>(arg0),
            fee_bps                    : arg0.fee_bps,
            max_storage_price_per_unit : arg0.max_storage_price_per_unit,
            max_write_price_per_unit   : arg0.max_write_price_per_unit,
        };
        0x2::event::emit<SponsorConfigUpdated>(v0);
    }

    fun emit_pool_updated(arg0: &SponsorPool) {
        let v0 = SponsorPoolUpdated{
            pool_id                 : 0x2::object::id<SponsorPool>(arg0),
            form_id                 : arg0.form_id,
            enabled                 : arg0.enabled,
            max_wal_per_upload      : arg0.max_wal_per_upload,
            max_tip_per_upload      : arg0.max_tip_per_upload,
            max_uploads_per_address : arg0.max_uploads_per_address,
        };
        0x2::event::emit<SponsorPoolUpdated>(v0);
    }

    public fun max_cost(arg0: &SponsorConfig, arg1: u64, arg2: u32) : u64 {
        (((((arg1 + 1048576 - 1) / 1048576) as u128) * ((arg0.max_storage_price_per_unit as u128) * (arg2 as u128) + (arg0.max_write_price_per_unit as u128))) as u64)
    }

    public fun max_fee_bps() : u64 {
        2000
    }

    fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    public fun pool_config_id(arg0: &SponsorPool) : 0x2::object::ID {
        arg0.config_id
    }

    public fun pool_enabled(arg0: &SponsorPool) : bool {
        arg0.enabled
    }

    public fun pool_form_id(arg0: &SponsorPool) : address {
        arg0.form_id
    }

    public fun pool_is_settled(arg0: &SponsorPool, arg1: 0x2::object::ID) : bool {
        0x2::table::contains<0x2::object::ID, bool>(&arg0.settled_blobs, arg1)
    }

    public fun pool_max_tip_per_upload(arg0: &SponsorPool) : u64 {
        arg0.max_tip_per_upload
    }

    public fun pool_max_uploads_per_address(arg0: &SponsorPool) : u64 {
        arg0.max_uploads_per_address
    }

    public fun pool_max_wal_per_upload(arg0: &SponsorPool) : u64 {
        arg0.max_wal_per_upload
    }

    public fun pool_platform_fees(arg0: &SponsorPool) : u64 {
        0x2::balance::value<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&arg0.platform_fees)
    }

    public fun pool_sui(arg0: &SponsorPool) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.sui)
    }

    public fun pool_total_fees_paid(arg0: &SponsorPool) : u64 {
        arg0.total_fees_paid
    }

    public fun pool_total_tips_paid(arg0: &SponsorPool) : u64 {
        arg0.total_tips_paid
    }

    public fun pool_total_uploads(arg0: &SponsorPool) : u64 {
        arg0.total_uploads
    }

    public fun pool_total_wal_spent(arg0: &SponsorPool) : u64 {
        arg0.total_wal_spent
    }

    public fun pool_uploads_of(arg0: &SponsorPool, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.uploads_by_address, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.uploads_by_address, arg1)
        } else {
            0
        }
    }

    public fun pool_wal(arg0: &SponsorPool) : u64 {
        0x2::balance::value<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&arg0.wal)
    }

    public fun set_enabled(arg0: &mut SponsorPool, arg1: &0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::form_owner_cap::FormOwnerCap, arg2: bool) {
        assert_owner(arg0, arg1);
        arg0.enabled = arg2;
        emit_pool_updated(arg0);
    }

    public fun set_fee_bps(arg0: &mut SponsorConfig, arg1: &0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::template::PlatformAdminCap, arg2: u64) {
        assert!(arg2 <= 2000, 14);
        arg0.fee_bps = arg2;
        emit_config_updated(arg0);
    }

    public fun set_limits(arg0: &mut SponsorPool, arg1: &0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::form_owner_cap::FormOwnerCap, arg2: u64, arg3: u64, arg4: u64) {
        assert_owner(arg0, arg1);
        arg0.max_wal_per_upload = arg2;
        arg0.max_tip_per_upload = arg3;
        arg0.max_uploads_per_address = arg4;
        emit_pool_updated(arg0);
    }

    public fun set_price_caps(arg0: &mut SponsorConfig, arg1: &0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::template::PlatformAdminCap, arg2: u64, arg3: u64) {
        arg0.max_storage_price_per_unit = arg2;
        arg0.max_write_price_per_unit = arg3;
        emit_config_updated(arg0);
    }

    public fun settle(arg0: &mut SponsorPool, arg1: &SponsorConfig, arg2: SponsorReceipt, arg3: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob, arg4: 0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>, arg5: &0x2::tx_context::TxContext) {
        let v0 = 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::storage(arg3);
        settle_inner(arg0, arg1, arg2, 0x2::object::id<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(arg3), 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::blob_id(arg3), 0x1::option::is_some<u32>(0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::certified_epoch(arg3)), 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::size(v0), 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::start_epoch(v0), 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::end_epoch(v0), arg4, 0x2::tx_context::sender(arg5));
    }

    fun settle_inner(arg0: &mut SponsorPool, arg1: &SponsorConfig, arg2: SponsorReceipt, arg3: 0x2::object::ID, arg4: u256, arg5: bool, arg6: u64, arg7: u32, arg8: u32, arg9: 0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>, arg10: address) {
        let SponsorReceipt {
            pool_id     : v0,
            borrowed    : v1,
            fee_bps     : v2,
            fee_reserve : v3,
            tip         : v4,
            tip_taken   : _,
        } = arg2;
        let v6 = v3;
        assert!(v0 == 0x2::object::id<SponsorPool>(arg0), 8);
        assert!(arg0.config_id == 0x2::object::id<SponsorConfig>(arg1), 9);
        assert!(!arg5, 11);
        assert!(!0x2::table::contains<0x2::object::ID, bool>(&arg0.settled_blobs, arg3), 10);
        let v7 = 0x2::coin::value<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&arg9);
        assert!(v7 <= v1, 13);
        let v8 = v1 - v7;
        assert!(v8 <= max_cost(arg1, arg6, arg8 - arg7), 12);
        0x2::balance::join<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&mut arg0.wal, 0x2::coin::into_balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(arg9));
        let v9 = mul_div(v8, v2, 10000);
        0x2::balance::join<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&mut arg0.platform_fees, 0x2::balance::split<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&mut v6, v9));
        0x2::balance::join<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&mut arg0.wal, v6);
        0x2::table::add<0x2::object::ID, bool>(&mut arg0.settled_blobs, arg3, true);
        arg0.total_uploads = arg0.total_uploads + 1;
        arg0.total_wal_spent = arg0.total_wal_spent + v8;
        arg0.total_fees_paid = arg0.total_fees_paid + v9;
        arg0.total_tips_paid = arg0.total_tips_paid + v4;
        let v10 = SponsoredBlobRegistered{
            pool_id        : v0,
            form_id        : arg0.form_id,
            uploader       : arg10,
            blob_object_id : arg3,
            blob_id        : arg4,
            encoded_size   : arg6,
            end_epoch      : arg8,
            wal_spent      : v8,
            fee            : v9,
            tip            : v4,
        };
        0x2::event::emit<SponsoredBlobRegistered>(v10);
    }

    public fun share_config(arg0: SponsorConfig) {
        0x2::transfer::share_object<SponsorConfig>(arg0);
    }

    public fun share_pool(arg0: SponsorPool) {
        0x2::transfer::share_object<SponsorPool>(arg0);
    }

    public fun sweep_fees(arg0: &mut SponsorPool, arg1: &mut SponsorConfig) {
        assert!(arg0.config_id == 0x2::object::id<SponsorConfig>(arg1), 9);
        0x2::balance::join<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&mut arg1.fees, 0x2::balance::withdraw_all<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&mut arg0.platform_fees));
    }

    public fun take_relay_tip(arg0: &mut SponsorPool, arg1: &mut SponsorReceipt, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(arg1.pool_id == 0x2::object::id<SponsorPool>(arg0), 8);
        assert!(!arg1.tip_taken, 15);
        assert!(arg2 <= arg0.max_tip_per_upload, 4);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.sui) >= arg2, 7);
        arg1.tip_taken = true;
        arg1.tip = arg2;
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui, arg2), arg3)
    }

    public fun withdraw_fees(arg0: &mut SponsorConfig, arg1: &0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::template::PlatformAdminCap, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL> {
        let v0 = SponsorFeesWithdrawn{
            config_id : 0x2::object::id<SponsorConfig>(arg0),
            amount    : 0x2::balance::value<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&arg0.fees),
        };
        0x2::event::emit<SponsorFeesWithdrawn>(v0);
        0x2::coin::from_balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(0x2::balance::withdraw_all<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&mut arg0.fees), arg2)
    }

    public fun withdraw_sui(arg0: &mut SponsorPool, arg1: &0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::form_owner_cap::FormOwnerCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert_owner(arg0, arg1);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.sui) >= arg2, 7);
        let v0 = SponsorPoolWithdrawn{
            pool_id : 0x2::object::id<SponsorPool>(arg0),
            form_id : arg0.form_id,
            wal     : 0,
            sui     : arg2,
        };
        0x2::event::emit<SponsorPoolWithdrawn>(v0);
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui, arg2), arg3)
    }

    public fun withdraw_wal(arg0: &mut SponsorPool, arg1: &0x128bec074eff2c7ad03b52f45321c529958f75633d74668373e890d23fb64bb::form_owner_cap::FormOwnerCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL> {
        assert_owner(arg0, arg1);
        assert!(0x2::balance::value<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&arg0.wal) >= arg2, 6);
        let v0 = SponsorPoolWithdrawn{
            pool_id : 0x2::object::id<SponsorPool>(arg0),
            form_id : arg0.form_id,
            wal     : arg2,
            sui     : 0,
        };
        0x2::event::emit<SponsorPoolWithdrawn>(v0);
        0x2::coin::from_balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(0x2::balance::split<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&mut arg0.wal, arg2), arg3)
    }

    // decompiled from Move bytecode v7
}

