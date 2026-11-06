module 0x1696aeabdfab810e474908072c2c9b685071135622b6a5342ebc7e15f6767b7f::player {
    struct Player has key {
        id: 0x2::object::UID,
        number: u64,
    }

    struct PlayerRegistry has key {
        id: 0x2::object::UID,
        count: u64,
    }

    struct PlayerKey has copy, drop, store {
        pos0: address,
    }

    struct PlayerCreatedEvent has copy, drop {
        player_id: 0x2::object::ID,
        owner: address,
        number: u64,
    }

    public fun derive_address(arg0: &PlayerRegistry, arg1: address) : address {
        let v0 = PlayerKey{pos0: arg1};
        0x2::derived_object::derive_address<PlayerKey>(0x2::object::uid_to_inner(&arg0.id), v0)
    }

    public fun new(arg0: &mut PlayerRegistry, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        arg0.count = arg0.count + 1;
        let v1 = arg0.count;
        let v2 = PlayerKey{pos0: v0};
        let v3 = Player{
            id     : 0x2::derived_object::claim<PlayerKey>(&mut arg0.id, v2),
            number : v1,
        };
        let v4 = PlayerCreatedEvent{
            player_id : 0x2::object::id<Player>(&v3),
            owner     : v0,
            number    : v1,
        };
        0x2::event::emit<PlayerCreatedEvent>(v4);
        0x2::transfer::transfer<Player>(v3, v0);
    }

    public fun count(arg0: &PlayerRegistry) : u64 {
        arg0.count
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PlayerRegistry{
            id    : 0x2::object::new(arg0),
            count : 0,
        };
        0x2::transfer::share_object<PlayerRegistry>(v0);
    }

    public fun number(arg0: &Player) : u64 {
        arg0.number
    }

    public fun uid(arg0: &Player) : &0x2::object::UID {
        &arg0.id
    }

    public fun uid_mut(arg0: &mut Player) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    // decompiled from Move bytecode v7
}

