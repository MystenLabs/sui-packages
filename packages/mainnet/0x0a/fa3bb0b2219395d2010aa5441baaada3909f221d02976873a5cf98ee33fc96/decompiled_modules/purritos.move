module 0xafa3bb0b2219395d2010aa5441baaada3909f221d02976873a5cf98ee33fc96::purritos {
    struct PURRITOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PURRITOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PURRITOS>(arg0, 6, b"PURRITOS", b"PURRITOS CAT", b"THE MOST MEOWABLE CAT ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeighffnoycj2m7se3marzjz7pbyulpwblqr652zhkzqe2helhodf4y")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PURRITOS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PURRITOS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

