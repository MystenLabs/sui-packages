module 0x4a25336d949648eddf4b5cf78e46d67bc529efffe4a5cca5169164116a56ea48::message {
    struct Message has drop {
        kind: u8,
        deadline: u64,
        data: vector<u8>,
    }

    public fun decode(arg0: &vector<u8>) : Message {
        let v0 = 0x5a6ab91581604273c78ef5bf421f0f57868ac40e519d39e2b80f39e9ddaef12e::decoder::decode_list(arg0);
        Message{
            kind     : 0x5a6ab91581604273c78ef5bf421f0f57868ac40e519d39e2b80f39e9ddaef12e::decoder::decode_u8(0x1::vector::borrow<vector<u8>>(&v0, 0)),
            deadline : 0x5a6ab91581604273c78ef5bf421f0f57868ac40e519d39e2b80f39e9ddaef12e::decoder::decode_u64(0x1::vector::borrow<vector<u8>>(&v0, 1)),
            data     : *0x1::vector::borrow<vector<u8>>(&v0, 2),
        }
    }

    public fun get_actions(arg0: &Message) : 0x4a25336d949648eddf4b5cf78e46d67bc529efffe4a5cca5169164116a56ea48::actions::Actions {
        0x4a25336d949648eddf4b5cf78e46d67bc529efffe4a5cca5169164116a56ea48::actions::decode(&arg0.data, arg0.kind)
    }

    public fun get_deadline(arg0: &Message) : u64 {
        arg0.deadline
    }

    public fun has_expired(arg0: &Message, arg1: &0x2::clock::Clock) : bool {
        arg0.deadline < 0x2::clock::timestamp_ms(arg1) / 1000
    }

    // decompiled from Move bytecode v6
}

