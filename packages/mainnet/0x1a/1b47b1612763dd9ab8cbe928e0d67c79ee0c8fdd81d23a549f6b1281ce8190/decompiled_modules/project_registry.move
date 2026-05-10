module 0x1a1b47b1612763dd9ab8cbe928e0d67c79ee0c8fdd81d23a549f6b1281ce8190::project_registry {
    struct Project has key {
        id: 0x2::object::UID,
        project_id: 0x2::object::ID,
        name: 0x1::string::String,
        owner: address,
        admins: vector<address>,
        forms_count: u64,
        signals_count: u64,
        created_at: u64,
        forms: vector<Form>,
        signals: vector<SignalReceipt>,
    }

    struct ProjectOwnerCap has store, key {
        id: 0x2::object::UID,
        project_id: 0x2::object::ID,
    }

    struct Form has copy, drop, store {
        form_id: u64,
        project_id: 0x2::object::ID,
        title: 0x1::string::String,
        metadata_digest: 0x1::string::String,
        created_at: u64,
        active: bool,
    }

    struct SignalReceipt has copy, drop, store {
        signal_id: u64,
        project_id: 0x2::object::ID,
        form_id: u64,
        walrus_blob_id: 0x1::string::String,
        metadata_digest: 0x1::string::String,
        encrypted: bool,
        seal_identity: 0x1::option::Option<0x1::string::String>,
        created_at: u64,
        submitter: 0x1::option::Option<address>,
        status: u8,
    }

    struct ProjectCreated has copy, drop {
        project_id: 0x2::object::ID,
        owner: address,
        name: 0x1::string::String,
        created_at: u64,
    }

    struct AdminAdded has copy, drop {
        project_id: 0x2::object::ID,
        admin: address,
        actor: address,
    }

    struct AdminRemoved has copy, drop {
        project_id: 0x2::object::ID,
        admin: address,
        actor: address,
    }

    struct FormCreated has copy, drop {
        project_id: 0x2::object::ID,
        form_id: u64,
        title: 0x1::string::String,
        metadata_digest: 0x1::string::String,
        actor: address,
        created_at: u64,
    }

    struct FormStatusChanged has copy, drop {
        project_id: 0x2::object::ID,
        form_id: u64,
        active: bool,
        actor: address,
    }

    struct SignalRegistered has copy, drop {
        project_id: 0x2::object::ID,
        form_id: u64,
        signal_id: u64,
        walrus_blob_id: 0x1::string::String,
        metadata_digest: 0x1::string::String,
        encrypted: bool,
        actor: address,
        created_at: u64,
    }

    struct SignalStatusUpdated has copy, drop {
        project_id: 0x2::object::ID,
        signal_id: u64,
        status: u8,
        actor: address,
    }

    public fun add_admin(arg0: &mut Project, arg1: &ProjectOwnerCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert_project_owner(arg0, arg1, v0);
        assert!(!contains_admin(&arg0.admins, arg2), 4);
        0x1::vector::push_back<address>(&mut arg0.admins, arg2);
        let v1 = AdminAdded{
            project_id : arg0.project_id,
            admin      : arg2,
            actor      : v0,
        };
        0x2::event::emit<AdminAdded>(v1);
    }

    fun assert_global_admin(arg0: &0x1a1b47b1612763dd9ab8cbe928e0d67c79ee0c8fdd81d23a549f6b1281ce8190::access_control::Registry, arg1: &0x1a1b47b1612763dd9ab8cbe928e0d67c79ee0c8fdd81d23a549f6b1281ce8190::access_control::AdminCap, arg2: address) {
        assert!(0x1a1b47b1612763dd9ab8cbe928e0d67c79ee0c8fdd81d23a549f6b1281ce8190::access_control::is_admin(arg0, arg2, 0x2::object::id<0x1a1b47b1612763dd9ab8cbe928e0d67c79ee0c8fdd81d23a549f6b1281ce8190::access_control::AdminCap>(arg1)), 1);
    }

    fun assert_global_owner(arg0: &0x1a1b47b1612763dd9ab8cbe928e0d67c79ee0c8fdd81d23a549f6b1281ce8190::access_control::Registry, arg1: &0x1a1b47b1612763dd9ab8cbe928e0d67c79ee0c8fdd81d23a549f6b1281ce8190::access_control::OwnerCap, arg2: address) {
        assert!(0x1a1b47b1612763dd9ab8cbe928e0d67c79ee0c8fdd81d23a549f6b1281ce8190::access_control::is_owner(arg0, arg2, 0x2::object::id<0x1a1b47b1612763dd9ab8cbe928e0d67c79ee0c8fdd81d23a549f6b1281ce8190::access_control::OwnerCap>(arg1)), 1);
    }

    fun assert_project_admin(arg0: &Project, arg1: address) {
        assert!(is_project_admin_address(arg0, arg1), 3);
    }

    fun assert_project_owner(arg0: &Project, arg1: &ProjectOwnerCap, arg2: address) {
        assert!(arg1.project_id == arg0.project_id, 2);
        assert!(arg0.owner == arg2, 3);
    }

    fun contains_admin(arg0: &vector<address>, arg1: address) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(arg0)) {
            if (*0x1::vector::borrow<address>(arg0, v0) == arg1) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    public fun create_form(arg0: &mut Project, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert_project_admin(arg0, v0);
        let v1 = arg0.forms_count;
        let v2 = 0x2::tx_context::epoch_timestamp_ms(arg3);
        let v3 = Form{
            form_id         : v1,
            project_id      : arg0.project_id,
            title           : arg1,
            metadata_digest : arg2,
            created_at      : v2,
            active          : true,
        };
        0x1::vector::push_back<Form>(&mut arg0.forms, v3);
        arg0.forms_count = arg0.forms_count + 1;
        let v4 = FormCreated{
            project_id      : arg0.project_id,
            form_id         : v1,
            title           : v3.title,
            metadata_digest : v3.metadata_digest,
            actor           : v0,
            created_at      : v2,
        };
        0x2::event::emit<FormCreated>(v4);
    }

    public fun create_project(arg0: &0x1a1b47b1612763dd9ab8cbe928e0d67c79ee0c8fdd81d23a549f6b1281ce8190::access_control::AdminCap, arg1: &0x1a1b47b1612763dd9ab8cbe928e0d67c79ee0c8fdd81d23a549f6b1281ce8190::access_control::Registry, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert_global_admin(arg1, arg0, v0);
        let v1 = 0x2::tx_context::epoch_timestamp_ms(arg3);
        let (v2, v3) = create_project_internal(arg2, v0, v1, arg3);
        let v4 = v2;
        let v5 = ProjectCreated{
            project_id : v4.project_id,
            owner      : v0,
            name       : v4.name,
            created_at : v1,
        };
        0x2::event::emit<ProjectCreated>(v5);
        0x2::transfer::share_object<Project>(v4);
        0x2::transfer::public_transfer<ProjectOwnerCap>(v3, v0);
    }

    public fun create_project_by_owner(arg0: &0x1a1b47b1612763dd9ab8cbe928e0d67c79ee0c8fdd81d23a549f6b1281ce8190::access_control::OwnerCap, arg1: &0x1a1b47b1612763dd9ab8cbe928e0d67c79ee0c8fdd81d23a549f6b1281ce8190::access_control::Registry, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert_global_owner(arg1, arg0, v0);
        let v1 = 0x2::tx_context::epoch_timestamp_ms(arg3);
        let (v2, v3) = create_project_internal(arg2, v0, v1, arg3);
        let v4 = v2;
        let v5 = ProjectCreated{
            project_id : v4.project_id,
            owner      : v0,
            name       : v4.name,
            created_at : v1,
        };
        0x2::event::emit<ProjectCreated>(v5);
        0x2::transfer::share_object<Project>(v4);
        0x2::transfer::public_transfer<ProjectOwnerCap>(v3, v0);
    }

    fun create_project_internal(arg0: 0x1::string::String, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (Project, ProjectOwnerCap) {
        let v0 = 0x2::object::new(arg3);
        let v1 = 0x2::object::uid_to_inner(&v0);
        let v2 = Project{
            id            : v0,
            project_id    : v1,
            name          : arg0,
            owner         : arg1,
            admins        : vector[],
            forms_count   : 0,
            signals_count : 0,
            created_at    : arg2,
            forms         : 0x1::vector::empty<Form>(),
            signals       : 0x1::vector::empty<SignalReceipt>(),
        };
        let v3 = ProjectOwnerCap{
            id         : 0x2::object::new(arg3),
            project_id : v1,
        };
        (v2, v3)
    }

    fun find_form_index(arg0: &vector<Form>, arg1: u64) : u64 {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Form>(arg0)) {
            if (0x1::vector::borrow<Form>(arg0, v0).form_id == arg1) {
                return v0
            };
            v0 = v0 + 1;
        };
        abort 6
    }

    fun find_signal_index(arg0: &vector<SignalReceipt>, arg1: u64) : u64 {
        let v0 = 0;
        while (v0 < 0x1::vector::length<SignalReceipt>(arg0)) {
            if (0x1::vector::borrow<SignalReceipt>(arg0, v0).signal_id == arg1) {
                return v0
            };
            v0 = v0 + 1;
        };
        abort 8
    }

    public fun form_is_active(arg0: &Project, arg1: u64) : bool {
        0x1::vector::borrow<Form>(&arg0.forms, find_form_index(&arg0.forms, arg1)).active
    }

    public fun is_project_admin(arg0: &Project, arg1: address) : bool {
        is_project_admin_address(arg0, arg1)
    }

    fun is_project_admin_address(arg0: &Project, arg1: address) : bool {
        if (arg0.owner == arg1) {
            return true
        };
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg0.admins)) {
            if (*0x1::vector::borrow<address>(&arg0.admins, v0) == arg1) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    public fun project_id(arg0: &ProjectOwnerCap) : 0x2::object::ID {
        arg0.project_id
    }

    public fun project_stats(arg0: &Project) : (u64, u64, u64) {
        (0x1::vector::length<address>(&arg0.admins), arg0.forms_count, arg0.signals_count)
    }

    public fun register_signal(arg0: &mut Project, arg1: u64, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: bool, arg5: 0x1::option::Option<0x1::string::String>, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::borrow<Form>(&arg0.forms, find_form_index(&arg0.forms, arg1)).active, 7);
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = arg0.signals_count;
        let v2 = 0x2::tx_context::epoch_timestamp_ms(arg6);
        let v3 = SignalReceipt{
            signal_id       : v1,
            project_id      : arg0.project_id,
            form_id         : arg1,
            walrus_blob_id  : arg2,
            metadata_digest : arg3,
            encrypted       : arg4,
            seal_identity   : arg5,
            created_at      : v2,
            submitter       : 0x1::option::some<address>(v0),
            status          : 0,
        };
        0x1::vector::push_back<SignalReceipt>(&mut arg0.signals, v3);
        arg0.signals_count = arg0.signals_count + 1;
        let v4 = SignalRegistered{
            project_id      : arg0.project_id,
            form_id         : arg1,
            signal_id       : v1,
            walrus_blob_id  : v3.walrus_blob_id,
            metadata_digest : v3.metadata_digest,
            encrypted       : arg4,
            actor           : v0,
            created_at      : v2,
        };
        0x2::event::emit<SignalRegistered>(v4);
    }

    public fun remove_admin(arg0: &mut Project, arg1: &ProjectOwnerCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert_project_owner(arg0, arg1, v0);
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(&arg0.admins)) {
            if (*0x1::vector::borrow<address>(&arg0.admins, v1) == arg2) {
                0x1::vector::swap_remove<address>(&mut arg0.admins, v1);
                let v2 = AdminRemoved{
                    project_id : arg0.project_id,
                    admin      : arg2,
                    actor      : v0,
                };
                0x2::event::emit<AdminRemoved>(v2);
                return
            };
            v1 = v1 + 1;
        };
        abort 5
    }

    public fun set_form_active(arg0: &mut Project, arg1: u64, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert_project_admin(arg0, v0);
        0x1::vector::borrow_mut<Form>(&mut arg0.forms, find_form_index(&arg0.forms, arg1)).active = arg2;
        let v1 = FormStatusChanged{
            project_id : arg0.project_id,
            form_id    : arg1,
            active     : arg2,
            actor      : v0,
        };
        0x2::event::emit<FormStatusChanged>(v1);
    }

    public fun signal_status_archived() : u8 {
        2
    }

    public fun signal_status_new() : u8 {
        0
    }

    public fun signal_status_triaged() : u8 {
        1
    }

    public fun update_signal_status(arg0: &mut Project, arg1: u64, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert_project_admin(arg0, v0);
        0x1::vector::borrow_mut<SignalReceipt>(&mut arg0.signals, find_signal_index(&arg0.signals, arg1)).status = arg2;
        let v1 = SignalStatusUpdated{
            project_id : arg0.project_id,
            signal_id  : arg1,
            status     : arg2,
            actor      : v0,
        };
        0x2::event::emit<SignalStatusUpdated>(v1);
    }

    // decompiled from Move bytecode v7
}

