module 0x5e85371b27fa5c611071bf03ea9977847fa0b2e1423ba2be68032b5e1eb66908::memechu {
    struct MEMECHU has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEMECHU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEMECHU>(arg0, 6, b"MEMECHU", b"MEMECHU ON SUI", x"4d656d65202b2050696b61636875203d204d656d65636875200a0a43757465206368616f73206f6e20535549", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifwk5jexrq66arwrlonem7srnvobfjh542t6xlokdpe7hbqlx7624")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMECHU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MEMECHU>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

