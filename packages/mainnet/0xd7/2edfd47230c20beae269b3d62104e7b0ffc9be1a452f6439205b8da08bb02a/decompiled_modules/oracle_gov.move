module 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::oracle_gov {
    struct UpdateAdmin has drop {
        dummy_field: bool,
    }

    struct UpdateAdminParams has drop, store {
        pos0: address,
        pos1: bool,
    }

    struct UpdateAuth has drop {
        dummy_field: bool,
    }

    struct UpdateAuthParams has drop, store {
        pos0: address,
        pos1: bool,
    }

    struct UpdateMigrator has drop {
        dummy_field: bool,
    }

    struct UpdateMigratorParams has drop, store {
        pos0: address,
        pos1: bool,
    }

    struct DisableTimelock has drop {
        dummy_field: bool,
    }

    struct DisableTimelockParams has drop, store {
        dummy_field: bool,
    }

    struct InitOracleConfig has drop {
        dummy_field: bool,
    }

    struct InitOracleConfigParams has drop, store {
        pos0: u16,
        pos1: 0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::structs::Source,
        pos2: 0x1::option::Option<0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::structs::Source>,
    }

    public fun enable_timelock(arg0: &mut 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::CapStore, arg1: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::Auth, arg2: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::SetupCap, arg3: &0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::registry::OracleRegistry, arg4: &mut 0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::auth::Auth, arg5: &mut 0x2::tx_context::TxContext) {
        0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::assert_roles_finalized(arg1);
        0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::store_cap<0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::timelock_cap::TimelockCap>(arg0, 0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::admin::mint_timelock_cap(arg3, arg4, arg5));
    }

    public fun execute_disable_timelock(arg0: &mut 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::CapStore, arg1: &mut 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::Timelock, arg2: &0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::registry::OracleRegistry, arg3: &mut 0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::auth::Auth, arg4: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::Auth, arg5: vector<u8>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = DisableTimelock{dummy_field: false};
        let (_, v2) = 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::consume<DisableTimelock, DisableTimelockParams>(arg1, 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::execute_admin<DisableTimelock, DisableTimelockParams>(arg0, arg1, arg4, arg5, arg6, arg7), v0);
        let DisableTimelockParams {  } = v2;
        0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::admin::disable_timelock(arg2, arg3, 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::remove<0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::timelock_cap::TimelockCap>(arg0), arg7);
    }

    public fun execute_init_oracle_config(arg0: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::CapStore, arg1: &mut 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::Timelock, arg2: &mut 0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::registry::OracleRegistry, arg3: &0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::auth::Auth, arg4: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::Auth, arg5: vector<u8>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = InitOracleConfig{dummy_field: false};
        let (_, v2) = 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::consume<InitOracleConfig, InitOracleConfigParams>(arg1, 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::execute_auth<InitOracleConfig, InitOracleConfigParams>(arg0, arg1, arg4, arg5, arg6, arg7), v0);
        let InitOracleConfigParams {
            pos0 : v3,
            pos1 : v4,
            pos2 : v5,
        } = v2;
        0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::admin::init_oracle_config(arg2, arg3, ticket_of(arg0, arg3), v3, v4, v5, arg7);
    }

    public fun execute_update_admin(arg0: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::CapStore, arg1: &mut 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::Timelock, arg2: &0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::registry::OracleRegistry, arg3: &mut 0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::auth::Auth, arg4: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::Auth, arg5: vector<u8>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = UpdateAdmin{dummy_field: false};
        let (_, v2) = 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::consume<UpdateAdmin, UpdateAdminParams>(arg1, 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::execute_admin<UpdateAdmin, UpdateAdminParams>(arg0, arg1, arg4, arg5, arg6, arg7), v0);
        let UpdateAdminParams {
            pos0 : v3,
            pos1 : v4,
        } = v2;
        0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::admin::update_admin(arg2, arg3, ticket_of(arg0, arg3), v3, v4, arg7);
    }

    public fun execute_update_auth(arg0: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::CapStore, arg1: &mut 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::Timelock, arg2: &0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::registry::OracleRegistry, arg3: &mut 0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::auth::Auth, arg4: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::Auth, arg5: vector<u8>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = UpdateAuth{dummy_field: false};
        let (_, v2) = 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::consume<UpdateAuth, UpdateAuthParams>(arg1, 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::execute_admin<UpdateAuth, UpdateAuthParams>(arg0, arg1, arg4, arg5, arg6, arg7), v0);
        let UpdateAuthParams {
            pos0 : v3,
            pos1 : v4,
        } = v2;
        0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::admin::update_auth(arg2, arg3, ticket_of(arg0, arg3), v3, v4, arg7);
    }

    public fun execute_update_migrator(arg0: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::CapStore, arg1: &mut 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::Timelock, arg2: &0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::registry::OracleRegistry, arg3: &mut 0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::auth::Auth, arg4: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::Auth, arg5: vector<u8>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = UpdateMigrator{dummy_field: false};
        let (_, v2) = 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::consume<UpdateMigrator, UpdateMigratorParams>(arg1, 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::execute_admin<UpdateMigrator, UpdateMigratorParams>(arg0, arg1, arg4, arg5, arg6, arg7), v0);
        let UpdateMigratorParams {
            pos0 : v3,
            pos1 : v4,
        } = v2;
        0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::admin::update_migrator(arg2, arg3, ticket_of(arg0, arg3), v3, v4, arg7);
    }

    public fun schedule_disable_timelock(arg0: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::CapStore, arg1: &mut 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::Timelock, arg2: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::Auth, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : vector<u8> {
        let v0 = DisableTimelockParams{dummy_field: false};
        0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::schedule_admin<DisableTimelock, DisableTimelockParams>(arg0, arg1, arg2, v0, arg3, arg4, arg5)
    }

    public fun schedule_init_oracle_config(arg0: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::CapStore, arg1: &mut 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::Timelock, arg2: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::Auth, arg3: u16, arg4: 0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::structs::Source, arg5: 0x1::option::Option<0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::structs::Source>, arg6: vector<u8>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : vector<u8> {
        let v0 = InitOracleConfigParams{
            pos0 : arg3,
            pos1 : arg4,
            pos2 : arg5,
        };
        0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::schedule_auth<InitOracleConfig, InitOracleConfigParams>(arg0, arg1, arg2, v0, arg6, arg7, arg8)
    }

    public fun schedule_update_admin(arg0: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::CapStore, arg1: &mut 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::Timelock, arg2: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::Auth, arg3: address, arg4: bool, arg5: vector<u8>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : vector<u8> {
        let v0 = UpdateAdminParams{
            pos0 : arg3,
            pos1 : arg4,
        };
        0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::schedule_admin<UpdateAdmin, UpdateAdminParams>(arg0, arg1, arg2, v0, arg5, arg6, arg7)
    }

    public fun schedule_update_auth(arg0: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::CapStore, arg1: &mut 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::Timelock, arg2: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::Auth, arg3: address, arg4: bool, arg5: vector<u8>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : vector<u8> {
        let v0 = UpdateAuthParams{
            pos0 : arg3,
            pos1 : arg4,
        };
        0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::schedule_admin<UpdateAuth, UpdateAuthParams>(arg0, arg1, arg2, v0, arg5, arg6, arg7)
    }

    public fun schedule_update_migrator(arg0: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::CapStore, arg1: &mut 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::Timelock, arg2: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::Auth, arg3: address, arg4: bool, arg5: vector<u8>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : vector<u8> {
        let v0 = UpdateMigratorParams{
            pos0 : arg3,
            pos1 : arg4,
        };
        0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::schedule_admin<UpdateMigrator, UpdateMigratorParams>(arg0, arg1, arg2, v0, arg5, arg6, arg7)
    }

    fun ticket_of(arg0: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::CapStore, arg1: &0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::auth::Auth) : 0x1::option::Option<0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::timelock_cap::TimelockTicket> {
        if (!0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::holds<0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::timelock_cap::TimelockCap>(arg0)) {
            return 0x1::option::none<0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::timelock_cap::TimelockTicket>()
        };
        0x1::option::some<0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::timelock_cap::TimelockTicket>(0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::auth::timelock_ticket(arg1, 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::borrow<0x2caaa38d2c1c424d8ec79750c110d2211f2e06d66a9a261204f721175da15bcc::timelock_cap::TimelockCap>(arg0)))
    }

    // decompiled from Move bytecode v7
}

