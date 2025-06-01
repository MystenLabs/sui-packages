module 0xfd78bbf9ef0e2b5a7d7f23aff640c23574a69d71de2dfb41d18448b093539e53::charmander {
    struct CHARMANDER has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHARMANDER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHARMANDER>(arg0, 6, b"CHARMANDER", b"CHARMANDER SUI", b"CharmSui is a fire-charged cryptocurrency on the SUI blockchain, sparking innovation and electrifying the crypto world!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidjfxk6cwmdzeohfygq6mjbykz7kpfo57kqtty2h2kpsfoxjkj5pe")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHARMANDER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CHARMANDER>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

