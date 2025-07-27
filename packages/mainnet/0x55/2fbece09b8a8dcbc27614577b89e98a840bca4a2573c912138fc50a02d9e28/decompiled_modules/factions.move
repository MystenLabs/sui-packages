module 0x552fbece09b8a8dcbc27614577b89e98a840bca4a2573c912138fc50a02d9e28::factions {
    struct Faction has copy, drop, store {
        id: u64,
        name: 0x1::string::String,
        description: 0x1::string::String,
    }

    public fun faction_description(arg0: &Faction) : &0x1::string::String {
        &arg0.description
    }

    public fun faction_id(arg0: &Faction) : u64 {
        arg0.id
    }

    public fun faction_name(arg0: &Faction) : &0x1::string::String {
        &arg0.name
    }

    public fun new_faction(arg0: u64, arg1: 0x1::string::String, arg2: 0x1::string::String) : Faction {
        Faction{
            id          : arg0,
            name        : arg1,
            description : arg2,
        }
    }

    // decompiled from Move bytecode v6
}

