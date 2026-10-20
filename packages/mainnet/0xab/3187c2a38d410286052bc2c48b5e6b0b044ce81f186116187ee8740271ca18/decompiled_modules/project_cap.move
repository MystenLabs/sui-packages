module 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project_cap {
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

