module 0x10288302c6c8ece585c2b3b0aca211e7f0a6fe798b64198120de4c52ff12fff1::authority {
    struct Authority has store, key {
        id: 0x2::object::UID,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Authority{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<Authority>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

