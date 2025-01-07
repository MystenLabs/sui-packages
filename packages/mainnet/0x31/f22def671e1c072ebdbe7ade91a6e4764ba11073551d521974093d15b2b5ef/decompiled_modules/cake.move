module 0x31f22def671e1c072ebdbe7ade91a6e4764ba11073551d521974093d15b2b5ef::cake {
    struct CAKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAKE>(arg0, 9, b"CAKE", b"cream cake", b"FUN MEME COIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/90787700-15fa-4029-b787-ce969e2f6abd.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CAKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

