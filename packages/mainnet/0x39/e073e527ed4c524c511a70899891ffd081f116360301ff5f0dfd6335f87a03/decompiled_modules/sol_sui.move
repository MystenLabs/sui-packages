module 0x39e073e527ed4c524c511a70899891ffd081f116360301ff5f0dfd6335f87a03::sol_sui {
    struct SOL_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOL_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOL_SUI>(arg0, 9, b"solSUI", b"Solana Staked SUI", b"Solana Staked Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.tusky.io/files/b7a09c6b-27e5-45c6-a227-05b91bb6f537/data")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOL_SUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOL_SUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

