module 0x9da396b48989871f46f17e1edee9bc5c7bd45226ece539e8872691d98cda9d3f::akita {
    struct AKITA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AKITA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AKITA>(arg0, 6, b"AKITA", b"AKITA on MOONBAGS", b"AKITA on MOONBAGS is Ticker!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://beige-abstract-pig-256.mypinata.cloud/ipfs/bafkreihafiuyxbupmuezxrvc7juhgqcfneux3zdybajuyv25jm6skgkck4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AKITA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AKITA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

