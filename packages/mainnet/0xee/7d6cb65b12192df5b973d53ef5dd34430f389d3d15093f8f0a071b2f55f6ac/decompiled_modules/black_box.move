module 0xee7d6cb65b12192df5b973d53ef5dd34430f389d3d15093f8f0a071b2f55f6ac::black_box {
    struct DecisionLog has store, key {
        id: 0x2::object::UID,
        agent: address,
        walrus_blob_id: 0x1::string::String,
        log_hash: vector<u8>,
        action: 0x1::string::String,
        recipient: address,
        amount_mist: u64,
        risk_flagged: bool,
        timestamp_ms: u64,
    }

    struct DecisionRecorded has copy, drop {
        log_id: 0x2::object::ID,
        agent: address,
        walrus_blob_id: 0x1::string::String,
        log_hash: vector<u8>,
        action: 0x1::string::String,
        recipient: address,
        amount_mist: u64,
        risk_flagged: bool,
        timestamp_ms: u64,
    }

    public fun record_decision(arg0: 0x1::string::String, arg1: vector<u8>, arg2: 0x1::string::String, arg3: address, arg4: u64, arg5: bool, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::string::length(&arg0) > 0, 0);
        assert!(0x1::vector::length<u8>(&arg1) == 32, 1);
        let v0 = DecisionLog{
            id             : 0x2::object::new(arg7),
            agent          : 0x2::tx_context::sender(arg7),
            walrus_blob_id : arg0,
            log_hash       : arg1,
            action         : arg2,
            recipient      : arg3,
            amount_mist    : arg4,
            risk_flagged   : arg5,
            timestamp_ms   : 0x2::clock::timestamp_ms(arg6),
        };
        let v1 = DecisionRecorded{
            log_id         : 0x2::object::id<DecisionLog>(&v0),
            agent          : v0.agent,
            walrus_blob_id : v0.walrus_blob_id,
            log_hash       : v0.log_hash,
            action         : v0.action,
            recipient      : v0.recipient,
            amount_mist    : v0.amount_mist,
            risk_flagged   : v0.risk_flagged,
            timestamp_ms   : v0.timestamp_ms,
        };
        0x2::event::emit<DecisionRecorded>(v1);
        0x2::transfer::freeze_object<DecisionLog>(v0);
    }

    // decompiled from Move bytecode v7
}

