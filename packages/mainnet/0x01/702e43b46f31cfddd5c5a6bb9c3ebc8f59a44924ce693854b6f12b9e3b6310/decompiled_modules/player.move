module 0x1702e43b46f31cfddd5c5a6bb9c3ebc8f59a44924ce693854b6f12b9e3b6310::player {
    struct PlayerRegistry has key {
        id: 0x2::object::UID,
    }

    struct Player has key {
        id: 0x2::object::UID,
        owner: address,
    }

    struct PlayerKey has copy, drop, store {
        pos0: address,
    }

    struct PlayerCreatedEvent has copy, drop {
        player_id: 0x2::object::ID,
        owner: address,
    }

    public fun derive_address(arg0: &PlayerRegistry, arg1: address) : address {
        let v0 = PlayerKey{pos0: arg1};
        0x2::derived_object::derive_address<PlayerKey>(0x2::object::id<PlayerRegistry>(arg0), v0)
    }

    public fun new(arg0: &mut PlayerRegistry, arg1: &mut 0x2::tx_context::TxContext) : Player {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = PlayerKey{pos0: v0};
        let v2 = Player{
            id    : 0x2::derived_object::claim<PlayerKey>(&mut arg0.id, v1),
            owner : v0,
        };
        let v3 = PlayerCreatedEvent{
            player_id : 0x2::object::id<Player>(&v2),
            owner     : v0,
        };
        0x2::event::emit<PlayerCreatedEvent>(v3);
        v2
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PlayerRegistry{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<PlayerRegistry>(v0);
    }

    public fun keep(arg0: Player) {
        0x2::transfer::transfer<Player>(arg0, arg0.owner);
    }

    public fun owner(arg0: &Player) : address {
        arg0.owner
    }

    public fun uid(arg0: &Player) : &0x2::object::UID {
        &arg0.id
    }

    public fun uid_mut(arg0: &mut Player) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    // decompiled from Move bytecode v7
}

