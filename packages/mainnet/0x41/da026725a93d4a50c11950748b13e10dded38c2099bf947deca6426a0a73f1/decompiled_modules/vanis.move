module 0x41da026725a93d4a50c11950748b13e10dded38c2099bf947deca6426a0a73f1::vanis {
    struct VANIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: VANIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VANIS>(arg0, 6, b"VANIS", b"VANI ON SUI", b"$VANIS: Mine explosion, meme leader!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeib34q3x6alued4ou5tjqcujpmmfacyrp67lsfb6tik7vx7xcub2gu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VANIS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<VANIS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

