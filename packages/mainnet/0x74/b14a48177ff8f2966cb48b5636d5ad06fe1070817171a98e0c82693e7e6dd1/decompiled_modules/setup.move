module 0x74b14a48177ff8f2966cb48b5636d5ad06fe1070817171a98e0c82693e7e6dd1::setup {
    public entry fun create_state(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_share_object<0x74b14a48177ff8f2966cb48b5636d5ad06fe1070817171a98e0c82693e7e6dd1::state::State>(0x74b14a48177ff8f2966cb48b5636d5ad06fe1070817171a98e0c82693e7e6dd1::state::new(0x2::tx_context::sender(arg1), arg0, @0xaeab97f96cf9877fee2883315d459552b2b921edc16d7ceac6eab944dd88919c, @0xc57508ee0d4595e5a8728974a4a93a787d38f339757230d441e895422c07aba9, arg1));
    }

    // decompiled from Move bytecode v6
}

