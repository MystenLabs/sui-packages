module 0x90cc3ed0a81dec0f273f29117d494d0b2848c57f1b7b06dc6d194611f33a7a0b::doogle {
    struct DOOGLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOOGLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOOGLE>(arg0, 6, b"DOOGLE", b"D O O G L E", b"In the year 2018, Matt Furie, the creator of the infamous Pepe the Frog meme, made a bold decision. He decided to bring a new character to life - Doogle, his first ever dog character. Doogle was a lovable, goofy dog with a big heart and a penchant for getting into silly situations.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_20_22_27_47_f0e55a9899.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOOGLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOOGLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

