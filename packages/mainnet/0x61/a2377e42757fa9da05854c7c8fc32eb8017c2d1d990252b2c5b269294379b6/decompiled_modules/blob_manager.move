module 0x61a2377e42757fa9da05854c7c8fc32eb8017c2d1d990252b2c5b269294379b6::blob_manager {
    public fun batch_register_and_submit(arg0: &mut 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg1: &mut 0x61a2377e42757fa9da05854c7c8fc32eb8017c2d1d990252b2c5b269294379b6::marketplace::QualityMarketplace, arg2: 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::Storage, arg3: u256, arg4: u256, arg5: u64, arg6: u8, arg7: bool, arg8: 0x1::string::String, arg9: 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::Storage, arg10: u256, arg11: u256, arg12: u64, arg13: u8, arg14: bool, arg15: 0x1::string::String, arg16: 0x1::string::String, arg17: 0x1::option::Option<vector<u8>>, arg18: u64, arg19: &mut 0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>, arg20: 0x2::coin::Coin<0x2::sui::SUI>, arg21: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::register_blob(arg0, arg2, arg3, arg4, arg5, arg6, arg7, arg19, arg21), 0x2::tx_context::sender(arg21));
        0x2::transfer::public_transfer<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::register_blob(arg0, arg9, arg10, arg11, arg12, arg13, arg14, arg19, arg21), 0x2::tx_context::sender(arg21));
        0x61a2377e42757fa9da05854c7c8fc32eb8017c2d1d990252b2c5b269294379b6::marketplace::submit_audio(arg1, arg20, arg8, arg15, arg16, arg17, arg18, arg21);
    }

    // decompiled from Move bytecode v6
}

