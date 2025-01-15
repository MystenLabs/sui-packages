module 0x5ab7dfbe8928c8f6b40a5d69db52e8816b7984b19c1f2a0b60155c7643c9b1c6::isaacnewton {
    struct ISAACNEWTON has drop {
        dummy_field: bool,
    }

    fun init(arg0: ISAACNEWTON, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<ISAACNEWTON>(arg0, 6, b"ISAACNEWTON", b"Isaac newton by SuiAI", x"4973616163204e6577746f6e2028313634332d313732372920666f6920756d206369656e746973746120696e676cc3aa732c20636f6e736964657261646f20756d20646f73206d61696f7265732064612068697374c3b37269612e20456c6520c3a920636f6e68656369646f20706f72207375617320636f6e747269627569c3a7c3b56573207061726120612066c3ad736963612c206d6174656dc3a1746963612c20617374726f6e6f6d6961206520c3b370746963612e20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_6814_57833962bf.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ISAACNEWTON>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ISAACNEWTON>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

