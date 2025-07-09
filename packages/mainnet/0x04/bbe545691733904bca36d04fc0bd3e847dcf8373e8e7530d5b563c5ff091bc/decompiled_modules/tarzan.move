module 0x4bbe545691733904bca36d04fc0bd3e847dcf8373e8e7530d5b563c5ff091bc::tarzan {
    struct TARZAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TARZAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TARZAN>(arg0, 6, b"TARZAN", b"Tarzan On Sui", b"Blue $TARZAN, born from Tarzan cartoons, swings with meme magic on Sui fun, wild, and ready to rule the crypto jungle!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreib4ryj3zsl7yendbynnnfhyq2hzauh56vnce6ylxenv5jfqiy27gq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TARZAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TARZAN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

