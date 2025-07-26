module 0x84fb201db559027c525551ab493f30c6c51854ba069499694398404bc1802b5::suiney {
    struct SUINEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINEY>(arg0, 6, b"SUINEY", b"Sydney Suiney", b"Relaunch of the Official lifeguard of SUI Chain. The original Suiney token of sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibpqigal7vtum7ra2woyzqy55tc6atpm63oldles6lka37mqciqp4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINEY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUINEY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

