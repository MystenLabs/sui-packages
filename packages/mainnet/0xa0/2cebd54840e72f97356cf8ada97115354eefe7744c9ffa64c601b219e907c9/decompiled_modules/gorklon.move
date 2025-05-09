module 0xa02cebd54840e72f97356cf8ada97115354eefe7744c9ffa64c601b219e907c9::gorklon {
    struct GORKLON has drop {
        dummy_field: bool,
    }

    fun init(arg0: GORKLON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GORKLON>(arg0, 6, b"Gorklon", b"gorklon rush", b"just a meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreib7q7cmkqj66mnfbzliilmzzcwx6wolylmx2kjlg5xncbbhqy6zvq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GORKLON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GORKLON>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

