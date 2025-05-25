module 0xa0d2e64cd92eacdb689861c31ba89006d9e21a1bc689e4c57afa3091a45da418::ozi {
    struct OZI has drop {
        dummy_field: bool,
    }

    fun init(arg0: OZI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OZI>(arg0, 6, b"OZI", b"Ozi The Turtle", b"$OZI - A turtle on sui is trying to climb up step by step", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000073810_1ceff5997d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OZI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OZI>>(v1);
    }

    // decompiled from Move bytecode v6
}

