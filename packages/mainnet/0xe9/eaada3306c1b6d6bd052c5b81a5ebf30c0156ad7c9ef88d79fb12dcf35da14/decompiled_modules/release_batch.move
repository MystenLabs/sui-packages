module 0xe9eaada3306c1b6d6bd052c5b81a5ebf30c0156ad7c9ef88d79fb12dcf35da14::release_batch {
    struct ReleaseBatch has copy, drop, store {
        fill_type: u8,
        order_hashes: vector<vector<u8>>,
        filler: address,
        from_amounts: vector<u256>,
        fees: vector<u256>,
        from_tokens: vector<vector<u8>>,
    }

    public(friend) fun consume_release_batch(arg0: ReleaseBatch) : (u8, vector<vector<u8>>, address, vector<u256>, vector<u256>, vector<vector<u8>>) {
        let ReleaseBatch {
            fill_type    : v0,
            order_hashes : v1,
            filler       : v2,
            from_amounts : v3,
            fees         : v4,
            from_tokens  : v5,
        } = arg0;
        (v0, v1, v2, v3, v4, v5)
    }

    public(friend) fun new(arg0: u8, arg1: vector<vector<u8>>, arg2: address, arg3: vector<u256>, arg4: vector<u256>, arg5: vector<vector<u8>>) : ReleaseBatch {
        ReleaseBatch{
            fill_type    : arg0,
            order_hashes : arg1,
            filler       : arg2,
            from_amounts : arg3,
            fees         : arg4,
            from_tokens  : arg5,
        }
    }

    // decompiled from Move bytecode v6
}

