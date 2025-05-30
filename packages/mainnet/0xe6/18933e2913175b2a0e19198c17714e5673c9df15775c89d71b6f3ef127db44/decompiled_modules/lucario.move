module 0xe618933e2913175b2a0e19198c17714e5673c9df15775c89d71b6f3ef127db44::lucario {
    struct LUCARIO has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUCARIO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUCARIO>(arg0, 6, b"LUCARIO", b"Lucario Sui", b"Lucario on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiailgxx6zzfxfpyrsijotwl6p474bfxxeayzxr5u56lmabkexmm3e")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUCARIO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LUCARIO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

