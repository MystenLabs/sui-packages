module 0x65e8082dd7795f538b06b20d831b698074d892eda342f9fe07600a63933d41fc::blob_manager {
    struct BlobsRegistered has copy, drop {
        uploader: address,
        main_blob_id: 0x1::string::String,
        preview_blob_id: 0x1::string::String,
        seal_policy_id: 0x1::string::String,
        duration_seconds: u64,
        fee_paid_sui: u64,
    }

    public fun batch_register_blobs(arg0: &mut 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg1: 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::Storage, arg2: u256, arg3: u256, arg4: u64, arg5: u8, arg6: bool, arg7: 0x1::string::String, arg8: 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::Storage, arg9: u256, arg10: u256, arg11: u64, arg12: u8, arg13: bool, arg14: 0x1::string::String, arg15: 0x1::string::String, arg16: vector<u8>, arg17: u64, arg18: &mut 0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>, arg19: 0x2::coin::Coin<0x2::sui::SUI>, arg20: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg20);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg19) >= 250000000, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg19, 250000000, arg20), @0xca793690985183dc8e2180fd059d76f3b0644f5c2ecd3b01cdebe7d40b0cca39);
        if (0x2::coin::value<0x2::sui::SUI>(&arg19) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg19, v0);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg19);
        };
        0x2::transfer::public_transfer<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::register_blob(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg18, arg20), v0);
        0x2::transfer::public_transfer<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::register_blob(arg0, arg8, arg9, arg10, arg11, arg12, arg13, arg18, arg20), v0);
        let v1 = BlobsRegistered{
            uploader         : v0,
            main_blob_id     : arg7,
            preview_blob_id  : arg14,
            seal_policy_id   : arg15,
            duration_seconds : arg17,
            fee_paid_sui     : 250000000,
        };
        0x2::event::emit<BlobsRegistered>(v1);
    }

    // decompiled from Move bytecode v6
}

