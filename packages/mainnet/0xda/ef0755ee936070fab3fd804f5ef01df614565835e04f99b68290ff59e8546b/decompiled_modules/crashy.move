module 0xdaef0755ee936070fab3fd804f5ef01df614565835e04f99b68290ff59e8546b::crashy {
    struct CRASHY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRASHY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRASHY>(arg0, 6, b"Crashy", b"crashy on sui", b"A neon-cool, spiky-headed icon ruling the cyberpunk skyline with style and swagger", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiheibdcmgfqeiznppy7kuaczxjy5huiho52uzjebzk5srvip3zr2q")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRASHY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CRASHY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

