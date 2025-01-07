module 0x3e0bacd2aea6964ff736ce6ab5d0c45084a636a0fad70aacd64a1907309f9fe::suepe {
    struct SUEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUEPE>(arg0, 6, b"Suepe", b"Pepe on Sui", b"The official Pepe on Sui by Pepe whale", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0801_b95571c99b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

