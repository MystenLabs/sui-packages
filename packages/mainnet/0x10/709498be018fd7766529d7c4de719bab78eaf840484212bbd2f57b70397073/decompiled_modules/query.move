module 0x6694aad3ac83111da7d9d249560ad655f36c525e595bb7104e74832643dab91b::query {
    struct QueryAmbassadorByOwnerEvent has copy, drop {
        owner: address,
        ambassador_id: 0x2::object::ID,
    }

    public fun query_ambassador_by_owner(arg0: &0x6694aad3ac83111da7d9d249560ad655f36c525e595bb7104e74832643dab91b::config::AmbassadorConfig, arg1: address) {
        let v0 = QueryAmbassadorByOwnerEvent{
            owner         : arg1,
            ambassador_id : 0x6694aad3ac83111da7d9d249560ad655f36c525e595bb7104e74832643dab91b::config::get_ambassador_id_by_owner(arg0, arg1),
        };
        0x2::event::emit<QueryAmbassadorByOwnerEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

