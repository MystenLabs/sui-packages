module 0x300c2da8074199249cf0b5c0d11a4b8b7359aeb240a68b0feb01df222af680ae::grl {
    struct GRL has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRL>(arg0, 9, b"GRL", b"the girl", b"Launch the CAT Memecoin, a purrfectly amusing and engaging cryptocurrency inspired by our feline friends", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/06870743-5905-4007-b54b-ad26dffdd3a4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GRL>>(v1);
    }

    // decompiled from Move bytecode v6
}

