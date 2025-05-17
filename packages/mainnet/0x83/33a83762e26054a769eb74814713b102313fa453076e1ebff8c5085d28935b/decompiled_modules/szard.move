module 0x8333a83762e26054a769eb74814713b102313fa453076e1ebff8c5085d28935b::szard {
    struct SZARD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SZARD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SZARD>(arg0, 6, b"SZARD", b"SUIZARD", b"Suizard, water hazard in ben10", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreids2lbzslys67r4ua3jlrlf66xzyfwqroxvmfao7xjca3py3gqj24")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SZARD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SZARD>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

