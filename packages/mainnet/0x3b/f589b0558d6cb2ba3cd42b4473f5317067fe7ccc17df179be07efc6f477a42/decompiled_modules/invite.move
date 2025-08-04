module 0x3bf589b0558d6cb2ba3cd42b4473f5317067fe7ccc17df179be07efc6f477a42::invite {
    struct Permission has copy, drop, store {
        can_read: bool,
        can_write: bool,
        can_admin: bool,
        expires_at: 0x1::option::Option<u64>,
    }

    struct DatabaseInvite has store, key {
        id: 0x2::object::UID,
        database_id: 0x2::object::ID,
        database_name: 0x1::string::String,
        from: address,
        to: address,
        permission: Permission,
        message: 0x1::option::Option<0x1::string::String>,
        created_at: u64,
        expires_at: 0x1::option::Option<u64>,
    }

    struct AccessRequest has store, key {
        id: 0x2::object::UID,
        database_id: 0x2::object::ID,
        database_name: 0x1::string::String,
        from: address,
        to: address,
        requested_permission: Permission,
        message: 0x1::option::Option<0x1::string::String>,
        created_at: u64,
    }

    struct InviteRegistry has key {
        id: 0x2::object::UID,
        pending_invites: 0x2::table::Table<address, vector<0x2::object::ID>>,
        pending_requests: 0x2::table::Table<address, vector<0x2::object::ID>>,
    }

    struct InviteSent has copy, drop {
        invite_id: 0x2::object::ID,
        database_id: 0x2::object::ID,
        from: address,
        to: address,
        permission: Permission,
    }

    struct InviteAccepted has copy, drop {
        invite_id: 0x2::object::ID,
        database_id: 0x2::object::ID,
        user: address,
    }

    struct InviteRejected has copy, drop {
        invite_id: 0x2::object::ID,
        database_id: 0x2::object::ID,
        user: address,
    }

    struct AccessRequested has copy, drop {
        request_id: 0x2::object::ID,
        database_id: 0x2::object::ID,
        from: address,
        to: address,
        requested_permission: Permission,
    }

    struct RequestApproved has copy, drop {
        request_id: 0x2::object::ID,
        database_id: 0x2::object::ID,
        user: address,
    }

    struct RequestRejected has copy, drop {
        request_id: 0x2::object::ID,
        database_id: 0x2::object::ID,
        user: address,
    }

    public entry fun accept_invite(arg0: DatabaseInvite, arg1: &mut InviteRegistry, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg0.to, 205);
        if (0x1::option::is_some<u64>(&arg0.expires_at)) {
            assert!(*0x1::option::borrow<u64>(&arg0.expires_at) > 0x2::tx_context::epoch_timestamp_ms(arg2), 204);
        };
        let v1 = 0x2::object::id<DatabaseInvite>(&arg0);
        remove_invite_from_registry(arg1, arg0.to, v1);
        let v2 = InviteAccepted{
            invite_id   : v1,
            database_id : arg0.database_id,
            user        : v0,
        };
        0x2::event::emit<InviteAccepted>(v2);
        let DatabaseInvite {
            id            : v3,
            database_id   : _,
            database_name : _,
            from          : _,
            to            : _,
            permission    : _,
            message       : _,
            created_at    : _,
            expires_at    : _,
        } = arg0;
        0x2::object::delete(v3);
    }

    public entry fun approve_request(arg0: AccessRequest, arg1: &mut InviteRegistry, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.to, 206);
        let v0 = 0x2::object::id<AccessRequest>(&arg0);
        remove_request_from_registry(arg1, arg0.to, v0);
        let v1 = RequestApproved{
            request_id  : v0,
            database_id : arg0.database_id,
            user        : arg0.from,
        };
        0x2::event::emit<RequestApproved>(v1);
        let AccessRequest {
            id                   : v2,
            database_id          : _,
            database_name        : _,
            from                 : _,
            to                   : _,
            requested_permission : _,
            message              : _,
            created_at           : _,
        } = arg0;
        0x2::object::delete(v2);
    }

    public fun create_permission(arg0: bool, arg1: bool, arg2: bool, arg3: 0x1::option::Option<u64>) : Permission {
        Permission{
            can_read   : arg0,
            can_write  : arg1,
            can_admin  : arg2,
            expires_at : arg3,
        }
    }

    fun find_id_index(arg0: &vector<0x2::object::ID>, arg1: 0x2::object::ID) : (bool, u64) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x2::object::ID>(arg0)) {
            if (*0x1::vector::borrow<0x2::object::ID>(arg0, v0) == arg1) {
                return (true, v0)
            };
            v0 = v0 + 1;
        };
        (false, 0)
    }

    public fun get_invite_details(arg0: &DatabaseInvite) : (0x2::object::ID, 0x1::string::String, address, address, &Permission, &0x1::option::Option<0x1::string::String>, u64, &0x1::option::Option<u64>) {
        (arg0.database_id, arg0.database_name, arg0.from, arg0.to, &arg0.permission, &arg0.message, arg0.created_at, &arg0.expires_at)
    }

    public fun get_pending_invites(arg0: &InviteRegistry, arg1: address) : vector<0x2::object::ID> {
        if (0x2::table::contains<address, vector<0x2::object::ID>>(&arg0.pending_invites, arg1)) {
            *0x2::table::borrow<address, vector<0x2::object::ID>>(&arg0.pending_invites, arg1)
        } else {
            0x1::vector::empty<0x2::object::ID>()
        }
    }

    public fun get_pending_requests(arg0: &InviteRegistry, arg1: address) : vector<0x2::object::ID> {
        if (0x2::table::contains<address, vector<0x2::object::ID>>(&arg0.pending_requests, arg1)) {
            *0x2::table::borrow<address, vector<0x2::object::ID>>(&arg0.pending_requests, arg1)
        } else {
            0x1::vector::empty<0x2::object::ID>()
        }
    }

    public fun get_permission_details(arg0: &Permission) : (bool, bool, bool, 0x1::option::Option<u64>) {
        (arg0.can_read, arg0.can_write, arg0.can_admin, arg0.expires_at)
    }

    public fun get_request_details(arg0: &AccessRequest) : (0x2::object::ID, 0x1::string::String, address, address, &Permission, &0x1::option::Option<0x1::string::String>, u64) {
        (arg0.database_id, arg0.database_name, arg0.from, arg0.to, &arg0.requested_permission, &arg0.message, arg0.created_at)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = InviteRegistry{
            id               : 0x2::object::new(arg0),
            pending_invites  : 0x2::table::new<address, vector<0x2::object::ID>>(arg0),
            pending_requests : 0x2::table::new<address, vector<0x2::object::ID>>(arg0),
        };
        0x2::transfer::share_object<InviteRegistry>(v0);
    }

    public entry fun reject_invite(arg0: DatabaseInvite, arg1: &mut InviteRegistry, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg0.to, 205);
        let v1 = 0x2::object::id<DatabaseInvite>(&arg0);
        remove_invite_from_registry(arg1, arg0.to, v1);
        let v2 = InviteRejected{
            invite_id   : v1,
            database_id : arg0.database_id,
            user        : v0,
        };
        0x2::event::emit<InviteRejected>(v2);
        let DatabaseInvite {
            id            : v3,
            database_id   : _,
            database_name : _,
            from          : _,
            to            : _,
            permission    : _,
            message       : _,
            created_at    : _,
            expires_at    : _,
        } = arg0;
        0x2::object::delete(v3);
    }

    public entry fun reject_request(arg0: AccessRequest, arg1: &mut InviteRegistry, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.to, 206);
        let v0 = 0x2::object::id<AccessRequest>(&arg0);
        remove_request_from_registry(arg1, arg0.to, v0);
        let v1 = RequestRejected{
            request_id  : v0,
            database_id : arg0.database_id,
            user        : arg0.from,
        };
        0x2::event::emit<RequestRejected>(v1);
        let AccessRequest {
            id                   : v2,
            database_id          : _,
            database_name        : _,
            from                 : _,
            to                   : _,
            requested_permission : _,
            message              : _,
            created_at           : _,
        } = arg0;
        0x2::object::delete(v2);
    }

    fun remove_invite_from_registry(arg0: &mut InviteRegistry, arg1: address, arg2: 0x2::object::ID) {
        if (0x2::table::contains<address, vector<0x2::object::ID>>(&arg0.pending_invites, arg1)) {
            let v0 = 0x2::table::borrow_mut<address, vector<0x2::object::ID>>(&mut arg0.pending_invites, arg1);
            let (v1, v2) = find_id_index(v0, arg2);
            if (v1) {
                0x1::vector::remove<0x2::object::ID>(v0, v2);
            };
        };
    }

    fun remove_request_from_registry(arg0: &mut InviteRegistry, arg1: address, arg2: 0x2::object::ID) {
        if (0x2::table::contains<address, vector<0x2::object::ID>>(&arg0.pending_requests, arg1)) {
            let v0 = 0x2::table::borrow_mut<address, vector<0x2::object::ID>>(&mut arg0.pending_requests, arg1);
            let (v1, v2) = find_id_index(v0, arg2);
            if (v1) {
                0x1::vector::remove<0x2::object::ID>(v0, v2);
            };
        };
    }

    public entry fun request_access(arg0: &mut InviteRegistry, arg1: 0x2::object::ID, arg2: 0x1::string::String, arg3: address, arg4: bool, arg5: bool, arg6: bool, arg7: 0x1::option::Option<0x1::string::String>, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg8);
        let v1 = Permission{
            can_read   : arg4,
            can_write  : arg5,
            can_admin  : arg6,
            expires_at : 0x1::option::none<u64>(),
        };
        let v2 = AccessRequest{
            id                   : 0x2::object::new(arg8),
            database_id          : arg1,
            database_name        : arg2,
            from                 : v0,
            to                   : arg3,
            requested_permission : v1,
            message              : arg7,
            created_at           : 0x2::tx_context::epoch_timestamp_ms(arg8),
        };
        let v3 = 0x2::object::id<AccessRequest>(&v2);
        if (!0x2::table::contains<address, vector<0x2::object::ID>>(&arg0.pending_requests, arg3)) {
            0x2::table::add<address, vector<0x2::object::ID>>(&mut arg0.pending_requests, arg3, 0x1::vector::empty<0x2::object::ID>());
        };
        0x1::vector::push_back<0x2::object::ID>(0x2::table::borrow_mut<address, vector<0x2::object::ID>>(&mut arg0.pending_requests, arg3), v3);
        let v4 = AccessRequested{
            request_id           : v3,
            database_id          : arg1,
            from                 : v0,
            to                   : arg3,
            requested_permission : v1,
        };
        0x2::event::emit<AccessRequested>(v4);
        0x2::transfer::transfer<AccessRequest>(v2, arg3);
    }

    public entry fun send_invite(arg0: &mut InviteRegistry, arg1: 0x2::object::ID, arg2: 0x1::string::String, arg3: address, arg4: bool, arg5: bool, arg6: bool, arg7: 0x1::option::Option<u64>, arg8: 0x1::option::Option<u64>, arg9: 0x1::option::Option<0x1::string::String>, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg10);
        let v1 = Permission{
            can_read   : arg4,
            can_write  : arg5,
            can_admin  : arg6,
            expires_at : arg8,
        };
        let v2 = DatabaseInvite{
            id            : 0x2::object::new(arg10),
            database_id   : arg1,
            database_name : arg2,
            from          : v0,
            to            : arg3,
            permission    : v1,
            message       : arg9,
            created_at    : 0x2::tx_context::epoch_timestamp_ms(arg10),
            expires_at    : arg7,
        };
        let v3 = 0x2::object::id<DatabaseInvite>(&v2);
        if (!0x2::table::contains<address, vector<0x2::object::ID>>(&arg0.pending_invites, arg3)) {
            0x2::table::add<address, vector<0x2::object::ID>>(&mut arg0.pending_invites, arg3, 0x1::vector::empty<0x2::object::ID>());
        };
        0x1::vector::push_back<0x2::object::ID>(0x2::table::borrow_mut<address, vector<0x2::object::ID>>(&mut arg0.pending_invites, arg3), v3);
        let v4 = InviteSent{
            invite_id   : v3,
            database_id : arg1,
            from        : v0,
            to          : arg3,
            permission  : v1,
        };
        0x2::event::emit<InviteSent>(v4);
        0x2::transfer::transfer<DatabaseInvite>(v2, arg3);
    }

    // decompiled from Move bytecode v6
}

