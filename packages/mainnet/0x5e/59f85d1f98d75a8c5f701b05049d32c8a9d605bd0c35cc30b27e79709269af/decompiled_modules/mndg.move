module 0x5e59f85d1f98d75a8c5f701b05049d32c8a9d605bd0c35cc30b27e79709269af::mndg {
    struct MNDG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MNDG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MNDG>(arg0, 6, b"MNDG", b"MoonDog", b"MoonDog (MNDG) is a meme token on the Sui blockchain that blends internet culture with community-driven fun. With a fixed supply and no central authority, it's built for memes, trading, and community engagement - no promises, just vibes.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibvcngo2stol7qjubck5iapj6fmsqtnn6moa2mbo2i6mzxzk3qm5i")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MNDG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MNDG>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

