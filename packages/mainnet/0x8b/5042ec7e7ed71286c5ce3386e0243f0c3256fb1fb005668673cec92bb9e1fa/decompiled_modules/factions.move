module 0x8b5042ec7e7ed71286c5ce3386e0243f0c3256fb1fb005668673cec92bb9e1fa::factions {
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

