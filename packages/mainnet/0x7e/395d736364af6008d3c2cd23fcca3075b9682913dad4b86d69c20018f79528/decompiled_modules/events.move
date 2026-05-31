module 0x7e395d736364af6008d3c2cd23fcca3075b9682913dad4b86d69c20018f79528::events {
    struct OsAccountCreated has copy, drop {
        os_account_id: 0x2::object::ID,
        parent_wallet_identity: address,
        name: 0x1::option::Option<0x1::string::String>,
        signer_address: address,
        created_at_ms: u64,
    }

    struct OsAccountPausedUpdated has copy, drop {
        os_account_id: 0x2::object::ID,
        paused: bool,
    }

    struct DelegateAdded has copy, drop {
        os_account_id: 0x2::object::ID,
        delegate: address,
        permissions: u32,
    }

    struct DelegateRemoved has copy, drop {
        os_account_id: 0x2::object::ID,
        delegate: address,
    }

    struct DelegatePermissionsUpdated has copy, drop {
        os_account_id: 0x2::object::ID,
        delegate: address,
        permissions: u32,
    }

    struct MaxLeverageUpdated has copy, drop {
        os_account_id: 0x2::object::ID,
        max_leverage_bps: u64,
    }

    struct VersionAllowed has copy, drop {
        os_account_id: 0x2::object::ID,
        version: u8,
    }

    struct VersionDisallowed has copy, drop {
        os_account_id: 0x2::object::ID,
        version: u8,
    }

    public fun emit_delegate_added(arg0: 0x2::object::ID, arg1: address, arg2: u32) {
        let v0 = DelegateAdded{
            os_account_id : arg0,
            delegate      : arg1,
            permissions   : arg2,
        };
        0x2::event::emit<DelegateAdded>(v0);
    }

    public fun emit_delegate_permissions_updated(arg0: 0x2::object::ID, arg1: address, arg2: u32) {
        let v0 = DelegatePermissionsUpdated{
            os_account_id : arg0,
            delegate      : arg1,
            permissions   : arg2,
        };
        0x2::event::emit<DelegatePermissionsUpdated>(v0);
    }

    public fun emit_delegate_removed(arg0: 0x2::object::ID, arg1: address) {
        let v0 = DelegateRemoved{
            os_account_id : arg0,
            delegate      : arg1,
        };
        0x2::event::emit<DelegateRemoved>(v0);
    }

    public fun emit_max_leverage_updated(arg0: 0x2::object::ID, arg1: u64) {
        let v0 = MaxLeverageUpdated{
            os_account_id    : arg0,
            max_leverage_bps : arg1,
        };
        0x2::event::emit<MaxLeverageUpdated>(v0);
    }

    public fun emit_os_account_created(arg0: 0x2::object::ID, arg1: address, arg2: 0x1::option::Option<0x1::string::String>, arg3: address, arg4: u64) {
        let v0 = OsAccountCreated{
            os_account_id          : arg0,
            parent_wallet_identity : arg1,
            name                   : arg2,
            signer_address         : arg3,
            created_at_ms          : arg4,
        };
        0x2::event::emit<OsAccountCreated>(v0);
    }

    public fun emit_os_account_paused_updated(arg0: 0x2::object::ID, arg1: bool) {
        let v0 = OsAccountPausedUpdated{
            os_account_id : arg0,
            paused        : arg1,
        };
        0x2::event::emit<OsAccountPausedUpdated>(v0);
    }

    public fun emit_version_allowed(arg0: 0x2::object::ID, arg1: u8) {
        let v0 = VersionAllowed{
            os_account_id : arg0,
            version       : arg1,
        };
        0x2::event::emit<VersionAllowed>(v0);
    }

    public fun emit_version_disallowed(arg0: 0x2::object::ID, arg1: u8) {
        let v0 = VersionDisallowed{
            os_account_id : arg0,
            version       : arg1,
        };
        0x2::event::emit<VersionDisallowed>(v0);
    }

    // decompiled from Move bytecode v7
}

