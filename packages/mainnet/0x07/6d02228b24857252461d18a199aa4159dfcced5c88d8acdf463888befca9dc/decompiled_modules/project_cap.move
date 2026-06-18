module 0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::project_cap {
    struct ProjectCap has store, key {
        id: 0x2::object::UID,
    }

    public fun get_project_cap_ID(arg0: &ProjectCap) : 0x2::object::ID {
        0x2::object::id<ProjectCap>(arg0)
    }

    public(friend) fun new_project_cap(arg0: &mut 0x2::tx_context::TxContext) : ProjectCap {
        ProjectCap{id: 0x2::object::new(arg0)}
    }

    // decompiled from Move bytecode v7
}

