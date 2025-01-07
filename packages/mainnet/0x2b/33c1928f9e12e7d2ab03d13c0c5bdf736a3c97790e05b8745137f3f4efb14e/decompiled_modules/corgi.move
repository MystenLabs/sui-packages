module 0x2b33c1928f9e12e7d2ab03d13c0c5bdf736a3c97790e05b8745137f3f4efb14e::corgi {
    struct CORGI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CORGI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CORGI>(arg0, 6, b"CORGI", b"Corgi Coin", b"Corgis are such delightful little dogs! With their short legs and big personalities, theyre known for being friendly, intelligent, and a bit mischievous. Do you have a corgi, or are you thinking about getting one?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/corgi_702fc85a27.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CORGI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CORGI>>(v1);
    }

    // decompiled from Move bytecode v6
}

