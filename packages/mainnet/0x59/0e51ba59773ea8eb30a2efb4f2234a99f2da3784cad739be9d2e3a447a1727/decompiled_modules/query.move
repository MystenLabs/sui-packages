module 0x590e51ba59773ea8eb30a2efb4f2234a99f2da3784cad739be9d2e3a447a1727::query {
    struct QueryAmbassadorByOwnerEvent has copy, drop {
        owner: address,
        ambassador_id: 0x2::object::ID,
    }

    public fun query_ambassador_by_owner(arg0: &0x590e51ba59773ea8eb30a2efb4f2234a99f2da3784cad739be9d2e3a447a1727::config::AmbassadorConfig, arg1: address) {
        let v0 = QueryAmbassadorByOwnerEvent{
            owner         : arg1,
            ambassador_id : 0x590e51ba59773ea8eb30a2efb4f2234a99f2da3784cad739be9d2e3a447a1727::config::get_ambassador_id_by_owner(arg0, arg1),
        };
        0x2::event::emit<QueryAmbassadorByOwnerEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

