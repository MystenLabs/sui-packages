module 0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::point_cap {
    struct PointCap has store, key {
        id: 0x2::object::UID,
        project_id: 0x2::object::ID,
    }

    public fun get_point_cap_project_ID(arg0: &PointCap) : &0x2::object::ID {
        &arg0.project_id
    }

    public(friend) fun new_point_cap(arg0: &0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::project_cap::ProjectCap, arg1: &mut 0x2::tx_context::TxContext) : PointCap {
        PointCap{
            id         : 0x2::object::new(arg1),
            project_id : 0x2::object::id<0x76d02228b24857252461d18a199aa4159dfcced5c88d8acdf463888befca9dc::project_cap::ProjectCap>(arg0),
        }
    }

    // decompiled from Move bytecode v7
}

