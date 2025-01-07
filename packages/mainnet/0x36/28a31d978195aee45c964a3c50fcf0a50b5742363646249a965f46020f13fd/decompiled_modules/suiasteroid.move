module 0x3628a31d978195aee45c964a3c50fcf0a50b5742363646249a965f46020f13fd::suiasteroid {
    struct SUIASTEROID has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIASTEROID, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIASTEROID>(arg0, 6, b"SUIAsteroid", b"Asteroid", b"This lil' homie normally chills in the asteroid belt, minding its own business, but guess what? it rolled up to earth's crib, got pulled in by gravity. its not here for long tho, just a quick vacay  gonna orbit around us for 2 months, then its off chasing the sun again.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/11_6cf665f8e6.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIASTEROID>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIASTEROID>>(v1);
    }

    // decompiled from Move bytecode v6
}

