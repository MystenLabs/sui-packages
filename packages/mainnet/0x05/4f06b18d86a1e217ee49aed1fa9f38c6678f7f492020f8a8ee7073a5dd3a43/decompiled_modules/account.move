module 0x54f06b18d86a1e217ee49aed1fa9f38c6678f7f492020f8a8ee7073a5dd3a43::account {
    struct Request has store, key {
        id: 0x2::object::UID,
    }

    public fun request_with_account(arg0: &mut 0x2::object::UID) : Request {
        abort 0
    }

    // decompiled from Move bytecode v6
}

