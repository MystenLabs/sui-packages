module 0x7d1ae42524974ba2c96ec1cf6d5bf2dec40bb870a040488ea4dd5eb2fbcd146b::suibubu {
    struct SUIBUBU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBUBU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBUBU>(arg0, 6, b"SUIBUBU", b"BUBU on SUI", x"6a75737420617065e280a620737569627562752121", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeib6t5o6yxr27oimr5xakjgky3hhfv5hmgr2tfxmq2lknez4c5x56u")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBUBU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIBUBU>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

