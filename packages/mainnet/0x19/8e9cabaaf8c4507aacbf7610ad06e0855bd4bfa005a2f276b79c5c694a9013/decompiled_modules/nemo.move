module 0x198e9cabaaf8c4507aacbf7610ad06e0855bd4bfa005a2f276b79c5c694a9013::nemo {
    struct NEMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEMO>(arg0, 6, b"NEMO", b"NEMOS SUI", x"f09d9989f09d9980f09d9988f09d998af09d998e20f09d9984f09d998e20f09d98bef09d998af09d9988f09d9990f09d9989f09d9984f09d998ff09d999420f09d98bff09d998df09d9984f09d9991f09d9980f09d998920f09d998ff09d998af09d9986f09d9980f09d998920f09d98bcf09d9987f09d9988f09d998af09d998ef09d998f20f09d9990f09d998ef09d998020f09d9984f09d998920f09d98bef09d998af09d9988f09d9990f09d9989f09d9984f09d998ff09d999420f09d9981f09d998af09d998d20f09d998ff09d998df09d98bcf09d98bff09d998020f09d998af09d998920f09d998ef09d9990f09d998420f09d98bef09d9983f09d98bcf09d9984f09d9989", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiazgyhvtj52eiulbu2pxiotdk3rsoffwfqbk2ggk6og7ie342cixm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEMO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<NEMO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

