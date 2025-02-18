module 0x61ee06f00574956076162b96eb30e1de04dca6c857f62b4de5cf67c812ae1687::launchpad {
    struct Launchpad has key {
        id: 0x2::object::UID,
        address: address,
        sender: address,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Launchpad{
            id      : 0x2::object::new(arg0),
            address : 0x2::tx_context::sender(arg0),
            sender  : 0x2::tx_context::sender(arg0),
        };
        v0.address = 0x2::object::uid_to_address(&v0.id);
        0x2::transfer::transfer<Launchpad>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

