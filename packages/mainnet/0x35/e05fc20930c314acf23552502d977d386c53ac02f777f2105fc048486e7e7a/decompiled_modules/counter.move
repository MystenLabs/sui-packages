module 0x35e05fc20930c314acf23552502d977d386c53ac02f777f2105fc048486e7e7a::counter {
    struct Counter has store, key {
        id: 0x2::object::UID,
        version: u16,
        stashed_airdrop_cnt: u64,
        all_access_pass_collectible_cnt: u64,
        all_access_pass_token_cnt: u64,
        klaus_mueller_portrait_cnt: u64,
        hayden_michael_portrait_cnt: u64,
    }

    public(friend) fun delete(arg0: Counter) {
        let Counter {
            id                              : v0,
            version                         : _,
            stashed_airdrop_cnt             : _,
            all_access_pass_collectible_cnt : _,
            all_access_pass_token_cnt       : _,
            klaus_mueller_portrait_cnt      : _,
            hayden_michael_portrait_cnt     : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : Counter {
        Counter{
            id                              : 0x2::object::new(arg0),
            version                         : 0x35e05fc20930c314acf23552502d977d386c53ac02f777f2105fc048486e7e7a::package::version(),
            stashed_airdrop_cnt             : 0,
            all_access_pass_collectible_cnt : 0,
            all_access_pass_token_cnt       : 0,
            klaus_mueller_portrait_cnt      : 0,
            hayden_michael_portrait_cnt     : 0,
        }
    }

    public fun all_access_pass_collectible_cnt(arg0: &Counter) : u64 {
        arg0.all_access_pass_collectible_cnt
    }

    public fun all_access_pass_token_cnt(arg0: &Counter) : u64 {
        arg0.all_access_pass_token_cnt
    }

    public fun hayden_michael_portrait_cnt(arg0: &Counter) : u64 {
        arg0.hayden_michael_portrait_cnt
    }

    public(friend) fun incr_all_access_pass_collectible_cnt(arg0: &mut Counter) {
        abort 0
    }

    public(friend) fun incr_all_access_pass_token_cnt(arg0: &mut Counter) {
        abort 0
    }

    public(friend) fun incr_hayden_michael_portrait_cnt(arg0: &mut Counter) {
        abort 0
    }

    public(friend) fun incr_klaus_mueller_portrait_cnt(arg0: &mut Counter) {
        abort 0
    }

    public(friend) fun incr_stashed_airdrop_cnt(arg0: &mut Counter) {
        abort 0
    }

    public fun klaus_mueller_portrait_cnt(arg0: &Counter) : u64 {
        arg0.klaus_mueller_portrait_cnt
    }

    public fun stashed_airdrop_cnt(arg0: &Counter) : u64 {
        arg0.stashed_airdrop_cnt
    }

    public fun version(arg0: &Counter) : u16 {
        arg0.version
    }

    // decompiled from Move bytecode v6
}

