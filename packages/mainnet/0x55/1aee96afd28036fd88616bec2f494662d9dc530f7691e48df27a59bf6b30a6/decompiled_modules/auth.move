module 0x551aee96afd28036fd88616bec2f494662d9dc530f7691e48df27a59bf6b30a6::auth {
    struct ManagerAuth has drop {
        dummy_field: bool,
    }

    public(friend) fun new_auth() : ManagerAuth {
        ManagerAuth{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

