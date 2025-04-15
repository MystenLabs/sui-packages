module 0xa16a3e9ff325031c6d925a271d784f2252e7486a5991189f24c90d307d3de9bd::suibubu {
    struct SUIBUBU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBUBU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBUBU>(arg0, 6, b"SUIBUBU", b"SUI BUBU", b"Just ape ... suibubu!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeib6t5o6yxr27oimr5xakjgky3hhfv5hmgr2tfxmq2lknez4c5x56u")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBUBU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIBUBU>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

