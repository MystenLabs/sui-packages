module 0xd9466b88893a1ab17947137bd7493d9f421ef0e5a2ec7965e64dc628a3058ea::yramid {
    struct YRAMID has drop {
        dummy_field: bool,
    }

    fun init(arg0: YRAMID, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YRAMID>(arg0, 6, b"YRAMID", b"Sui Yramid", b"YRAMID is the pufferfish of the meme coin world, bringing fun and charm. Puffi has the cool factor AND unique style.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeic5bso6s64dw6h4brswgplxgxohrsawew6mz2njz46fuxmkjwpnti")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YRAMID>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<YRAMID>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

