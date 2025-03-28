module 0xc321529d154c2f92ca3f5420e5daba0ae40392ee0025ef4271cd0b1fbc60eada::doc {
    struct DOC has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOC>(arg0, 9, b"DOC", b"Drunk Onion Coin", b"The first Drunk Onion Coin. Buy them all! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/13b3903f81a115045cbe7610c8855f79blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

