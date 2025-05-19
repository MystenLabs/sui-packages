module 0x6011263fd15787c33c134321ccb79ae9daaf2592cca5af3e4fec4974241c20fb::cheff {
    struct CHEFF has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHEFF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHEFF>(arg0, 6, b"CHEFF", b"Sui Cheff", b"Get Cooking on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreic5vipuxnhfxg6lihmzf2zo2lmjuwxnbeerli6h67an2irthkruua")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHEFF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CHEFF>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

