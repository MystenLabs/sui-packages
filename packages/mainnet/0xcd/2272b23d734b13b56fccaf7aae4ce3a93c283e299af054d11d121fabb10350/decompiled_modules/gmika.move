module 0xcd2272b23d734b13b56fccaf7aae4ce3a93c283e299af054d11d121fabb10350::gmika {
    struct GMIKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: GMIKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GMIKA>(arg0, 6, b"GMika", b"GMika Rabia", b"Your favorite girl next door is now on the Sui Network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241016_113733_198_bfe0d61b8c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GMIKA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GMIKA>>(v1);
    }

    // decompiled from Move bytecode v6
}

