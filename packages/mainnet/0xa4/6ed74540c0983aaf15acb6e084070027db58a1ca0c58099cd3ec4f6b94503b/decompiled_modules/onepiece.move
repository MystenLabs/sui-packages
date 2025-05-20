module 0xa46ed74540c0983aaf15acb6e084070027db58a1ca0c58099cd3ec4f6b94503b::onepiece {
    struct ONEPIECE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ONEPIECE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ONEPIECE>(arg0, 6, b"ONEPIECE", b"One Piece Sui", b"OnePieceSUI brings your favorite pirate-themed characters to the blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreia32e2lgfxk5tg4eu6lq2ma4jgu2khsos2tqg7mngqwivwyeblame")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ONEPIECE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ONEPIECE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

