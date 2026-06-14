module 0x24972ef5274a577127dc871687e4bfe4bb4d512d810c025cbe01d87ca621c2d7::strategy_receipt {
    struct StrategyReceipt has store, key {
        id: 0x2::object::UID,
        owner: address,
        strategy_id: 0x1::string::String,
        audit_blob_id: 0x1::string::String,
        created_at: u64,
        execution_digest: 0x1::string::String,
    }

    entry fun mint(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = StrategyReceipt{
            id               : 0x2::object::new(arg4),
            owner            : v0,
            strategy_id      : arg0,
            audit_blob_id    : arg1,
            created_at       : 0x2::clock::timestamp_ms(arg3),
            execution_digest : arg2,
        };
        0x2::transfer::public_transfer<StrategyReceipt>(v1, v0);
    }

    // decompiled from Move bytecode v7
}

