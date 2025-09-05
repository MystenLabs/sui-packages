module 0x888484c3f3e015f41fa3875691d95a7b20dd8397a3cecf2cf50c25b9983a592d::main {
    struct MockSuiNS has store, key {
        id: 0x2::object::UID,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MockSuiNS{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<MockSuiNS>(v0, 0x2::tx_context::sender(arg0));
    }

    entry fun recover_funds<T0>(arg0: &mut MockSuiNS, arg1: 0x2::transfer::Receiving<0x2::coin::Coin<T0>>, arg2: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::transfer::public_receive<0x2::coin::Coin<T0>>(&mut arg0.id, arg1), arg2);
    }

    // decompiled from Move bytecode v6
}

