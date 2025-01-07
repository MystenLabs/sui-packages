module 0xa0fd7028c74d9e8715787f8732713a0a26773c44a28a6c9021f03b024bc6c7b8::jokosui {
    struct JOKOSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: JOKOSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JOKOSUI>(arg0, 6, b"JokoSui", b"Joko on Sui", b"A meme dedicated to the best president RI. Not only a meme. Make Indonesia grater", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000645132_005da6ba16.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JOKOSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JOKOSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

