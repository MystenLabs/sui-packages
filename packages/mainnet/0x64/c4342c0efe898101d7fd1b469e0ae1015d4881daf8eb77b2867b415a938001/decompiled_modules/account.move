module 0x64c4342c0efe898101d7fd1b469e0ae1015d4881daf8eb77b2867b415a938001::account {
    struct Request has store, key {
        id: 0x2::object::UID,
    }

    public fun request_with_account(arg0: &mut 0x2::object::UID) : Request {
        abort 0
    }

    // decompiled from Move bytecode v6
}

