module 0x22394359e979c22914e0ae7dc997f5ff18f82bf1996ade5270638dc168e97bcd::cwifs {
    struct CWIFS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CWIFS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CWIFS>(arg0, 6, b"CWIFS", b"crabwifsmoke", b"Just a crab smoking.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibli53kf36u3ax7757awy7qpkfccjeiz4ku5nfde2xypczlueo3ny")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CWIFS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CWIFS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

