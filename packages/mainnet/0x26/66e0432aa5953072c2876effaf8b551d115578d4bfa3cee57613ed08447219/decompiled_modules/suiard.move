module 0x2666e0432aa5953072c2876effaf8b551d115578d4bfa3cee57613ed08447219::suiard {
    struct SUIARD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIARD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIARD>(arg0, 6, b"SUIARD", b"CHARSUIARD", b"Tokenizing .. SUInizing the most legendary Pokemon character and card .. the Charizard ..err.. the Charsuiard!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigp6p7dcktyl6taoofx6vncsxdicxyny3uio37nupca46gnpunepm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIARD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIARD>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

