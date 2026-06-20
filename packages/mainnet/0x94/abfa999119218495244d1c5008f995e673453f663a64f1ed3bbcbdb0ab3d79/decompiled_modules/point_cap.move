module 0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::point_cap {
    struct PointCap has store, key {
        id: 0x2::object::UID,
        project_id: 0x2::object::ID,
    }

    public fun get_point_cap_project_ID(arg0: &PointCap) : &0x2::object::ID {
        &arg0.project_id
    }

    public(friend) fun new_point_cap(arg0: &0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::project_cap::ProjectCap, arg1: &mut 0x2::tx_context::TxContext) : PointCap {
        PointCap{
            id         : 0x2::object::new(arg1),
            project_id : 0x2::object::id<0x810c9b47bd1f6eb88c4f6e29221a5408882dcb100ddf13074a9efe6917116039::project_cap::ProjectCap>(arg0),
        }
    }

    // decompiled from Move bytecode v7
}

