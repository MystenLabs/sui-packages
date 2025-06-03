module 0x88e35200e11754a01e8652dd850008272c4241fe174da085a1d49eaa4750c352::suim {
    struct SUIM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIM>(arg0, 6, b"SUIM", b"Sui MERGE", b"The ultimate coin-merging minigame built for the Sui community. Reach high scores and get airdrops!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiglvywdzrqnxkzynyzbmbrfo3jfkhtm5najde7xaukez2joo7rjem")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIM>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

