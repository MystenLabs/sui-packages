module 0x9dd6d9610f8960a1a7bd4b3e891d5a2eeb08ab9772b32ec111e56ae51679d657::suiard {
    struct SUIARD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIARD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIARD>(arg0, 6, b"SUIARD", b"CHARSUIARD", b"Tokenizing... SUInizingthe most legendary pokemon character and card - the Charizard .. err the Charsuiard!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigp6p7dcktyl6taoofx6vncsxdicxyny3uio37nupca46gnpunepm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIARD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIARD>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

