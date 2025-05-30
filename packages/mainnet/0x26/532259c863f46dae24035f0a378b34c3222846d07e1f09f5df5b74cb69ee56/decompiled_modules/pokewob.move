module 0x26532259c863f46dae24035f0a378b34c3222846d07e1f09f5df5b74cb69ee56::pokewob {
    struct POKEWOB has drop {
        dummy_field: bool,
    }

    fun init(arg0: POKEWOB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POKEWOB>(arg0, 6, b"POKEWOB", b"WOBBUFFET", b"Join the wobble. Reflect the chaos. Counter to the moon.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihqadfduqprsgqt5spnggvmax4zuup3z5x2bf7glwywex6pcydxr4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POKEWOB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<POKEWOB>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

