module 0x66c50cef76d2cfda9004c8dfdc49e5f5408b6792b7ad284654b84e608bdac000::barron {
    struct BARRON has drop {
        dummy_field: bool,
    }

    fun init(arg0: BARRON, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<BARRON>(arg0, 6, b"BARRON", b"B.A.R.R.O.N by SuiAI", b"Imagine a digital coin with Barron Trump's face on it, styled like a classic coin but with a modern, meme-like twist.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/BARRON_a555d29b30.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BARRON>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BARRON>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

