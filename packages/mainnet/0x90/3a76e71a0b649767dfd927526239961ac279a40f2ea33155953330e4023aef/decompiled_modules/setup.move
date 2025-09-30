module 0x903a76e71a0b649767dfd927526239961ac279a40f2ea33155953330e4023aef::setup {
    public entry fun create_state(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_share_object<0x903a76e71a0b649767dfd927526239961ac279a40f2ea33155953330e4023aef::state::State>(0x903a76e71a0b649767dfd927526239961ac279a40f2ea33155953330e4023aef::state::new(0x2::tx_context::sender(arg1), arg0, @0xaeab97f96cf9877fee2883315d459552b2b921edc16d7ceac6eab944dd88919c, @0xc57508ee0d4595e5a8728974a4a93a787d38f339757230d441e895422c07aba9, arg1));
    }

    // decompiled from Move bytecode v6
}

