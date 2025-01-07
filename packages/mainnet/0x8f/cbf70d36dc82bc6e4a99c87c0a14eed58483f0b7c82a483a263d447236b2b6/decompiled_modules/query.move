module 0x8fcbf70d36dc82bc6e4a99c87c0a14eed58483f0b7c82a483a263d447236b2b6::query {
    struct QueryAmbassadorByOwnerEvent has copy, drop {
        owner: address,
        ambassador_id: 0x2::object::ID,
    }

    public fun query_ambassador_by_owner(arg0: &0x8fcbf70d36dc82bc6e4a99c87c0a14eed58483f0b7c82a483a263d447236b2b6::config::AmbassadorConfig, arg1: address) {
        let v0 = QueryAmbassadorByOwnerEvent{
            owner         : arg1,
            ambassador_id : 0x8fcbf70d36dc82bc6e4a99c87c0a14eed58483f0b7c82a483a263d447236b2b6::config::get_ambassador_id_by_owner(arg0, arg1),
        };
        0x2::event::emit<QueryAmbassadorByOwnerEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

