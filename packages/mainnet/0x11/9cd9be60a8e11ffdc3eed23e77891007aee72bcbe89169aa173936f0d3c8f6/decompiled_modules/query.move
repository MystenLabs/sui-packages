module 0x119cd9be60a8e11ffdc3eed23e77891007aee72bcbe89169aa173936f0d3c8f6::query {
    struct QueryAmbassadorByOwnerEvent has copy, drop {
        owner: address,
        ambassador_id: 0x2::object::ID,
    }

    public fun query_ambassador_by_owner(arg0: &0x119cd9be60a8e11ffdc3eed23e77891007aee72bcbe89169aa173936f0d3c8f6::config::AmbassadorConfig, arg1: address) {
        let v0 = QueryAmbassadorByOwnerEvent{
            owner         : arg1,
            ambassador_id : 0x119cd9be60a8e11ffdc3eed23e77891007aee72bcbe89169aa173936f0d3c8f6::config::get_ambassador_id_by_owner(arg0, arg1),
        };
        0x2::event::emit<QueryAmbassadorByOwnerEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

