module 0x779b43f9ba514d8e9a794db3e0c7dcf998ebf04bf5d7e98d9215b2ee7ca20301::setup {
    public entry fun create_state(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_share_object<0x779b43f9ba514d8e9a794db3e0c7dcf998ebf04bf5d7e98d9215b2ee7ca20301::state::State>(0x779b43f9ba514d8e9a794db3e0c7dcf998ebf04bf5d7e98d9215b2ee7ca20301::state::new(0x2::tx_context::sender(arg1), arg0, @0xaeab97f96cf9877fee2883315d459552b2b921edc16d7ceac6eab944dd88919c, @0xc57508ee0d4595e5a8728974a4a93a787d38f339757230d441e895422c07aba9, arg1));
    }

    // decompiled from Move bytecode v6
}

