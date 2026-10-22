module 0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::admin {
    public fun disable_timelock(arg0: &mut 0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::auth::Auth, arg1: 0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::timelock_cap::TimelockCap, arg2: &0x2::tx_context::TxContext) {
        0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::auth::assert_has_direct<0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::auth::AdminRole>(arg0, arg2);
        0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::auth::disable_timelock(arg0, arg1);
    }

    public fun init_oracle_config(arg0: &mut 0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::registry::OracleRegistry, arg1: &0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::auth::Auth, arg2: 0x1::option::Option<0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::timelock_cap::TimelockTicket>, arg3: u16, arg4: 0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::structs::Source, arg5: 0x1::option::Option<0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::structs::Source>, arg6: &0x2::tx_context::TxContext) {
        0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::registry::assert_version(arg0);
        0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::auth::assert_has<0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::auth::AuthorizeRole>(arg1, arg2, arg6);
        assert!(!0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::registry::oracle_exists(arg0, arg3), 0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::errors::admin_oracle_nonce_taken());
        assert!(0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::structs::is_valid(&arg4), 0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::errors::admin_invalid_source());
        if (0x1::option::is_some<0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::structs::Source>(&arg5)) {
            let v0 = 0x1::option::borrow<0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::structs::Source>(&arg5);
            assert!(0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::structs::is_valid(v0), 0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::errors::admin_invalid_source());
            let v1 = 0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::structs::source_type(&arg4);
            let v2 = 0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::structs::source_type(v0);
            assert!(!0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::structs::same_provider(&v1, &v2), 0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::errors::admin_invalid_source());
        };
        let v3 = 0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::oracle::create(arg0, arg3, arg4, arg5);
        0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::events::emit_log_oracle_created(0x2::object::id<0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::oracle::Oracle>(&v3), arg3, arg4, arg5);
        0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::oracle::share(v3);
    }

    public fun migrate(arg0: &mut 0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::registry::OracleRegistry, arg1: &0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::auth::Auth, arg2: &0x2::tx_context::TxContext) {
        0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::auth::assert_has_direct<0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::auth::MigrateRole>(arg1, arg2);
        0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::registry::migrate(arg0);
    }

    public fun mint_timelock_cap(arg0: &mut 0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::auth::Auth, arg1: &mut 0x2::tx_context::TxContext) : 0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::timelock_cap::TimelockCap {
        0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::auth::assert_has_direct<0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::auth::AdminRole>(arg0, arg1);
        0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::auth::enable_timelock(arg0, arg1)
    }

    public fun update_admin(arg0: &0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::registry::OracleRegistry, arg1: &mut 0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::auth::Auth, arg2: 0x1::option::Option<0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::timelock_cap::TimelockTicket>, arg3: address, arg4: bool, arg5: &0x2::tx_context::TxContext) {
        0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::registry::assert_version(arg0);
        if (arg4) {
            0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::auth::grant<0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::auth::AdminRole>(arg1, arg2, arg3, arg5);
        } else {
            0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::auth::revoke<0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::auth::AdminRole>(arg1, arg2, arg3, arg5);
        };
    }

    public fun update_auth(arg0: &0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::registry::OracleRegistry, arg1: &mut 0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::auth::Auth, arg2: 0x1::option::Option<0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::timelock_cap::TimelockTicket>, arg3: address, arg4: bool, arg5: &0x2::tx_context::TxContext) {
        0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::registry::assert_version(arg0);
        if (arg4) {
            0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::auth::grant<0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::auth::AuthorizeRole>(arg1, arg2, arg3, arg5);
        } else {
            0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::auth::revoke<0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::auth::AuthorizeRole>(arg1, arg2, arg3, arg5);
        };
    }

    public fun update_migrator(arg0: &0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::registry::OracleRegistry, arg1: &mut 0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::auth::Auth, arg2: 0x1::option::Option<0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::timelock_cap::TimelockTicket>, arg3: address, arg4: bool, arg5: &0x2::tx_context::TxContext) {
        0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::registry::assert_version(arg0);
        if (arg4) {
            0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::auth::grant<0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::auth::MigrateRole>(arg1, arg2, arg3, arg5);
        } else {
            0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::auth::revoke<0xb43861086c8f85a23627c2aa6346dba8620dd2ea3147b3cdae4083912783a2ab::auth::MigrateRole>(arg1, arg2, arg3, arg5);
        };
    }

    // decompiled from Move bytecode v7
}

