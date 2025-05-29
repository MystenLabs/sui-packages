module 0x1d0ae2d563940d1c1e8ce0ce8caf0aa8fce30e9b9f18f4ece3302a8b3d90d41e::tstws {
    struct TSTWS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TSTWS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TSTWS>(arg0, 6, b"TSTWS", b"TST WS Token", b"Test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeibxoqyrauo3po2milbl457qswcpzgdoju275mujji45tndpeej3ri")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TSTWS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TSTWS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

