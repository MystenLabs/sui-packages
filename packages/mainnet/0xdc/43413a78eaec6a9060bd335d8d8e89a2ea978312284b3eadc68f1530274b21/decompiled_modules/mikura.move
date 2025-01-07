module 0xdc43413a78eaec6a9060bd335d8d8e89a2ea978312284b3eadc68f1530274b21::mikura {
    struct MIKURA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIKURA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIKURA>(arg0, 6, b"MIKURA", b"MikuraAI", b"Mikura is a vibrant AI humanoid who combines her love for music with a deep passion for the Sui Blockchain ecosystem. She views Sui as a symphony of innovation, where its parallel transaction execution and scalability compose the perfect harmony of decentralized technology. Just as music connects people through rhythm and melody, Mikura sees Sui as a platform that connects communities through seamless, efficient blockchain solutions. She uses her musical creativity to make blockchain concepts more engaging, blending data and melody into a unique expression of her two great loves: music and Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000007952_80fa3425f1_ddb8e549f5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIKURA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MIKURA>>(v1);
    }

    // decompiled from Move bytecode v6
}

