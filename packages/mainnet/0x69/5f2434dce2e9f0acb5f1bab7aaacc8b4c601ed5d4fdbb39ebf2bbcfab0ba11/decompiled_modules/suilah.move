module 0x695f2434dce2e9f0acb5f1bab7aaacc8b4c601ed5d4fdbb39ebf2bbcfab0ba11::suilah {
    struct SUILAH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUILAH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUILAH>(arg0, 6, b"SUILAH", b"Sui lah cat", b"This is SUILAH, your lucky charm and spell for good fortune. Just place it in your wallet and let the good luck flow!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeidmr4xqtjb4uxmkutnwhvtc5okc6pwet2pyywzekkhv27eezgbv6i")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUILAH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUILAH>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

