module 0x648300ef29ed50c983e0c2400b34c273f5de0c061b0c0d16cbe38caccdcf0dbb::pengu {
    struct PENGU has drop {
        dummy_field: bool,
    }

    fun init(arg0: PENGU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PENGU>(arg0, 6, b"Pengu", b"PENGUSUI", b"Welcome to PENGUSUI, the latest meme coin sensation soaring high on the SUI Blockchain! Inspired by the lovable penguin, PENGUSUI combines the playful spirit of memes with the innovation and speed of blockchain technology. With its unique charm and focus on building an inclusive community, PENGUSUI aims to bring fun, laughter, and value to the meme coin ecosystem.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pengu_6a16d0c49a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PENGU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PENGU>>(v1);
    }

    // decompiled from Move bytecode v6
}

