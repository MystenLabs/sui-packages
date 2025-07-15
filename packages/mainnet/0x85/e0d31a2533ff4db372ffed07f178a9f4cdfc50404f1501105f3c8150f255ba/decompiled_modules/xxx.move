module 0x85e0d31a2533ff4db372ffed07f178a9f4cdfc50404f1501105f3c8150f255ba::xxx {
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

