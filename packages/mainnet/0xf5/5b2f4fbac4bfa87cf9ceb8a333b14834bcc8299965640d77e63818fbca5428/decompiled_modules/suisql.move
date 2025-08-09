module 0x650ff3788c4dbc7dcb3f909fd01642fd8a772dc7e003e575c9d502d51b07cabe::suisql {
    struct SuiSqlBank has store, key {
        id: 0x2::object::UID,
        map: 0x2::table::Table<0x1::ascii::String, address>,
    }

    struct SuiSqlDb has store, key {
        id: 0x2::object::UID,
        owner: address,
        name: 0x1::ascii::String,
        patches: vector<vector<u8>>,
        walrus_blob_id: 0x1::option::Option<u256>,
        walrus_blob: 0x1::option::Option<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>,
        expected_walrus_blob_id: 0x1::option::Option<u256>,
    }

    struct WriteCap has store, key {
        id: 0x2::object::UID,
        sui_sql_db_id: 0x2::object::ID,
    }

    struct SUISQL has drop {
        dummy_field: bool,
    }

    fun assert_walrus_blob(arg0: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob, arg1: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System) {
        if (!0x1::option::is_some<u32>(0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::certified_epoch(arg0))) {
            abort 3
        };
        if (0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::end_epoch(arg0) <= 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::epoch(arg1)) {
            abort 4
        };
    }

    fun assert_write_cap(arg0: &SuiSqlDb, arg1: &WriteCap) {
        if (arg1.sui_sql_db_id != 0x2::object::id<SuiSqlDb>(arg0)) {
            abort 2
        };
    }

    fun attach_walrus_blob_reusing_storage(arg0: &mut SuiSqlDb, arg1: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg2: 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob, arg3: &mut 0x2::tx_context::TxContext) {
        if (can_extend_walrus_blob(arg0, arg1, &arg2)) {
            let v0 = 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::delete_blob(arg1, 0x1::option::extract<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(&mut arg0.walrus_blob));
            0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::extend_blob_with_resource(arg1, &mut arg2, 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::split_by_epoch(&mut v0, 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::end_epoch(&arg2), arg3));
            0x1::option::fill<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(&mut arg0.walrus_blob, arg2);
            0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::destroy(v0);
        } else if (0x1::option::is_some<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(&arg0.walrus_blob)) {
            0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::shared_blob::new(0x1::option::swap<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(&mut arg0.walrus_blob, arg2), arg3);
        } else {
            0x1::option::fill<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(&mut arg0.walrus_blob, arg2);
        };
    }

    fun can_extend_walrus_blob(arg0: &SuiSqlDb, arg1: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg2: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob) : bool {
        if (0x1::option::is_none<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(&arg0.walrus_blob)) {
            return false
        };
        let v0 = 0x1::option::borrow<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(&arg0.walrus_blob);
        if (0x1::option::is_none<u32>(0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::certified_epoch(v0)) || !0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::is_deletable(v0)) {
            return false
        };
        let v1 = 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::end_epoch(v0);
        if (0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::epoch(arg1) >= v1) {
            return false
        };
        if (0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::end_epoch(arg2) >= v1) {
            return false
        };
        if (0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::size(0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::storage(v0)) != 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::size(0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::storage(arg2))) {
            return false
        };
        true
    }

    public entry fun clamp_with_walrus(arg0: &mut SuiSqlDb, arg1: &WriteCap, arg2: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg3: 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob, arg4: &mut 0x2::tx_context::TxContext) {
        assert_write_cap(arg0, arg1);
        replace_walrus_blob(arg0, arg2, arg3, arg4);
    }

    public entry fun db(arg0: &mut SuiSqlBank, arg1: 0x1::ascii::String, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x2::table::contains<0x1::ascii::String, address>(&arg0.map, arg1)) {
            abort 1
        };
        let v0 = SuiSqlDb{
            id                      : 0x2::object::new(arg2),
            owner                   : 0x2::tx_context::sender(arg2),
            name                    : arg1,
            patches                 : 0x1::vector::empty<vector<u8>>(),
            walrus_blob_id          : 0x1::option::none<u256>(),
            walrus_blob             : 0x1::option::none<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(),
            expected_walrus_blob_id : 0x1::option::none<u256>(),
        };
        let v1 = WriteCap{
            id            : 0x2::object::new(arg2),
            sui_sql_db_id : 0x2::object::id<SuiSqlDb>(&v0),
        };
        let v2 = 0x2::object::id<SuiSqlDb>(&v0);
        let v3 = 0x2::object::id<WriteCap>(&v1);
        0x650ff3788c4dbc7dcb3f909fd01642fd8a772dc7e003e575c9d502d51b07cabe::suisql_events::emit_new_db_event(&v2, arg1, &v3);
        let v4 = 0x2::object::id<SuiSqlDb>(&v0);
        0x2::table::add<0x1::ascii::String, address>(&mut arg0.map, arg1, 0x2::object::id_to_address(&v4));
        0x2::transfer::transfer<WriteCap>(v1, 0x2::tx_context::sender(arg2));
        0x2::transfer::share_object<SuiSqlDb>(v0);
    }

    public entry fun expect_walrus(arg0: &mut SuiSqlDb, arg1: &WriteCap, arg2: u256, arg3: &mut 0x2::tx_context::TxContext) {
        assert_write_cap(arg0, arg1);
        arg0.expected_walrus_blob_id = 0x1::option::some<u256>(arg2);
    }

    public entry fun extend_walrus(arg0: &mut SuiSqlDb, arg1: &mut 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg2: u32, arg3: &mut 0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>) {
        if (0x1::option::is_none<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(&arg0.walrus_blob)) {
            abort 3
        };
        0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::extend_blob(arg1, 0x1::option::borrow_mut<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(&mut arg0.walrus_blob), arg2, arg3);
    }

    public entry fun fill_expected_walrus(arg0: &mut SuiSqlDb, arg1: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg2: 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob, arg3: &mut 0x2::tx_context::TxContext) {
        if (0x1::option::is_none<u256>(&arg0.expected_walrus_blob_id)) {
            abort 3
        };
        if (0x1::option::get_with_default<u256>(&arg0.expected_walrus_blob_id, 0) != 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::blob_id(&arg2)) {
            abort 3
        };
        assert_walrus_blob(&arg2, arg1);
        replace_walrus_blob(arg0, arg1, arg2, arg3);
    }

    public fun find_db_by_name(arg0: &SuiSqlBank, arg1: 0x1::ascii::String) {
        if (0x2::table::contains<0x1::ascii::String, address>(&arg0.map, arg1)) {
            0x650ff3788c4dbc7dcb3f909fd01642fd8a772dc7e003e575c9d502d51b07cabe::suisql_events::emit_remind_db_event(*0x2::table::borrow<0x1::ascii::String, address>(&arg0.map, arg1), arg1);
        };
    }

    fun init(arg0: SUISQL, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = SuiSqlBank{
            id  : 0x2::object::new(arg1),
            map : 0x2::table::new<0x1::ascii::String, address>(arg1),
        };
        let v1 = 0x2::object::id<SuiSqlBank>(&v0);
        0x650ff3788c4dbc7dcb3f909fd01642fd8a772dc7e003e575c9d502d51b07cabe::suisql_events::emit_new_bank_event(&v1);
        0x2::transfer::share_object<SuiSqlBank>(v0);
    }

    public entry fun patch(arg0: &mut SuiSqlDb, arg1: &WriteCap, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        assert_write_cap(arg0, arg1);
        0x1::vector::push_back<vector<u8>>(&mut arg0.patches, arg2);
        arg0.expected_walrus_blob_id = 0x1::option::none<u256>();
    }

    public entry fun patch_and_expect_walrus(arg0: &mut SuiSqlDb, arg1: &WriteCap, arg2: vector<u8>, arg3: u256, arg4: &mut 0x2::tx_context::TxContext) {
        assert_write_cap(arg0, arg1);
        0x1::vector::push_back<vector<u8>>(&mut arg0.patches, arg2);
        arg0.expected_walrus_blob_id = 0x1::option::some<u256>(arg3);
    }

    fun register_walrus_blob_reusing_storage(arg0: &mut SuiSqlDb, arg1: &mut 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg2: u256, arg3: u256, arg4: &mut 0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>, arg5: &mut 0x2::tx_context::TxContext) : 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob {
        let v0 = 0x1::option::extract<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(&mut arg0.walrus_blob);
        let v1 = 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::delete_blob(arg1, v0);
        0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::register_blob(arg1, v1, arg2, arg3, 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::size(&v1), 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::encoding_type(&v0), true, arg4, arg5)
    }

    fun replace_walrus_blob(arg0: &mut SuiSqlDb, arg1: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg2: 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob, arg3: &mut 0x2::tx_context::TxContext) {
        assert_walrus_blob(&arg2, arg1);
        arg0.walrus_blob_id = 0x1::option::some<u256>(0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::blob_id(&arg2));
        attach_walrus_blob_reusing_storage(arg0, arg1, arg2, arg3);
        arg0.patches = 0x1::vector::empty<vector<u8>>();
        arg0.expected_walrus_blob_id = 0x1::option::none<u256>();
    }

    public fun walrus_end_epoch(arg0: &SuiSqlDb) : u32 {
        if (0x1::option::is_none<u256>(&arg0.walrus_blob_id)) {
            return 0
        };
        0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::end_epoch(0x1::option::borrow<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(&arg0.walrus_blob))
    }

    // decompiled from Move bytecode v6
}

