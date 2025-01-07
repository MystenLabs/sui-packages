module 0x63ef2a690ed7ce06b7a28deb6bf9df018e45a08f05e3222f37f57a07f20e6a5c::glf {
    struct GLF has drop {
        dummy_field: bool,
    }

    fun init(arg0: GLF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GLF>(arg0, 9, b"GLF", b"Green Leaf", b"The green Leaf Meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/465e832c-1f9e-4b4d-b9ab-7b7785d1e41a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GLF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GLF>>(v1);
    }

    // decompiled from Move bytecode v6
}

