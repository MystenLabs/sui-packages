module 0x2056d6594b2309e84e1d3b25f1fb98576f446523d06200911077a7e74fd0419d::bullio {
    struct BULLIO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BULLIO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BULLIO>(arg0, 6, b"BULLIO", b"The most bullish bull run mascot on the planet", b"The most bullish bull run mascot on the planet $BULLIO. Built on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeidb76vb5vtjdtcqominkuytscmaymfaw6nwfeaock54b32ytj3d5e")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BULLIO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BULLIO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

