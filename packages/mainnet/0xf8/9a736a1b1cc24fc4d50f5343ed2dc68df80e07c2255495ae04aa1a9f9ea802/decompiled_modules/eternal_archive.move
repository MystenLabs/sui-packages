module 0xf89a736a1b1cc24fc4d50f5343ed2dc68df80e07c2255495ae04aa1a9f9ea802::eternal_archive {
    struct ArchiveEntry has key {
        id: 0x2::object::UID,
        blob_id: u256,
        title: 0x1::string::String,
        category: 0x1::string::String,
        author: address,
        created_epoch: u32,
    }

    struct EntryPromoted has copy, drop {
        archive_entry_id: 0x2::object::ID,
        blob_id: u256,
        title: 0x1::string::String,
        author: address,
    }

    struct EntryFunded has copy, drop {
        archive_entry_id: 0x2::object::ID,
        funder: address,
        amount: u64,
    }

    struct EntryExtended has copy, drop {
        archive_entry_id: 0x2::object::ID,
        extended_epochs: u32,
        funder: address,
    }

    public fun author(arg0: &ArchiveEntry) : address {
        arg0.author
    }

    public fun blob_id(arg0: &ArchiveEntry) : u256 {
        arg0.blob_id
    }

    public fun category(arg0: &ArchiveEntry) : &0x1::string::String {
        &arg0.category
    }

    public fun created_epoch(arg0: &ArchiveEntry) : u32 {
        arg0.created_epoch
    }

    public fun extend_entry(arg0: &mut 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::shared_blob::SharedBlob, arg1: &mut 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg2: u32, arg3: &ArchiveEntry, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::blob_id(0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::shared_blob::blob(arg0)) == arg3.blob_id, 0);
        0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::shared_blob::extend(arg0, arg1, arg2, arg4);
        let v0 = EntryExtended{
            archive_entry_id : 0x2::object::uid_to_inner(&arg3.id),
            extended_epochs  : arg2,
            funder           : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<EntryExtended>(v0);
    }

    public fun fund_entry(arg0: &mut 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::shared_blob::SharedBlob, arg1: 0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>, arg2: &ArchiveEntry, arg3: &0x2::tx_context::TxContext) {
        assert!(0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::blob_id(0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::shared_blob::blob(arg0)) == arg2.blob_id, 0);
        0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::shared_blob::fund(arg0, arg1);
        let v0 = EntryFunded{
            archive_entry_id : 0x2::object::uid_to_inner(&arg2.id),
            funder           : 0x2::tx_context::sender(arg3),
            amount           : 0x2::coin::value<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&arg1),
        };
        0x2::event::emit<EntryFunded>(v0);
    }

    public fun promote(arg0: 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::blob_id(&arg0);
        0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::shared_blob::new(arg0, arg3);
        let v2 = ArchiveEntry{
            id            : 0x2::object::new(arg3),
            blob_id       : v1,
            title         : arg1,
            category      : arg2,
            author        : v0,
            created_epoch : 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::registered_epoch(&arg0),
        };
        let v3 = EntryPromoted{
            archive_entry_id : 0x2::object::uid_to_inner(&v2.id),
            blob_id          : v1,
            title            : arg1,
            author           : v0,
        };
        0x2::event::emit<EntryPromoted>(v3);
        0x2::transfer::share_object<ArchiveEntry>(v2);
    }

    public fun title(arg0: &ArchiveEntry) : &0x1::string::String {
        &arg0.title
    }

    // decompiled from Move bytecode v6
}

