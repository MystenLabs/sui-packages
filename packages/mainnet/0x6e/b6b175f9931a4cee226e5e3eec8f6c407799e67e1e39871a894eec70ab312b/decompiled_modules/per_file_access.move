module 0x6eb6b175f9931a4cee226e5e3eec8f6c407799e67e1e39871a894eec70ab312b::per_file_access {
    struct SystemInitialized has copy, drop {
        super_admin: address,
        registry_id: 0x2::object::ID,
        timestamp: u64,
    }

    struct AdminAdded has copy, drop {
        admin_address: address,
        added_by: address,
        timestamp: u64,
    }

    struct AdminRemoved has copy, drop {
        admin_address: address,
        removed_by: address,
        timestamp: u64,
    }

    struct SuperAdminTransferred has copy, drop {
        old_super_admin: address,
        new_super_admin: address,
        timestamp: u64,
    }

    struct FileAllowlistCreated has copy, drop {
        allowlist_id: 0x2::object::ID,
        file_id: vector<u8>,
        owner: address,
        name: 0x1::string::String,
        created_by: address,
        timestamp: u64,
    }

    struct MemberAdded has copy, drop {
        allowlist_id: 0x2::object::ID,
        member: address,
        added_by: address,
        is_admin_action: bool,
        timestamp: u64,
    }

    struct MemberRemoved has copy, drop {
        allowlist_id: 0x2::object::ID,
        member: address,
        removed_by: address,
        is_admin_action: bool,
        timestamp: u64,
    }

    struct FileUpdated has copy, drop {
        allowlist_id: 0x2::object::ID,
        old_file_id: vector<u8>,
        new_file_id: vector<u8>,
        updated_by: address,
        is_admin_action: bool,
        new_version: u64,
        timestamp: u64,
    }

    struct OwnershipTransferred has copy, drop {
        allowlist_id: 0x2::object::ID,
        old_owner: address,
        new_owner: address,
        timestamp: u64,
    }

    struct FileAllowlistDeleted has copy, drop {
        allowlist_id: 0x2::object::ID,
        file_id: vector<u8>,
        owner: address,
        deleted_by: address,
        is_admin_action: bool,
        timestamp: u64,
    }

    struct AccessChecked has copy, drop {
        allowlist_id: 0x2::object::ID,
        user: address,
        access_granted: bool,
        timestamp: u64,
    }

    struct FileAllowlist has key {
        id: 0x2::object::UID,
        file_id: vector<u8>,
        owner: address,
        name: 0x1::string::String,
        members: vector<address>,
        created_at: u64,
        last_modified: u64,
        version: u64,
    }

    struct FileOwnerCap has key {
        id: 0x2::object::UID,
        file_allowlist_id: 0x2::object::ID,
    }

    struct SuperAdminCap has key {
        id: 0x2::object::UID,
        super_admin_address: address,
    }

    struct GlobalAdminCap has key {
        id: 0x2::object::UID,
        admin_address: address,
    }

    struct AdminRegistry has key {
        id: 0x2::object::UID,
        admin_addresses: vector<address>,
    }

    public entry fun add_admin(arg0: &mut AdminRegistry, arg1: &SuperAdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(arg1.super_admin_address == v0, 5);
        assert!(!0x1::vector::contains<address>(&arg0.admin_addresses, &arg2), 4);
        0x1::vector::push_back<address>(&mut arg0.admin_addresses, arg2);
        let v1 = GlobalAdminCap{
            id            : 0x2::object::new(arg3),
            admin_address : arg2,
        };
        0x2::transfer::transfer<GlobalAdminCap>(v1, arg2);
        let v2 = AdminAdded{
            admin_address : arg2,
            added_by      : v0,
            timestamp     : 0x2::tx_context::epoch(arg3),
        };
        0x2::event::emit<AdminAdded>(v2);
    }

    public entry fun add_member(arg0: &mut FileAllowlist, arg1: &FileOwnerCap, arg2: address, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::object::id<FileAllowlist>(arg0);
        assert!(arg1.file_allowlist_id == v1, 2);
        assert!(arg0.owner == v0, 2);
        assert!(!0x1::vector::contains<address>(&arg0.members, &arg2), 4);
        0x1::vector::push_back<address>(&mut arg0.members, arg2);
        let v2 = MemberAdded{
            allowlist_id    : v1,
            member          : arg2,
            added_by        : v0,
            is_admin_action : false,
            timestamp       : 0x2::tx_context::epoch(arg3),
        };
        0x2::event::emit<MemberAdded>(v2);
    }

    public entry fun admin_add_member(arg0: &mut FileAllowlist, arg1: &GlobalAdminCap, arg2: &AdminRegistry, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(arg1.admin_address == v0, 6);
        assert!(0x1::vector::contains<address>(&arg2.admin_addresses, &v0), 6);
        assert!(!0x1::vector::contains<address>(&arg0.members, &arg3), 4);
        0x1::vector::push_back<address>(&mut arg0.members, arg3);
        let v1 = MemberAdded{
            allowlist_id    : 0x2::object::id<FileAllowlist>(arg0),
            member          : arg3,
            added_by        : v0,
            is_admin_action : true,
            timestamp       : 0x2::tx_context::epoch(arg4),
        };
        0x2::event::emit<MemberAdded>(v1);
    }

    public entry fun admin_remove_member(arg0: &mut FileAllowlist, arg1: &GlobalAdminCap, arg2: &AdminRegistry, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(arg1.admin_address == v0, 6);
        assert!(0x1::vector::contains<address>(&arg2.admin_addresses, &v0), 6);
        assert!(arg3 != arg0.owner, 2);
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(&arg0.members)) {
            if (*0x1::vector::borrow<address>(&arg0.members, v1) == arg3) {
                0x1::vector::remove<address>(&mut arg0.members, v1);
                break
            };
            v1 = v1 + 1;
        };
        let v2 = MemberRemoved{
            allowlist_id    : 0x2::object::id<FileAllowlist>(arg0),
            member          : arg3,
            removed_by      : v0,
            is_admin_action : true,
            timestamp       : 0x2::tx_context::epoch(arg4),
        };
        0x2::event::emit<MemberRemoved>(v2);
    }

    public entry fun admin_update_file_blob_id(arg0: &mut FileAllowlist, arg1: &GlobalAdminCap, arg2: &AdminRegistry, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(arg1.admin_address == v0, 6);
        assert!(0x1::vector::contains<address>(&arg2.admin_addresses, &v0), 6);
        arg0.file_id = arg3;
        arg0.last_modified = 0x2::tx_context::epoch(arg4);
        arg0.version = arg0.version + 1;
        let v1 = FileUpdated{
            allowlist_id    : 0x2::object::id<FileAllowlist>(arg0),
            old_file_id     : arg0.file_id,
            new_file_id     : arg3,
            updated_by      : v0,
            is_admin_action : true,
            new_version     : arg0.version,
            timestamp       : 0x2::tx_context::epoch(arg4),
        };
        0x2::event::emit<FileUpdated>(v1);
    }

    public entry fun check_access(arg0: &FileAllowlist, arg1: address, arg2: &0x2::tx_context::TxContext) : bool {
        let v0 = 0x1::vector::contains<address>(&arg0.members, &arg1);
        let v1 = AccessChecked{
            allowlist_id   : 0x2::object::id<FileAllowlist>(arg0),
            user           : arg1,
            access_granted : v0,
            timestamp      : 0x2::tx_context::epoch(arg2),
        };
        0x2::event::emit<AccessChecked>(v1);
        v0
    }

    public entry fun create_file_allowlist(arg0: vector<u8>, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = FileAllowlist{
            id            : 0x2::object::new(arg2),
            file_id       : arg0,
            owner         : v0,
            name          : arg1,
            members       : 0x1::vector::empty<address>(),
            created_at    : 0x2::tx_context::epoch(arg2),
            last_modified : 0x2::tx_context::epoch(arg2),
            version       : 0,
        };
        let v2 = 0x2::object::id<FileAllowlist>(&v1);
        let v3 = FileOwnerCap{
            id                : 0x2::object::new(arg2),
            file_allowlist_id : v2,
        };
        0x1::vector::push_back<address>(&mut v1.members, v0);
        0x2::transfer::share_object<FileAllowlist>(v1);
        0x2::transfer::transfer<FileOwnerCap>(v3, v0);
        let v4 = FileAllowlistCreated{
            allowlist_id : v2,
            file_id      : arg0,
            owner        : v0,
            name         : arg1,
            created_by   : v0,
            timestamp    : 0x2::tx_context::epoch(arg2),
        };
        0x2::event::emit<FileAllowlistCreated>(v4);
    }

    public entry fun create_file_allowlist_as_admin(arg0: vector<u8>, arg1: 0x1::string::String, arg2: address, arg3: &GlobalAdminCap, arg4: &AdminRegistry, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(arg3.admin_address == v0, 6);
        assert!(0x1::vector::contains<address>(&arg4.admin_addresses, &v0), 6);
        let v1 = FileAllowlist{
            id            : 0x2::object::new(arg5),
            file_id       : arg0,
            owner         : arg2,
            name          : arg1,
            members       : 0x1::vector::empty<address>(),
            created_at    : 0x2::tx_context::epoch(arg5),
            last_modified : 0x2::tx_context::epoch(arg5),
            version       : 0,
        };
        let v2 = 0x2::object::id<FileAllowlist>(&v1);
        let v3 = FileOwnerCap{
            id                : 0x2::object::new(arg5),
            file_allowlist_id : v2,
        };
        0x1::vector::push_back<address>(&mut v1.members, arg2);
        0x2::transfer::share_object<FileAllowlist>(v1);
        0x2::transfer::transfer<FileOwnerCap>(v3, arg2);
        let v4 = FileAllowlistCreated{
            allowlist_id : v2,
            file_id      : arg0,
            owner        : arg2,
            name         : arg1,
            created_by   : v0,
            timestamp    : 0x2::tx_context::epoch(arg5),
        };
        0x2::event::emit<FileAllowlistCreated>(v4);
    }

    public entry fun create_file_allowlist_as_super_admin(arg0: vector<u8>, arg1: 0x1::string::String, arg2: address, arg3: &SuperAdminCap, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(arg3.super_admin_address == v0, 5);
        let v1 = FileAllowlist{
            id            : 0x2::object::new(arg4),
            file_id       : arg0,
            owner         : arg2,
            name          : arg1,
            members       : 0x1::vector::empty<address>(),
            created_at    : 0x2::tx_context::epoch(arg4),
            last_modified : 0x2::tx_context::epoch(arg4),
            version       : 0,
        };
        let v2 = 0x2::object::id<FileAllowlist>(&v1);
        let v3 = FileOwnerCap{
            id                : 0x2::object::new(arg4),
            file_allowlist_id : v2,
        };
        0x1::vector::push_back<address>(&mut v1.members, arg2);
        0x2::transfer::share_object<FileAllowlist>(v1);
        0x2::transfer::transfer<FileOwnerCap>(v3, arg2);
        let v4 = FileAllowlistCreated{
            allowlist_id : v2,
            file_id      : arg0,
            owner        : arg2,
            name         : arg1,
            created_by   : v0,
            timestamp    : 0x2::tx_context::epoch(arg4),
        };
        0x2::event::emit<FileAllowlistCreated>(v4);
    }

    public entry fun delete_file_allowlist(arg0: FileAllowlist, arg1: FileOwnerCap, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::object::id<FileAllowlist>(&arg0);
        assert!(arg1.file_allowlist_id == v1, 2);
        assert!(arg0.owner == v0, 2);
        let v2 = FileAllowlistDeleted{
            allowlist_id    : v1,
            file_id         : arg0.file_id,
            owner           : arg0.owner,
            deleted_by      : v0,
            is_admin_action : false,
            timestamp       : 0x2::tx_context::epoch(arg2),
        };
        0x2::event::emit<FileAllowlistDeleted>(v2);
        let FileAllowlist {
            id            : v3,
            file_id       : _,
            owner         : _,
            name          : _,
            members       : _,
            created_at    : _,
            last_modified : _,
            version       : _,
        } = arg0;
        let FileOwnerCap {
            id                : v11,
            file_allowlist_id : _,
        } = arg1;
        0x2::object::delete(v3);
        0x2::object::delete(v11);
    }

    public entry fun get_all_admins(arg0: &AdminRegistry) : vector<address> {
        arg0.admin_addresses
    }

    public entry fun get_file_id(arg0: &FileAllowlist) : vector<u8> {
        arg0.file_id
    }

    public entry fun get_file_name(arg0: &FileAllowlist) : 0x1::string::String {
        arg0.name
    }

    public entry fun get_file_owner(arg0: &FileAllowlist) : address {
        arg0.owner
    }

    public entry fun get_member_count(arg0: &FileAllowlist) : u64 {
        0x1::vector::length<address>(&arg0.members)
    }

    public entry fun get_members(arg0: &FileAllowlist) : vector<address> {
        arg0.members
    }

    public entry fun get_modification_info(arg0: &FileAllowlist) : (u64, u64) {
        (arg0.last_modified, arg0.version)
    }

    public entry fun has_blob_id_been_updated(arg0: &FileAllowlist) : bool {
        arg0.version > 0
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = SuperAdminCap{
            id                  : 0x2::object::new(arg0),
            super_admin_address : v0,
        };
        let v2 = AdminRegistry{
            id              : 0x2::object::new(arg0),
            admin_addresses : 0x1::vector::empty<address>(),
        };
        0x2::transfer::transfer<SuperAdminCap>(v1, v0);
        0x2::transfer::share_object<AdminRegistry>(v2);
        let v3 = SystemInitialized{
            super_admin : v0,
            registry_id : 0x2::object::id<AdminRegistry>(&v2),
            timestamp   : 0x2::tx_context::epoch(arg0),
        };
        0x2::event::emit<SystemInitialized>(v3);
    }

    public fun namespace(arg0: &FileAllowlist) : vector<u8> {
        let v0 = 0x2::object::id<FileAllowlist>(arg0);
        0x2::object::id_to_bytes(&v0)
    }

    public entry fun remove_admin(arg0: &mut AdminRegistry, arg1: &SuperAdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(arg1.super_admin_address == v0, 5);
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(&arg0.admin_addresses)) {
            if (*0x1::vector::borrow<address>(&arg0.admin_addresses, v1) == arg2) {
                0x1::vector::remove<address>(&mut arg0.admin_addresses, v1);
                break
            };
            v1 = v1 + 1;
        };
        let v2 = AdminRemoved{
            admin_address : arg2,
            removed_by    : v0,
            timestamp     : 0x2::tx_context::epoch(arg3),
        };
        0x2::event::emit<AdminRemoved>(v2);
    }

    public entry fun remove_member(arg0: &mut FileAllowlist, arg1: &FileOwnerCap, arg2: address, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::object::id<FileAllowlist>(arg0);
        assert!(arg1.file_allowlist_id == v1, 2);
        assert!(arg0.owner == v0, 2);
        assert!(arg2 != arg0.owner, 2);
        let v2 = 0;
        while (v2 < 0x1::vector::length<address>(&arg0.members)) {
            if (*0x1::vector::borrow<address>(&arg0.members, v2) == arg2) {
                0x1::vector::remove<address>(&mut arg0.members, v2);
                break
            };
            v2 = v2 + 1;
        };
        let v3 = MemberRemoved{
            allowlist_id    : v1,
            member          : arg2,
            removed_by      : v0,
            is_admin_action : false,
            timestamp       : 0x2::tx_context::epoch(arg3),
        };
        0x2::event::emit<MemberRemoved>(v3);
    }

    public entry fun seal_approve(arg0: vector<u8>, arg1: &FileAllowlist, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x1::vector::contains<address>(&arg1.members, &v0);
        let v2 = AccessChecked{
            allowlist_id   : 0x2::object::id<FileAllowlist>(arg1),
            user           : v0,
            access_granted : v1,
            timestamp      : 0x2::tx_context::epoch(arg2),
        };
        0x2::event::emit<AccessChecked>(v2);
        assert!(v1, 1);
    }

    public entry fun super_admin_add_member(arg0: &mut FileAllowlist, arg1: &SuperAdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(arg1.super_admin_address == v0, 5);
        assert!(!0x1::vector::contains<address>(&arg0.members, &arg2), 4);
        0x1::vector::push_back<address>(&mut arg0.members, arg2);
        let v1 = MemberAdded{
            allowlist_id    : 0x2::object::id<FileAllowlist>(arg0),
            member          : arg2,
            added_by        : v0,
            is_admin_action : true,
            timestamp       : 0x2::tx_context::epoch(arg3),
        };
        0x2::event::emit<MemberAdded>(v1);
    }

    public entry fun super_admin_remove_member(arg0: &mut FileAllowlist, arg1: &SuperAdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(arg1.super_admin_address == v0, 5);
        assert!(arg2 != arg0.owner, 2);
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(&arg0.members)) {
            if (*0x1::vector::borrow<address>(&arg0.members, v1) == arg2) {
                0x1::vector::remove<address>(&mut arg0.members, v1);
                break
            };
            v1 = v1 + 1;
        };
        let v2 = MemberRemoved{
            allowlist_id    : 0x2::object::id<FileAllowlist>(arg0),
            member          : arg2,
            removed_by      : v0,
            is_admin_action : true,
            timestamp       : 0x2::tx_context::epoch(arg3),
        };
        0x2::event::emit<MemberRemoved>(v2);
    }

    public entry fun super_admin_update_file_blob_id(arg0: &mut FileAllowlist, arg1: &SuperAdminCap, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(arg1.super_admin_address == v0, 5);
        arg0.file_id = arg2;
        arg0.last_modified = 0x2::tx_context::epoch(arg3);
        arg0.version = arg0.version + 1;
        let v1 = FileUpdated{
            allowlist_id    : 0x2::object::id<FileAllowlist>(arg0),
            old_file_id     : arg0.file_id,
            new_file_id     : arg2,
            updated_by      : v0,
            is_admin_action : true,
            new_version     : arg0.version,
            timestamp       : 0x2::tx_context::epoch(arg3),
        };
        0x2::event::emit<FileUpdated>(v1);
    }

    public entry fun transfer_ownership(arg0: &mut FileAllowlist, arg1: FileOwnerCap, arg2: address, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<FileAllowlist>(arg0);
        assert!(arg1.file_allowlist_id == v0, 2);
        assert!(arg0.owner == 0x2::tx_context::sender(arg3), 2);
        assert!(arg2 != arg0.owner, 4);
        if (arg0.owner != arg2) {
            let v1 = 0;
            while (v1 < 0x1::vector::length<address>(&arg0.members)) {
                if (*0x1::vector::borrow<address>(&arg0.members, v1) == arg0.owner) {
                    0x1::vector::remove<address>(&mut arg0.members, v1);
                    break
                };
                v1 = v1 + 1;
            };
        };
        if (!0x1::vector::contains<address>(&arg0.members, &arg2)) {
            0x1::vector::push_back<address>(&mut arg0.members, arg2);
        };
        arg0.owner = arg2;
        0x2::transfer::transfer<FileOwnerCap>(arg1, arg2);
        let v2 = OwnershipTransferred{
            allowlist_id : v0,
            old_owner    : arg0.owner,
            new_owner    : arg2,
            timestamp    : 0x2::tx_context::epoch(arg3),
        };
        0x2::event::emit<OwnershipTransferred>(v2);
    }

    public entry fun transfer_super_admin(arg0: SuperAdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = arg0.super_admin_address;
        assert!(v0 == 0x2::tx_context::sender(arg2), 5);
        assert!(v0 != arg1, 4);
        arg0.super_admin_address = arg1;
        0x2::transfer::transfer<SuperAdminCap>(arg0, arg1);
        let v1 = SuperAdminTransferred{
            old_super_admin : v0,
            new_super_admin : arg1,
            timestamp       : 0x2::tx_context::epoch(arg2),
        };
        0x2::event::emit<SuperAdminTransferred>(v1);
    }

    public entry fun update_file_blob_id(arg0: &mut FileAllowlist, arg1: &FileOwnerCap, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::object::id<FileAllowlist>(arg0);
        assert!(arg1.file_allowlist_id == v1, 2);
        assert!(arg0.owner == v0, 2);
        arg0.file_id = arg2;
        arg0.last_modified = 0x2::tx_context::epoch(arg3);
        arg0.version = arg0.version + 1;
        let v2 = FileUpdated{
            allowlist_id    : v1,
            old_file_id     : arg0.file_id,
            new_file_id     : arg2,
            updated_by      : v0,
            is_admin_action : false,
            new_version     : arg0.version,
            timestamp       : 0x2::tx_context::epoch(arg3),
        };
        0x2::event::emit<FileUpdated>(v2);
    }

    // decompiled from Move bytecode v6
}

