module 0x20a5373c3ef7e36a4908083cc669dbfa18195cb7a3eccd1facbea526cda3d7c6::query {
    struct QueryAmbassadorByOwnerEvent has copy, drop {
        owner: address,
        ambassador_id: 0x2::object::ID,
    }

    public fun query_ambassador_by_owner(arg0: &0x20a5373c3ef7e36a4908083cc669dbfa18195cb7a3eccd1facbea526cda3d7c6::config::AmbassadorConfig, arg1: address) {
        let v0 = QueryAmbassadorByOwnerEvent{
            owner         : arg1,
            ambassador_id : 0x20a5373c3ef7e36a4908083cc669dbfa18195cb7a3eccd1facbea526cda3d7c6::config::get_ambassador_id_by_owner(arg0, arg1),
        };
        0x2::event::emit<QueryAmbassadorByOwnerEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

