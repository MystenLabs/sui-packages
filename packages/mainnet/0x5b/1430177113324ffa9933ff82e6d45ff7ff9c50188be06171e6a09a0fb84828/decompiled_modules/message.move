module 0x5b1430177113324ffa9933ff82e6d45ff7ff9c50188be06171e6a09a0fb84828::message {
    struct Message has store, key {
        id: 0x2::object::UID,
    }

    struct MESSAGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MESSAGE, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<MESSAGE>(arg0, arg1);
        let v0 = Message{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<Message>(v0, @0xffbf8a12dff6587b8d0465fedd60b59b60a667adb621518468e7f442a7b2a8e);
    }

    // decompiled from Move bytecode v6
}

