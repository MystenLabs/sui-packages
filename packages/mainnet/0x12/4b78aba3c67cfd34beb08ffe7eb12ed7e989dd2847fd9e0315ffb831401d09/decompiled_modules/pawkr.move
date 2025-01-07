module 0x124b78aba3c67cfd34beb08ffe7eb12ed7e989dd2847fd9e0315ffb831401d09::pawkr {
    struct PAWKR has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAWKR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAWKR>(arg0, 6, b"Pawkr", b"Pawker Coin", b"n the wild world of crypto, why not bet on a little fun? Pawker Coin (PAWKR) captures the spirit of camaraderie and competition, just like dogs playing poker! This isnt just a meme; its a movement where laughter meets investment.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3334_ba50437d4c.JPG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAWKR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PAWKR>>(v1);
    }

    // decompiled from Move bytecode v6
}

