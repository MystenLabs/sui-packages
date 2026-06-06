module 0x6a89df757475967cd26ca83df85a2861aec5c123807f56d3eff36fdd3cd3a01::receipt {
    struct DropReceipt has store, key {
        id: 0x2::object::UID,
        blob_id: 0x1::string::String,
        sender: address,
        recipient: address,
        size: u64,
        name_hash: vector<u8>,
        created_at_ms: u64,
        expiry_epochs: u64,
    }

    struct DropCreated has copy, drop {
        receipt_id: 0x2::object::ID,
        blob_id: 0x1::string::String,
        sender: address,
        recipient: address,
        size: u64,
        created_at_ms: u64,
    }

    entry fun create_receipt(arg0: 0x1::string::String, arg1: address, arg2: u64, arg3: vector<u8>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x2::clock::timestamp_ms(arg5);
        let v2 = DropReceipt{
            id            : 0x2::object::new(arg6),
            blob_id       : arg0,
            sender        : v0,
            recipient     : arg1,
            size          : arg2,
            name_hash     : arg3,
            created_at_ms : v1,
            expiry_epochs : arg4,
        };
        let v3 = DropCreated{
            receipt_id    : 0x2::object::id<DropReceipt>(&v2),
            blob_id       : v2.blob_id,
            sender        : v0,
            recipient     : arg1,
            size          : arg2,
            created_at_ms : v1,
        };
        0x2::event::emit<DropCreated>(v3);
        0x2::transfer::public_transfer<DropReceipt>(v2, v0);
    }

    // decompiled from Move bytecode v7
}

