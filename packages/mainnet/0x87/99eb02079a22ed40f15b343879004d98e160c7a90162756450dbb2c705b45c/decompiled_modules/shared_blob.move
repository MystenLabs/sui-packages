module 0x8799eb02079a22ed40f15b343879004d98e160c7a90162756450dbb2c705b45c::shared_blob {
    struct SharedBlob has store, key {
        id: 0x2::object::UID,
        blob: 0x8799eb02079a22ed40f15b343879004d98e160c7a90162756450dbb2c705b45c::blob::Blob,
        funds: 0x2::balance::Balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>,
    }

    public fun new(arg0: 0x8799eb02079a22ed40f15b343879004d98e160c7a90162756450dbb2c705b45c::blob::Blob, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = SharedBlob{
            id    : 0x2::object::new(arg1),
            blob  : arg0,
            funds : 0x2::balance::zero<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(),
        };
        0x2::transfer::share_object<SharedBlob>(v0);
    }

    public fun extend(arg0: &mut SharedBlob, arg1: &mut 0x8799eb02079a22ed40f15b343879004d98e160c7a90162756450dbb2c705b45c::system::System, arg2: u32, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::from_balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(0x2::balance::withdraw_all<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&mut arg0.funds), arg3);
        0x8799eb02079a22ed40f15b343879004d98e160c7a90162756450dbb2c705b45c::system::extend_blob(arg1, &mut arg0.blob, arg2, &mut v0);
        0x2::balance::join<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&mut arg0.funds, 0x2::coin::into_balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(v0));
    }

    public fun fund(arg0: &mut SharedBlob, arg1: 0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>) {
        0x2::balance::join<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&mut arg0.funds, 0x2::coin::into_balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(arg1));
    }

    public fun new_funded(arg0: 0x8799eb02079a22ed40f15b343879004d98e160c7a90162756450dbb2c705b45c::blob::Blob, arg1: 0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = SharedBlob{
            id    : 0x2::object::new(arg2),
            blob  : arg0,
            funds : 0x2::coin::into_balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(arg1),
        };
        0x2::transfer::share_object<SharedBlob>(v0);
    }

    // decompiled from Move bytecode v6
}

