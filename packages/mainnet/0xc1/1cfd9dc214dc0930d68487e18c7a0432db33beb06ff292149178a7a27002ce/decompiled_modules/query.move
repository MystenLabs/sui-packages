module 0xc11cfd9dc214dc0930d68487e18c7a0432db33beb06ff292149178a7a27002ce::query {
    struct QueryAmbassadorByOwnerEvent has copy, drop {
        owner: address,
        ambassador_id: 0x2::object::ID,
    }

    public fun query_ambassador_by_owner(arg0: &0xc11cfd9dc214dc0930d68487e18c7a0432db33beb06ff292149178a7a27002ce::config::AmbassadorConfig, arg1: address) {
        let v0 = QueryAmbassadorByOwnerEvent{
            owner         : arg1,
            ambassador_id : 0xc11cfd9dc214dc0930d68487e18c7a0432db33beb06ff292149178a7a27002ce::config::get_ambassador_id_by_owner(arg0, arg1),
        };
        0x2::event::emit<QueryAmbassadorByOwnerEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

