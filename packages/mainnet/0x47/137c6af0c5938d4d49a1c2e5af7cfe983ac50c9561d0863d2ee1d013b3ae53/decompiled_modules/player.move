module 0x47137c6af0c5938d4d49a1c2e5af7cfe983ac50c9561d0863d2ee1d013b3ae53::player {
    struct Player has store, key {
        id: 0x2::object::UID,
    }

    struct PlayerCreatedEvent has copy, drop {
        player_id: 0x2::object::ID,
    }

    public fun new(arg0: &mut 0x2::tx_context::TxContext) : Player {
        let v0 = Player{id: 0x2::object::new(arg0)};
        let v1 = PlayerCreatedEvent{player_id: 0x2::object::id<Player>(&v0)};
        0x2::event::emit<PlayerCreatedEvent>(v1);
        v0
    }

    public fun uid(arg0: &Player) : &0x2::object::UID {
        &arg0.id
    }

    public fun uid_mut(arg0: &mut Player) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    // decompiled from Move bytecode v7
}

