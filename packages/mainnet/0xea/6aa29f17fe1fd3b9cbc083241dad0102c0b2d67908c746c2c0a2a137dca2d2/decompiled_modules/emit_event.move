module 0xea6aa29f17fe1fd3b9cbc083241dad0102c0b2d67908c746c2c0a2a137dca2d2::emit_event {
    struct Donut has copy, drop {
        amount: u64,
    }

    public entry fun do_emit(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Donut{amount: arg0};
        0x2::event::emit<Donut>(v0);
    }

    // decompiled from Move bytecode v6
}

