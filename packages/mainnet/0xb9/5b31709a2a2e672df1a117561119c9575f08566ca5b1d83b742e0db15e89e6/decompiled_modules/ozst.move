module 0xb95b31709a2a2e672df1a117561119c9575f08566ca5b1d83b742e0db15e89e6::ozst {
    struct OZST has drop {
        dummy_field: bool,
    }

    fun init(arg0: OZST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OZST>(arg0, 6, b"OZST", b"OSTEIN", b"Epstein Approved", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeigpxpezfzkeryvcxggbmgfekeloysxka7tj4cz4eujgrb3swfo55e")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OZST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<OZST>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

