module 0x437bb1e2a933f880ed858f767a31e93e3bd4ffeaae636e673521dd493d0badf8::dogcoin {
    struct DOGCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGCOIN>(arg0, 6, b"Dogcoin", b"DOGECOIN", b"Dogecoin on SUI. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000040038_80743edd49.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGCOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGCOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

