module 0x24faa722661aa85cfbc88ceb9fca6fe940e0c74ff07bcb0f5663c0ae163d36b::fill {
    struct Fill has copy, drop {
        fill_id: u256,
        intent_hash: vector<u8>,
        solver: vector<u8>,
        receiver: vector<u8>,
        token: vector<u8>,
        amount: u128,
    }

    public fun amount(arg0: &Fill) : u128 {
        arg0.amount
    }

    public fun decode(arg0: &vector<u8>) : Fill {
        let v0 = 0x5a6ab91581604273c78ef5bf421f0f57868ac40e519d39e2b80f39e9ddaef12e::decoder::decode_list(arg0);
        Fill{
            fill_id     : 0x5a6ab91581604273c78ef5bf421f0f57868ac40e519d39e2b80f39e9ddaef12e::decoder::decode_u256(0x1::vector::borrow<vector<u8>>(&v0, 0)),
            intent_hash : *0x1::vector::borrow<vector<u8>>(&v0, 1),
            solver      : *0x1::vector::borrow<vector<u8>>(&v0, 2),
            receiver    : *0x1::vector::borrow<vector<u8>>(&v0, 3),
            token       : *0x1::vector::borrow<vector<u8>>(&v0, 4),
            amount      : 0x5a6ab91581604273c78ef5bf421f0f57868ac40e519d39e2b80f39e9ddaef12e::decoder::decode_u128(0x1::vector::borrow<vector<u8>>(&v0, 5)),
        }
    }

    public fun encode(arg0: &Fill) : vector<u8> {
        let v0 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v0, 0x5a6ab91581604273c78ef5bf421f0f57868ac40e519d39e2b80f39e9ddaef12e::encoder::encode_u256(arg0.fill_id));
        0x1::vector::push_back<vector<u8>>(&mut v0, 0x5a6ab91581604273c78ef5bf421f0f57868ac40e519d39e2b80f39e9ddaef12e::encoder::encode(&arg0.intent_hash));
        0x1::vector::push_back<vector<u8>>(&mut v0, 0x5a6ab91581604273c78ef5bf421f0f57868ac40e519d39e2b80f39e9ddaef12e::encoder::encode(&arg0.solver));
        0x1::vector::push_back<vector<u8>>(&mut v0, 0x5a6ab91581604273c78ef5bf421f0f57868ac40e519d39e2b80f39e9ddaef12e::encoder::encode(&arg0.receiver));
        0x1::vector::push_back<vector<u8>>(&mut v0, 0x5a6ab91581604273c78ef5bf421f0f57868ac40e519d39e2b80f39e9ddaef12e::encoder::encode(&arg0.token));
        0x1::vector::push_back<vector<u8>>(&mut v0, 0x5a6ab91581604273c78ef5bf421f0f57868ac40e519d39e2b80f39e9ddaef12e::encoder::encode_u128(arg0.amount));
        0x5a6ab91581604273c78ef5bf421f0f57868ac40e519d39e2b80f39e9ddaef12e::encoder::encode_list(&v0, false)
    }

    public fun fill_id(arg0: &Fill) : u256 {
        arg0.fill_id
    }

    public fun intent_hash(arg0: &Fill) : vector<u8> {
        arg0.intent_hash
    }

    public fun new(arg0: u256, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: u128) : Fill {
        Fill{
            fill_id     : arg0,
            intent_hash : arg1,
            solver      : arg2,
            receiver    : arg3,
            token       : arg4,
            amount      : arg5,
        }
    }

    public fun receiver(arg0: &Fill) : vector<u8> {
        arg0.receiver
    }

    public fun solver(arg0: &Fill) : vector<u8> {
        arg0.solver
    }

    public fun token(arg0: &Fill) : vector<u8> {
        arg0.token
    }

    // decompiled from Move bytecode v6
}

