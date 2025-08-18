module 0xe1bf44069166378119e64bcc20eb653803c1483a76f4385c3ba7c5a291bd80c9::events {
    struct RaffleCreated has copy, drop {
        raffle_id: 0x2::object::ID,
    }

    struct RaffleParticipantJoined has copy, drop {
        raffle_id: 0x2::object::ID,
        participant_address: address,
    }

    struct RaffleWinnerSelected has copy, drop {
        raffle_id: 0x2::object::ID,
        winner_address: address,
    }

    struct RaffleFinished has copy, drop {
        raffle_id: 0x2::object::ID,
    }

    public(friend) fun emit_raffle_created(arg0: 0x2::object::ID) {
        let v0 = RaffleCreated{raffle_id: arg0};
        0xe1bf44069166378119e64bcc20eb653803c1483a76f4385c3ba7c5a291bd80c9::event_wrapper::emit_event<RaffleCreated>(v0);
    }

    public(friend) fun emit_raffle_finished(arg0: 0x2::object::ID) {
        let v0 = RaffleFinished{raffle_id: arg0};
        0xe1bf44069166378119e64bcc20eb653803c1483a76f4385c3ba7c5a291bd80c9::event_wrapper::emit_event<RaffleFinished>(v0);
    }

    public(friend) fun emit_raffle_participant_joined(arg0: 0x2::object::ID, arg1: address) {
        let v0 = RaffleParticipantJoined{
            raffle_id           : arg0,
            participant_address : arg1,
        };
        0xe1bf44069166378119e64bcc20eb653803c1483a76f4385c3ba7c5a291bd80c9::event_wrapper::emit_event<RaffleParticipantJoined>(v0);
    }

    public(friend) fun emit_raffle_winner_selected(arg0: 0x2::object::ID, arg1: address) {
        let v0 = RaffleWinnerSelected{
            raffle_id      : arg0,
            winner_address : arg1,
        };
        0xe1bf44069166378119e64bcc20eb653803c1483a76f4385c3ba7c5a291bd80c9::event_wrapper::emit_event<RaffleWinnerSelected>(v0);
    }

    // decompiled from Move bytecode v6
}

