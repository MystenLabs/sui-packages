module 0xabd713497874d48e4d49e956c5dd0f1e0792b1f2f663f8d0866792b56177504d::archival_blob {
    struct ArchivalBlobFund has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>,
    }

    struct SharedArchivalBlob has store, key {
        id: 0x2::object::UID,
        blob: 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob,
    }

    public fun blob(arg0: &SharedArchivalBlob) : &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob {
        &arg0.blob
    }

    public fun blob_expiration_epoch(arg0: &SharedArchivalBlob) : u32 {
        0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::end_epoch(&arg0.blob)
    }

    entry fun burn_shared_blob(arg0: &0xabd713497874d48e4d49e956c5dd0f1e0792b1f2f663f8d0866792b56177504d::admin::AdminCap, arg1: SharedArchivalBlob) {
        let SharedArchivalBlob {
            id   : v0,
            blob : v1,
        } = arg1;
        0x2::object::delete(v0);
        0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::burn(v1);
    }

    public fun create_shared_blob(arg0: &0xabd713497874d48e4d49e956c5dd0f1e0792b1f2f663f8d0866792b56177504d::admin::AdminCap, arg1: 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = SharedArchivalBlob{
            id   : 0x2::object::new(arg2),
            blob : arg1,
        };
        0x2::transfer::share_object<SharedArchivalBlob>(v0);
    }

    public fun deposit(arg0: &mut ArchivalBlobFund, arg1: 0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>) {
        0x2::balance::join<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&mut arg0.balance, 0x2::coin::into_balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(arg1));
    }

    public fun extend_shared_blob_using_shared_funds(arg0: &mut ArchivalBlobFund, arg1: &mut 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg2: &mut SharedArchivalBlob, arg3: u32, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 > 0, 0);
        let v0 = 0x2::coin::from_balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(0x2::balance::withdraw_all<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&mut arg0.balance), arg4);
        0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::extend_blob(arg1, &mut arg2.blob, arg3, &mut v0);
        0x2::balance::join<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&mut arg0.balance, 0x2::coin::into_balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(v0));
    }

    public fun extend_shared_blob_using_token(arg0: &mut 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg1: &mut SharedArchivalBlob, arg2: u32, arg3: &mut 0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>) {
        assert!(arg2 > 0, 0);
        0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::extend_blob(arg0, &mut arg1.blob, arg2, arg3);
    }

    public fun get_balance(arg0: &ArchivalBlobFund) : u64 {
        0x2::balance::value<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&arg0.balance)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ArchivalBlobFund{
            id      : 0x2::object::new(arg0),
            balance : 0x2::balance::zero<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(),
        };
        0x2::transfer::share_object<ArchivalBlobFund>(v0);
    }

    // decompiled from Move bytecode v6
}

