module 0x5ea13e44bc32a2bfd3f1f043271f5a07f4087ef42282f4e7b4a16a41805929a1::auth {
    struct ManagerAuth has drop {
        dummy_field: bool,
    }

    public(friend) fun new_auth() : ManagerAuth {
        ManagerAuth{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

