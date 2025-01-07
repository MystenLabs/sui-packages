module 0xbada9c8b48fc58cf8e392d4883bf1b3543bedf8333c496e5679ab9785e8a1b8d::hotdog {
    struct HOTDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOTDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOTDOG>(arg0, 6, b"HOTDOG", b"House of the Dog", b"The House Of The Dog, The newest & the next Hottest Meme Coin. Created & Directed by the Diamond Handed Drum Major himself, Scoop Dogg. Tired of all the shit coins out there today, Scoop Dogg decided to make his on Moonshot. Don't hesitate to fill your bags or you will be left behind.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1726686740337_c9c2bce82b74978a3e87079f2ce6e52b_483f952937.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOTDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOTDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

