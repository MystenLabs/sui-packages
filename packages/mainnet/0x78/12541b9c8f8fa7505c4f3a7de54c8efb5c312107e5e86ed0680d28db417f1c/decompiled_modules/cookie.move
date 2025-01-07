module 0x7812541b9c8f8fa7505c4f3a7de54c8efb5c312107e5e86ed0680d28db417f1c::cookie {
    struct COOKIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: COOKIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COOKIE>(arg0, 6, b"COOKIE", b"Sui Monster", b"t.me/Cookieonsui ; suimonster.net ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/22222222_d0e9f80e2d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COOKIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COOKIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

