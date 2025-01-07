module 0x4fac0d885af51d1fc357bfa6b30de19bfe378a9cbc8628e6fc7170e1e9ef58e::slork {
    struct SLORK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLORK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLORK>(arg0, 6, b"SLORK", b"SLORK SUI", b"$SLORK is a Sui based meme coin featuring an image of a sleepy Sloth. It is designed to bring humor and liquidity to Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/lmx_D8m30_400x400_1ef790fc2f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLORK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SLORK>>(v1);
    }

    // decompiled from Move bytecode v6
}

