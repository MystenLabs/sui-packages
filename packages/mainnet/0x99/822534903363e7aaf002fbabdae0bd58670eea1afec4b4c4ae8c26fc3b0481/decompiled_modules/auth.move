module 0x99822534903363e7aaf002fbabdae0bd58670eea1afec4b4c4ae8c26fc3b0481::auth {
    struct ManagerAuth has drop {
        dummy_field: bool,
    }

    public(friend) fun new_auth() : ManagerAuth {
        ManagerAuth{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

