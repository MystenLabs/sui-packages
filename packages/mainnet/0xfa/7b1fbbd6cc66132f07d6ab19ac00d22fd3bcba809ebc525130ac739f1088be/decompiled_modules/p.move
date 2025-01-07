module 0xfa7b1fbbd6cc66132f07d6ab19ac00d22fd3bcba809ebc525130ac739f1088be::p {
    struct P has drop {
        dummy_field: bool,
    }

    fun init(arg0: P, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<P>(arg0, 9, b"P", b"Pix", x"4974e28099732061206d656d65", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fa7469ff-e54e-4a46-8438-b1a0959b249f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<P>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<P>>(v1);
    }

    // decompiled from Move bytecode v6
}

