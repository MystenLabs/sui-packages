module 0x179af5a6954da7be035339a9fb4aa9aecd0be6b0dfc6f92775bfc4588cc29832::project_board {
    struct ProjectBoard has key {
        id: 0x2::object::UID,
        project_id: 0x1::string::String,
        name: 0x1::string::String,
        owner: address,
        task_count: u64,
        completed_count: u64,
        failed_count: u64,
        status: u8,
        created_at: u64,
        updated_at: u64,
    }

    struct TaskEntry has copy, drop, store {
        task_id: 0x1::string::String,
        title: 0x1::string::String,
        status: u8,
        assigned_agent: 0x1::string::String,
        dependencies: vector<0x1::string::String>,
        walrus_blob_id: 0x1::string::String,
        updated_at: u64,
    }

    struct ProjectCreated has copy, drop {
        board_id: 0x2::object::ID,
        project_id: 0x1::string::String,
        name: 0x1::string::String,
        owner: address,
        task_count: u64,
    }

    struct TaskStatusChanged has copy, drop {
        board_id: 0x2::object::ID,
        project_id: 0x1::string::String,
        task_id: 0x1::string::String,
        old_status: u8,
        new_status: u8,
        assigned_agent: 0x1::string::String,
        updated_by: address,
    }

    struct ProjectCompleted has copy, drop {
        board_id: 0x2::object::ID,
        project_id: 0x1::string::String,
        total_tasks: u64,
        completed_tasks: u64,
        failed_tasks: u64,
    }

    public entry fun add_task(arg0: &mut ProjectBoard, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: vector<0x1::string::String>, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg6) == arg0.owner, 300);
        assert!(arg0.status != 2, 301);
        let v0 = 0x2::clock::timestamp_ms(arg5);
        let v1 = TaskEntry{
            task_id        : arg1,
            title          : arg2,
            status         : 0,
            assigned_agent : arg3,
            dependencies   : arg4,
            walrus_blob_id : 0x1::string::utf8(b""),
            updated_at     : v0,
        };
        0x2::dynamic_field::add<vector<u8>, TaskEntry>(&mut arg0.id, task_key(&v1.task_id), v1);
        arg0.task_count = arg0.task_count + 1;
        arg0.updated_at = v0;
    }

    public entry fun complete_project(arg0: &mut ProjectBoard, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 300);
        arg0.status = 2;
        arg0.updated_at = 0x2::clock::timestamp_ms(arg1);
        let v0 = ProjectCompleted{
            board_id        : 0x2::object::id<ProjectBoard>(arg0),
            project_id      : arg0.project_id,
            total_tasks     : arg0.task_count,
            completed_tasks : arg0.completed_count,
            failed_tasks    : arg0.failed_count,
        };
        0x2::event::emit<ProjectCompleted>(v0);
    }

    public fun create(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : ProjectBoard {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        let v2 = ProjectBoard{
            id              : 0x2::object::new(arg3),
            project_id      : arg0,
            name            : arg1,
            owner           : v0,
            task_count      : 0,
            completed_count : 0,
            failed_count    : 0,
            status          : 0,
            created_at      : v1,
            updated_at      : v1,
        };
        let v3 = ProjectCreated{
            board_id   : 0x2::object::id<ProjectBoard>(&v2),
            project_id : v2.project_id,
            name       : v2.name,
            owner      : v0,
            task_count : 0,
        };
        0x2::event::emit<ProjectCreated>(v3);
        v2
    }

    entry fun create_shared(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<ProjectBoard>(create(arg0, arg1, arg2, arg3));
    }

    public fun get_completed_count(arg0: &ProjectBoard) : u64 {
        arg0.completed_count
    }

    public fun get_failed_count(arg0: &ProjectBoard) : u64 {
        arg0.failed_count
    }

    public fun get_name(arg0: &ProjectBoard) : 0x1::string::String {
        arg0.name
    }

    public fun get_project_id(arg0: &ProjectBoard) : 0x1::string::String {
        arg0.project_id
    }

    public fun get_status(arg0: &ProjectBoard) : u8 {
        arg0.status
    }

    public fun get_task(arg0: &ProjectBoard, arg1: 0x1::string::String) : TaskEntry {
        let v0 = task_key(&arg1);
        assert!(0x2::dynamic_field::exists_with_type<vector<u8>, TaskEntry>(&arg0.id, v0), 302);
        *0x2::dynamic_field::borrow<vector<u8>, TaskEntry>(&arg0.id, v0)
    }

    public fun get_task_count(arg0: &ProjectBoard) : u64 {
        arg0.task_count
    }

    public entry fun reassign_task(arg0: &mut ProjectBoard, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.owner, 300);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        let v1 = task_key(&arg1);
        assert!(0x2::dynamic_field::exists_with_type<vector<u8>, TaskEntry>(&arg0.id, v1), 302);
        let v2 = 0x2::dynamic_field::borrow_mut<vector<u8>, TaskEntry>(&mut arg0.id, v1);
        v2.assigned_agent = arg2;
        v2.updated_at = v0;
        arg0.updated_at = v0;
    }

    public entry fun set_task_artifact(arg0: &mut ProjectBoard, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg3);
        let v1 = task_key(&arg1);
        assert!(0x2::dynamic_field::exists_with_type<vector<u8>, TaskEntry>(&arg0.id, v1), 302);
        let v2 = 0x2::dynamic_field::borrow_mut<vector<u8>, TaskEntry>(&mut arg0.id, v1);
        v2.walrus_blob_id = arg2;
        v2.updated_at = v0;
        arg0.updated_at = v0;
    }

    public fun task_exists(arg0: &ProjectBoard, arg1: 0x1::string::String) : bool {
        0x2::dynamic_field::exists_with_type<vector<u8>, TaskEntry>(&arg0.id, task_key(&arg1))
    }

    fun task_key(arg0: &0x1::string::String) : vector<u8> {
        *0x1::string::as_bytes(arg0)
    }

    public entry fun update_task_status(arg0: &mut ProjectBoard, arg1: 0x1::string::String, arg2: u8, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(arg0.status != 2, 301);
        assert!(arg2 <= 4, 303);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        let v1 = task_key(&arg1);
        assert!(0x2::dynamic_field::exists_with_type<vector<u8>, TaskEntry>(&arg0.id, v1), 302);
        let v2 = 0x2::dynamic_field::borrow<vector<u8>, TaskEntry>(&arg0.id, v1).status;
        if (v2 == 2 && arg2 != 2) {
            arg0.completed_count = arg0.completed_count - 1;
        };
        if (v2 == 3 && arg2 != 3) {
            arg0.failed_count = arg0.failed_count - 1;
        };
        if (arg2 == 2 && v2 != 2) {
            arg0.completed_count = arg0.completed_count + 1;
        };
        if (arg2 == 3 && v2 != 3) {
            arg0.failed_count = arg0.failed_count + 1;
        };
        arg0.updated_at = v0;
        let v3 = 0x2::dynamic_field::borrow_mut<vector<u8>, TaskEntry>(&mut arg0.id, v1);
        v3.status = arg2;
        v3.updated_at = v0;
        let v4 = TaskStatusChanged{
            board_id       : 0x2::object::id<ProjectBoard>(arg0),
            project_id     : arg0.project_id,
            task_id        : arg1,
            old_status     : v2,
            new_status     : arg2,
            assigned_agent : 0x2::dynamic_field::borrow<vector<u8>, TaskEntry>(&arg0.id, v1).assigned_agent,
            updated_by     : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<TaskStatusChanged>(v4);
    }

    // decompiled from Move bytecode v7
}

