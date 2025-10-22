module 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::token_info {
    struct TokenInfo has store {
        symbol: 0x1::string::String,
        token_type: 0x1::string::String,
        upper_heuristic: u64,
        lower_heuristic: u64,
        exp_heuristic: u64,
        max_twap_divergence_bps: u64,
        max_age_price_seconds: u64,
        max_age_twap_seconds: u64,
        pyth_price_feed_id: 0x1::option::Option<0x1::string::String>,
        switchboard_price: 0x1::option::Option<0x1::string::String>,
        block_price_usage: u8,
    }

    public(friend) fun exp_heuristic(arg0: &TokenInfo) : u64 {
        arg0.exp_heuristic
    }

    public(friend) fun lower_heuristic(arg0: &TokenInfo) : u64 {
        arg0.lower_heuristic
    }

    public(friend) fun max_age_price_seconds(arg0: &TokenInfo) : u64 {
        arg0.max_age_price_seconds
    }

    public(friend) fun new(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: 0x1::option::Option<0x1::string::String>, arg9: 0x1::option::Option<0x1::string::String>, arg10: u8) : TokenInfo {
        TokenInfo{
            symbol                  : arg0,
            token_type              : arg1,
            upper_heuristic         : arg2,
            lower_heuristic         : arg3,
            exp_heuristic           : arg4,
            max_twap_divergence_bps : arg5,
            max_age_price_seconds   : arg6,
            max_age_twap_seconds    : arg7,
            pyth_price_feed_id      : arg8,
            switchboard_price       : arg9,
            block_price_usage       : arg10,
        }
    }

    public(friend) fun pyth_price_feed_id(arg0: &TokenInfo) : 0x1::string::String {
        assert!(0x1::option::is_some<0x1::string::String>(&arg0.pyth_price_feed_id), 0);
        *0x1::option::borrow<0x1::string::String>(&arg0.pyth_price_feed_id)
    }

    public(friend) fun update_exp_heuristic(arg0: &mut TokenInfo, arg1: u64) {
        arg0.exp_heuristic = arg1;
    }

    public(friend) fun update_lower_heuristic(arg0: &mut TokenInfo, arg1: u64) {
        arg0.lower_heuristic = arg1;
    }

    public(friend) fun update_max_age_price_seconds(arg0: &mut TokenInfo, arg1: u64) {
        arg0.max_age_price_seconds = arg1;
    }

    public(friend) fun update_max_age_twap_seconds(arg0: &mut TokenInfo, arg1: u64) {
        arg0.max_age_twap_seconds = arg1;
    }

    public(friend) fun update_max_twap_divergence_bps(arg0: &mut TokenInfo, arg1: u64) {
        arg0.max_twap_divergence_bps = arg1;
    }

    public(friend) fun update_pyth_price_feed_id(arg0: &mut TokenInfo, arg1: 0x1::option::Option<0x1::string::String>) {
        arg0.pyth_price_feed_id = arg1;
    }

    public(friend) fun update_switchboard_price(arg0: &mut TokenInfo, arg1: 0x1::option::Option<0x1::string::String>) {
        arg0.switchboard_price = arg1;
    }

    public(friend) fun update_upper_heuristic(arg0: &mut TokenInfo, arg1: u64) {
        arg0.upper_heuristic = arg1;
    }

    public(friend) fun upper_heuristic(arg0: &TokenInfo) : u64 {
        arg0.upper_heuristic
    }

    // decompiled from Move bytecode v6
}

