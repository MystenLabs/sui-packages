module 0x9653b674222566e8fb720480e037ffda2a82dce8656da1211968f4cedfc0468c::receipt {
    struct Receipt has store, key {
        id: 0x2::object::UID,
        kind: u8,
        strategy_id: vector<u8>,
        record_hash: vector<u8>,
        ref: vector<u8>,
        ts_ms: u64,
    }

    struct ReceiptMinted has copy, drop {
        receipt_id: 0x2::object::ID,
        kind: u8,
        strategy_id: vector<u8>,
        record_hash: vector<u8>,
        ref: vector<u8>,
        ts_ms: u64,
    }

    public fun mint(arg0: u8, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = Receipt{
            id          : 0x2::object::new(arg5),
            kind        : arg0,
            strategy_id : arg1,
            record_hash : arg2,
            ref         : arg3,
            ts_ms       : arg4,
        };
        let v1 = ReceiptMinted{
            receipt_id  : 0x2::object::id<Receipt>(&v0),
            kind        : arg0,
            strategy_id : arg1,
            record_hash : arg2,
            ref         : arg3,
            ts_ms       : arg4,
        };
        0x2::event::emit<ReceiptMinted>(v1);
        0x2::transfer::freeze_object<Receipt>(v0);
    }

    // decompiled from Move bytecode v7
}

