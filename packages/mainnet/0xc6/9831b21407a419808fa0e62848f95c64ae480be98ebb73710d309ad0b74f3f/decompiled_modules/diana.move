module 0xc69831b21407a419808fa0e62848f95c64ae480be98ebb73710d309ad0b74f3f::diana {
    struct DIANA has drop {
        dummy_field: bool,
    }

    fun init(arg0: DIANA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DIANA>(arg0, 9, b"DIANA", b"Princess Diana", b"The Solana-based Princess Diana meme coin is a playful cryptocurrency honoring the legacy of Princess Diana.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/PYrgjXw/generate-logo-meme-coin-for-princess-diana-without-text-only-image-logo.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DIANA>(&mut v2, 999000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DIANA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DIANA>>(v1);
    }

    // decompiled from Move bytecode v6
}

