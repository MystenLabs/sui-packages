module 0xaa131eea114fba9bbfc4a6b1b67f248184830e9d87500de5db899e8cb3b9a65e::config_validator {
    public fun are_valid_fee_shares(arg0: u8, arg1: u8) : bool {
        arg0 + arg1 == 100
    }

    public fun is_valid_market_cap_range(arg0: u64, arg1: u64) : bool {
        arg0 >= 100000000000 && arg1 > arg0
    }

    public fun is_valid_migration_percent(arg0: u8) : bool {
        arg0 > 0 && arg0 <= 100
    }

    public fun is_valid_remaining_action(arg0: u8) : bool {
        arg0 <= 3
    }

    public fun is_valid_tax_rate(arg0: u64) : bool {
        arg0 <= 1000
    }

    public fun validate_config(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u8, arg5: u8, arg6: u8, arg7: u8) : bool {
        assert!(arg0 >= 100000000000, 100);
        assert!(arg1 > arg0, 100);
        assert!(arg2 <= 1000, 101);
        assert!(arg3 <= 1000, 101);
        assert!(arg4 + arg5 == 100, 102);
        assert!(arg6 > 0 && arg6 <= 100, 103);
        assert!(arg7 <= 3, 104);
        true
    }

    // decompiled from Move bytecode v6
}

