module 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::migration {
    struct MigrationPrepared has copy, drop {
        generation: u64,
        timestamp_ms: u64,
    }

    struct MigrationAborted has copy, drop {
        generation: u64,
        timestamp_ms: u64,
    }

    public(friend) entry fun abort_prepared(arg0: &mut 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::Registry, arg1: &0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::authorities::MigrationCap, arg2: &0x2::clock::Clock) {
        abort 1701
    }

    public(friend) entry fun prepare(arg0: &mut 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::Registry, arg1: &0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::authorities::MigrationCap, arg2: &0x2::clock::Clock) {
        abort 1701
    }

    public(friend) entry fun resume(arg0: &mut 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::Registry, arg1: &0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::authorities::GovernanceCap) {
        assert!(0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::status(arg0) == 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::status_frozen(), 1700);
        0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::authorities::assert_governance(0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::authorities(0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::inner(arg0)), arg1);
        0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::set_status(arg0, 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::status_active());
    }

    public(friend) entry fun verify_custody<T0>(arg0: &mut 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::Registry, arg1: &0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::authorities::MigrationCap) {
        abort 1701
    }

    public(friend) entry fun verify_reserve<T0>(arg0: &mut 0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::registry::Registry, arg1: &0xc13c241cdcb32ce410dba013bc77590b51c62b6e4cf463a5f0d48fbec6d31b14::authorities::MigrationCap) {
        abort 1701
    }

    // decompiled from Move bytecode v7
}

