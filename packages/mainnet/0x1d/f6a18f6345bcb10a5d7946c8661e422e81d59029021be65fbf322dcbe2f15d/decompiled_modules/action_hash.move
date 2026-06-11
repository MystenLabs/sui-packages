module 0x1df6a18f6345bcb10a5d7946c8661e422e81d59029021be65fbf322dcbe2f15d::action_hash {
    struct ActionContext has copy, drop {
        policy_id: 0x2::object::ID,
        action_type: u8,
        protocol_id: 0x1::option::Option<0x2::object::ID>,
        recipient: address,
        amount: u64,
        nonce: vector<u8>,
        expires_at_ms: u64,
    }

    public fun digest(arg0: &ActionContext) : vector<u8> {
        let v0 = 0x1::bcs::to_bytes<ActionContext>(arg0);
        0x2::hash::blake2b256(&v0)
    }

    public fun digest_bound(arg0: 0x2::object::ID, arg1: u8, arg2: 0x2::object::ID, arg3: address, arg4: u64, arg5: vector<u8>, arg6: u64) : vector<u8> {
        let v0 = new_bound_context(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        digest(&v0)
    }

    public fun digest_unbound(arg0: 0x2::object::ID, arg1: u8, arg2: address, arg3: u64, arg4: vector<u8>, arg5: u64) : vector<u8> {
        let v0 = new_context(arg0, arg1, arg2, arg3, arg4, arg5);
        digest(&v0)
    }

    public fun new_bound_context(arg0: 0x2::object::ID, arg1: u8, arg2: 0x2::object::ID, arg3: address, arg4: u64, arg5: vector<u8>, arg6: u64) : ActionContext {
        ActionContext{
            policy_id     : arg0,
            action_type   : arg1,
            protocol_id   : 0x1::option::some<0x2::object::ID>(arg2),
            recipient     : arg3,
            amount        : arg4,
            nonce         : arg5,
            expires_at_ms : arg6,
        }
    }

    public fun new_context(arg0: 0x2::object::ID, arg1: u8, arg2: address, arg3: u64, arg4: vector<u8>, arg5: u64) : ActionContext {
        ActionContext{
            policy_id     : arg0,
            action_type   : arg1,
            protocol_id   : 0x1::option::none<0x2::object::ID>(),
            recipient     : arg2,
            amount        : arg3,
            nonce         : arg4,
            expires_at_ms : arg5,
        }
    }

    // decompiled from Move bytecode v7
}

