module 0x79b6d0afa058146ae90199b54590c43ce6750f94ea3b462f2b6dfd69c2c76bfe::ticket_commit {
    struct TicketCommit has store, key {
        id: 0x2::object::UID,
        game_id: 0x2::object::ID,
        signature: vector<u8>,
    }

    public fun burn_ticket_commit(arg0: TicketCommit) {
        let TicketCommit {
            id        : v0,
            game_id   : _,
            signature : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public(friend) fun create_ticket_commit<T0>(arg0: &mut 0x79b6d0afa058146ae90199b54590c43ce6750f94ea3b462f2b6dfd69c2c76bfe::game::Game<T0>, arg1: &mut 0x79b6d0afa058146ae90199b54590c43ce6750f94ea3b462f2b6dfd69c2c76bfe::fee_collector::FeeCollector<T0>, arg2: 0x2::coin::Coin<T0>, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) : TicketCommit {
        0x79b6d0afa058146ae90199b54590c43ce6750f94ea3b462f2b6dfd69c2c76bfe::game::add_ticket_commit<T0>(arg0, arg1, arg2, arg4);
        TicketCommit{
            id        : 0x2::object::new(arg4),
            game_id   : 0x2::object::id<0x79b6d0afa058146ae90199b54590c43ce6750f94ea3b462f2b6dfd69c2c76bfe::game::Game<T0>>(arg0),
            signature : arg3,
        }
    }

    public fun get_game_id(arg0: &TicketCommit) : 0x2::object::ID {
        arg0.game_id
    }

    public fun get_signature(arg0: &TicketCommit) : vector<u8> {
        arg0.signature
    }

    // decompiled from Move bytecode v6
}

