module 0x90cbc5d02db5d236bf6672ab0da60bd922df4f3bfe505c35d019790c1e008322::payment {
    fun charge_platform_fee(arg0: &mut 0x90cbc5d02db5d236bf6672ab0da60bd922df4f3bfe505c35d019790c1e008322::treasury::Treasury, arg1: &0x90cbc5d02db5d236bf6672ab0da60bd922df4f3bfe505c35d019790c1e008322::config::GlobalConfig, arg2: &0x90cbc5d02db5d236bf6672ab0da60bd922df4f3bfe505c35d019790c1e008322::profile::DriveProfile, arg3: &mut 0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>, arg4: u64, arg5: &0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(arg3);
        assert!(arg4 >= v0, 200);
        0x90cbc5d02db5d236bf6672ab0da60bd922df4f3bfe505c35d019790c1e008322::treasury::process_payment(arg0, arg1, arg3, arg4 - v0, 0x90cbc5d02db5d236bf6672ab0da60bd922df4f3bfe505c35d019790c1e008322::profile::referrer(arg2), arg5);
    }

    public fun extend_blob_with_fee(arg0: &mut 0x90cbc5d02db5d236bf6672ab0da60bd922df4f3bfe505c35d019790c1e008322::treasury::Treasury, arg1: &0x90cbc5d02db5d236bf6672ab0da60bd922df4f3bfe505c35d019790c1e008322::config::GlobalConfig, arg2: &mut 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg3: &0x90cbc5d02db5d236bf6672ab0da60bd922df4f3bfe505c35d019790c1e008322::profile::DriveProfile, arg4: &mut 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob, arg5: &mut 0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>, arg6: u32, arg7: &0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(arg5);
        0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::extend_blob(arg2, arg4, arg6, arg5);
        charge_platform_fee(arg0, arg1, arg3, arg5, v0, arg7);
    }

    public fun reserve_storage_with_fee(arg0: &mut 0x90cbc5d02db5d236bf6672ab0da60bd922df4f3bfe505c35d019790c1e008322::treasury::Treasury, arg1: &0x90cbc5d02db5d236bf6672ab0da60bd922df4f3bfe505c35d019790c1e008322::config::GlobalConfig, arg2: &mut 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg3: &0x90cbc5d02db5d236bf6672ab0da60bd922df4f3bfe505c35d019790c1e008322::profile::DriveProfile, arg4: &mut 0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>, arg5: u64, arg6: u32, arg7: &mut 0x2::tx_context::TxContext) : 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::Storage {
        let v0 = 0x2::coin::value<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(arg4);
        let v1 = 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::reserve_space(arg2, arg5, arg6, arg4, arg7);
        charge_platform_fee(arg0, arg1, arg3, arg4, v0, arg7);
        v1
    }

    // decompiled from Move bytecode v7
}

