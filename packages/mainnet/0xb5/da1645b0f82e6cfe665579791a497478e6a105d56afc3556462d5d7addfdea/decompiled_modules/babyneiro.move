module 0xb5da1645b0f82e6cfe665579791a497478e6a105d56afc3556462d5d7addfdea::babyneiro {
    struct BABYNEIRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYNEIRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYNEIRO>(arg0, 6, b"BABYNEIRO", b"SUI BABY NEIRO", b"\"Babyneiro\" is a new meme coin featuring a bold and fearless Shiba Inu-like character dressed as a superhero. With a lightning-charged blue cape and glowing paws ready for action, Babyneiro embodies the playful and energetic spirit of meme coins.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/babyniero_3fca672d88.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYNEIRO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BABYNEIRO>>(v1);
    }

    // decompiled from Move bytecode v6
}

