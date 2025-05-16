module 0x612a2d16c1ec5e468885cbf8b855d6c2b3876c02842e669ab3afa9a425ca0e23::glork {
    struct GLORK has drop {
        dummy_field: bool,
    }

    fun init(arg0: GLORK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GLORK>(arg0, 6, b"GLORK", b"Glorkcoin", b"From a distant galaxy, GLORK has arrived on Earth with one mission: to take over the blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreievtqozplwoec7rewmhyshxa7xjisougp4p4weuikc5x22ei5d5ku")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GLORK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GLORK>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

