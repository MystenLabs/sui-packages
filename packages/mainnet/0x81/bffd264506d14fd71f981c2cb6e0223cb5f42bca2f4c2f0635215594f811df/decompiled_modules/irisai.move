module 0x81bffd264506d14fd71f981c2cb6e0223cb5f42bca2f4c2f0635215594f811df::irisai {
    struct IRISAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: IRISAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IRISAI>(arg0, 6, b"IRISAI", b"IRIS AI", b"Interactive Recursive Imagination System Gallery on Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibtwp5c3m44n4mofojmfezkvxxvklwa7uulfbfpbxdhngru5pqfy4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IRISAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<IRISAI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

