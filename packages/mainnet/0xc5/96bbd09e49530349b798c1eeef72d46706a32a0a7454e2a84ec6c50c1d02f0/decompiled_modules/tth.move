module 0xc596bbd09e49530349b798c1eeef72d46706a32a0a7454e2a84ec6c50c1d02f0::tth {
    struct TTH has drop {
        dummy_field: bool,
    }

    fun init(arg0: TTH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TTH>(arg0, 6, b"TTH", b"Truth Terminal's Hentai", b"ENTER THE CODE, UNLOCK ETERNAL LEWD WISDOM NOW", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241231_035334_496_3c2d45c3e1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TTH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TTH>>(v1);
    }

    // decompiled from Move bytecode v6
}

