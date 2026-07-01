module 0xe308bd40bd81aa42b9245e4b51b3fe63801c77c78a76be4ce5902aae549f7221::events {
    struct AccountCreated has copy, drop {
        owner: address,
        account_object_address: address,
        alias: 0x1::string::String,
        index: u64,
    }

    struct AccountAliasUpdated has copy, drop {
        account_object_address: address,
        alias: 0x1::string::String,
    }

    struct DelegateAdded has copy, drop {
        account_object_address: address,
        delegate: address,
        alias: 0x1::string::String,
        permissions: u32,
        expires_at_ms: 0x1::option::Option<u64>,
    }

    struct DelegateRemoved has copy, drop {
        account_object_address: address,
        delegate: address,
    }

    struct DelegateUpdated has copy, drop {
        account_object_address: address,
        delegate: address,
        alias: 0x1::string::String,
        permissions: u32,
        expires_at_ms: 0x1::option::Option<u64>,
    }

    struct DelegateProtocolPermissionSet has copy, drop {
        account_object_address: address,
        delegate: address,
        protocol: 0x1::type_name::TypeName,
        permissions: u32,
    }

    struct DelegateProtocolPermissionUnset has copy, drop {
        account_object_address: address,
        delegate: address,
        protocol: 0x1::type_name::TypeName,
    }

    struct ProtocolWhitelisted has copy, drop {
        protocol: 0x1::type_name::TypeName,
    }

    struct ProtocolDelisted has copy, drop {
        protocol: 0x1::type_name::TypeName,
    }

    struct ProtocolPaused has copy, drop {
        protocol: 0x1::type_name::TypeName,
    }

    struct ProtocolUnpaused has copy, drop {
        protocol: 0x1::type_name::TypeName,
    }

    struct ProtocolAssetAllowed has copy, drop {
        protocol: 0x1::type_name::TypeName,
        asset: 0x1::type_name::TypeName,
    }

    struct ProtocolAssetDisallowed has copy, drop {
        protocol: 0x1::type_name::TypeName,
        asset: 0x1::type_name::TypeName,
    }

    struct DepositPolicyRegistered has copy, drop {
        token_type: 0x1::type_name::TypeName,
        policy: 0x1::type_name::TypeName,
    }

    struct DepositPolicyUnregistered has copy, drop {
        token_type: 0x1::type_name::TypeName,
        policy: 0x1::type_name::TypeName,
    }

    struct WithdrawPolicyRegistered has copy, drop {
        token_type: 0x1::type_name::TypeName,
        policy: 0x1::type_name::TypeName,
    }

    struct WithdrawPolicyUnregistered has copy, drop {
        token_type: 0x1::type_name::TypeName,
        policy: 0x1::type_name::TypeName,
    }

    struct DepositRequested has copy, drop {
        account_object_address: address,
        token_type: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct DepositConsumed has copy, drop {
        account_object_address: address,
        token_type: 0x1::type_name::TypeName,
        policy: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct WithdrawRequested has copy, drop {
        account_object_address: address,
        token_type: 0x1::type_name::TypeName,
        amount: u64,
        requested_by: address,
        recipient: address,
    }

    struct WithdrawConsumed has copy, drop {
        account_object_address: address,
        token_type: 0x1::type_name::TypeName,
        policy: 0x1::type_name::TypeName,
        amount: u64,
        recipient: address,
    }

    struct TakenByProtocol has copy, drop {
        account_object_address: address,
        protocol: 0x1::type_name::TypeName,
        token_type: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct ReturnedByProtocol has copy, drop {
        account_object_address: address,
        protocol: 0x1::type_name::TypeName,
        token_type: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct ManagerAdded has copy, drop {
        manager: address,
    }

    struct ManagerRemoved has copy, drop {
        manager: address,
    }

    struct Paused has copy, drop {
        paused_by: address,
    }

    struct Unpaused has copy, drop {
        dummy_field: bool,
    }

    struct VersionAllowed has copy, drop {
        version: u16,
    }

    struct VersionDisallowed has copy, drop {
        version: u16,
    }

    public(friend) fun emit_account_alias_updated(arg0: address, arg1: 0x1::string::String) {
        let v0 = AccountAliasUpdated{
            account_object_address : arg0,
            alias                  : arg1,
        };
        0x2::event::emit<AccountAliasUpdated>(v0);
    }

    public(friend) fun emit_account_created(arg0: address, arg1: address, arg2: 0x1::string::String, arg3: u64) {
        let v0 = AccountCreated{
            owner                  : arg0,
            account_object_address : arg1,
            alias                  : arg2,
            index                  : arg3,
        };
        0x2::event::emit<AccountCreated>(v0);
    }

    public(friend) fun emit_delegate_added(arg0: address, arg1: address, arg2: 0x1::string::String, arg3: u32, arg4: 0x1::option::Option<u64>) {
        let v0 = DelegateAdded{
            account_object_address : arg0,
            delegate               : arg1,
            alias                  : arg2,
            permissions            : arg3,
            expires_at_ms          : arg4,
        };
        0x2::event::emit<DelegateAdded>(v0);
    }

    public(friend) fun emit_delegate_protocol_permission_set(arg0: address, arg1: address, arg2: 0x1::type_name::TypeName, arg3: u32) {
        let v0 = DelegateProtocolPermissionSet{
            account_object_address : arg0,
            delegate               : arg1,
            protocol               : arg2,
            permissions            : arg3,
        };
        0x2::event::emit<DelegateProtocolPermissionSet>(v0);
    }

    public(friend) fun emit_delegate_protocol_permission_unset(arg0: address, arg1: address, arg2: 0x1::type_name::TypeName) {
        let v0 = DelegateProtocolPermissionUnset{
            account_object_address : arg0,
            delegate               : arg1,
            protocol               : arg2,
        };
        0x2::event::emit<DelegateProtocolPermissionUnset>(v0);
    }

    public(friend) fun emit_delegate_removed(arg0: address, arg1: address) {
        let v0 = DelegateRemoved{
            account_object_address : arg0,
            delegate               : arg1,
        };
        0x2::event::emit<DelegateRemoved>(v0);
    }

    public(friend) fun emit_delegate_updated(arg0: address, arg1: address, arg2: 0x1::string::String, arg3: u32, arg4: 0x1::option::Option<u64>) {
        let v0 = DelegateUpdated{
            account_object_address : arg0,
            delegate               : arg1,
            alias                  : arg2,
            permissions            : arg3,
            expires_at_ms          : arg4,
        };
        0x2::event::emit<DelegateUpdated>(v0);
    }

    public(friend) fun emit_deposit_consumed(arg0: address, arg1: 0x1::type_name::TypeName, arg2: 0x1::type_name::TypeName, arg3: u64) {
        let v0 = DepositConsumed{
            account_object_address : arg0,
            token_type             : arg1,
            policy                 : arg2,
            amount                 : arg3,
        };
        0x2::event::emit<DepositConsumed>(v0);
    }

    public(friend) fun emit_deposit_policy_registered(arg0: 0x1::type_name::TypeName, arg1: 0x1::type_name::TypeName) {
        let v0 = DepositPolicyRegistered{
            token_type : arg0,
            policy     : arg1,
        };
        0x2::event::emit<DepositPolicyRegistered>(v0);
    }

    public(friend) fun emit_deposit_policy_unregistered(arg0: 0x1::type_name::TypeName, arg1: 0x1::type_name::TypeName) {
        let v0 = DepositPolicyUnregistered{
            token_type : arg0,
            policy     : arg1,
        };
        0x2::event::emit<DepositPolicyUnregistered>(v0);
    }

    public(friend) fun emit_deposit_requested(arg0: address, arg1: 0x1::type_name::TypeName, arg2: u64) {
        let v0 = DepositRequested{
            account_object_address : arg0,
            token_type             : arg1,
            amount                 : arg2,
        };
        0x2::event::emit<DepositRequested>(v0);
    }

    public(friend) fun emit_manager_added(arg0: address) {
        let v0 = ManagerAdded{manager: arg0};
        0x2::event::emit<ManagerAdded>(v0);
    }

    public(friend) fun emit_manager_removed(arg0: address) {
        let v0 = ManagerRemoved{manager: arg0};
        0x2::event::emit<ManagerRemoved>(v0);
    }

    public(friend) fun emit_paused(arg0: address) {
        let v0 = Paused{paused_by: arg0};
        0x2::event::emit<Paused>(v0);
    }

    public(friend) fun emit_protocol_asset_allowed(arg0: 0x1::type_name::TypeName, arg1: 0x1::type_name::TypeName) {
        let v0 = ProtocolAssetAllowed{
            protocol : arg0,
            asset    : arg1,
        };
        0x2::event::emit<ProtocolAssetAllowed>(v0);
    }

    public(friend) fun emit_protocol_asset_disallowed(arg0: 0x1::type_name::TypeName, arg1: 0x1::type_name::TypeName) {
        let v0 = ProtocolAssetDisallowed{
            protocol : arg0,
            asset    : arg1,
        };
        0x2::event::emit<ProtocolAssetDisallowed>(v0);
    }

    public(friend) fun emit_protocol_delisted(arg0: 0x1::type_name::TypeName) {
        let v0 = ProtocolDelisted{protocol: arg0};
        0x2::event::emit<ProtocolDelisted>(v0);
    }

    public(friend) fun emit_protocol_paused(arg0: 0x1::type_name::TypeName) {
        let v0 = ProtocolPaused{protocol: arg0};
        0x2::event::emit<ProtocolPaused>(v0);
    }

    public(friend) fun emit_protocol_unpaused(arg0: 0x1::type_name::TypeName) {
        let v0 = ProtocolUnpaused{protocol: arg0};
        0x2::event::emit<ProtocolUnpaused>(v0);
    }

    public(friend) fun emit_protocol_whitelisted(arg0: 0x1::type_name::TypeName) {
        let v0 = ProtocolWhitelisted{protocol: arg0};
        0x2::event::emit<ProtocolWhitelisted>(v0);
    }

    public(friend) fun emit_returned_by_protocol(arg0: address, arg1: 0x1::type_name::TypeName, arg2: 0x1::type_name::TypeName, arg3: u64) {
        let v0 = ReturnedByProtocol{
            account_object_address : arg0,
            protocol               : arg1,
            token_type             : arg2,
            amount                 : arg3,
        };
        0x2::event::emit<ReturnedByProtocol>(v0);
    }

    public(friend) fun emit_taken_by_protocol(arg0: address, arg1: 0x1::type_name::TypeName, arg2: 0x1::type_name::TypeName, arg3: u64) {
        let v0 = TakenByProtocol{
            account_object_address : arg0,
            protocol               : arg1,
            token_type             : arg2,
            amount                 : arg3,
        };
        0x2::event::emit<TakenByProtocol>(v0);
    }

    public(friend) fun emit_unpaused() {
        let v0 = Unpaused{dummy_field: false};
        0x2::event::emit<Unpaused>(v0);
    }

    public(friend) fun emit_version_allowed(arg0: u16) {
        let v0 = VersionAllowed{version: arg0};
        0x2::event::emit<VersionAllowed>(v0);
    }

    public(friend) fun emit_version_disallowed(arg0: u16) {
        let v0 = VersionDisallowed{version: arg0};
        0x2::event::emit<VersionDisallowed>(v0);
    }

    public(friend) fun emit_withdraw_consumed(arg0: address, arg1: 0x1::type_name::TypeName, arg2: 0x1::type_name::TypeName, arg3: u64, arg4: address) {
        let v0 = WithdrawConsumed{
            account_object_address : arg0,
            token_type             : arg1,
            policy                 : arg2,
            amount                 : arg3,
            recipient              : arg4,
        };
        0x2::event::emit<WithdrawConsumed>(v0);
    }

    public(friend) fun emit_withdraw_policy_registered(arg0: 0x1::type_name::TypeName, arg1: 0x1::type_name::TypeName) {
        let v0 = WithdrawPolicyRegistered{
            token_type : arg0,
            policy     : arg1,
        };
        0x2::event::emit<WithdrawPolicyRegistered>(v0);
    }

    public(friend) fun emit_withdraw_policy_unregistered(arg0: 0x1::type_name::TypeName, arg1: 0x1::type_name::TypeName) {
        let v0 = WithdrawPolicyUnregistered{
            token_type : arg0,
            policy     : arg1,
        };
        0x2::event::emit<WithdrawPolicyUnregistered>(v0);
    }

    public(friend) fun emit_withdraw_requested(arg0: address, arg1: 0x1::type_name::TypeName, arg2: u64, arg3: address, arg4: address) {
        let v0 = WithdrawRequested{
            account_object_address : arg0,
            token_type             : arg1,
            amount                 : arg2,
            requested_by           : arg3,
            recipient              : arg4,
        };
        0x2::event::emit<WithdrawRequested>(v0);
    }

    // decompiled from Move bytecode v7
}

