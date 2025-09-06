module 0x13fc4df898341ac6329fea3d59ef79176b0faef94ad2915d2979bdcb6d2f9705::factions {
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

