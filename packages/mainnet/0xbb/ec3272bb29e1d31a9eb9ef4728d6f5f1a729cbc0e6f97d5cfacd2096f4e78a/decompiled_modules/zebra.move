module 0xbbec3272bb29e1d31a9eb9ef4728d6f5f1a729cbc0e6f97d5cfacd2096f4e78a::zebra {
    struct ZEBRA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZEBRA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZEBRA>(arg0, 6, b"ZEBRA", b"SUI ZEBRA", b"ZEBRA is the newest meme coin sensation on the Sui blockchain, inspired by the bold and wild energy of zebras. With its striking simplicity and community-driven approach, ZEBRA is here to stand out in the crypto jungle. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736609641243.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZEBRA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZEBRA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

