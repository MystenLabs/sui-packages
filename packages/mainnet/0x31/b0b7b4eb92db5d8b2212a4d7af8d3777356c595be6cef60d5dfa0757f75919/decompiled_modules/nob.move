module 0x31b0b7b4eb92db5d8b2212a4d7af8d3777356c595be6cef60d5dfa0757f75919::nob {
    struct NOB has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOB>(arg0, 9, b"NOB", b"Noob", b"meme community for blastroyale gamers", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4bc3030d-1bf0-460e-8462-b6fd02db4ba4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NOB>>(v1);
    }

    // decompiled from Move bytecode v6
}

