module 0x7126ef86984cdf50de3ff8bca59097b4eb714aa6f1bd62e3f908094cd85e9a13::demo {
    struct Demo has store, key {
        id: 0x2::object::UID,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Demo{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<Demo>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v7
}

