module 0xedf62448cfb9fef696218035611c65236852fe9002aec3db802fc0925b0d82f8::bushido {
    struct BUSHIDO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUSHIDO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUSHIDO>(arg0, 6, b"BUSHIDO", b"Bushido MEME", b"BushidoMeme is an innovative meme coin on the Sui blockchain, inspired by the samurai code of honor known as Bushido. This coin is not just a digital asset; it symbolizes the samurai values of loyalty, courage, integrity, and honor in the digital realm. BushidoMeme offers its users a fun and community-driven experience while connecting them to the rich heritage of Japanese samurai culture. Arm yourself with a digital katana and embrace the samurai spirit with BushidoMeme on this epic journey!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000099702_c8ca793978.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUSHIDO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUSHIDO>>(v1);
    }

    // decompiled from Move bytecode v6
}

