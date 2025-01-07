module 0x550f95b8965bef9ef16e950e59d76697b7ce0a35a09b1ba82816826c17fdae5::oracle_provider {
    struct OracleProviderConfig has store {
        provider: OracleProvider,
        enable: bool,
        pair_id: vector<u8>,
    }

    struct OracleProvider has copy, drop, store {
        name: 0x1::ascii::String,
    }

    public fun get_pair_id_from_oracle_provider_config(arg0: &OracleProviderConfig) : vector<u8> {
        arg0.pair_id
    }

    public fun get_provider_from_oracle_provider_config(arg0: &OracleProviderConfig) : OracleProvider {
        arg0.provider
    }

    public fun is_empty(arg0: &OracleProvider) : bool {
        0x1::ascii::length(&arg0.name) == 0
    }

    public fun is_oracle_provider_config_enable(arg0: &OracleProviderConfig) : bool {
        arg0.enable
    }

    public fun new_empty_provider() : OracleProvider {
        OracleProvider{name: 0x1::ascii::string(b"")}
    }

    public(friend) fun new_oracle_provider_config(arg0: OracleProvider, arg1: bool, arg2: vector<u8>) : OracleProviderConfig {
        OracleProviderConfig{
            provider : arg0,
            enable   : arg1,
            pair_id  : arg2,
        }
    }

    public fun pyth_provider() : OracleProvider {
        OracleProvider{name: 0x1::ascii::string(b"PythOracleProvider")}
    }

    public(friend) fun set_enable_to_oracle_provider_config(arg0: &mut OracleProviderConfig, arg1: bool) {
        arg0.enable = arg1;
    }

    public(friend) fun set_pair_id_to_oracle_provider_config(arg0: &mut OracleProviderConfig, arg1: vector<u8>) {
        arg0.pair_id = arg1;
    }

    public fun supra_provider() : OracleProvider {
        OracleProvider{name: 0x1::ascii::string(b"SupraOracleProvider")}
    }

    public fun to_string(arg0: &OracleProvider) : 0x1::ascii::String {
        arg0.name
    }

    // decompiled from Move bytecode v6
}

