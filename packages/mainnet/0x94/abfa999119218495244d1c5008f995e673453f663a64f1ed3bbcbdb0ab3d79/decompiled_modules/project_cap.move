module 0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::project_cap {
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

