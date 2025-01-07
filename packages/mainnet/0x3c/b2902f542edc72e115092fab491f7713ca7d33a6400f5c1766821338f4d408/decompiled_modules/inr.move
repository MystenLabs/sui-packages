module 0x3cb2902f542edc72e115092fab491f7713ca7d33a6400f5c1766821338f4d408::inr {
    struct INR has drop {
        dummy_field: bool,
    }

    fun init(arg0: INR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<INR>(arg0, 9, b"INR", b"RUPEE", b"This token is an intro of Indian Meme token to Crypto World", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/80342323-c108-4b71-8e54-478f8a700071.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<INR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<INR>>(v1);
    }

    // decompiled from Move bytecode v6
}

