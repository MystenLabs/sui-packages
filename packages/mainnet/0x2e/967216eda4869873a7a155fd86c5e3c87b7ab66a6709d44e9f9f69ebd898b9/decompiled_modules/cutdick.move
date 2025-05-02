module 0x2e967216eda4869873a7a155fd86c5e3c87b7ab66a6709d44e9f9f69ebd898b9::cutdick {
    struct CUTDICK has drop {
        dummy_field: bool,
    }

    fun init(arg0: CUTDICK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CUTDICK>(arg0, 6, b"Cutdick", b"Cutdickman", b"This is token comes Real memes", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeib2l5ixuz2vmli6ogwrqf5ghw6i6g52b4vpe4rmjzu6l3y4lgmrgq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CUTDICK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CUTDICK>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

