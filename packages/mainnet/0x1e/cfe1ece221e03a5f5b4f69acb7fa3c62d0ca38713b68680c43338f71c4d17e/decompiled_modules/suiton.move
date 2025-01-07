module 0x1ecfe1ece221e03a5f5b4f69acb7fa3c62d0ca38713b68680c43338f71c4d17e::suiton {
    struct SUITON has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITON>(arg0, 6, b"SUITON", b"Suiton", b"Inspired by one of the classical ninjutsu in Naruto Shippuden, this meme coin on Sui connects anime enthusiasts worldwide, offering a unique space to interact, share, and engage within the crypto-powered anime community.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1734225729045.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUITON>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITON>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

