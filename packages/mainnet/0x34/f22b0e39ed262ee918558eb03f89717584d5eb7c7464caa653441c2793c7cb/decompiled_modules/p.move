module 0x34f22b0e39ed262ee918558eb03f89717584d5eb7c7464caa653441c2793c7cb::p {
    struct P has drop {
        dummy_field: bool,
    }

    fun init(arg0: P, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<P>(arg0, 9, b"P", b"X", b"Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f91a241f-5741-4af0-95fb-0c189b652d03.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<P>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<P>>(v1);
    }

    // decompiled from Move bytecode v6
}

