module 0x58a3cedb4a9db031a12d62ec20127dca2da7629e601f30fc58b9f824a37236a8::dnigga {
    struct DNIGGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: DNIGGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DNIGGA>(arg0, 6, b"DNIGGA", b"DOG NIGGA", b"Dog nigga", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1200x1200bf_60_6a84aaaa8a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DNIGGA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DNIGGA>>(v1);
    }

    // decompiled from Move bytecode v6
}

