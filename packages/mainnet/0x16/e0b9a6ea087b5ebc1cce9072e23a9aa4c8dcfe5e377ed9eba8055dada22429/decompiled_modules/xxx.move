module 0x16e0b9a6ea087b5ebc1cce9072e23a9aa4c8dcfe5e377ed9eba8055dada22429::xxx {
    struct XXX has drop {
        dummy_field: bool,
    }

    fun init(arg0: XXX, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<XXX>(arg0, 6, b"XXX", b"XCOIN", b"@GokuCryptoZ @MantaNetwork @suilaunchcoin $XXX + XCOIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"null")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<XXX>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XXX>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

