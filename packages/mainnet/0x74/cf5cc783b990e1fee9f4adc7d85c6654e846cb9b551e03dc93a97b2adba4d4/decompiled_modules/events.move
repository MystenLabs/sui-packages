module 0x74cf5cc783b990e1fee9f4adc7d85c6654e846cb9b551e03dc93a97b2adba4d4::events {
    struct LogUpdateAuthority has copy, drop {
        new_authority: address,
        granted: bool,
    }

    struct LogUpdateAuth has copy, drop {
        addr: address,
        granted: bool,
    }

    struct LogUpdateMigrator has copy, drop {
        addr: address,
        granted: bool,
    }

    struct LogCreateManager has copy, drop {
        manager: 0x2::object::ID,
        vault: 0x2::object::ID,
        cap: 0x2::object::ID,
    }

    struct LogTimelockEnabled has copy, drop {
        cap_id: 0x2::object::ID,
    }

    struct LogTimelockDisabled has copy, drop {
        cap_id: 0x2::object::ID,
    }

    public(friend) fun emit_log_create_manager(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x2::object::ID) {
        let v0 = LogCreateManager{
            manager : arg0,
            vault   : arg1,
            cap     : arg2,
        };
        0x2::event::emit<LogCreateManager>(v0);
    }

    public(friend) fun emit_log_timelock_disabled(arg0: 0x2::object::ID) {
        let v0 = LogTimelockDisabled{cap_id: arg0};
        0x2::event::emit<LogTimelockDisabled>(v0);
    }

    public(friend) fun emit_log_timelock_enabled(arg0: 0x2::object::ID) {
        let v0 = LogTimelockEnabled{cap_id: arg0};
        0x2::event::emit<LogTimelockEnabled>(v0);
    }

    public(friend) fun emit_log_update_auth(arg0: address, arg1: bool) {
        let v0 = LogUpdateAuth{
            addr    : arg0,
            granted : arg1,
        };
        0x2::event::emit<LogUpdateAuth>(v0);
    }

    public(friend) fun emit_log_update_authority(arg0: address, arg1: bool) {
        let v0 = LogUpdateAuthority{
            new_authority : arg0,
            granted       : arg1,
        };
        0x2::event::emit<LogUpdateAuthority>(v0);
    }

    public(friend) fun emit_log_update_migrator(arg0: address, arg1: bool) {
        let v0 = LogUpdateMigrator{
            addr    : arg0,
            granted : arg1,
        };
        0x2::event::emit<LogUpdateMigrator>(v0);
    }

    // decompiled from Move bytecode v7
}

