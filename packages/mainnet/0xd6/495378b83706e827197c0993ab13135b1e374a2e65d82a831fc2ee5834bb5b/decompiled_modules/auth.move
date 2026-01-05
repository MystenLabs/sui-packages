module 0xd6495378b83706e827197c0993ab13135b1e374a2e65d82a831fc2ee5834bb5b::auth {
    struct ManagerAuth has drop {
        dummy_field: bool,
    }

    public(friend) fun new_auth() : ManagerAuth {
        ManagerAuth{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

