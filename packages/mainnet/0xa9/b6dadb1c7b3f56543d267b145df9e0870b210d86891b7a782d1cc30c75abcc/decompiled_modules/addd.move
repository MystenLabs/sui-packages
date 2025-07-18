module 0xa9b6dadb1c7b3f56543d267b145df9e0870b210d86891b7a782d1cc30c75abcc::addd {
    struct ADDD has drop {
        dummy_field: bool,
    }

    fun init(arg0: ADDD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ADDD>(arg0, 6, b"ADDD", b"asd", b"sad", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeibb5rxircs2gkul26rbv2cdm5wyop2574dyszoord7qo5wp4kr3my")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ADDD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ADDD>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

