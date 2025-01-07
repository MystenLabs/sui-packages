module 0x9b9fa564f62a00145522d63259f427786986b48b3b04279b0812eeb256c9f1c::csg {
    struct CSG has drop {
        dummy_field: bool,
    }

    fun init(arg0: CSG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CSG>(arg0, 6, b"CSG", b"CHILLSQUIDGAME", b"Imagine Squid Game, but instead of fighting for survival, the players are chilling on bean bags, cracking jokes, and competing in games like Who can nap the longest? Chill Squid Game is all about fun, laughter, and taking life less seriously. Grab your slippersit's time to chill!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241128_193859_484_6f59c7e9df.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CSG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CSG>>(v1);
    }

    // decompiled from Move bytecode v6
}

