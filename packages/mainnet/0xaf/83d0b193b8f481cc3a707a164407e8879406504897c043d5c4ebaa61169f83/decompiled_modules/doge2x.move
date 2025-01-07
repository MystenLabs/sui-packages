module 0xaf83d0b193b8f481cc3a707a164407e8879406504897c043d5c4ebaa61169f83::doge2x {
    struct DOGE2X has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGE2X, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGE2X>(arg0, 6, b"DOGE2X", b"DOGE2X MEME COIN", b"$DOGE2X IS THE FASTEST DOG IN THE WORLD. IT IS A 2X GENERATION DOG WITH SHINY BLACK FUR, A STRONG AND MUSCULAR BODY, AND BRIGHT, INTELLIGENT EYES. TO LEARN MORE ABOUT $DOGE2X, PLEASE VISIT THE PROJECT'S WEBSITE AND DON'T FORGET TO JOIN THE TELEGRAM CHANNEL, X, FOR THE LATEST UPDATES ON THE PROJECT.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/doge2xcoin8_bb31391a95.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGE2X>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGE2X>>(v1);
    }

    // decompiled from Move bytecode v6
}

