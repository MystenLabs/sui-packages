module 0x991454976a4ef8535ed3572bb1c500dcd565855d49a51f1fadc7f70a316c9631::spreadsheet {
    struct CellLock has copy, drop, store {
        editor: address,
        version_id: address,
        locked_at: u64,
        expires_at: u64,
    }

    struct Permission has copy, drop, store {
        level: u8,
        granted_at: u64,
    }

    struct SpreadsheetRegistry has key {
        id: 0x2::object::UID,
        spreadsheets: 0x2::table::Table<address, bool>,
        spreadsheet_list: vector<address>,
        total_count: u64,
    }

    struct Spreadsheet has key {
        id: 0x2::object::UID,
        title: 0x1::string::String,
        owner: address,
        created_at: u64,
        last_modified: u64,
        version_count: u64,
        current_version: address,
        version_history: vector<address>,
        is_public: bool,
        cell_locks: 0x2::table::Table<0x1::string::String, CellLock>,
        collaborators: 0x2::table::Table<address, Permission>,
        active_editors: 0x2::table::Table<address, u64>,
    }

    struct Version has store, key {
        id: 0x2::object::UID,
        spreadsheet_id: address,
        version_number: u64,
        parent_version: 0x1::option::Option<address>,
        walrus_blob_id: 0x1::string::String,
        content_hash: 0x1::string::String,
        cell_count: u64,
        created_at: u64,
        created_by: address,
        description: 0x1::string::String,
    }

    struct SpreadsheetCreated has copy, drop {
        spreadsheet_id: address,
        owner: address,
        title: 0x1::string::String,
        timestamp: u64,
    }

    struct VersionSaved has copy, drop {
        spreadsheet_id: address,
        version_id: address,
        version_number: u64,
        parent_version: 0x1::option::Option<address>,
        walrus_blob_id: 0x1::string::String,
        content_hash: 0x1::string::String,
        cell_count: u64,
        timestamp: u64,
    }

    struct CellLocked has copy, drop {
        spreadsheet_id: address,
        version_id: address,
        cell_ref: 0x1::string::String,
        editor: address,
        timestamp: u64,
        expires_at: u64,
    }

    struct CellUnlocked has copy, drop {
        spreadsheet_id: address,
        cell_ref: 0x1::string::String,
        editor: address,
        timestamp: u64,
    }

    struct CollaboratorAdded has copy, drop {
        spreadsheet_id: address,
        collaborator: address,
        permission_level: u8,
        timestamp: u64,
    }

    struct SpreadsheetDeleted has copy, drop {
        spreadsheet_id: address,
        owner: address,
        title: 0x1::string::String,
        version_count: u64,
        timestamp: u64,
    }

    public fun add_collaborator(arg0: &mut Spreadsheet, arg1: address, arg2: u8, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg3);
        assert!(has_permission(arg0, 0x2::tx_context::sender(arg4), 2), 0);
        assert!(validate_address(arg1), 6);
        assert!(arg2 <= 2, 4);
        let v1 = Permission{
            level      : arg2,
            granted_at : v0,
        };
        if (0x2::table::contains<address, Permission>(&arg0.collaborators, arg1)) {
            *0x2::table::borrow_mut<address, Permission>(&mut arg0.collaborators, arg1) = v1;
        } else {
            0x2::table::add<address, Permission>(&mut arg0.collaborators, arg1, v1);
        };
        let v2 = CollaboratorAdded{
            spreadsheet_id   : 0x2::object::uid_to_address(&arg0.id),
            collaborator     : arg1,
            permission_level : arg2,
            timestamp        : v0,
        };
        0x2::event::emit<CollaboratorAdded>(v2);
    }

    fun cleanup_expired_locks(arg0: &mut Spreadsheet, arg1: u64) {
    }

    public fun create_spreadsheet(arg0: &mut SpreadsheetRegistry, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) : address {
        assert!(validate_string(&arg1, 100), 7);
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::tx_context::epoch_timestamp_ms(arg2);
        let v2 = Spreadsheet{
            id              : 0x2::object::new(arg2),
            title           : arg1,
            owner           : v0,
            created_at      : v1,
            last_modified   : v1,
            version_count   : 0,
            current_version : @0x0,
            version_history : 0x1::vector::empty<address>(),
            is_public       : false,
            cell_locks      : 0x2::table::new<0x1::string::String, CellLock>(arg2),
            collaborators   : 0x2::table::new<address, Permission>(arg2),
            active_editors  : 0x2::table::new<address, u64>(arg2),
        };
        let v3 = 0x2::object::uid_to_address(&v2.id);
        0x2::table::add<address, bool>(&mut arg0.spreadsheets, v3, true);
        0x1::vector::push_back<address>(&mut arg0.spreadsheet_list, v3);
        arg0.total_count = arg0.total_count + 1;
        let v4 = SpreadsheetCreated{
            spreadsheet_id : v3,
            owner          : v0,
            title          : arg1,
            timestamp      : v1,
        };
        0x2::event::emit<SpreadsheetCreated>(v4);
        0x2::transfer::share_object<Spreadsheet>(v2);
        v3
    }

    public entry fun delete_spreadsheet(arg0: &mut SpreadsheetRegistry, arg1: Spreadsheet, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg1.owner, 0);
        let v0 = 0x2::object::uid_to_address(&arg1.id);
        assert!(0x1::vector::length<address>(&arg1.version_history) == 0, 4);
        if (0x2::table::contains<address, bool>(&arg0.spreadsheets, v0)) {
            0x2::table::remove<address, bool>(&mut arg0.spreadsheets, v0);
            arg0.total_count = arg0.total_count - 1;
            let v1 = 0;
            while (v1 < 0x1::vector::length<address>(&arg0.spreadsheet_list)) {
                if (*0x1::vector::borrow<address>(&arg0.spreadsheet_list, v1) == v0) {
                    0x1::vector::remove<address>(&mut arg0.spreadsheet_list, v1);
                    break
                };
                v1 = v1 + 1;
            };
        };
        let v2 = SpreadsheetDeleted{
            spreadsheet_id : v0,
            owner          : arg1.owner,
            title          : arg1.title,
            version_count  : arg1.version_count,
            timestamp      : 0x2::tx_context::epoch_timestamp_ms(arg2),
        };
        0x2::event::emit<SpreadsheetDeleted>(v2);
        let Spreadsheet {
            id              : v3,
            title           : _,
            owner           : _,
            created_at      : _,
            last_modified   : _,
            version_count   : _,
            current_version : _,
            version_history : _,
            is_public       : _,
            cell_locks      : v12,
            collaborators   : v13,
            active_editors  : v14,
        } = arg1;
        0x2::table::destroy_empty<0x1::string::String, CellLock>(v12);
        0x2::table::destroy_empty<address, Permission>(v13);
        0x2::table::destroy_empty<address, u64>(v14);
        0x2::object::delete(v3);
    }

    public entry fun delete_spreadsheet_with_versions(arg0: &mut SpreadsheetRegistry, arg1: Spreadsheet, arg2: vector<Version>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg1.owner, 0);
        let v0 = 0x2::object::uid_to_address(&arg1.id);
        let v1 = &arg1.version_history;
        let v2 = 0x1::vector::length<Version>(&arg2);
        assert!(v2 <= 50, 4);
        assert!(v2 == 0x1::vector::length<address>(v1), 11);
        let v3 = 0;
        while (v3 < v2) {
            let v4 = 0x1::vector::borrow<Version>(&arg2, v3);
            assert!(0x2::object::uid_to_address(&v4.id) == *0x1::vector::borrow<address>(v1, v3), 11);
            assert!(v4.spreadsheet_id == v0, 11);
            v3 = v3 + 1;
        };
        if (0x2::table::contains<address, bool>(&arg0.spreadsheets, v0)) {
            0x2::table::remove<address, bool>(&mut arg0.spreadsheets, v0);
            arg0.total_count = arg0.total_count - 1;
            let v5 = 0;
            while (v5 < 0x1::vector::length<address>(&arg0.spreadsheet_list)) {
                if (*0x1::vector::borrow<address>(&arg0.spreadsheet_list, v5) == v0) {
                    0x1::vector::remove<address>(&mut arg0.spreadsheet_list, v5);
                    break
                };
                v5 = v5 + 1;
            };
        };
        while (!0x1::vector::is_empty<Version>(&arg2)) {
            let Version {
                id             : v6,
                spreadsheet_id : _,
                version_number : _,
                parent_version : _,
                walrus_blob_id : _,
                content_hash   : _,
                cell_count     : _,
                created_at     : _,
                created_by     : _,
                description    : _,
            } = 0x1::vector::pop_back<Version>(&mut arg2);
            0x2::object::delete(v6);
        };
        0x1::vector::destroy_empty<Version>(arg2);
        let v16 = SpreadsheetDeleted{
            spreadsheet_id : v0,
            owner          : arg1.owner,
            title          : arg1.title,
            version_count  : arg1.version_count,
            timestamp      : 0x2::tx_context::epoch_timestamp_ms(arg3),
        };
        0x2::event::emit<SpreadsheetDeleted>(v16);
        let Spreadsheet {
            id              : v17,
            title           : _,
            owner           : _,
            created_at      : _,
            last_modified   : _,
            version_count   : _,
            current_version : _,
            version_history : _,
            is_public       : _,
            cell_locks      : v26,
            collaborators   : v27,
            active_editors  : v28,
        } = arg1;
        0x2::table::destroy_empty<0x1::string::String, CellLock>(v26);
        0x2::table::destroy_empty<address, Permission>(v27);
        0x2::table::destroy_empty<address, u64>(v28);
        0x2::object::delete(v17);
    }

    public fun force_unlock_all_cells(arg0: &mut Spreadsheet, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 0);
    }

    public fun get_active_editors(arg0: &Spreadsheet) : vector<address> {
        0x1::vector::empty<address>()
    }

    public fun get_locked_cells(arg0: &Spreadsheet, arg1: &0x2::clock::Clock) : vector<0x1::string::String> {
        0x1::vector::empty<0x1::string::String>()
    }

    public fun get_spreadsheet_info(arg0: &Spreadsheet) : (0x1::string::String, address, u64, u64, u64, address, bool) {
        (arg0.title, arg0.owner, arg0.created_at, arg0.last_modified, arg0.version_count, arg0.current_version, arg0.is_public)
    }

    public fun get_spreadsheet_stats(arg0: &Spreadsheet) : (u64, u64, u64) {
        (0x2::table::length<0x1::string::String, CellLock>(&arg0.cell_locks), 0x2::table::length<address, Permission>(&arg0.collaborators), 0x2::table::length<address, u64>(&arg0.active_editors))
    }

    public fun get_version_chain(arg0: &Spreadsheet, arg1: u64) : vector<address> {
        let v0 = 0x1::vector::empty<address>();
        let v1 = 0x1::vector::length<address>(&arg0.version_history);
        let v2 = if (v1 > arg1) {
            v1 - arg1
        } else {
            0
        };
        let v3 = v2;
        while (v3 < v1) {
            0x1::vector::push_back<address>(&mut v0, *0x1::vector::borrow<address>(&arg0.version_history, v3));
            v3 = v3 + 1;
        };
        v0
    }

    public fun get_version_info(arg0: &Version) : (address, u64, 0x1::string::String, 0x1::string::String, u64, u64, address, 0x1::string::String, 0x1::option::Option<address>) {
        (arg0.spreadsheet_id, arg0.version_number, arg0.walrus_blob_id, arg0.content_hash, arg0.cell_count, arg0.created_at, arg0.created_by, arg0.description, arg0.parent_version)
    }

    fun has_permission(arg0: &Spreadsheet, arg1: address, arg2: u8) : bool {
        if (arg1 == arg0.owner) {
            return true
        };
        if (arg2 == 0 && arg0.is_public) {
            return true
        };
        0x2::table::contains<address, Permission>(&arg0.collaborators, arg1) && 0x2::table::borrow<address, Permission>(&arg0.collaborators, arg1).level >= arg2
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = SpreadsheetRegistry{
            id               : 0x2::object::new(arg0),
            spreadsheets     : 0x2::table::new<address, bool>(arg0),
            spreadsheet_list : 0x1::vector::empty<address>(),
            total_count      : 0,
        };
        0x2::transfer::share_object<SpreadsheetRegistry>(v0);
    }

    public fun list_spreadsheets(arg0: &SpreadsheetRegistry, arg1: u64, arg2: u64) : (vector<address>, u64) {
        let v0 = if (arg2 > 100) {
            100
        } else {
            arg2
        };
        let v1 = 0x1::vector::empty<address>();
        let v2 = 0x1::vector::length<address>(&arg0.spreadsheet_list);
        let v3 = 0;
        while (arg1 < v2 && v3 < v0) {
            0x1::vector::push_back<address>(&mut v1, *0x1::vector::borrow<address>(&arg0.spreadsheet_list, arg1));
            arg1 = arg1 + 1;
            v3 = v3 + 1;
        };
        (v1, v2)
    }

    public fun lock_cell(arg0: &mut Spreadsheet, arg1: 0x1::string::String, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : bool {
        assert!(validate_cell_ref(&arg1), 8);
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        assert!(has_permission(arg0, v0, 1), 5);
        cleanup_expired_locks(arg0, v1);
        if (0x2::table::contains<0x1::string::String, CellLock>(&arg0.cell_locks, arg1)) {
            if (0x2::table::borrow<0x1::string::String, CellLock>(&arg0.cell_locks, arg1).expires_at > v1) {
                return false
            };
            0x2::table::remove<0x1::string::String, CellLock>(&mut arg0.cell_locks, arg1);
        };
        let v2 = CellLock{
            editor     : v0,
            version_id : arg0.current_version,
            locked_at  : v1,
            expires_at : v1 + 300000,
        };
        0x2::table::add<0x1::string::String, CellLock>(&mut arg0.cell_locks, arg1, v2);
        if (!0x2::table::contains<address, u64>(&arg0.active_editors, v0)) {
            0x2::table::add<address, u64>(&mut arg0.active_editors, v0, v1);
        } else {
            *0x2::table::borrow_mut<address, u64>(&mut arg0.active_editors, v0) = v1;
        };
        let v3 = CellLocked{
            spreadsheet_id : 0x2::object::uid_to_address(&arg0.id),
            version_id     : arg0.current_version,
            cell_ref       : arg1,
            editor         : v0,
            timestamp      : v1,
            expires_at     : v1 + 300000,
        };
        0x2::event::emit<CellLocked>(v3);
        true
    }

    public fun make_private(arg0: &mut Spreadsheet, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 0);
        arg0.is_public = false;
        arg0.last_modified = 0x2::tx_context::epoch_timestamp_ms(arg1);
    }

    public fun make_public(arg0: &mut Spreadsheet, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 0);
        arg0.is_public = true;
        arg0.last_modified = 0x2::tx_context::epoch_timestamp_ms(arg1);
    }

    public fun prune_old_versions(arg0: &mut Spreadsheet, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 0);
        let v0 = 0x1::vector::length<address>(&arg0.version_history);
        if (v0 <= arg1) {
            return
        };
        let v1 = 0;
        while (v1 < v0 - arg1) {
            0x1::vector::remove<address>(&mut arg0.version_history, 0);
            v1 = v1 + 1;
        };
    }

    public fun remove_collaborator(arg0: &mut Spreadsheet, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(has_permission(arg0, 0x2::tx_context::sender(arg2), 2), 0);
        if (0x2::table::contains<address, Permission>(&arg0.collaborators, arg1)) {
            0x2::table::remove<address, Permission>(&mut arg0.collaborators, arg1);
        };
        if (0x2::table::contains<address, u64>(&arg0.active_editors, arg1)) {
            0x2::table::remove<address, u64>(&mut arg0.active_editors, arg1);
        };
    }

    public fun remove_spreadsheet(arg0: &mut SpreadsheetRegistry, arg1: &Spreadsheet, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg1.owner, 0);
        let v0 = 0x2::object::uid_to_address(&arg1.id);
        if (0x2::table::contains<address, bool>(&arg0.spreadsheets, v0)) {
            0x2::table::remove<address, bool>(&mut arg0.spreadsheets, v0);
            arg0.total_count = arg0.total_count - 1;
            let v1 = 0;
            while (v1 < 0x1::vector::length<address>(&arg0.spreadsheet_list)) {
                if (*0x1::vector::borrow<address>(&arg0.spreadsheet_list, v1) == v0) {
                    0x1::vector::remove<address>(&mut arg0.spreadsheet_list, v1);
                    break
                };
                v1 = v1 + 1;
            };
        };
    }

    public fun rollback_to_version(arg0: &mut Spreadsheet, arg1: address, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(has_permission(arg0, 0x2::tx_context::sender(arg3), 2), 0);
        let v0 = false;
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(&arg0.version_history)) {
            if (*0x1::vector::borrow<address>(&arg0.version_history, v1) == arg1) {
                v0 = true;
                break
            };
            v1 = v1 + 1;
        };
        assert!(v0, 9);
        arg0.current_version = arg1;
        arg0.last_modified = 0x2::clock::timestamp_ms(arg2);
    }

    public fun save_version(arg0: &mut Spreadsheet, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: u64, arg4: 0x1::string::String, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : address {
        assert!(validate_string(&arg1, 100), 4);
        assert!(validate_string(&arg2, 100), 4);
        assert!(validate_string(&arg4, 500), 4);
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x2::clock::timestamp_ms(arg5);
        assert!(has_permission(arg0, v0, 1), 5);
        arg0.version_count = arg0.version_count + 1;
        arg0.last_modified = v1;
        let v2 = if (arg0.current_version != @0x0) {
            0x1::option::some<address>(arg0.current_version)
        } else {
            0x1::option::none<address>()
        };
        let v3 = Version{
            id             : 0x2::object::new(arg6),
            spreadsheet_id : 0x2::object::uid_to_address(&arg0.id),
            version_number : arg0.version_count,
            parent_version : v2,
            walrus_blob_id : arg1,
            content_hash   : arg2,
            cell_count     : arg3,
            created_at     : v1,
            created_by     : v0,
            description    : arg4,
        };
        let v4 = 0x2::object::uid_to_address(&v3.id);
        arg0.current_version = v4;
        0x1::vector::push_back<address>(&mut arg0.version_history, v4);
        let v5 = VersionSaved{
            spreadsheet_id : 0x2::object::uid_to_address(&arg0.id),
            version_id     : v4,
            version_number : arg0.version_count,
            parent_version : v2,
            walrus_blob_id : arg1,
            content_hash   : arg2,
            cell_count     : arg3,
            timestamp      : v1,
        };
        0x2::event::emit<VersionSaved>(v5);
        0x2::transfer::share_object<Version>(v3);
        v4
    }

    public fun transfer_ownership(arg0: &mut Spreadsheet, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 0);
        assert!(validate_address(arg1), 6);
        arg0.owner = arg1;
        arg0.last_modified = 0x2::tx_context::epoch_timestamp_ms(arg2);
    }

    public fun unlock_cell(arg0: &mut Spreadsheet, arg1: 0x1::string::String, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x2::table::contains<0x1::string::String, CellLock>(&arg0.cell_locks, arg1), 3);
        assert!(v0 == 0x2::table::borrow<0x1::string::String, CellLock>(&arg0.cell_locks, arg1).editor || v0 == arg0.owner, 1);
        0x2::table::remove<0x1::string::String, CellLock>(&mut arg0.cell_locks, arg1);
        let v1 = CellUnlocked{
            spreadsheet_id : 0x2::object::uid_to_address(&arg0.id),
            cell_ref       : arg1,
            editor         : v0,
            timestamp      : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<CellUnlocked>(v1);
    }

    public fun update_title(arg0: &mut Spreadsheet, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 0);
        assert!(validate_string(&arg1, 100), 7);
        arg0.title = arg1;
        arg0.last_modified = 0x2::tx_context::epoch_timestamp_ms(arg2);
    }

    fun validate_address(arg0: address) : bool {
        arg0 != @0x0
    }

    fun validate_cell_ref(arg0: &0x1::string::String) : bool {
        let v0 = 0x1::string::as_bytes(arg0);
        let v1 = 0x1::vector::length<u8>(v0);
        if (v1 < 2) {
            return false
        };
        let v2 = 0;
        let v3 = false;
        let v4 = false;
        while (v2 < v1) {
            let v5 = *0x1::vector::borrow<u8>(v0, v2);
            if (v5 >= 65 && v5 <= 90) {
                v3 = true;
                v2 = v2 + 1;
            } else {
                break
            };
        };
        while (v2 < v1) {
            let v6 = *0x1::vector::borrow<u8>(v0, v2);
            if (v6 >= 48 && v6 <= 57) {
                v4 = true;
                v2 = v2 + 1;
                continue
            };
            return false
        };
        v3 && v4
    }

    fun validate_string(arg0: &0x1::string::String, arg1: u64) : bool {
        let v0 = 0x1::string::length(arg0);
        v0 > 0 && v0 <= arg1
    }

    // decompiled from Move bytecode v6
}

