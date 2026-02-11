module 0xce42a683a94fc4fd1f0be5cdd2459acd82535c7800b4847a9cc4965cfcb5182d::walrus_storage {
    struct WalrusBlob has key {
        id: 0x2::object::UID,
        owner: address,
        blob_id: vector<u8>,
        blob_object_id: 0x2::object::ID,
        certified_blob_id: 0x2::object::ID,
        size_bytes: u64,
        stored_epoch: u64,
        expiry_epoch: u64,
        walrus_cost_paid_sui: u64,
        platform_fee_paid_usde: u64,
        auto_renew_enabled: bool,
        renewal_threshold_epochs: u64,
        uploaded_ms: u64,
        last_renewed_ms: u64,
        deleted: bool,
    }

    struct BlobRegistered has copy, drop {
        owner: address,
        blob_id: vector<u8>,
        blob_object_id: 0x2::object::ID,
        size_bytes: u64,
        stored_epoch: u64,
        expiry_epoch: u64,
        walrus_cost_sui: u64,
        platform_fee_usde: u64,
    }

    struct BlobRenewed has copy, drop {
        blob_id: vector<u8>,
        owner: address,
        old_expiry: u64,
        new_expiry: u64,
        cost_sui: u64,
        platform_fee_usde: u64,
    }

    struct RenewalNotice has copy, drop {
        blob_id: vector<u8>,
        owner: address,
        epochs_remaining: u64,
    }

    struct BlobDeleted has copy, drop {
        blob_id: vector<u8>,
        owner: address,
    }

    public fun auto_renew_enabled(arg0: &WalrusBlob) : bool {
        arg0.auto_renew_enabled
    }

    entry fun delete_blob(arg0: &mut WalrusBlob, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg1), 1);
        arg0.deleted = true;
        let v0 = BlobDeleted{
            blob_id : arg0.blob_id,
            owner   : arg0.owner,
        };
        0x2::event::emit<BlobDeleted>(v0);
    }

    entry fun disable_auto_renew(arg0: &mut WalrusBlob, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg1), 1);
        arg0.auto_renew_enabled = false;
    }

    entry fun enable_auto_renew(arg0: &mut WalrusBlob, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg1), 1);
        arg0.auto_renew_enabled = true;
    }

    public fun get_blob_id(arg0: &WalrusBlob) : vector<u8> {
        arg0.blob_id
    }

    public fun get_expiry(arg0: &WalrusBlob) : u64 {
        arg0.expiry_epoch
    }

    public fun get_platform_fee() : u64 {
        30000
    }

    public fun is_deleted(arg0: &WalrusBlob) : bool {
        arg0.deleted
    }

    public fun needs_renewal(arg0: &WalrusBlob, arg1: u64) : bool {
        if (arg0.deleted) {
            return false
        };
        let v0 = if (arg0.expiry_epoch > arg1) {
            arg0.expiry_epoch - arg1
        } else {
            0
        };
        v0 <= arg0.renewal_threshold_epochs
    }

    entry fun register_blob(arg0: &0xce42a683a94fc4fd1f0be5cdd2459acd82535c7800b4847a9cc4965cfcb5182d::platform::PlatformConfig, arg1: &mut 0xce42a683a94fc4fd1f0be5cdd2459acd82535c7800b4847a9cc4965cfcb5182d::platform::PlatformTreasury, arg2: vector<u8>, arg3: 0x2::object::ID, arg4: 0x2::object::ID, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: 0x2::coin::Coin<0x2::sui::SUI>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(!0xce42a683a94fc4fd1f0be5cdd2459acd82535c7800b4847a9cc4965cfcb5182d::platform::is_paused(arg0), 999);
        let v0 = 0x2::tx_context::sender(arg11);
        let v1 = 30000;
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg9) >= v1, 3);
        if (0x2::coin::value<0x2::sui::SUI>(&arg9) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg9, v0);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg9);
        };
        0xce42a683a94fc4fd1f0be5cdd2459acd82535c7800b4847a9cc4965cfcb5182d::platform::deposit_usde(arg1, 0x2::coin::split<0x2::sui::SUI>(&mut arg9, v1, arg11));
        let v2 = 0x2::clock::timestamp_ms(arg10);
        let v3 = WalrusBlob{
            id                       : 0x2::object::new(arg11),
            owner                    : v0,
            blob_id                  : arg2,
            blob_object_id           : arg3,
            certified_blob_id        : arg4,
            size_bytes               : arg5,
            stored_epoch             : arg6,
            expiry_epoch             : arg7,
            walrus_cost_paid_sui     : arg8,
            platform_fee_paid_usde   : v1,
            auto_renew_enabled       : false,
            renewal_threshold_epochs : 30,
            uploaded_ms              : v2,
            last_renewed_ms          : v2,
            deleted                  : false,
        };
        0x2::transfer::transfer<WalrusBlob>(v3, v0);
        let v4 = BlobRegistered{
            owner             : v0,
            blob_id           : v3.blob_id,
            blob_object_id    : v3.blob_object_id,
            size_bytes        : arg5,
            stored_epoch      : arg6,
            expiry_epoch      : arg7,
            walrus_cost_sui   : arg8,
            platform_fee_usde : v1,
        };
        0x2::event::emit<BlobRegistered>(v4);
    }

    entry fun renew_blob(arg0: &0xce42a683a94fc4fd1f0be5cdd2459acd82535c7800b4847a9cc4965cfcb5182d::platform::PlatformConfig, arg1: &mut 0xce42a683a94fc4fd1f0be5cdd2459acd82535c7800b4847a9cc4965cfcb5182d::platform::PlatformTreasury, arg2: &mut WalrusBlob, arg3: u64, arg4: u64, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(!0xce42a683a94fc4fd1f0be5cdd2459acd82535c7800b4847a9cc4965cfcb5182d::platform::is_paused(arg0), 999);
        assert!(arg2.owner == 0x2::tx_context::sender(arg7), 1);
        assert!(!arg2.deleted, 999);
        assert!(arg3 > arg2.expiry_epoch, 999);
        let v0 = 30000;
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg5) >= v0, 3);
        if (0x2::coin::value<0x2::sui::SUI>(&arg5) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg5, arg2.owner);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg5);
        };
        0xce42a683a94fc4fd1f0be5cdd2459acd82535c7800b4847a9cc4965cfcb5182d::platform::deposit_usde(arg1, 0x2::coin::split<0x2::sui::SUI>(&mut arg5, v0, arg7));
        arg2.expiry_epoch = arg3;
        arg2.last_renewed_ms = 0x2::clock::timestamp_ms(arg6);
        let v1 = BlobRenewed{
            blob_id           : arg2.blob_id,
            owner             : arg2.owner,
            old_expiry        : arg2.expiry_epoch,
            new_expiry        : arg3,
            cost_sui          : arg4,
            platform_fee_usde : v0,
        };
        0x2::event::emit<BlobRenewed>(v1);
    }

    entry fun set_renewal_threshold(arg0: &mut WalrusBlob, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 1);
        arg0.renewal_threshold_epochs = arg1;
    }

    // decompiled from Move bytecode v6
}

