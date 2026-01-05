module 0x3cde64663736a14edcbeb71a515e7773ab7bc0b1cbd5809a786bc4b1d6ab26f9::receipt_registry {
    struct ReceiptRecord has store, key {
        id: 0x2::object::UID,
        blob_id: 0x1::string::String,
        content_hash: 0x1::string::String,
        store_id: 0x1::string::String,
        order_id: 0x1::string::String,
        owner: address,
        created_at: u64,
        is_immutable: bool,
    }

    struct ReceiptRegistered has copy, drop {
        record_id: 0x2::object::ID,
        blob_id: 0x1::string::String,
        content_hash: 0x1::string::String,
        store_id: 0x1::string::String,
        order_id: 0x1::string::String,
        owner: address,
        is_immutable: bool,
    }

    struct ReceiptLocked has copy, drop {
        record_id: 0x2::object::ID,
        locked_by: address,
    }

    public fun get_blob_id(arg0: &ReceiptRecord) : 0x1::string::String {
        arg0.blob_id
    }

    public fun get_content_hash(arg0: &ReceiptRecord) : 0x1::string::String {
        arg0.content_hash
    }

    public fun get_created_at(arg0: &ReceiptRecord) : u64 {
        arg0.created_at
    }

    public fun get_order_id(arg0: &ReceiptRecord) : 0x1::string::String {
        arg0.order_id
    }

    public fun get_owner(arg0: &ReceiptRecord) : address {
        arg0.owner
    }

    public fun get_store_id(arg0: &ReceiptRecord) : 0x1::string::String {
        arg0.store_id
    }

    public fun is_immutable(arg0: &ReceiptRecord) : bool {
        arg0.is_immutable
    }

    public entry fun lock_receipt(arg0: &mut ReceiptRecord, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(v0 == arg0.owner, 1);
        assert!(!arg0.is_immutable, 2);
        arg0.is_immutable = true;
        let v1 = ReceiptLocked{
            record_id : 0x2::object::id<ReceiptRecord>(arg0),
            locked_by : v0,
        };
        0x2::event::emit<ReceiptLocked>(v1);
    }

    public entry fun register_receipt(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: bool, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = ReceiptRecord{
            id           : 0x2::object::new(arg6),
            blob_id      : 0x1::string::utf8(arg0),
            content_hash : 0x1::string::utf8(arg1),
            store_id     : 0x1::string::utf8(arg2),
            order_id     : 0x1::string::utf8(arg3),
            owner        : v0,
            created_at   : 0x2::clock::timestamp_ms(arg5),
            is_immutable : arg4,
        };
        let v2 = ReceiptRegistered{
            record_id    : 0x2::object::id<ReceiptRecord>(&v1),
            blob_id      : v1.blob_id,
            content_hash : v1.content_hash,
            store_id     : v1.store_id,
            order_id     : v1.order_id,
            owner        : v0,
            is_immutable : arg4,
        };
        0x2::event::emit<ReceiptRegistered>(v2);
        0x2::transfer::transfer<ReceiptRecord>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

