module 0x4ef01b8dfb64d41dced29275ecdd8f115491d8cca47920eed296ab4638135eaa::bosc {
    struct BOSC has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOSC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOSC>(arg0, 6, b"BOSC", b"Buying on sui coin", b"Boy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigypmdbguxtiwxzze6cqaj2zbfvg42cg4jmrt73pflaus2es3zu3m")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOSC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BOSC>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

