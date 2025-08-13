module 0xdd42c7de81424c3b5342863fb30c2d3c93f0615c2c2856376b1cf86e2c4a3692::kappa {
    struct KAPPA has drop {
        dummy_field: bool,
    }

    fun init(arg0: KAPPA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KAPPA>(arg0, 6, b"KAPPA", b"Kappa Sui", b"A mythical meme + legendary platform on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiadjudtxk5byclqwzquuswc7uj6u5jcbpwahiszeud4ukxke436ee")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KAPPA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<KAPPA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

