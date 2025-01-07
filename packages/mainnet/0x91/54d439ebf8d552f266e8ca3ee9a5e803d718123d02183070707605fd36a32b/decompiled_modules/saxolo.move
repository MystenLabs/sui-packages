module 0x9154d439ebf8d552f266e8ca3ee9a5e803d718123d02183070707605fd36a32b::saxolo {
    struct SAXOLO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAXOLO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAXOLO>(arg0, 6, b"SAXOLO", b"SUI Axolotl", b"sui meme coin with a strong vision", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000022061_18255492b7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAXOLO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAXOLO>>(v1);
    }

    // decompiled from Move bytecode v6
}

