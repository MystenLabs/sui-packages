module 0x2ff81d5d87ef2847d26de1920c70871f3a90b9d7471c917c9dd41f75c3dd4709::state {
    struct CoinFlipState has store {
        number_of_house_bias: u64,
        number_of_heads: u64,
        number_of_tails: u64,
        recent_throws: vector<0x1::string::String>,
    }

    public fun empty() : CoinFlipState {
        CoinFlipState{
            number_of_house_bias : 0,
            number_of_heads      : 0,
            number_of_tails      : 0,
            recent_throws        : 0x1::vector::empty<0x1::string::String>(),
        }
    }

    public fun counters(arg0: &CoinFlipState) : (u64, u64, u64) {
        (arg0.number_of_heads, arg0.number_of_tails, arg0.number_of_house_bias)
    }

    public fun process_context(arg0: &mut CoinFlipState, arg1: &0x2ff81d5d87ef2847d26de1920c70871f3a90b9d7471c917c9dd41f75c3dd4709::context::CoinFlipContext) {
        let v0 = 0x2ff81d5d87ef2847d26de1920c70871f3a90b9d7471c917c9dd41f75c3dd4709::context::result(arg1);
        if (0x2ff81d5d87ef2847d26de1920c70871f3a90b9d7471c917c9dd41f75c3dd4709::context::status(arg1) != 0x2ff81d5d87ef2847d26de1920c70871f3a90b9d7471c917c9dd41f75c3dd4709::constants::settled_status()) {
            return
        };
        0x1::vector::push_back<0x1::string::String>(&mut arg0.recent_throws, v0);
        if (0x1::vector::length<0x1::string::String>(&arg0.recent_throws) > 0x2ff81d5d87ef2847d26de1920c70871f3a90b9d7471c917c9dd41f75c3dd4709::constants::max_recent_throws()) {
            0x1::vector::remove<0x1::string::String>(&mut arg0.recent_throws, 0);
        };
        if (v0 == 0x2ff81d5d87ef2847d26de1920c70871f3a90b9d7471c917c9dd41f75c3dd4709::constants::house_bias_result()) {
            arg0.number_of_house_bias = arg0.number_of_house_bias + 1;
        } else if (v0 == 0x2ff81d5d87ef2847d26de1920c70871f3a90b9d7471c917c9dd41f75c3dd4709::constants::head_result()) {
            arg0.number_of_heads = arg0.number_of_heads + 1;
        } else if (v0 == 0x2ff81d5d87ef2847d26de1920c70871f3a90b9d7471c917c9dd41f75c3dd4709::constants::tail_result()) {
            arg0.number_of_tails = arg0.number_of_tails + 1;
        };
    }

    public fun recent_throws(arg0: &CoinFlipState) : vector<0x1::string::String> {
        arg0.recent_throws
    }

    // decompiled from Move bytecode v6
}

