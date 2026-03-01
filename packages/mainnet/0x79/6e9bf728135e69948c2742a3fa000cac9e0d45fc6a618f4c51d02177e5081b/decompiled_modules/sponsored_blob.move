module 0x5bfeba4e22005f3c1647ae09a57ea4c60a7782bb3ecf2ffe3cbbd2789bbd3622::sponsored_blob {
    struct SponsoredBlobCreated has copy, drop {
        sponsored_blob_id: 0x2::object::ID,
        blob_id: u256,
        creator: address,
        sponsor: address,
    }

    struct SponsoredBlobDeleted has copy, drop {
        sponsored_blob_id: 0x2::object::ID,
        blob_id: u256,
        deleted_by: address,
        storage_returned_to: address,
    }

    struct SponsoredBlobExtended has copy, drop {
        sponsored_blob_id: 0x2::object::ID,
        blob_id: u256,
        extended_epochs: u32,
        extended_by: address,
    }

    struct SponsoredBlobEdited has copy, drop {
        sponsored_blob_id: 0x2::object::ID,
        old_blob_id: u256,
        new_blob_id: u256,
        edited_by: address,
        edit_nonce: u64,
    }

    struct OwnershipTransferred has copy, drop {
        sponsored_blob_id: 0x2::object::ID,
        blob_id: u256,
        new_owner: address,
    }

    struct SponsoredBlob has store, key {
        id: 0x2::object::UID,
        version: u64,
        blob: 0x1::option::Option<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>,
        creator: address,
        sponsor: address,
        sponsor_can_delete: bool,
        require_sponsor_approval_for_edit: bool,
        edit_nonce: u64,
        funds: 0x2::balance::Balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>,
    }

    struct SponsorCap has store, key {
        id: 0x2::object::UID,
        sponsor: address,
    }

    struct EditApproval has drop {
        sponsored_blob_id: 0x2::object::ID,
        new_blob_id: u256,
        edit_nonce: u64,
    }

    public fun delete(arg0: SponsoredBlob, arg1: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg2: &mut 0x2::tx_context::TxContext) {
        assert_version(&arg0);
        let v0 = 0x2::tx_context::sender(arg2);
        if (v0 == arg0.sponsor && v0 != arg0.creator) {
            assert!(arg0.sponsor_can_delete, 4);
        } else {
            assert!(v0 == arg0.creator, 0);
        };
        assert!(0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::is_deletable(0x1::option::borrow<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(&arg0.blob)), 1);
        let SponsoredBlob {
            id                                : v1,
            version                           : _,
            blob                              : v3,
            creator                           : _,
            sponsor                           : v5,
            sponsor_can_delete                : _,
            require_sponsor_approval_for_edit : _,
            edit_nonce                        : _,
            funds                             : v9,
        } = arg0;
        let v10 = v9;
        let v11 = v1;
        let v12 = 0x1::option::destroy_some<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(v3);
        0x2::transfer::public_transfer<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::Storage>(0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::delete_blob(arg1, v12), v5);
        let v13 = 0x2::balance::withdraw_all<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&mut v10);
        if (0x2::balance::value<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&v13) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>>(0x2::coin::from_balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(v13, arg2), v5);
        } else {
            0x2::balance::destroy_zero<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(v13);
        };
        0x2::balance::destroy_zero<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(v10);
        0x2::object::delete(v11);
        let v14 = SponsoredBlobDeleted{
            sponsored_blob_id   : 0x2::object::uid_to_inner(&v11),
            blob_id             : 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::blob_id(&v12),
            deleted_by          : v0,
            storage_returned_to : v5,
        };
        0x2::event::emit<SponsoredBlobDeleted>(v14);
    }

    public fun new(arg0: 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob, arg1: address, arg2: address, arg3: &mut 0x2::tx_context::TxContext) : SponsoredBlob {
        new_with_policy(arg0, arg1, arg2, false, false, arg3)
    }

    fun assert_version(arg0: &SponsoredBlob) {
        assert!(arg0.version == 1, 5);
    }

    public fun batch_extend_with_payment(arg0: &mut vector<SponsoredBlob>, arg1: &mut 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg2: u32, arg3: &mut 0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>, arg4: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0;
        while (v1 < 0x1::vector::length<SponsoredBlob>(arg0)) {
            let v2 = 0x1::vector::borrow_mut<SponsoredBlob>(arg0, v1);
            assert!(v0 == v2.creator || v0 == v2.sponsor, 0);
            let v3 = inner_blob_mut(v2);
            0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::extend_blob(arg1, v3, arg2, arg3);
            let v4 = SponsoredBlobExtended{
                sponsored_blob_id : 0x2::object::id<SponsoredBlob>(v2),
                blob_id           : 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::blob_id(inner_blob(v2)),
                extended_epochs   : arg2,
                extended_by       : v0,
            };
            0x2::event::emit<SponsoredBlobExtended>(v4);
            v1 = v1 + 1;
        };
    }

    public fun batch_fund(arg0: &mut vector<SponsoredBlob>, arg1: 0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<SponsoredBlob>(arg0);
        assert!(v0 > 0, 3);
        let v1 = 0x2::coin::into_balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(arg1);
        let v2 = 0;
        while (v2 < v0 - 1) {
            0x2::balance::join<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&mut 0x1::vector::borrow_mut<SponsoredBlob>(arg0, v2).funds, 0x2::balance::split<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&mut v1, 0x2::coin::value<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&arg1) / v0));
            v2 = v2 + 1;
        };
        0x2::balance::join<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&mut 0x1::vector::borrow_mut<SponsoredBlob>(arg0, v0 - 1).funds, v1);
    }

    public fun blob(arg0: &SponsoredBlob) : &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob {
        inner_blob(arg0)
    }

    public fun blob_id(arg0: &SponsoredBlob) : u256 {
        0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::blob_id(inner_blob(arg0))
    }

    public fun cap_sponsor(arg0: &SponsorCap) : address {
        arg0.sponsor
    }

    public fun certify_blob(arg0: &mut SponsoredBlob, arg1: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>) {
        assert_version(arg0);
        0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::certify_blob(arg1, inner_blob_mut(arg0), arg2, arg3, arg4);
    }

    public fun change_creator(arg0: &mut SponsoredBlob, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert!(0x2::tx_context::sender(arg2) == arg0.creator, 0);
        assert!(arg1 != @0x0, 3);
        arg0.creator = arg1;
    }

    public fun change_sponsor(arg0: &mut SponsoredBlob, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert!(0x2::tx_context::sender(arg2) == arg0.sponsor, 0);
        assert!(arg1 != @0x0, 3);
        arg0.sponsor = arg1;
    }

    public fun create_and_transfer(arg0: 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob, arg1: address, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::transfer<SponsoredBlob>(new(arg0, arg1, arg2, arg3), arg1);
    }

    public fun create_edit_approval(arg0: 0x2::object::ID, arg1: u256, arg2: u64) : EditApproval {
        EditApproval{
            sponsored_blob_id : arg0,
            new_blob_id       : arg1,
            edit_nonce        : arg2,
        }
    }

    public fun create_from_pool(arg0: &mut 0x5bfeba4e22005f3c1647ae09a57ea4c60a7782bb3ecf2ffe3cbbd2789bbd3622::walrus_pool::WalrusPool, arg1: 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x5bfeba4e22005f3c1647ae09a57ea4c60a7782bb3ecf2ffe3cbbd2789bbd3622::walrus_pool::is_admin(arg0, 0x2::tx_context::sender(arg3)), 0);
        let v0 = 0x2::tx_context::sender(arg3);
        0x2::transfer::transfer<SponsoredBlob>(new(arg1, arg2, v0, arg3), arg2);
    }

    public fun create_funded_and_transfer(arg0: 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob, arg1: address, arg2: address, arg3: 0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::transfer<SponsoredBlob>(new_funded(arg0, arg1, arg2, arg3, arg4), arg1);
    }

    public fun create_funded_from_pool(arg0: &mut 0x5bfeba4e22005f3c1647ae09a57ea4c60a7782bb3ecf2ffe3cbbd2789bbd3622::walrus_pool::WalrusPool, arg1: 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x5bfeba4e22005f3c1647ae09a57ea4c60a7782bb3ecf2ffe3cbbd2789bbd3622::walrus_pool::is_admin(arg0, 0x2::tx_context::sender(arg4)), 0);
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x5bfeba4e22005f3c1647ae09a57ea4c60a7782bb3ecf2ffe3cbbd2789bbd3622::walrus_pool::take(arg0, arg3, arg4);
        0x2::transfer::transfer<SponsoredBlob>(new_funded(arg1, arg2, v0, v1, arg4), arg2);
    }

    public fun creator(arg0: &SponsoredBlob) : address {
        arg0.creator
    }

    public fun destroy_sponsor_cap(arg0: SponsorCap) {
        let SponsorCap {
            id      : v0,
            sponsor : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun edit(arg0: &mut SponsoredBlob, arg1: &mut 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg2: 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::Storage, arg3: u256, arg4: u256, arg5: u64, arg6: u8, arg7: &mut 0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>, arg8: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert!(!arg0.require_sponsor_approval_for_edit, 6);
        assert!(0x2::tx_context::sender(arg8) == arg0.creator, 0);
        internal_edit(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    public fun edit_nonce(arg0: &SponsoredBlob) : u64 {
        arg0.edit_nonce
    }

    public fun edit_with_sponsor_approval(arg0: &mut SponsoredBlob, arg1: &mut 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg2: 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::Storage, arg3: u256, arg4: u256, arg5: u64, arg6: u8, arg7: &mut 0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>, arg8: vector<u8>, arg9: vector<u8>, arg10: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert!(arg0.require_sponsor_approval_for_edit, 9);
        assert!(0x2::tx_context::sender(arg10) == arg0.creator, 0);
        let v0 = EditApproval{
            sponsored_blob_id : 0x2::object::id<SponsoredBlob>(arg0),
            new_blob_id       : arg3,
            edit_nonce        : arg0.edit_nonce,
        };
        let v1 = 0x2::bcs::to_bytes<EditApproval>(&v0);
        assert!(0x2::ed25519::ed25519_verify(&arg8, &arg9, &v1), 7);
        0x1::vector::insert<u8>(&mut arg9, 0, 0);
        assert!(0x2::address::from_bytes(0x2::hash::blake2b256(&arg9)) == arg0.sponsor, 8);
        internal_edit(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg10);
    }

    public fun end_epoch(arg0: &SponsoredBlob) : u32 {
        0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::end_epoch(0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::storage(inner_blob(arg0)))
    }

    public fun extend(arg0: &mut SponsoredBlob, arg1: &mut 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg2: u32, arg3: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        let v0 = 0x2::coin::from_balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(0x2::balance::withdraw_all<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&mut arg0.funds), arg3);
        let v1 = inner_blob_mut(arg0);
        0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::extend_blob(arg1, v1, arg2, &mut v0);
        0x2::balance::join<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&mut arg0.funds, 0x2::coin::into_balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(v0));
        let v2 = SponsoredBlobExtended{
            sponsored_blob_id : 0x2::object::id<SponsoredBlob>(arg0),
            blob_id           : 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::blob_id(inner_blob(arg0)),
            extended_epochs   : arg2,
            extended_by       : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<SponsoredBlobExtended>(v2);
    }

    public fun extend_from_pool(arg0: &mut 0x5bfeba4e22005f3c1647ae09a57ea4c60a7782bb3ecf2ffe3cbbd2789bbd3622::walrus_pool::WalrusPool, arg1: &mut SponsoredBlob, arg2: &mut 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg3: u32, arg4: &mut 0x2::tx_context::TxContext) {
        assert_version(arg1);
        assert!(0x5bfeba4e22005f3c1647ae09a57ea4c60a7782bb3ecf2ffe3cbbd2789bbd3622::walrus_pool::is_admin(arg0, 0x2::tx_context::sender(arg4)), 0);
        let v0 = 0x5bfeba4e22005f3c1647ae09a57ea4c60a7782bb3ecf2ffe3cbbd2789bbd3622::walrus_pool::take_all(arg0, arg4);
        let v1 = inner_blob_mut(arg1);
        0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::extend_blob(arg2, v1, arg3, &mut v0);
        0x5bfeba4e22005f3c1647ae09a57ea4c60a7782bb3ecf2ffe3cbbd2789bbd3622::walrus_pool::return_funds(arg0, v0);
        let v2 = SponsoredBlobExtended{
            sponsored_blob_id : 0x2::object::id<SponsoredBlob>(arg1),
            blob_id           : 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::blob_id(inner_blob(arg1)),
            extended_epochs   : arg3,
            extended_by       : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<SponsoredBlobExtended>(v2);
    }

    public fun extend_with_payment(arg0: &mut SponsoredBlob, arg1: &mut 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg2: u32, arg3: &mut 0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>, arg4: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(v0 == arg0.creator || v0 == arg0.sponsor, 0);
        let v1 = inner_blob_mut(arg0);
        0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::extend_blob(arg1, v1, arg2, arg3);
        let v2 = SponsoredBlobExtended{
            sponsored_blob_id : 0x2::object::id<SponsoredBlob>(arg0),
            blob_id           : 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::blob_id(inner_blob(arg0)),
            extended_epochs   : arg2,
            extended_by       : v0,
        };
        0x2::event::emit<SponsoredBlobExtended>(v2);
    }

    public fun extend_with_storage(arg0: &mut SponsoredBlob, arg1: &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg2: 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::Storage, arg3: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(v0 == arg0.creator || v0 == arg0.sponsor, 0);
        let v1 = inner_blob_mut(arg0);
        0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::extend_blob_with_resource(arg1, v1, arg2);
        let v2 = SponsoredBlobExtended{
            sponsored_blob_id : 0x2::object::id<SponsoredBlob>(arg0),
            blob_id           : 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::blob_id(inner_blob(arg0)),
            extended_epochs   : 0,
            extended_by       : v0,
        };
        0x2::event::emit<SponsoredBlobExtended>(v2);
    }

    public fun fund(arg0: &mut SponsoredBlob, arg1: 0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>) {
        assert_version(arg0);
        0x2::balance::join<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&mut arg0.funds, 0x2::coin::into_balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(arg1));
    }

    public fun fund_from_pool(arg0: &mut 0x5bfeba4e22005f3c1647ae09a57ea4c60a7782bb3ecf2ffe3cbbd2789bbd3622::walrus_pool::WalrusPool, arg1: &mut SponsoredBlob, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert_version(arg1);
        assert!(0x5bfeba4e22005f3c1647ae09a57ea4c60a7782bb3ecf2ffe3cbbd2789bbd3622::walrus_pool::is_admin(arg0, 0x2::tx_context::sender(arg3)), 0);
        0x2::balance::join<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&mut arg1.funds, 0x2::coin::into_balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(0x5bfeba4e22005f3c1647ae09a57ea4c60a7782bb3ecf2ffe3cbbd2789bbd3622::walrus_pool::take(arg0, arg2, arg3)));
    }

    public fun funds(arg0: &SponsoredBlob) : &0x2::balance::Balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL> {
        &arg0.funds
    }

    public fun funds_value(arg0: &SponsoredBlob) : u64 {
        0x2::balance::value<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&arg0.funds)
    }

    fun inner_blob(arg0: &SponsoredBlob) : &0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob {
        assert!(0x1::option::is_some<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(&arg0.blob), 10);
        0x1::option::borrow<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(&arg0.blob)
    }

    fun inner_blob_mut(arg0: &mut SponsoredBlob) : &mut 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob {
        assert!(0x1::option::is_some<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(&arg0.blob), 10);
        0x1::option::borrow_mut<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(&mut arg0.blob)
    }

    fun internal_edit(arg0: &mut SponsoredBlob, arg1: &mut 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::System, arg2: 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::Storage, arg3: u256, arg4: u256, arg5: u64, arg6: u8, arg7: &mut 0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::option::extract<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(&mut arg0.blob);
        assert!(0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::is_deletable(&v0), 1);
        0x2::transfer::public_transfer<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::storage_resource::Storage>(0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::delete_blob(arg1, v0), arg0.sponsor);
        0x1::option::fill<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(&mut arg0.blob, 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::system::register_blob(arg1, arg2, arg3, arg4, arg5, arg6, true, arg7, arg8));
        arg0.edit_nonce = arg0.edit_nonce + 1;
        let v1 = SponsoredBlobEdited{
            sponsored_blob_id : 0x2::object::id<SponsoredBlob>(arg0),
            old_blob_id       : 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::blob_id(&v0),
            new_blob_id       : 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::blob_id(inner_blob(arg0)),
            edited_by         : 0x2::tx_context::sender(arg8),
            edit_nonce        : arg0.edit_nonce,
        };
        0x2::event::emit<SponsoredBlobEdited>(v1);
    }

    public fun is_deletable(arg0: &SponsoredBlob) : bool {
        0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::is_deletable(inner_blob(arg0))
    }

    public fun migrate(arg0: &mut SponsoredBlob, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.creator, 0);
        assert!(arg0.version < 1, 5);
        arg0.version = 1;
    }

    public fun new_funded(arg0: 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob, arg1: address, arg2: address, arg3: 0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>, arg4: &mut 0x2::tx_context::TxContext) : SponsoredBlob {
        new_funded_with_policy(arg0, arg1, arg2, false, false, arg3, arg4)
    }

    public fun new_funded_with_policy(arg0: 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob, arg1: address, arg2: address, arg3: bool, arg4: bool, arg5: 0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>, arg6: &mut 0x2::tx_context::TxContext) : SponsoredBlob {
        assert!(arg1 != @0x0 && arg2 != @0x0, 3);
        let v0 = SponsoredBlob{
            id                                : 0x2::object::new(arg6),
            version                           : 1,
            blob                              : 0x1::option::some<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(arg0),
            creator                           : arg1,
            sponsor                           : arg2,
            sponsor_can_delete                : arg3,
            require_sponsor_approval_for_edit : arg4,
            edit_nonce                        : 0,
            funds                             : 0x2::coin::into_balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(arg5),
        };
        let v1 = SponsoredBlobCreated{
            sponsored_blob_id : 0x2::object::id<SponsoredBlob>(&v0),
            blob_id           : 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::blob_id(0x1::option::borrow<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(&v0.blob)),
            creator           : arg1,
            sponsor           : arg2,
        };
        0x2::event::emit<SponsoredBlobCreated>(v1);
        v0
    }

    public fun new_sponsor_cap(arg0: &mut 0x2::tx_context::TxContext) : SponsorCap {
        SponsorCap{
            id      : 0x2::object::new(arg0),
            sponsor : 0x2::tx_context::sender(arg0),
        }
    }

    public fun new_with_policy(arg0: 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob, arg1: address, arg2: address, arg3: bool, arg4: bool, arg5: &mut 0x2::tx_context::TxContext) : SponsoredBlob {
        assert!(arg1 != @0x0 && arg2 != @0x0, 3);
        let v0 = SponsoredBlob{
            id                                : 0x2::object::new(arg5),
            version                           : 1,
            blob                              : 0x1::option::some<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(arg0),
            creator                           : arg1,
            sponsor                           : arg2,
            sponsor_can_delete                : arg3,
            require_sponsor_approval_for_edit : arg4,
            edit_nonce                        : 0,
            funds                             : 0x2::balance::zero<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(),
        };
        let v1 = SponsoredBlobCreated{
            sponsored_blob_id : 0x2::object::id<SponsoredBlob>(&v0),
            blob_id           : 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::blob_id(0x1::option::borrow<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(&v0.blob)),
            creator           : arg1,
            sponsor           : arg2,
        };
        0x2::event::emit<SponsoredBlobCreated>(v1);
        v0
    }

    public fun require_sponsor_approval_for_edit(arg0: &SponsoredBlob) : bool {
        arg0.require_sponsor_approval_for_edit
    }

    public fun set_require_sponsor_approval_for_edit(arg0: &mut SponsoredBlob, arg1: bool, arg2: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert!(0x2::tx_context::sender(arg2) == arg0.sponsor, 0);
        arg0.require_sponsor_approval_for_edit = arg1;
    }

    public fun set_sponsor_can_delete(arg0: &mut SponsoredBlob, arg1: bool, arg2: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert!(0x2::tx_context::sender(arg2) == arg0.creator, 0);
        arg0.sponsor_can_delete = arg1;
    }

    public fun sponsor(arg0: &SponsoredBlob) : address {
        arg0.sponsor
    }

    public fun sponsor_can_delete(arg0: &SponsoredBlob) : bool {
        arg0.sponsor_can_delete
    }

    public fun transfer_to_creator(arg0: SponsoredBlob, arg1: &mut 0x2::tx_context::TxContext) {
        assert_version(&arg0);
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(v0 == arg0.sponsor, 0);
        let SponsoredBlob {
            id                                : v1,
            version                           : _,
            blob                              : v3,
            creator                           : v4,
            sponsor                           : _,
            sponsor_can_delete                : _,
            require_sponsor_approval_for_edit : _,
            edit_nonce                        : _,
            funds                             : v9,
        } = arg0;
        let v10 = v9;
        let v11 = v1;
        let v12 = 0x1::option::destroy_some<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(v3);
        if (0x2::balance::value<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(&v10) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>>(0x2::coin::from_balance<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(v10, arg1), v0);
        } else {
            0x2::balance::destroy_zero<0x356a26eb9e012a68958082340d4c4116e7f55615cf27affcff209cf0ae544f59::wal::WAL>(v10);
        };
        0x2::transfer::public_transfer<0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::Blob>(v12, v4);
        0x2::object::delete(v11);
        let v13 = OwnershipTransferred{
            sponsored_blob_id : 0x2::object::uid_to_inner(&v11),
            blob_id           : 0xfdc88f7d7cf30afab2f82e8380d11ee8f70efb90e863d1de8616fae1bb09ea77::blob::blob_id(&v12),
            new_owner         : v4,
        };
        0x2::event::emit<OwnershipTransferred>(v13);
    }

    public fun version(arg0: &SponsoredBlob) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v6
}

