module 0xf2cbc60595b3a706c9275a03ea803370acf5c9702045447790348dc05945a960::cz4 {
    struct CZ4 has drop {
        dummy_field: bool,
    }

    fun init(arg0: CZ4, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CZ4>(arg0, 6, b"CZ4", b"CZ Free", b"CZ is Back", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/4_4a0b33ae47.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CZ4>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CZ4>>(v1);
    }

    // decompiled from Move bytecode v6
}

