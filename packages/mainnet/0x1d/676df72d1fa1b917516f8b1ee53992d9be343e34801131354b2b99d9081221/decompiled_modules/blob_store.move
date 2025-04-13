module 0x1d676df72d1fa1b917516f8b1ee53992d9be343e34801131354b2b99d9081221::blob_store {
    struct BlobStore has store, key {
        id: 0x2::object::UID,
        blobs: 0x2::table::Table<u64, 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>,
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = BlobStore{
            id    : 0x2::object::new(arg0),
            blobs : 0x2::table::new<u64, 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(arg0),
        };
        0x2::transfer::public_share_object<BlobStore>(v0);
    }

    public(friend) fun burn_blob(arg0: &mut BlobStore, arg1: u64) {
        0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::burn(0x2::table::remove<u64, 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(&mut arg0.blobs, arg1));
    }

    public(friend) fun renew_blob(arg0: &mut BlobStore, arg1: u64, arg2: u32, arg3: &mut 0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>, arg4: &mut 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System) {
        0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::extend_blob(arg4, 0x2::table::borrow_mut<u64, 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(&mut arg0.blobs, arg1), arg2, arg3);
    }

    public(friend) fun store_blob(arg0: &mut BlobStore, arg1: u64, arg2: 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob) {
        0x2::table::add<u64, 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(&mut arg0.blobs, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

