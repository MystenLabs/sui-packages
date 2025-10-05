module 0xd6dfe75ab0586a023edc0b43f28028269c43be4dfa2a1e5bba0dc8a73b689b1c::setup {
    public entry fun create_state(arg0: &0x2::package::Publisher, arg1: address, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_share_object<0xd6dfe75ab0586a023edc0b43f28028269c43be4dfa2a1e5bba0dc8a73b689b1c::state::State>(0xd6dfe75ab0586a023edc0b43f28028269c43be4dfa2a1e5bba0dc8a73b689b1c::state::new(arg0, arg1, arg2, arg3));
    }

    // decompiled from Move bytecode v6
}

