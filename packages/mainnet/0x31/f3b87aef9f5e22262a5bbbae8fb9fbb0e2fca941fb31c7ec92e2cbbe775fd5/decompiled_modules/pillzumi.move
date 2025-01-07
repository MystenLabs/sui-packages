module 0x31f3b87aef9f5e22262a5bbbae8fb9fbb0e2fca941fb31c7ec92e2cbbe775fd5::pillzumi {
    struct PILLZUMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PILLZUMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PILLZUMI>(arg0, 6, b"PILLZUMI", b"CHILL PILL ZUMI", b"Were the Chill Pillzumi, a group of laid-back pills who know how to keep things cool. Whether were lounging in the chaos of the pharmacy or just vibing with our shades on, were all about staying calm and collected. Red Pill brings the confidence, Blue Pill brings the chill, and together, we show you how to relax, shill, and live your best, unbothered life.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241202_184259_779_378b6b92aa.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PILLZUMI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PILLZUMI>>(v1);
    }

    // decompiled from Move bytecode v6
}

