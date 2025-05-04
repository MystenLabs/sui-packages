module 0x5c8272fd0f349663905e8f78d81615059cad11e3ae6871ef1fa3e9d2d449c0b8::rev {
    struct REV has drop {
        dummy_field: bool,
    }

    fun init(arg0: REV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REV>(arg0, 6, b"REV", b"REVERB", b"Welcome to our project!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiahf7wk54s2yjohqenisthsgmujsmnjtrgv3soenc2h3j7eyiez5e")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<REV>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

