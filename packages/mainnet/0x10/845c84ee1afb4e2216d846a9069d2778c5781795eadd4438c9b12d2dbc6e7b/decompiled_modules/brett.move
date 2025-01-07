module 0x10845c84ee1afb4e2216d846a9069d2778c5781795eadd4438c9b12d2dbc6e7b::brett {
    struct BRETT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRETT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRETT>(arg0, 6, b"BRETT", b"Je SUI BRETT", x"4a65207375697320436861726c6965203f20746861742773206e6f7468696e67202e2e2e204a65205355492042524554542021200a0a4252455454204f4e205355492c20434f4f4c45522c204849474845522c2046414e4349455221200a0a4c45542753204655434b494e4720474f2021", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2675b790054a913dc6975fdf78828fca_6c7cc57211.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRETT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BRETT>>(v1);
    }

    // decompiled from Move bytecode v6
}

