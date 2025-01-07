module 0x1ff3029d3ae82c9998d91c632da9cea66b7020bc794571cb986270e4d6117e05::query {
    struct QueryAmbassadorByOwnerEvent has copy, drop {
        owner: address,
        ambassador_id: 0x2::object::ID,
    }

    public fun query_ambassador_by_owner(arg0: &0x1ff3029d3ae82c9998d91c632da9cea66b7020bc794571cb986270e4d6117e05::config::AmbassadorConfig, arg1: address) {
        let v0 = QueryAmbassadorByOwnerEvent{
            owner         : arg1,
            ambassador_id : 0x1ff3029d3ae82c9998d91c632da9cea66b7020bc794571cb986270e4d6117e05::config::get_ambassador_id_by_owner(arg0, arg1),
        };
        0x2::event::emit<QueryAmbassadorByOwnerEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

