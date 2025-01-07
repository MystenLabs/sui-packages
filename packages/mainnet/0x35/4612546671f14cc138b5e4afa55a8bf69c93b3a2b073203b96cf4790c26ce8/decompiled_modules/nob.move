module 0x354612546671f14cc138b5e4afa55a8bf69c93b3a2b073203b96cf4790c26ce8::nob {
    struct NOB has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOB>(arg0, 9, b"NOB", b"Noob", b"meme community for blastroyale gamers", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1ff368e1-6cec-42d4-bf31-96d93a6a9afe.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NOB>>(v1);
    }

    // decompiled from Move bytecode v6
}

