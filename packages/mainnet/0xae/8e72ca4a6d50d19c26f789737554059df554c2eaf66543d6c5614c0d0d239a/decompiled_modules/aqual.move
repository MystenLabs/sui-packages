module 0xae8e72ca4a6d50d19c26f789737554059df554c2eaf66543d6c5614c0d0d239a::aqual {
    struct AQUAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: AQUAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AQUAL>(arg0, 6, b"AQUAL", b"Aqua Lightyear on Sui", b"TO INFINITY AND BEYOND", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3684ooo_936ace7c36.JPEG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AQUAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AQUAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

