module 0x97862b177cdae55f29711e5200280d85a25a4b6de63fb4d853d7cd8bfe15f3a1::go {
    struct GO has drop {
        dummy_field: bool,
    }

    fun init(arg0: GO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GO>(arg0, 9, b"Go", b"Goat", b"Goat Coin Meme The Biggest Gap in the Market.Last Warning to Market Leaders, We'll Pee on Everyone Soon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/50f01ca9013f977066fdc56cdde5da0dblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

