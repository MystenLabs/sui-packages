module 0x1925bced9aeb16ca8159be0a10d39a0778fe618404443a4b6149116ad9997617::receipt {
    struct ActionReceipt has store, key {
        id: 0x2::object::UID,
        policy_id: 0x2::object::ID,
        agent: address,
        kind: 0x1::string::String,
        coin_type: vector<u8>,
        protocol: address,
        amount_mist: u64,
        spent_after_mist: u64,
        memo: 0x1::string::String,
        timestamp_ms: u64,
    }

    struct ActionRecorded has copy, drop {
        policy_id: 0x2::object::ID,
        receipt_id: 0x2::object::ID,
        agent: address,
        kind: 0x1::string::String,
        amount_mist: u64,
        spent_after_mist: u64,
        timestamp_ms: u64,
    }

    public fun agent(arg0: &ActionReceipt) : address {
        arg0.agent
    }

    public fun amount_mist(arg0: &ActionReceipt) : u64 {
        arg0.amount_mist
    }

    public fun coin_type(arg0: &ActionReceipt) : vector<u8> {
        arg0.coin_type
    }

    public(friend) fun issue(arg0: 0x2::object::ID, arg1: address, arg2: vector<u8>, arg3: vector<u8>, arg4: address, arg5: u64, arg6: u64, arg7: vector<u8>, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) : ActionReceipt {
        let v0 = ActionReceipt{
            id               : 0x2::object::new(arg9),
            policy_id        : arg0,
            agent            : arg1,
            kind             : 0x1::string::utf8(arg2),
            coin_type        : arg3,
            protocol         : arg4,
            amount_mist      : arg5,
            spent_after_mist : arg6,
            memo             : 0x1::string::utf8(arg7),
            timestamp_ms     : arg8,
        };
        let v1 = ActionRecorded{
            policy_id        : arg0,
            receipt_id       : 0x2::object::id<ActionReceipt>(&v0),
            agent            : arg1,
            kind             : v0.kind,
            amount_mist      : arg5,
            spent_after_mist : arg6,
            timestamp_ms     : arg8,
        };
        0x2::event::emit<ActionRecorded>(v1);
        v0
    }

    public fun kind(arg0: &ActionReceipt) : 0x1::string::String {
        arg0.kind
    }

    public fun memo(arg0: &ActionReceipt) : 0x1::string::String {
        arg0.memo
    }

    public fun policy_id(arg0: &ActionReceipt) : 0x2::object::ID {
        arg0.policy_id
    }

    public fun protocol(arg0: &ActionReceipt) : address {
        arg0.protocol
    }

    public fun spent_after_mist(arg0: &ActionReceipt) : u64 {
        arg0.spent_after_mist
    }

    public fun timestamp_ms(arg0: &ActionReceipt) : u64 {
        arg0.timestamp_ms
    }

    // decompiled from Move bytecode v7
}

