module 0x1b5bbbf5c7a52775bb705282599987d1e5a8a5b0b1c9afe789bbe3f8b95ea4b7::sume {
    struct SUME has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUME>(arg0, 6, b"SUME", b"SUI OF MEME", x"54686520666f6c6c6f77657273206f6620766172696f7573206d656d65732062656c6965766520696e2074686520486f6c79204269626c65206f6620576174657220616e642072656761726420697420617320746865697220646f637472696e650a2d2453554d45", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sui_booook_d22d848592.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUME>>(v1);
    }

    // decompiled from Move bytecode v6
}

