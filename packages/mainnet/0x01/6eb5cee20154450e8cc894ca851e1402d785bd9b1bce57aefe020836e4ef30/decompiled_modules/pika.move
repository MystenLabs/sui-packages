module 0x16eb5cee20154450e8cc894ca851e1402d785bd9b1bce57aefe020836e4ef30::pika {
    struct PIKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIKA>(arg0, 6, b"PIKA", b"Piksasui", b"PikaSui is a community-driven meme token that combines the playful spirit of internet culture with the innovative capabilities of the SUI Blockchain. Our mission is to create a fun and engaging ecosystem where memes and crypto enthusiasts unite.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731011702988.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PIKA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIKA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

