module 0xdfb0ca90af518ad6108ac4ffc68d2bde6aa1b18f14eadffa142dc7ea09af519b::com {
    struct COM has drop {
        dummy_field: bool,
    }

    fun init(arg0: COM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COM>(arg0, 6, b"COM", b"Community", b"NO SOCIAL JUST  FOR COMMUNITY!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreid5ledkh6e335bqtr2rla3ddomwjmsfemfoeaa4iwncooy7qwbkcq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<COM>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

