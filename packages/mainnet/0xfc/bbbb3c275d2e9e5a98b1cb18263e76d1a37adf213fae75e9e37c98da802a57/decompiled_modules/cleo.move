module 0xfcbbbb3c275d2e9e5a98b1cb18263e76d1a37adf213fae75e9e37c98da802a57::cleo {
    struct CLEO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CLEO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CLEO>(arg0, 6, b"CLEO", b"Cleo Patra", b"$Cleo Graceful and charismatic cat.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidaptxocvbl76zlhdaqeb32ojj4gnubzwjqgnookgorbq33kmhzhe")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLEO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CLEO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

