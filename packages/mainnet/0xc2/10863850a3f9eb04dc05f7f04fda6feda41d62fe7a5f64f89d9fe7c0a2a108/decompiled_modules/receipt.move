module 0xc210863850a3f9eb04dc05f7f04fda6feda41d62fe7a5f64f89d9fe7c0a2a108::receipt {
    struct StorageReceipt has store, key {
        id: 0x2::object::UID,
        kind: u8,
        blob_id: u256,
        shared_blob_id: 0x2::object::ID,
        end_epoch: u32,
    }

    public fun blob_id(arg0: &StorageReceipt) : u256 {
        arg0.blob_id
    }

    public fun burn(arg0: StorageReceipt) {
        let StorageReceipt {
            id             : v0,
            kind           : _,
            blob_id        : _,
            shared_blob_id : _,
            end_epoch      : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun end_epoch(arg0: &StorageReceipt) : u32 {
        arg0.end_epoch
    }

    public fun kind(arg0: &StorageReceipt) : u8 {
        arg0.kind
    }

    public fun mint(arg0: u8, arg1: u256, arg2: 0x2::object::ID, arg3: u32, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0 == 0 || arg0 == 1, 0);
        let v0 = StorageReceipt{
            id             : 0x2::object::new(arg5),
            kind           : arg0,
            blob_id        : arg1,
            shared_blob_id : arg2,
            end_epoch      : arg3,
        };
        0x2::transfer::transfer<StorageReceipt>(v0, arg4);
    }

    public fun shared_blob_id(arg0: &StorageReceipt) : 0x2::object::ID {
        arg0.shared_blob_id
    }

    // decompiled from Move bytecode v6
}

