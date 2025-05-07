module 0x1021d3a153ed5bfb994f393bea5cb58ce42502030d274b13f61a1b4c757159a2::boob {
    struct BOOB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOOB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOOB>(arg0, 6, b"BOOB", b"Boob Coin", b"BOOB is a community-driven memecoin built on the blazing-fast Sui blockchain. Fun, fast, and fearless BOOB is here to dominate meme culture with real community power.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeigjtccxjon4gflwfpzm5uvmf6uvzgv37ewknfuhyyn6xqvty3m6oy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOOB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BOOB>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

