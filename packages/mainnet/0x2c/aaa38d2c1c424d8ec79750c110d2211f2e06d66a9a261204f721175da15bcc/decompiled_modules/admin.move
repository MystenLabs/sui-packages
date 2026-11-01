module 0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::admin {
    public fun disable_timelock(arg0: &0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::registry::OracleRegistry, arg1: &mut 0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::auth::Auth, arg2: 0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::timelock_cap::TimelockCap, arg3: &0x2::tx_context::TxContext) {
        0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::registry::assert_version(arg0);
        0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::auth::assert_has_direct<0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::auth::AdminRole>(arg1, arg3);
        0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::auth::disable_timelock(arg1, arg2);
        0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::events::emit_log_timelock_disabled(0x2::object::id<0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::timelock_cap::TimelockCap>(&arg2));
    }

    public fun init_oracle_config(arg0: &mut 0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::registry::OracleRegistry, arg1: &0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::auth::Auth, arg2: 0x1::option::Option<0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::timelock_cap::TimelockTicket>, arg3: u16, arg4: 0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::structs::Source, arg5: 0x1::option::Option<0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::structs::Source>, arg6: &0x2::tx_context::TxContext) {
        0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::registry::assert_version(arg0);
        0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::auth::assert_has<0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::auth::AuthorizeRole>(arg1, arg2, arg6);
        assert!(!0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::registry::oracle_exists(arg0, arg3), 0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::errors::admin_oracle_nonce_taken());
        assert!(0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::structs::is_valid(&arg4), 0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::errors::admin_invalid_source());
        if (0x1::option::is_some<0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::structs::Source>(&arg5)) {
            let v0 = 0x1::option::borrow<0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::structs::Source>(&arg5);
            assert!(0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::structs::is_valid(v0), 0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::errors::admin_invalid_source());
            let v1 = 0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::structs::source_type(&arg4);
            let v2 = 0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::structs::source_type(v0);
            assert!(!0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::structs::same_provider(&v1, &v2), 0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::errors::admin_invalid_source());
        };
        let v3 = 0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::oracle::create(arg0, arg3, arg4, arg5);
        0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::events::emit_log_oracle_created(0x2::object::id<0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::oracle::Oracle>(&v3), arg3, arg4, arg5);
        0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::oracle::share(v3);
    }

    public fun migrate(arg0: &mut 0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::registry::OracleRegistry, arg1: &0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::auth::Auth, arg2: &0x2::tx_context::TxContext) {
        0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::auth::assert_has_direct<0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::auth::MigrateRole>(arg1, arg2);
        0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::registry::migrate(arg0);
    }

    public fun mint_timelock_cap(arg0: &0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::registry::OracleRegistry, arg1: &mut 0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::auth::Auth, arg2: &mut 0x2::tx_context::TxContext) : 0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::timelock_cap::TimelockCap {
        0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::registry::assert_version(arg0);
        0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::auth::assert_has_direct<0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::auth::AdminRole>(arg1, arg2);
        let v0 = 0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::auth::enable_timelock(arg1, arg2);
        0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::events::emit_log_timelock_enabled(0x2::object::id<0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::timelock_cap::TimelockCap>(&v0));
        v0
    }

    public fun update_admin(arg0: &0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::registry::OracleRegistry, arg1: &mut 0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::auth::Auth, arg2: 0x1::option::Option<0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::timelock_cap::TimelockTicket>, arg3: address, arg4: bool, arg5: &0x2::tx_context::TxContext) {
        0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::registry::assert_version(arg0);
        if (arg4) {
            0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::auth::grant<0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::auth::AdminRole>(arg1, arg2, arg3, arg5);
        } else {
            0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::auth::revoke<0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::auth::AdminRole>(arg1, arg2, arg3, arg5);
        };
    }

    public fun update_auth(arg0: &0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::registry::OracleRegistry, arg1: &mut 0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::auth::Auth, arg2: 0x1::option::Option<0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::timelock_cap::TimelockTicket>, arg3: address, arg4: bool, arg5: &0x2::tx_context::TxContext) {
        0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::registry::assert_version(arg0);
        if (arg4) {
            0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::auth::grant<0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::auth::AuthorizeRole>(arg1, arg2, arg3, arg5);
        } else {
            0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::auth::revoke<0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::auth::AuthorizeRole>(arg1, arg2, arg3, arg5);
        };
    }

    public fun update_migrator(arg0: &0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::registry::OracleRegistry, arg1: &mut 0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::auth::Auth, arg2: 0x1::option::Option<0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::timelock_cap::TimelockTicket>, arg3: address, arg4: bool, arg5: &0x2::tx_context::TxContext) {
        0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::registry::assert_version(arg0);
        if (arg4) {
            0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::auth::grant<0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::auth::MigrateRole>(arg1, arg2, arg3, arg5);
        } else {
            0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::auth::revoke<0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::auth::MigrateRole>(arg1, arg2, arg3, arg5);
        };
    }

    // decompiled from Move bytecode v7
}

