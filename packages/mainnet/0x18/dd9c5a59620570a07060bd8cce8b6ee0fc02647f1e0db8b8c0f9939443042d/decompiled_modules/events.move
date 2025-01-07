module 0x18dd9c5a59620570a07060bd8cce8b6ee0fc02647f1e0db8b8c0f9939443042d::events {
    struct AdminCapTransferred has copy, drop {
        previous_admin: address,
        new_admin: address,
    }

    struct SupportedVersionUpdate has copy, drop {
        old_version: u64,
        new_version: u64,
    }

    struct VaultCreated has copy, drop {
        id: 0x2::object::ID,
        manager: address,
        name: 0x1::string::String,
        type: u8,
        index: u64,
    }

    struct FundsProvided has copy, drop {
        id: 0x2::object::ID,
        provider: address,
        coin_type: 0x1::string::String,
        coin_amount: u64,
        coin_reserves_at_start: u64,
        coin_reserves_at_end: u64,
        sequence_number: u128,
    }

    struct FundsWithdrawn has copy, drop {
        id: 0x2::object::ID,
        coin_type: 0x1::string::String,
        coin_amount: u64,
        coin_reserves_at_start: u64,
        coin_reserves_at_end: u64,
        sequence_number: u128,
    }

    struct UsersAdded has copy, drop {
        id: 0x2::object::ID,
        users: vector<address>,
        sequence_number: u128,
    }

    struct UsersRemoved has copy, drop {
        id: 0x2::object::ID,
        users: vector<address>,
        sequence_number: u128,
    }

    struct FundsRequested has copy, drop {
        id: 0x2::object::ID,
        user: address,
        coin_type: 0x1::string::String,
        coin_amount: u64,
        coin_reserves_at_start: u64,
        coin_reserves_at_end: u64,
        sequence_number: u128,
    }

    struct FundsReturned has copy, drop {
        id: 0x2::object::ID,
        user: address,
        coin_type: 0x1::string::String,
        coin_amount: u64,
        coin_reserves_at_start: u64,
        coin_reserves_at_end: u64,
        sequence_number: u128,
    }

    public(friend) fun emit_admin_cap_transfer_event(arg0: address, arg1: address) {
        let v0 = AdminCapTransferred{
            previous_admin : arg0,
            new_admin      : arg1,
        };
        0x2::event::emit<AdminCapTransferred>(v0);
    }

    public(friend) fun emit_funds_provided_event(arg0: 0x2::object::ID, arg1: address, arg2: 0x1::string::String, arg3: u64, arg4: u64, arg5: u64, arg6: u128) {
        let v0 = FundsProvided{
            id                     : arg0,
            provider               : arg1,
            coin_type              : arg2,
            coin_amount            : arg3,
            coin_reserves_at_start : arg4,
            coin_reserves_at_end   : arg5,
            sequence_number        : arg6,
        };
        0x2::event::emit<FundsProvided>(v0);
    }

    public(friend) fun emit_funds_requested_event(arg0: 0x2::object::ID, arg1: address, arg2: 0x1::string::String, arg3: u64, arg4: u64, arg5: u64, arg6: u128) {
        let v0 = FundsRequested{
            id                     : arg0,
            user                   : arg1,
            coin_type              : arg2,
            coin_amount            : arg3,
            coin_reserves_at_start : arg4,
            coin_reserves_at_end   : arg5,
            sequence_number        : arg6,
        };
        0x2::event::emit<FundsRequested>(v0);
    }

    public(friend) fun emit_funds_returned_event(arg0: 0x2::object::ID, arg1: address, arg2: 0x1::string::String, arg3: u64, arg4: u64, arg5: u64, arg6: u128) {
        let v0 = FundsReturned{
            id                     : arg0,
            user                   : arg1,
            coin_type              : arg2,
            coin_amount            : arg3,
            coin_reserves_at_start : arg4,
            coin_reserves_at_end   : arg5,
            sequence_number        : arg6,
        };
        0x2::event::emit<FundsReturned>(v0);
    }

    public(friend) fun emit_funds_withdrawn_event(arg0: 0x2::object::ID, arg1: 0x1::string::String, arg2: u64, arg3: u64, arg4: u64, arg5: u128) {
        let v0 = FundsWithdrawn{
            id                     : arg0,
            coin_type              : arg1,
            coin_amount            : arg2,
            coin_reserves_at_start : arg3,
            coin_reserves_at_end   : arg4,
            sequence_number        : arg5,
        };
        0x2::event::emit<FundsWithdrawn>(v0);
    }

    public(friend) fun emit_supported_version_update_event(arg0: u64, arg1: u64) {
        let v0 = SupportedVersionUpdate{
            old_version : arg0,
            new_version : arg1,
        };
        0x2::event::emit<SupportedVersionUpdate>(v0);
    }

    public(friend) fun emit_vault_created_event(arg0: 0x2::object::ID, arg1: address, arg2: 0x1::string::String, arg3: u8, arg4: u64) {
        let v0 = VaultCreated{
            id      : arg0,
            manager : arg1,
            name    : arg2,
            type    : arg3,
            index   : arg4,
        };
        0x2::event::emit<VaultCreated>(v0);
    }

    public(friend) fun emit_vault_users_added_event(arg0: 0x2::object::ID, arg1: vector<address>, arg2: u128) {
        let v0 = UsersAdded{
            id              : arg0,
            users           : arg1,
            sequence_number : arg2,
        };
        0x2::event::emit<UsersAdded>(v0);
    }

    public(friend) fun emit_vault_users_removed_event(arg0: 0x2::object::ID, arg1: vector<address>, arg2: u128) {
        let v0 = UsersRemoved{
            id              : arg0,
            users           : arg1,
            sequence_number : arg2,
        };
        0x2::event::emit<UsersRemoved>(v0);
    }

    // decompiled from Move bytecode v6
}

