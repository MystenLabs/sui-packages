module 0xca0ce070024a3051713c5986f9cb8680e85b7ab81d7d8f76361ddcf2a18a19be::registry {
    struct Signal has store, key {
        id: 0x2::object::UID,
        author: address,
        handle: 0x1::string::String,
        token: 0x1::string::String,
        direction: 0x1::string::String,
        entry_e12: u64,
        target_e12: u64,
        stop_e12: u64,
        thesis: 0x1::string::String,
        payload_hash: 0x1::string::String,
        blob_id: 0x1::string::String,
        created_at_ms: u64,
        resolved: bool,
        win: bool,
        pnl_bps: u64,
        resolved_price_e12: u64,
        outcome_blob_id: 0x1::string::String,
        resolved_at_ms: u64,
    }

    struct SignalSealed has copy, drop {
        signal_id: 0x2::object::ID,
        author: address,
        handle: 0x1::string::String,
        token: 0x1::string::String,
        direction: 0x1::string::String,
        blob_id: 0x1::string::String,
        payload_hash: 0x1::string::String,
        created_at_ms: u64,
    }

    struct SignalResolved has copy, drop {
        signal_id: 0x2::object::ID,
        author: address,
        win: bool,
        pnl_bps: u64,
        resolved_price_e12: u64,
        outcome_blob_id: 0x1::string::String,
        resolved_at_ms: u64,
    }

    public fun resolve(arg0: &mut Signal, arg1: bool, arg2: u64, arg3: u64, arg4: 0x1::string::String, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.author == 0x2::tx_context::sender(arg6), 0);
        assert!(!arg0.resolved, 1);
        let v0 = 0x2::clock::timestamp_ms(arg5);
        arg0.resolved = true;
        arg0.win = arg1;
        arg0.pnl_bps = arg2;
        arg0.resolved_price_e12 = arg3;
        arg0.outcome_blob_id = arg4;
        arg0.resolved_at_ms = v0;
        let v1 = SignalResolved{
            signal_id          : 0x2::object::id<Signal>(arg0),
            author             : arg0.author,
            win                : arg1,
            pnl_bps            : arg2,
            resolved_price_e12 : arg3,
            outcome_blob_id    : arg0.outcome_blob_id,
            resolved_at_ms     : v0,
        };
        0x2::event::emit<SignalResolved>(v1);
    }

    public fun seal(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: u64, arg4: u64, arg5: u64, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg9);
        let v1 = 0x2::tx_context::sender(arg10);
        let v2 = Signal{
            id                 : 0x2::object::new(arg10),
            author             : v1,
            handle             : arg0,
            token              : arg1,
            direction          : arg2,
            entry_e12          : arg3,
            target_e12         : arg4,
            stop_e12           : arg5,
            thesis             : arg6,
            payload_hash       : arg7,
            blob_id            : arg8,
            created_at_ms      : v0,
            resolved           : false,
            win                : false,
            pnl_bps            : 0,
            resolved_price_e12 : 0,
            outcome_blob_id    : 0x1::string::utf8(b""),
            resolved_at_ms     : 0,
        };
        let v3 = SignalSealed{
            signal_id     : 0x2::object::id<Signal>(&v2),
            author        : v1,
            handle        : v2.handle,
            token         : v2.token,
            direction     : v2.direction,
            blob_id       : v2.blob_id,
            payload_hash  : v2.payload_hash,
            created_at_ms : v0,
        };
        0x2::event::emit<SignalSealed>(v3);
        0x2::transfer::share_object<Signal>(v2);
    }

    // decompiled from Move bytecode v7
}

