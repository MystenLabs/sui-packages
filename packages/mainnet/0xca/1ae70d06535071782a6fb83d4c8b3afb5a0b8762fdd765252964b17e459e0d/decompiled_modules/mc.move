module 0xca1ae70d06535071782a6fb83d4c8b3afb5a0b8762fdd765252964b17e459e0d::mc {
    struct MC has drop {
        dummy_field: bool,
    }

    fun init(arg0: MC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MC>(arg0, 6, b"MC", b"Kobuko", b"Only u", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreid64cse7b3kerqtbbt5eagrltpvmdtvyywiv6wx67xlj2yw4damt4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MC>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

