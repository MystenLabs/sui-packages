module 0xcdb144bccbba66fe81fe81aafcc9e21487557b851986254147df35a6023674e::lbums {
    struct LBUMS has drop {
        dummy_field: bool,
    }

    fun init(arg0: LBUMS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LBUMS>(arg0, 6, b"LBums", b"LaydBums", b"BBuBumBums", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000653_09c84e46ff.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LBUMS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LBUMS>>(v1);
    }

    // decompiled from Move bytecode v6
}

