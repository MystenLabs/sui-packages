module 0x98b65b900aefe24576549924c7c458b8330da2a6506d6d21fe433ee066456384::shd {
    struct SHD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHD>(arg0, 6, b"SHD", b"Sui Hero Dog", b"The first-ever singing superhero dog flying high on the Sui blockchain! With a voice that can shatter scams and a cape made of pure meme magic, SHD is here to protect your portfolio and drop beats that save the chain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1749531075367.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

