module 0x1cf8a5458ec2f9e50a1f38fd0cc9f399a888eee52736cf03e7db256e770473b2::cookie {
    struct COOKIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: COOKIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COOKIE>(arg0, 6, b"COOKIE", b"CookieSui", b"Cookie is me lucky charm", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000001050_1b53b62ad3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COOKIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COOKIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

