module 0xb0ba6a934c62ce0d6618d14657a658ab7cf5ab406a7aad091e198fbd471d48aa::account {
    struct Request has store, key {
        id: 0x2::object::UID,
    }

    public fun request_with_account(arg0: &mut 0x2::object::UID) : Request {
        abort 0
    }

    // decompiled from Move bytecode v6
}

