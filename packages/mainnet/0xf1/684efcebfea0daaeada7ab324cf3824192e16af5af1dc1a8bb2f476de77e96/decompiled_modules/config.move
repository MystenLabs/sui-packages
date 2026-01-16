module 0xf1684efcebfea0daaeada7ab324cf3824192e16af5af1dc1a8bb2f476de77e96::config {
    struct ProtocolConfig has copy, drop, store {
        protocol_fee: u64,
        min_atoken_supply: u64,
    }

    public fun min_atoken_supply(arg0: &ProtocolConfig) : u64 {
        arg0.min_atoken_supply
    }

    public fun default_protocol_config() : ProtocolConfig {
        new_protocol_config(200000000, 1000000)
    }

    public fun new_protocol_config(arg0: u64, arg1: u64) : ProtocolConfig {
        assert!(arg0 <= 0xf1684efcebfea0daaeada7ab324cf3824192e16af5af1dc1a8bb2f476de77e96::abyss_constants::max_protocol_fee(), 1);
        assert!(arg1 >= 0xf1684efcebfea0daaeada7ab324cf3824192e16af5af1dc1a8bb2f476de77e96::abyss_constants::min_atoken_supply(), 2);
        ProtocolConfig{
            protocol_fee      : arg0,
            min_atoken_supply : arg1,
        }
    }

    public fun protocol_fee(arg0: &ProtocolConfig) : u64 {
        arg0.protocol_fee
    }

    // decompiled from Move bytecode v6
}

