module 0xbfecfbef3e4a7895cb20b5349c8802bec1a11f5e666e7201b0372e132daa9d44::brott {
    struct BROTT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BROTT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BROTT>(arg0, 6, b"BROTT", b"Brott", b"BROTT the memecoin that arrives as the \"distant cousin\" of Brett, aimed at bringing joy and innovation to the crypto landscape. Brott is more than just a token; it symbolizes a vibrant community filled with passion, where humor and creativity intersect.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241102_115935_d9b1b81f83.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BROTT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BROTT>>(v1);
    }

    // decompiled from Move bytecode v6
}

