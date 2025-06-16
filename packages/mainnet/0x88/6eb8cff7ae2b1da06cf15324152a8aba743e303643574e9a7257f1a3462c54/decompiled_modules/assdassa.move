module 0x886eb8cff7ae2b1da06cf15324152a8aba743e303643574e9a7257f1a3462c54::assdassa {
    struct ASSDASSA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASSDASSA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASSDASSA>(arg0, 6, b"Assdassa", b"Asda", b"Hshdhdh", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeihdaahq4lv4xtemnf53x7g7msd4hbe5zzdsalblwk4qljir4f52ly")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASSDASSA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ASSDASSA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

