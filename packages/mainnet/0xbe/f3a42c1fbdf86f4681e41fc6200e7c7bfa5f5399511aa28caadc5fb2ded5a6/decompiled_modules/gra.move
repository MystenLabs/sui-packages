module 0xbef3a42c1fbdf86f4681e41fc6200e7c7bfa5f5399511aa28caadc5fb2ded5a6::gra {
    struct GRA has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRA>(arg0, 9, b"GRA", b"Gra.Fun", b"Fair memes for fair fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c408f9fe-3635-46af-9357-f05aa8ab1612.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GRA>>(v1);
    }

    // decompiled from Move bytecode v6
}

