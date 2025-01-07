module 0x4ed1d789d2df3e8ee22498c9ab291d99ded9cafc118a385422f0d49f6ace3b21::gsps {
    struct GSPS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GSPS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GSPS>(arg0, 6, b"GSPS", b"Goatseus Pepesimus", b"The OG Sui Meme has merged with AI GOAT! Pow!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241202_074708_629_92550dbfaf.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GSPS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GSPS>>(v1);
    }

    // decompiled from Move bytecode v6
}

