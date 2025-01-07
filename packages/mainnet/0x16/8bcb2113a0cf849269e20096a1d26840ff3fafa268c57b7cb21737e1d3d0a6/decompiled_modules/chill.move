module 0x168bcb2113a0cf849269e20096a1d26840ff3fafa268c57b7cb21737e1d3d0a6::chill {
    struct CHILL has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHILL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHILL>(arg0, 6, b"Chill", b"Just a Chill Guy", b"Im just a chill Guy on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_4405_6a9940b5c2.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHILL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHILL>>(v1);
    }

    // decompiled from Move bytecode v6
}

