module 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::upgrade_gov {
    struct AuthorizeUpgrade has drop {
        dummy_field: bool,
    }

    struct AuthorizeUpgradeParams has drop, store {
        pos0: 0x2::object::ID,
        pos1: u8,
        pos2: vector<u8>,
    }

    public fun commit_upgrade(arg0: &mut 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::CapStore, arg1: 0x2::package::UpgradeReceipt, arg2: 0x2::object::ID) {
        0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::assert_version(arg0);
        let v0 = 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::borrow_upgrade_cap_mut(arg0, arg2);
        0x2::package::commit_upgrade(v0, arg1);
        0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::events::emit_upgrade_committed(arg2, 0x2::package::upgrade_package(v0), 0x2::package::version(v0));
    }

    public fun authorize_scheduled_upgrade(arg0: &mut 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::CapStore, arg1: &mut 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::Timelock, arg2: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::Auth, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::package::UpgradeTicket {
        let v0 = AuthorizeUpgrade{dummy_field: false};
        let (_, v2) = 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::consume<AuthorizeUpgrade, AuthorizeUpgradeParams>(arg1, 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::execute_admin<AuthorizeUpgrade, AuthorizeUpgradeParams>(arg0, arg1, arg2, arg3, arg4, arg5), v0);
        let AuthorizeUpgradeParams {
            pos0 : v3,
            pos1 : v4,
            pos2 : v5,
        } = v2;
        0x2::package::authorize_upgrade(0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::borrow_upgrade_cap_mut(arg0, v3), v4, v5)
    }

    public fun schedule_upgrade(arg0: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::CapStore, arg1: &mut 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock::Timelock, arg2: &0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::auth::Auth, arg3: 0x2::object::ID, arg4: u8, arg5: vector<u8>, arg6: vector<u8>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : vector<u8> {
        assert!(0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::cap_store::holds_upgrade_cap(arg0, arg3), 0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::errors::upgrade_cap_missing());
        let v0 = AuthorizeUpgradeParams{
            pos0 : arg3,
            pos1 : arg4,
            pos2 : arg5,
        };
        0xd72edfd47230c20beae269b3d62104e7b0ffc9be1a452f6439205b8da08bb02a::timelock_ops::schedule_admin<AuthorizeUpgrade, AuthorizeUpgradeParams>(arg0, arg1, arg2, v0, arg6, arg7, arg8)
    }

    // decompiled from Move bytecode v7
}

