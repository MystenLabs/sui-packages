module 0x5bbac9c2ea57211d67dad73811dd71a3753692d22c531bf3b31542e1a0aecd7::rose {
    struct ROSE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROSE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROSE>(arg0, 6, b"Rose", b"MissRose_BotSui", b"MissRose_BotSui is a mischievous, wild meme coin on the Sui blockchain, thriving on cheeky humor and playful, naughty jokes. Join her daring, rebellious community and have some fun!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1945_5824e96a33.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROSE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ROSE>>(v1);
    }

    // decompiled from Move bytecode v6
}

