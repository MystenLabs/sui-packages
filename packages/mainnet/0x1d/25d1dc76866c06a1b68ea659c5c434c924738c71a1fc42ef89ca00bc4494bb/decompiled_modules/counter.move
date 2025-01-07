module 0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::counter {
    struct Counter has store, key {
        id: 0x2::object::UID,
        version: u16,
        stashed_airdrop_cnt: u64,
        all_access_pass_collectible_cnt: u64,
        all_access_pass_token_cnt: u64,
        klaus_mueller_portrait_cnt: u64,
        hayden_michael_portrait_cnt: u64,
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : Counter {
        Counter{
            id                              : 0x2::object::new(arg0),
            version                         : 0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::package::version(),
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
        arg0.all_access_pass_collectible_cnt = arg0.all_access_pass_collectible_cnt + 1;
    }

    public(friend) fun incr_all_access_pass_token_cnt(arg0: &mut Counter) {
        arg0.all_access_pass_token_cnt = arg0.all_access_pass_token_cnt + 1;
    }

    public(friend) fun incr_hayden_michael_portrait_cnt(arg0: &mut Counter) {
        arg0.hayden_michael_portrait_cnt = arg0.hayden_michael_portrait_cnt + 1;
    }

    public(friend) fun incr_klaus_mueller_portrait_cnt(arg0: &mut Counter) {
        arg0.klaus_mueller_portrait_cnt = arg0.klaus_mueller_portrait_cnt + 1;
    }

    public(friend) fun incr_stashed_airdrop_cnt(arg0: &mut Counter) {
        arg0.stashed_airdrop_cnt = arg0.stashed_airdrop_cnt + 1;
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

