module 0xee96ae6b44c4e4a5920d85ad591478fde67f02b069705a1ac9492c37bba71424::suipi {
    struct SUIPI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPI>(arg0, 6, b"SUIPI", b"BLUEPINGUIN", x"2453554950492070656e6775696e206d6173636f740a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3541_f0927d5c57.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPI>>(v1);
    }

    // decompiled from Move bytecode v6
}

