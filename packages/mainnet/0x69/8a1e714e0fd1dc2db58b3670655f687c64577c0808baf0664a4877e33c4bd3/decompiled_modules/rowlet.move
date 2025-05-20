module 0x698a1e714e0fd1dc2db58b3670655f687c64577c0808baf0664a4877e33c4bd3::rowlet {
    struct ROWLET has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROWLET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROWLET>(arg0, 6, b"ROWLET", b"Rowlet Sui", x"526f776c65747420697320612047726173732f466c79696e672d7479706520506f6bc3a96d6f6e2c20526561647920746f20636f6e717565722074686520537569207761746572732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreievppwox5jjjvklpdv722pxxirfxhvfhrtqvnq7ggd3gf22l2tjc4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROWLET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ROWLET>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

