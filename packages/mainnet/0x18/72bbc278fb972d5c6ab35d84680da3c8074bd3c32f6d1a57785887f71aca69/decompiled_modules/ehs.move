module 0x1872bbc278fb972d5c6ab35d84680da3c8074bd3c32f6d1a57785887f71aca69::ehs {
    struct EHS has drop {
        dummy_field: bool,
    }

    fun init(arg0: EHS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EHS>(arg0, 9, b"EHS", b"EHSENTIAL", b"EHSENTIAL is a revolutionary cryptocurrency designed to be essential for the future of finance. Our mission is to create a more inclusive, secure, and sustainable financial system, empowering individuals and communities worldwide.\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/201f8a84-052d-486c-a419-f287ccc5993c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EHS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EHS>>(v1);
    }

    // decompiled from Move bytecode v6
}

