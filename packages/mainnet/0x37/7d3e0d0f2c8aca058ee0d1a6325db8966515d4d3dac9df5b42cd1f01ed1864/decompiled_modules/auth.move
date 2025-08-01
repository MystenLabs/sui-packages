module 0x377d3e0d0f2c8aca058ee0d1a6325db8966515d4d3dac9df5b42cd1f01ed1864::auth {
    struct ManagerAuth has drop {
        dummy_field: bool,
    }

    public(friend) fun new_auth() : ManagerAuth {
        ManagerAuth{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

