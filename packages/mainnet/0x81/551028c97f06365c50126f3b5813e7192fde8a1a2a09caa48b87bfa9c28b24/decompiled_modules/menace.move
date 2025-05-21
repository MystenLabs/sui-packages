module 0x81551028c97f06365c50126f3b5813e7192fde8a1a2a09caa48b87bfa9c28b24::menace {
    struct MENACE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MENACE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MENACE>(arg0, 6, b"MENACE", b"Menace Penguin", b"Menace Penguin, Masked for a reason. He is planning the ultimate heist, and you are invited.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeihan4h5e4rprb6k7xm2vh5ctlnm2lgzf6wliq34fg6osmmo3z5mvm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MENACE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MENACE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

