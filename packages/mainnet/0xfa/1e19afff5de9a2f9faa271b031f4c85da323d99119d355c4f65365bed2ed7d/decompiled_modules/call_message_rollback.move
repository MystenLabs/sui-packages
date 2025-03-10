module 0xfa1e19afff5de9a2f9faa271b031f4c85da323d99119d355c4f65365bed2ed7d::call_message_rollback {
    struct CallMessageWithRollback has drop {
        data: vector<u8>,
        rollback: vector<u8>,
    }

    public fun encode(arg0: CallMessageWithRollback) : vector<u8> {
        let v0 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v0, 0xd43b1be8c0327bf9ed887578bd621cfbdd7ec8ee7ea1d3df429cd34e88914902::encoder::encode(&arg0.data));
        0x1::vector::push_back<vector<u8>>(&mut v0, 0xd43b1be8c0327bf9ed887578bd621cfbdd7ec8ee7ea1d3df429cd34e88914902::encoder::encode(&arg0.rollback));
        0xd43b1be8c0327bf9ed887578bd621cfbdd7ec8ee7ea1d3df429cd34e88914902::encoder::encode_list(&v0, false)
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
        let v0 = 0xd43b1be8c0327bf9ed887578bd621cfbdd7ec8ee7ea1d3df429cd34e88914902::decoder::decode_list(arg0);
        CallMessageWithRollback{
            data     : *0x1::vector::borrow<vector<u8>>(&v0, 0),
            rollback : *0x1::vector::borrow<vector<u8>>(&v0, 1),
        }
    }

    public fun msg_type() : u8 {
        1
    }

    public fun rollback(arg0: &CallMessageWithRollback) : vector<u8> {
        arg0.rollback
    }

    // decompiled from Move bytecode v6
}

