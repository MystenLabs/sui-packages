module 0x7374df1031ddfd982b130f30f351abd99456cabb2db80ea498c1055fed09596f::redstone_sdk_config {
    struct Config has copy, drop, store {
        signer_count_threshold: u8,
        signers: vector<vector<u8>>,
        max_timestamp_delay_ms: u64,
        max_timestamp_ahead_ms: u64,
        trusted_updaters: vector<address>,
        min_interval_between_updates_ms: u64,
    }

    fun check(arg0: &Config) {
        0x2::vec_set::from_keys<vector<u8>>(arg0.signers);
        assert!(0x1::vector::length<vector<u8>>(&arg0.signers) >= (arg0.signer_count_threshold as u64), 0);
        assert!(arg0.signer_count_threshold > 0, 1);
    }

    public fun max_timestamp_ahead_ms(arg0: &Config) : u64 {
        arg0.max_timestamp_ahead_ms
    }

    public fun max_timestamp_delay_ms(arg0: &Config) : u64 {
        arg0.max_timestamp_delay_ms
    }

    public fun min_interval_between_updates_ms(arg0: &Config) : u64 {
        arg0.min_interval_between_updates_ms
    }

    public(friend) fun new(arg0: u8, arg1: vector<vector<u8>>, arg2: u64, arg3: u64, arg4: vector<address>, arg5: u64) : Config {
        let v0 = Config{
            signer_count_threshold          : arg0,
            signers                         : arg1,
            max_timestamp_delay_ms          : arg2,
            max_timestamp_ahead_ms          : arg3,
            trusted_updaters                : arg4,
            min_interval_between_updates_ms : arg5,
        };
        check(&v0);
        v0
    }

    public fun signer_count_threshold(arg0: &Config) : u8 {
        arg0.signer_count_threshold
    }

    public fun signers(arg0: &Config) : vector<vector<u8>> {
        arg0.signers
    }

    public fun trusted_updaters(arg0: &Config) : vector<address> {
        arg0.trusted_updaters
    }

    public(friend) fun update_config(arg0: &mut Config, arg1: &0x7374df1031ddfd982b130f30f351abd99456cabb2db80ea498c1055fed09596f::admin::AdminCap, arg2: vector<vector<u8>>, arg3: u8, arg4: u64, arg5: u64, arg6: vector<address>, arg7: u64) {
        arg0.signers = arg2;
        arg0.signer_count_threshold = arg3;
        arg0.max_timestamp_delay_ms = arg4;
        arg0.max_timestamp_ahead_ms = arg5;
        arg0.trusted_updaters = arg6;
        arg0.min_interval_between_updates_ms = arg7;
        check(arg0);
    }

    // decompiled from Move bytecode v6
}

