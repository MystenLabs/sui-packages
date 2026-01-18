module 0x90a75f641859f4d77a4349d67e518e1dd9ecb4fac079e220fa46b7a7f164e0a5::config {
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
        assert!(arg0 <= 0x90a75f641859f4d77a4349d67e518e1dd9ecb4fac079e220fa46b7a7f164e0a5::abyss_constants::max_protocol_fee(), 1);
        assert!(arg1 >= 0x90a75f641859f4d77a4349d67e518e1dd9ecb4fac079e220fa46b7a7f164e0a5::abyss_constants::min_atoken_supply(), 2);
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

