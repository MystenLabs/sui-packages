module 0xde5c870ba392a554e55d0a8337db08d094abf09066f61fe56756700545bab733::glrb {
    struct GLRB has drop {
        dummy_field: bool,
    }

    fun init(arg0: GLRB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GLRB>(arg0, 6, b"GLRB", b"GLORBO", b"I'm Samantha - and this is a transforming plastic creature GLORBO. The page in the link will be available soon.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeifrprbck4qpl2fglmplhtuumrwcx4mwc42reap2wnj7byi3io5n7m")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GLRB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GLRB>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

