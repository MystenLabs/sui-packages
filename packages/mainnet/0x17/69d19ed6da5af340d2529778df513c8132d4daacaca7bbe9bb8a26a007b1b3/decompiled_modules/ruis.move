module 0x1769d19ed6da5af340d2529778df513c8132d4daacaca7bbe9bb8a26a007b1b3::ruis {
    struct RUIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: RUIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RUIS>(arg0, 6, b"RUIS", b"RUIS BLUE", b"Introducing Ruis Coin, inspired by the swift and pure spirit of Ruis the blue bird, now soaring on the Sui network!  Join the flight to fun and reliability in the world of meme coins!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/rio_png_9_1bf055b95f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RUIS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RUIS>>(v1);
    }

    // decompiled from Move bytecode v6
}

