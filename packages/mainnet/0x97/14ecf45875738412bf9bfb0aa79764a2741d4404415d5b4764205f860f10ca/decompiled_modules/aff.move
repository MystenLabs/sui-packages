module 0x9714ecf45875738412bf9bfb0aa79764a2741d4404415d5b4764205f860f10ca::aff {
    struct AFF has drop {
        dummy_field: bool,
    }

    fun init(arg0: AFF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AFF>(arg0, 9, b"AFF", b"Anyaforger", b"The Anya meme token is inspired by the Anya Forger Family films, where the aim of this token is to become a rapidly growing meme token with strong community trust", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d700b164-09ae-44bc-951f-b7554f94d65b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AFF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AFF>>(v1);
    }

    // decompiled from Move bytecode v6
}

