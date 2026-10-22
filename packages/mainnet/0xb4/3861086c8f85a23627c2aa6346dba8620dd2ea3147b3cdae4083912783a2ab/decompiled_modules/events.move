module 0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::events {
    struct LogOracleCreated has copy, drop {
        oracle: 0x2::object::ID,
        nonce: u16,
        main: 0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::structs::Source,
        guard: 0x1::option::Option<0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::structs::Source>,
    }

    struct LogRoleUpdated has copy, drop {
        role: 0x1::type_name::TypeName,
        owner: address,
        granted: bool,
    }

    public(friend) fun emit_log_oracle_created(arg0: 0x2::object::ID, arg1: u16, arg2: 0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::structs::Source, arg3: 0x1::option::Option<0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::structs::Source>) {
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

    // decompiled from Move bytecode v7
}

