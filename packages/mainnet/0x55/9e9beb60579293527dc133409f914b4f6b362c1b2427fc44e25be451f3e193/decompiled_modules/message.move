module 0x559e9beb60579293527dc133409f914b4f6b362c1b2427fc44e25be451f3e193::message {
    struct Message has store, key {
        id: 0x2::object::UID,
    }

    struct MESSAGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MESSAGE, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<MESSAGE>(arg0, arg1);
        let v0 = Message{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<Message>(v0, @0xad37e5f6b116077335d80b533363db9df9af28d93eb89f9efe2c3ac0cc3aef38);
    }

    // decompiled from Move bytecode v6
}

