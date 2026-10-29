module 0xcb7318d9293fddcdc32e2c4e23e9733c640a0dfdfdee04ba54c7b7fc97aeec1c::flag {
    struct FlagAnchored has copy, drop {
        market_id: 0x1::string::String,
        flag: u8,
        criteria_hash: vector<u8>,
        lesson_count: u64,
        anchored_ms: u64,
    }

    public fun anchor_flag(arg0: 0x1::string::String, arg1: u8, arg2: vector<u8>, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        assert!(arg1 < 3, 0);
        let v0 = FlagAnchored{
            market_id     : arg0,
            flag          : arg1,
            criteria_hash : arg2,
            lesson_count  : arg3,
            anchored_ms   : 0x2::tx_context::epoch_timestamp_ms(arg4),
        };
        0x2::event::emit<FlagAnchored>(v0);
    }

    // decompiled from Move bytecode v7
}

