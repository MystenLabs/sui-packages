module 0x67d3f4863daf794628d35c2c18e6d2a7e285e23a7ff8ffae389d0e2bd712b99e::factions {
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

