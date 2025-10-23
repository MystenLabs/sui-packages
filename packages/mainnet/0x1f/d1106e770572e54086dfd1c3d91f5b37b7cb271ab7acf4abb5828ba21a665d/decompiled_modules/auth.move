module 0x1fd1106e770572e54086dfd1c3d91f5b37b7cb271ab7acf4abb5828ba21a665d::auth {
    struct ManagerAuth has drop {
        dummy_field: bool,
    }

    public(friend) fun new_auth() : ManagerAuth {
        ManagerAuth{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

