module 0x24faa722661aa85cfbc88ceb9fca6fe940e0c74ff07bcb0f5663c0ae163d36b::fill_response {
    struct FillResponse has copy, drop {
        fill_id: u256,
        success: bool,
    }

    public fun decode(arg0: &vector<u8>) : FillResponse {
        let v0 = 0x5a6ab91581604273c78ef5bf421f0f57868ac40e519d39e2b80f39e9ddaef12e::decoder::decode_list(arg0);
        FillResponse{
            fill_id : 0x5a6ab91581604273c78ef5bf421f0f57868ac40e519d39e2b80f39e9ddaef12e::decoder::decode_u256(0x1::vector::borrow<vector<u8>>(&v0, 0)),
            success : 0x5a6ab91581604273c78ef5bf421f0f57868ac40e519d39e2b80f39e9ddaef12e::decoder::decode_bool(0x1::vector::borrow<vector<u8>>(&v0, 1)),
        }
    }

    public fun encode(arg0: &FillResponse) : vector<u8> {
        let v0 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v0, 0x5a6ab91581604273c78ef5bf421f0f57868ac40e519d39e2b80f39e9ddaef12e::encoder::encode_u256(arg0.fill_id));
        0x1::vector::push_back<vector<u8>>(&mut v0, 0x5a6ab91581604273c78ef5bf421f0f57868ac40e519d39e2b80f39e9ddaef12e::encoder::encode_bool(arg0.success));
        0x5a6ab91581604273c78ef5bf421f0f57868ac40e519d39e2b80f39e9ddaef12e::encoder::encode_list(&v0, false)
    }

    public fun new(arg0: u256, arg1: bool) : FillResponse {
        FillResponse{
            fill_id : arg0,
            success : arg1,
        }
    }

    public fun success(arg0: &FillResponse) : bool {
        arg0.success
    }

    // decompiled from Move bytecode v6
}

