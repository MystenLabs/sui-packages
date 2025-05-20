module 0x14a74579ea50fb25201187873d1046f05fb59273d08b9405660700f9cad78695::rowlet {
    struct ROWLET has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROWLET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROWLET>(arg0, 6, b"ROWLET", b"Rowlet Sui", b"Rowlet on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreievppwox5jjjvklpdv722pxxirfxhvfhrtqvnq7ggd3gf22l2tjc4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROWLET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ROWLET>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

