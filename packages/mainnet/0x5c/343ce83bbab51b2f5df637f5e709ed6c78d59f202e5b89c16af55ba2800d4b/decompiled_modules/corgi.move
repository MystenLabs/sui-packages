module 0x5c343ce83bbab51b2f5df637f5e709ed6c78d59f202e5b89c16af55ba2800d4b::corgi {
    struct CORGI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CORGI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CORGI>(arg0, 6, b"CORGI", b"Corgi Coin", b"Corgis are such delightful little dogs! With their short legs and big personalities, theyre known for being friendly, intelligent, and a bit mischievous. Do you have a corgi, or are you thinking about getting one?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/corgi_1203037e1d.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CORGI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CORGI>>(v1);
    }

    // decompiled from Move bytecode v6
}

