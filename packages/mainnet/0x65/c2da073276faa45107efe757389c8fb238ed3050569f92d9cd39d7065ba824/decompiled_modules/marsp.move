module 0x65c2da073276faa45107efe757389c8fb238ed3050569f92d9cd39d7065ba824::marsp {
    struct MARSP has drop {
        dummy_field: bool,
    }

    fun init(arg0: MARSP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MARSP>(arg0, 6, b"MARSP", b"MARS PEOPLE", b"MARS PEOPLE join SUI World", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiem6b5t4m5qhvpwjfotfayy6z545ufqspyei5bexhsydjpobyivsm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MARSP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MARSP>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

