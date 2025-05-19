module 0x9ed06a7229b044f2cfa96c442dc60520946ab0f8c2c5f9909b4a62e637d7174c::radie {
    struct RADIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: RADIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RADIE>(arg0, 6, b"RADIE", b"RADIE the RODENT", b"$RADIE the cute little rodent wandering in the lake looking for some food and adventure. Where will he go?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeigauf2zpmdtlriaca3tso56cn4p5dyrkl7gg756s7qahb7nuuxdr4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RADIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<RADIE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

