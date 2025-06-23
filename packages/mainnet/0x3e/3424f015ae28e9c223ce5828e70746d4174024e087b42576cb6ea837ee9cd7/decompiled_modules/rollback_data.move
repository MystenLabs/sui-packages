module 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::rollback_data {
    struct RollbackData has copy, drop, store {
        from: 0x2::object::ID,
        to: 0x1::string::String,
        sources: vector<0x1::string::String>,
        rollback: vector<u8>,
        enabled: bool,
    }

    public fun create(arg0: 0x2::object::ID, arg1: 0x1::string::String, arg2: vector<0x1::string::String>, arg3: vector<u8>, arg4: bool) : RollbackData {
        RollbackData{
            from     : arg0,
            to       : arg1,
            sources  : arg2,
            rollback : arg3,
            enabled  : arg4,
        }
    }

    public(friend) fun enable_rollback(arg0: &mut RollbackData) {
        arg0.enabled = true;
    }

    public fun enabled(arg0: &RollbackData) : bool {
        arg0.enabled
    }

    public fun from(arg0: &RollbackData) : 0x2::object::ID {
        arg0.from
    }

    public fun rollback(arg0: &RollbackData) : vector<u8> {
        arg0.rollback
    }

    public fun sources(arg0: &RollbackData) : vector<0x1::string::String> {
        arg0.sources
    }

    public fun to(arg0: &RollbackData) : 0x1::string::String {
        arg0.to
    }

    // decompiled from Move bytecode v6
}

