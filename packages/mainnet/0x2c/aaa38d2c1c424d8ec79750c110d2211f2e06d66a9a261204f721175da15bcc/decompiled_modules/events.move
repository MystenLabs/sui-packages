module 0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::events {
    struct LogOracleCreated has copy, drop {
        oracle: 0x2::object::ID,
        nonce: u16,
        main: 0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::structs::Source,
        guard: 0x1::option::Option<0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::structs::Source>,
    }

    struct LogRoleUpdated has copy, drop {
        role: 0x1::type_name::TypeName,
        owner: address,
        granted: bool,
    }

    struct LogTimelockEnabled has copy, drop {
        cap_id: 0x2::object::ID,
    }

    struct LogTimelockDisabled has copy, drop {
        cap_id: 0x2::object::ID,
    }

    public(friend) fun emit_log_oracle_created(arg0: 0x2::object::ID, arg1: u16, arg2: 0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::structs::Source, arg3: 0x1::option::Option<0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::structs::Source>) {
        let v0 = LogOracleCreated{
            oracle : arg0,
            nonce  : arg1,
            main   : arg2,
            guard  : arg3,
        };
        0x2::event::emit<LogOracleCreated>(v0);
    }

    public(friend) fun emit_log_role_updated(arg0: 0x1::type_name::TypeName, arg1: address, arg2: bool) {
        let v0 = LogRoleUpdated{
            role    : arg0,
            owner   : arg1,
            granted : arg2,
        };
        0x2::event::emit<LogRoleUpdated>(v0);
    }

    public(friend) fun emit_log_timelock_disabled(arg0: 0x2::object::ID) {
        let v0 = LogTimelockDisabled{cap_id: arg0};
        0x2::event::emit<LogTimelockDisabled>(v0);
    }

    public(friend) fun emit_log_timelock_enabled(arg0: 0x2::object::ID) {
        let v0 = LogTimelockEnabled{cap_id: arg0};
        0x2::event::emit<LogTimelockEnabled>(v0);
    }

    // decompiled from Move bytecode v7
}

