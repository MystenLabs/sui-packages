module 0x1c53e2304b957a2dc6facccc53d2dd3c2e08066614ea05a5c0af14d72ac496e3::call_message_rollback {
    struct CallMessageWithRollback has drop {
        data: vector<u8>,
        rollback: vector<u8>,
    }

    public fun create(arg0: vector<u8>, arg1: vector<u8>) : CallMessageWithRollback {
        CallMessageWithRollback{
            data     : arg0,
            rollback : arg1,
        }
    }

    public fun data(arg0: &CallMessageWithRollback) : vector<u8> {
        arg0.data
    }

    public fun decode(arg0: &vector<u8>) : CallMessageWithRollback {
        let v0 = 0x6f35a78c8338c61d78c3086772e0bfb02b9acac78286bf0a005291b887aa6cd8::decoder::decode_list(arg0);
        CallMessageWithRollback{
            data     : *0x1::vector::borrow<vector<u8>>(&v0, 0),
            rollback : *0x1::vector::borrow<vector<u8>>(&v0, 1),
        }
    }

    public fun encode(arg0: CallMessageWithRollback) : vector<u8> {
        let v0 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v0, 0x6f35a78c8338c61d78c3086772e0bfb02b9acac78286bf0a005291b887aa6cd8::encoder::encode(&arg0.data));
        0x1::vector::push_back<vector<u8>>(&mut v0, 0x6f35a78c8338c61d78c3086772e0bfb02b9acac78286bf0a005291b887aa6cd8::encoder::encode(&arg0.rollback));
        0x6f35a78c8338c61d78c3086772e0bfb02b9acac78286bf0a005291b887aa6cd8::encoder::encode_list(&v0, false)
    }

    public fun msg_type() : u8 {
        1
    }

    public fun rollback(arg0: &CallMessageWithRollback) : vector<u8> {
        arg0.rollback
    }

    // decompiled from Move bytecode v6
}

