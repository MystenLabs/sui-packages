module 0xc1e7632c9847370a0f00298defa15d42fcb0e3191cad3bee8451cab5ce144814::admin {
    public fun init_oracle_config(arg0: &mut 0xc1e7632c9847370a0f00298defa15d42fcb0e3191cad3bee8451cab5ce144814::registry::OracleRegistry, arg1: &0xc1e7632c9847370a0f00298defa15d42fcb0e3191cad3bee8451cab5ce144814::auth::Auth, arg2: u16, arg3: 0xc1e7632c9847370a0f00298defa15d42fcb0e3191cad3bee8451cab5ce144814::structs::Source, arg4: 0x1::option::Option<0xc1e7632c9847370a0f00298defa15d42fcb0e3191cad3bee8451cab5ce144814::structs::Source>, arg5: &0x2::tx_context::TxContext) {
        0xc1e7632c9847370a0f00298defa15d42fcb0e3191cad3bee8451cab5ce144814::registry::assert_version(arg0);
        0xc1e7632c9847370a0f00298defa15d42fcb0e3191cad3bee8451cab5ce144814::auth::assert_has<0xc1e7632c9847370a0f00298defa15d42fcb0e3191cad3bee8451cab5ce144814::auth::AuthorizeRole>(arg1, 0x2::tx_context::sender(arg5));
        assert!(!0xc1e7632c9847370a0f00298defa15d42fcb0e3191cad3bee8451cab5ce144814::registry::oracle_exists(arg0, arg2), 0xc1e7632c9847370a0f00298defa15d42fcb0e3191cad3bee8451cab5ce144814::errors::admin_oracle_nonce_taken());
        assert!(0xc1e7632c9847370a0f00298defa15d42fcb0e3191cad3bee8451cab5ce144814::structs::is_valid(&arg3), 0xc1e7632c9847370a0f00298defa15d42fcb0e3191cad3bee8451cab5ce144814::errors::admin_invalid_source());
        if (0x1::option::is_some<0xc1e7632c9847370a0f00298defa15d42fcb0e3191cad3bee8451cab5ce144814::structs::Source>(&arg4)) {
            let v0 = 0x1::option::borrow<0xc1e7632c9847370a0f00298defa15d42fcb0e3191cad3bee8451cab5ce144814::structs::Source>(&arg4);
            assert!(0xc1e7632c9847370a0f00298defa15d42fcb0e3191cad3bee8451cab5ce144814::structs::is_valid(v0), 0xc1e7632c9847370a0f00298defa15d42fcb0e3191cad3bee8451cab5ce144814::errors::admin_invalid_source());
            let v1 = 0xc1e7632c9847370a0f00298defa15d42fcb0e3191cad3bee8451cab5ce144814::structs::source_type(&arg3);
            let v2 = 0xc1e7632c9847370a0f00298defa15d42fcb0e3191cad3bee8451cab5ce144814::structs::source_type(v0);
            assert!(!0xc1e7632c9847370a0f00298defa15d42fcb0e3191cad3bee8451cab5ce144814::structs::same_provider(&v1, &v2), 0xc1e7632c9847370a0f00298defa15d42fcb0e3191cad3bee8451cab5ce144814::errors::admin_invalid_source());
        };
        0xc1e7632c9847370a0f00298defa15d42fcb0e3191cad3bee8451cab5ce144814::oracle::share(0xc1e7632c9847370a0f00298defa15d42fcb0e3191cad3bee8451cab5ce144814::oracle::create(arg0, arg2, arg3, arg4));
    }

    public fun migrate(arg0: &mut 0xc1e7632c9847370a0f00298defa15d42fcb0e3191cad3bee8451cab5ce144814::registry::OracleRegistry, arg1: &0xc1e7632c9847370a0f00298defa15d42fcb0e3191cad3bee8451cab5ce144814::auth::Auth, arg2: &0x2::tx_context::TxContext) {
        0xc1e7632c9847370a0f00298defa15d42fcb0e3191cad3bee8451cab5ce144814::auth::assert_has<0xc1e7632c9847370a0f00298defa15d42fcb0e3191cad3bee8451cab5ce144814::auth::AdminRole>(arg1, 0x2::tx_context::sender(arg2));
        0xc1e7632c9847370a0f00298defa15d42fcb0e3191cad3bee8451cab5ce144814::registry::migrate(arg0);
    }

    public fun update_admin(arg0: &mut 0xc1e7632c9847370a0f00298defa15d42fcb0e3191cad3bee8451cab5ce144814::auth::Auth, arg1: address, arg2: bool, arg3: &0x2::tx_context::TxContext) {
        if (arg2) {
            0xc1e7632c9847370a0f00298defa15d42fcb0e3191cad3bee8451cab5ce144814::auth::grant<0xc1e7632c9847370a0f00298defa15d42fcb0e3191cad3bee8451cab5ce144814::auth::AdminRole>(arg0, arg1, arg3);
        } else {
            0xc1e7632c9847370a0f00298defa15d42fcb0e3191cad3bee8451cab5ce144814::auth::revoke<0xc1e7632c9847370a0f00298defa15d42fcb0e3191cad3bee8451cab5ce144814::auth::AdminRole>(arg0, arg1, arg3);
        };
    }

    public fun update_auth(arg0: &mut 0xc1e7632c9847370a0f00298defa15d42fcb0e3191cad3bee8451cab5ce144814::auth::Auth, arg1: address, arg2: bool, arg3: &0x2::tx_context::TxContext) {
        if (arg2) {
            0xc1e7632c9847370a0f00298defa15d42fcb0e3191cad3bee8451cab5ce144814::auth::grant<0xc1e7632c9847370a0f00298defa15d42fcb0e3191cad3bee8451cab5ce144814::auth::AuthorizeRole>(arg0, arg1, arg3);
        } else {
            0xc1e7632c9847370a0f00298defa15d42fcb0e3191cad3bee8451cab5ce144814::auth::revoke<0xc1e7632c9847370a0f00298defa15d42fcb0e3191cad3bee8451cab5ce144814::auth::AuthorizeRole>(arg0, arg1, arg3);
        };
    }

    // decompiled from Move bytecode v7
}

