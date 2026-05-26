module 0x829f06d3746829abf21cd5fa64a6879ffb702b54074e19c5d79df2e8279d4d07::project_registry {
    struct Member has copy, drop, store {
        addr: address,
        role: u8,
    }

    struct Project has key {
        id: 0x2::object::UID,
        project_id: 0x2::object::ID,
        name: 0x1::string::String,
        owner: address,
        admins: vector<address>,
        members: vector<Member>,
        forms_count: u64,
        signals_count: u64,
        next_form_id: u64,
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

    struct ProjectMemberAdded has copy, drop {
        project_id: 0x2::object::ID,
        member: address,
        role: u8,
        actor: address,
    }

    struct ProjectMemberRemoved has copy, drop {
        project_id: 0x2::object::ID,
        member: address,
        role: u8,
        actor: address,
    }

    struct ProjectMemberRoleUpdated has copy, drop {
        project_id: 0x2::object::ID,
        member: address,
        previous_role: u8,
        role: u8,
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

    struct FormDeleted has copy, drop {
        project_id: 0x2::object::ID,
        form_id: u64,
        title: 0x1::string::String,
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

    struct ProjectDeleted has copy, drop {
        project_id: 0x2::object::ID,
        actor: address,
        forms_count: u64,
        signals_count: u64,
    }

    public fun is_owner(arg0: &Project, arg1: address) : bool {
        arg0.owner == arg1
    }

    public fun is_reviewer(arg0: &Project, arg1: address) : bool {
        member_has_role(arg0, arg1, 2)
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

    public fun add_project_member(arg0: &mut Project, arg1: &ProjectOwnerCap, arg2: address, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert_project_owner(arg0, arg1, v0);
        assert!(is_valid_role(arg3) && arg3 != 0, 13);
        assert!(arg2 != arg0.owner, 14);
        assert!(!contains_admin(&arg0.admins, arg2), 11);
        let v1 = find_member_index(&arg0.members, arg2);
        assert!(0x1::option::is_none<u64>(&v1), 11);
        let v2 = Member{
            addr : arg2,
            role : arg3,
        };
        0x1::vector::push_back<Member>(&mut arg0.members, v2);
        let v3 = ProjectMemberAdded{
            project_id : arg0.project_id,
            member     : arg2,
            role       : arg3,
            actor      : v0,
        };
        0x2::event::emit<ProjectMemberAdded>(v3);
    }

    fun assert_can_review(arg0: &Project, arg1: address) {
        assert!(can_review(arg0, arg1), 10);
    }

    fun assert_global_admin(arg0: &0x829f06d3746829abf21cd5fa64a6879ffb702b54074e19c5d79df2e8279d4d07::access_control::Registry, arg1: &0x829f06d3746829abf21cd5fa64a6879ffb702b54074e19c5d79df2e8279d4d07::access_control::AdminCap, arg2: address) {
        assert!(0x829f06d3746829abf21cd5fa64a6879ffb702b54074e19c5d79df2e8279d4d07::access_control::is_admin(arg0, arg2, 0x2::object::id<0x829f06d3746829abf21cd5fa64a6879ffb702b54074e19c5d79df2e8279d4d07::access_control::AdminCap>(arg1)), 1);
    }

    fun assert_global_owner(arg0: &0x829f06d3746829abf21cd5fa64a6879ffb702b54074e19c5d79df2e8279d4d07::access_control::Registry, arg1: &0x829f06d3746829abf21cd5fa64a6879ffb702b54074e19c5d79df2e8279d4d07::access_control::OwnerCap, arg2: address) {
        assert!(0x829f06d3746829abf21cd5fa64a6879ffb702b54074e19c5d79df2e8279d4d07::access_control::is_owner(arg0, arg2, 0x2::object::id<0x829f06d3746829abf21cd5fa64a6879ffb702b54074e19c5d79df2e8279d4d07::access_control::OwnerCap>(arg1)), 1);
    }

    fun assert_project_admin(arg0: &Project, arg1: address) {
        assert!(can_manage(arg0, arg1), 10);
    }

    fun assert_project_owner(arg0: &Project, arg1: &ProjectOwnerCap, arg2: address) {
        assert!(arg1.project_id == arg0.project_id, 2);
        assert!(arg0.owner == arg2, 3);
    }

    fun assert_project_reviewer(arg0: &0x829f06d3746829abf21cd5fa64a6879ffb702b54074e19c5d79df2e8279d4d07::access_control::Registry, arg1: &0x829f06d3746829abf21cd5fa64a6879ffb702b54074e19c5d79df2e8279d4d07::access_control::ReviewerCap, arg2: address) {
        assert!(0x829f06d3746829abf21cd5fa64a6879ffb702b54074e19c5d79df2e8279d4d07::access_control::is_reviewer(arg0, arg2, 0x2::object::id<0x829f06d3746829abf21cd5fa64a6879ffb702b54074e19c5d79df2e8279d4d07::access_control::ReviewerCap>(arg1)), 3);
    }

    public fun can_manage(arg0: &Project, arg1: address) : bool {
        is_owner(arg0, arg1) || is_co_admin(arg0, arg1)
    }

    public fun can_manage_members(arg0: &Project, arg1: address) : bool {
        is_owner(arg0, arg1)
    }

    public fun can_review(arg0: &Project, arg1: address) : bool {
        if (is_owner(arg0, arg1)) {
            true
        } else if (is_co_admin(arg0, arg1)) {
            true
        } else {
            is_reviewer(arg0, arg1)
        }
    }

    public fun can_view(arg0: &Project, arg1: address) : bool {
        if (is_owner(arg0, arg1)) {
            true
        } else if (is_co_admin(arg0, arg1)) {
            true
        } else {
            is_reviewer(arg0, arg1)
        }
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
        let v1 = arg0.next_form_id;
        arg0.next_form_id = v1 + 1;
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
        arg0.forms_count = 0x1::vector::length<Form>(&arg0.forms);
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

    public fun create_project(arg0: &0x829f06d3746829abf21cd5fa64a6879ffb702b54074e19c5d79df2e8279d4d07::access_control::AdminCap, arg1: &0x829f06d3746829abf21cd5fa64a6879ffb702b54074e19c5d79df2e8279d4d07::access_control::Registry, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) : ProjectOwnerCap {
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
        v3
    }

    public fun create_project_by_owner(arg0: &0x829f06d3746829abf21cd5fa64a6879ffb702b54074e19c5d79df2e8279d4d07::access_control::OwnerCap, arg1: &0x829f06d3746829abf21cd5fa64a6879ffb702b54074e19c5d79df2e8279d4d07::access_control::Registry, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) : ProjectOwnerCap {
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
        v3
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
            members       : 0x1::vector::empty<Member>(),
            forms_count   : 0,
            signals_count : 0,
            next_form_id  : 0,
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

    public fun delete_form(arg0: &mut Project, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert_project_admin(arg0, v0);
        assert!(!form_has_signals(&arg0.signals, arg1), 9);
        let v1 = 0x1::vector::swap_remove<Form>(&mut arg0.forms, find_form_index(&arg0.forms, arg1));
        arg0.forms_count = 0x1::vector::length<Form>(&arg0.forms);
        let v2 = FormDeleted{
            project_id : arg0.project_id,
            form_id    : arg1,
            title      : v1.title,
            actor      : v0,
        };
        0x2::event::emit<FormDeleted>(v2);
    }

    public fun delete_project(arg0: Project, arg1: ProjectOwnerCap, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert_project_owner(&arg0, &arg1, v0);
        let v1 = ProjectDeleted{
            project_id    : arg0.project_id,
            actor         : v0,
            forms_count   : arg0.forms_count,
            signals_count : arg0.signals_count,
        };
        0x2::event::emit<ProjectDeleted>(v1);
        destroy_project_owner_cap(arg1);
        destroy_project(arg0);
    }

    fun destroy_project(arg0: Project) {
        let Project {
            id            : v0,
            project_id    : _,
            name          : _,
            owner         : _,
            admins        : _,
            members       : _,
            forms_count   : _,
            signals_count : _,
            next_form_id  : _,
            created_at    : _,
            forms         : _,
            signals       : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    fun destroy_project_owner_cap(arg0: ProjectOwnerCap) {
        let ProjectOwnerCap {
            id         : v0,
            project_id : _,
        } = arg0;
        0x2::object::delete(v0);
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

    fun find_member_index(arg0: &vector<Member>, arg1: address) : 0x1::option::Option<u64> {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Member>(arg0)) {
            if (0x1::vector::borrow<Member>(arg0, v0).addr == arg1) {
                return 0x1::option::some<u64>(v0)
            };
            v0 = v0 + 1;
        };
        0x1::option::none<u64>()
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

    fun form_has_signals(arg0: &vector<SignalReceipt>, arg1: u64) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<SignalReceipt>(arg0)) {
            if (0x1::vector::borrow<SignalReceipt>(arg0, v0).form_id == arg1) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    public fun form_is_active(arg0: &Project, arg1: u64) : bool {
        0x1::vector::borrow<Form>(&arg0.forms, find_form_index(&arg0.forms, arg1)).active
    }

    fun has_prefix(arg0: &vector<u8>, arg1: &vector<u8>) : bool {
        let v0 = 0x1::vector::length<u8>(arg0);
        if (v0 > 0x1::vector::length<u8>(arg1)) {
            return false
        };
        let v1 = 0;
        while (v1 < v0) {
            if (*0x1::vector::borrow<u8>(arg0, v1) != *0x1::vector::borrow<u8>(arg1, v1)) {
                return false
            };
            v1 = v1 + 1;
        };
        true
    }

    public fun is_co_admin(arg0: &Project, arg1: address) : bool {
        if (is_owner(arg0, arg1)) {
            true
        } else if (contains_admin(&arg0.admins, arg1)) {
            true
        } else {
            member_has_role(arg0, arg1, 1)
        }
    }

    public fun is_project_admin(arg0: &Project, arg1: address) : bool {
        can_manage(arg0, arg1)
    }

    fun is_valid_role(arg0: u8) : bool {
        if (arg0 == 0) {
            true
        } else if (arg0 == 1) {
            true
        } else {
            arg0 == 2
        }
    }

    fun member_has_role(arg0: &Project, arg1: address, arg2: u8) : bool {
        let v0 = find_member_index(&arg0.members, arg1);
        if (0x1::option::is_none<u64>(&v0)) {
            return false
        };
        0x1::vector::borrow<Member>(&arg0.members, *0x1::option::borrow<u64>(&v0)).role == arg2
    }

    fun namespace(arg0: &Project) : vector<u8> {
        0x2::object::id_to_bytes(&arg0.project_id)
    }

    public fun project_id(arg0: &ProjectOwnerCap) : 0x2::object::ID {
        arg0.project_id
    }

    public fun project_stats(arg0: &Project) : (u64, u64, u64) {
        (0x1::vector::length<address>(&arg0.admins) + 0x1::vector::length<Member>(&arg0.members), arg0.forms_count, arg0.signals_count)
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

    public fun remove_project_member(arg0: &mut Project, arg1: &ProjectOwnerCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert_project_owner(arg0, arg1, v0);
        assert!(arg2 != arg0.owner, 14);
        let v1 = find_member_index(&arg0.members, arg2);
        if (0x1::option::is_some<u64>(&v1)) {
            let v2 = 0x1::vector::swap_remove<Member>(&mut arg0.members, *0x1::option::borrow<u64>(&v1));
            let v3 = ProjectMemberRemoved{
                project_id : arg0.project_id,
                member     : arg2,
                role       : v2.role,
                actor      : v0,
            };
            0x2::event::emit<ProjectMemberRemoved>(v3);
            return
        } else {
            let v4 = 0;
            while (v4 < 0x1::vector::length<address>(&arg0.admins)) {
                if (*0x1::vector::borrow<address>(&arg0.admins, v4) == arg2) {
                    0x1::vector::swap_remove<address>(&mut arg0.admins, v4);
                    let v5 = ProjectMemberRemoved{
                        project_id : arg0.project_id,
                        member     : arg2,
                        role       : 1,
                        actor      : v0,
                    };
                    0x2::event::emit<ProjectMemberRemoved>(v5);
                    return
                };
                v4 = v4 + 1;
            };
            abort 12
        };
    }

    public fun role_co_admin() : u8 {
        1
    }

    public fun role_owner() : u8 {
        0
    }

    public fun role_reviewer() : u8 {
        2
    }

    entry fun seal_approve_owner_signal(arg0: vector<u8>, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x2::address::to_bytes(0x2::tx_context::sender(arg1));
        assert!(has_prefix(&v0, &arg0), 10);
    }

    entry fun seal_approve_project_admin(arg0: vector<u8>, arg1: &Project, arg2: &0x2::tx_context::TxContext) {
        assert!(can_manage(arg1, 0x2::tx_context::sender(arg2)), 10);
    }

    entry fun seal_approve_project_reviewer(arg0: vector<u8>, arg1: &0x829f06d3746829abf21cd5fa64a6879ffb702b54074e19c5d79df2e8279d4d07::access_control::Registry, arg2: &0x829f06d3746829abf21cd5fa64a6879ffb702b54074e19c5d79df2e8279d4d07::access_control::ReviewerCap, arg3: &Project, arg4: &0x2::tx_context::TxContext) {
        assert_project_reviewer(arg1, arg2, 0x2::tx_context::sender(arg4));
    }

    entry fun seal_approve_project_signal(arg0: vector<u8>, arg1: &Project, arg2: &0x2::tx_context::TxContext) {
        assert_can_review(arg1, 0x2::tx_context::sender(arg2));
        let v0 = namespace(arg1);
        assert!(has_prefix(&v0, &arg0), 10);
    }

    entry fun seal_approve_project_signal_reviewer(arg0: vector<u8>, arg1: &0x829f06d3746829abf21cd5fa64a6879ffb702b54074e19c5d79df2e8279d4d07::access_control::Registry, arg2: &0x829f06d3746829abf21cd5fa64a6879ffb702b54074e19c5d79df2e8279d4d07::access_control::ReviewerCap, arg3: &Project, arg4: &0x2::tx_context::TxContext) {
        assert_project_reviewer(arg1, arg2, 0x2::tx_context::sender(arg4));
        let v0 = namespace(arg3);
        assert!(has_prefix(&v0, &arg0), 10);
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

    public fun update_project_member_role(arg0: &mut Project, arg1: &ProjectOwnerCap, arg2: address, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert_project_owner(arg0, arg1, v0);
        assert!(is_valid_role(arg3) && arg3 != 0, 13);
        assert!(arg2 != arg0.owner, 14);
        let v1 = find_member_index(&arg0.members, arg2);
        assert!(0x1::option::is_some<u64>(&v1), 12);
        let v2 = 0x1::vector::borrow_mut<Member>(&mut arg0.members, *0x1::option::borrow<u64>(&v1));
        v2.role = arg3;
        let v3 = ProjectMemberRoleUpdated{
            project_id    : arg0.project_id,
            member        : arg2,
            previous_role : v2.role,
            role          : arg3,
            actor         : v0,
        };
        0x2::event::emit<ProjectMemberRoleUpdated>(v3);
    }

    public fun update_signal_status(arg0: &mut Project, arg1: u64, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert_can_review(arg0, v0);
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

