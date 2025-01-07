module 0x9b7b91806a6a1ac1cb69e9f7026be1a8fe57f2e7add455472d487439d9f8af65::dogwifhat {
    struct DOGWIFHAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGWIFHAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGWIFHAT>(arg0, 6, b"Dogwifhat", b"SuiDogWifHat", b"Step into the meme-ified future with $SUIDOGWIF on the Sui blockchain! This playful coin merges the iconic Doge vibes with the sleek tech of Sui, featuring the legendary Dogwif Hat meme. Perfect for crypto enthusiasts who love a good laugh while exploring cutting-edge blockchain innovation. Embrace the fun and join the $SUIDOGWIF movement! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/dogwifhat_47caae09e7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGWIFHAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGWIFHAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

