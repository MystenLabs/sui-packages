module 0xd58246ac847998e3da81a9438f7302459a417c1c9ad250fd19a933039cdba453::elonmusk {
    struct ELONMUSK has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELONMUSK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELONMUSK>(arg0, 6, b"ElonMusk", b"Suielonmusk", b"\"Suielonmusk is a community-driven token on the SUI blockchain inspired by technological advancements and meme culture. The token aims to combine decentralized finance with social media trends.\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000109327_c8e1a08934.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELONMUSK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ELONMUSK>>(v1);
    }

    // decompiled from Move bytecode v6
}

