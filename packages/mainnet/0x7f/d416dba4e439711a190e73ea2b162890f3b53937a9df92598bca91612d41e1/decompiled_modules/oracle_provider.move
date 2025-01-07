module 0x7fd416dba4e439711a190e73ea2b162890f3b53937a9df92598bca91612d41e1::oracle_provider {
    struct OracleProviderConfig has store {
        provider: OracleProvider,
        enable: bool,
        pair_id: vector<u8>,
    }

    struct OracleProvider has copy, drop, store {
        bytes: vector<u8>,
    }

    public fun is_empty(arg0: &OracleProvider) : bool {
        0x1::vector::is_empty<u8>(&arg0.bytes)
    }

    public fun get_pair_id_from_oracle_provider_config(arg0: &OracleProviderConfig) : vector<u8> {
        arg0.pair_id
    }

    public fun get_provider_from_oracle_provider_config(arg0: &OracleProviderConfig) : OracleProvider {
        arg0.provider
    }

    public fun is_oracle_provider_config_enable(arg0: &OracleProviderConfig) : bool {
        arg0.enable
    }

    public fun new_empty_provider() : OracleProvider {
        OracleProvider{bytes: 0x1::vector::empty<u8>()}
    }

    public(friend) fun new_oracle_provider_config(arg0: OracleProvider, arg1: bool, arg2: vector<u8>) : OracleProviderConfig {
        OracleProviderConfig{
            provider : arg0,
            enable   : arg1,
            pair_id  : arg2,
        }
    }

    public fun pyth_provider() : OracleProvider {
        OracleProvider{bytes: b"pyth price provider"}
    }

    public(friend) fun set_enable_to_oracle_provider_config(arg0: &mut OracleProviderConfig, arg1: bool) {
        arg0.enable = arg1;
    }

    public(friend) fun set_pair_id_to_oracle_provider_config(arg0: &mut OracleProviderConfig, arg1: vector<u8>) {
        arg0.pair_id = arg1;
    }

    public fun supra_provider() : OracleProvider {
        OracleProvider{bytes: b"supra price provider"}
    }

    public fun to_address(arg0: &OracleProvider) : address {
        0x2::address::from_bytes(arg0.bytes)
    }

    public fun to_bytes(arg0: &OracleProvider) : vector<u8> {
        arg0.bytes
    }

    public fun to_string(arg0: &OracleProvider) : 0x1::ascii::String {
        0x1::ascii::string(arg0.bytes)
    }

    // decompiled from Move bytecode v6
}

