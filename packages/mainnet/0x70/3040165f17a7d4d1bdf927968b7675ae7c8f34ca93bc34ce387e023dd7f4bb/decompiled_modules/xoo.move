module 0x703040165f17a7d4d1bdf927968b7675ae7c8f34ca93bc34ce387e023dd7f4bb::xoo {
    struct XOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: XOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XOO>(arg0, 6, b"XOO", b"XOO ON SUI", b"The stitchy toy for the community powered by the holders.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeidtrnwbo3iayidllvhbzpwrh5s33avtr4rg5bqldsifdm4b6hrg5m")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XOO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<XOO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

