module 0xe245681673283fec53e15862d3d14bc6d3c65d8bf27c4dc0e62d338eb968c9eb::query {
    struct QueryAmbassadorByOwnerEvent has copy, drop {
        owner: address,
        ambassador_id: 0x2::object::ID,
    }

    public fun query_ambassador_by_owner(arg0: &0xe245681673283fec53e15862d3d14bc6d3c65d8bf27c4dc0e62d338eb968c9eb::config::AmbassadorConfig, arg1: address) {
        let v0 = QueryAmbassadorByOwnerEvent{
            owner         : arg1,
            ambassador_id : 0xe245681673283fec53e15862d3d14bc6d3c65d8bf27c4dc0e62d338eb968c9eb::config::get_ambassador_id_by_owner(arg0, arg1),
        };
        0x2::event::emit<QueryAmbassadorByOwnerEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

