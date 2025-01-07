module 0xba79a25a5b03061d623b245398598756f5f3a08e542ce9ee5a413813a1321c1::mummy {
    struct MUMMY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUMMY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUMMY>(arg0, 6, b"Mummy", b"Mummy on Sui", b"Introducing Mummy, the latest cryptocurrency launching on the Sui blockchain! Mummy aims to revolutionize digital transactions with its fast, secure, and scalable infrastructure. Inspired by the ancient art of preservation, Mummy not only protects your assets but also fosters a vibrant community focused on sustainability and innovation. Join us on this exciting journey as we unwrap the future of finance and unlock new opportunities for users everywhere!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2024_10_31_17_45_24_3b88a040ad.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUMMY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MUMMY>>(v1);
    }

    // decompiled from Move bytecode v6
}

