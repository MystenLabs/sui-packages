module 0x59a3dafe938291216a952eb211229a16b82e8c26013cceb5a7e757f2ac5fa3f2::boobsi {
    struct BOOBSI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOOBSI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOOBSI>(arg0, 6, b"BOOBSI", b"BOOBSI SUI", b"With BOOBSI just a touch is enough to feel...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreievzsgrq4qu2337heipd4cfac5zbgvw2ix6kprx5svo2hy2ckvgo4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOOBSI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BOOBSI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

