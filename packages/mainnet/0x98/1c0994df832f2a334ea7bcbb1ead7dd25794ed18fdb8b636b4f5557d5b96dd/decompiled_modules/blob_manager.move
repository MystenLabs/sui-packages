module 0x981c0994df832f2a334ea7bcbb1ead7dd25794ed18fdb8b636b4f5557d5b96dd::blob_manager {
    struct BlobsSubmitted has copy, drop {
        uploader: address,
        main_blob_id: 0x1::string::String,
        preview_blob_id: 0x1::string::String,
        seal_policy_id: 0x1::string::String,
        duration_seconds: u64,
        fee_paid_sui: u64,
        main_blob_object_id: address,
        preview_blob_object_id: address,
        storage_epochs: u32,
    }

    public fun submit_and_register_blobs(arg0: &mut 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg1: u256, arg2: u256, arg3: u64, arg4: u256, arg5: u256, arg6: u64, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: u64, arg11: u8, arg12: u32, arg13: &mut 0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>, arg14: 0x2::coin::Coin<0x2::sui::SUI>, arg15: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg15);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg14);
        assert!(v1 >= 500000000, 1);
        assert!(v1 <= 10000000000, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg14, @0xca793690985183dc8e2180fd059d76f3b0644f5c2ecd3b01cdebe7d40b0cca39);
        let v2 = arg6 * 2;
        let v3 = 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::reserve_space(arg0, arg3 * 2 + v2, arg12, arg13, arg15);
        let v4 = 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::register_blob(arg0, v3, arg1, arg2, arg3, arg11, false, arg13, arg15);
        let v5 = 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::register_blob(arg0, 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::split_by_size(&mut v3, v2, arg15), arg4, arg5, arg6, arg11, false, arg13, arg15);
        let v6 = 0x2::object::id<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(&v4);
        let v7 = 0x2::object::id<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(&v5);
        0x2::transfer::public_transfer<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(v4, v0);
        0x2::transfer::public_transfer<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(v5, v0);
        let v8 = BlobsSubmitted{
            uploader               : v0,
            main_blob_id           : arg7,
            preview_blob_id        : arg8,
            seal_policy_id         : arg9,
            duration_seconds       : arg10,
            fee_paid_sui           : v1,
            main_blob_object_id    : 0x2::object::id_to_address(&v6),
            preview_blob_object_id : 0x2::object::id_to_address(&v7),
            storage_epochs         : arg12,
        };
        0x2::event::emit<BlobsSubmitted>(v8);
    }

    public fun submit_blobs(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: u64, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg4);
        assert!(v0 >= 500000000, 1);
        assert!(v0 <= 10000000000, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg4, @0xca793690985183dc8e2180fd059d76f3b0644f5c2ecd3b01cdebe7d40b0cca39);
        let v1 = BlobsSubmitted{
            uploader               : 0x2::tx_context::sender(arg5),
            main_blob_id           : arg0,
            preview_blob_id        : arg1,
            seal_policy_id         : arg2,
            duration_seconds       : arg3,
            fee_paid_sui           : v0,
            main_blob_object_id    : @0x0,
            preview_blob_object_id : @0x0,
            storage_epochs         : 0,
        };
        0x2::event::emit<BlobsSubmitted>(v1);
    }

    // decompiled from Move bytecode v6
}

