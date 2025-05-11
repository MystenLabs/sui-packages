module 0x417452dd76a86b61118a6d11363a48326bf07a5fb11f2ef1664b75361e749639::suizard {
    struct SUIZARD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIZARD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIZARD>(arg0, 6, b"SUIZARD", b"Sui Charizard", b"CHAR!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeicgvsidwhytm6h3os7ykpffw5l27c5vzsswm5sbp5xt723sqwnrtq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIZARD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIZARD>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

