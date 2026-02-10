module 0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::sponsored_blob {
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

    struct OwnershipTransferred has copy, drop {
        sponsored_blob_id: 0x2::object::ID,
        blob_id: u256,
        new_owner: address,
    }

    struct SponsoredBlob has store, key {
        id: 0x2::object::UID,
        version: u64,
        blob: 0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::blob::Blob,
        creator: address,
        sponsor: address,
        sponsor_can_delete: bool,
        funds: 0x2::balance::Balance<0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::wal::WAL>,
    }

    struct SponsorCap has store, key {
        id: 0x2::object::UID,
        sponsor: address,
    }

    public fun delete(arg0: SponsoredBlob, arg1: &0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::system::System, arg2: &0x2::tx_context::TxContext) : 0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::storage_resource::Storage {
        assert_version(&arg0);
        let v0 = 0x2::tx_context::sender(arg2);
        if (v0 == arg0.sponsor && v0 != arg0.creator) {
            assert!(arg0.sponsor_can_delete, 4);
        } else {
            assert!(v0 == arg0.creator, 0);
        };
        assert!(0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::blob::is_deletable(&arg0.blob), 1);
        let SponsoredBlob {
            id                 : v1,
            version            : _,
            blob               : v3,
            creator            : _,
            sponsor            : v5,
            sponsor_can_delete : _,
            funds              : v7,
        } = arg0;
        let v8 = v3;
        let v9 = v1;
        0x2::balance::destroy_zero<0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::wal::WAL>(v7);
        0x2::object::delete(v9);
        let v10 = SponsoredBlobDeleted{
            sponsored_blob_id   : 0x2::object::uid_to_inner(&v9),
            blob_id             : 0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::blob::blob_id(&v8),
            deleted_by          : v0,
            storage_returned_to : v5,
        };
        0x2::event::emit<SponsoredBlobDeleted>(v10);
        0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::system::delete_blob(arg1, v8)
    }

    public fun new(arg0: 0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::blob::Blob, arg1: address, arg2: address, arg3: &mut 0x2::tx_context::TxContext) : SponsoredBlob {
        new_with_policy(arg0, arg1, arg2, false, arg3)
    }

    public fun blob(arg0: &SponsoredBlob) : &0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::blob::Blob {
        &arg0.blob
    }

    public fun blob_id(arg0: &SponsoredBlob) : u256 {
        0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::blob::blob_id(&arg0.blob)
    }

    public fun is_deletable(arg0: &SponsoredBlob) : bool {
        0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::blob::is_deletable(&arg0.blob)
    }

    fun assert_version(arg0: &SponsoredBlob) {
        assert!(arg0.version == 1, 5);
    }

    public fun batch_extend_with_payment(arg0: &mut vector<SponsoredBlob>, arg1: &mut 0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::system::System, arg2: u32, arg3: &mut 0x2::coin::Coin<0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::wal::WAL>, arg4: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0;
        while (v1 < 0x1::vector::length<SponsoredBlob>(arg0)) {
            let v2 = 0x1::vector::borrow_mut<SponsoredBlob>(arg0, v1);
            assert!(v0 == v2.creator || v0 == v2.sponsor, 0);
            0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::system::extend_blob(arg1, &mut v2.blob, arg2, arg3);
            let v3 = SponsoredBlobExtended{
                sponsored_blob_id : 0x2::object::id<SponsoredBlob>(v2),
                blob_id           : 0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::blob::blob_id(&v2.blob),
                extended_epochs   : arg2,
                extended_by       : v0,
            };
            0x2::event::emit<SponsoredBlobExtended>(v3);
            v1 = v1 + 1;
        };
    }

    public fun batch_fund(arg0: &mut vector<SponsoredBlob>, arg1: 0x2::coin::Coin<0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::wal::WAL>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<SponsoredBlob>(arg0);
        assert!(v0 > 0, 3);
        let v1 = 0x2::coin::into_balance<0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::wal::WAL>(arg1);
        let v2 = 0;
        while (v2 < v0 - 1) {
            0x2::balance::join<0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::wal::WAL>(&mut 0x1::vector::borrow_mut<SponsoredBlob>(arg0, v2).funds, 0x2::balance::split<0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::wal::WAL>(&mut v1, 0x2::coin::value<0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::wal::WAL>(&arg1) / v0));
            v2 = v2 + 1;
        };
        0x2::balance::join<0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::wal::WAL>(&mut 0x1::vector::borrow_mut<SponsoredBlob>(arg0, v0 - 1).funds, v1);
    }

    public fun cap_sponsor(arg0: &SponsorCap) : address {
        arg0.sponsor
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

    public fun create_and_transfer(arg0: 0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::blob::Blob, arg1: address, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::transfer<SponsoredBlob>(new(arg0, arg1, arg2, arg3), arg1);
    }

    public fun create_from_pool(arg0: &mut 0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::walrus_pool::WalrusPool, arg1: 0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::blob::Blob, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::walrus_pool::is_admin(arg0, 0x2::tx_context::sender(arg3)), 0);
        let v0 = 0x2::tx_context::sender(arg3);
        0x2::transfer::transfer<SponsoredBlob>(new(arg1, arg2, v0, arg3), arg2);
    }

    public fun create_funded_and_transfer(arg0: 0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::blob::Blob, arg1: address, arg2: address, arg3: 0x2::coin::Coin<0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::wal::WAL>, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::transfer<SponsoredBlob>(new_funded(arg0, arg1, arg2, arg3, arg4), arg1);
    }

    public fun create_funded_from_pool(arg0: &mut 0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::walrus_pool::WalrusPool, arg1: 0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::blob::Blob, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::walrus_pool::is_admin(arg0, 0x2::tx_context::sender(arg4)), 0);
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::walrus_pool::take(arg0, arg3, arg4);
        0x2::transfer::transfer<SponsoredBlob>(new_funded(arg1, arg2, v0, v1, arg4), arg2);
    }

    public fun creator(arg0: &SponsoredBlob) : address {
        arg0.creator
    }

    public fun delete_and_return_all(arg0: SponsoredBlob, arg1: &0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::system::System, arg2: &mut 0x2::tx_context::TxContext) {
        assert_version(&arg0);
        let v0 = 0x2::tx_context::sender(arg2);
        if (v0 == arg0.sponsor && v0 != arg0.creator) {
            assert!(arg0.sponsor_can_delete, 4);
        } else {
            assert!(v0 == arg0.creator, 0);
        };
        assert!(0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::blob::is_deletable(&arg0.blob), 1);
        let v1 = arg0.sponsor;
        let v2 = 0x2::balance::withdraw_all<0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::wal::WAL>(&mut arg0.funds);
        if (0x2::balance::value<0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::wal::WAL>(&v2) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::wal::WAL>>(0x2::coin::from_balance<0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::wal::WAL>(v2, arg2), v1);
        } else {
            0x2::balance::destroy_zero<0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::wal::WAL>(v2);
        };
        let SponsoredBlob {
            id                 : v3,
            version            : _,
            blob               : v5,
            creator            : _,
            sponsor            : _,
            sponsor_can_delete : _,
            funds              : v9,
        } = arg0;
        0x2::balance::destroy_zero<0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::wal::WAL>(v9);
        0x2::transfer::public_transfer<0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::storage_resource::Storage>(0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::system::delete_blob(arg1, v5), v1);
        0x2::object::delete(v3);
        let v10 = SponsoredBlobDeleted{
            sponsored_blob_id   : 0x2::object::id<SponsoredBlob>(&arg0),
            blob_id             : 0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::blob::blob_id(&arg0.blob),
            deleted_by          : v0,
            storage_returned_to : v1,
        };
        0x2::event::emit<SponsoredBlobDeleted>(v10);
    }

    public fun delete_and_return_storage(arg0: SponsoredBlob, arg1: &0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::system::System, arg2: &0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::storage_resource::Storage>(delete(arg0, arg1, arg2), arg0.sponsor);
    }

    public fun destroy_sponsor_cap(arg0: SponsorCap) {
        let SponsorCap {
            id      : v0,
            sponsor : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun end_epoch(arg0: &SponsoredBlob) : u32 {
        0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::storage_resource::end_epoch(0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::blob::storage(&arg0.blob))
    }

    public fun extend(arg0: &mut SponsoredBlob, arg1: &mut 0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::system::System, arg2: u32, arg3: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        let v0 = 0x2::coin::from_balance<0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::wal::WAL>(0x2::balance::withdraw_all<0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::wal::WAL>(&mut arg0.funds), arg3);
        0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::system::extend_blob(arg1, &mut arg0.blob, arg2, &mut v0);
        0x2::balance::join<0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::wal::WAL>(&mut arg0.funds, 0x2::coin::into_balance<0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::wal::WAL>(v0));
        let v1 = SponsoredBlobExtended{
            sponsored_blob_id : 0x2::object::id<SponsoredBlob>(arg0),
            blob_id           : 0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::blob::blob_id(&arg0.blob),
            extended_epochs   : arg2,
            extended_by       : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<SponsoredBlobExtended>(v1);
    }

    public fun extend_from_pool(arg0: &mut 0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::walrus_pool::WalrusPool, arg1: &mut SponsoredBlob, arg2: &mut 0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::system::System, arg3: u32, arg4: &mut 0x2::tx_context::TxContext) {
        assert_version(arg1);
        assert!(0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::walrus_pool::is_admin(arg0, 0x2::tx_context::sender(arg4)), 0);
        let v0 = 0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::walrus_pool::take_all(arg0, arg4);
        0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::system::extend_blob(arg2, &mut arg1.blob, arg3, &mut v0);
        0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::walrus_pool::return_funds(arg0, v0);
        let v1 = SponsoredBlobExtended{
            sponsored_blob_id : 0x2::object::id<SponsoredBlob>(arg1),
            blob_id           : 0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::blob::blob_id(&arg1.blob),
            extended_epochs   : arg3,
            extended_by       : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<SponsoredBlobExtended>(v1);
    }

    public fun extend_with_payment(arg0: &mut SponsoredBlob, arg1: &mut 0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::system::System, arg2: u32, arg3: &mut 0x2::coin::Coin<0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::wal::WAL>, arg4: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(v0 == arg0.creator || v0 == arg0.sponsor, 0);
        0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::system::extend_blob(arg1, &mut arg0.blob, arg2, arg3);
        let v1 = SponsoredBlobExtended{
            sponsored_blob_id : 0x2::object::id<SponsoredBlob>(arg0),
            blob_id           : 0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::blob::blob_id(&arg0.blob),
            extended_epochs   : arg2,
            extended_by       : v0,
        };
        0x2::event::emit<SponsoredBlobExtended>(v1);
    }

    public fun extend_with_storage(arg0: &mut SponsoredBlob, arg1: &0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::system::System, arg2: 0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::storage_resource::Storage, arg3: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(v0 == arg0.creator || v0 == arg0.sponsor, 0);
        0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::system::extend_blob_with_resource(arg1, &mut arg0.blob, arg2);
        let v1 = SponsoredBlobExtended{
            sponsored_blob_id : 0x2::object::id<SponsoredBlob>(arg0),
            blob_id           : 0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::blob::blob_id(&arg0.blob),
            extended_epochs   : 0,
            extended_by       : v0,
        };
        0x2::event::emit<SponsoredBlobExtended>(v1);
    }

    public fun fund(arg0: &mut SponsoredBlob, arg1: 0x2::coin::Coin<0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::wal::WAL>) {
        assert_version(arg0);
        0x2::balance::join<0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::wal::WAL>(&mut arg0.funds, 0x2::coin::into_balance<0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::wal::WAL>(arg1));
    }

    public fun fund_from_pool(arg0: &mut 0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::walrus_pool::WalrusPool, arg1: &mut SponsoredBlob, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert_version(arg1);
        assert!(0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::walrus_pool::is_admin(arg0, 0x2::tx_context::sender(arg3)), 0);
        0x2::balance::join<0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::wal::WAL>(&mut arg1.funds, 0x2::coin::into_balance<0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::wal::WAL>(0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::walrus_pool::take(arg0, arg2, arg3)));
    }

    public fun funds(arg0: &SponsoredBlob) : &0x2::balance::Balance<0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::wal::WAL> {
        &arg0.funds
    }

    public fun funds_value(arg0: &SponsoredBlob) : u64 {
        0x2::balance::value<0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::wal::WAL>(&arg0.funds)
    }

    public fun migrate(arg0: &mut SponsoredBlob, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.creator, 0);
        assert!(arg0.version < 1, 5);
        arg0.version = 1;
    }

    public fun new_funded(arg0: 0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::blob::Blob, arg1: address, arg2: address, arg3: 0x2::coin::Coin<0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::wal::WAL>, arg4: &mut 0x2::tx_context::TxContext) : SponsoredBlob {
        new_funded_with_policy(arg0, arg1, arg2, false, arg3, arg4)
    }

    public fun new_funded_with_policy(arg0: 0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::blob::Blob, arg1: address, arg2: address, arg3: bool, arg4: 0x2::coin::Coin<0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::wal::WAL>, arg5: &mut 0x2::tx_context::TxContext) : SponsoredBlob {
        assert!(arg1 != @0x0 && arg2 != @0x0, 3);
        let v0 = SponsoredBlob{
            id                 : 0x2::object::new(arg5),
            version            : 1,
            blob               : arg0,
            creator            : arg1,
            sponsor            : arg2,
            sponsor_can_delete : arg3,
            funds              : 0x2::coin::into_balance<0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::wal::WAL>(arg4),
        };
        let v1 = SponsoredBlobCreated{
            sponsored_blob_id : 0x2::object::id<SponsoredBlob>(&v0),
            blob_id           : 0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::blob::blob_id(&v0.blob),
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

    public fun new_with_policy(arg0: 0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::blob::Blob, arg1: address, arg2: address, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) : SponsoredBlob {
        assert!(arg1 != @0x0 && arg2 != @0x0, 3);
        let v0 = SponsoredBlob{
            id                 : 0x2::object::new(arg4),
            version            : 1,
            blob               : arg0,
            creator            : arg1,
            sponsor            : arg2,
            sponsor_can_delete : arg3,
            funds              : 0x2::balance::zero<0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::wal::WAL>(),
        };
        let v1 = SponsoredBlobCreated{
            sponsored_blob_id : 0x2::object::id<SponsoredBlob>(&v0),
            blob_id           : 0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::blob::blob_id(&v0.blob),
            creator           : arg1,
            sponsor           : arg2,
        };
        0x2::event::emit<SponsoredBlobCreated>(v1);
        v0
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
            id                 : v1,
            version            : _,
            blob               : v3,
            creator            : v4,
            sponsor            : _,
            sponsor_can_delete : _,
            funds              : v7,
        } = arg0;
        let v8 = v7;
        let v9 = v3;
        let v10 = v1;
        if (0x2::balance::value<0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::wal::WAL>(&v8) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::wal::WAL>>(0x2::coin::from_balance<0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::wal::WAL>(v8, arg1), v0);
        } else {
            0x2::balance::destroy_zero<0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::wal::WAL>(v8);
        };
        0x2::transfer::public_transfer<0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::blob::Blob>(v9, v4);
        0x2::object::delete(v10);
        let v11 = OwnershipTransferred{
            sponsored_blob_id : 0x2::object::uid_to_inner(&v10),
            blob_id           : 0xe1cbd92c6ef6bf04f905f5c2caf7fa754f41480618eac2e2a59b24551f8d2d08::blob::blob_id(&v9),
            new_owner         : v4,
        };
        0x2::event::emit<OwnershipTransferred>(v11);
    }

    public fun version(arg0: &SponsoredBlob) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v6
}

