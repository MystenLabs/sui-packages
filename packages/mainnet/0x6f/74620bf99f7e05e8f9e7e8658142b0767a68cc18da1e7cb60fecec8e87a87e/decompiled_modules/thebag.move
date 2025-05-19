module 0x6f74620bf99f7e05e8f9e7e8658142b0767a68cc18da1e7cb60fecec8e87a87e::thebag {
    struct THEBAG has drop {
        dummy_field: bool,
    }

    fun init(arg0: THEBAG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<THEBAG>(arg0, 6, b"Thebag", b"The bag", b"Loads of bags", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicqq5pkia65ttv73sgv6x5un3slwfclugdkdeypogyuempuqsxr6q")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<THEBAG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<THEBAG>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

