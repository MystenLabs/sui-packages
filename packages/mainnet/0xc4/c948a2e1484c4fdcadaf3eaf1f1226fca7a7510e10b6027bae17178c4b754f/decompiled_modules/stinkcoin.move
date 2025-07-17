module 0xc4c948a2e1484c4fdcadaf3eaf1f1226fca7a7510e10b6027bae17178c4b754f::stinkcoin {
    struct STINKCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: STINKCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STINKCOIN>(arg0, 6, b"Stinkcoin", b"Stinkcoin on Sui", b"Stinkcoin on Sui No insiders, no cabal, just stink!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeib7xq35otw5syemo7ontaa26pf67iqxxzkccf3w5in7bhkbvoszle")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STINKCOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<STINKCOIN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

