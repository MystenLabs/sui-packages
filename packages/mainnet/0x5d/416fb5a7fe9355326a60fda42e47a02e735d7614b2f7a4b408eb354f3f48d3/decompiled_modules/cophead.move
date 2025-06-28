module 0x5d416fb5a7fe9355326a60fda42e47a02e735d7614b2f7a4b408eb354f3f48d3::cophead {
    struct COPHEAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: COPHEAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COPHEAD>(arg0, 6, b"COPHEAD", b"Sui Cophead", b"COPHEAD The liltle animals", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeih7icpmy2qemdlvsa6oy6djd4bjhek6r5krkqbxvq6n5q4grhx4fq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COPHEAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<COPHEAD>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

