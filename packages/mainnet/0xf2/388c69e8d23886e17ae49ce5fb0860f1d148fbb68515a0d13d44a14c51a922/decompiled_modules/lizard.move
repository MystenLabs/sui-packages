module 0xf2388c69e8d23886e17ae49ce5fb0860f1d148fbb68515a0d13d44a14c51a922::lizard {
    struct LIZARD has drop {
        dummy_field: bool,
    }

    fun init(arg0: LIZARD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LIZARD>(arg0, 6, b"LIZARD", b"SUI LIZARD", b"The New Meme Mascot of SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidqmmjflm7uaiz3gslxmak4h6oxdaxwpybeel45xeogofkv7rgxha")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LIZARD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LIZARD>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

