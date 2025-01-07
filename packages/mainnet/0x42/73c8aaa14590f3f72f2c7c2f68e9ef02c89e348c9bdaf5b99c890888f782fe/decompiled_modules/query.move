module 0x4273c8aaa14590f3f72f2c7c2f68e9ef02c89e348c9bdaf5b99c890888f782fe::query {
    struct QueryAmbassadorByOwnerEvent has copy, drop {
        owner: address,
        ambassador_id: 0x2::object::ID,
    }

    public fun query_ambassador_by_owner(arg0: &0x4273c8aaa14590f3f72f2c7c2f68e9ef02c89e348c9bdaf5b99c890888f782fe::config::AmbassadorConfig, arg1: address) {
        let v0 = QueryAmbassadorByOwnerEvent{
            owner         : arg1,
            ambassador_id : 0x4273c8aaa14590f3f72f2c7c2f68e9ef02c89e348c9bdaf5b99c890888f782fe::config::get_ambassador_id_by_owner(arg0, arg1),
        };
        0x2::event::emit<QueryAmbassadorByOwnerEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

