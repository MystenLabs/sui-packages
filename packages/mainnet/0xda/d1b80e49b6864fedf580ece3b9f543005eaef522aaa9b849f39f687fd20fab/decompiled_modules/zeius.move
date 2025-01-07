module 0xdad1b80e49b6864fedf580ece3b9f543005eaef522aaa9b849f39f687fd20fab::zeius {
    struct ZEIUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZEIUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZEIUS>(arg0, 6, b"ZEIUS", b"Zeius", b"Unleash the thunder of Zeius, where every meme is a strike of lightning, and every community member is a hero in the making. Step into the world of Zeius and let the fun begin!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000030800_f2918c4991.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZEIUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZEIUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

