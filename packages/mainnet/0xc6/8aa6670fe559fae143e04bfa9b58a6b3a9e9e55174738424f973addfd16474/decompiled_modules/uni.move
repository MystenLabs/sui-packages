module 0xc68aa6670fe559fae143e04bfa9b58a6b3a9e9e55174738424f973addfd16474::uni {
    struct UNI has drop {
        dummy_field: bool,
    }

    fun init(arg0: UNI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UNI>(arg0, 6, b"UNI", b"Uniswap", b"Uniswap meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://akasui-statics.sgp1.cdn.digitaloceanspaces.com/images/b9ad7f55-5f67-4c08-814e-e0dd1005731a.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<UNI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UNI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

