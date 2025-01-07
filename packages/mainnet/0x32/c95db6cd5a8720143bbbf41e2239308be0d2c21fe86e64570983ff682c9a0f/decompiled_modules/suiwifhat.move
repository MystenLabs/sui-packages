module 0x32c95db6cd5a8720143bbbf41e2239308be0d2c21fe86e64570983ff682c9a0f::suiwifhat {
    struct SUIWIFHAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIWIFHAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIWIFHAT>(arg0, 6, b"SUIWIFHAT", b"Sui Wif Hat", b"A classy coin with a signature hatstylish, mysterious, and always on top of its game.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Sui_Wif_Hat_44e35becc8.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIWIFHAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIWIFHAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

