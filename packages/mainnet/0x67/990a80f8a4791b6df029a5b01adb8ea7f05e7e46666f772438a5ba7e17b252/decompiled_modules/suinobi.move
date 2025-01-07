module 0x67990a80f8a4791b6df029a5b01adb8ea7f05e7e46666f772438a5ba7e17b252::suinobi {
    struct SUINOBI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINOBI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINOBI>(arg0, 6, b"Suinobi", b"suinobi", b"Suinobi is the Shinobi of Sui Village. We are here to protect your valuable Sui from scammers. We offer 100% CTO, with no cabal and no jeet", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_10_16_13_542_bde2362e78.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINOBI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUINOBI>>(v1);
    }

    // decompiled from Move bytecode v6
}

