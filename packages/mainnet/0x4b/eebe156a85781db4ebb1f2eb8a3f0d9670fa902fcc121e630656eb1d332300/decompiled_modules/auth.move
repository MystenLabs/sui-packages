module 0x4beebe156a85781db4ebb1f2eb8a3f0d9670fa902fcc121e630656eb1d332300::auth {
    struct ManagerAuth has drop {
        dummy_field: bool,
    }

    public(friend) fun new_auth() : ManagerAuth {
        ManagerAuth{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

