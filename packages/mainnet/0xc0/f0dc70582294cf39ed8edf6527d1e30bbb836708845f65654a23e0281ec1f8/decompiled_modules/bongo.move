module 0xc0f0dc70582294cf39ed8edf6527d1e30bbb836708845f65654a23e0281ec1f8::bongo {
    struct BONGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BONGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BONGO>(arg0, 6, b"BONGO", b"THE BONGO CAT", b"Bongos don't stop", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/BONGO_5b5bf3a08c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BONGO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BONGO>>(v1);
    }

    // decompiled from Move bytecode v6
}

