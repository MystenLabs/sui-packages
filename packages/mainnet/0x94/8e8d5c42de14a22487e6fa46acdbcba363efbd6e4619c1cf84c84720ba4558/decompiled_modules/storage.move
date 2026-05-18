module 0x948e8d5c42de14a22487e6fa46acdbcba363efbd6e4619c1cf84c84720ba4558::storage {
    struct StorageRenewed has copy, drop {
        form_id: 0x2::object::ID,
        record_id: 0x2::object::ID,
        blob_id: vector<u8>,
        epochs_extended: u64,
        renewed_by: address,
    }

    struct StorageRenewalRecord has key {
        id: 0x2::object::UID,
        blob_id: vector<u8>,
        form_id: 0x2::object::ID,
        renewed_by: address,
        renewed_at: u64,
        epochs_extended: u64,
    }

    public fun blob_id(arg0: &StorageRenewalRecord) : vector<u8> {
        arg0.blob_id
    }

    public fun epochs_extended(arg0: &StorageRenewalRecord) : u64 {
        arg0.epochs_extended
    }

    public fun form_id(arg0: &StorageRenewalRecord) : 0x2::object::ID {
        arg0.form_id
    }

    entry fun record_storage_renewal(arg0: &0x948e8d5c42de14a22487e6fa46acdbcba363efbd6e4619c1cf84c84720ba4558::form::FormOwnerCap, arg1: &0x948e8d5c42de14a22487e6fa46acdbcba363efbd6e4619c1cf84c84720ba4558::form::Form, arg2: vector<u8>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x948e8d5c42de14a22487e6fa46acdbcba363efbd6e4619c1cf84c84720ba4558::form::verify_cap(arg0, arg1);
        assert!(0x1::vector::length<u8>(&arg2) == 32, 4);
        let v0 = 0x948e8d5c42de14a22487e6fa46acdbcba363efbd6e4619c1cf84c84720ba4558::form::id(arg1);
        let v1 = 0x2::tx_context::sender(arg4);
        let v2 = StorageRenewalRecord{
            id              : 0x2::object::new(arg4),
            blob_id         : arg2,
            form_id         : v0,
            renewed_by      : v1,
            renewed_at      : 0x2::tx_context::epoch(arg4),
            epochs_extended : arg3,
        };
        let v3 = StorageRenewed{
            form_id         : v0,
            record_id       : 0x2::object::uid_to_inner(&v2.id),
            blob_id         : v2.blob_id,
            epochs_extended : arg3,
            renewed_by      : v1,
        };
        0x2::event::emit<StorageRenewed>(v3);
        0x2::transfer::transfer<StorageRenewalRecord>(v2, v1);
    }

    public fun renewed_at(arg0: &StorageRenewalRecord) : u64 {
        arg0.renewed_at
    }

    public fun renewed_by(arg0: &StorageRenewalRecord) : address {
        arg0.renewed_by
    }

    // decompiled from Move bytecode v6
}

