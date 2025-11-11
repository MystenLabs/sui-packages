module 0xfbf46a3d9717aff0b76f49f9fcb3169d593a65db8df43e0d2a2443b28a1334a8::todo {
    struct Task has drop, store {
        description: vector<u8>,
        done: bool,
    }

    struct TaskList has store, key {
        id: 0x2::object::UID,
        items: vector<Task>,
    }

    fun add_task_to_list(arg0: &mut TaskList, arg1: Task) {
        0x1::vector::push_back<Task>(&mut arg0.items, arg1);
    }

    fun create_task(arg0: vector<u8>) : Task {
        Task{
            description : arg0,
            done        : false,
        }
    }

    fun create_tasklist(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = TaskList{
            id    : 0x2::object::new(arg0),
            items : 0x1::vector::empty<Task>(),
        };
        0x2::transfer::transfer<TaskList>(v0, 0x2::tx_context::sender(arg0));
    }

    fun delete_tasklist(arg0: TaskList) {
        let TaskList {
            id    : v0,
            items : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    fun get_completed_tasks(arg0: &TaskList) {
        let v0 = 0x1::vector::length<Task>(&arg0.items);
        if (v0 > 0) {
            let v1 = 0;
            while (v1 < v0) {
                let v2 = 0x1::vector::borrow<Task>(&arg0.items, v1);
                if (v2.done) {
                    0x1::debug::print<Task>(v2);
                };
                v1 = v1 + 1;
            };
        };
    }

    fun get_incomplete_tasks(arg0: &TaskList) {
        let v0 = 0x1::vector::length<Task>(&arg0.items);
        if (v0 > 0) {
            let v1 = 0;
            while (v1 < v0) {
                let v2 = 0x1::vector::borrow<Task>(&arg0.items, v1);
                if (!v2.done) {
                    0x1::debug::print<Task>(v2);
                };
                v1 = v1 + 1;
            };
        };
    }

    fun get_tasks(arg0: &TaskList) {
        let v0 = 0x1::vector::length<Task>(&arg0.items);
        if (v0 > 0) {
            let v1 = 0;
            while (v1 < v0) {
                0x1::debug::print<Task>(0x1::vector::borrow<Task>(&arg0.items, v1));
                v1 = v1 + 1;
            };
        };
    }

    fun mark_as_done(arg0: &mut Task) {
        arg0.done = true;
    }

    fun update_task(arg0: &mut Task, arg1: vector<u8>) {
        arg0.description = arg1;
    }

    // decompiled from Move bytecode v6
}

