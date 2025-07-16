module 0xdf08dccd8012056f97b19fdf8ad7f1f4f74e5443e2f18e3a6b63f97d3833011a::meme {
    struct MEME has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEME>(arg0, 6, b"MEME", b"banana cat", b"test dont buy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiclvl3e3bxfas756tin3nqnqibddsgq74mdwmds65kri43hq4kxri")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MEME>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

