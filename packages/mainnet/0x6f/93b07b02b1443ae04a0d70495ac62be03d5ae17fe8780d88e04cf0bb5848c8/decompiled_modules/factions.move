module 0x6f93b07b02b1443ae04a0d70495ac62be03d5ae17fe8780d88e04cf0bb5848c8::factions {
    struct Faction has copy, drop, store {
        id: u64,
        name: 0x1::string::String,
        description: 0x1::string::String,
    }

    public(friend) fun faction_id(arg0: &Faction) : u64 {
        arg0.id
    }

    public(friend) fun faction_name(arg0: &Faction) : &0x1::string::String {
        &arg0.name
    }

    public(friend) fun new_faction(arg0: u64, arg1: 0x1::string::String, arg2: 0x1::string::String) : Faction {
        Faction{
            id          : arg0,
            name        : arg1,
            description : arg2,
        }
    }

    // decompiled from Move bytecode v6
}

