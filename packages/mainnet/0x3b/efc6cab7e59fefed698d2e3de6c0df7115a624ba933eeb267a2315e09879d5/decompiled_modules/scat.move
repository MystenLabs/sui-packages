module 0x3befc6cab7e59fefed698d2e3de6c0df7115a624ba933eeb267a2315e09879d5::scat {
    struct SCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCAT>(arg0, 6, b"SCat", b"SuiCat", b"SuiCat is a playful and lighthearted meme token on the Sui blockchain, featuring a fun and mischievous cat mascot. With its vibrant and quirky design, SuiCat aims to bring a sense of humor and community-driven excitement to the crypto world, making it a purr-fect addition to the Sui ecosystem.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000361_54cad88c90.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

