module 0x439227ffb9ddd0b175a7b9b5c428c985b5c05e3cf9c0688d6e6e73fa78c4a00c::kdf {
    struct KDF has drop {
        dummy_field: bool,
    }

    fun init(arg0: KDF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KDF>(arg0, 6, b"KDF", b"sdfsdfsd", b"sdfsdfsdsdfsdfsdsdfsdfsd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicr3vmvte3fso3em65fsfra2fvzl4a7x3boabz63uluh3tgyhb6ve")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KDF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<KDF>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

