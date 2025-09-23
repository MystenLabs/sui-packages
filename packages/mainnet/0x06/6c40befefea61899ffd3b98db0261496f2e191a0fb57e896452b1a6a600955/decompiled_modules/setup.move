module 0x66c40befefea61899ffd3b98db0261496f2e191a0fb57e896452b1a6a600955::setup {
    struct SETUP has drop {
        dummy_field: bool,
    }

    public entry fun create_state(arg0: 0x2::package::UpgradeCap, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_share_object<0x66c40befefea61899ffd3b98db0261496f2e191a0fb57e896452b1a6a600955::state::State>(0x66c40befefea61899ffd3b98db0261496f2e191a0fb57e896452b1a6a600955::state::new(arg0, 0x2::tx_context::sender(arg1), @0xaeab97f96cf9877fee2883315d459552b2b921edc16d7ceac6eab944dd88919c, @0xc57508ee0d4595e5a8728974a4a93a787d38f339757230d441e895422c07aba9, arg1));
    }

    fun init(arg0: SETUP, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<SETUP>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

