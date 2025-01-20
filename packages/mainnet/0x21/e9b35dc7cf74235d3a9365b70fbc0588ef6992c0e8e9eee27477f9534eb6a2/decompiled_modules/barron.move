module 0x21e9b35dc7cf74235d3a9365b70fbc0588ef6992c0e8e9eee27477f9534eb6a2::barron {
    struct BARRON has drop {
        dummy_field: bool,
    }

    fun init(arg0: BARRON, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<BARRON>(arg0, 6, b"BARRON", b"BARRON TRUMP by SuiAI", b"Imagine a digital coin with Barron Trump's face on it, styled like a classic coin but with a modern, meme-like twist. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/BARRON_682853feda.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BARRON>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BARRON>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

