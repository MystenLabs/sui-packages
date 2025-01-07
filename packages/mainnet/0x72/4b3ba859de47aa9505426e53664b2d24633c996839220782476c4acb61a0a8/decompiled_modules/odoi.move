module 0x724b3ba859de47aa9505426e53664b2d24633c996839220782476c4acb61a0a8::odoi {
    struct ODOI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ODOI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ODOI>(arg0, 6, b"ODOI", b"Sui Odoi", b"ODOI - A cute and adorable dog who sails the seas of the sui network, with his cleverness and intelligence will conquer the pirates", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000001826_a5ff9621f7.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ODOI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ODOI>>(v1);
    }

    // decompiled from Move bytecode v6
}

