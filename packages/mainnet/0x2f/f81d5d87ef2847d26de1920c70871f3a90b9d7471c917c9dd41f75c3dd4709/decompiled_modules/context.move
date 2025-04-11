module 0x2ff81d5d87ef2847d26de1920c70871f3a90b9d7471c917c9dd41f75c3dd4709::context {
    struct CoinFlipContext has copy, drop, store {
        stake: u64,
        prediction: 0x1::string::String,
        result: 0x1::string::String,
        status: 0x1::string::String,
        win: u64,
    }

    public(friend) fun empty() : CoinFlipContext {
        CoinFlipContext{
            stake      : 0,
            prediction : 0x2ff81d5d87ef2847d26de1920c70871f3a90b9d7471c917c9dd41f75c3dd4709::constants::head_result(),
            result     : 0x2ff81d5d87ef2847d26de1920c70871f3a90b9d7471c917c9dd41f75c3dd4709::constants::head_result(),
            status     : 0x2ff81d5d87ef2847d26de1920c70871f3a90b9d7471c917c9dd41f75c3dd4709::constants::new_status(),
            win        : 0,
        }
    }

    fun assert_valid_prediction(arg0: &0x1::string::String) {
        let v0 = 0x2ff81d5d87ef2847d26de1920c70871f3a90b9d7471c917c9dd41f75c3dd4709::constants::head_result();
        let v1 = if (arg0 == &v0) {
            true
        } else {
            let v2 = 0x2ff81d5d87ef2847d26de1920c70871f3a90b9d7471c917c9dd41f75c3dd4709::constants::tail_result();
            arg0 == &v2
        };
        assert!(v1, 3);
    }

    fun assert_valid_result(arg0: &0x1::string::String) {
        let v0 = 0x2ff81d5d87ef2847d26de1920c70871f3a90b9d7471c917c9dd41f75c3dd4709::constants::head_result();
        let v1 = if (arg0 == &v0) {
            true
        } else {
            let v2 = 0x2ff81d5d87ef2847d26de1920c70871f3a90b9d7471c917c9dd41f75c3dd4709::constants::tail_result();
            if (arg0 == &v2) {
                true
            } else {
                let v3 = 0x2ff81d5d87ef2847d26de1920c70871f3a90b9d7471c917c9dd41f75c3dd4709::constants::house_bias_result();
                arg0 == &v3
            }
        };
        assert!(v1, 2);
    }

    fun assert_valid_state_transition(arg0: &CoinFlipContext, arg1: 0x1::string::String) {
        if (arg0.status == 0x2ff81d5d87ef2847d26de1920c70871f3a90b9d7471c917c9dd41f75c3dd4709::constants::new_status()) {
            assert!(arg1 == 0x2ff81d5d87ef2847d26de1920c70871f3a90b9d7471c917c9dd41f75c3dd4709::constants::initialized_status(), 1);
        } else if (arg0.status == 0x2ff81d5d87ef2847d26de1920c70871f3a90b9d7471c917c9dd41f75c3dd4709::constants::initialized_status()) {
            assert!(arg1 == 0x2ff81d5d87ef2847d26de1920c70871f3a90b9d7471c917c9dd41f75c3dd4709::constants::settled_status(), 1);
        } else {
            assert!(arg0.status == 0x2ff81d5d87ef2847d26de1920c70871f3a90b9d7471c917c9dd41f75c3dd4709::constants::settled_status(), 1);
            assert!(arg1 == 0x2ff81d5d87ef2847d26de1920c70871f3a90b9d7471c917c9dd41f75c3dd4709::constants::initialized_status(), 1);
        };
    }

    public(friend) fun bet(arg0: &mut CoinFlipContext, arg1: u64, arg2: 0x1::string::String) {
        assert_valid_prediction(&arg2);
        let v0 = 0x2ff81d5d87ef2847d26de1920c70871f3a90b9d7471c917c9dd41f75c3dd4709::constants::initialized_status();
        assert_valid_state_transition(arg0, v0);
        arg0.status = v0;
        arg0.stake = arg1;
        arg0.prediction = arg2;
        arg0.win = 0;
    }

    public fun player_won(arg0: &CoinFlipContext) : bool {
        arg0.result == arg0.prediction
    }

    public fun prediction(arg0: &CoinFlipContext) : 0x1::string::String {
        arg0.prediction
    }

    public fun result(arg0: &CoinFlipContext) : 0x1::string::String {
        arg0.result
    }

    public(friend) fun settle(arg0: &mut CoinFlipContext, arg1: 0x1::string::String, arg2: u64) {
        assert_valid_result(&arg1);
        let v0 = 0x2ff81d5d87ef2847d26de1920c70871f3a90b9d7471c917c9dd41f75c3dd4709::constants::settled_status();
        assert_valid_state_transition(arg0, v0);
        arg0.status = v0;
        arg0.result = arg1;
        arg0.win = arg2;
    }

    public fun status(arg0: &CoinFlipContext) : 0x1::string::String {
        arg0.status
    }

    public fun win(arg0: &CoinFlipContext) : u64 {
        arg0.win
    }

    // decompiled from Move bytecode v6
}

